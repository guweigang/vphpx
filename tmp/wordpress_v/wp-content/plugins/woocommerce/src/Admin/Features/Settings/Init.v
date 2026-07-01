import rt

struct Class_Automattic_WooCommerce_Admin_Features_Settings_Init {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) construct()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_component_settings' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Settings_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_settings_editor_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Settings_Init', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_settings_editor_styles' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) is_settings_page() bool {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	return rt.is_true(var_screen) && rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(var_screen, 'id')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) enqueue_settings_editor_styles()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_instance(), 'is_settings_page', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_style_name := rt.new_string(rt.new_string('wc-admin-edit-settings'))
	mut var_style_path_name := rt.new_string(rt.new_string('settings'))
	mut var_style_assets_filename := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.get_script_asset_filename(arg_0, arg_1) }(var_style_path_name.dup(), rt.new_string('style'))
	mut var_style_assets := rt.include_file((rt.get_constant('WC_ADMIN_ABSPATH')).str() + (rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + (var_style_path_name).str() + '/' + (var_style_assets_filename).str(), '3')
	rt.call_function('wp_register_style', [var_style_name.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.get_url(arg_0, arg_1) }(rt.new_string((var_style_path_name).str() + '/style'), rt.new_string('css')), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-components' }, rt.ArrayItem{ key: none, val: 'wc-components' }]), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.get_file_version(arg_0, arg_1) }(rt.new_string('css'), var_style_assets.array_get('version'))])
	rt.call_function('wp_enqueue_style', [var_style_name.dup()])
	rt.call_function('wp_register_style', [rt.new_string('wc-global-presets'), rt.new_bool(false)])
	rt.call_function('wp_add_inline_style', [rt.new_string('wc-global-presets'), rt.call_function('wp_get_global_stylesheet', [rt.create_array([rt.ArrayItem{ key: none, val: 'presets' }])])])
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-global-presets')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) enqueue_settings_editor_scripts()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_instance(), 'is_settings_page', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-settings-editor')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-settings-editor')])
	mut var_script_name := rt.new_string(rt.new_string('wc-admin-edit-settings'))
	mut var_script_path_name := rt.new_string(rt.new_string('settings'))
	mut var_script_assets_filename := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.get_script_asset_filename(arg_0, arg_1) }(var_script_path_name.dup(), rt.new_string('index'))
	mut var_script_assets := rt.include_file((rt.get_constant('WC_ADMIN_ABSPATH')).str() + (rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + (var_script_path_name).str() + '/' + (var_script_assets_filename).str(), '3')
	rt.call_function('wp_enqueue_script', [var_script_name.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.get_url(arg_0, arg_1) }(rt.new_string((var_script_path_name).str() + '/index'), rt.new_string('js')), var_script_assets.array_get('dependencies'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.get_file_version(arg_0, arg_1) }(rt.new_string('js'), var_script_assets.array_get('version')), rt.new_bool(true)])
	rt.call_function('wp_set_script_translations', ['wc-admin-' + (var_script_name).str(), rt.new_string('woocommerce')])
}

