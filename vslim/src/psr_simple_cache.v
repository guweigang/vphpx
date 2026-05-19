module main

import vphp

const psr_cache_reserved_key_chars = ['{', '}', '(', ')', '/', '\\', '@', ':']

@[php_method]
pub fn (mut cache VSlimPsr16Cache) construct() &VSlimPsr16Cache {
	cache.ensure()
	return &cache
}

@[php_method: 'setNamespace']
pub fn (mut cache VSlimPsr16Cache) set_namespace(prefix string) &VSlimPsr16Cache {
	cache.namespace_prefix = psr_cache_normalize_namespace(prefix)
	return &cache
}

@[php_method: 'namespace']
pub fn (cache &VSlimPsr16Cache) namespace() string {
	return cache.namespace_prefix
}

@[php_method: 'setDefaultTtlSeconds']
pub fn (mut cache VSlimPsr16Cache) set_default_ttl_seconds(seconds int) &VSlimPsr16Cache {
	cache.default_ttl_seconds = if seconds <= 0 { 0 } else { seconds }
	return &cache
}

@[php_method: 'defaultTtlSeconds']
pub fn (cache &VSlimPsr16Cache) default_ttl_seconds_value() int {
	return if cache.default_ttl_seconds <= 0 { 0 } else { cache.default_ttl_seconds }
}

@[php_arg_type: 'clock=Psr\\Clock\\ClockInterface']
@[php_method: 'setClock']
pub fn (mut cache VSlimPsr16Cache) set_clock(clock vphp.PhpObject) &VSlimPsr16Cache {
	cache.ensure()
	if !psr20_clock_is_valid(clock) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'clock must implement Psr\\Clock\\ClockInterface', 0)
		return &cache
	}
	mut old := cache.clock_ref
	old.release()
	cache.clock_ref = clock.retain()
	return &cache
}

@[php_return_type: 'Psr\\Clock\\ClockInterface']
@[php_method]
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

@[php_arg_name: 'default_value=defaultValue']
@[php_method]
pub fn (mut cache VSlimPsr16Cache) get(key string, default_value ?vphp.PhpValue) vphp.PhpValue {
	cache.ensure()
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return psr16_default_value_or_null(default_value)
	}
	storage_key := cache.storage_key(normalized)
	cache.prune_expired_entry(storage_key)
	entry := cache.entries[storage_key] or { return psr16_default_value_or_null(default_value) }
	return entry.value.to_request_owned()
}

@[php_method]
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
	cache.replace_entry(cache.storage_key(normalized), value.retain(), psr_cache_apply_default_ttl(cache.clock_ref,
		expires_at, cache.default_ttl_seconds))
	return true
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) delete(key string) bool {
	cache.ensure()
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	cache.remove_entry(cache.storage_key(normalized))
	return true
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) clear() bool {
	cache.ensure()
	cache.clear_entries()
	return true
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method: 'getMultiple']
@[php_return_type: 'iterable']
pub fn (mut cache VSlimPsr16Cache) get_multiple(keys vphp.PhpIterable, default_value ?vphp.PhpValue) vphp.PhpArray {
	cache.ensure()
	mut out := vphp.PhpArray.new()
	for key_name in psr16_iterable_key_list(keys) or {
		msg := err.msg()
		throw_psr16_invalid_argument(msg)
		return out
	} {
		value := cache.get(key_name, default_value)
		out.set(key_name, value)
	}
	return out
}

@[php_method: 'setMultiple']
pub fn (mut cache VSlimPsr16Cache) set_multiple(values vphp.PhpIterable, ttl ?vphp.PhpValue) bool {
	cache.ensure()
	expires_at := psr_cache_resolve_relative_ttl_or_throw(cache.clock_ref,
		psr16_ttl_value_or_null(ttl)) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	if expires_at < 0 {
		for key_name in psr16_iterable_assoc_key_list(values) or {
			throw_psr16_invalid_argument(err.msg())
			return false
		} {
			cache.remove_entry(cache.storage_key(key_name))
		}
		return true
	}
	for key_name, value in psr16_iterable_assoc_pairs(values) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	} {
		cache.replace_entry(cache.storage_key(key_name), value, psr_cache_apply_default_ttl(cache.clock_ref,
			expires_at, cache.default_ttl_seconds))
	}
	return true
}

