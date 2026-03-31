module main

import vphp

struct Psr6ItemSnapshot {
	key string
mut:
	value           vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
	has_value       bool
	expires_at_unix i64
}

@[php_method]
pub fn (mut pool VSlimPsr6CacheItemPool) construct() &VSlimPsr6CacheItemPool {
	ensure_psr6_pool(mut pool)
	return &pool
}

@[php_method: 'setClock']
@[php_arg_type: 'clock=Psr\\Clock\\ClockInterface']
pub fn (mut pool VSlimPsr6CacheItemPool) set_clock(clock vphp.BorrowedValue) &VSlimPsr6CacheItemPool {
	ensure_psr6_pool(mut pool)
	if !psr20_is_clock(clock.to_zval()) {
		vphp.throw_exception_class('InvalidArgumentException', 'clock must implement Psr\\Clock\\ClockInterface', 0)
		return &pool
	}
	mut old := pool.clock_ref
	old.release()
	pool.clock_ref = vphp.PersistentOwnedZVal.from_zval(clock.to_zval())
	return &pool
}

@[php_method]
@[php_return_type: 'Psr\\Clock\\ClockInterface']
pub fn (mut pool VSlimPsr6CacheItemPool) clock() vphp.Value {
	ensure_psr6_pool(mut pool)
	return vphp.Value.from_zval(pool.clock_ref.clone_request_owned().to_zval())
}

@[php_method: 'getItem']
@[php_return_type: 'Psr\\Cache\\CacheItemInterface']
pub fn (mut pool VSlimPsr6CacheItemPool) get_item(key string) &VSlimPsr6CacheItem {
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr6_invalid_argument(err.msg())
		return psr6_new_missing_item_with_clock('', pool.clock_ref)
	}
	ensure_psr6_pool(mut pool)
	return pool.item_for_key(normalized)
}

@[php_method: 'getItems']
@[php_arg_type: 'keys=array']
@[php_return_type: 'iterable']
@[php_optional_args: 'keys']
pub fn (mut pool VSlimPsr6CacheItemPool) get_items(keys vphp.BorrowedValue) vphp.Value {
	ensure_psr6_pool(mut pool)
	mut out := new_array_zval()
	if !keys.is_valid() || keys.is_null() || keys.is_undef() {
		return vphp.Value.from_zval(out)
	}
	if !keys.is_array() {
		throw_psr6_invalid_argument('keys must be an array of cache keys')
		return vphp.Value.from_zval(out)
	}
	for key_name in psr6_key_list_from_array(keys.to_zval()) or {
		throw_psr6_invalid_argument(err.msg())
		return vphp.Value.from_zval(out)
	} {
		add_assoc_zval(out, key_name, build_php_psr6_cache_item_object(pool.item_for_key(key_name)))
	}
	return vphp.Value.from_zval(out)
}

@[php_method: 'hasItem']
pub fn (mut pool VSlimPsr6CacheItemPool) has_item(key string) bool {
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr6_invalid_argument(err.msg())
		return false
	}
	ensure_psr6_pool(mut pool)
	if normalized in pool.deferred {
		entry := pool.deferred[normalized] or { Psr6DeferredEntry{} }
		if psr6_deferred_entry_expired(pool.clock_ref.to_zval(), entry) || !entry.has_value {
			pool.remove_deferred_entry(normalized)
			return false
		}
		return true
	}
	pool.prune_expired_entry(normalized)
	return normalized in pool.entries
}

@[php_method]
pub fn (mut pool VSlimPsr6CacheItemPool) clear() bool {
	ensure_psr6_pool(mut pool)
	pool.clear_entries()
	pool.clear_deferred_entries()
	return true
}

@[php_method: 'deleteItem']
pub fn (mut pool VSlimPsr6CacheItemPool) delete_item(key string) bool {
	normalized := psr_cache_validate_key_or_throw(key) or {
		throw_psr6_invalid_argument(err.msg())
		return false
	}
	ensure_psr6_pool(mut pool)
	pool.remove_entry(normalized)
	pool.remove_deferred_entry(normalized)
	return true
}

@[php_method: 'deleteItems']
@[php_arg_type: 'keys=array']
pub fn (mut pool VSlimPsr6CacheItemPool) delete_items(keys vphp.BorrowedValue) bool {
	ensure_psr6_pool(mut pool)
	if !keys.is_array() {
		throw_psr6_invalid_argument('keys must be an array of cache keys')
		return false
	}
	for key_name in psr6_key_list_from_array(keys.to_zval()) or {
		throw_psr6_invalid_argument(err.msg())
		return false
	} {
		pool.remove_entry(key_name)
		pool.remove_deferred_entry(key_name)
	}
	return true
}

