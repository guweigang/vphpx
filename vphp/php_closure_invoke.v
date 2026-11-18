module vphp

import vphp.zend

// ======== 闭包桥接 ========

@[inline]
fn save_closure_value[T](v_cb T) voidptr {
	mut saved_cb := unsafe { &T(zend.emalloc(usize(sizeof(T)))) }
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		*saved_cb = v_cb
	}
	return voidptr(saved_cb)
}

pub fn (ctx Context) create_saved_closure[T](v_cb T, bridge voidptr, arity int) {
	ctx.create_saved_closure_with_arity[T](v_cb, bridge, arity, arity)
}

pub fn (ctx Context) create_saved_closure_with_arity[T](v_cb T, bridge voidptr, arity int, required int) {
	zend.create_closure_with_arity_ptr(ctx.return().raw_ptr(), save_closure_value[T](v_cb), bridge,
		arity, required)
}

pub fn (ctx Context) create_saved_variadic_closure[T](v_cb T, bridge voidptr) {
	zend.create_variadic_closure_ptr(ctx.return().raw_ptr(), save_closure_value[T](v_cb), bridge)
}

pub fn (ctx Context) create_saved_closure_with_arginfo[T](v_cb T, bridge voidptr, arity int, required int, arginfo voidptr) {
	zend.create_closure_with_arginfo(ctx.return().raw_ptr(), save_closure_value[T](v_cb), bridge,
		arity, required, arginfo)
}

pub fn (ctx Context) create_typed_saved_variadic_closure[T](v_cb T, bridge zend.ClosureBridge) {
	zend.create_typed_variadic_closure(ctx.return().raw_ptr(), save_closure_value[T](v_cb),
		bridge)
}

pub fn (ctx Context) create_typed_saved_closure_with_arginfo[T](v_cb T, bridge zend.ClosureBridge, arity int, required int, arginfo voidptr) {
	zend.create_typed_closure_with_arginfo(ctx.return().raw_ptr(), save_closure_value[T](v_cb),
		bridge, arity, required, arginfo)
}

// These values suppress sibling initializers while reading one default field.
// Their storage is never exposed to the callback or converted to a PHP value.
pub fn struct_closure_default_placeholder[T]() T {
	unsafe {
		storage := vcalloc_noscan(int(sizeof(T)))
		defer {
			free(storage)
		}
		return *(&T(storage))
	}
}

pub fn (ctx Context) forward_struct_closure[A, R](cb fn (A) R, args A) {
	result := cb(args)
	ctx.return().v[R](result)
}

pub fn (ctx Context) forward_struct_closure_void[A](cb fn (A), args A) {
	cb(args)
	ctx.return().null()
}

pub fn (ctx Context) invoke_struct_closure[T, A, R](cb T, args A) {
	$match T {
		fn (A) R {
			ctx.forward_struct_closure[A, R](cb, args)
		}
		$else {
			throw_exception('unsupported struct closure type', 0)
		}
	}
}

pub fn (ctx Context) invoke_struct_closure_void[T, A](cb T, args A) {
	$match T {
		fn (A) {
			ctx.forward_struct_closure_void[A](cb, args)
		}
		$else {
			throw_exception('unsupported struct closure type', 0)
		}
	}
}

pub fn (ctx Context) forward_variadic_closure[A, R](cb fn (...A) R) {
	args := ctx.variadic_closure_args[A]() or {
		throw_exception(err.msg(), 0)
		return
	}
	result := cb(...args)
	ctx.return().v[R](result)
}

pub fn (ctx Context) forward_variadic_closure_void[A](cb fn (...A)) {
	args := ctx.variadic_closure_args[A]() or {
		throw_exception(err.msg(), 0)
		return
	}
	cb(...args)
	ctx.return().null()
}

pub fn (ctx Context) invoke_variadic_closure[T, R](cb T) {
	// The comptime match compares function type names from the calling module.
	$match T {
		fn (...vphp.ZVal) R {
			ctx.forward_variadic_closure[ZVal, R](cb)
		}
		fn (...vphp.PhpValue) R {
			ctx.forward_variadic_closure[PhpValue, R](cb)
		}
		fn (...vphp.RequestBorrowedZBox) R {
			ctx.forward_variadic_closure[RequestBorrowedZBox, R](cb)
		}
		fn (...vphp.VScalarValue) R {
			ctx.forward_variadic_closure[VScalarValue, R](cb)
		}
		$else {
			throw_exception('unsupported variadic closure type', 0)
		}
	}
}

pub fn (ctx Context) invoke_variadic_closure_void[T](cb T) {
	// Match the module-qualified parameter types used by callers.
	$match T {
		fn (...vphp.ZVal) {
			ctx.forward_variadic_closure_void[ZVal](cb)
		}
		fn (...vphp.PhpValue) {
			ctx.forward_variadic_closure_void[PhpValue](cb)
		}
		fn (...vphp.RequestBorrowedZBox) {
			ctx.forward_variadic_closure_void[RequestBorrowedZBox](cb)
		}
		fn (...vphp.VScalarValue) {
			ctx.forward_variadic_closure_void[VScalarValue](cb)
		}
		$else {
			throw_exception('unsupported variadic closure type', 0)
		}
	}
}

pub fn (ctx Context) variadic_closure_args[T]() ![]T {
	$if T is ZVal || T is PhpValue || T is RequestBorrowedZBox || T is VScalarValue {
		count := ctx.num_args()
		mut args := []T{cap: count}
		for i in 0 .. count {
			$if T is ZVal {
				args << ctx.arg_val(i)
			} $else $if T is PhpValue {
				args << ctx.arg_value(i)
			} $else $if T is RequestBorrowedZBox {
				args << ctx.arg_borrowed_zbox(i)
			} $else {
				args << ctx.arg_v_scalar(i)!
			}
		}
		return args
	} $else {
		return error('unsupported variadic closure argument type')
	}
}
