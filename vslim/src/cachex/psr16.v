module cachex

import supportx
import configx as cfgx
import vphp

const psr_cache_reserved_key_chars = ['{', '}', '(', ')', '/', '\\', '@', ':']

@[vphp.PhpExportMethod(name: '')]
pub fn (mut cache VSlimPsr16Cache) construct() &VSlimPsr16Cache {
	cache.ensure()
	return &cache
}

pub fn VSlimPsr16Cache.from_clock_and_config(clock vphp.PhpObject, config &cfgx.VSlimConfig) &VSlimPsr16Cache {
	mut cache := &VSlimPsr16Cache{}
	cache.construct()
	cache.set_clock(clock)
	cache.configure_defaults(config)
	return cache
}

@[vphp.PhpExportMethod(name: 'setNamespace')]
pub fn (mut cache VSlimPsr16Cache) set_namespace(prefix string) &VSlimPsr16Cache {
	cache.namespace_prefix = psr_cache_normalize_namespace(prefix)
	return &cache
}

@[vphp.PhpExportMethod(name: 'namespace')]
pub fn (cache &VSlimPsr16Cache) namespace() string {
	return cache.namespace_prefix
}

@[vphp.PhpExportMethod(name: 'setDefaultTtlSeconds')]
pub fn (mut cache VSlimPsr16Cache) set_default_ttl_seconds(seconds int) &VSlimPsr16Cache {
	cache.default_ttl_seconds = if seconds <= 0 { 0 } else { seconds }
	return &cache
}

@[vphp.PhpExportMethod(name: 'defaultTtlSeconds')]
pub fn (cache &VSlimPsr16Cache) default_ttl_seconds_value() int {
	return if cache.default_ttl_seconds <= 0 { 0 } else { cache.default_ttl_seconds }
}

@[vphp.PhpExportMethod(name: 'setClock')]
pub fn (mut cache VSlimPsr16Cache) export_set_clock(clock supportx.PsrClock) &VSlimPsr16Cache {
	return cache.set_clock(clock.to_object())
}

pub fn (mut cache VSlimPsr16Cache) set_clock(clock vphp.PhpObject) &VSlimPsr16Cache {
	cache.ensure()
	if !supportx.psr20_clock_is_valid(clock) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'clock must implement Psr\\Clock\\ClockInterface', 0)
		return &cache
	}
	mut old := cache.clock_ref
	cache.clock_ref = clock.retain()
	old.release()
	return &cache
}

@[vphp.PhpReturnType(php_type: 'Psr\\Clock\\ClockInterface')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut cache VSlimPsr16Cache) clock() vphp.PhpObject {
	cache.ensure()
	return cache.clock_ref.to_request_owned()
}

fn psr16_default_value_or_null(default_value ?vphp.PhpValue) vphp.PhpValue {
	if actual_default := default_value {
		return actual_default.to_request_owned()
	}
	return vphp.PhpValue.null()
}

fn psr16_ttl_value_or_null(ttl ?vphp.PhpValue) vphp.PhpValue {
	if actual_ttl := ttl {
		return actual_ttl.to_request_owned()
	}
	return vphp.PhpValue.null()
}

@[vphp.PhpArgName(v_name: 'default_value', php_name: 'defaultValue')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut cache VSlimPsr16Cache) get(key string, default_value ?vphp.PhpValue) vphp.PhpValue {
	cache.ensure()
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return psr16_default_value_or_null(default_value)
	}
	storage_key := cache.storage_key(normalized)
	cache.prune_expired_entry(storage_key)
	entry := cache.entries[storage_key] or { return psr16_default_value_or_null(default_value) }
	return psr_cache_snapshot_value(entry.value)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut cache VSlimPsr16Cache) set(key string, value vphp.PhpValue, ttl ?vphp.PhpValue) bool {
	cache.ensure()
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	expires_at := psr_cache_resolve_relative_ttl_or_throw(cache.clock_ref,
		psr16_ttl_value_or_null(ttl)) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	if expires_at < 0 {
		return cache.delete(normalized)
	}
	cache.replace_entry(cache.storage_key(normalized), psr_cache_retain_value(value), psr_cache_apply_default_ttl(cache.clock_ref,
		expires_at, cache.default_ttl_seconds))
	return true
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut cache VSlimPsr16Cache) delete(key string) bool {
	cache.ensure()
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	cache.remove_entry(cache.storage_key(normalized))
	return true
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut cache VSlimPsr16Cache) clear() bool {
	cache.ensure()
	cache.clear_entries()
	return true
}

