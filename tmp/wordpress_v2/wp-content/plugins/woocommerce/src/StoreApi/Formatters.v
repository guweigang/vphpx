import rt

struct Class_Automattic_WooCommerce_StoreApi_Formatters {
	rt.PhpObjectBase
pub mut:
	formatters rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if !(this.formatters.array_isset(var_name)) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG'))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(
				var_name.str() + ' formatter does not exist')))
		}
		return rt.new_object('Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter',
			[]string{}, create_automattic_woocommerce_storeapi_formatters_defaultformatter())
	}
	return this.formatters.array_get(var_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters) register(var_name rt.PhpVal, var_class rt.PhpVal) {
	this.formatters.array_set(var_name, rt.create_object_dynamically(var_class, []rt.PhpVal{}))
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_formatters(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Formatters {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters{
		PhpObjectBase: rt.PhpObjectBase{}
		formatters:    rt.new_array()
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_storeapi_formatters_defaultformatter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.register(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'formatters' { return this.formatters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'formatters' {
			this.formatters = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_Formatters', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_storeapi_formatters()
		return rt.new_object('Automattic_WooCommerce_StoreApi_Formatters', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_storeapi_formatters_defaultformatter()
		return rt.new_object('Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter',
			[]string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
