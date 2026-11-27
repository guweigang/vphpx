module vphp

import vphp.object
import vphp.zend
import vphp.zval as zvalmod

// --- From php_return_type.v ---
pub struct PhpReturn {
	handle zvalmod.Handle
}

pub fn PhpReturn.from_ptr(raw voidptr) PhpReturn {
	return PhpReturn{
		handle: zvalmod.Handle.from_ptr(raw)
	}
}

pub fn PhpReturn.from_zval(z ZVal) PhpReturn {
	return PhpReturn{
		handle: z.handle()
	}
}

pub fn (ret PhpReturn) raw_ptr() voidptr {
	return ret.handle.raw_ptr()
}

pub fn (ret PhpReturn) handle() zvalmod.Handle {
	return ret.handle
}

pub fn (ret PhpReturn) to_zval() ZVal {
	return ZVal.from_handle(ret.handle)
}

// --- From php_return_scalar.v ---
pub fn (ret PhpReturn) null() {
	ret.to_zval().set_null()
}

pub fn (ret PhpReturn) bool_value(val bool) {
	ret.to_zval().set_bool(val)
}

pub fn (ret PhpReturn) int_value(val i64) {
	ret.to_zval().set_int(val)
}

pub fn (ret PhpReturn) double_value(val f64) {
	ret.to_zval().set_double(val)
}

pub fn (ret PhpReturn) string_value(val string) {
	ret.to_zval().set_string(val)
}

// --- From php_return_value.v ---
pub fn (ret PhpReturn) zval(val ZVal) {
	ret.to_zval().copy_from(val)
}

pub fn (ret PhpReturn) value(value PhpValue) {
	ret.zval(value.to_zval())
}

pub fn (ret PhpReturn) null_value(value PhpNull) {
	ret.zval(value.to_zval())
}

pub fn (ret PhpReturn) dyn_value(value DynValue) {
	mut owned := value.request_owned()
	defer {
		owned.release()
	}
	ret.zval(owned.to_zval())
}

pub fn (ret PhpReturn) request_owned(value RequestOwnedZBox) {
	ret.zval(value.to_zval())
	mut owned := value
	owned.release()
}

pub fn (ret PhpReturn) request_borrowed(value RequestBorrowedZBox) {
	ret.zval(value.to_zval())
}

pub fn (ret PhpReturn) persistent_owned(value PersistentOwnedZBox) {
	value.with_request_zval(fn [ret] (z ZVal) bool {
		ret.zval(z)
		return true
	})
}

// --- From php_return_object.v ---
pub fn (ret PhpReturn) resource(ptr voidptr, label string) {
	ret.to_zval().make_resource(ptr, label)
}

pub fn (ret PhpReturn) object(v_ptr voidptr, ce ZendClassEntry) {
	object.return_unbound(ret.raw_ptr(), v_ptr, ce)
}

pub fn (ret PhpReturn) bound_object(v_ptr voidptr, ce ZendClassEntry, handlers object.ObjectHandlers, ownership OwnershipKind) {
	match ownership {
		.borrowed {
			object.return_bound(ret.raw_ptr(), v_ptr, ce, handlers, .borrowed)
		}
		.owned_request {
			object.register_root(v_ptr)
			object.return_bound(ret.raw_ptr(), v_ptr, ce, handlers, .owned)
		}
		.owned_persistent {
			object.register_root(v_ptr)
			object.return_bound(ret.raw_ptr(), v_ptr, ce, handlers, .owned)
		}
	}
}

pub fn (ret PhpReturn) owned_object(v_ptr voidptr, ce ZendClassEntry, handlers object.ObjectHandlers) {
	ret.bound_object(v_ptr, ce, handlers, .owned_request)
}

pub fn (ret PhpReturn) borrowed_object(v_ptr voidptr, ce ZendClassEntry, handlers object.ObjectHandlers) {
	object.return_bound(ret.raw_ptr(), v_ptr, ce, handlers, .borrowed)
}

// --- From php_return_compound.v ---
pub fn (ret PhpReturn) list[T](list []T) {
	$if T is string || T is f64 || T is int || T is i64 {
		ret.v(list)
	} $else {
		out := ret.to_zval()
		out.array_init()
		for item in list {
			out.push_struct(item)
		}
	}
}

pub fn (ret PhpReturn) map_value[T](m map[string]T) {
	$if T is string || T is int || T is i64 || T is f64 || T is bool {
		ret.v(m)
	} $else {
		ret.to_zval().array_init()
	}
}

pub fn (ret PhpReturn) object_props(props map[string]string) {
	out := ret.to_zval()
	out.object_init()
	for k, v in props {
		out.update_property_string(k, v)
	}
}

pub fn (ret PhpReturn) struct_value[T](s T) {
	out := ret.to_zval()
	out.array_init()
	$for field in T.fields {
		key := field.name
		$if field.typ is string {
			out.add_assoc_string(key, s.$(field.name))
		} $else $if field.typ is f64 {
			out.add_assoc_double(key, s.$(field.name))
		} $else $if field.typ is int || field.typ is i64 {
			out.add_assoc_long(key, i64(s.$(field.name)))
		} $else $if field.typ is bool {
			out.add_assoc_bool(key, s.$(field.name))
		}
	}
}

