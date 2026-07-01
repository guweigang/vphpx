import rt

struct Class_WC_Admin_Assets {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Assets) construct()  {
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_styles' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_command_palette_assets' }])])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Assets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_lost_connection_notice' }])])
}

fn (mut this Class_WC_Admin_Assets) render_lost_connection_notice()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'base'))) {
		return rt.new_null()
	}
	mut var_is_wc_admin_page := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\Admin\\PageController')])) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))
	if rt.is_true(var_is_wc_admin_page) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_screen, 'id'), rt.call_function('wc_get_screen_ids', []rt.PhpVal{}), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Connection lost.')])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Saving has been disabled until you are reconnected.')])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Assets) admin_styles()  {
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	rt.call_function('wp_register_style', [rt.new_string('woocommerce_admin_menu_styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/menu.css', rt.new_array(), var_version.dup()])
	rt.call_function('wp_register_style', [rt.new_string('woocommerce_admin_styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/admin.css', rt.new_array(), var_version.dup()])
	rt.call_function('wp_register_style', [rt.new_string('jquery-ui-style'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/jquery-ui/jquery-ui.min.css', rt.new_array(), var_version.dup()])
	rt.call_function('wp_register_style', [rt.new_string('woocommerce_admin_dashboard_styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/dashboard.css', rt.new_array(), var_version.dup()])
	rt.call_function('wp_register_style', [rt.new_string('woocommerce_admin_print_reports_styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/reports-print.css', rt.new_array(), var_version.dup(), rt.new_string('print')])
	rt.call_function('wp_register_style', [rt.new_string('woocommerce_admin_marketplace_styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/marketplace-suggestions.css', rt.new_array(), var_version.dup()])
	rt.call_function('wp_register_style', [rt.new_string('woocommerce_admin_privacy_styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/privacy.css', rt.new_array(), var_version.dup()])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce_admin_menu_styles'), rt.new_string('rtl'), rt.new_string('replace')])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce_admin_styles'), rt.new_string('rtl'), rt.new_string('replace')])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce_admin_dashboard_styles'), rt.new_string('rtl'), rt.new_string('replace')])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce_admin_print_reports_styles'), rt.new_string('rtl'), rt.new_string('replace')])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce_admin_marketplace_styles'), rt.new_string('rtl'), rt.new_string('replace')])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce_admin_privacy_styles'), rt.new_string('rtl'), rt.new_string('replace')])
	if rt.is_true(rt.new_bool(rt.is_true(var_screen) && rt.is_true(rt.call_method(var_screen, 'is_block_editor', []rt.PhpVal{})))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
			rt.call_function('wp_register_style', [rt.new_string('woocommerce-classictheme-editor-fonts'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/woocommerce-classictheme-editor-fonts.css', rt.new_array(), var_version.dup()])
			rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-classictheme-editor-fonts')])
		}
		mut var_styles := fn () rt.PhpVal { mut temp := Class_WC_Frontend_Scripts{}; return temp.get_styles() }()
		if rt.is_true(var_styles) {
			{
				mut iter_1 := var_styles.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_args := item_1.val
					mut var_handle := item_1.key
					rt.call_function('wp_register_style', [var_handle.dup(), var_args.array_get('src'), var_args.array_get('deps'), var_args.array_get('version'), var_args.array_get('media')])
					if !(var_args.array_isset(rt.new_string('has_rtl'))) {
						rt.call_function('wp_style_add_data', [var_handle.dup(), rt.new_string('rtl'), rt.new_string('replace')])
					}
					rt.call_function('wp_enqueue_style', [var_handle.dup()])
				}
			}
		}
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_menu_styles')])
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.call_function('wc_get_screen_ids', []rt.PhpVal{})])) {
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_styles')])
		rt.call_function('wp_enqueue_style', [rt.new_string('jquery-ui-style')])
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-color-picker')])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'dashboard' }])])) {
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_dashboard_styles')])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_page_wc-reports' }, rt.ArrayItem{ key: none, val: 'toplevel_page_wc-reports' }])])) {
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_print_reports_styles')])
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('wp-privacy-policy-guide')) || rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'privacy-policy-guide' }])])))) {
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_privacy_styles')])
	}
	if rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_admin_css')])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_admin_css')])
		rt.call_function('wc_deprecated_function', [rt.new_string('The woocommerce_admin_css action'), rt.new_string('2.3'), rt.new_string('admin_enqueue_scripts')])
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Marketplace_Suggestions{}; return temp.show_suggestions_for_screen(arg_0) }(var_screen_id.dup())) {
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce_admin_marketplace_styles')])
	}
}

