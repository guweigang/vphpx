module cachex

import supportx
import configx as cfgx
import vphp

#include "php_bridge.h"

struct Psr6ItemSnapshot {
	key string
mut:
	value           vphp.PhpValue = vphp.PhpValue.invalid()
	has_value       bool
	expires_at_unix i64
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut pool VSlimPsr6CacheItemPool) construct() &VSlimPsr6CacheItemPool {
	pool.ensure()
	return &pool
}

pub fn VSlimPsr6CacheItemPool.from_clock_and_config(clock vphp.PhpObject, config &cfgx.VSlimConfig) &VSlimPsr6CacheItemPool {
	mut pool := &VSlimPsr6CacheItemPool{}
	pool.construct()
	pool.set_clock(clock)
	pool.configure_defaults(config)
	return pool
}

@[vphp.PhpExportMethod(name: 'setNamespace')]
pub fn (mut pool VSlimPsr6CacheItemPool) set_namespace(prefix string) &VSlimPsr6CacheItemPool {
	pool.namespace_prefix = psr_cache_normalize_namespace(prefix)
	return &pool
}

@[vphp.PhpExportMethod(name: 'namespace')]
pub fn (pool &VSlimPsr6CacheItemPool) namespace() string {
	return pool.namespace_prefix
}

@[vphp.PhpExportMethod(name: 'setDefaultTtlSeconds')]
pub fn (mut pool VSlimPsr6CacheItemPool) set_default_ttl_seconds(seconds int) &VSlimPsr6CacheItemPool {
	pool.default_ttl_seconds = if seconds <= 0 { 0 } else { seconds }
	return &pool
}

@[vphp.PhpExportMethod(name: 'defaultTtlSeconds')]
pub fn (pool &VSlimPsr6CacheItemPool) default_ttl_seconds_value() int {
	return if pool.default_ttl_seconds <= 0 { 0 } else { pool.default_ttl_seconds }
}

@[vphp.PhpArgType(v_name: 'clock', php_type: 'Psr\\Clock\\ClockInterface')]
@[vphp.PhpExportMethod(name: 'setClock')]
pub fn (mut pool VSlimPsr6CacheItemPool) set_clock(clock vphp.PhpObject) &VSlimPsr6CacheItemPool {
	pool.ensure()
	if !supportx.psr20_clock_is_valid(clock) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'clock must implement Psr\\Clock\\ClockInterface', 0)
		return &pool
	}
	mut old := pool.clock_ref
	old.release()
	pool.clock_ref = clock.retain()
	return &pool
}

@[vphp.PhpReturnType(php_type: 'Psr\\Clock\\ClockInterface')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut pool VSlimPsr6CacheItemPool) clock() vphp.PhpObject {
	pool.ensure()
	return pool.clock_ref.to_request_owned()
}

@[vphp.PhpReturnType(php_type: 'Psr\\Cache\\CacheItemInterface')]
@[vphp.PhpExportMethod(name: 'getItem')]
pub fn (mut pool VSlimPsr6CacheItemPool) get_item(key string) &VSlimPsr6CacheItem {
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr6_invalid_argument(err.msg())
		return VSlimPsr6CacheItem.missing_with_clock('', pool.clock_ref)
	}
	pool.ensure()
	return pool.item_for_key(normalized)
}

@[vphp.PhpArgType(v_name: 'keys', php_type: 'array')]
@[vphp.PhpReturnType(php_type: 'iterable')]
@[vphp.PhpExportMethod(name: 'getItems')]
@[vphp.PhpArgDefault(v_name: 'keys', default_value: '[]')]
pub fn (mut pool VSlimPsr6CacheItemPool) get_items(keys vphp.PhpValue) vphp.PhpArray {
	pool.ensure()
	mut out := vphp.PhpArray.new()
	if !keys.is_valid() || keys.is_null() || keys.is_undef() {
		return out
	}
	mut key_array := keys.as_array() or {
		throw_psr6_invalid_argument('keys must be an array of cache keys')
		return out
	}
	defer {
		key_array.release()
	}
	for key_name in psr6_key_list_from_array(key_array) or {
		msg := err.msg()
		throw_psr6_invalid_argument(msg)
		return out
	} {
		mut item_value := pool.item_for_key(key_name).to_value()
		out.set_value(key_name, item_value)
		item_value.release()
	}
	return out
}

