module zend

pub type ClosureBridge = fn (voidptr, &C.zend_execute_data, &C.zval)

pub fn create_closure_with_arity(ret &C.zval, thunk voidptr, bridge voidptr, num_args int, required_args int) {
	C.vphp_create_closure_with_arity(ret, thunk, bridge, num_args, required_args)
}

pub fn create_closure_with_arity_ptr(ret voidptr, thunk voidptr, bridge voidptr, num_args int, required_args int) {
	create_closure_with_arity( // SAFETY: ret is a valid zval pointer from Zend runtime
	unsafe { &C.zval(ret) }, thunk, bridge, num_args, required_args)
}

pub fn create_variadic_closure(ret &C.zval, thunk voidptr, bridge voidptr) {
	C.vphp_create_variadic_closure(ret, thunk, ClosureBridge(bridge))
}

pub fn create_closure_with_arginfo(ret voidptr, thunk voidptr, bridge voidptr, num_args int, required_args int, arginfo voidptr) {
	create_typed_closure_with_arginfo(ret, thunk, ClosureBridge(bridge), num_args, required_args,
		arginfo)
}

pub fn create_typed_closure_with_arginfo(ret voidptr, thunk voidptr, bridge ClosureBridge, num_args int, required_args int, arginfo voidptr) {
	C.vphp_create_closure_with_arginfo(unsafe { &C.zval(ret) }, thunk, bridge, num_args,
		required_args, arginfo)
}

pub fn create_typed_variadic_closure(ret voidptr, thunk voidptr, bridge ClosureBridge) {
	C.vphp_create_variadic_closure(unsafe { &C.zval(ret) }, thunk, bridge)
}

pub fn create_variadic_closure_ptr(ret voidptr, thunk voidptr, bridge voidptr) {
	create_variadic_closure( // SAFETY: ret is a valid zval pointer from Zend runtime
	unsafe { &C.zval(ret) }, thunk, bridge)
}
