import rt

struct Class_WC_Admin_Assets {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Assets) construct() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_scripts' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'admin_styles' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'admin_scripts' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_command_palette_assets' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_lost_connection_notice' },
		])])
}

fn (mut this Class_WC_Admin_Assets) render_lost_connection_notice() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen)))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'base'))) {
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_0 := iife_temp_0.is_admin_page()
	mut var_is_wc_admin_page := rt.new_bool(
		rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\Admin\\PageController')]))
		&& rt.is_true(iife_result_0))
	if rt.is_true(var_is_wc_admin_page) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_screen, 'id'),
		rt.call_function('wc_get_screen_ids', []rt.PhpVal{}),
		rt.new_bool(true),
	])))))
	{
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Connection lost.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Saving has been disabled until you are reconnected.'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Assets) admin_styles() {
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_1
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) {
		rt.get_property(var_screen, 'id')
	} else {
		rt.new_string('')
	}
	rt.call_function('wp_register_style', [
		rt.new_string('woocommerce_admin_menu_styles'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/menu.css'),
		rt.new_array(),
		var_version.clone(),
	])
	rt.call_function('wp_register_style', [rt.new_string('woocommerce_admin_styles'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/admin.css'),
		rt.new_array(), var_version.clone()])
	rt.call_function('wp_register_style', [rt.new_string('jquery-ui-style'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/jquery-ui/jquery-ui.min.css'),
		rt.new_array(), var_version.clone()])
	rt.call_function('wp_register_style', [
		rt.new_string('woocommerce_admin_dashboard_styles'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/dashboard.css'),
		rt.new_array(),
		var_version.clone(),
	])
	rt.call_function('wp_register_style', [
		rt.new_string('woocommerce_admin_print_reports_styles'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/reports-print.css'),
		rt.new_array(),
		var_version.clone(),
		rt.new_string('print'),
	])
	rt.call_function('wp_register_style', [
		rt.new_string('woocommerce_admin_marketplace_styles'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/marketplace-suggestions.css'),
		rt.new_array(),
		var_version.clone(),
	])
	rt.call_function('wp_register_style', [
		rt.new_string('woocommerce_admin_privacy_styles'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/privacy.css'),
		rt.new_array(),
		var_version.clone(),
	])
	rt.call_function('wp_style_add_data', [
		rt.new_string('woocommerce_admin_menu_styles'),
		rt.new_string('rtl'),
		rt.new_string('replace'),
	])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce_admin_styles'),
		rt.new_string('rtl'), rt.new_string('replace')])
	rt.call_function('wp_style_add_data', [
		rt.new_string('woocommerce_admin_dashboard_styles'),
		rt.new_string('rtl'),
		rt.new_string('replace'),
	])
	rt.call_function('wp_style_add_data', [
		rt.new_string('woocommerce_admin_print_reports_styles'),
		rt.new_string('rtl'),
		rt.new_string('replace'),
	])
	rt.call_function('wp_style_add_data', [
		rt.new_string('woocommerce_admin_marketplace_styles'),
		rt.new_string('rtl'),
		rt.new_string('replace'),
	])
	rt.call_function('wp_style_add_data', [
		rt.new_string('woocommerce_admin_privacy_styles'),
		rt.new_string('rtl'),
		rt.new_string('replace'),
	])
	if rt.is_true(var_screen)
		&& rt.is_true(rt.call_method(var_screen, 'is_block_editor', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
			rt.call_function('wp_register_style', [
				rt.new_string('woocommerce-classictheme-editor-fonts'),
				rt.new_string(
					(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
					'/assets/css/woocommerce-classictheme-editor-fonts.css'),
				rt.new_array(),
				var_version.clone(),
			])
			rt.call_function('wp_enqueue_style', [
				rt.new_string('woocommerce-classictheme-editor-fonts'),
			])
		}
		mut iife_temp_2 := Class_WC_Frontend_Scripts{}
		mut iife_result_2 := iife_temp_2.get_styles()
		mut var_styles := iife_result_2
		if rt.is_true(var_styles) {
			mut iter_1 := var_styles.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_handle := item_1.key
				rt.call_function('wp_register_style', [var_handle.clone(),
					var_args.array_get(rt.new_string('src')),
					var_args.array_get(rt.new_string('deps')),
					var_args.array_get(rt.new_string('version')),
					var_args.array_get(rt.new_string('media'))])
				if !(var_args.array_isset(rt.new_string('has_rtl'))) {
					rt.call_function('wp_style_add_data', [var_handle.clone(),
						rt.new_string('rtl'), rt.new_string('replace')])
				}
				rt.call_function('wp_enqueue_style', [var_handle.clone()])
			}
		}
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_menu_styles')])
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.call_function('wc_get_screen_ids', []rt.PhpVal{})]))
	{
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_styles')])
		rt.call_function('wp_enqueue_style', [rt.new_string('jquery-ui-style')])
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-color-picker')])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashboard' }])]))
	{
		rt.call_function('wp_enqueue_style', [
			rt.new_string('woocommerce_admin_dashboard_styles'),
		])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_page_wc-reports' },
			rt.ArrayItem{ key: none, val: 'toplevel_page_wc-reports' }])]))
	{
		rt.call_function('wp_enqueue_style', [
			rt.new_string('woocommerce_admin_print_reports_styles'),
		])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('wp-privacy-policy-guide'))
		|| rt.is_true(rt.call_function('in_array', [var_screen_id.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'privacy-policy-guide'
	}])])) {
		rt.call_function('wp_enqueue_style', [
			rt.new_string('woocommerce_admin_privacy_styles'),
		])
	}
	if rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_admin_css')])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_admin_css')])
		rt.call_function('wc_deprecated_function', [
			rt.new_string('The woocommerce_admin_css action'),
			rt.new_string('2.3'),
			rt.new_string('admin_enqueue_scripts'),
		])
	}
	mut iife_temp_3 := Class_WC_Marketplace_Suggestions{}
	mut iife_result_3 := iife_temp_3.show_suggestions_for_screen(var_screen_id.clone())
	if rt.is_true(iife_result_3) {
		rt.call_function('wp_enqueue_style', [
			rt.new_string('woocommerce_admin_marketplace_styles'),
		])
	}
}

