module main

import vphp

fn psr16_owned_value(z vphp.ZVal) vphp.RequestOwnedZBox {
	return vphp.own_request_zbox(z)
}

const psr_cache_reserved_key_chars = ['{', '}', '(', ')', '/', '\\', '@', ':']

@[php_method]
pub fn (mut cache VSlimPsr16Cache) construct() &VSlimPsr16Cache {
	ensure_psr16_cache(mut cache)
	return &cache
}

@[php_method: 'setClock']
@[php_arg_type: 'clock=Psr\\Clock\\ClockInterface']
pub fn (mut cache VSlimPsr16Cache) set_clock(clock vphp.RequestBorrowedZBox) &VSlimPsr16Cache {
	ensure_psr16_cache(mut cache)
	if !psr20_is_clock(clock.to_zval()) {
		vphp.throw_exception_class('InvalidArgumentException', 'clock must implement Psr\\Clock\\ClockInterface', 0)
		return &cache
	}
	mut old := cache.clock_ref
	old.release()
	cache.clock_ref = vphp.PersistentOwnedZVal.from_value_zval(clock.to_zval())
	return &cache
}

@[php_method]
@[php_return_type: 'Psr\\Clock\\ClockInterface']
pub fn (mut cache VSlimPsr16Cache) clock() vphp.RequestOwnedZBox {
	ensure_psr16_cache(mut cache)
	return cache.clock_ref.clone_request_owned()
}

@[php_method]
@[php_optional_args: 'default_value']
pub fn (mut cache VSlimPsr16Cache) get(key string, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	ensure_psr16_cache(mut cache)
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return default_value.clone_request_owned()
	}
	cache.prune_expired_entry(normalized)
	entry := cache.entries[normalized] or {
		return default_value.clone_request_owned()
	}
	return entry.value.clone_request_owned()
}

@[php_method]
@[php_optional_args: 'ttl']
pub fn (mut cache VSlimPsr16Cache) set(key string, value vphp.RequestBorrowedZBox, ttl vphp.RequestBorrowedZBox) bool {
	ensure_psr16_cache(mut cache)
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	expires_at := psr_cache_resolve_relative_ttl_or_throw(cache.clock_ref.to_zval(), ttl.to_zval()) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	if expires_at < 0 {
		return cache.delete(normalized)
	}
	cache.replace_entry(normalized, vphp.PersistentOwnedZVal.from_value_zval(value.to_zval()),
		expires_at)
	return true
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) delete(key string) bool {
	ensure_psr16_cache(mut cache)
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	cache.remove_entry(normalized)
	return true
}

@[php_method]
pub fn (mut cache VSlimPsr16Cache) clear() bool {
	ensure_psr16_cache(mut cache)
	cache.clear_entries()
	return true
}

@[php_method: 'getMultiple']
@[php_arg_type: 'keys=iterable']
@[php_return_type: 'iterable']
@[php_optional_args: 'default_value']
pub fn (mut cache VSlimPsr16Cache) get_multiple(keys vphp.RequestBorrowedZBox, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	ensure_psr16_cache(mut cache)
	mut out := new_array_zval()
	if !psr16_is_iterable(keys.to_zval()) {
		throw_psr16_invalid_argument('keys must be iterable')
		return vphp.own_request_zbox(out)
	}
	for key_name in psr16_iterable_key_list(keys.to_zval()) or {
		msg := err.msg()
		throw_psr16_invalid_argument(msg)
		return psr16_owned_value(out)
	} {
		value := cache.get(key_name, default_value)
		add_assoc_zval(out, key_name, value.to_zval())
	}
	return vphp.own_request_zbox(out)
}

@[php_method: 'setMultiple']
@[php_arg_type: 'values=iterable']
@[php_optional_args: 'ttl']
pub fn (mut cache VSlimPsr16Cache) set_multiple(values vphp.RequestBorrowedZBox, ttl vphp.RequestBorrowedZBox) bool {
	ensure_psr16_cache(mut cache)
	if !psr16_is_iterable(values.to_zval()) {
		throw_psr16_invalid_argument('values must be iterable')
		return false
	}
	expires_at := psr_cache_resolve_relative_ttl_or_throw(cache.clock_ref.to_zval(), ttl.to_zval()) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	}
	if expires_at < 0 {
		for key_name in psr16_iterable_assoc_key_list(values.to_zval()) or {
			throw_psr16_invalid_argument(err.msg())
			return false
		} {
			cache.remove_entry(key_name)
		}
		return true
	}
	for key_name, value in psr16_iterable_assoc_pairs(values.to_zval()) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	} {
		cache.replace_entry(key_name, value, expires_at)
	}
	return true
}

