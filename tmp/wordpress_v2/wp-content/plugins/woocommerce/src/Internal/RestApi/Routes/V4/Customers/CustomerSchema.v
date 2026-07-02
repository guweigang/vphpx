import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.identifier() string {
	return 'customer'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the resource.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_created', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("The date the customer was created, in the site's timezone."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the customer was created, as GMT.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_modified', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("The date the customer was last modified, in the site's timezone."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'date_modified_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The date the customer was last modified, as GMT.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'email', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The email address for the customer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'email' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
		]) },
		rt.ArrayItem{ key: 'first_name', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Customer first name.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
				rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			]) },
		]) },
		rt.ArrayItem{ key: 'last_name', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Customer last name.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
				rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			]) },
		]) },
		rt.ArrayItem{ key: 'role', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Customer role.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'username', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Customer login name.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
				rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_user' },
			]) },
		]) },
		rt.ArrayItem{ key: 'billing', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of billing address data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'first_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('First name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'last_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Last name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'company', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Company name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_1', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 1'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_2', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 2'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'city', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('City name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'state', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code or name of the state, province or district.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'postcode', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Postal code.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'country', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code of the country.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'email', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Email address.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'format', val: 'email' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'phone', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Phone number.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of shipping address data.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'first_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('First name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'last_name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Last name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'company', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Company name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_1', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 1'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'address_2', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Address line 2'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'city', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('City name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'state', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code or name of the state, province or district.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'postcode', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Postal code.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'country', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code of the country.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
				rt.ArrayItem{ key: 'phone', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Phone number.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
					},
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'is_paying_customer', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Is the customer a paying customer?'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'orders_count', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Quantity of orders made by the customer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'total_spent', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total amount spent.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'avatar_url', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Avatar URL.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'last_active', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string("When the customer was last active in the site's timezone."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'null' },
				rt.ArrayItem{ key: none, val: 'string' },
			]) },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'last_active_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('When the customer was last active, as GMT.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'null' },
				rt.ArrayItem{ key: none, val: 'string' },
			]) },
			rt.ArrayItem{ key: 'format', val: 'date-time' },
			rt.ArrayItem{
				key: 'context'
				val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema.view_edit_context()
			},
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
	])
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'WC_Customer')))))) {
		return rt.new_array()
	}
	mut var_data := rt.call_method(var_item, 'get_data', []rt.PhpVal{})
	mut var_last_active := rt.call_method(var_item, 'get_meta', [
		rt.new_string('wc_last_active'),
	])
	var_last_active = if !rt.is_true(var_last_active) { rt.new_null() } else { var_last_active }
	mut var_formatted_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_item, 'get_date_created', []rt.PhpVal{}),
			rt.new_bool(false),
		]) },
		rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_item, 'get_date_created', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_item, 'get_date_modified', []rt.PhpVal{}),
			rt.new_bool(false),
		]) },
		rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_item, 'get_date_modified', []rt.PhpVal{}),
		]) },
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
		rt.ArrayItem{ key: 'orders_count', val: rt.call_method(var_item, 'get_order_count',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'total_spent', val: rt.call_method(var_item, 'get_total_spent',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'avatar_url', val: rt.call_method(var_item, 'get_avatar_url',
			[]rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'last_active'
			val: if rt.is_true(var_last_active) { rt.call_function('wc_rest_prepare_date_response', [
					var_last_active.clone(),
					rt.new_bool(false),
				]) } else { rt.new_null() }
		},
		rt.ArrayItem{
			key: 'last_active_gmt'
			val: if rt.is_true(var_last_active) { rt.call_function('wc_rest_prepare_date_response', [
					var_last_active.clone(),
				]) } else { rt.new_null() }
		},
	])
	if !(!rt.is_true(var_include_fields)) {
		var_formatted_data = rt.call_function('array_intersect_key', [
			var_formatted_data.clone(), rt.call_function('array_flip', [
				var_include_fields,
			])])
	}
	return var_formatted_data.clone()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_customers_customerschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
