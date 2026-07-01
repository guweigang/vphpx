import rt

struct Class_Automattic_WooCommerce_Admin_API_Coupons {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Coupons) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller.get_collection_params()
	var_params.array_set('search', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to coupons with codes matching a given string.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Coupons) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller.prepare_objects_query(var_request.dup())
	if !(!rt.is_true(var_request.array_get('search'))) {
		var_args.array_set('search', var_request.array_get('search'))
		var_args.array_set('s', false)
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Coupons) get_items(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_search_code_filter' }]), rt.new_int(10), rt.new_int(2)])
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller.get_items(var_request.dup())
	rt.call_function('remove_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_search_code_filter' }]), rt.new_int(10)])
	return var_response.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Coupons.add_wp_query_search_code_filter(var_where rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_search := rt.call_method(var_wp_query, 'get', [rt.new_string('search')])
	if rt.is_true(var_search) {
		mut var_code_like := rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_search.dup()])).str() + '%')
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_where.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_coupons() &Class_Automattic_WooCommerce_Admin_API_Coupons {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Coupons{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_coupons_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Coupons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'add_wp_query_search_code_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Coupons.add_wp_query_search_code_filter(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Coupons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Coupons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Coupons_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_coupons_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
