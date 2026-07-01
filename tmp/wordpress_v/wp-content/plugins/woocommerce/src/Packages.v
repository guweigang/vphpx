import rt

struct Class_Automattic_WooCommerce_Packages {
	rt.PhpObjectBase
pub mut:
		packages rt.PhpVal = rt.new_array()
		base_packages rt.PhpVal = rt.new_array()
		merged_packages rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Packages) construct()  {
}

fn Class_Automattic_WooCommerce_Packages.init()  {
	rt.call_function('add_action', [rt.new_string('plugins_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'prepare_packages' }]), // unsupported expression: Expr_UnaryMinus])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'on_init' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('activate_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'deactivate_merged_plugins' }])])
	rt.call_function('add_filter', [rt.new_string('all_plugins'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'mark_merged_plugins_as_pending_update' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('after_plugin_row'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'display_notice_for_merged_plugins' }]), rt.new_int(10), rt.new_int(1)])
}

fn Class_Automattic_WooCommerce_Packages.on_init()  {
	Class_Automattic_WooCommerce_Packages.deactivate_merged_packages()
	Class_Automattic_WooCommerce_Packages.initialize_packages()
}

fn Class_Automattic_WooCommerce_Packages.package_exists(var_package rt.PhpVal) rt.PhpVal {
	return rt.call_function('file_exists', [(rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/packages/' + (var_package).str()])
}

fn Class_Automattic_WooCommerce_Packages.should_load_class(var_class_name rt.PhpVal) bool {
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_merged_package_class := item_1.val
			mut var_merged_package_name := item_1.key
			if rt.is_true(rt.identical(rt.call_function('str_replace', [rt.new_string('woocommerce-'), rt.new_string('wc_'), var_merged_package_name.dup()]), var_class_name)) {
				return true
			}
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Packages.get_enabled_packages() rt.PhpVal {
	mut var_enabled_packages := rt.new_array()
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package_class := item_1.val
			mut var_merged_package_name := item_1.key
			mut var_option := rt.new_string('wc_feature_' + (rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_merged_package_name.dup()])).str() + '_enabled')
			mut var_option_value := rt.call_function('get_option', [var_option.dup(), rt.new_string('')])
			if rt.is_true(rt.identical(rt.new_string('no'), var_option_value)) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('yes'), var_option_value)) {
				var_enabled_packages.array_set(var_merged_package_name, var_package_class.dup())
				continue
			}
			mut var_experimental_package_enabled := if rt.is_true(rt.call_function('method_exists', [var_package_class.dup(), rt.new_string('is_enabled')])) { rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: var_package_class }, rt.ArrayItem{ key: none, val: 'is_enabled' }])]) } else { rt.new_bool(false) }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_experimental_package_enabled)))) {
				continue
			}
			var_enabled_packages.array_set(var_merged_package_name, var_package_class.dup())
		}
	}
	return rt.call_function('array_merge', [var_enabled_packages.dup(), // unsupported expression: Expr_StaticPropertyFetch])
}

fn Class_Automattic_WooCommerce_Packages.is_package_enabled(var_package rt.PhpVal) bool {
	return Class_Automattic_WooCommerce_Packages.get_enabled_packages().array_isset(var_package.dup())
}

fn Class_Automattic_WooCommerce_Packages.prepare_packages()  {
	{
		mut iter_1 := Class_Automattic_WooCommerce_Packages.get_enabled_packages().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package_class := item_1.val
			mut var_package_name := item_1.key
			if rt.is_true(rt.call_function('method_exists', [var_package_class.dup(), rt.new_string('prepare')])) {
				rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: var_package_class }, rt.ArrayItem{ key: none, val: 'prepare' }])])
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Packages.deactivate_merged_packages()  {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('WC_ALLOW_MERGED_FEATURE_PLUGINS'))) {
		return rt.new_null()
	}
	mut var_active_plugins := rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])
	{
		mut iter_1 := var_active_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_active_plugin_path := item_1.val
			mut var_plugin_file := rt.call_function('basename', [rt.call_function('plugin_basename', [var_active_plugin_path.dup()]), rt.new_string('.php')])
			if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Packages.is_package_enabled(var_plugin_file.dup()))))) {
				continue
			}
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
			mut var_plugin_data := rt.call_function('get_plugin_data', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_active_plugin_path).str()])
			rt.call_function('deactivate_plugins', [var_active_plugin_path.dup()])
			closure_1_fn := fn [var_plugin_data] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	print('<div class="error"><p>')
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('The %1$s plugin has been deactivated as the latest improvements are now included with the %2$s plugin.'), rt.new_string('woocommerce')]), '<code>' + (rt.call_function('esc_html', [var_plugin_data.array_get('Name')])).str() + '</code>', rt.new_string('<code>WooCommerce</code>')])
	print('</p></div>')
	return rt.new_null()
	}
			rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_1_fn)])
		}
	}
}