@[vphp.PhpExportMethod(name: 'hasItem')]
pub fn (mut pool VSlimPsr6CacheItemPool) has_item(key string) bool {
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr6_invalid_argument(err.msg())
		return false
	}
	pool.ensure()
	storage_key := pool.storage_key(normalized)
	if storage_key in pool.deferred {
		entry := pool.deferred[storage_key] or { Psr6DeferredEntry{} }
		if psr6_deferred_entry_expired(pool.clock_ref, entry) || !entry.has_value {
			pool.remove_deferred_entry(storage_key)
			return false
		}
		return true
	}
	pool.prune_expired_entry(storage_key)
	return storage_key in pool.entries
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut pool VSlimPsr6CacheItemPool) clear() bool {
	pool.ensure()
	pool.clear_entries()
	pool.clear_deferred_entries()
	return true
}

@[vphp.PhpExportMethod(name: 'deleteItem')]
pub fn (mut pool VSlimPsr6CacheItemPool) delete_item(key string) bool {
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr6_invalid_argument(err.msg())
		return false
	}
	pool.ensure()
	storage_key := pool.storage_key(normalized)
	pool.remove_entry(storage_key)
	pool.remove_deferred_entry(storage_key)
	return true
}

@[vphp.PhpExportMethod(name: 'deleteItems')]
pub fn (mut pool VSlimPsr6CacheItemPool) delete_items(keys vphp.PhpArray) bool {
	pool.ensure()
	for key_name in psr6_key_list_from_array(keys) or {
		throw_psr6_invalid_argument(err.msg())
		return false
	} {
		storage_key := pool.storage_key(key_name)
		pool.remove_entry(storage_key)
		pool.remove_deferred_entry(storage_key)
	}
	return true
}

@[vphp.PhpArgType(v_name: 'item', php_type: 'Psr\\Cache\\CacheItemInterface')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut pool VSlimPsr6CacheItemPool) save(item vphp.PhpObject) bool {
	pool.ensure()
	snapshot := psr6_snapshot_from_item(item) or {
		throw_psr6_cache_exception(err.msg())
		return false
	}
	pool.remove_deferred_entry(snapshot.key)
	ok := pool.persist_snapshot(snapshot)
	mut owned := snapshot.value
	owned.release()
	return ok
}

@[vphp.PhpArgType(v_name: 'item', php_type: 'Psr\\Cache\\CacheItemInterface')]
@[vphp.PhpExportMethod(name: 'saveDeferred')]
pub fn (mut pool VSlimPsr6CacheItemPool) save_deferred(item vphp.PhpObject) bool {
	pool.ensure()
	snapshot := psr6_snapshot_from_item(item) or {
		throw_psr6_cache_exception(err.msg())
		return false
	}
	pool.replace_deferred_entry(pool.storage_key(snapshot.key), snapshot)
	mut owned := snapshot.value
	owned.release()
	return true
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut pool VSlimPsr6CacheItemPool) commit() bool {
	pool.ensure()
	keys := pool.deferred.keys()
	for key in keys {
		entry := pool.deferred[key] or { continue }
		original_key := if pool.namespace_prefix != ''
			&& key.starts_with(pool.namespace_prefix + ':') {
			key[pool.namespace_prefix.len + 1..]
		} else {
			key
		}
		snapshot := Psr6ItemSnapshot{
			key:             original_key
			value:           entry.value.clone()
			has_value:       entry.has_value
			expires_at_unix: entry.expires_at_unix
		}
		if !pool.persist_snapshot(snapshot) {
			mut owned := snapshot.value
			owned.release()
			return false
		}
		mut owned := snapshot.value
		owned.release()
	}
	pool.clear_deferred_entries()
	return true
}

@[vphp.PhpExportMethod(name: 'getKey')]
pub fn (item &VSlimPsr6CacheItem) get_key() string {
	return item.key
}

@[vphp.PhpExportMethod(name: '')]
pub fn (item &VSlimPsr6CacheItem) get() vphp.PhpValue {
	if !item.has_value {
		return vphp.PhpValue.null()
	}
	return item.value_ref.to_request_owned()
}

