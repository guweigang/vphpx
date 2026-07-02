import rt

struct Class_WC_REST_Payment_Gateways_V2_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v2')
	rest_base rt.PhpVal = rt.new_string('payment_gateways')
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
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
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('payment_gateways'),
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

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('payment_gateways'),
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

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) update_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('payment_gateways'),
		rt.new_string('edit'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
	mut var_data := rt.new_array()
	mut iter_1 := var_payment_gateways.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_payment_gateway := item_1.val
		mut var_payment_gateway_id := item_1.key
		rt.set_property(var_payment_gateway, 'id', var_payment_gateway_id.clone())
		mut var_gateway := this.prepare_item_for_response(var_payment_gateway.clone(),
			var_request.clone())
		var_gateway = this.prepare_response_for_collection(var_gateway.clone())
		var_data.array_push(var_gateway.clone())
	}
	mut var_total := rt.new_int(var_data.clone().array_count())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total.to_i64())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(if rt.is_true(var_total) { 1 } else { 0 })])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_gateway := this.get_gateway(var_request.clone())
	if rt.is_true(rt.new_bool(var_gateway.clone().is_null())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_payment_gateway_invalid'), rt.call_function('__', [
			rt.new_string('Resource does not exist.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	var_gateway = this.prepare_item_for_response(var_gateway.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_gateway.clone()])
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_gateway := this.get_gateway(var_request.clone())
	if rt.is_true(rt.new_bool(var_gateway.clone().is_null())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_payment_gateway_invalid'), rt.call_function('__', [
			rt.new_string('Resource does not exist.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_method(var_gateway, 'init_form_fields', []rt.PhpVal{})
	mut var_settings := rt.get_property(var_gateway, 'settings')
	if var_request.array_isset(rt.new_string('settings')) {
		mut var_errors_found := rt.new_bool(false)
		mut iter_2 := rt.get_property(var_gateway, 'form_fields').iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			mut var_key := item_2.key
			if var_request.array_get(rt.new_string('settings')).array_isset(var_key) {
				if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
							'WC_REST_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'validate_setting_' +
							(var_field.array_get(rt.new_string('type'))).str() + '_field' },
					]),
				]))
				{
					mut var_value := rt.call_method(rt.new_object('WC_REST_Payment_Gateways_V2_Controller', [
						'WC_REST_Controller',
					], &this), 'validate_setting_' +
						(var_field.array_get(rt.new_string('type'))).str() + '_field', [
						var_request.array_get(rt.new_string('settings')).array_get(var_key),
						var_field.clone(),
					])
				} else {
					var_value = this.validate_setting_text_field(var_request.array_get(rt.new_string('settings')).array_get(var_key),
						var_field.clone())
				}
				if rt.is_true(rt.call_function('is_wp_error', [
					var_value.clone()]))
				{
					var_errors_found = rt.new_bool(true)
					break
				}
				var_settings.array_set(var_key, var_value.clone())
			}
		}
		if rt.is_true(var_errors_found) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [
				rt.new_string('An invalid setting value was passed.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	if var_request.array_isset(rt.new_string('enabled')) {
		var_settings.array_set('enabled', rt.call_function('wc_bool_to_string', [
			var_request.array_get(rt.new_string('enabled')),
		]))
		rt.set_property(var_gateway, 'enabled', var_settings.array_get(rt.new_string('enabled')))
	}
	if var_request.array_isset(rt.new_string('title')) {
		var_settings.array_set('title', this.validate_setting_text_field(var_request.array_get(rt.new_string('title')), if !(rt.get_property(var_gateway,
			'form_fields').array_get(rt.new_string('title'))).is_null() {
			rt.get_property(var_gateway, 'form_fields').array_get(rt.new_string('title'))
		} else {
			rt.new_array()
		}))
		rt.set_property(var_gateway, 'title', var_settings.array_get(rt.new_string('title')))
	}
	if var_request.array_isset(rt.new_string('description')) {
		var_settings.array_set('description', this.validate_setting_text_field(var_request.array_get(rt.new_string('description')), if !(rt.get_property(var_gateway,
			'form_fields').array_get(rt.new_string('description'))).is_null() {
			rt.get_property(var_gateway, 'form_fields').array_get(rt.new_string('description'))
		} else {
			rt.new_array()
		}))
		rt.set_property(var_gateway, 'description',
			var_settings.array_get(rt.new_string('description')))
	}
	rt.set_property(var_gateway, 'settings', var_settings.clone())
	rt.call_function('update_option', [
		rt.call_method(var_gateway, 'get_option_key', []rt.PhpVal{}),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_gateway_' + (rt.get_property(var_gateway, 'id')).str() +
				'_settings_values'),
			var_settings.clone(),
			var_gateway.clone(),
		]),
	])
	if var_request.array_isset(rt.new_string('order')) {
		mut var_order := rt.cast_array(rt.call_function('get_option', [
			rt.new_string('woocommerce_gateway_order'),
		]))
		var_order.array_set(rt.get_property(var_gateway, 'id'), rt.call_function('absint', [
			var_request.array_get(rt.new_string('order')),
		]))
		rt.call_function('update_option', [rt.new_string('woocommerce_gateway_order'),
			var_order.clone()])
		rt.set_property(var_gateway, 'order', rt.call_function('absint', [
			var_request.array_get(rt.new_string('order')),
		]))
	}
	var_gateway = this.prepare_item_for_response(var_gateway.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_gateway.clone()])
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_gateway(var_request rt.PhpVal) rt.PhpVal {
	mut var_gateway := rt.new_null()
	mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
	mut iter_3 := var_payment_gateways.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_payment_gateway := item_3.val
		mut var_payment_gateway_id := item_3.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request.array_get(rt.new_string('id')),
			var_payment_gateway_id))))
		{
			continue
		}
		rt.set_property(var_payment_gateway, 'id', var_payment_gateway_id.clone())
		var_gateway = var_payment_gateway.clone()
	}
	return var_gateway.clone()
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) prepare_item_for_response(var_gateway rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_gateway_mutated := var_gateway
	mut var_order := rt.cast_array(rt.call_function('get_option', [
		rt.new_string('woocommerce_gateway_order'),
	]))
	mut var_item := {
		'id':                 rt.get_property(var_gateway_mutated, 'id')
		'title':              rt.get_property(var_gateway_mutated, 'title')
		'description':        rt.get_property(var_gateway_mutated, 'description')
		'order':              if var_order.array_isset(rt.get_property(var_gateway_mutated, 'id')) {
			var_order.array_get(rt.get_property(var_gateway_mutated, 'id'))
		} else {
			rt.new_string('')
		}
		'enabled':            rt.identical(rt.new_string('yes'), rt.get_property(var_gateway_mutated,
			'enabled'))
		'method_title':       rt.call_method(var_gateway_mutated, 'get_method_title', []rt.PhpVal{})
		'method_description': rt.call_method(var_gateway_mutated, 'get_method_description',
			[]rt.PhpVal{})
		'settings':           this.get_settings(var_gateway_mutated.clone())
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	mut var_data := this.add_additional_fields_to_object(var_item.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_gateway_mutated.clone(), var_request.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_payment_gateway'),
		var_response.clone(),
		var_gateway_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_settings(var_gateway rt.PhpVal) rt.PhpVal {
	mut var_gateway_mutated := var_gateway
	mut var_settings := rt.new_array()
	rt.call_method(var_gateway_mutated, 'init_form_fields', []rt.PhpVal{})
	mut iter_4 := rt.get_property(var_gateway_mutated, 'form_fields').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_field := item_4.val
		mut var_id := item_4.key
		if !rt.is_true(var_field.array_get(rt.new_string('title')))
			|| !rt.is_true(var_field.array_get(rt.new_string('type'))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('title'),
			var_field.array_get(rt.new_string('type'))))
		{
			continue
		}
		if rt.is_true(rt.call_function('in_array', [var_id.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'enabled' },
				rt.ArrayItem{ key: none, val: 'description' }]),
			rt.new_bool(true)]))
		{
			continue
		}
		mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: var_id },
			rt.ArrayItem{
				key: 'label'
				val: if !rt.is_true(var_field.array_get(rt.new_string('label'))) {
					var_field.array_get(rt.new_string('title'))
				} else {
					var_field.array_get(rt.new_string('label'))
				}
			}, rt.ArrayItem{
				key: 'description'
				val: if !rt.is_true(var_field.array_get(rt.new_string('description'))) {
					rt.new_string('')
				} else {
					var_field.array_get(rt.new_string('description'))
				}
			}, rt.ArrayItem{ key: 'type', val: var_field.array_get(rt.new_string('type')) },
			rt.ArrayItem{
				key: 'value'
				val: if !rt.is_true(rt.get_property(var_gateway_mutated, 'settings').array_get(var_id)) {
					rt.new_string('')
				} else {
					rt.get_property(var_gateway_mutated, 'settings').array_get(var_id)
				}
			}, rt.ArrayItem{
				key: 'default'
				val: if !rt.is_true(var_field.array_get(rt.new_string('default'))) {
					rt.new_string('')
				} else {
					var_field.array_get(rt.new_string('default'))
				}
			}, rt.ArrayItem{
				key: 'tip'
				val: if !rt.is_true(var_field.array_get(rt.new_string('description'))) {
					rt.new_string('')
				} else {
					var_field.array_get(rt.new_string('description'))
				}
			}, rt.ArrayItem{
				key: 'placeholder'
				val: if !rt.is_true(var_field.array_get(rt.new_string('placeholder'))) {
					rt.new_string('')
				} else {
					var_field.array_get(rt.new_string('placeholder'))
				}
			}])
		if !(!rt.is_true(var_field.array_get(rt.new_string('options')))) {
			var_data.array_set('options', var_field.array_get(rt.new_string('options')))
		}
		var_settings.array_set(var_id, var_data.clone())
	}
	return var_settings.clone()
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) prepare_links(var_gateway rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_gateway_mutated := var_gateway
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), this.namespace, this.rest_base,
					rt.get_property(var_gateway_mutated, 'id')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('payment_gateway')
		'type':       rt.new_string('object')
		'properties': {
			'id':                 {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway ID.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'title':              {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway title on checkout.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'description':        {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway description on checkout.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'order':              {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway sort order.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('absint')
				}
			}
			'enabled':            {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway enabled status.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
			}
			'method_title':       {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway method title.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'method_description': {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway method description.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'settings':           {
				'description': rt.call_function('__', [
					rt.new_string('Payment gateway settings.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'properties':  {
					'id':          {
						'description': rt.call_function('__', [
							rt.new_string('A unique identifier for the setting.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'label':       {
						'description': rt.call_function('__', [
							rt.new_string('A human readable label for the setting used in interfaces.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'description': {
						'description': rt.call_function('__', [
							rt.new_string('A human readable description for the setting used in interfaces.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'type':        {
						'description': rt.call_function('__', [
							rt.new_string('Type of setting.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'enum':        map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'value':       {
						'description': rt.call_function('__', [
							rt.new_string('Setting value.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'default':     {
						'description': rt.call_function('__', [
							rt.new_string('Default value for the setting.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'tip':         {
						'description': rt.call_function('__', [
							rt.new_string('Additional help text shown to the user about the setting.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
					'placeholder': {
						'description': rt.call_function('__', [
							rt.new_string('Placeholder text to be displayed in text inputs.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
						'readonly':    rt.new_bool(true)
					}
				}
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) get_collection_params() rt.PhpVal {
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

fn create_wc_rest_payment_gateways_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Payment_Gateways_V2_Controller {
	mut obj := &Class_WC_REST_Payment_Gateways_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
		rest_base:     rt.new_string('payment_gateways')
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

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'update_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'get_gateway' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_gateway(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_settings(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
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

fn (this &Class_WC_REST_Payment_Gateways_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