fn Class_Automattic_WooCommerce_Packages.deactivate_merged_plugins(var_plugin rt.PhpVal)  {
	mut var_plugin_dir := rt.call_function('basename', [rt.call_function('dirname', [var_plugin.dup()])])
	if rt.is_true(Class_Automattic_WooCommerce_Packages.is_package_enabled(var_plugin_dir.dup())) {
		mut var_plugins_url := rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php')])])
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('This plugin cannot be activated because its functionality is now included in WooCommerce core.'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Plugin Activation Error'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'link_url', val: rt.call_function('esc_url', [var_plugins_url.dup()]) }, rt.ArrayItem{ key: 'link_text', val: rt.call_function('esc_html__', [rt.new_string('Return to the Plugins page'), rt.new_string('woocommerce')]) }])])
	}
}

fn Class_Automattic_WooCommerce_Packages.mark_merged_plugins_as_pending_update(var_plugins rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_data := item_1.val
			mut var_plugin_name := item_1.key
			mut var_plugin_dir := rt.call_function('basename', [rt.call_function('dirname', [var_plugin_name.dup()])])
			if rt.is_true(Class_Automattic_WooCommerce_Packages.is_package_enabled(var_plugin_dir.dup())) {
				var_plugins.array_get_mut(var_plugin_name).array_set('update', 1)
			}
		}
	}
	return var_plugins.dup()
}

fn Class_Automattic_WooCommerce_Packages.display_notice_for_merged_plugins(var_plugin_file rt.PhpVal)  {
	mut var_wp_list_table := rt.new_null()
	mut var_plugin_file_mutated := var_plugin_file
	// unsupported statement: Stmt_Global
	mut var_plugin_dir := rt.call_function('basename', [rt.call_function('dirname', [var_plugin_file_mutated.dup()])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Packages.is_package_enabled(var_plugin_dir.dup()))))) || rt.is_true(rt.new_bool(var_wp_list_table.dup().is_null())))) {
		return rt.new_null()
	}
	mut var_columns_count := rt.call_method(var_wp_list_table, 'get_column_count', []rt.PhpVal{})
	mut var_notice := rt.call_function('__', [rt.new_string('This plugin can no longer be activated because its functionality is now included in <strong>WooCommerce</strong>. It is recommended to <strong>delete</strong> it.'), rt.new_string('woocommerce')])
	print('<tr class="plugin-update-tr"><td colspan="' + (rt.call_function('esc_attr', [var_columns_count.dup()])).str() + '" class="plugin-update"><div class="update-message notice inline notice-error notice-alt"><p>' + (rt.call_function('wp_kses_post', [var_notice.dup()])).str() + '</p></div></td></tr>')
}