fn (mut this Class_WC_Admin_Assets) get_scripts() rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_4) { '' } else { '.min' }).str())
	mut iife_temp_5 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_5 := iife_temp_5.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_5
	mut var_plugin_url := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url',
		[]rt.PhpVal{})
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'woocommerce_admin' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/woocommerce_admin' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wc-jquery-blockui' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-widget' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
				rt.ArrayItem{ key: none, val: 'wc-jquery-tiptip' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'jquery-blockui' },
			rt.ArrayItem{ key: 'handle', val: 'wc-jquery-blockui' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-blockui/jquery.blockUI' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: '2.70' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'in_footer', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'jquery-tiptip' },
			rt.ArrayItem{ key: 'handle', val: 'wc-jquery-tiptip' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-tiptip/jquery.tipTip' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wc-dompurify' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'in_footer', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'round' },
			rt.ArrayItem{ key: 'handle', val: 'wc-round' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() + '/assets/js/round/round' +
				var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-admin-meta-boxes' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() + '/assets/js/admin/meta-boxes' +
				var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-datepicker' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
				rt.ArrayItem{ key: none, val: 'wc-accounting' },
				rt.ArrayItem{ key: none, val: 'wc-round' },
				rt.ArrayItem{ key: none, val: 'wc-enhanced-select' },
				rt.ArrayItem{ key: none, val: 'plupload-all' },
				rt.ArrayItem{ key: none, val: 'wc-stupidtable' },
				rt.ArrayItem{ key: none, val: 'wc-jquery-tiptip' },
				rt.ArrayItem{ key: none, val: 'wc-jquery-blockui' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'qrcode' },
			rt.ArrayItem{ key: 'handle', val: 'wc-qrcode' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-qrcode/jquery.qrcode' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'stupidtable' },
			rt.ArrayItem{ key: 'handle', val: 'wc-stupidtable' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/stupidtable/stupidtable' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'serializejson' },
			rt.ArrayItem{ key: 'handle', val: 'wc-serializejson' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-serializejson/jquery.serializejson' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: '2.8.1' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'flot' },
			rt.ArrayItem{ key: 'handle', val: 'wc-flot' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-flot/jquery.flot' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'flot-resize' },
			rt.ArrayItem{ key: 'handle', val: 'wc-flot-resize' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-flot/jquery.flot.resize' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wc-flot' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'flot-time' },
			rt.ArrayItem{ key: 'handle', val: 'wc-flot-time' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-flot/jquery.flot.time' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wc-flot' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'flot-pie' },
			rt.ArrayItem{ key: 'handle', val: 'wc-flot-pie' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-flot/jquery.flot.pie' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wc-flot' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'flot-stack' },
			rt.ArrayItem{ key: 'handle', val: 'wc-flot-stack' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/jquery-flot/jquery.flot.stack' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wc-flot' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-settings-tax' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/settings-views-html-settings-tax' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'backbone' },
				rt.ArrayItem{ key: none, val: 'wc-jquery-blockui' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-backbone-modal' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/backbone-modal' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'backbone' },
				rt.ArrayItem{ key: none, val: 'wp-util' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-shipping-zones' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/wc-shipping-zones' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'backbone' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
				rt.ArrayItem{ key: none, val: 'wc-enhanced-select' },
				rt.ArrayItem{ key: none, val: 'wc-backbone-modal' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-shipping-zone-methods' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/wc-shipping-zone-methods' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'backbone' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
				rt.ArrayItem{ key: none, val: 'wc-backbone-modal' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-shipping-classes' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/wc-shipping-classes' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'backbone' },
				rt.ArrayItem{ key: none, val: 'wc-backbone-modal' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-shipping-providers' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/wc-shipping-providers' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'backbone' },
				rt.ArrayItem{ key: none, val: 'wc-backbone-modal' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-clipboard' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() + '/assets/js/admin/wc-clipboard' +
				var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'select2' },
			rt.ArrayItem{ key: 'handle', val: 'wc-select2' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/select2/select2.full' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: '4.0.3' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'selectWoo' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/selectWoo/selectWoo.full' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: '1.0.6' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/admin/wc-enhanced-select' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'selectWoo' },
			]) },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'js-cookie' },
			rt.ArrayItem{ key: 'handle', val: 'wc-js-cookie' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/js-cookie/js.cookie' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '2.1.4' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'in_footer', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'dompurify' },
			rt.ArrayItem{ key: 'handle', val: 'wc-dompurify' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() + '/assets/js/dompurify/purify' +
				var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: var_version },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'legacy_handle', val: 'accounting' },
			rt.ArrayItem{ key: 'handle', val: 'wc-accounting' },
			rt.ArrayItem{ key: 'path', val: var_plugin_url.str() +
				'/assets/js/accounting/accounting' + var_suffix.str() + '.js' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]) },
			rt.ArrayItem{ key: 'version', val: '0.4.2' },
		]) },
	])
}

fn (mut this Class_WC_Admin_Assets) register_scripts() {
	mut var_scripts := this.get_scripts()
	mut iter_2 := var_scripts.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_script := item_2.val
		rt.call_function('wp_register_script', [var_script.array_get(rt.new_string('handle')),
			var_script.array_get(rt.new_string('path')), if !(var_script.array_get(rt.new_string('dependencies'))).is_null() {
				var_script.array_get(rt.new_string('dependencies'))
			} else {
				rt.new_array()
			}, if !(var_script.array_get(rt.new_string('version'))).is_null() {
				var_script.array_get(rt.new_string('version'))
			} else {
				rt.new_null()
			}, if !(var_script.array_get(rt.new_string('args'))).is_null() { var_script.array_get(rt.new_string('args')) } else { rt.create_array([
					rt.ArrayItem{ key: 'in_footer', val: false },
				]) }])
		if var_script.array_isset(rt.new_string('legacy_handle')) {
			rt.call_function('wp_register_script', [
				var_script.array_get(rt.new_string('legacy_handle')),
				rt.new_bool(false),
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_script.array_get(rt.new_string('handle')) },
				]),
				if !(var_script.array_get(rt.new_string('version'))).is_null() {
					var_script.array_get(rt.new_string('version'))
				} else {
					rt.new_null()
				},
				rt.new_bool(true),
			])
		}
	}
	rt.call_function('wp_localize_script', [rt.new_string('wc-enhanced-select'),
		rt.new_string('wc_enhanced_select_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'i18n_no_matches', val: rt.call_function('_x', [
				rt.new_string('No matches found'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_ajax_error', val: rt.call_function('_x', [
				rt.new_string('Loading failed'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_input_too_short_1', val: rt.call_function('_x', [
				rt.new_string('Please enter 1 or more characters'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_input_too_short_n', val: rt.call_function('_x', [
				rt.new_string('Please enter %qty% or more characters'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_input_too_long_1', val: rt.call_function('_x', [
				rt.new_string('Please delete 1 character'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_input_too_long_n', val: rt.call_function('_x', [
				rt.new_string('Please delete %qty% characters'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_selection_too_long_1', val: rt.call_function('_x', [
				rt.new_string('You can only select 1 item'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_selection_too_long_n', val: rt.call_function('_x', [
				rt.new_string('You can only select %qty% items'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_load_more', val: rt.call_function('_x', [
				rt.new_string('Loading more results&hellip;'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_searching', val: rt.call_function('_x', [
				rt.new_string('Searching&hellip;'),
				rt.new_string('enhanced select'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php'),
			]) },
			rt.ArrayItem{ key: 'search_products_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-products'),
			]) },
			rt.ArrayItem{ key: 'search_customers_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-customers'),
			]) },
			rt.ArrayItem{ key: 'search_categories_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-categories'),
			]) },
			rt.ArrayItem{ key: 'search_taxonomy_terms_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-taxonomy-terms'),
			]) },
			rt.ArrayItem{ key: 'search_product_attributes_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-product-attributes'),
			]) },
			rt.ArrayItem{ key: 'search_pages_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-pages'),
			]) },
			rt.ArrayItem{ key: 'search_order_metakeys_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-order-metakeys'),
			]) },
		])])
	rt.call_function('wp_localize_script', [rt.new_string('wc-accounting'),
		rt.new_string('accounting_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'mon_decimal_point', val: rt.call_function('wc_get_price_decimal_separator',
				[]rt.PhpVal{}) },
		])])
}

