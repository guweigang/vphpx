import rt

struct Class_WC_REST_Customers_V2_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v2')
}

fn (mut this Class_WC_REST_Customers_V2_Controller) get_formatted_item_data(var_object rt.PhpVal) rt.PhpVal {
	mut var_formatted_data := this.get_formatted_item_data_core(var_object.clone())
	var_formatted_data.array_set('orders_count', rt.call_method(var_object, 'get_order_count',
		[]rt.PhpVal{}))
	var_formatted_data.array_set('total_spent', rt.call_method(var_object, 'get_total_spent',
		[]rt.PhpVal{}))
	return var_formatted_data.clone()
}

fn (mut this Class_WC_REST_Customers_V2_Controller) get_formatted_item_data_core(var_object rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_method(var_object, 'get_data', []rt.PhpVal{})
	mut var_format_date := ['date_created', 'date_modified']
	for var_key in var_format_date {
		mut var_datetime := if rt.is_true(rt.identical(rt.new_string('date_created'), rt.new_string(key))) && rt.is_true(rt.call_function('is_subclass_of', [var_data.array_get(rt.new_string(key)), rt.new_string('DateTime')])) { rt.call_function('get_date_from_gmt', [
				rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
					rt.call_method(var_data.array_get(rt.new_string(key)), 'getTimestamp', []rt.PhpVal{})]),
			]) } else { var_data.array_get(rt.new_string(key)) }
		var_data.array_set(key, rt.call_function('wc_rest_prepare_date_response', [
			var_datetime.clone(),
			rt.new_bool(false),
		]))
		var_data.array_set(key + '_gmt', rt.call_function('wc_rest_prepare_date_response', [
			var_datetime.clone(),
		]))
	}
	mut var_formatted_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'date_created', val: var_data.array_get(rt.new_string('date_created')) },
		rt.ArrayItem{
			key: 'date_created_gmt'
			val: var_data.array_get(rt.new_string('date_created_gmt'))
		},
		rt.ArrayItem{ key: 'date_modified', val: var_data.array_get(rt.new_string('date_modified')) },
		rt.ArrayItem{
			key: 'date_modified_gmt'
			val: var_data.array_get(rt.new_string('date_modified_gmt'))
		},
		rt.ArrayItem{ key: 'email', val: var_data.array_get(rt.new_string('email')) },
		rt.ArrayItem{ key: 'first_name', val: var_data.array_get(rt.new_string('first_name')) },
		rt.ArrayItem{ key: 'last_name', val: var_data.array_get(rt.new_string('last_name')) },
		rt.ArrayItem{ key: 'role', val: var_data.array_get(rt.new_string('role')) },
		rt.ArrayItem{ key: 'username', val: var_data.array_get(rt.new_string('username')) },
		rt.ArrayItem{ key: 'billing', val: var_data.array_get(rt.new_string('billing')) },
		rt.ArrayItem{ key: 'shipping', val: var_data.array_get(rt.new_string('shipping')) },
		rt.ArrayItem{
			key: 'is_paying_customer'
			val: var_data.array_get(rt.new_string('is_paying_customer'))
		},
		rt.ArrayItem{ key: 'avatar_url', val: rt.call_method(var_object, 'get_avatar_url',
			[]rt.PhpVal{}) },
	])
	if rt.is_true(rt.call_function('wc_current_user_has_role', [
		rt.new_string('administrator'),
	]))
	{
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!(rt.is_true(rt.call_function('is_protected_meta', [
				rt.get_property(var_meta, 'key'),
				rt.new_string('user'),
			]))))
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!(rt.is_true(rt.call_function('is_protected_meta', [
				rt.get_property(var_meta, 'key'),
				rt.new_string('user'),
			]))))
		}
		var_formatted_data.array_set('meta_data', rt.call_function('array_values', [
			rt.call_function('array_filter', [var_data.array_get(rt.new_string('meta_data')),
				rt.new_closure(closure_1_fn)]),
		]))
	}
	return var_formatted_data.clone()
}

fn (mut this Class_WC_REST_Customers_V2_Controller) prepare_item_for_response(var_user_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_customer := create_wc_customer(rt.get_property(var_user_data, 'ID'))
	mut var_data := this.get_formatted_item_data(rt.new_object('WC_Customer', []string{},
		var_customer))
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_user_data.clone())])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_customer'),
		var_response.clone(),
		var_user_data.clone(),
		var_request.clone(),
	])
	return rt.new_null()
}

fn (mut this Class_WC_REST_Customers_V2_Controller) update_customer_meta_fields(var_customer rt.PhpVal, var_request rt.PhpVal) {
	mut var_meta := map[string]rt.PhpVal{}
	mut var_customer_mutated := var_customer
	this.Class_WC_REST_Customers_V1_Controller.update_customer_meta_fields(var_customer_mutated.clone(),
		var_request.clone())
	if var_request.array_isset(rt.new_string('meta_data')) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
		mut iife_result_2 :=
			iife_temp_2.normalize(var_request.array_get(rt.new_string('meta_data')))
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!(rt.is_true(rt.call_function('is_protected_meta', [
				var_meta.array_get(rt.new_string('key')),
				rt.new_string('user'),
			]))))
		}
		mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
		mut iife_result_4 :=
			iife_temp_4.normalize(var_request.array_get(rt.new_string('meta_data')))
		mut var_meta_data := rt.call_function('array_filter', [iife_result_2,
			rt.new_closure(closure_4_fn)])
		mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
		mut iife_result_5 := iife_temp_5.update(var_meta_data.clone(), var_customer_mutated.clone())
	}
}

