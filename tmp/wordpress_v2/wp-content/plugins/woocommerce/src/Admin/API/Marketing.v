import rt

struct Class_Automattic_WooCommerce_Admin_API_Marketing {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('marketing')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Marketing) register_routes() {
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/recommended'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_recommended_plugins' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_recommended_plugins_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{
						key: 'per_page'
						val: this.get_collection_params().array_get(rt.new_string('per_page'))
					},
					rt.ArrayItem{ key: 'category', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_title_with_dashes' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/knowledge-base'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_knowledge_base_posts' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'category', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_title_with_dashes' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/misc-recommendations'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_misc_recommendations' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_recommended_plugins_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Marketing', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Marketing) get_recommended_plugins_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [
			rt.new_string('You do not have permissions to manage plugins. Please contact your site administrator.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Marketing) get_recommended_plugins(var_request rt.PhpVal) rt.PhpVal {
	mut var_category := if !(!rt.is_true(rt.call_method(var_request, 'get_param', [
		rt.new_string('category'),
	]))) {
		rt.call_method(var_request, 'get_param', [rt.new_string('category')])
	} else {
		rt.new_string('marketing')
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{}
	mut iife_result_0 := iife_temp_0.get_recommended_plugins()
	mut var_all_plugins := iife_result_0
	mut var_valid_plugins := rt.new_array()
	mut var_per_page := rt.call_method(var_request, 'get_param', [
		rt.new_string('per_page'),
	])
	mut iter_1 := var_all_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		mut var_plugin_categories := if !(!rt.is_true(var_plugin.array_get(rt.new_string('categories')))) { var_plugin.array_get(rt.new_string('categories')) } else { rt.create_array([
				rt.ArrayItem{ key: none, val: 'marketing' },
			]) }
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
		mut iife_result_1 :=
			iife_temp_1.is_plugin_installed(var_plugin.array_get(rt.new_string('plugin')))
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1))))
			&& rt.is_true(rt.call_function('in_array', [var_category.clone(), var_plugin_categories.clone(), rt.new_bool(true)])) {
			var_valid_plugins.array_push(var_plugin.clone())
		}
	}
	return rt.call_function('rest_ensure_response', [
		rt.call_function('array_slice', [var_valid_plugins.clone(),
			rt.new_int(0), var_per_page.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Marketing) get_knowledge_base_posts(var_request rt.PhpVal) rt.PhpVal {
	mut var_marketing_specs := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs.class(),
	])
	mut var_category := rt.call_method(var_request, 'get_param', [
		rt.new_string('category'),
	])
	return rt.call_function('rest_ensure_response', [
		rt.call_method(var_marketing_specs, 'get_knowledge_base_posts', [
			var_category.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Marketing) get_misc_recommendations(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{}
	mut iife_result_2 := iife_temp_2.get_misc_recommendations()
	mut var_misc_recommendations := iife_result_2
	return rt.call_function('rest_ensure_response', [var_misc_recommendations.clone()])
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_marketing(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Marketing {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Marketing{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('marketing')
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

fn create_automattic_woocommerce_admin_features_marketingrecommendations_init(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Marketing) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_recommended_plugins_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_recommended_plugins_permissions_check(dispatch_arg_0))
		}
		'get_recommended_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recommended_plugins(dispatch_arg_0)
		}
		'get_knowledge_base_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_knowledge_base_posts(dispatch_arg_0)
		}
		'get_misc_recommendations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_misc_recommendations(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Marketing) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Marketing) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
