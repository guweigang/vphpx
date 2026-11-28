module vphp

pub fn (o PhpObject) method_zval(method string, args []ZVal) ZVal {
	return o.value.with_request_object[ZVal](fn [method, args] (obj PhpObject) ZVal {
		return obj.to_zval().method(method, args)
	}) or { invalid_zval() }
}

pub fn (o PhpObject) method_owned_request(method string, args []ZVal) ZVal {
	mut obj := o.to_request_owned()
	defer { obj.release() }
	if !obj.is_valid() { return invalid_zval() }
	return obj.to_zval().method_owned_request(method, args)
}

pub fn (o PhpObject) method_owned_persistent(method string, args []ZVal) ZVal {
	return o.value.with_request_object[ZVal](fn [method, args] (obj PhpObject) ZVal {
		return obj.to_zval().method_owned_persistent(method, args)
	}) or { invalid_zval() }
}

fn (o PhpObject) method_request_owned_zval(method string, args []ZVal) RequestOwnedZBox {
	return RequestOwnedZBox.adopt_zval(o.method_owned_request(method, args))
}

fn (o PhpObject) method_request_owned(method string, args ...PhpArgInput) RequestOwnedZBox {
	return o.method_request_owned_zval(method, php_arg_inputs_to_zvals(args))
}

pub fn (o PhpObject) call_method(method string, args ...PhpArgInput) PhpValue {
	mut result := o.method_request_owned(method, ...args)
	return result.take_value()
}

// call_method_by_value returns an owned snapshot of the method result.
// A PHP reference is dereferenced at the top level. PHP objects keep their identity.
pub fn (o PhpObject) call_method_by_value(method string, args ...PhpArgInput) PhpValue {
	mut result := o.call_method(method, ...args)
	return PhpValue.adopt_zval(result.take_zval_by_value())
}

fn (o PhpObject) method_request_owned_args(method string, args PhpArray) RequestOwnedZBox {
	return o.value.with_request_object[RequestOwnedZBox](fn [method, args] (obj PhpObject) RequestOwnedZBox {
		mut callback := PhpArray.new()
		mut name := PhpString.of(method)
		defer {
			callback.release()
			name.release()
		}
		callback.next(obj)
		callback.next(name)
		return PhpCallable.borrowed(callback.to_zval()).request_owned_args(args)
	}) or { RequestOwnedZBox.adopt_zval(invalid_zval()) }
}

pub fn (o PhpObject) call_method_args(method string, args PhpArray) PhpValue {
	mut result := o.method_request_owned_args(method, args)
	return result.take_value()
}

pub fn (o PhpObject) method_reference_args(method string, args PhpArray) !PhpReference {
	mut result := o.method_request_owned_args(method, args)
	return php_call_reference_result(mut result)
}

pub fn (o PhpObject) with_attribute(name string, value PhpArgInput) PhpObject {
	if !o.is_valid() || !o.method_exists('withAttribute') {
		return o.to_request_owned()
	}
	mut name_arg := PhpString.of(name)
	defer {
		name_arg.release()
	}
	mut result := o.call_method('withAttribute', name_arg, value)
	return result.as_object() or {
		result.release()
		o.to_request_owned()
	}
}

pub fn (o PhpObject) method[T](method string, args ...PhpArgInput) !T {
	mut result := o.method_request_owned(method, ...args)
	defer {
		result.release()
	}
	return php_call_copied_result_as[T](result.to_zval())
}

pub fn (o PhpObject) method_reference(method string, args ...PhpArgInput) !PhpReference {
	mut result := o.method_request_owned(method, ...args)
	return php_call_reference_result(mut result)
}

pub fn (o PhpObject) with_method_result[T, R](method string, run fn (T) R, args ...PhpArgInput) !R {
	mut result := o.method_request_owned(method, ...args)
	defer {
		result.release()
	}
	return php_with_call_result[T, R](result.to_zval(), run)
}

pub fn (o PhpObject) with_method_result_zval[T](method string, run fn (ZVal) T, args ...ZVal) T {
	mut result := o.method_request_owned_zval(method, args)
	defer {
		result.release()
	}
	z := result.to_zval()
	return run(z)
}

pub fn (o PhpObject) method_v[T](method string, args []ZVal) !T {
	return o.method_zval(method, args).to_v[T]()
}
