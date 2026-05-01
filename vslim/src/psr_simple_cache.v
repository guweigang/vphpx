module main

import vphp

fn psr16_owned_value(z vphp.ZVal) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.of(z)
}

const psr_cache_reserved_key_chars = ['{', '}', '(', ')', '/', '\\', '@', ':']

@[php_method]
pub fn (mut cache VSlimPsr16Cache) construct() &VSlimPsr16Cache {
	ensure_psr16_cache(mut cache)
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
pub fn (mut cache VSlimPsr16Cache) set_clock(clock vphp.RequestBorrowedZBox) &VSlimPsr16Cache {
	ensure_psr16_cache(mut cache)
	if !psr20_is_clock(clock.to_zval()) {
		vphp.PhpException.raise_class('InvalidArgumentException', 'clock must implement Psr\\Clock\\ClockInterface',
			0)
		return &cache
	}
	mut old := cache.clock_ref
	old.release()
	cache.clock_ref = vphp.PersistentOwnedZBox.from_object_zval(clock.to_zval())
	return &cache
}

@[php_return_type: 'Psr\\Clock\\ClockInterface']
@[php_method]
pub fn (mut cache VSlimPsr16Cache) clock() vphp.RequestOwnedZBox {
	ensure_psr16_cache(mut cache)
	return cache.clock_ref.clone_request_owned()
}

fn psr16_default_value_or_null(default_value ?vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if actual_default := default_value {
		return actual_default.clone_request_owned()
	}
	return vphp.RequestOwnedZBox.new_null()
}

fn psr16_ttl_zval_or_null(ttl ?vphp.RequestBorrowedZBox) vphp.ZVal {
	if actual_ttl := ttl {
		return actual_ttl.to_zval()
	}
	return vphp.ZVal.new_null()
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method]
pub fn (mut cache VSlimPsr16Cache) get(key string, default_value ?vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	ensure_psr16_cache(mut cache)
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return psr16_default_value_or_null(default_value)
	}
	storage_key := psr16_storage_key(cache, normalized)
	cache.prune_expired_entry(storage_key)
	entry := cache.entries[storage_key] or { return psr16_default_value_or_null(default_value) }
	return entry.value.clone_request_owned()
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) set(key string, value vphp.RequestBorrowedZBox, ttl ?vphp.RequestBorrowedZBox) bool {
	ensure_psr16_cache(mut cache)
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	expires_at := psr_cache_resolve_relative_ttl_or_throw(cache.clock_ref.to_zval(), psr16_ttl_zval_or_null(ttl)) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	if expires_at < 0 {
		return cache.delete(normalized)
	}
	cache.replace_entry(psr16_storage_key(cache, normalized), vphp.PersistentOwnedZBox.from_mixed_zval(value.to_zval()),
		psr_cache_apply_default_ttl(cache.clock_ref.to_zval(), expires_at, cache.default_ttl_seconds))
	return true
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) delete(key string) bool {
	ensure_psr16_cache(mut cache)
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	cache.remove_entry(psr16_storage_key(cache, normalized))
	return true
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) clear() bool {
	ensure_psr16_cache(mut cache)
	cache.clear_entries()
	return true
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method: 'getMultiple']
@[php_return_type: 'iterable']
pub fn (mut cache VSlimPsr16Cache) get_multiple(keys vphp.PhpIterable, default_value ?vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	ensure_psr16_cache(mut cache)
	mut out := new_array()
	if !psr16_is_iterable(keys.to_zval()) {
		throw_psr16_invalid_argument('keys must be iterable')
		return vphp.RequestOwnedZBox.adopt_zval(out.take_zval())
	}
	for key_name in psr16_iterable_key_list(keys.to_zval()) or {
		msg := err.msg()
		throw_psr16_invalid_argument(msg)
		return vphp.RequestOwnedZBox.adopt_zval(out.take_zval())
	} {
		value := cache.get(key_name, default_value)
		out.set_zval(key_name, value.to_zval())
	}
	return vphp.RequestOwnedZBox.adopt_zval(out.take_zval())
}

@[php_method: 'setMultiple']
pub fn (mut cache VSlimPsr16Cache) set_multiple(values vphp.PhpIterable, ttl ?vphp.RequestBorrowedZBox) bool {
	ensure_psr16_cache(mut cache)
	if !psr16_is_iterable(values.to_zval()) {
		throw_psr16_invalid_argument('values must be iterable')
		return false
	}
	expires_at := psr_cache_resolve_relative_ttl_or_throw(cache.clock_ref.to_zval(), psr16_ttl_zval_or_null(ttl)) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	if expires_at < 0 {
		for key_name in psr16_iterable_assoc_key_list(values.to_zval()) or {
			throw_psr16_invalid_argument(err.msg())
			return false
		} {
			cache.remove_entry(psr16_storage_key(cache, key_name))
		}
		return true
	}
	for key_name, value in psr16_iterable_assoc_pairs(values.to_zval()) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	} {
		cache.replace_entry(psr16_storage_key(cache, key_name), value, psr_cache_apply_default_ttl(cache.clock_ref.to_zval(),
			expires_at, cache.default_ttl_seconds))
	}
	return true
}

@[php_method: 'deleteMultiple']
pub fn (mut cache VSlimPsr16Cache) delete_multiple(keys vphp.PhpIterable) bool {
	ensure_psr16_cache(mut cache)
	if !psr16_is_iterable(keys.to_zval()) {
		throw_psr16_invalid_argument('keys must be iterable')
		return false
	}
	for key_name in psr16_iterable_key_list(keys.to_zval()) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	} {
		cache.remove_entry(psr16_storage_key(cache, key_name))
	}
	return true
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) has(key string) bool {
	ensure_psr16_cache(mut cache)
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	storage_key := psr16_storage_key(cache, normalized)
	cache.prune_expired_entry(storage_key)
	return storage_key in cache.entries
}

