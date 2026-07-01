import rt

fn woocommerce_register_additional_checkout_field(var_options rt.PhpVal) {
	mut var_woocommerce_blocks_loaded_ran := rt.call_function('did_action', [
		rt.new_string('woocommerce_blocks_loaded'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_woocommerce_blocks_loaded_ran)))) {
		closure_1_fn := fn [var_options] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			woocommerce_register_additional_checkout_field(var_options.dup())
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('woocommerce_blocks_loaded'),
			rt.new_closure(closure_1_fn)])
		return rt.new_null()
	}
	mut var_checkout_fields := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
	mut var_result := rt.call_method(var_checkout_fields, 'register_checkout_field', [
		var_options.dup(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_attr', [
			rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
		]))))
	}
}

fn __experimental_woocommerce_blocks_register_checkout_field(var_options rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string(@FN),
		rt.new_string('8.9.0'), rt.new_string('woocommerce_register_additional_checkout_field')])
	woocommerce_register_additional_checkout_field(var_options.dup())
}

fn __internal_woocommerce_blocks_deregister_checkout_field(var_field_id rt.PhpVal) {
	mut var_checkout_fields := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
	mut var_result := rt.call_method(var_checkout_fields, 'deregister_checkout_field', [
		var_field_id.dup(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_attr', [
			rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
		]))))
	}
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
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

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_register_additional_checkout_field'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('__experimental_woocommerce_blocks_register_checkout_field'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('__internal_woocommerce_blocks_deregister_checkout_field'),
	])))))
	{
	}
}