fn (mut this Class_WC_Admin_Assets) admin_scripts() {
	mut var_wp_query := rt.new_null()
	mut var_post := rt.new_null()
	mut var_theorder := rt.new_null()
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) {
		rt.get_property(var_screen, 'id')
	} else {
		rt.new_string('')
	}
	mut var_wc_screen_id := rt.new_string('woocommerce')
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_6) { '' } else { '.min' }).str())
	mut iife_temp_7 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_7 := iife_temp_7.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_7
	rt.call_function('wp_register_script', [rt.new_string('wc-orders'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/wc-orders' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'underscore' },
			rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{
				key: none
				val: 'wc-jquery-blockui'
			}]),
		var_version.clone(), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: false }])])
	rt.call_function('wp_localize_script', [rt.new_string('wc-orders'),
		rt.new_string('wc_orders_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php'),
			]) },
			rt.ArrayItem{ key: 'preview_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('woocommerce-preview-order'),
			]) },
		])])
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.call_function('wc_get_screen_ids', []rt.PhpVal{})]))
	{
		rt.call_function('wp_enqueue_script', [rt.new_string('iris')])
		rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce_admin')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-enhanced-select')])
		mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_PageController{}
		mut iife_result_8 := iife_temp_8.is_admin_page()
		mut var_is_wc_admin_page := rt.new_bool(
			rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\Admin\\PageController')]))
			&& rt.is_true(iife_result_8))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), if !(rt.get_property(var_screen, 'base')).is_null() { rt.get_property(var_screen, 'base') } else { rt.new_string('') }))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_wc_admin_page)))) {
			rt.call_function('wp_enqueue_script', [rt.new_string('autosave')])
		}
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-ui-sortable')])
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-ui-autocomplete')])
		mut var_locale := rt.call_function('localeconv', []rt.PhpVal{})
		mut var_decimal_point := if var_locale.array_isset(rt.new_string('decimal_point')) {
			var_locale.array_get(rt.new_string('decimal_point'))
		} else {
			rt.new_string('.')
		}
		mut var_decimal := if !(!rt.is_true(rt.call_function('wc_get_price_decimal_separator',
			[]rt.PhpVal{}))) {
			rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{})
		} else {
			var_decimal_point
		}
		mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		mut iife_result_9 := iife_temp_9.feature_is_enabled(rt.new_string('product_block_editor'))
		mut var_params := {
			'i18n_decimal_error':                rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please enter a value with one decimal point (%s) without thousand separators.'),
					rt.new_string('woocommerce'),
				]),
				var_decimal.clone(),
			])
			'i18n_mon_decimal_error':            rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Please enter a value with one monetary decimal point (%s) without thousand separators and currency symbols.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}),
			])
			'i18n_country_iso_error':            rt.call_function('__', [
				rt.new_string('Please enter in country code with two capital letters.'),
				rt.new_string('woocommerce'),
			])
			'i18n_sale_less_than_regular_error': rt.call_function('__', [
				rt.new_string('Please enter in a value less than the regular price.'),
				rt.new_string('woocommerce'),
			])
			'i18n_delete_product_notice':        rt.call_function('__', [
				rt.new_string('This product has produced sales and may be linked to existing orders. Are you sure you want to delete it?'),
				rt.new_string('woocommerce'),
			])
			'i18n_remove_personal_data_notice':  rt.call_function('__', [
				rt.new_string('This action cannot be reversed. Are you sure you wish to erase personal data from the selected orders?'),
				rt.new_string('woocommerce'),
			])
			'i18n_confirm_delete':               rt.call_function('__', [
				rt.new_string('Are you sure you wish to delete this item?'),
				rt.new_string('woocommerce'),
			])
			'i18n_global_unique_id_error':       rt.call_function('__', [
				rt.new_string('Please enter only numbers and hyphens (-).'),
				rt.new_string('woocommerce'),
			])
			'decimal_point':                     var_decimal
			'mon_decimal_point':                 rt.call_function('wc_get_price_decimal_separator',
				[]rt.PhpVal{})
			'ajax_url':                          rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php'),
			])
			'strings':                           {
				'import_products':          rt.call_function('__', [
					rt.new_string('Import'),
					rt.new_string('woocommerce'),
				])
				'export_products':          rt.call_function('__', [
					rt.new_string('Export'),
					rt.new_string('woocommerce'),
				])
				'export_selected_products': rt.call_function('__', [
					rt.new_string('Export %d selected'),
					rt.new_string('woocommerce'),
				])
			}
			'nonces':                            {
				'gateway_toggle':                 if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('manage_woocommerce'),
				]))
				{ rt.call_function('wp_create_nonce', [
						rt.new_string('woocommerce-toggle-payment-gateway-enabled'),
					]) } else { rt.new_null() }
				'export_selected_products_nonce': if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('export'),
				]))
				{ rt.call_function('wp_create_nonce', [
						rt.new_string('export-selected-products'),
					]) } else { rt.new_null() }
			}
			'urls':                              {
				'add_product':     if rt.is_true(iife_result_9) { rt.call_function('esc_url_raw', [
						rt.call_function('admin_url', [
							rt.new_string('admin.php?page=wc-admin&path=/add-product'),
						]),
					]) } else { rt.new_null() }
				'import_products': if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('import'),
				]))
				{ rt.call_function('esc_url_raw', [
						rt.call_function('admin_url', [
							rt.new_string('edit.php?post_type=product&page=product_importer'),
						]),
					]) } else { rt.new_null() }
				'export_products': if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('export'),
				]))
				{ rt.call_function('esc_url_raw', [
						rt.call_function('admin_url', [
							rt.new_string('edit.php?post_type=product&page=product_exporter'),
						]),
					]) } else { rt.new_null() }
			}
		}
		rt.call_function('wp_localize_script', [rt.new_string('woocommerce_admin'),
			rt.new_string('woocommerce_admin'), rt.create_array_from_native_map(var_params)])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'edit-product_cat' }])]))
	{
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'edit-product' }])]))
	{
		rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce_quick-edit'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/quick-edit' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'woocommerce_admin' }]),
			var_version.clone()])
		var_params = {
			'strings': {
				'allow_reviews': rt.call_function('esc_js', [
					rt.call_function('__', [rt.new_string('Enable reviews'),
						rt.new_string('woocommerce')]),
				])
			}
		}
		rt.call_function('wp_localize_script', [rt.new_string('woocommerce_quick-edit'),
			rt.new_string('woocommerce_quick_edit'), rt.create_array_from_native_map(var_params)])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
		rt.new_bool(true)]))
	{
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-admin-product-editor'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/product-editor' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
			var_version.clone(), rt.new_bool(false)])
		rt.call_function('wp_localize_script', [rt.new_string('wc-admin-product-editor'),
			rt.new_string('woocommerce_admin_product_editor'),
			rt.create_array([
				rt.ArrayItem{ key: 'i18n_description', val: rt.call_function('esc_js', [
					rt.call_function('__', [rt.new_string('Product description'),
						rt.new_string('woocommerce')]),
				]) },
			])])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'edit-product' }])]))
	{
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		rt.call_function('wp_register_script', [
			rt.new_string('wc-admin-product-meta-boxes'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/meta-boxes-product' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-meta-boxes' },
				rt.ArrayItem{ key: none, val: 'media-models' }]),
			var_version.clone(),
		])
		rt.call_function('wp_register_script', [
			rt.new_string('wc-admin-variation-meta-boxes'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/meta-boxes-product-variation' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-meta-boxes' },
				rt.ArrayItem{ key: none, val: 'wc-serializejson' },
				rt.ArrayItem{ key: none, val: 'media-models' },
				rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{
					key: none
					val: 'jquery-ui-sortable'
				}, rt.ArrayItem{ key: none, val: 'wc-backbone-modal' },
				rt.ArrayItem{ key: none, val: 'wp-data' }, rt.ArrayItem{
					key: none
					val: 'wp-notices'
				}]),
			var_version.clone(),
		])
		rt.call_function('wp_enqueue_script', [
			rt.new_string('wc-admin-product-meta-boxes'),
		])
		rt.call_function('wp_enqueue_script', [
			rt.new_string('wc-admin-variation-meta-boxes'),
		])
		mut iife_temp_10 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_10 := iife_temp_10.is_defined(rt.new_string('WC_MAX_LINKED_VARIATIONS'))
		mut iife_temp_11 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_11 := iife_temp_11.get_constant(rt.new_string('WC_MAX_LINKED_VARIATIONS'))
		mut iife_temp_12 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_12 := iife_temp_12.is_defined(rt.new_string('WC_MAX_LINKED_VARIATIONS'))
		mut iife_temp_13 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_13 := iife_temp_13.get_constant(rt.new_string('WC_MAX_LINKED_VARIATIONS'))
		var_params = {
			'post_id':                             if !(rt.get_property(var_post, 'ID')).is_null() {
				rt.get_property(var_post, 'ID')
			} else {
				rt.new_string('')
			}
			'plugin_url':                          rt.call_method(rt.call_function('WC',
				[]rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})
			'ajax_url':                            rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php'),
			])
			'woocommerce_placeholder_img_src':     rt.call_function('wc_placeholder_img_src',
				[]rt.PhpVal{})
			'add_variation_nonce':                 rt.call_function('wp_create_nonce', [
				rt.new_string('add-variation'),
			])
			'link_variation_nonce':                rt.call_function('wp_create_nonce', [
				rt.new_string('link-variations'),
			])
			'delete_variations_nonce':             rt.call_function('wp_create_nonce', [
				rt.new_string('delete-variations'),
			])
			'load_variations_nonce':               rt.call_function('wp_create_nonce', [
				rt.new_string('load-variations'),
			])
			'save_variations_nonce':               rt.call_function('wp_create_nonce', [
				rt.new_string('save-variations'),
			])
			'bulk_edit_variations_nonce':          rt.call_function('wp_create_nonce', [
				rt.new_string('bulk-edit-variations'),
			])
			'i18n_link_all_variations':            rt.call_function('esc_js', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Do you want to generate all variations? This will create a new variation for each and every possible combination of variation attributes (max %d per run).'),
						rt.new_string('woocommerce'),
					]),
					if rt.is_true(iife_result_10) { iife_result_11 } else { rt.new_int(50) },
				]),
			])
			'i18n_enter_a_value':                  rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('Enter a value'),
					rt.new_string('woocommerce')]),
			])
			'i18n_enter_menu_order':               rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('Variation menu order (determines position in the list of variations)'),
					rt.new_string('woocommerce'),
				]),
			])
			'i18n_enter_a_value_fixed_or_percent': rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('Enter a value (fixed or %)'),
					rt.new_string('woocommerce')]),
			])
			'i18n_sale_price_warning':             rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('Warning: Sale prices will be removed if they are not lower than regular prices.'),
					rt.new_string('woocommerce'),
				]),
			])
			'i18n_delete_all_variations':          rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('Are you sure you want to delete all variations? This cannot be undone.'),
					rt.new_string('woocommerce'),
				]),
			])
			'i18n_last_warning':                   rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('Last warning, are you sure?'),
					rt.new_string('woocommerce')]),
			])
			'i18n_choose_image':                   rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('Choose an image'),
					rt.new_string('woocommerce')]),
			])
			'i18n_set_image':                      rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('Set variation image'),
					rt.new_string('woocommerce')]),
			])
			'i18n_variation_added':                rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('1 variation added'),
					rt.new_string('woocommerce')]),
			])
			'i18n_variations_added':               rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('%qty% variations added'),
					rt.new_string('woocommerce')]),
			])
			'i18n_remove_variation':               rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('Are you sure you want to remove this variation?'),
					rt.new_string('woocommerce'),
				]),
			])
			'i18n_scheduled_sale_start':           rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('Sale start date (YYYY-MM-DD format or leave blank)'),
					rt.new_string('woocommerce'),
				]),
			])
			'i18n_scheduled_sale_end':             rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('Sale end date (YYYY-MM-DD format or leave blank)'),
					rt.new_string('woocommerce'),
				]),
			])
			'i18n_edited_variations':              rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('Save changes before changing page?'),
					rt.new_string('woocommerce'),
				]),
			])
			'i18n_variation_count_single':         rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('1 variation'),
					rt.new_string('woocommerce')]),
			])
			'i18n_variation_count_plural':         rt.call_function('esc_js', [
				rt.call_function('__', [rt.new_string('%qty% variations'),
					rt.new_string('woocommerce')]),
			])
			'i18n_variation_cost_remove_warning':  rt.call_function('esc_js', [
				rt.call_function('__', [
					rt.new_string('The custom cost of goods sold values will revert back to their defaults for all the variations. Would you like to continue?'),
					rt.new_string('woocommerce'),
				]),
			])
			'variations_per_page':                 rt.call_function('absint', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_admin_meta_boxes_variations_per_page'),
					rt.new_int(15),
				]),
			])
		}
		rt.call_function('wp_localize_script', [
			rt.new_string('wc-admin-variation-meta-boxes'),
			rt.new_string('woocommerce_admin_meta_boxes_variations'),
			rt.create_array_from_native_map(var_params),
		])
	}
	if rt.is_true(this.is_order_meta_box_screen(var_screen_id.clone())) {
		mut var_default_location := rt.call_function('wc_get_customer_default_location',
			[]rt.PhpVal{})
		rt.call_function('wp_enqueue_script', [
			rt.new_string('wc-admin-order-meta-boxes'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/meta-boxes-order' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-meta-boxes' },
				rt.ArrayItem{ key: none, val: 'wc-backbone-modal' },
				rt.ArrayItem{ key: none, val: 'selectWoo' }, rt.ArrayItem{
					key: none
					val: 'wc-clipboard'
				}]),
			var_version.clone(),
		])
		rt.call_function('wp_localize_script', [
			rt.new_string('wc-admin-order-meta-boxes'),
			rt.new_string('woocommerce_admin_meta_boxes_order'),
			rt.create_array([
				rt.ArrayItem{ key: 'countries', val: rt.call_function('wp_json_encode', [
					rt.call_function('array_merge', [
						rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
							'countries'), 'get_allowed_country_states', []rt.PhpVal{}),
						rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
							'countries'), 'get_shipping_country_states', []rt.PhpVal{}),
					]),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES')),
				]) },
				rt.ArrayItem{ key: 'i18n_select_state_text', val: rt.call_function('esc_attr__', [
					rt.new_string('Select an option&hellip;'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'default_country'
					val: if var_default_location.array_isset(rt.new_string('country')) {
						var_default_location.array_get(rt.new_string('country'))
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{
					key: 'default_state'
					val: if var_default_location.array_isset(rt.new_string('state')) {
						var_default_location.array_get(rt.new_string('state'))
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{ key: 'placeholder_name', val: rt.call_function('esc_attr__', [
					rt.new_string('Name (required)'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'placeholder_value', val: rt.call_function('esc_attr__', [
					rt.new_string('Value (required)'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'shop_coupon' },
			rt.ArrayItem{ key: none, val: 'edit-shop_coupon' }])]))
	{
		rt.call_function('wp_enqueue_script', [
			rt.new_string('wc-admin-coupon-meta-boxes'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/meta-boxes-coupon' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-meta-boxes' }]),
			var_version.clone(),
		])
		rt.call_function('wp_localize_script', [
			rt.new_string('wc-admin-coupon-meta-boxes'),
			rt.new_string('woocommerce_admin_meta_boxes_coupon'),
			rt.create_array([
				rt.ArrayItem{ key: 'generate_button_text', val: rt.call_function('esc_html__', [
					rt.new_string('Generate coupon code'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'characters', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_coupon_code_generator_characters'),
					rt.new_string('ABCDEFGHJKMNPQRSTUVWXYZ23456789'),
				]) },
				rt.ArrayItem{ key: 'char_length', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_coupon_code_generator_character_length'),
					rt.new_int(8),
				]) },
				rt.ArrayItem{ key: 'prefix', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_coupon_code_generator_prefix'),
					rt.new_string(''),
				]) },
				rt.ArrayItem{ key: 'suffix', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_coupon_code_generator_suffix'),
					rt.new_string(''),
				]) },
			]),
		])
	}
	if rt.is_true(rt.call_function('in_array', [rt.call_function('str_replace', [rt.new_string('edit-'), rt.new_string(''), var_screen_id.clone()]), rt.create_array([rt.ArrayItem{
		key: none
		val: 'shop_coupon'
	}, rt.ArrayItem{ key: none, val: 'product' }]), rt.new_bool(true)]))
		|| rt.is_true(this.is_order_meta_box_screen(var_screen_id.clone())) {
		mut var_post_id := if !(rt.get_property(var_post, 'ID')).is_null() {
			rt.get_property(var_post, 'ID')
		} else {
			rt.new_string('')
		}
		mut var_currency := rt.new_string('')
		mut var_remove_item_notice := rt.call_function('__', [
			rt.new_string('Are you sure you want to remove the selected items?'),
			rt.new_string('woocommerce'),
		])
		mut var_remove_fee_notice := rt.call_function('__', [
			rt.new_string('Are you sure you want to remove the selected fees?'),
			rt.new_string('woocommerce'),
		])
		mut var_remove_shipping_notice := rt.call_function('__', [
			rt.new_string('Are you sure you want to remove the selected shipping?'),
			rt.new_string('woocommerce'),
		])
		mut var_order_or_post_object := var_post
		if rt.is_true(rt.new_bool(rt.instance_of(var_theorder, 'WC_Order')))
			&& rt.is_true(this.is_order_meta_box_screen(var_screen_id.clone())) {
			var_order_or_post_object = var_theorder
			if rt.is_true(var_order_or_post_object) {
				var_currency = rt.call_method(var_order_or_post_object, 'get_currency',
					[]rt.PhpVal{})
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_or_post_object,
					'has_status', [
					rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending()
						},
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed()
						},
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled()
						},
					]),
				])))))
				{
					var_remove_item_notice =
						rt.new_string(var_remove_item_notice.str() + ' ' +(rt.call_function('__', [rt.new_string("You may need to manually restore the item's stock."), rt.new_string('woocommerce')])).str())
				}
			}
		}
		mut iife_temp_14 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_14 := iife_temp_14.get_post_or_order_id(var_order_or_post_object.clone())
		var_params = {
			'remove_item_notice':                              var_remove_item_notice
			'remove_fee_notice':                               var_remove_fee_notice
			'remove_shipping_notice':                          var_remove_shipping_notice
			'i18n_select_items':                               rt.call_function('__', [
				rt.new_string('Please select some items.'),
				rt.new_string('woocommerce'),
			])
			'i18n_do_refund':                                  rt.call_function('__', [
				rt.new_string('Are you sure you wish to process this refund? This action cannot be undone.'),
				rt.new_string('woocommerce'),
			])
			'i18n_delete_refund':                              rt.call_function('__', [
				rt.new_string('Are you sure you wish to delete this refund? This action cannot be undone.'),
				rt.new_string('woocommerce'),
			])
			'i18n_delete_tax':                                 rt.call_function('__', [
				rt.new_string('Are you sure you wish to delete this tax column? This action cannot be undone.'),
				rt.new_string('woocommerce'),
			])
			'remove_item_meta':                                rt.call_function('__', [
				rt.new_string('Remove this item meta?'),
				rt.new_string('woocommerce'),
			])
			'name_label':                                      rt.call_function('__', [
				rt.new_string('Name'),
				rt.new_string('woocommerce'),
			])
			'remove_label':                                    rt.call_function('__', [
				rt.new_string('Remove'),
				rt.new_string('woocommerce'),
			])
			'click_to_toggle':                                 rt.call_function('__', [
				rt.new_string('Click to toggle'),
				rt.new_string('woocommerce'),
			])
			'values_label':                                    rt.call_function('__', [
				rt.new_string('Value(s)'),
				rt.new_string('woocommerce'),
			])
			'text_attribute_tip':                              rt.call_function('__', [
				rt.new_string('Enter some text, or some attributes by pipe (|) separating values.'),
				rt.new_string('woocommerce'),
			])
			'visible_label':                                   rt.call_function('__', [
				rt.new_string('Visible on the product page'),
				rt.new_string('woocommerce'),
			])
			'used_for_variations_label':                       rt.call_function('__', [
				rt.new_string('Used for variations'),
				rt.new_string('woocommerce'),
			])
			'new_attribute_prompt':                            rt.call_function('__', [
				rt.new_string('Enter a name for the new attribute term:'),
				rt.new_string('woocommerce'),
			])
			'calc_totals':                                     rt.call_function('__', [
				rt.new_string('Recalculate totals? This will calculate taxes based on the customers country (or the store base country) and update totals.'),
				rt.new_string('woocommerce'),
			])
			'copy_billing':                                    rt.call_function('__', [
				rt.new_string('Copy billing information to shipping information? This will remove any currently entered shipping information.'),
				rt.new_string('woocommerce'),
			])
			'load_billing':                                    rt.call_function('__', [
				rt.new_string("Load the customer's billing information? This will remove any currently entered billing information."),
				rt.new_string('woocommerce'),
			])
			'load_shipping':                                   rt.call_function('__', [
				rt.new_string("Load the customer's shipping information? This will remove any currently entered shipping information."),
				rt.new_string('woocommerce'),
			])
			'featured_label':                                  rt.call_function('__', [
				rt.new_string('Featured'),
				rt.new_string('woocommerce'),
			])
			'prices_include_tax':                              rt.call_function('esc_attr', [
				rt.call_function('get_option', [
					rt.new_string('woocommerce_prices_include_tax'),
				]),
			])
			'tax_based_on':                                    rt.call_function('esc_attr', [
				rt.call_function('get_option', [
					rt.new_string('woocommerce_tax_based_on'),
				]),
			])
			'round_at_subtotal':                               rt.call_function('esc_attr', [
				rt.call_function('get_option', [
					rt.new_string('woocommerce_tax_round_at_subtotal'),
				]),
			])
			'no_customer_selected':                            rt.call_function('__', [
				rt.new_string('No customer selected'),
				rt.new_string('woocommerce'),
			])
			'plugin_url':                                      rt.call_method(rt.call_function('WC',
				[]rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})
			'ajax_url':                                        rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php'),
			])
			'order_item_nonce':                                rt.call_function('wp_create_nonce', [
				rt.new_string('order-item'),
			])
			'add_attribute_nonce':                             rt.call_function('wp_create_nonce', [
				rt.new_string('add-attribute'),
			])
			'save_attributes_nonce':                           rt.call_function('wp_create_nonce', [
				rt.new_string('save-attributes'),
			])
			'add_attributes_and_variations':                   rt.call_function('wp_create_nonce', [
				rt.new_string('add-attributes-and-variations'),
			])
			'calc_totals_nonce':                               rt.call_function('wp_create_nonce', [
				rt.new_string('calc-totals'),
			])
			'get_customer_details_nonce':                      rt.call_function('wp_create_nonce', [
				rt.new_string('get-customer-details'),
			])
			'search_products_nonce':                           rt.call_function('wp_create_nonce', [
				rt.new_string('search-products'),
			])
			'grant_access_nonce':                              rt.call_function('wp_create_nonce', [
				rt.new_string('grant-access'),
			])
			'revoke_access_nonce':                             rt.call_function('wp_create_nonce', [
				rt.new_string('revoke-access'),
			])
			'add_order_note_nonce':                            rt.call_function('wp_create_nonce', [
				rt.new_string('add-order-note'),
			])
			'delete_order_note_nonce':                         rt.call_function('wp_create_nonce', [
				rt.new_string('delete-order-note'),
			])
			'calendar_image':
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/calendar.png'
			'post_id':                                         if
				rt.is_true(this.is_order_meta_box_screen(var_screen_id.clone()))
				&& !var_order_or_post_object.is_null() {
				iife_result_14
			} else {
				var_post_id
			}
			'base_country':                                    rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})
			'currency_format_num_decimals':                    rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{})
			'currency_format_symbol':                          rt.call_function('get_woocommerce_currency_symbol', [
				var_currency.clone(),
			])
			'currency_format_decimal_sep':                     rt.call_function('esc_attr', [
				rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}),
			])
			'currency_format_thousand_sep':                    rt.call_function('esc_attr', [
				rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{}),
			])
			'currency_format':                                 rt.call_function('esc_attr', [
				rt.call_function('str_replace', [map[string]rt.PhpVal{},
					map[string]rt.PhpVal{},
					rt.call_function('get_woocommerce_price_format',
						[]rt.PhpVal{})]),
			])
			'rounding_precision':                              rt.call_function('wc_get_rounding_precision',
				[]rt.PhpVal{})
			'tax_rounding_mode':                               rt.call_function('wc_get_tax_rounding_mode',
				[]rt.PhpVal{})
			'product_types':                                   rt.call_function('array_unique', [
				rt.call_function('array_merge', [map[string]rt.PhpVal{},
					rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{}))]),
			])
			'i18n_download_permission_fail':                   rt.call_function('__', [
				rt.new_string('Could not grant access - the user may already have permission for this file or billing email is not set. Ensure the billing email is set, and the order has been saved.'),
				rt.new_string('woocommerce'),
			])
			'i18n_permission_revoke':                          rt.call_function('__', [
				rt.new_string('Are you sure you want to revoke access to this download?'),
				rt.new_string('woocommerce'),
			])
			'i18n_tax_rate_already_exists':                    rt.call_function('__', [
				rt.new_string('You cannot add the same tax rate twice!'),
				rt.new_string('woocommerce'),
			])
			'i18n_delete_note':                                rt.call_function('__', [
				rt.new_string('Are you sure you wish to delete this note? This action cannot be undone.'),
				rt.new_string('woocommerce'),
			])
			'i18n_apply_coupon':                               rt.call_function('__', [
				rt.new_string('Enter a coupon code to apply. Discounts are applied to line totals, before taxes.'),
				rt.new_string('woocommerce'),
			])
			'i18n_add_fee':                                    rt.call_function('__', [
				rt.new_string('Enter a fixed amount or percentage to apply as a fee.'),
				rt.new_string('woocommerce'),
			])
			'i18n_attribute_name_placeholder':                 rt.call_function('__', [
				rt.new_string('New attribute'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_simple_tip':                         rt.call_function('__', [
				rt.new_string('<b>Simple –</b> covers the vast majority of any products you may sell. Simple products are shipped and have no options. For example, a book.'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_grouped_tip':                        rt.call_function('__', [
				rt.new_string('<b>Grouped –</b> a collection of related products that can be purchased individually and only consist of simple products. For example, a set of six drinking glasses.'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_external_tip':                       rt.call_function('__', [
				rt.new_string('<b>External or Affiliate –</b> one that you list and describe on your website but is sold elsewhere.'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_variable_tip':                       rt.call_function('__', [
				rt.new_string('<b>Variable –</b> a product with variations, each of which may have a different SKU, price, stock option, etc. For example, a t-shirt available in different colors and/or sizes.'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_other_tip':                          rt.call_function('__', [
				rt.new_string('Product types define available product details and attributes, such as downloadable files and variations. They’re also used for analytics and inventory management.'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_description_tip':                    rt.call_function('__', [
				rt.new_string('Describe this product. What makes it unique? What are its most important features?'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_short_description_tip':              rt.call_function('__', [
				rt.new_string('Summarize this product in 1-2 short sentences. We’ll show it at the top of the page.'),
				rt.new_string('woocommerce'),
			])
			'i18n_save_attribute_variation_tip':               rt.call_function('__', [
				rt.new_string('Make sure you enter the name and values for each attribute.'),
				rt.new_string('woocommerce'),
			])
			'i18n_product_image_tip':                          rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('For best results, upload JPEG or PNG files that are 1000 by 1000 pixels or larger. Maximum upload file size: %1$s.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('size_format', [
					rt.call_function('wp_max_upload_size', []rt.PhpVal{}),
				]),
			])
			'i18n_remove_used_attribute_confirmation_message': rt.call_function('__', [
				rt.new_string('If you remove this attribute, customers will no longer be able to purchase some variations of this product.'),
				rt.new_string('woocommerce'),
			])
			'i18n_add_attribute_error_notice':                 rt.call_function('__', [
				rt.new_string('Adding new attribute failed.'),
				rt.new_string('woocommerce'),
			])
			'i18n_attributes_default_placeholder':             rt.call_function('sprintf', [
				rt.call_function('esc_attr__', [
					rt.new_string('Enter some descriptive text. Use “%s” to separate different values.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_attr', [
					rt.get_constant('WC_DELIMITER'),
				]),
			])
			'i18n_attributes_used_for_variations_placeholder': rt.call_function('sprintf', [
				rt.call_function('esc_attr__', [
					rt.new_string('Enter options for customers to choose from, f.e. “Blue” or “Large”. Use “%s” to separate different options.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_attr', [
					rt.get_constant('WC_DELIMITER'),
				]),
			])
		}
		mut var_cogs_controller := rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
		])
		if rt.is_true(rt.call_method(var_cogs_controller, 'feature_is_enabled', []rt.PhpVal{})) {
			var_params['cogs_value_tooltip_simple_products'] = rt.call_function('esc_attr', [
				rt.call_method(var_cogs_controller, 'get_general_cost_edit_field_tooltip', [
					rt.new_bool(false),
				]),
			])
			var_params['cogs_value_tooltip_variable_products'] = rt.call_function('esc_attr', [
				rt.call_method(var_cogs_controller, 'get_general_cost_edit_field_tooltip', [
					rt.new_bool(true),
				]),
			])
		}
		rt.call_function('wp_localize_script', [rt.new_string('wc-admin-meta-boxes'),
			rt.new_string('woocommerce_admin_meta_boxes'), rt.create_array_from_native_map(var_params)])
	}
	if rt.is_true(rt.call_function('strstr', [var_screen_id.clone(), rt.new_string('edit-pa_')]))
		|| (!(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy'))))
		&& rt.is_true(rt.call_function('in_array', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy'))]), rt.call_function('apply_filters', [rt.new_string('woocommerce_sortable_taxonomies'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product_cat'
	}])])])))
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('orderby'))) {
		rt.call_function('wp_register_script', [
			rt.new_string('woocommerce_term_ordering'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/term-ordering' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }]),
			var_version.clone(),
		])
		rt.call_function('wp_enqueue_script', [
			rt.new_string('woocommerce_term_ordering'),
		])
		mut var_taxonomy := if rt.get_superglobal('_GET').array_isset(rt.new_string('taxonomy')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy'))]),
			]) } else { rt.new_string('') }
		mut var_woocommerce_term_order_params := {
			'taxonomy': var_taxonomy
			'nonce':    rt.call_function('wp_create_nonce', [
				rt.new_string('term-ordering'),
			])
		}
		rt.call_function('wp_localize_script', [
			rt.new_string('woocommerce_term_ordering'),
			rt.new_string('woocommerce_term_ordering_params'),
			rt.create_array_from_native_map(var_woocommerce_term_order_params),
		])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_pages')]))
		&& rt.is_true(rt.identical(rt.new_string('edit-product'), var_screen_id))
		&& rt.get_property(var_wp_query, 'query').array_isset(rt.new_string('orderby'))
		&& rt.is_true(rt.identical(rt.new_string('menu_order title'), rt.get_property(var_wp_query, 'query').array_get(rt.new_string('orderby')))) {
		rt.call_function('wp_register_script', [
			rt.new_string('woocommerce_product_ordering'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/product-ordering' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }]),
			var_version.clone(),
			rt.new_bool(true),
		])
		rt.call_function('wp_enqueue_script', [
			rt.new_string('woocommerce_product_ordering'),
		])
		rt.call_function('wp_localize_script', [
			rt.new_string('woocommerce_product_ordering'),
			rt.new_string('woocommerce_product_ordering_params'),
			rt.create_array([
				rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('product-ordering'),
				]) },
			]),
		])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_reports_screen_ids'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_wc_screen_id.str() + '_page_wc-reports' },
				rt.ArrayItem{ key: none, val: 'toplevel_page_wc-reports' },
			]),
		])]))
	{
		rt.call_function('wp_register_script', [rt.new_string('wc-reports'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/reports' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-datepicker' }]),
			var_version.clone()])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-reports')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-flot')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-flot-resize')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-flot-time')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-flot-pie')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-flot-stack')])
	}
	if rt.is_true(rt.identical(var_wc_screen_id.str() + '_page_wc-settings', var_screen_id))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('section'))
		&& rt.is_true(rt.equal(rt.new_string('keys'), rt.get_superglobal('_GET').array_get(rt.new_string('section')))) {
		rt.call_function('wp_register_script', [rt.new_string('wc-api-keys'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/api-keys' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'woocommerce_admin' },
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'wc-qrcode' }, rt.ArrayItem{
					key: none
					val: 'wc-clipboard'
				}]),
			var_version.clone(), rt.new_bool(true)])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-api-keys')])
		rt.call_function('wp_localize_script', [rt.new_string('wc-api-keys'),
			rt.new_string('woocommerce_admin_api_keys'),
			rt.create_array([
				rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [
					rt.new_string('admin-ajax.php'),
				]) },
				rt.ArrayItem{ key: 'update_api_nonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('update-api-key'),
				]) },
				rt.ArrayItem{ key: 'clipboard_failed', val: rt.call_function('esc_html__', [
					rt.new_string('Copying to clipboard failed. Please press Ctrl/Cmd+C to copy.'),
					rt.new_string('woocommerce'),
				]) },
			])])
	}
	if rt.is_true(rt.identical(var_wc_screen_id.str() + '_page_wc-settings', var_screen_id))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))
		&& rt.is_true(rt.identical(rt.new_string('email'), rt.get_superglobal('_GET').array_get(rt.new_string('tab')))) {
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(var_wc_screen_id.str() + '_page_wc-status', var_screen_id)) {
		rt.call_function('wp_register_script', [rt.new_string('wc-admin-system-status'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/system-status' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wc-clipboard' }]),
			var_version.clone()])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-admin-system-status')])
		rt.call_function('wp_localize_script', [rt.new_string('wc-admin-system-status'),
			rt.new_string('woocommerce_admin_system_status'),
			rt.create_array([
				rt.ArrayItem{ key: 'delete_log_confirmation', val: rt.call_function('esc_js', [
					rt.call_function('__', [
						rt.new_string('Are you sure you want to delete this log?'),
						rt.new_string('woocommerce'),
					]),
				]) },
				rt.ArrayItem{ key: 'run_tool_confirmation', val: rt.call_function('esc_js', [
					rt.call_function('__', [
						rt.new_string('Are you sure you want to run this tool?'),
						rt.new_string('woocommerce'),
					]),
				]) },
			])])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'user-edit' },
			rt.ArrayItem{ key: none, val: 'profile' }])]))
	{
		rt.call_function('wp_register_script', [rt.new_string('wc-users'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/users' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wc-enhanced-select' },
				rt.ArrayItem{ key: none, val: 'selectWoo' }]),
			var_version.clone(), rt.new_bool(true)])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-users')])
		rt.call_function('wp_localize_script', [rt.new_string('wc-users'),
			rt.new_string('wc_users_params'),
			rt.create_array([
				rt.ArrayItem{ key: 'countries', val: rt.call_function('wp_json_encode', [
					rt.call_function('array_merge', [
						rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
							'countries'), 'get_allowed_country_states', []rt.PhpVal{}),
						rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
							'countries'), 'get_shipping_country_states', []rt.PhpVal{}),
					]),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES')),
				]) },
				rt.ArrayItem{ key: 'i18n_select_state_text', val: rt.call_function('esc_attr__', [
					rt.new_string('Select an option&hellip;'),
					rt.new_string('woocommerce'),
				]) },
			])])
	}
	mut iife_temp_15 := Class_WC_Marketplace_Suggestions{}
	mut iife_result_15 := iife_temp_15.show_suggestions_for_screen(var_screen_id.clone())
	if rt.is_true(iife_result_15) {
		mut var_active_plugin_slugs := rt.call_function('array_map', [
			rt.new_string('dirname'),
			rt.call_function('get_option', [rt.new_string('active_plugins')]),
		])
		rt.call_function('wp_register_script', [rt.new_string('marketplace-suggestions'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/js/admin/marketplace-suggestions' + var_suffix.str() + '.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'underscore' },
				rt.ArrayItem{ key: none, val: 'wc-js-cookie' }]),
			var_version.clone(), rt.new_bool(true)])
		mut iife_temp_16 := Class_WC_Marketplace_Suggestions{}
		mut iife_result_16 := iife_temp_16.get_dismissed_suggestions()
		mut iife_temp_17 := Class_WC_Marketplace_Suggestions{}
		mut iife_result_17 := iife_temp_17.get_suggestions_api_data()
		mut iife_temp_18 := Class_WC_Admin_Addons{}
		mut iife_result_18 := iife_temp_18.get_in_app_purchase_url_params()
		rt.call_function('wp_localize_script', [rt.new_string('marketplace-suggestions'),
			rt.new_string('marketplace_suggestions'),
			rt.create_array([
				rt.ArrayItem{ key: 'dismiss_suggestion_nonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('add_dismissed_marketplace_suggestion'),
				]) },
				rt.ArrayItem{ key: 'active_plugins', val: var_active_plugin_slugs },
				rt.ArrayItem{ key: 'dismissed_suggestions', val: iife_result_16 },
				rt.ArrayItem{ key: 'suggestions_data', val: iife_result_17 },
				rt.ArrayItem{ key: 'manage_suggestions_url', val: rt.call_function('admin_url', [
					rt.new_string('admin.php?page=wc-settings&tab=advanced&section=woocommerce_com'),
				]) },
				rt.ArrayItem{ key: 'in_app_purchase_params', val: iife_result_18 },
				rt.ArrayItem{ key: 'admin_base_url', val: rt.call_function('admin_url',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'i18n_marketplace_suggestions_default_cta', val: rt.call_function('esc_html__', [
					rt.new_string('Learn More'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'i18n_marketplace_suggestions_dismiss_tooltip', val: rt.call_function('esc_attr__', [
					rt.new_string('Dismiss this suggestion'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'i18n_marketplace_suggestions_manage_suggestions', val: rt.call_function('esc_html__', [
					rt.new_string('Manage suggestions'),
					rt.new_string('woocommerce'),
				]) },
			])])
		rt.call_function('wp_enqueue_script', [rt.new_string('marketplace-suggestions')])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'edit-shop_coupon' },
			rt.ArrayItem{ key: none, val: 'woocommerce_page_wc-admin' }]),
		rt.new_bool(true)]))
	{
		mut iife_temp_19 := Class_WC_Admin_Marketplace_Promotions{}
		mut iife_result_19 := iife_temp_19.get_active_promotions()
		mut var_promotions := iife_result_19
		if rt.is_true(rt.identical(rt.new_bool(false), var_promotions)) {
			return
		}
		rt.call_function('wp_add_inline_script', [rt.new_string('wc-admin-app'),
			rt.new_string('window.wcMarketplace = ' +(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{
				key: 'promotions'
				val: var_promotions
			}]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str()),
			rt.new_string('before')])
	}
}