fn (mut this Class_WC_Admin_Assets) get_scripts() rt.PhpVal {
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	mut var_plugin_url := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'woocommerce_admin' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/woocommerce_admin' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wc-jquery-blockui' }, rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }, rt.ArrayItem{ key: none, val: 'jquery-ui-widget' }, rt.ArrayItem{ key: none, val: 'jquery-ui-core' }, rt.ArrayItem{ key: none, val: 'wc-jquery-tiptip' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'jquery-blockui' }, rt.ArrayItem{ key: 'handle', val: 'wc-jquery-blockui' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-blockui/jquery.blockUI' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: '2.70' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'jquery-tiptip' }, rt.ArrayItem{ key: 'handle', val: 'wc-jquery-tiptip' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-tiptip/jquery.tipTip' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wc-dompurify' }]) }, rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'round' }, rt.ArrayItem{ key: 'handle', val: 'wc-round' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/round/round' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-admin-meta-boxes' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/meta-boxes' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'jquery-ui-datepicker' }, rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }, rt.ArrayItem{ key: none, val: 'wc-accounting' }, rt.ArrayItem{ key: none, val: 'wc-round' }, rt.ArrayItem{ key: none, val: 'wc-enhanced-select' }, rt.ArrayItem{ key: none, val: 'plupload-all' }, rt.ArrayItem{ key: none, val: 'wc-stupidtable' }, rt.ArrayItem{ key: none, val: 'wc-jquery-tiptip' }, rt.ArrayItem{ key: none, val: 'wc-jquery-blockui' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'qrcode' }, rt.ArrayItem{ key: 'handle', val: 'wc-qrcode' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-qrcode/jquery.qrcode' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'stupidtable' }, rt.ArrayItem{ key: 'handle', val: 'wc-stupidtable' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/stupidtable/stupidtable' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'serializejson' }, rt.ArrayItem{ key: 'handle', val: 'wc-serializejson' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-serializejson/jquery.serializejson' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: '2.8.1' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'flot' }, rt.ArrayItem{ key: 'handle', val: 'wc-flot' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-flot/jquery.flot' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'flot-resize' }, rt.ArrayItem{ key: 'handle', val: 'wc-flot-resize' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-flot/jquery.flot.resize' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wc-flot' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'flot-time' }, rt.ArrayItem{ key: 'handle', val: 'wc-flot-time' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-flot/jquery.flot.time' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wc-flot' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'flot-pie' }, rt.ArrayItem{ key: 'handle', val: 'wc-flot-pie' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-flot/jquery.flot.pie' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wc-flot' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'flot-stack' }, rt.ArrayItem{ key: 'handle', val: 'wc-flot-stack' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/jquery-flot/jquery.flot.stack' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wc-flot' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-settings-tax' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/settings-views-html-settings-tax' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'wc-jquery-blockui' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-backbone-modal' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/backbone-modal' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'wp-util' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-shipping-zones' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/wc-shipping-zones' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }, rt.ArrayItem{ key: none, val: 'wc-enhanced-select' }, rt.ArrayItem{ key: none, val: 'wc-backbone-modal' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-shipping-zone-methods' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/wc-shipping-zone-methods' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }, rt.ArrayItem{ key: none, val: 'wc-backbone-modal' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-shipping-classes' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/wc-shipping-classes' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'wc-backbone-modal' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-shipping-providers' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/wc-shipping-providers' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'wc-backbone-modal' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-clipboard' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/wc-clipboard' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'select2' }, rt.ArrayItem{ key: 'handle', val: 'wc-select2' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/select2/select2.full' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: '4.0.3' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'selectWoo' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/selectWoo/selectWoo.full' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: '1.0.6' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-enhanced-select' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/admin/wc-enhanced-select' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'selectWoo' }]) }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'js-cookie' }, rt.ArrayItem{ key: 'handle', val: 'wc-js-cookie' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/js-cookie/js.cookie' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.new_array() }, rt.ArrayItem{ key: 'version', val: '2.1.4' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'dompurify' }, rt.ArrayItem{ key: 'handle', val: 'wc-dompurify' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/dompurify/purify' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.new_array() }, rt.ArrayItem{ key: 'version', val: var_version }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'legacy_handle', val: 'accounting' }, rt.ArrayItem{ key: 'handle', val: 'wc-accounting' }, rt.ArrayItem{ key: 'path', val: (var_plugin_url).str() + '/assets/js/accounting/accounting' + (var_suffix).str() + '.js' }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]) }, rt.ArrayItem{ key: 'version', val: '0.4.2' }]) }])
}