fn ensure_psr16_cache(mut cache VSlimPsr16Cache) {
	if cache.entries.len == 0 {
		cache.entries = map[string]PsrCacheEntry{}
	}
	if !cache.clock_ref.is_valid() || cache.clock_ref.is_null() || cache.clock_ref.is_undef() {
		cache.clock_ref = new_psr20_system_clock_ref()
	}
	if cache.default_ttl_seconds < 0 {
		cache.default_ttl_seconds = 0
	}
}

pub fn (mut cache VSlimPsr16Cache) replace_entry(key string, value vphp.PersistentOwnedZBox, expires_at_unix i64) {
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
	if !psr_cache_entry_expired(cache.clock_ref.to_zval(), entry) {
		return
	}
	cache.remove_entry(key)
}

fn psr_cache_entry_expired(clock vphp.ZVal, entry PsrCacheEntry) bool {
	now_unix := psr20_now_unix_or_throw(clock) or { return false }
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

fn psr16_storage_key(cache VSlimPsr16Cache, key string) string {
	if cache.namespace_prefix == '' {
		return key
	}
	return '${cache.namespace_prefix}:${key}'
}

fn psr_cache_apply_default_ttl(clock vphp.ZVal, expires_at i64, default_ttl_seconds int) i64 {
	if expires_at != 0 || default_ttl_seconds <= 0 {
		return expires_at
	}
	now_unix := psr20_now_unix_or_throw(clock) or { return expires_at }
	return now_unix + i64(default_ttl_seconds)
}

fn psr_cache_resolve_relative_ttl_or_throw(clock vphp.ZVal, ttl vphp.ZVal) !i64 {
	if !ttl.is_valid() || ttl.is_null() || ttl.is_undef() {
		return 0
	}
	now_unix := psr20_now_unix_or_throw(clock)!
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
		now_dt := psr20_now_datetime_or_throw(clock) or {
			return error('failed to resolve clock time for TTL resolution')
		}
		expires_at := vphp.PhpObject.borrowed(now_dt).with_method_result[vphp.PhpObject, i64]('add',
			fn (added vphp.PhpObject) i64 {
			if !added.is_valid() {
				return i64(-1)
			}
			return added.with_method_result[vphp.PhpInt, i64]('getTimestamp', fn (ts vphp.PhpInt) i64 {
				return ts.value()
			}) or { i64(-1) }
		}, vphp.PhpValue.from_zval(ttl)) or { i64(-1) }
		if expires_at <= now_unix {
			return i64(-1)
		}
		return expires_at
	}
	return error('ttl must be null, an integer, or DateInterval')
}

fn psr16_is_iterable(value vphp.ZVal) bool {
	return value.is_array() || (value.is_object() && value.is_instance_of('Traversable'))
}

fn psr16_iterable_key_list(value vphp.ZVal) ![]string {
	normalized := psr16_iterable_to_array(value)!
	values := normalized.values()
	mut out := []string{}
	for idx := 0; idx < values.array_count(); idx++ {
		key_name := psr16_zval_to_key(values.array_get(idx))!
		out << psr_cache_validate_key_or_throw(key_name)!
	}
	return out
}

fn psr16_iterable_assoc_pairs(value vphp.ZVal) !map[string]vphp.PersistentOwnedZBox {
	normalized := psr16_iterable_to_array(value)!
	keys := normalized.keys()
	values := normalized.values()
	mut out := map[string]vphp.PersistentOwnedZBox{}
	for idx := 0; idx < keys.array_count(); idx++ {
		key_name := psr16_zval_to_key(keys.array_get(idx)) or {
			psr16_release_pairs(mut out)
			return error(err.msg())
		}
		safe_key := psr_cache_validate_key_or_throw(key_name) or {
			psr16_release_pairs(mut out)
			return error(err.msg())
		}
		out[safe_key] = vphp.PersistentOwnedZBox.from_mixed_zval(values.array_get(idx))
	}
	return out
}

fn psr16_iterable_assoc_key_list(value vphp.ZVal) ![]string {
	normalized := psr16_iterable_to_array(value)!
	keys := normalized.keys()
	mut out := []string{}
	for idx := 0; idx < keys.array_count(); idx++ {
		key_name := psr16_zval_to_key(keys.array_get(idx))!
		out << psr_cache_validate_key_or_throw(key_name)!
	}
	return out
}

fn psr16_iterable_to_array(value vphp.ZVal) !vphp.ZVal {
	if value.is_array() {
		return value
	}
	if value.is_object() && value.is_instance_of('Traversable') {
		mut preserve_keys_arg := vphp.PhpBool.of(true)
		defer {
			preserve_keys_arg.release()
		}
		mut normalized_box := vphp.PhpFunction.named('iterator_to_array').request_owned(vphp.PhpValue.from_zval(value),
			preserve_keys_arg)
		mut normalized := normalized_box.take_zval()
		if normalized.is_array() {
			return normalized
		}
		normalized.release()
	}
	return error('value must be iterable')
}

fn psr16_release_pairs(mut pairs map[string]vphp.PersistentOwnedZBox) {
	for _, persistent in pairs {
		mut owned := persistent
		owned.release()
	}
}

fn psr16_zval_to_key(value vphp.ZVal) !string {
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
