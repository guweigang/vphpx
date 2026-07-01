import rt

fn woocommerce_store_api_register_endpoint_data(var_args rt.PhpVal) bool {
	mut var_extend := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_StoreApi{}
		return temp.container()
	}(), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema.class()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_extend, 'register_endpoint_data', [var_args.dup()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_error := var_e_1.dup()
		return (create_wp_error(rt.new_string('error'), rt.call_method(var_error, 'getMessage',
			[]rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return true
}

fn woocommerce_store_api_register_update_callback(var_args rt.PhpVal) bool {
	mut var_extend := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_StoreApi{}
		return temp.container()
	}(), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema.class()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(var_extend, 'register_update_callback', [var_args.dup()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_error := var_e_2.dup()
		return (create_wp_error(rt.new_string('error'), rt.call_method(var_error, 'getMessage',
			[]rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return true
}

fn woocommerce_store_api_register_payment_requirements(var_args rt.PhpVal) bool {
	mut var_extend := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_StoreApi{}
		return temp.container()
	}(), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema.class()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	rt.call_method(var_extend, 'register_payment_requirements', [
		var_args.dup()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_error := var_e_3.dup()
		return (create_wp_error(rt.new_string('error'), rt.call_method(var_error, 'getMessage',
			[]rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return true
}

fn woocommerce_store_api_get_formatter(var_name rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_StoreApi_StoreApi{}
		return temp.container()
	}(), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema.class()]),
		'get_formatter', [var_name.dup()])
}

struct Class_Automattic_WooCommerce_StoreApi_StoreApi {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_storeapi() &Class_Automattic_WooCommerce_StoreApi_StoreApi {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_StoreApi{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_store_api_register_endpoint_data'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_store_api_register_update_callback'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_store_api_register_payment_requirements'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_store_api_get_formatter'),
	])))))
	{
	}
}