@[php_method: 'deleteMultiple']
@[php_arg_type: 'keys=iterable']
pub fn (mut cache VSlimPsr16Cache) delete_multiple(keys vphp.RequestBorrowedZBox) bool {
	ensure_psr16_cache(mut cache)
	if !psr16_is_iterable(keys.to_zval()) {
		throw_psr16_invalid_argument('keys must be iterable')
		return false
	}
	for key_name in psr16_iterable_key_list(keys.to_zval()) or {
		throw_psr16_invalid_argument(err.msg())
		return false
	} {
		cache.remove_entry(key_name)
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
	cache.prune_expired_entry(normalized)
	return normalized in cache.entries
}

fn ensure_psr16_cache(mut cache VSlimPsr16Cache) {
	if cache.entries.len == 0 {
		cache.entries = map[string]PsrCacheEntry{}
	}
	if !cache.clock_ref.is_valid() || cache.clock_ref.is_null() || cache.clock_ref.is_undef() {
		cache.clock_ref = new_psr20_system_clock_ref()
	}
}

fn (mut cache VSlimPsr16Cache) replace_entry(key string, value vphp.PersistentOwnedZVal, expires_at_unix i64) {
	cache.construct()
	if key in cache.entries {
		mut old := cache.entries[key] or { PsrCacheEntry{} }
		old.value.release()
	}
	cache.entries[key] = PsrCacheEntry{
		value: value
		expires_at_unix: expires_at_unix
	}
}

fn (mut cache VSlimPsr16Cache) remove_entry(key string) {
	if key !in cache.entries {
		return
	}
	mut entry := cache.entries[key] or { return }
	entry.value.release()
	cache.entries.delete(key)
}

fn (mut cache VSlimPsr16Cache) clear_entries() {
	keys := cache.entries.keys()
	for key in keys {
		cache.remove_entry(key)
	}
}

fn (mut cache VSlimPsr16Cache) prune_expired_entry(key string) {
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
		expires_at := vphp.with_method_result_zval(now_dt, 'add', [ttl], fn (added vphp.ZVal) i64 {
			if !added.is_valid() || !added.is_object() {
				return i64(-1)
			}
			return vphp.with_method_result_zval(added, 'getTimestamp', []vphp.ZVal{}, fn (ts vphp.ZVal) i64 {
				return ts.to_i64()
			})
		})
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
	values := vphp.php_fn('array_values').call([normalized])
	if !values.is_array() {
		return error('keys must be iterable')
	}
	mut out := []string{}
	for idx := 0; idx < values.array_count(); idx++ {
		key_name := psr16_zval_to_key(values.array_get(idx))!
		out << psr_cache_validate_key_or_throw(key_name)!
	}
	return out
}

fn psr16_iterable_assoc_pairs(value vphp.ZVal) !map[string]vphp.PersistentOwnedZVal {
	normalized := psr16_iterable_to_array(value)!
	keys := vphp.php_fn('array_keys').call([normalized])
	values := vphp.php_fn('array_values').call([normalized])
	if !keys.is_array() || !values.is_array() {
		return error('values must be iterable')
	}
	mut out := map[string]vphp.PersistentOwnedZVal{}
	for idx := 0; idx < keys.array_count(); idx++ {
		key_name := psr16_zval_to_key(keys.array_get(idx)) or {
			psr16_release_pairs(mut out)
			return error(err.msg())
		}
		safe_key := psr_cache_validate_key_or_throw(key_name) or {
			psr16_release_pairs(mut out)
			return error(err.msg())
		}
		out[safe_key] = vphp.PersistentOwnedZVal.from_value_zval(values.array_get(idx))
	}
	return out
}

fn psr16_iterable_assoc_key_list(value vphp.ZVal) ![]string {
	normalized := psr16_iterable_to_array(value)!
	keys := vphp.php_fn('array_keys').call([normalized])
	if !keys.is_array() {
		return error('values must be iterable')
	}
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
		normalized := vphp.php_fn('iterator_to_array').call([value, vphp.ZVal.new_bool(true)])
		if normalized.is_array() {
			return normalized
		}
	}
	return error('value must be iterable')
}

fn psr16_release_pairs(mut pairs map[string]vphp.PersistentOwnedZVal) {
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
	vphp.throw_exception_class('VSlim\\Psr16\\InvalidArgumentException', message, 0)
}

fn (cache &VSlimPsr16Cache) free() {
	unsafe {
		mut writable := &VSlimPsr16Cache(cache)
		writable.clear_entries()
		writable.clock_ref.release()
		writable.entries.free()
	}
}