@[vphp.PhpExportMethod(name: 'isHit')]
pub fn (item &VSlimPsr6CacheItem) is_hit() bool {
	if !item.hit {
		return false
	}
	now_unix := supportx.psr20_clock_now_unix_or_throw(item.clock_ref) or { return false }
	if item.expires_at_unix > 0 && item.expires_at_unix <= now_unix {
		return false
	}
	return item.has_value
}

@[vphp.PhpReturnType(php_type: 'static')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut item VSlimPsr6CacheItem) set(value vphp.PhpValue) &VSlimPsr6CacheItem {
	item.replace_value(value)
	return &item
}

@[vphp.PhpArgType(v_name: 'expiration', php_type: '?DateTimeInterface')]
@[vphp.PhpExportMethod(name: 'expiresAt')]
@[vphp.PhpReturnType(php_type: 'static')]
pub fn (mut item VSlimPsr6CacheItem) expires_at(expiration vphp.PhpValue) &VSlimPsr6CacheItem {
	item.ensure_clock()
	item.expires_at_unix = psr6_resolve_absolute_expiration_or_throw(expiration) or {
		throw_psr6_invalid_argument(err.msg())
		return &item
	}
	return &item
}

@[vphp.PhpArgName(v_name: 'time_value', php_name: 'timeValue')]
@[vphp.PhpExportMethod(name: 'expiresAfter')]
@[vphp.PhpReturnType(php_type: 'static')]
pub fn (mut item VSlimPsr6CacheItem) expires_after(time_value vphp.PhpValue) &VSlimPsr6CacheItem {
	item.ensure_clock()
	item.expires_at_unix = psr6_resolve_relative_expiration_or_throw(item.clock_ref, time_value) or {
		throw_psr6_invalid_argument(err.msg())
		return &item
	}
	return &item
}

fn (mut pool VSlimPsr6CacheItemPool) ensure() {
	if pool.entries.len == 0 {
		pool.entries = map[string]PsrCacheEntry{}
	}
	if pool.deferred.len == 0 {
		pool.deferred = map[string]Psr6DeferredEntry{}
	}
	if !supportx.psr20_clock_is_valid(pool.clock_ref) {
		pool.clock_ref = supportx.new_psr20_system_clock_ref()
	}
	if pool.default_ttl_seconds < 0 {
		pool.default_ttl_seconds = 0
	}
}

fn (mut item VSlimPsr6CacheItem) ensure_clock() {
	if !supportx.psr20_clock_is_valid(item.clock_ref) {
		item.clock_ref = supportx.new_psr20_system_clock_ref()
	}
}

pub fn (mut pool VSlimPsr6CacheItemPool) item_for_key(key string) &VSlimPsr6CacheItem {
	storage_key := pool.storage_key(key)
	if storage_key in pool.deferred {
		entry := pool.deferred[storage_key] or { Psr6DeferredEntry{} }
		if psr6_deferred_entry_expired(pool.clock_ref, entry) || !entry.has_value {
			pool.remove_deferred_entry(storage_key)
			return VSlimPsr6CacheItem.missing_with_clock(key, pool.clock_ref)
		}
		return VSlimPsr6CacheItem.hit_with_clock(key, entry.value, entry.expires_at_unix,
			pool.clock_ref)
	}
	pool.prune_expired_entry(storage_key)
	entry := pool.entries[storage_key] or {
		return VSlimPsr6CacheItem.missing_with_clock(key, pool.clock_ref)
	}
	return VSlimPsr6CacheItem.hit_with_clock(key, entry.value, entry.expires_at_unix,
		pool.clock_ref)
}

pub fn (mut pool VSlimPsr6CacheItemPool) persist_snapshot(snapshot Psr6ItemSnapshot) bool {
	now_unix := supportx.psr20_clock_now_unix_or_throw(pool.clock_ref) or { return false }
	if !snapshot.has_value || snapshot.expires_at_unix < 0
		|| (snapshot.expires_at_unix > 0 && snapshot.expires_at_unix <= now_unix) {
		pool.remove_entry(pool.storage_key(snapshot.key))
		return true
	}
	expires_at := psr_cache_apply_default_ttl(pool.clock_ref, snapshot.expires_at_unix,
		pool.default_ttl_seconds)
	pool.replace_entry(pool.storage_key(snapshot.key), snapshot.value.clone(), expires_at)
	return true
}

