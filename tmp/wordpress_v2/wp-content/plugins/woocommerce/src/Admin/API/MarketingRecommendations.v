import rt

struct Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('marketing/recommendations')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MarketingRecommendations', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MarketingRecommendations', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'category', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_title_with_dashes' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'channels' },
							rt.ArrayItem{ key: none, val: 'extensions' },
						]) },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MarketingRecommendations', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot view marketing channels.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_category := rt.call_method(var_request, 'get_param', [
		rt.new_string('category'),
	])
	if rt.is_true(rt.identical(rt.new_string('channels'), var_category)) {
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{}
		mut iife_result_0 := iife_temp_0.get_recommended_marketing_channels()
		mut var_items := iife_result_0
	} else if rt.is_true(rt.identical(rt.new_string('extensions'), var_category)) {
		mut iife_temp_1 :=
			Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{}
		mut iife_result_1 := iife_temp_1.get_recommended_marketing_extensions_excluding_channels()
		var_items = iife_result_1
	} else {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_category'), rt.call_function('__', [
			rt.new_string('The specified category for recommendations is invalid. Allowed values: "channels", "extensions".'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_responses := rt.new_array()
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_response := this.prepare_item_for_response(var_item.clone(), var_request.clone())
		var_responses.array_push(this.prepare_response_for_collection(var_response.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_responses.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	mut var_data := this.add_additional_fields_to_object(var_item.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'marketing_recommendation' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'url', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'direct_install', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'product', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'plugin', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'categories', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'subcategories', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'slug', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'name', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'tags', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'slug', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'name', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
				]) },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_marketingrecommendations(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('marketing/recommendations')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingRecommendations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
