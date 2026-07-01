import rt

struct Class_WC_REST_Webhook_Deliveries_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V2_Controller) prepare_item_for_response(var_log rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.cast_array(var_log)
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_log.dup())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_webhook_delivery'), var_response.dup(), var_log.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('webhook_delivery'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'duration': { 'description': rt.call_function('__', [rt.new_string('The delivery duration, in seconds.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'summary': { 'description': rt.call_function('__', [rt.new_string('A friendly summary of the response including the HTTP response code, message, and body.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'request_url': { 'description': rt.call_function('__', [rt.new_string('The URL where the webhook was delivered.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'request_headers': { 'description': rt.call_function('__', [rt.new_string('Request headers.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'request_body': { 'description': rt.call_function('__', [rt.new_string('Request body.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'response_code': { 'description': rt.call_function('__', [rt.new_string('The HTTP response code from the receiving server.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'response_message': { 'description': rt.call_function('__', [rt.new_string('The HTTP response message from the receiving server.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'response_headers': { 'description': rt.call_function('__', [rt.new_string('Array of the response headers from the receiving server.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'response_body': { 'description': rt.call_function('__', [rt.new_string('The response body from the receiving server.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the webhook delivery was logged, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the webhook delivery was logged, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Webhook_Deliveries_V1_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_webhook_deliveries_v2_controller() &Class_WC_REST_Webhook_Deliveries_V2_Controller {
	mut obj := &Class_WC_REST_Webhook_Deliveries_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
	}
	return obj
}

fn create_wc_rest_webhook_deliveries_v1_controller() &Class_WC_REST_Webhook_Deliveries_V1_Controller {
	mut obj := &Class_WC_REST_Webhook_Deliveries_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Webhook_Deliveries_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Webhook_Deliveries_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_webhook_deliveries_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
