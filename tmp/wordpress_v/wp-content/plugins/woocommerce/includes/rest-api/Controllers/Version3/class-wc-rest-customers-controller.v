import rt

struct Class_WC_REST_Customers_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Customers_Controller) get_formatted_item_data(var_object rt.PhpVal) rt.PhpVal {
	return this.get_formatted_item_data_core(var_object.dup())
}

fn (mut this Class_WC_REST_Customers_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('customer'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the customer was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the customer was created, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified': { 'description': rt.call_function('__', [rt.new_string('The date the customer was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the customer was last modified, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'email': { 'description': rt.call_function('__', [rt.new_string('The email address for the customer.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('email'), 'context': map[string]rt.PhpVal{} }, 'first_name': { 'description': rt.call_function('__', [rt.new_string('Customer first name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } }, 'last_name': { 'description': rt.call_function('__', [rt.new_string('Customer last name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } }, 'role': { 'description': rt.call_function('__', [rt.new_string('Customer role.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'username': { 'description': rt.call_function('__', [rt.new_string('Customer login name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_user') } }, 'password': { 'description': rt.call_function('__', [rt.new_string('Customer password.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'billing': { 'description': rt.call_function('__', [rt.new_string('List of billing address data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'properties': { 'first_name': { 'description': rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'last_name': { 'description': rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'company': { 'description': rt.call_function('__', [rt.new_string('Company name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'address_1': { 'description': rt.call_function('__', [rt.new_string('Address line 1'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'address_2': { 'description': rt.call_function('__', [rt.new_string('Address line 2'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'city': { 'description': rt.call_function('__', [rt.new_string('City name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'state': { 'description': rt.call_function('__', [rt.new_string('ISO code or name of the state, province or district.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'postcode': { 'description': rt.call_function('__', [rt.new_string('Postal code.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'country': { 'description': rt.call_function('__', [rt.new_string('ISO code of the country.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'email': { 'description': rt.call_function('__', [rt.new_string('Email address.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('email'), 'context': map[string]rt.PhpVal{} }, 'phone': { 'description': rt.call_function('__', [rt.new_string('Phone number.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } }, 'shipping': { 'description': rt.call_function('__', [rt.new_string('List of shipping address data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'properties': { 'first_name': { 'description': rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'last_name': { 'description': rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'company': { 'description': rt.call_function('__', [rt.new_string('Company name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'address_1': { 'description': rt.call_function('__', [rt.new_string('Address line 1'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'address_2': { 'description': rt.call_function('__', [rt.new_string('Address line 2'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'city': { 'description': rt.call_function('__', [rt.new_string('City name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'state': { 'description': rt.call_function('__', [rt.new_string('ISO code or name of the state, province or district.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'postcode': { 'description': rt.call_function('__', [rt.new_string('Postal code.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'country': { 'description': rt.call_function('__', [rt.new_string('ISO code of the country.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'phone': { 'description': rt.call_function('__', [rt.new_string('Phone number.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } }, 'is_paying_customer': { 'description': rt.call_function('__', [rt.new_string('Is the customer a paying customer?'), rt.new_string('woocommerce')]), 'type': rt.new_string('bool'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'avatar_url': { 'description': rt.call_function('__', [rt.new_string('Avatar URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} } } } } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Customers_V2_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_customers_controller() &Class_WC_REST_Customers_Controller {
	mut obj := &Class_WC_REST_Customers_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_customers_v2_controller() &Class_WC_REST_Customers_V2_Controller {
	mut obj := &Class_WC_REST_Customers_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Customers_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_formatted_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_item_data(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Customers_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Customers_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Customers_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Customers_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Customers_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_customers_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
