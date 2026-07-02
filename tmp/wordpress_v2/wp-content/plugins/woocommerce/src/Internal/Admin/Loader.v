import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Loader {
	rt.PhpObjectBase
pub mut:
	preloaded_dependencies rt.PhpVal = rt.new_array()
}

fn init_static_automattic_woocommerce_internal_admin_loader() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Loader', 'instance', rt.new_null())
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Loader', 'classes', rt.new_array())
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Loader', 'required_capability',
		rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Loader',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Loader', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self',
			[]string{}, create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Loader', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Translations{}
	mut iife_result_2 := iife_temp_2.get_instance()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}
	mut iife_result_3 := iife_temp_3.get_instance()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
	mut iife_result_4 := iife_temp_4.get_instance()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_SiteHealth{}
	mut iife_result_5 := iife_temp_5.get_instance()
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport{}
	mut iife_result_6 := iife_temp_6.get_instance()
	rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.class(),
	])
	rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides.class(),
	])
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_admin_body_classes' }])])
	rt.call_function('add_filter', [rt.new_string('admin_title'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_admin_title' }])])
	rt.call_function('add_action', [rt.new_string('in_admin_header'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'embed_page_header' }])])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'remove_notices' }])])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'smart_app_banner' }])])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'inject_before_notices' }]),
		rt.new_int(-9999)])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'inject_after_notices' }]),
		rt.get_constant('PHP_INT_MAX')])
	rt.call_function('add_action', [rt.new_string('trashed_post'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_homepage' }])])
	rt.call_function('remove_action', [rt.new_string('admin_print_scripts'),
		rt.new_string('print_emoji_detection_script')])
	rt.call_function('add_action', [rt.new_string('load-themes.php'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_appearance_theme_view_tracks_event' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs() rt.PhpVal {
	return rt.call_function('wc_admin_get_breadcrumbs', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.output_heading(var_section rt.PhpVal) {
	rt.echo_val(rt.call_function('esc_html', [var_section.clone()]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.embed_page_header() {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_7 := iife_temp_7.is_admin_page()
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_8 := iife_temp_8.is_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_7))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
		return
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_9 := iife_temp_9.is_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_9)))) {
		return
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_10 := iife_temp_10.is_modern_settings_page()
	if rt.is_true(iife_result_10) {
		return
	}
	mut var_sections := Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs()
	var_sections = if var_sections.clone().is_array() { var_sections } else { rt.create_array([
			rt.ArrayItem{ key: none, val: var_sections },
		]) }
	mut var_page_title := rt.new_string('')
	mut var_pages_with_tabs := rt.create_array([
		rt.ArrayItem{ key: none, val: 'admin.php?page=wc-settings' },
		rt.ArrayItem{ key: none, val: 'admin.php?page=wc-reports' },
		rt.ArrayItem{ key: none, val: 'admin.php?page=wc-status' },
	])
	if var_sections.clone().array_count() > 2 && var_sections.array_get(rt.new_int(1)).is_array()
		&& rt.is_true(rt.call_function('in_array', [var_sections.array_get(rt.new_int(1)).array_get(rt.new_int(0)), var_pages_with_tabs.clone(), rt.new_bool(true)])) {
		var_page_title = var_sections.array_get(rt.new_int(1)).array_get(rt.new_int(1))
	} else {
		var_page_title = rt.call_function('end', [var_sections.clone()])
	}
	// unsupported statement: Stmt_InlineHTML
	Class_Automattic_WooCommerce_Internal_Admin_Loader.output_heading(var_page_title.clone())
	// unsupported statement: Stmt_InlineHTML
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_admin_body_classes(admin_body_class string) string {
	mut admin_body_class_mutated := admin_body_class
	mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_11 := iife_temp_11.is_admin_or_embed_page()
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_12 := iife_temp_12.is_modern_settings_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_11)))) || rt.is_true(iife_result_12) {
		return admin_body_class_mutated
	}
	mut var_classes := rt.call_function('explode', [rt.new_string(' '),
		rt.new_string(admin_body_class_mutated.trim_space())])
	var_classes.array_push('woocommerce-admin-page')
	mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_13 := iife_temp_13.is_embed_page()
	if rt.is_true(iife_result_13) {
		var_classes.array_push('woocommerce-embed-page')
	}
	mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_14 := iife_temp_14.get_instance()
	mut var_page_id := rt.call_method(iife_result_14, 'get_current_screen_id', []rt.PhpVal{})
	if rt.is_true(var_page_id) {
		var_classes.array_push(var_page_id.clone())
	}
	mut var_is_loading := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_is_loading'),
		rt.new_bool(false),
	])
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_15 := iife_temp_15.is_admin_page()
	if rt.is_true(iife_result_15) && rt.is_true(var_is_loading) {
		var_classes.array_push('woocommerce-admin-is-loading')
	}
	admin_body_class_mutated = (rt.call_function('implode', [
		rt.new_string(' '), rt.call_function('array_unique', [
			var_classes.clone()])])).str()
	return ' ${var_admin_body_class.to_string()} '
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.smart_app_banner() {
	mut var_exclude_paths := rt.create_array([
		rt.ArrayItem{ key: none, val: '/customize-store' },
		rt.ArrayItem{ key: none, val: '/setup-wizard' },
		rt.ArrayItem{ key: none, val: '/launch-your-store' },
	])
	mut var_path := if !(rt.get_superglobal('_GET').array_get(rt.new_string('path'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('path'))
	} else {
		rt.new_string('')
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_16 := iife_temp_16.is_admin_or_embed_page()
	if rt.is_true(iife_result_16)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_path.clone(), var_exclude_paths.clone(), rt.new_bool(true)]))))) {
		print("\n\t\t\t\t<meta name='apple-itunes-app' content='app-id=1389130815'>\n\t\t\t")
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.remove_notices() {
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_17 := iife_temp_17.is_admin_or_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_17)))) {
		return
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('hello_dolly')])) {
		rt.call_function('remove_action', [rt.new_string('admin_notices'),
			rt.new_string('hello_dolly')])
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.inject_before_notices() {
	mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_18 := iife_temp_18.is_admin_or_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_18)))) {
		return
	}
	mut var_is_onboarding := rt.new_bool(
		rt.get_superglobal('_GET').array_isset(rt.new_string('path'))
		&& rt.is_true(rt.identical(rt.new_string('/setup-wizard'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('path'))])]))))
	mut var_maybe_hide_jitm := rt.new_string((if rt.is_true(var_is_onboarding) {
		'-hide'
	} else {
		''
	}).str())
	print('<div class="woocommerce-layout__jitm' +
		(rt.call_function('sanitize_html_class', [var_maybe_hide_jitm.clone()])).str() +
		'" id="jp-admin-notices"></div>')
	print('<div class="woocommerce-layout__notice-list-hide" id="wp__notice-list">')
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_19 := iife_temp_19.is_admin_page()
	if rt.is_true(iife_result_19) {
		print('<div class="wp-header-end" id="woocommerce-layout__notice-catcher"></div>')
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.inject_after_notices() {
	mut iife_temp_20 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_20 := iife_temp_20.is_admin_or_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_20)))) {
		return
	}
	print('</div>')
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.update_admin_title(var_admin_title rt.PhpVal) rt.PhpVal {
	mut iife_temp_21 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_21 := iife_temp_21.is_admin_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('current_screen')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_21)))) {
		return var_admin_title.clone()
	}
	mut var_sections := Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs()
	mut var_pieces := rt.new_array()
	mut iter_1 := var_sections.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_section := item_1.val
		var_pieces.array_push(if var_section.clone().is_array() {
			var_section.array_get(rt.new_int(1))
		} else {
			var_section
		})
	}
	var_pieces = rt.call_function('array_reverse', [var_pieces.clone()])
	mut var_title := rt.call_function('implode', [rt.new_string(' &lsaquo; '),
		var_pieces.clone()])
	return rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s &lsaquo; %2$s'),
			rt.new_string('woocommerce')]),
		var_title.clone(),
		rt.call_function('get_bloginfo', [rt.new_string('name')]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.page_wrapper() {
	// unsupported statement: Stmt_InlineHTML
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_component_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return var_settings_mutated.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_blocks_container'),
	])))))
	{
		mut iife_temp_22 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
		mut iife_result_22 := iife_temp_22.get_order_statuses(rt.call_function('wc_get_order_statuses',
			[]rt.PhpVal{}))
		var_settings_mutated.array_set('orderStatuses', iife_result_22)
		mut iife_temp_23 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
		mut iife_result_23 := iife_temp_23.get_order_statuses(rt.call_function('wc_get_product_stock_status_options',
			[]rt.PhpVal{}))
		var_settings_mutated.array_set('stockStatuses', iife_result_23)
		mut iife_temp_24 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
		mut iife_result_24 := iife_temp_24.get_currency_settings()
		var_settings_mutated.array_set('currency', iife_result_24)
		var_settings_mutated.array_set('locale', rt.create_array([
			rt.ArrayItem{
				key: 'siteLocale'
				val: if var_settings_mutated.array_isset(rt.new_string('siteLocale')) {
					var_settings_mutated.array_get(rt.new_string('siteLocale'))
				} else {
					rt.call_function('get_locale', []rt.PhpVal{})
				}
			},
			rt.ArrayItem{
				key: 'userLocale'
				val: if var_settings_mutated.array_get(rt.new_string('l10n')).array_isset(rt.new_string('userLocale')) {
					var_settings_mutated.array_get(rt.new_string('l10n')).array_get(rt.new_string('userLocale'))
				} else {
					rt.call_function('get_user_locale', []rt.PhpVal{})
				}
			},
			rt.ArrayItem{
				key: 'weekdaysShort'
				val: if var_settings_mutated.array_get(rt.new_string('l10n')).array_isset(rt.new_string('weekdaysShort')) { var_settings_mutated.array_get(rt.new_string('l10n')).array_get(rt.new_string('weekdaysShort')) } else { rt.call_function('array_values', [
						rt.get_property(var_wp_locale, 'weekday_abbrev'),
					]) }
			},
		]))
	}
	mut var_preload_data_endpoints := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_component_settings_preload_endpoints'),
		rt.new_array(),
	])
	var_preload_data_endpoints.array_set('jetpackStatus', '/jetpack/v4/connection')
	if !(!rt.is_true(var_preload_data_endpoints)) {
		mut var_preload_data := rt.call_function('array_reduce', [
			rt.call_function('array_values', [var_preload_data_endpoints.clone()]),
			rt.new_string('rest_preload_api_request'),
		])
	}
	mut var_preload_options := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_preload_options'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_preload_options)) {
		mut iter_2 := var_preload_options.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_option := item_2.val
			var_settings_mutated.array_get_mut('preloadOptions').array_set(var_option, rt.call_function('get_option', [
				var_option.clone(),
			]))
		}
	}
	mut var_preload_settings := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_preload_settings'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_preload_settings)) {
		mut var_setting_options :=
			create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller()
		mut iter_3 := var_preload_settings.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_group := item_3.val
			mut var_group_settings := var_setting_options.get_group_settings(var_group.clone())
			var_preload_settings = rt.new_array()
			mut iter_4 := var_group_settings.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_option := item_4.val
				if rt.is_true(rt.new_bool(var_option.clone().array_isset(rt.new_string('id'))))
					&& rt.is_true(rt.new_bool(var_option.clone().array_isset(rt.new_string('value')))) {
					var_preload_settings.array_set(var_option.array_get(rt.new_string('id')),
						var_option.array_get(rt.new_string('value')))
				}
			}
			var_settings_mutated.array_get_mut('preloadSettings').array_set(var_group,
				var_preload_settings.clone())
		}
	}
	mut var_user_controller :=
		create_automattic_woocommerce_internal_admin_wp_rest_users_controller()
	mut var_request := create_automattic_woocommerce_internal_admin_wp_rest_request()
	var_request.set_query_params(rt.create_array([
		rt.ArrayItem{ key: 'context', val: 'edit' },
	]))
	mut var_user_response := var_user_controller.get_current_item(rt.new_object('Automattic_WooCommerce_Internal_Admin_WP_REST_Request',
		[]string{}, var_request))
	mut var_current_user_data := if rt.is_true(rt.call_function('is_wp_error', [
		var_user_response.clone(),
	]))
	{
		rt.array_to_object(rt.new_array())
	} else {
		rt.call_method(var_user_response, 'get_data', []rt.PhpVal{})
	}
	var_settings_mutated.array_set('currentUserData', var_current_user_data.clone())
	var_settings_mutated.array_set('reviewsEnabled', rt.call_function('get_option', [
		rt.new_string('woocommerce_enable_reviews'),
	]))
	var_settings_mutated.array_set('manageStock', rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	]))
	var_settings_mutated.array_set('commentModeration', rt.call_function('get_option', [
		rt.new_string('comment_moderation'),
	]))
	var_settings_mutated.array_set('notifyLowStockAmount', rt.call_function('get_option', [
		rt.new_string('woocommerce_notify_low_stock_amount'),
	]))
	var_settings_mutated.array_set('wcAdminAssetUrl', rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL'))
	var_settings_mutated.array_set('wcVersion', rt.get_constant('WC_VERSION'))
	var_settings_mutated.array_set('siteUrl', rt.call_function('site_url', []rt.PhpVal{}))
	var_settings_mutated.array_set('shopUrl', rt.call_function('get_permalink', [
		rt.call_function('wc_get_page_id', [rt.new_string('shop')]),
	]))
	var_settings_mutated.array_set('homeUrl', rt.call_function('home_url', []rt.PhpVal{}))
	var_settings_mutated.array_set('dateFormat', rt.call_function('get_option', [
		rt.new_string('date_format'),
	]))
	var_settings_mutated.array_set('timeZone',
		rt.call_function('wc_timezone_string', []rt.PhpVal{}))
	mut iife_temp_25 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_25 := iife_temp_25.get_installed_plugin_slugs()
	mut iife_temp_26 := Class_Automattic_WooCommerce_Internal_Admin_Plugins{}
	mut iife_result_26 := iife_temp_26.get_active_plugins()
	var_settings_mutated.array_set('plugins', rt.create_array([
		rt.ArrayItem{ key: 'installedPlugins', val: iife_result_25 },
		rt.ArrayItem{ key: 'activePlugins', val: iife_result_26 },
	]))
	var_settings_mutated.array_set('woocommerceTranslation', rt.call_function('__', [
		rt.new_string('WooCommerce'),
		rt.new_string('woocommerce'),
	]))
	var_settings_mutated.array_set('unregisteredOrderStatuses',
		Class_Automattic_WooCommerce_Internal_Admin_Loader.get_unregistered_order_statuses())
	var_settings_mutated.array_set('variationTitleAttributesSeparator', rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_variation_title_attributes_separator'),
		rt.new_string(' - '),
		create_automattic_woocommerce_internal_admin_wc_product(),
	]))
	if !(!rt.is_true(var_preload_data_endpoints)) {
		var_settings_mutated.array_set('dataEndpoints', if var_settings_mutated.array_isset(rt.new_string('dataEndpoints')) {
			var_settings_mutated.array_get(rt.new_string('dataEndpoints'))
		} else {
			rt.new_array()
		})
		mut iter_5 := var_preload_data_endpoints.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_endpoint := item_5.val
			mut var_key := item_5.key
			if !rt.is_true(var_preload_data.array_get(var_endpoint)) {
				var_settings_mutated.array_get_mut('dataEndpoints').array_set(var_key,
					rt.new_array())
			} else {
				var_settings_mutated.array_get_mut('dataEndpoints').array_set(var_key,
					var_preload_data.array_get(var_endpoint).array_get(rt.new_string('body')))
			}
		}
	}
	var_settings_mutated =
		Class_Automattic_WooCommerce_Internal_Admin_Loader.get_custom_settings(var_settings_mutated.clone())
	mut iife_temp_27 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_27 := iife_temp_27.is_embed_page()
	if rt.is_true(iife_result_27) {
		var_settings_mutated.array_set('embedBreadcrumbs',
			Class_Automattic_WooCommerce_Internal_Admin_Loader.get_embed_breadcrumbs())
	}
	mut iife_temp_28 := Class_Automattic_WooCommerce_Internal_Admin_WC_Marketplace_Suggestions{}
	mut iife_result_28 := iife_temp_28.allow_suggestions()
	var_settings_mutated.array_set('allowMarketplaceSuggestions', iife_result_28)
	var_settings_mutated.array_set('connectNonce', rt.call_function('wp_create_nonce', [
		rt.new_string('connect'),
	]))
	var_settings_mutated.array_set('wcpay_welcome_page_connect_nonce', rt.call_function('wp_create_nonce', [
		rt.new_string('wcpay-connect'),
	]))
	return var_settings_mutated.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_order_statuses(var_statuses rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.9.0'),
		rt.new_string('\\Automattic\\WooCommerce\\Internal\\Admin\\Settings::get_order_statuses')])
	mut iife_temp_29 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
	mut iife_result_29 := iife_temp_29.get_order_statuses(var_statuses.clone())
	return iife_result_29
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_unregistered_order_statuses() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.9.0')])
	mut var_registered_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut iife_temp_30 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
	mut iife_result_30 := iife_temp_30.get_all_statuses()
	mut var_all_synced_statuses := iife_result_30
	mut var_unregistered_statuses := rt.call_function('array_diff', [
		var_all_synced_statuses.clone(), rt.func_array_keys(var_registered_statuses.clone())])
	mut iife_temp_31 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
	mut iife_result_31 := iife_temp_31.get_order_statuses(rt.call_function('array_fill_keys', [
		var_unregistered_statuses.clone(),
		rt.new_string(''),
	]))
	mut var_formatted_status_keys := iife_result_31
	mut var_formatted_statuses := rt.func_array_keys(var_formatted_status_keys.clone())
	return rt.call_function('array_combine', [var_formatted_statuses.clone(),
		var_formatted_statuses.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_settings_group(var_groups rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.9.0'),
		rt.new_string('\\Automattic\\WooCommerce\\Internal\\Admin\\Settings::add_settings_group')])
	mut iife_temp_32 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
	mut iife_result_32 := iife_temp_32.get_instance()
	return rt.call_method(iife_result_32, 'add_settings_group', [
		var_groups.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.9.0'),
		rt.new_string('\\Automattic\\WooCommerce\\Internal\\Admin\\Settings::add_settings')])
	mut iife_temp_33 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
	mut iife_result_33 := iife_temp_33.get_instance()
	return rt.call_method(iife_result_33, 'add_settings', [var_settings_mutated.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_custom_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.9.0')])
	mut var_wc_rest_settings_options_controller :=
		create_automattic_woocommerce_internal_admin_wc_rest_setting_options_controller()
	mut var_wc_admin_group_settings :=
		var_wc_rest_settings_options_controller.get_group_settings(rt.new_string('wc_admin'))
	var_settings_mutated.array_set('wcAdminSettings', rt.new_array())
	mut iter_6 := var_wc_admin_group_settings.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_setting := item_6.val
		if !(!rt.is_true(var_setting.array_get(rt.new_string('id')))) {
			var_settings_mutated.array_get_mut('wcAdminSettings').array_set(var_setting.array_get(rt.new_string('id')),
				var_setting.array_get(rt.new_string('value')))
		}
	}
	return var_settings_mutated.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.get_currency_settings() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN),
		rt.new_string('9.9.0'),
		rt.new_string('\\Automattic\\WooCommerce\\Internal\\Admin\\Settings::get_currency_settings')])
	mut iife_temp_34 := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
	mut iife_result_34 := iife_temp_34.get_currency_settings()
	return iife_result_34
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.delete_homepage(var_post_id rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_post_type', [
		var_post_id.clone(),
	])))))
	{
		return
	}
	mut var_homepage_id := rt.new_int(rt.call_function('get_option', [
		rt.new_string('woocommerce_onboarding_homepage_post_id'),
		rt.new_bool(false),
	]).to_i64())
	if rt.is_true(rt.identical(var_homepage_id, var_post_id)) {
		rt.call_function('delete_option', [
			rt.new_string('woocommerce_onboarding_homepage_post_id'),
		])
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Loader.add_appearance_theme_view_tracks_event() {
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('appearance_theme_view'),
		rt.new_array(),
	])
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
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

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Plugins {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Product {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Marketplace_Suggestions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_loader() &Class_Automattic_WooCommerce_Internal_Admin_Loader {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Loader{
		PhpObjectBase:          rt.PhpObjectBase{}
		preloaded_dependencies: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminsharedsettings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminSharedSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_translations(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Translations {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminuser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_sitehealth(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_SiteHealth{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_systemstatusreport(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_SystemStatusReport{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wp_rest_users_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Users_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wp_rest_request(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request{
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

fn create_automattic_woocommerce_internal_admin_plugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_product(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Product {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_marketplace_suggestions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Marketplace_Suggestions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_rest_setting_options_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller{
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'preloaded_dependencies' { return this.preloaded_dependencies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'preloaded_dependencies' {
			this.preloaded_dependencies = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Marketplace_Suggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Marketplace_Suggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Marketplace_Suggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
