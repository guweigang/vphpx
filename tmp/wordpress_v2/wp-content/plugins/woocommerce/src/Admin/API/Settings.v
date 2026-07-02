import rt

struct Class_Automattic_WooCommerce_Admin_API_Settings {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('legacy-settings')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Settings) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Settings', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'save_settings' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Settings', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'save_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'schema', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Settings', [
							'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'save_items_schema' },
					]) },
				]) },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Settings) save_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Settings) save_settings(var_request rt.PhpVal) rt.PhpVal {
	mut var_current_section := rt.get_superglobal('current_section')
	mut var_current_tab := rt.get_superglobal('current_tab')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [
		rt.new_string('wp_rest'),
		rt.new_bool(false),
		rt.new_bool(false),
	])))))
	{
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_settings_invalid_nonce'), rt.call_function('__', [
			rt.new_string('Invalid nonce.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }])))
	}
	mut var_params := rt.call_method(var_request, 'get_params', []rt.PhpVal{})
	var_current_tab = if !rt.is_true(var_params.array_get(rt.new_string('tab'))) { rt.new_string('general') } else { rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash', [var_params.array_get(rt.new_string('tab'))]),
		]) }
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_current_section = if !rt.is_true(var_params.array_get(rt.new_string('section'))) { rt.new_string('') } else { rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash', [var_params.array_get(rt.new_string('section'))]),
		]) }
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_filter_name := rt.new_string((if rt.is_true(rt.identical(rt.new_string(''),
		var_current_section))
	{
		'woocommerce_save_settings_${var_current_tab.to_string()}'
	} else {
		'woocommerce_save_settings_${var_current_tab.to_string()}_${var_current_section.to_string()}'
	}).str())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [var_filter_name.clone(),
		rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('save')))))]))
	{
		mut iife_temp_0 := Class_WC_Admin_Settings{}
		mut iife_result_0 := iife_temp_0.save()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_1 := Class_WC_Admin_Settings{}
	mut iife_result_1 := iife_temp_1.get_settings_pages()
	mut var_setting_pages := iife_result_1
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iter_1 := var_setting_pages.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_setting_page := item_1.val
		mut var_key := item_1.key
		mut var_class_name := rt.call_function('get_class', [
			var_setting_page.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_setting_pages.array_set(var_key, rt.create_object_dynamically(var_class_name,
			[]rt.PhpVal{}))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_Settings_Init{}
	mut iife_result_2 := iife_temp_2.get_page_data(rt.new_array(), var_setting_pages.clone())
	mut var_data := iife_result_2
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return rt.new_object('Automattic_WooCommerce_Admin_API_WP_REST_Response', []string{}, create_automattic_woocommerce_admin_api_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'success' },
		rt.ArrayItem{ key: 'data', val: var_data },
	])))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_API_Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_settings_save_error'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Failed to save settings: %s'),
				rt.new_string('woocommerce')]),
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Settings) save_items_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'options' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Array of options with associated values.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'tab', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Settings tab.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'default', val: 'general' },
			]) },
			rt.ArrayItem{ key: 'section', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Settings section.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'default', val: '' },
			]) },
		]) },
	])
	return var_schema.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Settings_Init {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_settings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Settings {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('legacy-settings')
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

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_settings_init(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Settings_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Settings_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_rest_response(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WP_REST_Response {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'save_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save_items_permissions_check(dispatch_arg_0)
		}
		'save_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save_settings(dispatch_arg_0)
		}
		'save_items_schema' {
			return this.save_items_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Settings_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_Settings', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_settings()
		return rt.new_object('Automattic_WooCommerce_Admin_API_Settings', [
			'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_wc_rest_data_controller()
		return rt.new_object('Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_WP_Error', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_wp_error()
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Settings', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_settings()
		return rt.new_object('WC_Admin_Settings', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Settings_Init', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_settings_init()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Settings_Init', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_WP_REST_Response', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_wp_rest_response()
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_REST_Response', []string{}, obj)
	})
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