fn (mut this Class_WC_REST_Customers_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('customer')
		'type':       rt.new_string('object')
		'properties': {
			'id':                 {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created':       {
				'description': rt.call_function('__', [
					rt.new_string("The date the customer was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created_gmt':   {
				'description': rt.call_function('__', [
					rt.new_string('The date the customer was created, as GMT.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_modified':      {
				'description': rt.call_function('__', [
					rt.new_string("The date the customer was last modified, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_modified_gmt':  {
				'description': rt.call_function('__', [
					rt.new_string('The date the customer was last modified, as GMT.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'email':              {
				'description': rt.call_function('__', [
					rt.new_string('The email address for the customer.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('email')
				'context':     map[string]rt.PhpVal{}
			}
			'first_name':         {
				'description': rt.call_function('__', [
					rt.new_string('Customer first name.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
			}
			'last_name':          {
				'description': rt.call_function('__', [
					rt.new_string('Customer last name.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
			}
			'role':               {
				'description': rt.call_function('__', [rt.new_string('Customer role.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'username':           {
				'description': rt.call_function('__', [
					rt.new_string('Customer login name.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_user')
				}
			}
			'password':           {
				'description': rt.call_function('__', [
					rt.new_string('Customer password.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'billing':            {
				'description': rt.call_function('__', [
					rt.new_string('List of billing address data.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'properties':  {
					'first_name': {
						'description': rt.call_function('__', [
							rt.new_string('First name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'last_name':  {
						'description': rt.call_function('__', [
							rt.new_string('Last name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'company':    {
						'description': rt.call_function('__', [
							rt.new_string('Company name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'address_1':  {
						'description': rt.call_function('__', [
							rt.new_string('Address line 1'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'address_2':  {
						'description': rt.call_function('__', [
							rt.new_string('Address line 2'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'city':       {
						'description': rt.call_function('__', [
							rt.new_string('City name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'state':      {
						'description': rt.call_function('__', [
							rt.new_string('ISO code or name of the state, province or district.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'postcode':   {
						'description': rt.call_function('__', [
							rt.new_string('Postal code.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'country':    {
						'description': rt.call_function('__', [
							rt.new_string('ISO code of the country.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'email':      {
						'description': rt.call_function('__', [
							rt.new_string('Email address.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'format':      rt.new_string('email')
						'context':     map[string]rt.PhpVal{}
					}
					'phone':      {
						'description': rt.call_function('__', [
							rt.new_string('Phone number.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
				}
			}
			'shipping':           {
				'description': rt.call_function('__', [
					rt.new_string('List of shipping address data.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'properties':  {
					'first_name': {
						'description': rt.call_function('__', [
							rt.new_string('First name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'last_name':  {
						'description': rt.call_function('__', [
							rt.new_string('Last name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'company':    {
						'description': rt.call_function('__', [
							rt.new_string('Company name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'address_1':  {
						'description': rt.call_function('__', [
							rt.new_string('Address line 1'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'address_2':  {
						'description': rt.call_function('__', [
							rt.new_string('Address line 2'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'city':       {
						'description': rt.call_function('__', [
							rt.new_string('City name.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'state':      {
						'description': rt.call_function('__', [
							rt.new_string('ISO code or name of the state, province or district.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'postcode':   {
						'description': rt.call_function('__', [
							rt.new_string('Postal code.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
					'country':    {
						'description': rt.call_function('__', [
							rt.new_string('ISO code of the country.'),
							rt.new_string('woocommerce'),
						])
						'type':        rt.new_string('string')
						'context':     map[string]rt.PhpVal{}
					}
				}
			}
			'is_paying_customer': {
				'description': rt.call_function('__', [
					rt.new_string('Is the customer a paying customer?'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('bool')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'orders_count':       {
				'description': rt.call_function('__', [
					rt.new_string('Quantity of orders made by the customer.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'total_spent':        {
				'description': rt.call_function('__', [
					rt.new_string('Total amount spent.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'avatar_url':         {
				'description': rt.call_function('__', [rt.new_string('Avatar URL.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'meta_data':          {
				'description': rt.call_function('__', [rt.new_string('Meta data.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'items':       {
					'type':       rt.new_string('object')
					'properties': {
						'id':    {
							'description': rt.call_function('__', [
								rt.new_string('Meta ID.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('integer')
							'context':     map[string]rt.PhpVal{}
							'readonly':    rt.new_bool(true)
						}
						'key':   {
							'description': rt.call_function('__', [
								rt.new_string('Meta key.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('string')
							'context':     map[string]rt.PhpVal{}
						}
						'value': {
							'description': rt.call_function('__', [
								rt.new_string('Meta value.'),
								rt.new_string('woocommerce'),
							])
							'type':        rt.new_string('mixed')
							'context':     map[string]rt.PhpVal{}
						}
					}
				}
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

struct Class_WC_REST_Customers_V1_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_customers_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Customers_V2_Controller {
	mut obj := &Class_WC_REST_Customers_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
	}
	return obj
}

fn create_wc_rest_customers_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Customers_V1_Controller {
	mut obj := &Class_WC_REST_Customers_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_metadatautil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Customers_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_formatted_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_item_data(dispatch_arg_0)
		}
		'get_formatted_item_data_core' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_item_data_core(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'update_customer_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_customer_meta_fields(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Customers_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Customers_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_REST_Customers_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Customers_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Customers_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
