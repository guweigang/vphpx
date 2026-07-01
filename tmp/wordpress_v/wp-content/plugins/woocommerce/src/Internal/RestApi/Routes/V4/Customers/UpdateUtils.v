import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) update_customer_from_request(mut var_customer Class_WC_Customer, mut var_request Class_WP_REST_Request, creating bool)  {
	if var_request.array_isset(rt.new_string('email')) {
		var_customer.set_email(rt.call_function('sanitize_email', [var_request.array_get('email')]))
	}
	if var_request.array_isset(rt.new_string('password')) {
		var_customer.set_password(var_request.array_get('password'))
	}
	if var_request.array_isset(rt.new_string('first_name')) {
		var_customer.set_first_name(rt.call_function('wc_clean', [var_request.array_get('first_name')]))
	}
	if var_request.array_isset(rt.new_string('last_name')) {
		var_customer.set_last_name(rt.call_function('wc_clean', [var_request.array_get('last_name')]))
	}
	if rt.is_true(rt.new_bool(var_request.array_isset(rt.new_string('billing')) && rt.is_true(rt.new_bool(var_request.array_get('billing').is_array())))) {
		this.update_customer_address(mut var_customer, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array](var_request.array_get('billing')), 'billing')
	}
	if rt.is_true(rt.new_bool(var_request.array_isset(rt.new_string('shipping')) && rt.is_true(rt.new_bool(var_request.array_get('shipping').is_array())))) {
		this.update_customer_address(mut var_customer, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array](var_request.array_get('shipping')), 'shipping')
	}
	var_customer.save()
	mut var_user_data := rt.call_function('get_userdata', [var_customer.get_id()])
	if rt.is_true(var_user_data) {
		this.update_additional_fields_for_object(var_user_data.dup(), mut var_request)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [rt.get_property(var_user_data, 'ID')]))))) {
			rt.call_method(var_user_data, 'add_role', [rt.new_string('customer')])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) update_customer_address(mut var_customer Class_WC_Customer, mut var_address Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array, type string)  {
	mut var_address_mutated := var_address
	var_address_mutated = rt.call_function('wc_clean', [var_address_mutated.dup()])
	mut var_address_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'first_name' }, rt.ArrayItem{ key: none, val: 'last_name' }, rt.ArrayItem{ key: none, val: 'company' }, rt.ArrayItem{ key: none, val: 'address_1' }, rt.ArrayItem{ key: none, val: 'address_2' }, rt.ArrayItem{ key: none, val: 'city' }, rt.ArrayItem{ key: none, val: 'state' }, rt.ArrayItem{ key: none, val: 'postcode' }, rt.ArrayItem{ key: none, val: 'country' }, rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'phone' }])
	{
		mut iter_1 := var_address_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if rt.is_true(rt.new_bool(var_address_mutated.array_isset(var_field) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: "set_${var_type}_${var_field.to_string()}" }])])))) {
				mut var_value := if rt.is_true(rt.identical(rt.new_string('email'), var_field)) { rt.call_function('sanitize_email', [var_address_mutated.array_get(var_field)]) } else { var_address_mutated.array_get(var_field) }
				rt.call_method(var_customer, "set_${var_type}_${var_field.to_string()}", [var_value.dup()])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) update_additional_fields_for_object(var_item rt.PhpVal, mut var_request Class_WP_REST_Request)  {
	mut var_additional_fields := this.get_additional_fields()
	{
		mut iter_1 := var_additional_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_options := item_1.val
			mut var_field_name := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_field_options.array_get('update_callback'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_field_options.array_get('update_callback')]))))))) {
				continue
			}
			if !(var_request.array_isset(var_field_name)) {
				continue
			}
			mut var_result := rt.call_function('call_user_func', [var_field_options.array_get('update_callback'), var_request.array_get(var_field_name), var_item.dup(), var_field_name.dup(), var_request])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
				rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('esc_html', [rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})]), rt.new_int(400))))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) get_additional_fields() rt.PhpVal {
	mut var_fields := rt.new_array()
	var_fields = rt.call_function('apply_filters', [rt.new_string('rest_additional_fields'), var_fields.dup(), rt.new_string('user')])
	var_fields = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('rest_'), this.get_object_type()), rt.new_string('_additional_fields')), var_fields.dup(), rt.new_string('user')])
	return var_fields.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) get_object_type() string {
	return 'user'
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_customers_updateutils() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception() &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update_customer_from_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Customer](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.update_customer_from_request(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_customer_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Customer](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.update_customer_address(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_additional_fields_for_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			this.update_additional_fields_for_object(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_additional_fields' {
			return this.get_additional_fields()
		}
		'get_object_type' {
			return rt.new_string(this.get_object_type())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_customers_updateutils_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
