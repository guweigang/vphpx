import rt

struct Class_Automattic_WooCommerce_Admin_API_Notice {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('notice')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notice) register_routes() {
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/dismiss'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'POST' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notice', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'dissmiss_notice' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notice', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_permission' },
				]) },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notice) dissmiss_notice(var_request rt.PhpVal) rt.PhpVal {
	if !(var_request.array_isset(rt.new_string('dismiss_notice_nonce')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_request.array_get(rt.new_string('dismiss_notice_nonce')), rt.new_string('dismiss_notice')]))))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('unauthorized'),
			rt.new_string('Invalid nonce.'), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 401 },
		])))
	}
	mut var_notice_id := if var_request.array_isset(rt.new_string('notice_id')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [var_request.array_get(rt.new_string('notice_id'))]),
		]) } else { rt.new_string('') }
	mut var_dismissed := rt.new_bool(false)
	mut switch_val_1 := var_notice_id
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woo-subscription-expired-notice'))) {
		rt.call_function('update_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_expired_subs_notice(),
			rt.call_function('time', []rt.PhpVal{}),
		])
		var_dismissed = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woo-subscription-expiring-notice'))) {
		rt.call_function('update_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_expiring_subs_notice(),
			rt.call_function('time', []rt.PhpVal{}),
		])
		var_dismissed = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woo-disconnect-notice'))) {
		rt.call_function('update_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_disconnect_notice(),
			rt.call_function('time', []rt.PhpVal{}),
		])
		var_dismissed = rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woo-connect-notice'))) {
		rt.call_function('update_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_connect_notice(),
			rt.call_function('time', []rt.PhpVal{}),
		])
		var_dismissed = rt.new_bool(true)
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: var_dismissed }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notice) get_permission() bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])).to_bool()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_notice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Notice {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Notice{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('notice')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notice) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'dissmiss_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.dissmiss_notice(dispatch_arg_0)
		}
		'get_permission' {
			return rt.new_bool(this.get_permission())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Notice) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notice) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
