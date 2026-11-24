module vphp

import vphp.zend

struct ZendMethodCall {
	receiver ZVal
	method   string
}

struct ZendCallableCall {
	callable ZVal
}

struct ZendCallableArgsCall {
	callable ZVal
	args     ZVal
}

struct ZendConstructCall {
	class_name ZVal
}

struct ZendConstructArgsCall {
	class_name string
	args       ZVal
}

struct ZendStaticMethodCall {
	class_name ZVal
	method     string
}

type ZendCallTarget = ZendCallableArgsCall
	| ZendCallableCall
	| ZendConstructArgsCall
	| ZendConstructCall
	| ZendMethodCall
	| ZendStaticMethodCall

fn invoke_zval_call_target(target ZendCallTarget, retval voidptr, count int, params voidptr) int {
	return match target {
		ZendMethodCall {
			zend.call_method_ptr(target.receiver.raw_ptr(), target.method, retval, count, params)
		}
		ZendCallableCall {
			zend.call_callable_ptr(target.callable.raw_ptr(), retval, count, params)
		}
		ZendCallableArgsCall {
			zend.call_callable_args_ptr(target.callable.raw_ptr(), retval, target.args.raw_ptr())
		}
		ZendConstructCall {
			class_name := target.class_name.get_string()
			zend.new_instance_named(class_name, retval, count, params)
		}
		ZendConstructArgsCall {
			zend.new_instance_args(target.class_name, retval, target.args.raw_ptr())
		}
		ZendStaticMethodCall {
			class_name := target.class_name.get_string()
			zend.call_static_method_named(class_name, target.method, retval, count, params)
		}
	}
}
