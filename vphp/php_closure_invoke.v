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

pub fn (ctx Context) create_saved_closure_with_attributes[T](v_cb T, bridge zend.ClosureBridge, arity int, required int, arginfo voidptr, attributes voidptr) {
	zend.create_closure_with_attributes(ctx.return().raw_ptr(), save_closure_value[T](v_cb), bridge,
		arity, required, arginfo, attributes)
}

pub fn (ctx Context) create_saved_named_variadic_closure[T](v_cb T, bridge zend.ClosureBridge, arity int, required int, arginfo voidptr) {
	zend.create_named_variadic_closure(ctx.return().raw_ptr(), save_closure_value[T](v_cb),
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

pub fn (ctx Context) forward_struct_closure_result[A, R](cb fn (A) !R, args A) {
	result := cb(args) or {
		raise_return_error(err)
		return
	}
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

pub fn (ctx Context) forward_variadic_closure_result[A, R](cb fn (...A) !R) {
	args := ctx.variadic_closure_args[A]() or {
		throw_exception(err.msg(), 0)
		return
	}
	result := cb(...args) or {
		raise_return_error(err)
		return
	}
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
	return ctx.variadic_closure_args_from[T](0)
}

pub fn (ctx Context) closure_arg_to_v[T](index int) !T {
	$if T is PhpThrowable {
		return PhpThrowable.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpEnumCase {
		return PhpEnumCase.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpIterable {
		return PhpIterable.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpGenerator {
		return PhpGenerator.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpFiber {
		return PhpFiber.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpDateInterval {
		return PhpDateInterval.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpDateTimeInterface {
		return PhpDateTimeInterface.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpDateTimeImmutable {
		return PhpDateTimeImmutable.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpJsonSerializable {
		return PhpJsonSerializable.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpStringable {
		return PhpStringable.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpCountable {
		return PhpCountable.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpArrayAccess {
		return PhpArrayAccess.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpWeakMap {
		return PhpWeakMap.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpWeakReference {
		return PhpWeakReference.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpIterator {
		return PhpIterator.must_from_zval(ctx.arg_val(index))
	} $else $if T is PhpIteratorAggregate {
		return PhpIteratorAggregate.must_from_zval(ctx.arg_val(index))
	}
	if !zend.execute_check_closure_scalar_argument(ctx.ex.handle.raw_ptr(), index) {
		return error('type mismatch: expected ${typeof[T]().name}, got ${ctx.arg_val(index).type_name()}')
	}
	return ctx.arg_val(index).to_v[T]()
}

pub fn (ctx Context) variadic_closure_args_from[T](start int) ![]T {
	$if T is PhpArg {
		return ctx.variadic_php_args(ctx.args(), start)
	} $else $if T is PhpReference {
		return ctx.args().variadic_references(start)
	} $else $if T is ZVal || T is PhpValue || T is PhpThrowable || T is PhpEnumCase || T is PhpIterable || T is PhpIterator || T is PhpIteratorAggregate || T is PhpGenerator || T is PhpFiber || T is PhpDateInterval || T is PhpDateTimeImmutable || T is PhpDateTimeInterface || T is PhpJsonSerializable || T is PhpStringable || T is PhpCountable || T is PhpArrayAccess || T is PhpWeakMap || T is PhpWeakReference || T is RequestBorrowedZBox || T is VScalarValue || T is PhpInterfaceValue || T is int || T is i64 || T is string || T is bool || T is f32 || T is f64 {
		count := ctx.num_args()
		if start < 0 || start >= count {
			return []T{}
		}
		mut args := []T{cap: count - start}
		for i in start .. count {
			$if T is ZVal {
				args << ctx.arg_val(i)
			} $else $if T is PhpValue {
				args << ctx.arg_value(i)
			} $else $if T is RequestBorrowedZBox {
				args << ctx.arg_borrowed_zbox(i)
			} $else $if T is VScalarValue {
				args << ctx.arg_v_scalar(i)!
			} $else {
				args << ctx.closure_arg_to_v[T](i) or {
					return error('Argument #${i + 1}: ${err.msg()}')
				}
			}
		}
		return args
	} $else {
		return error('unsupported variadic closure argument type')
	}
}

pub fn (ctx Context) nullable_interface_closure_args_from[T](start int) ![]?T {
	mut args := []?T{}
	for i in start .. ctx.num_args() {
		if ctx.arg_val(i).is_null() {
			args << none
		} else {
			args << ?T(ctx.closure_arg_to_v[T](i) or {
				return error('Argument #${i + 1}: ${err.msg()}')
			})
		}
	}
	return args
}
