module object

import sync

// Keep these roots visible to V's collector across PHP request threads.
__global (
	vphp_vptr_roots      &map[voidptr]int
	vphp_vptr_roots_lock = sync.new_mutex()
)

pub fn register_root(ptr voidptr) {
	if ptr == 0 {
		return
	}
	vphp_vptr_roots_lock.lock()
	defer {
		vphp_vptr_roots_lock.unlock()
	}
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		if isnil(vphp_vptr_roots) {
			vphp_vptr_roots = &map[voidptr]int{}
		}
		mut m := vphp_vptr_roots
		count := m[ptr] or { 0 }
		m[ptr] = count + 1
	}
}

pub fn ensure_root(ptr voidptr) {
	if ptr == 0 {
		return
	}
	vphp_vptr_roots_lock.lock()
	defer {
		vphp_vptr_roots_lock.unlock()
	}
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		if isnil(vphp_vptr_roots) {
			vphp_vptr_roots = &map[voidptr]int{}
		}
		mut m := vphp_vptr_roots
		if ptr !in m {
			m[ptr] = 1
		}
	}
}

pub fn unregister_root(ptr voidptr) {
	if ptr == 0 {
		return
	}
	vphp_vptr_roots_lock.lock()
	defer {
		vphp_vptr_roots_lock.unlock()
	}
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		if !isnil(vphp_vptr_roots) {
			mut m := vphp_vptr_roots
			count := m[ptr] or { 0 }
			if count > 1 {
				m[ptr] = count - 1
			} else {
				m.delete(ptr)
			}
		}
	}
}
