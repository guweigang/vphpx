import rt

struct Class_WC_REST_Payment_Gateways_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Payment_Gateways_Controller) prepare_item_for_response(var_gateway rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_order := rt.cast_array(rt.call_function('get_option', [
		rt.new_string('woocommerce_gateway_order'),
	]))
	mut var_item := {
		'id':                 rt.get_property(var_gateway, 'id')
		'title':              rt.get_property(var_gateway, 'title')
		'description':        rt.get_property(var_gateway, 'description')
		'order':              if var_order.array_isset(rt.get_property(var_gateway, 'id')) {
			var_order.array_get(rt.get_property(var_gateway, 'id'))
		} else {
			rt.new_string('')
		}
		'enabled':            rt.identical(rt.new_string('yes'), rt.get_property(var_gateway,
			'enabled'))
		'method_title':       rt.call_method(var_gateway, 'get_method_title', []rt.PhpVal{})
		'method_description': rt.call_method(var_gateway, 'get_method_description', []rt.PhpVal{})
		'method_supports':    rt.get_property(var_gateway, 'supports')
		'settings':           this.get_settings(var_gateway.clone())
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
		this.prepare_links(var_gateway.clone(), var_request.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_payment_gateway'),
		var_response.clone(),
		var_gateway.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Payment_Gateways_Controller) get_settings(var_gateway rt.PhpVal) rt.PhpVal {
	mut var_settings := rt.new_array()
	rt.call_method(var_gateway, 'init_form_fields', []rt.PhpVal{})
	mut iter_1 := rt.get_property(var_gateway, 'form_fields').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_id := item_1.key
		if !rt.is_true(var_field.array_get(rt.new_string('title')))
			|| !rt.is_true(var_field.array_get(rt.new_string('type'))) {
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
				val: if !rt.is_true(rt.get_property(var_gateway, 'settings').array_get(var_id)) {
					rt.new_string('')
				} else {
					rt.get_property(var_gateway, 'settings').array_get(var_id)
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

fn (mut this Class_WC_REST_Payment_Gateways_Controller) get_item_schema() rt.PhpVal {
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
			'method_supports':    {
				'description': rt.call_function('__', [
					rt.new_string('Supported features for this payment gateway.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type': rt.new_string('string')
				}
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

fn (mut this Class_WC_REST_Payment_Gateways_Controller) validate_setting_multiselect_field(var_values rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_values) {
		return rt.new_array()
	}
	if !(var_values.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_setting_value_invalid'), rt.call_function('__', [
			rt.new_string('An invalid setting value was passed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_valid_keys :=
		this.flatten_options_keys(mut rt.cast_object_ptr[Class_array](var_setting.array_get(rt.new_string('options'))))
	mut var_final_values := rt.new_array()
	mut iter_2 := var_values.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		if rt.is_true(rt.call_function('in_array', [var_value.clone(),
			var_valid_keys.clone(), rt.new_bool(true)]))
		{
			var_final_values << var_value.clone()
		}
	}
	return var_final_values.clone()
}

fn (mut this Class_WC_REST_Payment_Gateways_Controller) flatten_options_keys(mut var_options Class_array) rt.PhpVal {
	mut var_keys := rt.new_array()
	mut iter_3 := var_options.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_keys = rt.call_function('array_merge', [var_keys.clone(),
				this.flatten_options_keys(mut rt.cast_object_ptr[Class_array](var_value))])
		} else {
			var_keys.array_push(var_key.clone())
		}
	}
	return var_keys.clone()
}

struct Class_WC_REST_Payment_Gateways_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_payment_gateways_controller(_args ...rt.PhpVal) &Class_WC_REST_Payment_Gateways_Controller {
	mut obj := &Class_WC_REST_Payment_Gateways_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_payment_gateways_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Payment_Gateways_V2_Controller {
	mut obj := &Class_WC_REST_Payment_Gateways_V2_Controller{
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

fn (mut this Class_WC_REST_Payment_Gateways_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_settings(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'validate_setting_multiselect_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_multiselect_field(dispatch_arg_0, dispatch_arg_1)
		}
		'flatten_options_keys' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.flatten_options_keys(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Payment_Gateways_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Payment_Gateways_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Payment_Gateways_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Payment_Gateways_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