@[vphp.PhpArgName(v_name: 'default_value', php_name: 'defaultValue')]
@[vphp.PhpExportMethod(name: 'getMultiple')]
@[vphp.PhpReturnType(php_type: 'iterable')]
pub fn (mut cache VSlimPsr16Cache) get_multiple(keys vphp.PhpIterable, default_value ?vphp.PhpValue) vphp.PhpArray {
	cache.ensure()
	mut out := vphp.PhpArray.new()
	for key_name in psr16_iterable_key_list(keys) or {
		msg := err.msg()
		throw_psr16_invalid_argument(msg)
		return out
	} {
		mut value := cache.get(key_name, default_value)
		out.set_value(key_name, value)
		value.release()
	}
	return out
}

@[vphp.PhpExportMethod(name: 'setMultiple')]
pub fn (mut cache VSlimPsr16Cache) set_multiple(values vphp.PhpIterable, ttl ?vphp.PhpValue) bool {
	cache.ensure()
	expires_at := psr_cache_resolve_relative_ttl_or_throw(cache.clock_ref,
		psr16_ttl_value_or_null(ttl)) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	mut normalized := values.to_array() or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	defer {
		normalized.release()
	}
	mut keys := normalized.key_array()
	defer {
		keys.release()
	}
	mut entries := map[string]vphp.PhpValue{}
	for key in keys.items() {
		name := psr_cache_validate_key_or_throw(key.to_string()) or {
			throw_psr16_invalid_argument(err.msg())
			return false
		}
		value := normalized.get_key(key) or {
			throw_psr16_invalid_argument(err.msg())
			return false
		}
		entries[name] = vphp.PhpValue.from_zval(value)
	}
	if expires_at < 0 {
		for key, _ in entries {
			cache.remove_entry(cache.storage_key(key))
		}
		return true
	}
	for key, value in entries {
		cache.replace_entry(cache.storage_key(key), psr_cache_retain_value(value), psr_cache_apply_default_ttl(cache.clock_ref,
			expires_at, cache.default_ttl_seconds))
	}
	return true
}

@[vphp.PhpExportMethod(name: 'deleteMultiple')]
pub fn (mut cache VSlimPsr16Cache) delete_multiple(keys vphp.PhpIterable) bool {
	cache.ensure()
	for key_name in psr16_iterable_key_list(keys) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	} {
		cache.remove_entry(cache.storage_key(key_name))
	}
	return true
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut cache VSlimPsr16Cache) has(key string) bool {
	cache.ensure()
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	storage_key := cache.storage_key(normalized)
	cache.prune_expired_entry(storage_key)
	return storage_key in cache.entries
}

fn (mut cache VSlimPsr16Cache) ensure() {
	if cache.entries.len == 0 {
		cache.entries = map[string]PsrCacheEntry{}
	}
	if !supportx.psr20_clock_is_valid(cache.clock_ref) {
		cache.clock_ref = supportx.new_psr20_system_clock_ref()
	}
	if cache.default_ttl_seconds < 0 {
		cache.default_ttl_seconds = 0
	}
}

pub fn (mut cache VSlimPsr16Cache) replace_entry(key string, value vphp.PhpValue, expires_at_unix i64) {
	cache.construct()
	if key in cache.entries {
		mut old := cache.entries[key] or { PsrCacheEntry{} }
		old.value.release()
	}
	cache.entries[key] = PsrCacheEntry{
		value:           value
		expires_at_unix: expires_at_unix
	}
}

pub fn (mut cache VSlimPsr16Cache) remove_entry(key string) {
	if key !in cache.entries {
		return
	}
	mut entry := cache.entries[key] or { return }
	entry.value.release()
	cache.entries.delete(key)
}

pub fn (mut cache VSlimPsr16Cache) clear_entries() {
	keys := cache.entries.keys()
	for key in keys {
		cache.remove_entry(key)
	}
}

