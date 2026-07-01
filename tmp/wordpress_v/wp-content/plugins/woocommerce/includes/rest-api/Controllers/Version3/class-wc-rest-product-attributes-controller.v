import rt

struct Class_WC_REST_Product_Attributes_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Product_Attributes_Controller) generate_unique_slug(var_attribute_name rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_root_slug := rt.call_function('wc_sanitize_taxonomy_name', [var_attribute_name.dup()])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT attribute_name FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies WHERE attribute_name LIKE %s ORDER BY attribute_id DESC LIMIT 1')), (var_root_slug).str() + '%'])])
	if !rt.is_true(var_results) {
		return (var_root_slug).str()
	}
	mut var_last_created_slug := rt.get_property(var_results.array_get(0), 'attribute_name')
	mut var_suffix := rt.new_int(rt.new_int(rt.call_function('substr', [var_last_created_slug.dup(), rt.add(rt.call_function('strrpos', [var_last_created_slug.dup(), rt.new_string('-')]), rt.new_int(1))]).to_i64()))
	return (var_root_slug).str() + '-' + (rt.add(var_suffix, rt.new_int(1))).str()
}

fn (mut this Class_WC_REST_Product_Attributes_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_generate_slug := rt.call_function('stripslashes', [var_request.array_get('generate_slug')])
	mut var_slug := rt.call_function('wc_sanitize_taxonomy_name', [rt.call_function('stripslashes', [var_request.array_get('slug')])])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_generate_slug)) && rt.is_true(rt.identical(rt.new_string('true'), var_generate_slug)))) {
		var_slug = rt.new_string(this.generate_unique_slug(var_request.array_get('name')))
	}
	mut var_id := rt.call_function('wc_create_attribute', [rt.create_array([rt.ArrayItem{ key: 'name', val: var_request.array_get('name') }, rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'type', val: if !(!rt.is_true(var_request.array_get('type'))) { var_request.array_get('type') } else { rt.new_string('select') } }, rt.ArrayItem{ key: 'order_by', val: if !(!rt.is_true(var_request.array_get('order_by'))) { var_request.array_get('order_by') } else { rt.new_string('menu_order') } }, rt.ArrayItem{ key: 'has_archives', val: rt.identical(rt.new_bool(true), var_request.array_get('has_archives')) }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_id.dup()])) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_method(var_id, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_attribute := this.get_attribute(var_id.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_attribute.dup()])) {
		return var_attribute.dup()
	}
	this.update_additional_fields_for_object(var_attribute.dup(), var_request.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_product_attribute'), var_attribute.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_attribute.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', ['/' + (this.namespace).str() + '/' + (rt.get_property(rt.new_object('WC_REST_Product_Attributes_Controller', ['WC_REST_Product_Attributes_V2_Controller'], &this), 'rest_base')).str() + '/' + (rt.get_property(var_attribute, 'attribute_id')).str()])])
	return var_response.dup()
}

struct Class_WC_REST_Product_Attributes_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_product_attributes_controller() &Class_WC_REST_Product_Attributes_Controller {
	mut obj := &Class_WC_REST_Product_Attributes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_product_attributes_v2_controller() &Class_WC_REST_Product_Attributes_V2_Controller {
	mut obj := &Class_WC_REST_Product_Attributes_V2_Controller{
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

fn (mut this Class_WC_REST_Product_Attributes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate_unique_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.generate_unique_slug(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Product_Attributes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Attributes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Product_Attributes_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Attributes_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Attributes_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_product_attributes_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
