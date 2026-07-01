import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentException {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentException) construct(message string, http_status_code i64, mut var_additional_data Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array) {
	this.Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException.construct(rt.new_string('woocommerce_fulfillment_error'),
		rt.new_string(message), rt.new_int(http_status_code), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_array',
		[]string{}, var_additional_data))
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentexception(message string, http_status_code i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentException {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(message, http_status_code, arg_2)
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception() &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_fulfillmentexception_php() {
	// unsupported statement: Stmt_Declare
}