pub fn (mut cache VSlimPsr16Cache) prune_expired_entry(key string) {
	if key !in cache.entries {
		return
	}
	entry := cache.entries[key] or { return }
	if !psr_cache_entry_expired(cache.clock_ref, entry) {
		return
	}
	cache.remove_entry(key)
}

fn psr_cache_entry_expired(clock vphp.PhpObject, entry PsrCacheEntry) bool {
	now_unix := supportx.psr20_clock_now_unix_or_throw(clock) or { return false }
	return entry.expires_at_unix > 0 && entry.expires_at_unix <= now_unix
}

fn psr_cache_validate_key_or_throw(key string) !string {
	if key == '' {
		return error('cache key must be a non-empty string')
	}
	for ch in psr_cache_reserved_key_chars {
		if key.contains(ch) {
			return error('cache key contains reserved character `${ch}`')
		}
	}
	return key
}

fn psr_cache_normalize_namespace(prefix string) string {
	return prefix.trim_space()
}

fn (cache VSlimPsr16Cache) storage_key(key string) string {
	if cache.namespace_prefix == '' {
		return key
	}
	return '${cache.namespace_prefix}:${key}'
}

fn psr_cache_apply_default_ttl(clock vphp.PhpObject, expires_at i64, default_ttl_seconds int) i64 {
	if expires_at != 0 || default_ttl_seconds <= 0 {
		return expires_at
	}
	now_unix := supportx.psr20_clock_now_unix_or_throw(clock) or { return expires_at }
	return now_unix + i64(default_ttl_seconds)
}

fn psr_cache_resolve_relative_ttl_or_throw(clock vphp.PhpObject, ttl vphp.PhpValue) !i64 {
	if !ttl.is_valid() || ttl.is_null() || ttl.is_undef() {
		return 0
	}
	if ttl.is_long() {
		seconds := ttl.to_i64()
		if seconds <= 0 {
			return i64(-1)
		}
		return supportx.psr20_clock_now_unix_or_throw(clock)! + seconds
	}
	if ttl.is_double() {
		seconds := i64(ttl.to_f64())
		if seconds <= 0 {
			return i64(-1)
		}
		return supportx.psr20_clock_now_unix_or_throw(clock)! + seconds
	}
	if mut interval := ttl.as_date_interval() {
		defer {
			interval.release()
		}
		now_unix, expires_at := psr_cache_interval_expiration(clock, interval)!
		if expires_at <= now_unix {
			return i64(-1)
		}
		return expires_at
	}
	return error('ttl must be null, an integer, or DateInterval')
}

fn psr_cache_interval_expiration(clock vphp.PhpObject, interval vphp.PhpDateInterval) !(i64, i64) {
	mut date := supportx.psr20_clock_now_datetime_or_throw(clock)!
	defer {
		date.release()
	}
	now_unix := date.unix_seconds()!
	mut expiration := date.add(interval.borrowed_view())!
	defer {
		expiration.release()
	}
	return now_unix, expiration.unix_seconds()!
}

fn psr16_iterable_key_list(value vphp.PhpIterable) ![]string {
	mut normalized := value.to_list()!
	defer {
		normalized.release()
	}
	mut out := []string{}
	for item in normalized.value_items() {
		key_name := psr16_value_to_key(item)!
		out << psr_cache_validate_key_or_throw(key_name)!
	}
	return out
}

fn psr16_value_to_key(value vphp.PhpValue) !string {
	if value.is_string() || value.is_long() {
		return value.to_string()
	}
	return error('cache keys must be strings')
}

fn throw_psr16_invalid_argument(message string) {
	if !vphp.has_exception() {
		vphp.PhpException.raise_class('VSlim\\Psr16\\InvalidArgumentException', message, 0)
	}
}

pub fn (cache &VSlimPsr16Cache) free() {
	unsafe {
		mut writable := &VSlimPsr16Cache(cache)
		writable.clear_entries()
		writable.clock_ref.release()
		writable.entries.free()
	}
}

pub fn (mut cache VSlimPsr16Cache) configure_defaults(config &cfgx.VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('cache.prefix') {
		cache.set_namespace(config.get_string('cache.prefix', cache.namespace()))
	}
	if config.has('cache.default_ttl_seconds') {
		cache.set_default_ttl_seconds(config.get_int('cache.default_ttl_seconds',
			cache.default_ttl_seconds_value()))
	}
}