fn (mut this Class_WC_Admin_Assets) enqueue_script(script_path_name string, script_name string) {
	mut iife_temp_20 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_20 := iife_temp_20.get_script_asset_filename(rt.new_string(script_path_name),
		rt.new_string(script_name))
	mut var_script_assets_filename := iife_result_20
	mut var_script_assets := rt.include_file((rt.get_constant('WC_ADMIN_ABSPATH')).str() +
		(rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + script_path_name + '/' +
		var_script_assets_filename.str(), '3')
	mut iife_temp_21 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_21 := iife_temp_21.get_url(rt.new_string(script_path_name + '/' + script_name),
		rt.new_string('js'))
	mut iife_temp_22 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_22 := iife_temp_22.get_file_version(rt.new_string('js'),
		var_script_assets.array_get(rt.new_string('version')))
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-admin-' + script_name), iife_result_21,
		var_script_assets.array_get(rt.new_string('dependencies')), iife_result_22, rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Assets) enqueue_command_palette_assets() {
	this.enqueue_script('wp-admin-scripts', 'command-palette')
	mut var_admin_features_disabled := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_disabled'),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_admin_features_disabled)))) {
		mut iife_temp_23 := Class_Automattic_WooCommerce_Internal_Admin_Analytics{}
		mut iife_result_23 := iife_temp_23.get_report_pages()
		mut var_analytics_reports := iife_result_23
		if var_analytics_reports.clone().is_array()
			&& var_analytics_reports.clone().array_count() > 0 {
			closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_report := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				if !(var_report.clone().is_array()) {
					return
				}
				mut var_title := if rt.is_true(rt.new_bool(var_report.clone().array_isset(rt.new_string('title')))) {
					var_report.array_get(rt.new_string('title'))
				} else {
					rt.new_string('')
				}
				mut var_path := if rt.is_true(rt.new_bool(var_report.clone().array_isset(rt.new_string('path')))) {
					var_report.array_get(rt.new_string('path'))
				} else {
					rt.new_string('')
				}
				if var_title.clone().is_string()
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_title, rt.new_string('')))))
					&& var_path.clone().is_string()
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_path, rt.new_string(''))))) {
					return
				}
				return
			}
			closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_report := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				if !(var_report.clone().is_array()) {
					return
				}
				mut var_title := if rt.is_true(rt.new_bool(var_report.clone().array_isset(rt.new_string('title')))) {
					var_report.array_get(rt.new_string('title'))
				} else {
					rt.new_string('')
				}
				mut var_path := if rt.is_true(rt.new_bool(var_report.clone().array_isset(rt.new_string('path')))) {
					var_report.array_get(rt.new_string('path'))
				} else {
					rt.new_string('')
				}
				if var_title.clone().is_string()
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_title, rt.new_string('')))))
					&& var_path.clone().is_string()
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_path, rt.new_string(''))))) {
					return
				}
				return
			}
			mut var_formatted_analytics_reports := rt.call_function('array_map', [
				rt.new_closure(closure_25_fn),
				var_analytics_reports.clone(),
			])
			var_formatted_analytics_reports = rt.call_function('array_filter', [
				var_formatted_analytics_reports.clone(),
				rt.new_string('is_array'),
			])
			this.enqueue_script('wp-admin-scripts', 'command-palette-analytics')
			rt.call_function('wp_localize_script', [
				rt.new_string('wc-admin-command-palette-analytics'),
				rt.new_string('wcCommandPaletteAnalytics'),
				rt.create_array([
					rt.ArrayItem{ key: 'reports', val: var_formatted_analytics_reports },
				]),
			])
		}
	}
}

