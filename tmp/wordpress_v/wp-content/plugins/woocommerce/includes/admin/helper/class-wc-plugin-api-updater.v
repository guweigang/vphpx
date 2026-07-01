import rt

struct Class_WC_Plugin_Api_Updater {
	rt.PhpObjectBase
}

fn Class_WC_Plugin_Api_Updater.load()  {
	rt.call_function('add_filter', [rt.new_string('plugins_api'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'plugins_api' }]), rt.new_int(20), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('themes_api'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'themes_api' }]), rt.new_int(20), rt.new_int(3)])
}

fn Class_WC_Plugin_Api_Updater.plugins_api(var_response rt.PhpVal, var_action rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_response_mutated.dup()
	}
	return Class_WC_Plugin_Api_Updater.override_products_api_response(var_response_mutated.dup(), var_action.dup(), var_args.dup())
}

fn Class_WC_Plugin_Api_Updater.themes_api(var_response rt.PhpVal, var_action rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_response_mutated.dup()
	}
	return Class_WC_Plugin_Api_Updater.override_products_api_response(var_response_mutated.dup(), var_action.dup(), var_args.dup())
}

fn Class_WC_Plugin_Api_Updater.override_products_api_response(var_response rt.PhpVal, var_action rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	if !rt.is_true(rt.get_property(var_args, 'slug')) {
		return var_response_mutated.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_response_mutated.dup()
	}
	mut var_clean_slug := rt.call_function('str_replace', [rt.new_string('woocommerce-com-'), rt.new_string(''), rt.get_property(var_args, 'slug')])
	mut var_update_data := fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.get_update_data() }()
	mut var_products := rt.call_function('wp_list_filter', [var_update_data.dup(), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_clean_slug }])])
	if !rt.is_true(var_products) {
		return var_response_mutated.dup()
	}
	mut var_product_id := rt.func_array_keys(var_products.dup())
	var_product_id = rt.call_function('array_shift', [var_product_id.dup()])
	mut var_is_site_connected := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }()
	mut var_endpoint := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.call_function('absint', [var_product_id.dup()]) }]), rt.new_string('info')])
	mut var_request := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_API{}; return temp.get(arg_0, arg_1) }(var_endpoint.dup(), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: var_is_site_connected }]))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_request.dup()])) && rt.is_true(var_is_site_connected))) {
		var_request = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_API{}; return temp.get(arg_0) }(var_endpoint.dup())
	}
	mut var_results := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.dup()]), rt.new_bool(true)])
	if !(!rt.is_true(var_results)) {
		var_response_mutated = // unsupported expression: Expr_Cast_Object
	}
	return var_response_mutated.dup()
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

fn create_wc_plugin_api_updater() &Class_WC_Plugin_Api_Updater {
	mut obj := &Class_WC_Plugin_Api_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_updater() &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_api() &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Plugin_Api_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Plugin_Api_Updater.load()
			return rt.new_null()
		}
		'plugins_api' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Plugin_Api_Updater.plugins_api(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'themes_api' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Plugin_Api_Updater.themes_api(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'override_products_api_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Plugin_Api_Updater.override_products_api_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WC_Plugin_Api_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Plugin_Api_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_class_wc_plugin_api_updater_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	Class_WC_Plugin_Api_Updater.load()
}
