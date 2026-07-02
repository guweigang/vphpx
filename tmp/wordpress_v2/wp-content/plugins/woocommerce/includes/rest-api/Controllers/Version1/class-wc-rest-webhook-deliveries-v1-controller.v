import rt

struct Class_WC_REST_Webhook_Deliveries_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('webhooks/(?P<webhook_id>[\\d]+)/deliveries')
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'webhook_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the webhook.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhook_Deliveries_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhook_Deliveries_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhook_Deliveries_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'webhook_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the webhook.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhook_Deliveries_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhook_Deliveries_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhook_Deliveries_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot view this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_webhook := rt.call_function('wc_get_webhook', [
		rt.new_int((var_request.array_get(rt.new_string('webhook_id'))).to_i64()),
	])
	if !rt.is_true(var_webhook) || var_webhook.clone().is_null() {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_webhook_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid webhook ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_logs := rt.new_array()
	mut var_data := rt.new_array()
	mut iter_1 := var_logs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_log := item_1.val
		mut var_delivery := this.prepare_item_for_response(rt.new_object('stdClass', []string{},
			rt.array_to_object(var_log)), var_request.clone())
		var_delivery = this.prepare_response_for_collection(var_delivery.clone())
		var_data.array_push(var_delivery.clone())
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_webhook := rt.call_function('wc_get_webhook', [
		rt.new_int((var_request.array_get(rt.new_string('webhook_id'))).to_i64()),
	])
	if !rt.is_true(var_webhook) || var_webhook.clone().is_null() {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_webhook_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid webhook ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_log := rt.new_array()
	if !rt.is_true(var_id) || !rt.is_true(var_log) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid resource ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_delivery := this.prepare_item_for_response(rt.new_object('stdClass', []string{},
		rt.array_to_object(var_log)), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_delivery.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) prepare_item_for_response(var_log rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_log_mutated := var_log
	mut var_data := rt.cast_array(var_log_mutated)
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_log_mutated.clone())])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_webhook_delivery'),
		var_response.clone(),
		var_log_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) prepare_links(var_log rt.PhpVal) rt.PhpVal {
	mut var_log_mutated := var_log
	mut var_webhook_id :=
		rt.new_int((rt.get_property(var_log_mutated, 'request_headers').array_get(rt.new_string('X-WC-Webhook-ID'))).to_i64())
	mut var_base := rt.call_function('str_replace', [
		rt.new_string('(?P<webhook_id>[\\d]+)'),
		var_webhook_id.clone(),
		this.rest_base,
	])
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
					var_base.clone(), rt.get_property(var_log_mutated, 'id')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, var_base.clone()]),
			])
		}
		'up':         {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/webhooks/%d'), this.namespace,
					var_webhook_id.clone()]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('webhook_delivery')
		'type':       rt.new_string('object')
		'properties': {
			'id':               {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'duration':         {
				'description': rt.call_function('__', [
					rt.new_string('The delivery duration, in seconds.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'summary':          {
				'description': rt.call_function('__', [
					rt.new_string('A friendly summary of the response including the HTTP response code, message, and body.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'request_url':      {
				'description': rt.call_function('__', [
					rt.new_string('The URL where the webhook was delivered.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('uri')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'request_headers':  {
				'description': rt.call_function('__', [rt.new_string('Request headers.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type': rt.new_string('string')
				}
			}
			'request_body':     {
				'description': rt.call_function('__', [rt.new_string('Request body.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'response_code':    {
				'description': rt.call_function('__', [
					rt.new_string('The HTTP response code from the receiving server.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'response_message': {
				'description': rt.call_function('__', [
					rt.new_string('The HTTP response message from the receiving server.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'response_headers': {
				'description': rt.call_function('__', [
					rt.new_string('Array of the response headers from the receiving server.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type': rt.new_string('string')
				}
			}
			'response_body':    {
				'description': rt.call_function('__', [
					rt.new_string('The response body from the receiving server.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created':     {
				'description': rt.call_function('__', [
					rt.new_string("The date the webhook delivery was logged, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_webhook_deliveries_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Webhook_Deliveries_V1_Controller {
	mut obj := &Class_WC_REST_Webhook_Deliveries_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('webhooks/(?P<webhook_id>[\\d]+)/deliveries')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Webhook_Deliveries_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Webhook_Deliveries_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
