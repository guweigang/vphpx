module vphp

import vphp.zend

// reject_named_variadic_args protects positional-only V variadic exports.
pub fn (ctx Context) reject_named_variadic_args() bool {
	return zend.execute_read_named_variadic_args(ctx.ex.handle.raw_ptr(), unsafe { nil },
		unsafe { nil })
}

// variadic_php_args preserves the order and names of the PHP variadic tail.
pub fn (ctx Context) variadic_php_args(args PhpArgs, start int) ![]PhpArg {
	mut items := []PhpArg{}
	for index in start .. args.len() {
		items << args.at(index)
	}
	if !zend.execute_read_named_variadic_args(ctx.ex.handle.raw_ptr(), &items,
		append_named_variadic_arg) {
		return error('invalid named variadic argument')
	}
	return items
}

fn append_named_variadic_arg(data voidptr, index u32, name &char, len int, value &C.zval) {
	unsafe {
		mut items := &[]PhpArg(data)
		items << PhpArg.from_meta_zval(PhpArgMeta{
			index:             int(index)
			name:              tos(&u8(name), len).clone()
			is_named_variadic: true
		}, ZVal.from_ptr(value))
	}
}

// 获取当前 PHP 函数调用的所有参数
pub fn (ctx Context) get_args() []ZVal {
	return ctx.ex.args()
}

// ======== 参数读取 ========

pub fn (ctx Context) arg_raw(index int) ZVal {
	return ctx.ex.arg(index)
}

// Low-level borrowed view; prefer `arg_borrowed_zbox()` for ownership-facing
pub fn (ctx Context) arg_borrowed_zbox(index int) RequestBorrowedZBox {
	return ctx.ex.arg_borrowed_zbox(index)
}

pub fn (ctx Context) arg_borrowed_zbox_opt(index int) ?RequestBorrowedZBox {
	return ctx.ex.arg_borrowed_zbox_opt(index)
}

pub fn (ctx Context) arg_any_zbox(index int) RequestBorrowedZBox {
	return ctx.arg_borrowed_zbox(index)
}

pub fn (ctx Context) arg_value(index int) PhpValue {
	return ctx.ex.arg_value(index)
}

pub fn (ctx Context) arg_null(index int) ?PhpNull {
	return ctx.arg_at(index).null_value()
}

pub fn (ctx Context) arg_bool(index int) ?PhpBool {
	return ctx.arg_at(index).bool_value()
}

pub fn (ctx Context) arg_int(index int) ?PhpInt {
	return ctx.arg_at(index).int_value()
}

pub fn (ctx Context) arg_double(index int) ?PhpDouble {
	return ctx.arg_at(index).double_value()
}

pub fn (ctx Context) arg_string(index int) ?PhpString {
	return ctx.arg_at(index).string_value()
}

pub fn (ctx Context) arg_scalar(index int) ?PhpScalar {
	return ctx.arg_at(index).scalar()
}

pub fn (ctx Context) arg_v_scalar(index int) !VScalarValue {
	return VScalarValue.from_zval(ctx.arg_val(index))
}

pub fn (ctx Context) arg_v_scalar_opt(index int) ?VScalarValue {
	return VScalarValue.from_zval(ctx.arg_val(index)) or { return none }
}

pub fn (ctx Context) arg_array(index int) ?PhpArray {
	return ctx.arg_at(index).array()
}

pub fn (ctx Context) arg_object(index int) ?PhpObject {
	return ctx.arg_at(index).object()
}

pub fn (ctx Context) arg_callable(index int) ?PhpCallable {
	return ctx.arg_at(index).callable()
}

pub fn (ctx Context) arg_resource(index int) ?PhpResource {
	return ctx.arg_at(index).resource()
}

pub fn (ctx Context) arg_reference(index int) ?PhpReference {
	return ctx.arg_at(index).reference()
}

pub fn (ctx Context) arg_iterable(index int) ?PhpIterable {
	return ctx.arg_at(index).iterable()
}

pub fn (ctx Context) arg_iterator(index int) ?PhpIterator {
	return ctx.arg_at(index).iterator()
}

pub fn (ctx Context) arg_iterator_aggregate(index int) ?PhpIteratorAggregate {
	return ctx.arg_at(index).iterator_aggregate()
}

pub fn (ctx Context) arg_throwable(index int) ?PhpThrowable {
	return ctx.arg_at(index).throwable()
}

pub fn (ctx Context) arg_enum_case(index int) ?PhpEnumCase {
	return ctx.arg_at(index).enum_case()
}

pub fn (ctx Context) arg_owned_request_zbox(index int) RequestOwnedZBox {
	return ctx.arg_at(index).request_owned_zbox()
}

pub fn (ctx Context) arg_owned_persistent_zbox(index int) PersistentOwnedZBox {
	return ctx.arg_at(index).persistent_owned_zbox()
}

pub fn (ctx Context) arg[T](index int) T {
	return ctx.ex.v_arg[T](index)
}

pub fn (ctx Context) arg_opt[T](index int) ?T {
	return ctx.ex.v_arg_opt[T](index)
}

pub fn (ctx Context) arg_val(index int) ZVal {
	return ctx.ex.arg_or_null(index)
}

pub fn (ctx Context) arg_raw_obj(index int) voidptr {
	return ctx.arg_at(index).raw_obj()
}