fn (mut this Class_WC_Admin_Assets) is_order_meta_box_screen(var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_screen_id_mutated := var_screen_id
	var_screen_id_mutated = rt.call_function('str_replace', [
		rt.new_string('edit-'), rt.new_string(''), var_screen_id_mutated.clone()])
	mut var_types_with_metaboxes_screen_ids := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('wc_get_page_screen_id'),
			rt.call_function('wc_get_order_types', [rt.new_string('order-meta-boxes')])]),
	])
	return rt.call_function('in_array', [var_screen_id_mutated.clone(),
		var_types_with_metaboxes_screen_ids.clone(), rt.new_bool(true)])
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Frontend_Scripts {
	rt.PhpObjectBase
}

struct Class_WC_Marketplace_Suggestions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Addons {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Marketplace_Promotions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Analytics {
	rt.PhpObjectBase
}

fn create_wc_admin_assets() &Class_WC_Admin_Assets {
	mut obj := &Class_WC_Admin_Assets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_frontend_scripts(_args ...rt.PhpVal) &Class_WC_Frontend_Scripts {
	mut obj := &Class_WC_Frontend_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_marketplace_suggestions(_args ...rt.PhpVal) &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_addons(_args ...rt.PhpVal) &Class_WC_Admin_Addons {
	mut obj := &Class_WC_Admin_Addons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_marketplace_promotions(_args ...rt.PhpVal) &Class_WC_Admin_Marketplace_Promotions {
	mut obj := &Class_WC_Admin_Marketplace_Promotions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_analytics(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Analytics {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Analytics{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Assets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'render_lost_connection_notice' {
			this.render_lost_connection_notice()
			return rt.new_null()
		}
		'admin_styles' {
			this.admin_styles()
			return rt.new_null()
		}
		'get_scripts' {
			return this.get_scripts()
		}
		'register_scripts' {
			this.register_scripts()
			return rt.new_null()
		}
		'admin_scripts' {
			this.admin_scripts()
			return rt.new_null()
		}
		'enqueue_script' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.enqueue_script(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'enqueue_command_palette_assets' {
			this.enqueue_command_palette_assets()
			return rt.new_null()
		}
		'is_order_meta_box_screen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_order_meta_box_screen(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Assets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Assets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Frontend_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Frontend_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Frontend_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Marketplace_Suggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Addons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Addons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Addons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Marketplace_Promotions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Marketplace_Promotions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Marketplace_Promotions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Analytics) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Analytics) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Assets'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Admin_Assets', []string{}, create_wc_admin_assets())
}