pub fn (mut pool VSlimPsr6CacheItemPool) replace_entry(key string, value vphp.PhpValue, expires_at_unix i64) {
	if key in pool.entries {
		mut old := pool.entries[key] or { PsrCacheEntry{} }
		old.value.release()
	}
	pool.entries[key] = PsrCacheEntry{
		value:           value
		expires_at_unix: expires_at_unix
	}
}

pub fn (mut pool VSlimPsr6CacheItemPool) remove_entry(key string) {
	if key !in pool.entries {
		return
	}
	mut entry := pool.entries[key] or { return }
	entry.value.release()
	pool.entries.delete(key)
}

pub fn (mut pool VSlimPsr6CacheItemPool) clear_entries() {
	keys := pool.entries.keys()
	for key in keys {
		pool.remove_entry(key)
	}
}

pub fn (mut pool VSlimPsr6CacheItemPool) prune_expired_entry(key string) {
	if key !in pool.entries {
		return
	}
	entry := pool.entries[key] or { return }
	if !psr_cache_entry_expired(pool.clock_ref, entry) {
		return
	}
	pool.remove_entry(key)
}

pub fn (mut pool VSlimPsr6CacheItemPool) replace_deferred_entry(key string, snapshot Psr6ItemSnapshot) {
	if key in pool.deferred {
		mut old := pool.deferred[key] or { Psr6DeferredEntry{} }
		old.value.release()
	}
	pool.deferred[key] = Psr6DeferredEntry{
		value:           snapshot.value.clone()
		has_value:       snapshot.has_value
		expires_at_unix: snapshot.expires_at_unix
	}
}

fn (pool VSlimPsr6CacheItemPool) storage_key(key string) string {
	if pool.namespace_prefix == '' {
		return key
	}
	return '${pool.namespace_prefix}:${key}'
}

pub fn (mut pool VSlimPsr6CacheItemPool) remove_deferred_entry(key string) {
	if key !in pool.deferred {
		return
	}
	mut entry := pool.deferred[key] or { return }
	entry.value.release()
	pool.deferred.delete(key)
}

pub fn (mut pool VSlimPsr6CacheItemPool) clear_deferred_entries() {
	keys := pool.deferred.keys()
	for key in keys {
		pool.remove_deferred_entry(key)
	}
}

fn psr6_deferred_entry_expired(clock vphp.PhpObject, entry Psr6DeferredEntry) bool {
	now_unix := supportx.psr20_clock_now_unix_or_throw(clock) or { return false }
	return entry.expires_at_unix > 0 && entry.expires_at_unix <= now_unix
}

fn VSlimPsr6CacheItem.missing_with_clock(key string, clock_ref vphp.PhpObject) &VSlimPsr6CacheItem {
	return &VSlimPsr6CacheItem{
		key:       key
		value_ref: vphp.PhpValue.invalid()
		clock_ref: clock_ref.clone()
		hit:       false
		has_value: false
	}
}

fn VSlimPsr6CacheItem.hit_with_clock(key string, value vphp.PhpValue, expires_at_unix i64, clock_ref vphp.PhpObject) &VSlimPsr6CacheItem {
	return &VSlimPsr6CacheItem{
		key:             key
		value_ref:       value.clone()
		clock_ref:       clock_ref.clone()
		hit:             true
		has_value:       true
		expires_at_unix: expires_at_unix
	}
}

fn (item &VSlimPsr6CacheItem) to_value() vphp.PhpValue {
	unsafe {
		return vphp.bind_owned_object_value[VSlimPsr6CacheItem](item)
	}
}

fn psr6_snapshot_from_item(item vphp.PhpObject) !Psr6ItemSnapshot {
	if !item.is_valid() {
		return error('cache item must be an object')
	}
	mut own := item.to_v_object[VSlimPsr6CacheItem]() or {
		return error('save() expects VSlim\\Psr6\\CacheItem instances created by this pool')
	}
	key := psr_cache_validate_key_or_throw(own.key)!
	return Psr6ItemSnapshot{
		key:             key
		value:           own.value_ref.clone()
		has_value:       own.has_value
		expires_at_unix: own.expires_at_unix
	}
}