@[php_method: 'deleteMultiple']
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

@[php_method]
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
	if !psr20_clock_is_valid(cache.clock_ref) {
		cache.clock_ref = new_psr20_system_clock_ref()
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
	now_unix := psr20_clock_now_unix_or_throw(clock) or { return false }
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
	now_unix := psr20_clock_now_unix_or_throw(clock) or { return expires_at }
	return now_unix + i64(default_ttl_seconds)
}

fn psr_cache_resolve_relative_ttl_or_throw(clock vphp.PhpObject, ttl vphp.PhpValue) !i64 {
	if !ttl.is_valid() || ttl.is_null() || ttl.is_undef() {
		return 0
	}
	now_unix := psr20_clock_now_unix_or_throw(clock)!
	if ttl.is_long() {
		seconds := ttl.to_i64()
		if seconds <= 0 {
			return i64(-1)
		}
		return now_unix + seconds
	}
	if ttl.is_double() {
		seconds := i64(ttl.to_f64())
		if seconds <= 0 {
			return i64(-1)
		}
		return now_unix + seconds
	}
	if ttl.is_object() && ttl.is_instance_of('DateInterval') {
		mut now_dt := psr20_clock_now_datetime_or_throw(clock) or {
			return error('failed to resolve clock time for TTL resolution')
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
		}, ttl) or { i64(-1) }
		if expires_at <= now_unix {
			return i64(-1)
		}
		return expires_at
	}
	return error('ttl must be null, an integer, or DateInterval')
}

fn psr16_iterable_key_list(value vphp.PhpIterable) ![]string {
	mut normalized := value.to_array()!
	defer {
		normalized.release()
	}
	mut values := normalized.value_array()
	defer {
		values.release()
	}
	mut out := []string{}
	for item in values.value_items() {
		key_name := psr16_value_to_key(item)!
		out << psr_cache_validate_key_or_throw(key_name)!
	}
	return out
}

fn psr16_iterable_assoc_pairs(value vphp.PhpIterable) !map[string]vphp.PhpValue {
	mut normalized := value.to_array()!
	defer {
		normalized.release()
	}
	mut out := map[string]vphp.PhpValue{}
	for key in normalized.assoc_keys() {
		safe_key := psr_cache_validate_key_or_throw(key) or {
			psr16_release_pairs(mut out)
			return error(err.msg())
		}
		out[safe_key] = normalized.value_at(key).retain()
	}
	return out
}

fn psr16_iterable_assoc_key_list(value vphp.PhpIterable) ![]string {
	mut normalized := value.to_array()!
	defer {
		normalized.release()
	}
	mut out := []string{}
	for key in normalized.assoc_keys() {
		out << psr_cache_validate_key_or_throw(key)!
	}
	return out
}

fn psr16_release_pairs(mut pairs map[string]vphp.PhpValue) {
	for _, persistent in pairs {
		mut owned := persistent
		owned.release()
	}
}

fn psr16_value_to_key(value vphp.PhpValue) !string {
	if value.is_string() || value.is_long() {
		return value.to_string()
	}
	return error('cache keys must be strings')
}

fn throw_psr16_invalid_argument(message string) {
	vphp.PhpException.raise_class('VSlim\\Psr16\\InvalidArgumentException', message, 0)
}

pub fn (cache &VSlimPsr16Cache) free() {
	unsafe {
		mut writable := &VSlimPsr16Cache(cache)
		writable.clear_entries()
		writable.clock_ref.release()
		writable.entries.free()
	}
}
