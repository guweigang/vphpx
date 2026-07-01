import rt

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) construct()  {
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminUser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_user_data' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) register_user_data()  {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_user := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(var_user.array_isset(rt.new_string('id'))) || rt.is_true(rt.identical(rt.new_int(0), var_user.array_get('id'))))) {
		return rt.new_bool(false)
	}
	return rt.call_function('is_super_admin', [var_user.array_get('id')])
	}
	rt.call_function('register_rest_field', [rt.new_string('user'), rt.new_string('is_super_admin'), rt.create_array([rt.ArrayItem{ key: 'get_callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'schema', val: rt.new_null() }])])
	rt.call_function('register_rest_field', [rt.new_string('user'), rt.new_string('woocommerce_meta'), rt.create_array([rt.ArrayItem{ key: 'get_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminUser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_user_data_values' }]) }, rt.ArrayItem{ key: 'update_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminUser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_user_data_values' }]) }, rt.ArrayItem{ key: 'schema', val: rt.new_null() }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) get_user_data_values(var_user rt.PhpVal) rt.PhpVal {
	mut var_values := rt.new_array()
	{
		mut iter_1 := this.get_user_data_fields().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			var_values.array_set(var_field, Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.get_user_data_field(var_user.array_get('id'), var_field.dup()))
		}
	}
	return var_values.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) update_user_data_values(var_values rt.PhpVal, var_user rt.PhpVal, var_field_id rt.PhpVal) rt.PhpVal {
	mut var_values_mutated := var_values
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_values_mutated) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_values_mutated.dup().is_array()))))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_fields := this.get_user_data_fields()
	mut var_updates := rt.new_array()
	{
		mut iter_1 := var_values_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_field := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_field.dup(), var_fields.dup(), rt.new_bool(true)])) {
				var_updates.array_set(var_field, var_value.dup())
				Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.update_user_data_field(rt.get_property(var_user, 'ID'), var_field.dup(), var_value.dup())
			}
		}
	}
	return var_updates.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) get_user_data_fields() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_get_user_data_fields'), rt.create_array([rt.ArrayItem{ key: none, val: 'variable_product_tour_shown' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.update_user_data_field(var_user_id rt.PhpVal, var_field rt.PhpVal, var_value rt.PhpVal)  {
	rt.call_function('update_user_meta', [var_user_id.dup(), 'woocommerce_admin_' + (var_field).str(), var_value.dup()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.get_user_data_field(var_user_id rt.PhpVal, var_field rt.PhpVal) rt.PhpVal {
	mut var_meta_value := rt.call_function('get_user_meta', [var_user_id.dup(), 'woocommerce_admin_' + (var_field).str(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_string(''), var_meta_value)) {
		mut var_old_meta_value := rt.call_function('get_user_meta', [var_user_id.dup(), 'wc_admin_' + (var_field).str(), rt.new_bool(true)])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.update_user_data_field(var_user_id.dup(), var_field.dup(), var_old_meta_value.dup())
			rt.call_function('delete_user_meta', [var_user_id.dup(), 'wc_admin_' + (var_field).str()])
			var_meta_value = var_old_meta_value.dup()
		}
	}
	return var_meta_value.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.get_user_data() rt.PhpVal {
	mut var_user_controller := create_automattic_woocommerce_internal_admin_wp_rest_users_controller()
	mut var_request := create_automattic_woocommerce_internal_admin_wp_rest_request()
	var_request.set_query_params(rt.create_array([rt.ArrayItem{ key: 'context', val: 'edit' }]))
	mut var_user_response := var_user_controller.get_current_item(rt.new_object('Automattic_WooCommerce_Internal_Admin_WP_REST_Request', []string{}, var_request))
	mut var_current_user_data := if rt.is_true(rt.call_function('is_wp_error', [var_user_response.dup()])) { // unsupported expression: Expr_Cast_Object } else { rt.call_method(var_user_response, 'get_data', []rt.PhpVal{}) }
	var_current_user_data = Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.filter_user_capabilities(var_current_user_data.dup())
	return var_current_user_data.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.filter_user_capabilities(var_user_data rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_user_data.dup().is_array()))))) || !(var_user_data.array_isset(rt.new_string('capabilities'))))) {
		return var_user_data.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_user_data.array_get('capabilities'), 'install_plugins')).is_null() && rt.is_true(rt.get_property(var_user_data.array_get('capabilities'), 'install_plugins')))) {
		rt.set_property(var_user_data.array_get('capabilities'), 'install_plugins', rt.call_function('wp_is_file_mod_allowed', [rt.new_string('woocommerce')]))
	}
	return var_user_data.dup()
}

struct Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcadminuser() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_wp_rest_users_controller() &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wp_rest_request() &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.get_instance()
		}
		'register_user_data' {
			this.register_user_data()
			return rt.new_null()
		}
		'get_user_data_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_user_data_values(dispatch_arg_0)
		}
		'update_user_data_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_user_data_values(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_user_data_fields' {
			return this.get_user_data_fields()
		}
		'update_user_data_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.update_user_data_field(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_user_data_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.get_user_data_field(dispatch_arg_0, dispatch_arg_1)
		}
		'get_user_data' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.get_user_data()
		}
		'filter_user_capabilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser.filter_user_capabilities(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_wcadminuser_php() {
}