fn (mut this Class_WC_Admin_Assets) register_scripts()  {
	mut var_scripts := this.get_scripts()
	{
		mut iter_1 := var_scripts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_script := item_1.val
			rt.call_function('wp_register_script', [var_script.array_get('handle'), var_script.array_get('path'), if !(var_script.array_get('dependencies')).is_null() { var_script.array_get('dependencies') } else { rt.new_array() }, if !(var_script.array_get('version')).is_null() { var_script.array_get('version') } else { rt.new_null() }, if !(var_script.array_get('args')).is_null() { var_script.array_get('args') } else { rt.create_array([rt.ArrayItem{ key: 'in_footer', val: false }]) }])
			if var_script.array_isset(rt.new_string('legacy_handle')) {
				rt.call_function('wp_register_script', [var_script.array_get('legacy_handle'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: none, val: var_script.array_get('handle') }]), if !(var_script.array_get('version')).is_null() { var_script.array_get('version') } else { rt.new_null() }, rt.new_bool(true)])
			}
		}
	}
	rt.call_function('wp_localize_script', [rt.new_string('wc-enhanced-select'), rt.new_string('wc_enhanced_select_params'), rt.create_array([rt.ArrayItem{ key: 'i18n_no_matches', val: rt.call_function('_x', [rt.new_string('No matches found'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_ajax_error', val: rt.call_function('_x', [rt.new_string('Loading failed'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_input_too_short_1', val: rt.call_function('_x', [rt.new_string('Please enter 1 or more characters'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_input_too_short_n', val: rt.call_function('_x', [rt.new_string('Please enter %qty% or more characters'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_input_too_long_1', val: rt.call_function('_x', [rt.new_string('Please delete 1 character'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_input_too_long_n', val: rt.call_function('_x', [rt.new_string('Please delete %qty% characters'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_selection_too_long_1', val: rt.call_function('_x', [rt.new_string('You can only select 1 item'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_selection_too_long_n', val: rt.call_function('_x', [rt.new_string('You can only select %qty% items'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_load_more', val: rt.call_function('_x', [rt.new_string('Loading more results&hellip;'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_searching', val: rt.call_function('_x', [rt.new_string('Searching&hellip;'), rt.new_string('enhanced select'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]) }, rt.ArrayItem{ key: 'search_products_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('search-products')]) }, rt.ArrayItem{ key: 'search_customers_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('search-customers')]) }, rt.ArrayItem{ key: 'search_categories_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('search-categories')]) }, rt.ArrayItem{ key: 'search_taxonomy_terms_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('search-taxonomy-terms')]) }, rt.ArrayItem{ key: 'search_product_attributes_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('search-product-attributes')]) }, rt.ArrayItem{ key: 'search_pages_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('search-pages')]) }, rt.ArrayItem{ key: 'search_order_metakeys_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('search-order-metakeys')]) }])])
	rt.call_function('wp_localize_script', [rt.new_string('wc-accounting'), rt.new_string('accounting_params'), rt.create_array([rt.ArrayItem{ key: 'mon_decimal_point', val: rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}) }])])
}

fn (mut this Class_WC_Admin_Assets) admin_scripts()  {
	mut var_wp_query := rt.new_null()
	mut var_post := rt.new_null()
	mut var_theorder := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	mut var_wc_screen_id := rt.new_string(rt.new_string('woocommerce'))
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	rt.call_function('wp_register_script', [rt.new_string('wc-orders'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/admin/wc-orders' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'wc-jquery-blockui' }]), var_version.dup(), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: false }])])
	rt.call_function('wp_localize_script', [rt.new_string('wc-orders'), rt.new_string('wc_orders_params'), rt.create_array([rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]) }, rt.ArrayItem{ key: 'preview_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('woocommerce-preview-order')]) }])])
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.call_function('wc_get_screen_ids', []rt.PhpVal{})])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('iris')])
		rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce_admin')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-enhanced-select')])
		mut var_is_wc_admin_page := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\Admin\\PageController')])) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_wc_admin_page)))))) {
			rt.call_function('wp_enqueue_script', [rt.new_string('autosave')])
		}
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-ui-sortable')])
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-ui-autocomplete')])
		mut var_locale := rt.call_function('localeconv', []rt.PhpVal{})
		mut var_decimal_point := if var_locale.array_isset(rt.new_string('decimal_point')) { var_locale.array_get('decimal_point') } else { rt.new_string('.') }
		mut var_decimal := if !(!rt.is_true(rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}))) { rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}) } else { var_decimal_point }
		mut var_params := { 'i18n_decimal_error': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please enter a value with one decimal point (%s) without thousand separators.'), rt.new_string('woocommerce')]), var_decimal.dup()]), 'i18n_mon_decimal_error': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please enter a value with one monetary decimal point (%s) without thousand separators and currency symbols.'), rt.new_string('woocommerce')]), rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{})]), 'i18n_country_iso_error': rt.call_function('__', [rt.new_string('Please enter in country code with two capital letters.'), rt.new_string('woocommerce')]), 'i18n_sale_less_than_regular_error': rt.call_function('__', [rt.new_string('Please enter in a value less than the regular price.'), rt.new_string('woocommerce')]), 'i18n_delete_product_notice': rt.call_function('__', [rt.new_string('This product has produced sales and may be linked to existing orders. Are you sure you want to delete it?'), rt.new_string('woocommerce')]), 'i18n_remove_personal_data_notice': rt.call_function('__', [rt.new_string('This action cannot be reversed. Are you sure you wish to erase personal data from the selected orders?'), rt.new_string('woocommerce')]), 'i18n_confirm_delete': rt.call_function('__', [rt.new_string('Are you sure you wish to delete this item?'), rt.new_string('woocommerce')]), 'i18n_global_unique_id_error': rt.call_function('__', [rt.new_string('Please enter only numbers and hyphens (-).'), rt.new_string('woocommerce')]), 'decimal_point': var_decimal, 'mon_decimal_point': rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}), 'ajax_url': rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]), 'strings': { 'import_products': rt.call_function('__', [rt.new_string('Import'), rt.new_string('woocommerce')]), 'export_products': rt.call_function('__', [rt.new_string('Export'), rt.new_string('woocommerce')]), 'export_selected_products': rt.call_function('__', [rt.new_string('Export %d selected'), rt.new_string('woocommerce')]) }, 'nonces': { 'gateway_toggle': if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) { rt.call_function('wp_create_nonce', [rt.new_string('woocommerce-toggle-payment-gateway-enabled')]) } else { rt.new_null() }, 'export_selected_products_nonce': if rt.is_true(rt.call_function('current_user_can', [rt.new_string('export')])) { rt.call_function('wp_create_nonce', [rt.new_string('export-selected-products')]) } else { rt.new_null() } }, 'urls': { 'add_product': if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('product_block_editor'))) { rt.call_function('esc_url_raw', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/add-product')])]) } else { rt.new_null() }, 'import_products': if rt.is_true(rt.call_function('current_user_can', [rt.new_string('import')])) { rt.call_function('esc_url_raw', [rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product&page=product_importer')])]) } else { rt.new_null() }, 'export_products': if rt.is_true(rt.call_function('current_user_can', [rt.new_string('export')])) { rt.call_function('esc_url_raw', [rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product&page=product_exporter')])]) } else { rt.new_null() } } }
		rt.call_function('wp_localize_script', [rt.new_string('woocommerce_admin'), rt.new_string('woocommerce_admin'), var_params.dup()])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'edit-product_cat' }])])) {
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'edit-product' }])])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce_quick-edit'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/admin/quick-edit' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin' }]), var_version.dup()])
		var_params = { 'strings': { 'allow_reviews': rt.call_function('esc_js', []) } }
		rt.call_function('wp_localize_script', [rt.new_string('woocommerce_quick-edit'), rt.new_string('woocommerce_quick_edit'), var_params.dup()])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]), rt.new_bool(true)])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-admin-product-editor'),  + ().str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]), var_version.dup(), rt.new_bool(false)])
		rt.call_function('wp_localize_script', [rt.new_string('wc-admin-product-editor'), rt.new_string('woocommerce_admin_product_editor'), rt.create_array([rt.ArrayItem{ key: , val:  }])])
	}
	if rt.is_true(rt.call_function('in_array', [var_screen_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }])])) {
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
}

fn (mut this Class_WC_Admin_Assets) enqueue_script(script_path_name string, script_name string)  {
	
}

fn (mut this Class_WC_Admin_Assets) enqueue_command_palette_assets()  {
}

fn (mut this Class_WC_Admin_Assets) is_order_meta_box_screen(var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_screen_id_mutated := var_screen_id
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

fn create_wc_admin_assets() &Class_WC_Admin_Assets {
	mut obj := &Class_WC_Admin_Assets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_frontend_scripts() &Class_WC_Frontend_Scripts {
	mut obj := &Class_WC_Frontend_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_marketplace_suggestions() &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_assets_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Assets'), rt.new_bool(false)]))))) {
	}
	return 
}