fn psr6_key_list_from_array(keys vphp.PhpArray) ![]string {
	mut values_value := vphp.PhpFunction.named('array_values').invoke(keys)
	defer {
		values_value.release()
	}
	mut values := values_value.as_array() or { return error('keys must be an array of cache keys') }
	defer {
		values.release()
	}
	mut out := []string{}
	for value in values.value_items() {
		key_name := psr6_value_to_key(value)!
		out << psr_cache_validate_key_or_throw(key_name)!
	}
	return out
}

fn psr6_value_to_key(value vphp.PhpValue) !string {
	if value.is_string() {
		return value.to_string()
	}
	return error('cache keys must be strings')
}

fn psr6_resolve_absolute_expiration_or_throw(expiration vphp.PhpValue) !i64 {
	if !expiration.is_valid() || expiration.is_null() || expiration.is_undef() {
		return 0
	}
	if expiration.is_object() && expiration.is_instance_of('DateTimeInterface') {
		mut obj := expiration.as_object() or {
			return error('expiration must be null or DateTimeInterface')
		}
		defer {
			obj.release()
		}
		return obj.with_method_result[vphp.PhpInt, i64]('getTimestamp', fn (ts vphp.PhpInt) i64 {
			return ts.value()
		})!
	}
	return error('expiration must be null or DateTimeInterface')
}

fn psr6_resolve_relative_expiration_or_throw(clock vphp.PhpObject, time_value vphp.PhpValue) !i64 {
	if !time_value.is_valid() || time_value.is_null() || time_value.is_undef() {
		return 0
	}
	now_unix := supportx.psr20_clock_now_unix_or_throw(clock)!
	if time_value.is_long() {
		seconds := time_value.to_i64()
		if seconds <= 0 {
			return i64(-1)
		}
		return now_unix + seconds
	}
	if time_value.is_object() && time_value.is_instance_of('DateInterval') {
		mut now_dt := supportx.psr20_clock_now_datetime_or_throw(clock) or {
			return error('failed to resolve clock time for expiration resolution')
		}
		defer {
			now_dt.release()
		}
		expires_at := now_dt.with_method_result[vphp.PhpObject, i64]('add', fn (added vphp.PhpObject) i64 {
			if !added.is_valid() {
				return i64(-1)
			}
			return added.with_method_result[vphp.PhpInt, i64]('getTimestamp', fn (ts vphp.PhpInt) i64 {
				return ts.value()
			}) or { i64(-1) }
		}, time_value) or { i64(-1) }
		if expires_at < 0 {
			return error('failed to apply DateInterval expiration')
		}
		return expires_at
	}
	return error('time must be null, an integer, or DateInterval')
}

pub fn (mut item VSlimPsr6CacheItem) replace_value(value vphp.PhpValue) {
	mut old := item.value_ref
	old.release()
	item.value_ref = value.retain()
	item.has_value = true
}

fn throw_psr6_invalid_argument(message string) {
	vphp.PhpException.raise_class('VSlim\\Psr6\\InvalidArgumentException', message, 0)
}

fn throw_psr6_cache_exception(message string) {
	vphp.PhpException.raise_class('VSlim\\Psr6\\CacheException', message, 0)
}

pub fn (item &VSlimPsr6CacheItem) free() {
	unsafe {
		mut writable := &VSlimPsr6CacheItem(item)
		writable.value_ref.release()
		writable.clock_ref.release()
	}
}

pub fn (pool &VSlimPsr6CacheItemPool) free() {
	unsafe {
		mut writable := &VSlimPsr6CacheItemPool(pool)
		writable.clear_entries()
		writable.clear_deferred_entries()
		writable.clock_ref.release()
		writable.entries.free()
		writable.deferred.free()
	}
}

pub fn (mut pool VSlimPsr6CacheItemPool) configure_defaults(config &cfgx.VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('cache.pool.prefix') {
		pool.set_namespace(config.get_string('cache.pool.prefix', pool.namespace()))
	} else if config.has('cache.prefix') {
		pool.set_namespace(config.get_string('cache.prefix', pool.namespace()))
	}
	if config.has('cache.pool.default_ttl_seconds') {
		pool.set_default_ttl_seconds(config.get_int('cache.pool.default_ttl_seconds',
			pool.default_ttl_seconds_value()))
	} else if config.has('cache.default_ttl_seconds') {
		pool.set_default_ttl_seconds(config.get_int('cache.default_ttl_seconds',
			pool.default_ttl_seconds_value()))
	}
}