// --- From php_return_flow.v ---
fn raise_return_error(err IError) {
	if !has_exception() {
		throw_exception(err.msg(), 0)
	}
}

pub fn (ret PhpReturn) from_result_void(f fn () !) {
	f() or {
		raise_return_error(err)
		return
	}
}

pub fn (ret PhpReturn) from_result[T](f fn () !T) {
	res := f() or {
		raise_return_error(err)
		return
	}
	ret.v[T](res)
}

pub fn (ret PhpReturn) from_option_void(f fn () ?) {
	f() or {
		ret.null()
		return
	}
}

pub fn (ret PhpReturn) from_option[T](f fn () ?T) {
	res := f() or {
		ret.null()
		return
	}
	ret.v[T](res)
}

pub fn (ret PhpReturn) from_result_object[T](f fn () !&T, ownership OwnershipKind) {
	value := f() or {
		raise_return_error(err)
		return
	}
	ret.return_v_object(value, ownership)
}

pub fn (ret PhpReturn) from_option_object[T](f fn () ?&T, ownership OwnershipKind) {
	value := f() or {
		ret.null()
		return
	}
	ret.return_v_object(value, ownership)
}

pub fn (ret PhpReturn) return_v_object[T](value &T, ownership OwnershipKind) {
	if has_exception() {
		return
	}
	$for method in T.methods {
		$if method.name == 'php_class_name' && T is $struct {
			binding := PhpObjectBinding.new[T]()
			ce := binding.class_entry.raw_ptr()
			handlers := binding.handlers.raw_ptr()
			if ownership == .borrowed {
				zend.return_borrowed_object_ptr(ret.raw_ptr(), value, ce, handlers)
			} else {
				zend.return_owned_object_ptr(ret.raw_ptr(), value, ce, handlers)
			}
			return
		}
	}
	ret.v[&T](value)
}

// --- From php_return_generic.v ---
pub fn (ret PhpReturn) any[T](val T) {
	ret.v[T](val)
}

pub fn (ret PhpReturn) v[T](val T) {
	$if T is PhpInterfaceValue {
		ret.zval(val.php_interface_zval())
		return
	} $else $if T is PhpValue {
		ret.value(val)
		return
	} $else $if T is PhpNull {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpBool {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpInt {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpDouble {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpString {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpScalar {
		ret.zval(val.to_zval())
		return
	} $else $if T is VScalarValue {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpArray {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpObject {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpCallable {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpClosure {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpResource {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpReference {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpIterable {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpIterator || T is PhpIteratorAggregate || T is PhpGenerator || T is PhpFiber || T is PhpDateInterval || T is PhpDateTimeImmutable || T is PhpDateTimeInterface || T is PhpJsonSerializable || T is PhpStringable || T is PhpCountable || T is PhpArrayAccess || T is PhpWeakMap || T is PhpWeakReference {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpThrowable {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpEnumCase {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpClass {
		ret.zval(val.to_zval())
		return
	} $else $if T is PhpFunction {
		ret.zval(val.to_zval())
		return
	} $else $if T is DynValue {
		ret.dyn_value(val)
		return
	} $else $if T is RequestOwnedZBox {
		ret.request_owned(val)
		return
	} $else $if T is RequestBorrowedZBox {
		ret.request_borrowed(val)
		return
	} $else $if T is PersistentOwnedZBox {
		ret.persistent_owned(val)
		return
	} $else $if T is $sumtype {
		$for variant in T.variants {
			$if variant.typ is bool || variant.typ is int || variant.typ is i64 || variant.typ is f64 || variant.typ is string || variant.typ is []string || variant.typ is []int || variant.typ is []i64 || variant.typ is []f64 || variant.typ is []bool {
				if val is variant {
					payload := val
					ret.v(payload)
					return
				}
			}
			$if variant.typ is PhpValue {
				if val is PhpValue {
					ret.value(val)
					return
				}
			}
			$if variant.typ is PhpObject {
				if val is PhpObject {
					ret.zval(val.to_zval())
					return
				}
			}
			$if variant.typ is PhpArray {
				if val is PhpArray {
					ret.zval(val.to_zval())
					return
				}
			}
			$if variant.typ is $struct {
				if val is variant {
					payload := val
					ret.sumtype_object(payload)
					return
				}
			}
			$if variant.typ is $enum {
				if val is variant {
					payload := val
					ret.v(payload)
					return
				}
			}
		}
		ret.null()
		return
	}
	mut out := ret.to_zval()
	out.from_v[T](val) or {
		$if T is $struct {
			ret.struct_value(val)
		} $else {
			throw_exception(err.msg(), 0)
			ret.null()
		}
	}
}

fn (ret PhpReturn) sumtype_object[T](payload T) {
	$for method in T.methods {
		$if method.name == 'php_class_name' {
			binding := PhpObjectBinding.new[T]()
			if binding.is_valid() {
				ptr := unsafe { memdup(&payload, int(sizeof(T))) }
				zend.return_owned_object_ptr(ret.raw_ptr(), ptr, binding.class_entry.raw_ptr(),
					binding.handlers.raw_ptr())
				return
			}
		}
	}
	ret.null()
}
