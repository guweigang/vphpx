import rt

struct Class_WC_REST_Webhooks_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
}

fn (mut this Class_WC_REST_Webhooks_V2_Controller) prepare_item_for_response(var_id rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_webhook := rt.call_function('wc_get_webhook', [var_id.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_webhook) || rt.is_true(rt.new_bool(var_webhook.dup().is_null())))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_Webhooks_V2_Controller', ['WC_REST_Webhooks_V1_Controller'], &this), 'post_type')), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('ID is invalid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_method(var_webhook, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_webhook, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'topic', val: rt.call_method(var_webhook, 'get_topic', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'resource', val: rt.call_method(var_webhook, 'get_resource', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'event', val: rt.call_method(var_webhook, 'get_event', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'hooks', val: rt.call_method(var_webhook, 'get_hooks', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'delivery_url', val: rt.call_method(var_webhook, 'get_delivery_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_webhook, 'get_date_created', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_webhook, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_webhook, 'get_date_modified', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_webhook, 'get_date_modified', []rt.PhpVal{})]) }])
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}), var_request.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('woocommerce_rest_prepare_'), rt.get_property(rt.new_object('WC_REST_Webhooks_V2_Controller', ['WC_REST_Webhooks_V1_Controller'], &this), 'post_type')), var_response.dup(), var_webhook.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Webhooks_V2_Controller) get_default_api_version() string {
	return 'wp_api_v2'
}

fn (mut this Class_WC_REST_Webhooks_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('webhook'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('A friendly name for the webhook.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'status': { 'description': rt.call_function('__', [rt.new_string('Webhook status.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': rt.new_string('active'), 'enum': rt.func_array_keys(rt.call_function('wc_get_webhook_statuses', []rt.PhpVal{})), 'context': map[string]rt.PhpVal{} }, 'topic': { 'description': rt.call_function('__', [rt.new_string('Webhook topic.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'resource': { 'description': rt.call_function('__', [rt.new_string('Webhook resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'event': { 'description': rt.call_function('__', [rt.new_string('Webhook event.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'hooks': { 'description': rt.call_function('__', [rt.new_string('WooCommerce action names associated with the webhook.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'items': { 'type': rt.new_string('string') } }, 'delivery_url': { 'description': rt.call_function('__', [rt.new_string('The URL where the webhook payload is delivered.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'secret': { 'description': rt.call_function('__', [rt.new_string('Secret key used to generate a hash of the delivered webhook and provided in the request headers. This will default to a MD5 hash from the current user\'s ID|username if not provided.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the webhook was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the webhook was created, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified': { 'description': rt.call_function('__', [rt.new_string('The date the webhook was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the webhook was last modified, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Webhooks_V1_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_webhooks_v2_controller() &Class_WC_REST_Webhooks_V2_Controller {
	mut obj := &Class_WC_REST_Webhooks_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
	}
	return obj
}

fn create_wc_rest_webhooks_v1_controller() &Class_WC_REST_Webhooks_V1_Controller {
	mut obj := &Class_WC_REST_Webhooks_V1_Controller{
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

fn (mut this Class_WC_REST_Webhooks_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_default_api_version' {
			return rt.new_string(this.get_default_api_version())
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Webhooks_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Webhooks_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Webhooks_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Webhooks_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_webhooks_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