@[php_method]
@[php_arg_type: 'item=Psr\\Cache\\CacheItemInterface']
pub fn (mut pool VSlimPsr6CacheItemPool) save(item vphp.BorrowedValue) bool {
	ensure_psr6_pool(mut pool)
	snapshot := psr6_snapshot_from_item(item.to_zval()) or {
		throw_psr6_cache_exception(err.msg())
		return false
	}
	pool.remove_deferred_entry(snapshot.key)
	ok := pool.persist_snapshot(snapshot)
	mut owned := snapshot.value
	owned.release()
	return ok
}

@[php_method: 'saveDeferred']
@[php_arg_type: 'item=Psr\\Cache\\CacheItemInterface']
pub fn (mut pool VSlimPsr6CacheItemPool) save_deferred(item vphp.BorrowedValue) bool {
	ensure_psr6_pool(mut pool)
	snapshot := psr6_snapshot_from_item(item.to_zval()) or {
		throw_psr6_cache_exception(err.msg())
		return false
	}
	pool.replace_deferred_entry(snapshot.key, snapshot)
	mut owned := snapshot.value
	owned.release()
	return true
}

@[php_method]
pub fn (mut pool VSlimPsr6CacheItemPool) commit() bool {
	ensure_psr6_pool(mut pool)
	keys := pool.deferred.keys()
	for key in keys {
		entry := pool.deferred[key] or { continue }
		snapshot := Psr6ItemSnapshot{
			key:             key
			value:           psr6_clone_persistent(entry.value)
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

@[php_method: 'getKey']
pub fn (item &VSlimPsr6CacheItem) get_key() string {
	return item.key
}

@[php_method]
pub fn (item &VSlimPsr6CacheItem) get() vphp.Value {
	if !item.has_value {
		return vphp.Value.new_null()
	}
	return vphp.Value.from_zval(item.value_ref.clone_request_owned().to_zval())
}

@[php_method: 'isHit']
pub fn (item &VSlimPsr6CacheItem) is_hit() bool {
	if !item.hit {
		return false
	}
	now_unix := psr20_now_unix_or_throw(item.clock_ref.to_zval()) or { return false }
	if item.expires_at_unix > 0 && item.expires_at_unix <= now_unix {
		return false
	}
	return item.has_value
}

@[php_method]
@[php_return_type: 'static']
pub fn (mut item VSlimPsr6CacheItem) set(value vphp.BorrowedValue) &VSlimPsr6CacheItem {
	item.replace_value(value.to_zval())
	return &item
}

@[php_method: 'expiresAt']
@[php_arg_type: 'expiration=?DateTimeInterface']
@[php_return_type: 'static']
pub fn (mut item VSlimPsr6CacheItem) expires_at(expiration vphp.BorrowedValue) &VSlimPsr6CacheItem {
	ensure_psr6_item_clock(mut item)
	item.expires_at_unix = psr6_resolve_absolute_expiration_or_throw(expiration.to_zval()) or {
		throw_psr6_invalid_argument(err.msg())
		return &item
	}
	return &item
}

@[php_method: 'expiresAfter']
@[php_arg_type: 'time=mixed']
@[php_return_type: 'static']
pub fn (mut item VSlimPsr6CacheItem) expires_after(time_value vphp.BorrowedValue) &VSlimPsr6CacheItem {
	ensure_psr6_item_clock(mut item)
	item.expires_at_unix = psr6_resolve_relative_expiration_or_throw(item.clock_ref.to_zval(), time_value.to_zval()) or {
		throw_psr6_invalid_argument(err.msg())
		return &item
	}
	return &item
}

fn ensure_psr6_pool(mut pool VSlimPsr6CacheItemPool) {
	if pool.entries.len == 0 {
		pool.entries = map[string]PsrCacheEntry{}
	}
	if pool.deferred.len == 0 {
		pool.deferred = map[string]Psr6DeferredEntry{}
	}
	if !pool.clock_ref.is_valid() || pool.clock_ref.is_null() || pool.clock_ref.is_undef() {
		pool.clock_ref = new_psr20_system_clock_ref()
	}
}

fn ensure_psr6_item_clock(mut item VSlimPsr6CacheItem) {
	if !item.clock_ref.is_valid() || item.clock_ref.is_null() || item.clock_ref.is_undef() {
		item.clock_ref = new_psr20_system_clock_ref()
	}
}

fn (mut pool VSlimPsr6CacheItemPool) item_for_key(key string) &VSlimPsr6CacheItem {
	if key in pool.deferred {
		entry := pool.deferred[key] or { Psr6DeferredEntry{} }
		if psr6_deferred_entry_expired(pool.clock_ref.to_zval(), entry) || !entry.has_value {
			pool.remove_deferred_entry(key)
			return psr6_new_missing_item_with_clock(key, pool.clock_ref)
		}
		return psr6_new_hit_item_with_clock(key, entry.value, entry.expires_at_unix, pool.clock_ref)
	}
	pool.prune_expired_entry(key)
	entry := pool.entries[key] or { return psr6_new_missing_item_with_clock(key, pool.clock_ref) }
	return psr6_new_hit_item_with_clock(key, entry.value, entry.expires_at_unix, pool.clock_ref)
}

fn (mut pool VSlimPsr6CacheItemPool) persist_snapshot(snapshot Psr6ItemSnapshot) bool {
	now_unix := psr20_now_unix_or_throw(pool.clock_ref.to_zval()) or { return false }
	if !snapshot.has_value || snapshot.expires_at_unix < 0
		|| (snapshot.expires_at_unix > 0 && snapshot.expires_at_unix <= now_unix) {
		pool.remove_entry(snapshot.key)
		return true
	}
	pool.replace_entry(snapshot.key, psr6_clone_persistent(snapshot.value), snapshot.expires_at_unix)
	return true
}

fn (mut pool VSlimPsr6CacheItemPool) replace_entry(key string, value vphp.PersistentOwnedZVal, expires_at_unix i64) {
	if key in pool.entries {
		mut old := pool.entries[key] or { PsrCacheEntry{} }
		old.value.release()
	}
	pool.entries[key] = PsrCacheEntry{
		value: value
		expires_at_unix: expires_at_unix
	}
}

fn (mut pool VSlimPsr6CacheItemPool) remove_entry(key string) {
	if key !in pool.entries {
		return
	}
	mut entry := pool.entries[key] or { return }
	entry.value.release()
	pool.entries.delete(key)
}

fn (mut pool VSlimPsr6CacheItemPool) clear_entries() {
	keys := pool.entries.keys()
	for key in keys {
		pool.remove_entry(key)
	}
}

fn (mut pool VSlimPsr6CacheItemPool) prune_expired_entry(key string) {
	if key !in pool.entries {
		return
	}
	entry := pool.entries[key] or { return }
	if !psr_cache_entry_expired(pool.clock_ref.to_zval(), entry) {
		return
	}
	pool.remove_entry(key)
}

fn (mut pool VSlimPsr6CacheItemPool) replace_deferred_entry(key string, snapshot Psr6ItemSnapshot) {
	if key in pool.deferred {
		mut old := pool.deferred[key] or { Psr6DeferredEntry{} }
		old.value.release()
	}
	pool.deferred[key] = Psr6DeferredEntry{
		value:           psr6_clone_persistent(snapshot.value)
		has_value:       snapshot.has_value
		expires_at_unix: snapshot.expires_at_unix
	}
}

fn (mut pool VSlimPsr6CacheItemPool) remove_deferred_entry(key string) {
	if key !in pool.deferred {
		return
	}
	mut entry := pool.deferred[key] or { return }
	entry.value.release()
	pool.deferred.delete(key)
}

fn (mut pool VSlimPsr6CacheItemPool) clear_deferred_entries() {
	keys := pool.deferred.keys()
	for key in keys {
		pool.remove_deferred_entry(key)
	}
}

fn psr6_deferred_entry_expired(clock vphp.ZVal, entry Psr6DeferredEntry) bool {
	now_unix := psr20_now_unix_or_throw(clock) or { return false }
	return entry.expires_at_unix > 0 && entry.expires_at_unix <= now_unix
}

fn psr6_new_missing_item_with_clock(key string, clock_ref vphp.PersistentOwnedZVal) &VSlimPsr6CacheItem {
	return &VSlimPsr6CacheItem{
		key:       key
		value_ref: vphp.PersistentOwnedZVal.new_null()
		clock_ref: psr6_clone_persistent(clock_ref)
		hit:       false
		has_value: false
	}
}

fn psr6_new_hit_item_with_clock(key string, value vphp.PersistentOwnedZVal, expires_at_unix i64, clock_ref vphp.PersistentOwnedZVal) &VSlimPsr6CacheItem {
	return &VSlimPsr6CacheItem{
		key:             key
		value_ref:       psr6_clone_persistent(value)
		clock_ref:       psr6_clone_persistent(clock_ref)
		hit:             true
		has_value:       true
		expires_at_unix: expires_at_unix
	}
}

fn build_php_psr6_cache_item_object(item &VSlimPsr6CacheItem) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		vphp.return_owned_object_raw(payload.raw, item, C.vslim__psr6__cacheitem_ce,
			&C.vphp_class_handlers(vslimpsr6cacheitem_handlers()))
		return payload
	}
}

fn psr6_snapshot_from_item(item vphp.ZVal) !Psr6ItemSnapshot {
	if !item.is_valid() || !item.is_object() {
		return error('cache item must be an object')
	}
	mut own := item.to_object[VSlimPsr6CacheItem]() or {
		return error('save() expects VSlim\\Psr6\\CacheItem instances created by this pool')
	}
	key := psr_cache_validate_key_or_throw(own.key)!
	return Psr6ItemSnapshot{
		key:             key
		value:           psr6_clone_persistent(own.value_ref)
		has_value:       own.has_value
		expires_at_unix: own.expires_at_unix
	}
}

fn psr6_key_list_from_array(keys vphp.ZVal) ![]string {
	values := vphp.php_fn('array_values').call([keys])
	if !values.is_array() {
		return error('keys must be an array of cache keys')
	}
	mut out := []string{}
	for idx := 0; idx < values.array_count(); idx++ {
		key_name := psr6_zval_to_key(values.array_get(idx))!
		out << psr_cache_validate_key_or_throw(key_name)!
	}
	return out
}

fn psr6_zval_to_key(value vphp.ZVal) !string {
	if value.is_string() {
		return value.to_string()
	}
	return error('cache keys must be strings')
}

fn psr6_resolve_absolute_expiration_or_throw(expiration vphp.ZVal) !i64 {
	if !expiration.is_valid() || expiration.is_null() || expiration.is_undef() {
		return 0
	}
	if expiration.is_object() && expiration.is_instance_of('DateTimeInterface') {
		return expiration.method_owned_request('getTimestamp', []).to_i64()
	}
	return error('expiration must be null or DateTimeInterface')
}

fn psr6_resolve_relative_expiration_or_throw(clock vphp.ZVal, time_value vphp.ZVal) !i64 {
	if !time_value.is_valid() || time_value.is_null() || time_value.is_undef() {
		return 0
	}
	now_unix := psr20_now_unix_or_throw(clock)!
	if time_value.is_long() {
		seconds := time_value.to_i64()
		if seconds <= 0 {
			return i64(-1)
		}
		return now_unix + seconds
	}
	if time_value.is_object() && time_value.is_instance_of('DateInterval') {
		now_dt := psr20_now_datetime_or_throw(clock) or {
			return error('failed to resolve clock time for expiration resolution')
		}
		added := now_dt.method_owned_request('add', [time_value])
		if !added.is_valid() || !added.is_object() {
			return error('failed to apply DateInterval expiration')
		}
		return added.method_owned_request('getTimestamp', []).to_i64()
	}
	return error('time must be null, an integer, or DateInterval')
}

fn psr6_clone_persistent(value vphp.PersistentOwnedZVal) vphp.PersistentOwnedZVal {
	return value.clone_request_owned().clone_persistent_owned()
}

fn (mut item VSlimPsr6CacheItem) replace_value(value vphp.ZVal) {
	mut old := item.value_ref
	old.release()
	item.value_ref = vphp.PersistentOwnedZVal.from_zval(value)
	item.has_value = true
}

fn throw_psr6_invalid_argument(message string) {
	vphp.throw_exception_class('VSlim\\Psr6\\InvalidArgumentException', message, 0)
}

fn throw_psr6_cache_exception(message string) {
	vphp.throw_exception_class('VSlim\\Psr6\\CacheException', message, 0)
}

fn (item &VSlimPsr6CacheItem) free() {
	unsafe {
		mut writable := &VSlimPsr6CacheItem(item)
		writable.value_ref.release()
		writable.clock_ref.release()
	}
}

fn (pool &VSlimPsr6CacheItemPool) free() {
	unsafe {
		mut writable := &VSlimPsr6CacheItemPool(pool)
		writable.clear_entries()
		writable.clear_deferred_entries()
		writable.clock_ref.release()
		writable.entries.free()
		writable.deferred.free()
	}
}
