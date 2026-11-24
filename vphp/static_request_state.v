module vphp

import vphp.zend

// request_static_state is used by generated statics() accessors. The returned
// reference is valid until the current physical or worker request ends.
pub fn request_static_state[T](key string, initialize fn () T) &T {
	if state := zend.find_request_static_state(key) {
		return unsafe { &T(state) }
	}
	initial := initialize()
	// Keep V pointers in the state visible to the GC while Zend owns the slot.
	state := unsafe { memdup_uncollectable(&initial, int(sizeof(T))) }
	zend.store_request_static_state(key, state, release_request_static_state)
	return unsafe { &T(state) }
}

fn release_request_static_state(state voidptr) {
	unsafe { free(state) }
}

pub fn current_static_sync_class(from_php fn (voidptr)) voidptr {
	return C.vphp_current_static_sync_class(from_php)
}

// static_shadow_state_key selects a separate V state when PHP redeclares a
// property in the table. fields contains NUL-terminated PHP property names.
pub fn static_shadow_state_key(key string, ce voidptr, base string, fields string) string {
	owner := C.vphp_static_shadow_owner(ce, &char(base.str), usize(base.len), &char(fields.str),
		usize(fields.len))
	return if owner == 0 { key } else { '${key}:${u64(owner)}' }
}

pub struct StaticSyncScope {
mut:
	handle voidptr
}

// static_sync_class_entry selects the PHP class whose static properties the
// current method call resolves, including properties redeclared by subclasses.
pub fn (ctx Context) static_sync_class_entry() ZendClassEntry {
	return ZendClassEntry.from_ptr(zend.execute_called_class_ptr(ctx.ex.handle.raw_ptr()))
}

// begin_static_sync attaches a generated shadow table to this method call.
pub fn begin_static_sync(ctx Context, from_php fn (voidptr), to_php fn (voidptr)) StaticSyncScope {
	ce := ctx.static_sync_class_entry()
	if !ce.is_valid() {
		return StaticSyncScope{}
	}
	return StaticSyncScope{
		handle: C.vphp_begin_static_sync(ce.raw_ptr(), from_php, to_php)
	}
}

pub fn (mut scope StaticSyncScope) close() {
	if scope.handle != 0 {
		C.vphp_end_static_sync(scope.handle)
		scope.handle = voidptr(0)
	}
}
