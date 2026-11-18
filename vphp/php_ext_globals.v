module vphp

import vphp.zend

// get_globals returns the active Zend module globals declared with
// @[vphp.PhpGlobals] or @[php_globals]. Mutate individual fields.
pub fn get_globals[T]() &T {
	return unsafe { &T(zend.active_globals_ptr()) }
}

// with_globals passes Zend's active module globals to a mutation callback.
pub fn with_globals[T](run fn (mut T)) {
	mut globals := get_globals[T]()
	run(mut globals)
}
