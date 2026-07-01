import rt

struct Class_WC_REST_Reports_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('reports')
}

fn (mut this Class_WC_REST_Reports_V1_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Reports_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Reports_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Reports_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Reports_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('reports'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Reports_V1_Controller) get_reports() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'sales' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of sales reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'top_sellers' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of top sellers products.'), rt.new_string('woocommerce')]) }]) }])
}

fn (mut this Class_WC_REST_Reports_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_reports := this.get_reports()
	{
		mut iter_1 := var_reports.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_report := item_1.val
			mut var_item := this.prepare_item_for_response(// unsupported expression: Expr_Cast_Object, var_request.dup())
			var_data.array_push(this.prepare_response_for_collection(var_item.dup()))
		}
	}
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WC_REST_Reports_V1_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.get_property(var_report, 'slug') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_report, 'description') }])
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), this.namespace, this.rest_base, rt.get_property(var_report, 'slug')])]) }]) }, rt.ArrayItem{ key: 'collection', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), this.namespace, this.rest_base])]) }]) }])])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report'), var_response.dup(), var_report.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Reports_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('report'), 'type': rt.new_string('object'), 'properties': { 'slug': { 'description': rt.call_function('__', [rt.new_string('An alphanumeric identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'description': { 'description': rt.call_function('__', [rt.new_string('A human-readable description of the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_WC_REST_Reports_V1_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_reports_v1_controller() &Class_WC_REST_Reports_V1_Controller {
	mut obj := &Class_WC_REST_Reports_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('reports')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn (mut this Class_WC_REST_Reports_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_reports' {
			return this.get_reports()
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Reports_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Reports_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version1_class_wc_rest_reports_v1_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
