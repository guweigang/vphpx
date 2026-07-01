import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Loader {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		classes rt.PhpVal = rt.new_array()
		required_capability rt.PhpVal = rt.new_null()
		preloaded_dependencies rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) construct()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.get_instance() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings{}; return temp.get_instance() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Translations{}; return temp.get_instance() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}; return temp.get_instance() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings{}; return temp.get_instance() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_SiteHealth{}; return temp.get_instance() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport{}; return temp.get_instance() }()
	rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.class()])
	rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides.class()])
	rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_admin_body_classes' }])])
	rt.call_function('add_filter', [rt.new_string('admin_title'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_admin_title' }])])
	rt.call_function('add_action', [rt.new_string('in_admin_header'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'embed_page_header' }])])
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'remove_notices' }])])
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'smart_app_banner' }])])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'inject_before_notices' }]), // unsupported expression: Expr_UnaryMinus])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'inject_after_notices' }]), rt.get_constant('PHP_INT_MAX')])
	rt.call_function('add_action', [rt.new_string('trashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_homepage' }])])
	rt.call_function('remove_action', [rt.new_string('admin_print_scripts'), rt.new_string('print_emoji_detection_script')])
	rt.call_function('add_action', [rt.new_string('load-themes.php'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_appearance_theme_view_tracks_event' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs() rt.PhpVal {
	return rt.call_function('wc_admin_get_breadcrumbs', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.output_heading(var_section rt.PhpVal)  {
	rt.echo_val(rt.call_function('esc_html', [var_section.dup()]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.embed_page_header()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))) && rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_embed_page() }())))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_embed_page() }())))) {
		return rt.new_null()
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_modern_settings_page() }()) {
		return rt.new_null()
	}
	mut var_sections := Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs()
	var_sections = if rt.is_true(rt.new_bool(var_sections.dup().is_array())) { var_sections } else { rt.create_array([rt.ArrayItem{ key: none, val: var_sections }]) }
	mut var_page_title := rt.new_string(rt.new_string(''))
	mut var_pages_with_tabs := rt.create_array([rt.ArrayItem{ key: none, val: 'admin.php?page=wc-settings' }, rt.ArrayItem{ key: none, val: 'admin.php?page=wc-reports' }, rt.ArrayItem{ key: none, val: 'admin.php?page=wc-status' }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_sections.dup().array_count() > 2 && rt.is_true(rt.new_bool(var_sections.array_get(1).is_array())))) && rt.is_true(rt.call_function('in_array', [var_sections.array_get(1).array_get(0), var_pages_with_tabs.dup(), rt.new_bool(true)])))) {
		var_page_title = var_sections.array_get(1).array_get(1)
	} else {
		var_page_title = rt.call_function('end', [var_sections.dup()])
	}
	// unsupported statement: Stmt_InlineHTML
	Class_Automattic_WooCommerce_Internal_Admin_Loader.output_heading(var_page_title.dup())
	// unsupported statement: Stmt_InlineHTML
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_admin_body_classes(admin_body_class string) string {
	mut admin_body_class_mutated := admin_body_class
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) || rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_modern_settings_page() }()))) {
		return admin_body_class_mutated
	}
	mut var_classes := rt.call_function('explode', [rt.new_string(' '), rt.new_string(admin_body_class_mutated.trim_space())])
	var_classes.array_push('woocommerce-admin-page')
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_embed_page() }()) {
		var_classes.array_push('woocommerce-embed-page')
	}
	mut var_page_id := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.get_instance() }(), 'get_current_screen_id', []rt.PhpVal{})
	if rt.is_true(var_page_id) {
		var_classes.array_push(var_page_id.dup())
	}
	mut var_is_loading := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_is_loading'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }()) && rt.is_true(var_is_loading))) {
		var_classes.array_push('woocommerce-admin-is-loading')
	}
	admin_body_class_mutated = (rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_unique', [var_classes.dup()])])).str()
	return " ${var_admin_body_class.to_string()} "
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.smart_app_banner()  {
	mut var_exclude_paths := rt.create_array([rt.ArrayItem{ key: none, val: '/customize-store' }, rt.ArrayItem{ key: none, val: '/setup-wizard' }, rt.ArrayItem{ key: none, val: '/launch-your-store' }])
	mut var_path := if !(rt.get_superglobal('_GET').array_get('path')).is_null() { rt.get_superglobal('_GET').array_get('path') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_path.dup(), var_exclude_paths.dup(), rt.new_bool(true)]))))))) {
		print('\n\t\t\t\t<meta name=\'apple-itunes-app\' content=\'app-id=1389130815\'>\n\t\t\t')
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.remove_notices()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('hello_dolly')])) {
		rt.call_function('remove_action', [rt.new_string('admin_notices'), rt.new_string('hello_dolly')])
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.inject_before_notices()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) {
		return rt.new_null()
	}
	mut var_is_onboarding := rt.new_bool(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('path')) && rt.is_true(rt.identical(rt.new_string('/setup-wizard'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('path')])])))))
	mut var_maybe_hide_jitm := rt.new_string(if rt.is_true(var_is_onboarding) { rt.new_string('-hide') } else { rt.new_string('') })
	print('<div class="woocommerce-layout__jitm' + (rt.call_function('sanitize_html_class', [var_maybe_hide_jitm.dup()])).str() + '" id="jp-admin-notices"></div>')
	print('<div class="woocommerce-layout__notice-list-hide" id="wp__notice-list">')
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }()) {
		print('<div class="wp-header-end" id="woocommerce-layout__notice-catcher"></div>')
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.inject_after_notices()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) {
		return rt.new_null()
	}
	print('</div>')
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.update_admin_title(var_admin_title rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('current_screen')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))))) {
		return var_admin_title.dup()
	}
	mut var_sections := Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs()
	mut var_pieces := rt.new_array()
	{
		mut iter_1 := var_sections.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_section := item_1.val
			var_pieces.array_push(if rt.is_true(rt.new_bool(var_section.dup().is_array())) { var_section.array_get(1) } else { var_section })
		}
	}
	var_pieces = rt.call_function('array_reverse', [var_pieces.dup()])
	mut var_title := rt.call_function('implode', [rt.new_string(' &lsaquo; '), var_pieces.dup()])
	return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s &lsaquo; %2$s'), rt.new_string('woocommerce')]), var_title.dup(), rt.call_function('get_bloginfo', [rt.new_string('name')])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.page_wrapper()  {
	// unsupported statement: Stmt_InlineHTML
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_component_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return var_settings_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_blocks_container')]))))) {
		// unsupported statement: Stmt_Global
		var_settings_mutated.array_set('orderStatuses', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings{}; return temp.get_order_statuses(arg_0) }(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})))
		var_settings_mutated.array_set('stockStatuses', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings{}; return temp.get_order_statuses(arg_0) }(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})))
		var_settings_mutated.array_set('currency', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings{}; return temp.get_currency_settings() }())
		var_settings_mutated.array_set('locale', rt.create_array([rt.ArrayItem{ key: 'siteLocale', val: if var_settings_mutated.array_isset(rt.new_string('siteLocale')) { var_settings_mutated.array_get('siteLocale') } else { rt.call_function('get_locale', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'userLocale', val: if var_settings_mutated.array_get('l10n').array_isset(rt.new_string('userLocale')) { var_settings_mutated.array_get('l10n').array_get('userLocale') } else { rt.call_function('get_user_locale', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'weekdaysShort', val: if var_settings_mutated.array_get('l10n').array_isset(rt.new_string('weekdaysShort')) { var_settings_mutated.array_get('l10n').array_get('weekdaysShort') } else { rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday_abbrev')]) } }]))
	}
	mut var_preload_data_endpoints := rt.call_function('apply_filters', [rt.new_string('woocommerce_component_settings_preload_endpoints'), rt.new_array()])
	var_preload_data_endpoints.array_set('jetpackStatus', '/jetpack/v4/connection')
	if !(!rt.is_true(var_preload_data_endpoints)) {
		mut var_preload_data := rt.call_function('array_reduce', [rt.call_function('array_values', [var_preload_data_endpoints.dup()]), rt.new_string('rest_preload_api_request')])
	}
	mut var_preload_options := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_preload_options'), rt.new_array()])
	if !(!rt.is_true(var_preload_options)) {
		{
			mut iter_1 := var_preload_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_option := item_1.val
				var_settings_mutated.array_get_mut('preloadOptions').array_set(var_option, rt.call_function('get_option', [var_option.dup()]))
			}
		}
	}
	mut var_preload_settings := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_preload_settings'), rt.new_array()])
	if !(!rt.is_true(var_preload_settings)) {
		mut var_setting_options := create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller()
		{
			mut iter_1 := var_preload_settings.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_group := item_1.val
				mut var_group_settings := var_setting_options.get_group_settings(var_group.dup())
				var_preload_settings = rt.new_array()
				{
					mut iter_2 := var_group_settings.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_option := item_2.val
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_option.dup().array_isset(rt.new_string('id')))) && rt.is_true(rt.new_bool(var_option.dup().array_isset(rt.new_string('value')))))) {
							var_preload_settings.array_set(var_option.array_get('id'), var_option.array_get('value'))
						}
					}
				}
				var_settings_mutated.array_get_mut('preloadSettings').array_set(var_group, var_preload_settings.dup())
			}
		}
	}
	mut var_user_controller := create_automattic_woocommerce_internal_admin_wp_rest_users_controller()
	mut var_request := create_automattic_woocommerce_internal_admin_wp_rest_request()
	var_request.set_query_params(rt.create_array([rt.ArrayItem{ key: , val:  }]))
	mut var_user_response := 
	
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_order_statuses(var_statuses rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_unregistered_order_statuses() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_settings_group(var_groups rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_custom_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_currency_settings() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.delete_homepage(var_post_id rt.PhpVal)  {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_appearance_theme_view_tracks_event()  {
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Translations {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_SiteHealth {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_loader() &Class_Automattic_WooCommerce_Internal_Admin_Loader {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		classes: rt.new_array()
		required_capability: rt.new_null()
		preloaded_dependencies: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminsharedsettings() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_translations() &Class_Automattic_WooCommerce_Internal_Admin_Translations {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminuser() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings() &Class_Automattic_WooCommerce_Internal_Admin_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_sitehealth() &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_systemstatusreport() &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller() &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_embed_breadcrumbs' {
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs()
		}
		'output_heading' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Loader.output_heading(dispatch_arg_0)
			return rt.new_null()
		}
		'embed_page_header' {
			Class_Automattic_WooCommerce_Internal_Admin_Loader.embed_page_header()
			return rt.new_null()
		}
		'add_admin_body_classes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Loader.add_admin_body_classes(dispatch_arg_0))
		}
		'smart_app_banner' {
			Class_Automattic_WooCommerce_Internal_Admin_Loader.smart_app_banner()
			return rt.new_null()
		}
		'remove_notices' {
			Class_Automattic_WooCommerce_Internal_Admin_Loader.remove_notices()
			return rt.new_null()
		}
		'inject_before_notices' {
			Class_Automattic_WooCommerce_Internal_Admin_Loader.inject_before_notices()
			return rt.new_null()
		}
		'inject_after_notices' {
			Class_Automattic_WooCommerce_Internal_Admin_Loader.inject_after_notices()
			return rt.new_null()
		}
		'update_admin_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.update_admin_title(dispatch_arg_0)
		}
		'page_wrapper' {
			Class_Automattic_WooCommerce_Internal_Admin_Loader.page_wrapper()
			return rt.new_null()
		}
		'add_component_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.add_component_settings(dispatch_arg_0)
		}
		'get_order_statuses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.get_order_statuses(dispatch_arg_0)
		}
		'get_unregistered_order_statuses' {
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.get_unregistered_order_statuses()
		}
		'add_settings_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.add_settings_group(dispatch_arg_0)
		}
		'add_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.add_settings(dispatch_arg_0)
		}
		'get_custom_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.get_custom_settings(dispatch_arg_0)
		}
		'get_currency_settings' {
			return Class_Automattic_WooCommerce_Internal_Admin_Loader.get_currency_settings()
		}
		'delete_homepage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Loader.delete_homepage(dispatch_arg_0)
			return rt.new_null()
		}
		'add_appearance_theme_view_tracks_event' {
			Class_Automattic_WooCommerce_Internal_Admin_Loader.add_appearance_theme_view_tracks_event()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'classes' { return this.classes }
		'required_capability' { return this.required_capability }
		'preloaded_dependencies' { return this.preloaded_dependencies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'classes' { this.classes = val; return true }
		'required_capability' { this.required_capability = val; return true }
		'preloaded_dependencies' { this.preloaded_dependencies = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SiteHealth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_loader_php() {
}
