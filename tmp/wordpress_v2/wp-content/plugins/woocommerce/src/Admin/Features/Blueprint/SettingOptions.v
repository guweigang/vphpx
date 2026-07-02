import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions {
	rt.PhpObjectBase
pub mut:
	setting_option_controller rt.PhpVal = rt.new_null()
	ignore_setting_types      rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) construct() {
	this.setting_option_controller =
		create_automattic_woocommerce_admin_features_blueprint_wc_rest_setting_options_controller()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) get_page_options(var_page_id rt.PhpVal) rt.PhpVal {
	mut var_settings := rt.call_method(this.setting_option_controller, 'get_group_settings', [
		var_page_id.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_settings.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Exception',
			[]string{}, create_automattic_woocommerce_admin_features_blueprint_exception(rt.call_function('esc_html', [
			rt.call_method(var_settings, 'get_error_message', []rt.PhpVal{}),
		]))))
	}
	mut var_page_options := rt.new_array()
	mut iter_1 := var_settings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_setting := item_1.val
		if rt.is_true(rt.call_function('in_array', [var_setting.array_get(rt.new_string('type')), this.ignore_setting_types, rt.new_bool(true)]))
			|| !(var_setting.array_isset(rt.new_string('id'))) {
			continue
		}
		mut var_key := if var_setting.array_get(rt.new_string('option_key')).is_array() {
			var_setting.array_get(rt.new_string('option_key')).array_get(rt.new_int(0))
		} else {
			var_setting.array_get(rt.new_string('option_key'))
		}
		if rt.is_true(rt.call_function('in_array', [var_key.clone(),
			var_page_options.clone(), rt.new_bool(true)]))
		{
			continue
		}
		mut var_default_value := if !(var_setting.array_get(rt.new_string('default'))).is_null() {
			var_setting.array_get(rt.new_string('default'))
		} else {
			rt.new_null()
		}
		var_page_options.array_set(var_key, rt.call_function('get_option', [
			var_key.clone(), var_default_value.clone()]))
	}
	return var_page_options.clone()
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_WC_REST_Setting_Options_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_settingoptions() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions{
		PhpObjectBase:             rt.PhpObjectBase{}
		setting_option_controller: rt.new_null()
		ignore_setting_types:      rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_wc_rest_setting_options_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WC_REST_Setting_Options_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WC_REST_Setting_Options_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_page_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_page_options(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'setting_option_controller' { return this.setting_option_controller }
		'ignore_setting_types' { return this.ignore_setting_types }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_SettingOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'setting_option_controller' {
			this.setting_option_controller = val
			return true
		}
		'ignore_setting_types' {
			this.ignore_setting_types = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_WC_REST_Setting_Options_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WC_REST_Setting_Options_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_WC_REST_Setting_Options_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
