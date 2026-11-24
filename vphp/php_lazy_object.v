module vphp

import vphp.zend

pub fn php_lazy_objects_supported() bool {
	return zend.lazy_objects_supported()
}

// new_lazy_ghost returns an owned native ghost. PHP passes it to the
// initializer, which fills in its properties in place.
pub fn (c PhpClass) new_lazy_ghost(initializer PhpCallable) !PhpObject {
	return call_lazy_reflection('newLazyGhost', PhpString.of(c.name()), initializer)
}

// new_lazy_proxy returns an owned native proxy. PHP expects its initializer
// to return a compatible object to back the proxy.
pub fn (c PhpClass) new_lazy_proxy(initializer PhpCallable) !PhpObject {
	return call_lazy_reflection('newLazyProxy', PhpString.of(c.name()), initializer)
}

pub fn (o PhpObject) is_uninitialized_lazy() bool {
	return o.value.with_request_zval(fn (z ZVal) bool {
		return zend.object_is_uninitialized_lazy(z.raw)
	})
}

// initialize_lazy returns an owned handle to the initialized instance.
pub fn (o PhpObject) initialize_lazy() !PhpObject {
	mut receiver := o.to_request_owned()
	defer {
		receiver.release()
	}
	return call_lazy_reflection('initializeLazyObject', receiver, receiver)
}

// ReflectionClass supplies Zend's class and initializer validation and
// preserves the native exception if validation or initialization fails.
fn call_lazy_reflection(method string, target PhpArgInput, argument PhpArgInput) !PhpObject {
	if !php_lazy_objects_supported() {
		return error('native lazy objects require PHP 8.4 or newer')
	}
	mut reflection := PhpClass.named('ReflectionClass').construct(target)!
	defer {
		reflection.release()
	}
	mut value := reflection.call_method(method, argument)
	if has_exception() || !value.is_object() {
		value.release()
		return error('PHP ReflectionClass::${method}() failed')
	}
	result := value.take_zval()
	return PhpObject.adopt_zval(result) or { error('could not adopt lazy object result') }
}