fn Class_Automattic_WooCommerce_Admin_Features_Settings_Init.add_component_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_instance(), 'is_settings_page', []rt.PhpVal{}))))) {
		return var_settings_mutated.dup()
	}
	// unsupported statement: Stmt_Global
	mut var_ignored_settings_scripts := rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-app' }, rt.ArrayItem{ key: none, val: 'woocommerce_admin' }, rt.ArrayItem{ key: none, val: 'wc-settings-editor' }, rt.ArrayItem{ key: none, val: 'wc-admin-edit-settings' }, rt.ArrayItem{ key: none, val: 'woo-tracks' }, rt.ArrayItem{ key: none, val: 'woocommerce-admin-test-helper' }, rt.ArrayItem{ key: none, val: 'woocommerce-beta-tester-live-branches' }, rt.ArrayItem{ key: none, val: 'WCPAY_DASH_APP' }])
	mut var_default_scripts_handles := rt.call_function('array_diff', [rt.get_property(var_wp_scripts, 'queue'), var_ignored_settings_scripts.dup()])
	var_settings_mutated.array_get_mut('settingsScripts').array_set('_default', Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_script_urls(var_default_scripts_handles.dup()))
	mut var_setting_pages := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Settings_WC_Admin_Settings{}; return temp.get_settings_pages() }()
	var_settings_mutated = Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_page_data(var_settings_mutated.dup(), var_setting_pages.dup())
	return var_settings_mutated.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_page_data(var_settings rt.PhpVal, var_setting_pages rt.PhpVal) rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	mut var_settings_mutated := var_settings
	mut var_setting_pages_mutated := var_setting_pages
	// unsupported statement: Stmt_Global
	mut var_available_pages := rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_tabs_array'), rt.new_array()])
	mut var_pages := rt.new_array()
	{
		mut iter_1 := var_setting_pages_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting_page := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_setting_page, 'get_id', []rt.PhpVal{}), rt.func_array_keys(var_available_pages.dup()), rt.new_bool(true)]))))) {
				continue
			}
			mut var_scripts_before_adding_settings := rt.get_property(var_wp_scripts, 'queue')
			var_pages = rt.call_method(var_setting_page, 'add_settings_page_data', [var_pages.dup()])
			mut var_settings_scripts_handles := rt.call_function('array_diff', [rt.get_property(var_wp_scripts, 'queue'), var_scripts_before_adding_settings.dup()])
			var_settings_mutated.array_get_mut('settingsScripts').array_set(rt.call_method(var_setting_page, 'get_id', []rt.PhpVal{}), Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_script_urls(var_settings_scripts_handles.dup()))
		}
	}
	mut var_transformer := create_automattic_woocommerce_admin_features_settings_transformer()
	var_settings_mutated.array_get_mut('settingsData').array_set('pages', var_transformer.transform(var_pages.dup()))
	var_settings_mutated.array_get_mut('settingsData').array_set('start', rt.call_method(var_setting_pages_mutated.array_get(0), 'get_custom_view', [rt.new_string('woocommerce_settings_start')]))
	var_settings_mutated.array_get_mut('settingsData').array_set('_wpnonce', rt.call_function('wp_create_nonce', [rt.new_string('wp_rest')]))
	return var_settings_mutated.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_script_urls(var_script_handles rt.PhpVal) rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_script_urls := rt.new_array()
	{
		mut iter_1 := var_script_handles.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_script := item_1.val
			mut var_registered_script := rt.get_property(var_wp_scripts, 'registered').array_get(var_script)
			if !(!(rt.get_property(var_registered_script, 'src')).is_null()) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('strpos', [rt.get_property(var_registered_script, 'src'), '/' + (rt.get_constant('WPINC')).str() + '/js']), rt.new_int(0))) || rt.is_true(rt.identical(rt.call_function('strpos', [rt.get_property(var_registered_script, 'src'), rt.new_string('/wp-admin/js')]), rt.new_int(0))))) {
				continue
			}
			mut var_src := rt.get_property(var_registered_script, 'src')
			mut var_ver := if rt.is_true(rt.get_property(var_registered_script, 'ver')) { rt.get_property(var_registered_script, 'ver') } else { rt.new_bool(false) }
			if rt.is_true(var_ver) {
				var_src = rt.call_function('add_query_arg', [rt.new_string('ver'), var_ver.dup(), var_src.dup()])
			}
			if rt.is_true(rt.identical(rt.call_function('strpos', [var_src.dup(), rt.new_string('/')]), rt.new_int(0))) {
				var_script_urls.array_push(rt.call_function('home_url', [var_src.dup()]))
			} else {
				var_script_urls.array_push(var_src.dup())
			}
		}
	}
	return var_script_urls.dup()
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Settings_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_settings_init() &Class_Automattic_WooCommerce_Admin_Features_Settings_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Settings_Init{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_settings_wc_admin_settings() &Class_Automattic_WooCommerce_Admin_Features_Settings_WC_Admin_Settings {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Settings_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_settings_transformer() &Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_settings_page' {
			return rt.new_bool(this.is_settings_page())
		}
		'enqueue_settings_editor_styles' {
			this.enqueue_settings_editor_styles()
			return rt.new_null()
		}
		'enqueue_settings_editor_scripts' {
			this.enqueue_settings_editor_scripts()
			return rt.new_null()
		}
		'add_component_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Settings_Init.add_component_settings(dispatch_arg_0)
		}
		'get_page_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_page_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_script_urls' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Settings_Init.get_script_urls(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Settings_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Settings_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_settings_init_php() {
	// unsupported statement: Stmt_Declare
}
