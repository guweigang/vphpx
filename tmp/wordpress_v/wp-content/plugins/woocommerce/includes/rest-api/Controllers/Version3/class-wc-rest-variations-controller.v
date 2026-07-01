import rt

struct Class_WC_REST_Variations_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('variations')
}

fn (mut this Class_WC_REST_Variations_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Variations_Controller', ['WC_REST_Product_Variations_Controller'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Variations_Controller', ['WC_REST_Product_Variations_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Variations_Controller', ['WC_REST_Product_Variations_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Variations_Controller', ['WC_REST_Product_Variations_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Variations_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := this.Class_WC_REST_Product_Variations_Controller.prepare_objects_query(var_request.dup())
	if rt.is_true(rt.identical(rt.concat(rt.concat(rt.new_string('/'), rt.get_property(rt.new_object('WC_REST_Variations_Controller', ['WC_REST_Product_Variations_Controller'], &this), 'namespace')), rt.new_string('/variations')), rt.call_method(var_request, 'get_route', []rt.PhpVal{}))) {
		var_args.array_unset(rt.new_string('post_parent'))
	}
	return var_args.dup()
}

struct Class_WC_REST_Product_Variations_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_variations_controller() &Class_WC_REST_Variations_Controller {
	mut obj := &Class_WC_REST_Variations_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('variations')
	}
	return obj
}

fn create_wc_rest_product_variations_controller() &Class_WC_REST_Product_Variations_Controller {
	mut obj := &Class_WC_REST_Product_Variations_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Variations_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Variations_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Variations_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Product_Variations_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Variations_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Variations_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_variations_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