fn Class_Automattic_WooCommerce_Packages.initialize_packages()  {
	{
		mut iter_1 := Class_Automattic_WooCommerce_Packages.get_enabled_packages().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package_class := item_1.val
			mut var_package_name := item_1.key
			rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: var_package_class }, rt.ArrayItem{ key: none, val: 'init' }])])
		}
	}
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package_class := item_1.val
			mut var_package_name := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Packages.package_exists(var_package_name.dup()))))) {
				Class_Automattic_WooCommerce_Packages.missing_package(var_package_name.dup())
				continue
			}
			rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: var_package_class }, rt.ArrayItem{ key: none, val: 'init' }])])
		}
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		mut var_activated_plugin := rt.call_function('get_transient', [rt.new_string('woocommerce_activated_plugin')])
		if rt.is_true(var_activated_plugin) {
			rt.call_function('delete_transient', [rt.new_string('woocommerce_activated_plugin')])
			rt.call_function('do_action', [rt.new_string('woocommerce_activated_plugin'), var_activated_plugin.dup()])
		}
	}
}

fn Class_Automattic_WooCommerce_Packages.missing_package(var_package rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG')))) {
		rt.call_function('error_log', [(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Missing the WooCommerce %s package'), rt.new_string('woocommerce')]), '<code>' + (rt.call_function('esc_html', [var_package.dup()])).str() + '</code>'])).str() + ' - ' + (rt.call_function('esc_html__', [rt.new_string('Your installation of WooCommerce is incomplete. If you installed WooCommerce from GitHub, please refer to this document to set up your development environment: https://developer.woocommerce.com/docs/contribution/contributing/#setting-up-your-development-environment'), rt.new_string('woocommerce')])).str()])
	}
	closure_2_fn := fn [var_package] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Missing the WooCommerce %s package'), rt.new_string('woocommerce')]), '<code>' + (rt.call_function('esc_html', [var_package.dup()])).str() + '</code>'])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Your installation of WooCommerce is incomplete. If you installed WooCommerce from GitHub, %1$splease refer to this document%2$s to set up your development environment.'), rt.new_string('woocommerce')]), '<a href="' + (rt.call_function('esc_url', [rt.new_string('https://developer.woocommerce.com/docs/contribution/contributing/#setting-up-your-development-environment')])).str() + '" target="_blank" rel="noopener noreferrer">', rt.new_string('</a>')])
	// unsupported statement: Stmt_InlineHTML
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_closure(closure_2_fn)])
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_packages() &Class_Automattic_WooCommerce_Packages {
	mut obj := &Class_Automattic_WooCommerce_Packages{
		PhpObjectBase: rt.PhpObjectBase{}
		packages: rt.new_array()
		base_packages: rt.new_array()
		merged_packages: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Packages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Packages.init()
			return rt.new_null()
		}
		'on_init' {
			Class_Automattic_WooCommerce_Packages.on_init()
			return rt.new_null()
		}
		'package_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Packages.package_exists(dispatch_arg_0)
		}
		'should_load_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Packages.should_load_class(dispatch_arg_0))
		}
		'get_enabled_packages' {
			return Class_Automattic_WooCommerce_Packages.get_enabled_packages()
		}
		'is_package_enabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Packages.is_package_enabled(dispatch_arg_0))
		}
		'prepare_packages' {
			Class_Automattic_WooCommerce_Packages.prepare_packages()
			return rt.new_null()
		}
		'deactivate_merged_packages' {
			Class_Automattic_WooCommerce_Packages.deactivate_merged_packages()
			return rt.new_null()
		}
		'deactivate_merged_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Packages.deactivate_merged_plugins(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_merged_plugins_as_pending_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Packages.mark_merged_plugins_as_pending_update(dispatch_arg_0)
		}
		'display_notice_for_merged_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Packages.display_notice_for_merged_plugins(dispatch_arg_0)
			return rt.new_null()
		}
		'initialize_packages' {
			Class_Automattic_WooCommerce_Packages.initialize_packages()
			return rt.new_null()
		}
		'missing_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Packages.missing_package(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Packages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'packages' { return this.packages }
		'base_packages' { return this.base_packages }
		'merged_packages' { return this.merged_packages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Packages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'packages' { this.packages = val; return true }
		'base_packages' { this.base_packages = val; return true }
		'merged_packages' { this.merged_packages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_packages_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
