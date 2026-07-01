import rt

struct Class_Automattic_WooCommerce_Admin_API_Options {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('options')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Options', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_options' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Options', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Options', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Options', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_options' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Options', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Options', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_params := if rt.is_true(rt.new_bool(var_request.array_isset(rt.new_string('options')) && rt.is_true(rt.new_bool(var_request.array_get('options').is_string())))) { rt.call_function('explode', [rt.new_string(','), var_request.array_get('options')]) } else { rt.new_array() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_params)))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('You must supply an array of options.'), rt.new_string('woocommerce')]), rt.new_int(500))).to_bool()
	}
	{
		mut iter_1 := var_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			if !(this.user_has_permission(var_option.dup(), var_request.dup(), false)) {
				return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view these options.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) user_has_permission(var_option rt.PhpVal, var_request rt.PhpVal, is_update bool) bool {
	mut var_permissions := this.get_option_permissions(var_request.dup())
	if var_permissions.array_isset(var_option) {
		return (var_permissions.array_get(var_option)).to_bool()
	}
	rt.call_function('wc_deprecated_function', ['Automattic\\WooCommerce\\Admin\\API\\Options::' + if var_is_update { 'update_options' } else { 'get_options' }, rt.new_string('6.3')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	return (rt.call_function('current_user_can', [rt.new_string('manage_options')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_params := rt.call_method(var_request, 'get_json_params', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_params.dup().is_array()))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [rt.new_string('You must supply an array of options and values.'), rt.new_string('woocommerce')]), rt.new_int(500))).to_bool()
	}
	{
		mut iter_1 := var_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option_value := item_1.val
			mut var_option_name := item_1.key
			if !(this.user_has_permission(var_option_name.dup(), var_request.dup(), true)) {
				return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [rt.new_string('Sorry, you cannot manage these options.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) get_option_permissions(var_request rt.PhpVal) rt.PhpVal {
	mut var_permissions := Class_Automattic_WooCommerce_Admin_API_Options.get_default_option_permissions()
	return rt.call_function('apply_filters_deprecated', [rt.new_string('woocommerce_rest_api_option_permissions'), rt.create_array([rt.ArrayItem{ key: none, val: var_permissions }, rt.ArrayItem{ key: none, val: var_request }]), rt.new_string('6.3.0')])
}

fn Class_Automattic_WooCommerce_Admin_API_Options.get_default_option_permissions() rt.PhpVal {
	mut var_is_woocommerce_admin := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Internal_Admin_Homescreen{}; return temp.is_admin_user() }()
	mut var_legacy_whitelisted_options := rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_setup_jetpack_opted_in' }, rt.ArrayItem{ key: none, val: 'woocommerce_stripe_settings' }, rt.ArrayItem{ key: none, val: 'woocommerce-ppcp-settings' }, rt.ArrayItem{ key: none, val: 'woocommerce_ppcp-gateway_setting' }, rt.ArrayItem{ key: none, val: 'woocommerce_demo_store' }, rt.ArrayItem{ key: none, val: 'woocommerce_demo_store_notice' }, rt.ArrayItem{ key: none, val: 'woocommerce_ces_tracks_queue' }, rt.ArrayItem{ key: none, val: 'woocommerce_navigation_intro_modal_dismissed' }, rt.ArrayItem{ key: none, val: 'woocommerce_shipping_dismissed_timestamp' }, rt.ArrayItem{ key: none, val: 'woocommerce_allow_tracking' }, rt.ArrayItem{ key: none, val: 'woocommerce_task_list_keep_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_default_homepage_layout' }, rt.ArrayItem{ key: none, val: 'woocommerce_setup_jetpack_opted_in' }, rt.ArrayItem{ key: none, val: 'woocommerce_no_sales_tax' }, rt.ArrayItem{ key: none, val: 'woocommerce_calc_taxes' }, rt.ArrayItem{ key: none, val: 'woocommerce_bacs_settings' }, rt.ArrayItem{ key: none, val: 'woocommerce_bacs_accounts' }, rt.ArrayItem{ key: none, val: 'woocommerce_settings_shipping_recommendations_hidden' }, rt.ArrayItem{ key: none, val: 'woocommerce_task_list_dismissed_tasks' }, rt.ArrayItem{ key: none, val: 'woocommerce_setting_payments_recommendations_hidden' }, rt.ArrayItem{ key: none, val: 'woocommerce_navigation_favorites_tooltip_hidden' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_transient_notices_queue' }, rt.ArrayItem{ key: none, val: 'woocommerce_task_list_hidden' }, rt.ArrayItem{ key: none, val: 'woocommerce_task_list_complete' }, rt.ArrayItem{ key: none, val: 'woocommerce_extended_task_list_hidden' }, rt.ArrayItem{ key: none, val: 'woocommerce_ces_shown_for_actions' }, rt.ArrayItem{ key: none, val: 'woocommerce_clear_ces_tracks_queue_for_page' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_install_timestamp' }, rt.ArrayItem{ key: none, val: 'woocommerce_task_list_tracked_completed_tasks' }, rt.ArrayItem{ key: none, val: 'woocommerce_show_marketplace_suggestions' }, rt.ArrayItem{ key: none, val: 'woocommerce_task_list_reminder_bar_hidden' }, rt.ArrayItem{ key: none, val: 'wc_connect_options' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_created_default_shipping_zones' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_reviewed_default_shipping_zones' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_reviewed_store_location_settings' }, rt.ArrayItem{ key: none, val: 'woocommerce_ces_product_feedback_shown' }, rt.ArrayItem{ key: none, val: 'woocommerce_marketing_overview_multichannel_banner_dismissed' }, rt.ArrayItem{ key: none, val: 'woocommerce_manage_stock' }, rt.ArrayItem{ key: none, val: 'woocommerce_dimension_unit' }, rt.ArrayItem{ key: none, val: 'woocommerce_weight_unit' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_editor_show_feedback_bar' }, rt.ArrayItem{ key: none, val: 'woocommerce_single_variation_notice_dismissed' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_tour_modal_hidden' }, rt.ArrayItem{ key: none, val: 'woocommerce_block_product_tour_shown' }, rt.ArrayItem{ key: none, val: 'woocommerce_revenue_report_date_tour_shown' }, rt.ArrayItem{ key: none, val: 'woocommerce_orders_report_date_tour_shown' }, rt.ArrayItem{ key: none, val: 'woocommerce_show_prepublish_checks_enabled' }, rt.ArrayItem{ key: none, val: 'woocommerce_date_type' }, rt.ArrayItem{ key: none, val: 'date_format' }, rt.ArrayItem{ key: none, val: 'time_format' }, rt.ArrayItem{ key: none, val: 'woocommerce_onboarding_profile' }, rt.ArrayItem{ key: none, val: 'woocommerce_default_country' }, rt.ArrayItem{ key: none, val: 'blogname' }, rt.ArrayItem{ key: none, val: 'wcpay_welcome_page_incentives_dismissed' }, rt.ArrayItem{ key: none, val: 'wcpay_welcome_page_viewed_timestamp' }, rt.ArrayItem{ key: none, val: 'wcpay_welcome_page_exit_survey_more_info_needed_timestamp' }, rt.ArrayItem{ key: none, val: 'woocommerce_customize_store_onboarding_tour_hidden' }, rt.ArrayItem{ key: none, val: 'woocommerce_customize_store_ai_suggestions' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_customize_store_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_customize_store_completed_theme_id' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin_customize_store_survey_completed' }, rt.ArrayItem{ key: none, val: 'woocommerce_coming_soon' }, rt.ArrayItem{ key: none, val: 'woocommerce_store_pages_only' }, rt.ArrayItem{ key: none, val: 'woocommerce_private_link' }, rt.ArrayItem{ key: none, val: 'woocommerce_share_key' }, rt.ArrayItem{ key: none, val: 'woocommerce_show_lys_tour' }, rt.ArrayItem{ key: none, val: 'woocommerce_remote_variant_assignment' }, rt.ArrayItem{ key: none, val: 'woocommerce_gateway_order' }, rt.ArrayItem{ key: none, val: 'woocommerce_woopayments_nox_profile' }, rt.ArrayItem{ key: none, val: 'wc-admin-test-helper-rest-api-filters' }, rt.ArrayItem{ key: none, val: 'wc_admin_helper_feature_values' }])
	mut var_theme_permissions := rt.create_array([rt.ArrayItem{ key: 'theme_mods_' + (rt.call_function('get_stylesheet', []rt.PhpVal{})).str(), val: rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]) }, rt.ArrayItem{ key: 'stylesheet', val: rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]) }])
	return rt.call_function('array_merge', [rt.call_function('array_fill_keys', [var_theme_permissions.dup(), rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])]), rt.call_function('array_fill_keys', [var_legacy_whitelisted_options.dup(), var_is_woocommerce_admin.dup()])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) get_options(var_request rt.PhpVal) rt.PhpVal {
	mut var_options := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(var_request.array_get('options')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_request.array_get('options').is_string()))))))) {
		return var_options.dup()
	}
	mut var_params := rt.call_function('explode', [rt.new_string(','), var_request.array_get('options')])
	{
		mut iter_1 := var_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			var_options.array_set(var_option, rt.call_function('get_option', [var_option.dup()]))
		}
	}
	return var_options.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) update_options(var_request rt.PhpVal) rt.PhpVal {
	mut var_params := rt.call_method(var_request, 'get_json_params', []rt.PhpVal{})
	mut var_updated := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_params.dup().is_array()))))) {
		return rt.new_array()
	}
	{
		mut iter_1 := var_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_updated.array_set(var_key, rt.call_function('update_option', [var_key.dup(), var_value.dup()]))
		}
	}
	return var_updated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'options' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Array of options with associated values.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Internal_Admin_Homescreen {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_options() &Class_Automattic_WooCommerce_Admin_API_Options {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Options{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('options')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_automattic_woocommerce_internal_admin_homescreen() &Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Internal_Admin_Homescreen {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Internal_Admin_Homescreen{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'user_has_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.user_has_permission(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'get_option_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_option_permissions(dispatch_arg_0)
		}
		'get_default_option_permissions' {
			return Class_Automattic_WooCommerce_Admin_API_Options.get_default_option_permissions()
		}
		'get_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_options(dispatch_arg_0)
		}
		'update_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_options(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Internal_Admin_Homescreen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Internal_Admin_Homescreen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Automattic_WooCommerce_Internal_Admin_Homescreen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_options_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
