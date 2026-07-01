import rt

struct Class_WC_REST_Coupons_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Coupons_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := this.Class_WC_REST_Coupons_V2_Controller.prepare_objects_query(var_request.dup())
	var_args.array_set('post_status', var_request.array_get('status'))
	if !(!rt.is_true(var_request.array_get('code'))) {
		mut var_id := rt.call_function('wc_get_coupon_id_by_code', [var_request.array_get('code')])
		var_args.array_set('post__in', rt.create_array([rt.ArrayItem{ key: none, val: var_id }]))
	}
	var_args.array_set('fields', 'ids')
	return var_args.dup()
}

struct Class_WC_REST_Coupons_V2_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_coupons_controller() &Class_WC_REST_Coupons_Controller {
	mut obj := &Class_WC_REST_Coupons_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_coupons_v2_controller() &Class_WC_REST_Coupons_V2_Controller {
	mut obj := &Class_WC_REST_Coupons_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Coupons_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Coupons_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Coupons_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Coupons_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Coupons_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Coupons_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_coupons_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
