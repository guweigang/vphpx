import rt

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		preloaded_dependencies rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) construct()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.get_instance() }()
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminAssets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminAssets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'inject_wc_settings_dependencies' }]), rt.new_int(14)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminAssets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_assets' }]), rt.new_int(15)])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_path(var_ext rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.identical(var_ext, rt.new_string('css'))) { rt.get_constant('WC_ADMIN_DIST_CSS_FOLDER') } else { rt.get_constant('WC_ADMIN_DIST_JS_FOLDER') }
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.should_use_minified_js_file(var_script_debug rt.PhpVal) bool {
	mut var_script_debug_mutated := var_script_debug
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.exists(arg_0) }(rt.new_string('minified-js')))))) {
		return false
	}
	return !(rt.is_true(var_script_debug_mutated))
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_url(var_file rt.PhpVal, var_ext rt.PhpVal) rt.PhpVal {
	mut var_suffix := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.identical(var_ext, rt.new_string('js'))) {
		mut var_script_debug := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')])) && rt.is_true(rt.get_constant('SCRIPT_DEBUG'))))
		var_suffix = rt.new_string(if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.should_use_minified_js_file(var_script_debug.dup())) { rt.new_string('.min') } else { rt.new_string('') })
	}
	return rt.call_function('plugins_url', [(Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_path(var_ext.dup())).str() + (var_file).str() + (var_suffix).str() + '.' + (var_ext).str(), rt.get_constant('WC_ADMIN_PLUGIN_FILE')])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_file_version(var_ext rt.PhpVal, var_asset_version rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')])) && rt.is_true(rt.get_constant('SCRIPT_DEBUG')))) {
		return rt.call_function('filemtime', [rt.concat(rt.get_constant('WC_ADMIN_ABSPATH'), Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_path(var_ext.dup()))])
	}
	if !(!rt.is_true(var_asset_version)) {
		return var_asset_version.dup()
	}
	return rt.get_constant('WC_VERSION')
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_script_asset_filename(var_script_path_name rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	mut var_script_path_name_mutated := var_script_path_name
	mut var_minification_supported := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.exists(arg_0) }(rt.new_string('minified-js'))
	mut var_script_min_filename := rt.new_string((var_file).str() + '.min.asset.php')
	mut var_script_nonmin_filename := rt.new_string((var_file).str() + '.asset.php')
	mut var_script_asset_path := rt.new_string((rt.get_constant('WC_ADMIN_ABSPATH')).str() + (rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + (var_script_path_name_mutated).str() + '/')
	if rt.is_true(rt.new_bool(rt.is_true(var_minification_supported) && rt.is_true(rt.call_function('is_readable', [rt.concat(var_script_asset_path, var_script_min_filename)])))) {
		return var_script_min_filename.dup()
	} else if rt.is_true(rt.call_function('is_readable', [rt.concat(var_script_asset_path, var_script_nonmin_filename)])) {
		return var_script_nonmin_filename.dup()
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Exception', []string{}, create_automattic_woocommerce_internal_admin_exception('Could not find asset registry for ' + (var_script_path_name_mutated).str())))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) maybe_output_preload_link_tag(var_dependency rt.PhpVal, var_type rt.PhpVal, var_allowlist rt.PhpVal)  {
	mut var_dependency_mutated := var_dependency
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_allowlist)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_dependency_mutated, 'handle'), var_allowlist.dup(), rt.new_bool(true)]))))))) || rt.is_true(rt.new_bool(!(!rt.is_true(this.preloaded_dependencies.array_get(var_type))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_dependency_mutated, 'handle'), this.preloaded_dependencies.array_get(var_type), rt.new_bool(true)])))))) {
		return rt.new_null()
	}
	this.preloaded_dependencies.array_get_mut(var_type).array_push(rt.get_property(var_dependency_mutated, 'handle'))
	mut var_source := if rt.is_true(rt.get_property(var_dependency_mutated, 'ver')) { rt.call_function('add_query_arg', [rt.new_string('ver'), rt.get_property(var_dependency_mutated, 'ver'), rt.get_property(var_dependency_mutated, 'src')]) } else { rt.get_property(var_dependency_mutated, 'src') }
	print('<link rel="preload" href="')
	rt.echo_val(rt.call_function('esc_url', [var_source.dup()]))
	print('" as="')
	rt.echo_val(rt.call_function('esc_attr', [var_type.dup()]))
	print('" />')
	print('\n')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) output_header_preload_tags_for_type(var_type rt.PhpVal, var_allowlist rt.PhpVal)  {
	if rt.is_true(rt.identical(var_type, rt.new_string('script'))) {
		mut var_dependencies_of_type := rt.call_function('wp_scripts', []rt.PhpVal{})
	} else if rt.is_true(rt.identical(var_type, rt.new_string('style'))) {
		var_dependencies_of_type = rt.call_function('wp_styles', []rt.PhpVal{})
	} else {
		return rt.new_null()
	}
	{
		mut iter_1 := rt.get_property(var_dependencies_of_type, 'queue').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependency_handle := item_1.val
			mut var_dependency := rt.call_method(var_dependencies_of_type, 'query', [var_dependency_handle.dup(), rt.new_string('registered')])
			if rt.is_true(rt.identical(var_dependency, rt.new_bool(false))) {
				continue
			}
			{
				mut iter_2 := rt.get_property(var_dependency, 'deps').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_sub_dependency_handle := item_2.val
					mut var_sub_dependency := rt.call_method(var_dependencies_of_type, 'query', [var_sub_dependency_handle.dup(), rt.new_string('registered')])
					if rt.is_true(var_sub_dependency) {
						this.maybe_output_preload_link_tag(var_sub_dependency.dup(), var_type.dup(), var_allowlist.dup())
					}
				}
			}
			this.maybe_output_preload_link_tag(var_dependency.dup(), var_type.dup(), var_allowlist.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) output_header_preload_tags()  {
	mut var_wc_admin_scripts := rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('WC_ADMIN_APP') }, rt.ArrayItem{ key: none, val: 'wc-components' }])
	mut var_wc_admin_styles := rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('WC_ADMIN_APP') }, rt.ArrayItem{ key: none, val: 'wc-components' }, rt.ArrayItem{ key: none, val: 'wc-material-icons' }])
	this.output_header_preload_tags_for_type(rt.new_string('style'), var_wc_admin_styles.dup())
	this.output_header_preload_tags_for_type(rt.new_string('script'), var_wc_admin_scripts.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) enqueue_assets()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_modern_settings_page() }())))) {
		rt.call_function('wp_enqueue_script', [rt.get_constant('WC_ADMIN_APP')])
		rt.call_function('wp_enqueue_style', [rt.get_constant('WC_ADMIN_APP')])
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-material-icons')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-onboarding')])
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_settings_page() }()) {
		this.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('settings-embed'), true, rt.new_null())
		this.register_style(rt.new_string('settings-embed'), rt.new_string('style'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-components' }]))
	}
	this.output_header_preload_tags()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) modify_script_dependencies(var_dependencies rt.PhpVal, var_script rt.PhpVal) rt.PhpVal {
	mut var_dependencies_mutated := var_dependencies
	mut var_script_mutated := var_script
	mut switch_val_1 := var_script_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.get_constant('WC_ADMIN_APP'))) {
		mut var_is_customize_store_page := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }()) && rt.get_superglobal('_GET').array_isset(rt.new_string('path')))) && rt.is_true(rt.call_function('str_starts_with', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('path')])]), rt.new_string('/customize-store')]))))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_customize_store_page)))) {
			var_dependencies_mutated = rt.call_function('array_diff', [var_dependencies_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-editor' }])])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('product_block_editor')))))) {
			var_dependencies_mutated = rt.call_function('array_diff', [var_dependencies_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-product-editor' }])])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-product-editor'))) {
		mut var_is_product_data_view_page := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init{}; return temp.is_product_data_view_page() }()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('product_block_editor'))) || rt.is_true(var_is_product_data_view_page)))))) {
			var_dependencies_mutated = rt.call_function('array_diff', [var_dependencies_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-editor' }])])
		}
	}
	return var_dependencies_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) register_scripts()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_set_script_translations')]))))) {
		return rt.new_null()
	}
	mut var_scripts := rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-layout' }, rt.ArrayItem{ key: none, val: 'wc-explat' }, rt.ArrayItem{ key: none, val: 'wc-experimental' }, rt.ArrayItem{ key: none, val: 'wc-customer-effort-score' }, rt.ArrayItem{ key: none, val: 'wc-notices' }, rt.ArrayItem{ key: none, val: 'wc-number' }, rt.ArrayItem{ key: none, val: 'wc-tracks' }, rt.ArrayItem{ key: none, val: 'wc-date' }, rt.ArrayItem{ key: none, val: 'wc-components' }, rt.ArrayItem{ key: none, val: rt.get_constant('WC_ADMIN_APP') }, rt.ArrayItem{ key: none, val: 'wc-csv' }, rt.ArrayItem{ key: none, val: 'wc-store-data' }, rt.ArrayItem{ key: none, val: 'wc-currency' }, rt.ArrayItem{ key: none, val: 'wc-navigation' }, rt.ArrayItem{ key: none, val: 'wc-block-templates' }, rt.ArrayItem{ key: none, val: 'wc-experimental-products-app' }, rt.ArrayItem{ key: none, val: 'wc-product-editor' }, rt.ArrayItem{ key: none, val: 'wc-settings-editor' }, rt.ArrayItem{ key: none, val: 'wc-remote-logging' }, rt.ArrayItem{ key: none, val: 'wc-sanitize' }])
	mut var_scripts_map := rt.create_array([rt.ArrayItem{ key: rt.get_constant('WC_ADMIN_APP'), val: if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_embed_page() }()) { 'embed' } else { 'app' } }, rt.ArrayItem{ key: 'wc-csv', val: 'csv-export' }, rt.ArrayItem{ key: 'wc-store-data', val: 'data' }])
	mut var_translated_scripts := rt.create_array([rt.ArrayItem{ key: none, val: 'wc-currency' }, rt.ArrayItem{ key: none, val: 'wc-date' }, rt.ArrayItem{ key: none, val: 'wc-components' }, rt.ArrayItem{ key: none, val: 'wc-customer-effort-score' }, rt.ArrayItem{ key: none, val: 'wc-experimental-products-app' }, rt.ArrayItem{ key: none, val: 'wc-experimental' }, rt.ArrayItem{ key: none, val: 'wc-navigation' }, rt.ArrayItem{ key: none, val: 'wc-product-editor' }, rt.ArrayItem{ key: none, val: rt.get_constant('WC_ADMIN_APP') }])
	{
		mut iter_1 := var_scripts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_script := item_1.val
			mut var_script_path_name := if var_scripts_map.array_isset(var_script) { var_scripts_map.array_get(var_script) } else { rt.call_function('str_replace', [rt.new_string('wc-'), rt.new_string(''), var_script.dup()]) }
			mut var_script_assets_filename := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_script_asset_filename(var_script_path_name.dup(), rt.new_string('index'))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_script_assets := rt.include_file((rt.get_constant('WC_ADMIN_ABSPATH')).str() + (rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + (var_script_path_name).str() + '/' + (var_script_assets_filename).str(), '3')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_script_version := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_file_version(rt.new_string('js'), var_script_assets.array_get('version'))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_script_dependencies := this.modify_script_dependencies(var_script_assets.array_get('dependencies'), var_script.dup(), var_script_path_name.dup())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			rt.call_function('wp_register_script', [var_script.dup(), Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_url(rt.new_string((var_script_path_name).str() + '/index'), rt.new_string('js')), var_script_dependencies.dup(), var_script_version.dup(), rt.new_bool(true)])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.call_function('in_array', [var_script.dup(), var_translated_scripts.dup(), rt.new_bool(true)])) {
				rt.call_function('wp_set_script_translations', [var_script.dup(), rt.new_string('woocommerce')])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.identical(rt.get_constant('WC_ADMIN_APP'), var_script)) {
				rt.call_function('wp_localize_script', [rt.get_constant('WC_ADMIN_APP'), rt.new_string('wcAdminAssets'), rt.create_array([rt.ArrayItem{ key: 'path', val: rt.call_function('plugins_url', [Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_path(rt.new_string('js')), rt.get_constant('WC_ADMIN_PLUGIN_FILE')]) }, rt.ArrayItem{ key: 'version', val: var_script_version }])])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Exception') {
				mut var_e := var_e_1.dup()
				rt.call_function('wc_caught_exception', [var_e.dup(), @STRUCT + '::' + @FN, var_script_path_name.dup()])
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	mut var_styles := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-admin-layout' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-components' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-block-templates' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-experimental-products-app' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-product-editor' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-settings-editor' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-customer-effort-score' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-experimental' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: rt.get_constant('WC_ADMIN_APP') }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc-components' }, rt.ArrayItem{ key: none, val: 'wc-admin-layout' }, rt.ArrayItem{ key: none, val: 'wc-customer-effort-score' }, rt.ArrayItem{ key: none, val: 'wp-components' }, rt.ArrayItem{ key: none, val: 'wc-experimental' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-onboarding' }]) }])
	mut var_css_file_version := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_file_version(rt.new_string('css'))
	{
		mut iter_1 := var_styles.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_style := item_1.val
			mut var_handle := var_style.array_get('handle')
			mut var_style_path_name := if var_scripts_map.array_isset(var_handle) { var_scripts_map.array_get(var_handle) } else { rt.call_function('str_replace', [rt.new_string('wc-'), rt.new_string(''), var_handle.dup()]) }
			mut var_style_assets_filename := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_script_asset_filename(var_style_path_name.dup(), rt.new_string('style'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			mut var_style_assets := rt.include_file((rt.get_constant('WC_ADMIN_ABSPATH')).str() + (rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + (var_style_path_name).str() + '/' + (var_style_assets_filename).str(), '3')
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			mut var_version := var_style_assets.array_get('version')
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Admin_Throwable') {
				mut var_e := var_e_2.dup()
				var_version = var_css_file_version.dup()
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
			mut var_dependencies := if var_style.array_isset(rt.new_string('dependencies')) { var_style.array_get('dependencies') } else { rt.new_array() }
			rt.call_function('wp_register_style', [var_handle.dup(), Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_url(rt.new_string((var_style_path_name).str() + '/style'), rt.new_string('css')), var_dependencies.dup(), Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_file_version(rt.new_string('css'), var_version.dup())])
			rt.call_function('wp_style_add_data', [var_handle.dup(), rt.new_string('rtl'), rt.new_string('replace')])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) inject_wc_settings_dependencies()  {
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	if rt.is_true(rt.call_function('wp_script_is', [rt.new_string('wc-settings'), rt.new_string('registered')])) {
		mut var_handles_for_injection := rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-layout' }, rt.ArrayItem{ key: none, val: 'wc-csv' }, rt.ArrayItem{ key: none, val: 'wc-currency' }, rt.ArrayItem{ key: none, val: 'wc-customer-effort-score' }, rt.ArrayItem{ key: none, val: 'wc-experimental-products-app' }, rt.ArrayItem{ key: none, val: 'wc-navigation' }, rt.ArrayItem{ key: none, val: 'wc-notices' }, rt.ArrayItem{ key: none, val: 'wc-number' }, rt.ArrayItem{ key: none, val: 'wc-date' }, rt.ArrayItem{ key: none, val: 'wc-components' }, rt.ArrayItem{ key: none, val: 'wc-tracks' }, rt.ArrayItem{ key: none, val: 'wc-block-templates' }, rt.ArrayItem{ key: none, val: 'wc-product-editor' }])
		{
			mut iter_1 := var_handles_for_injection.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_handle := item_1.val
				mut var_script := rt.call_method(var_wp_scripts, 'query', [var_handle.dup(), rt.new_string('registered')])
				if rt.is_true(rt.new_bool(rt.instance_of(var_script, '_WP_Dependency'))) {
					rt.get_property(, 'deps').array_push('wc-settings')
					rt.call_method(, 'add_data', [.dup(), , ])
				}
			}
		}
		{
			mut iter_1 := rt.get_property(, 'registered').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_script := item_1.val
				mut var_handle := item_1.key
				if rt.is_true() {
				}
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.register_script(var_script_path_name rt.PhpVal, var_script_name rt.PhpVal, need_translation bool, var_dependencies rt.PhpVal)  {
	mut var_script_path_name_mutated := var_script_path_name
	mut var_dependencies_mutated := var_dependencies
	mut var_script_assets_filename := 
	
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.register_style(var_style_path_name rt.PhpVal, var_style_name rt.PhpVal, var_dependencies rt.PhpVal)  {
	mut var_style_path_name_mutated := var_style_path_name
	mut var_dependencies_mutated := var_dependencies
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		preloaded_dependencies: rt.new_null()
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

fn create_automattic_woocommerce_internal_admin_exception() &Class_Automattic_WooCommerce_Internal_Admin_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Exception{
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

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_automattic_woocommerce_admin_features_productdataviews_init() &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_path(dispatch_arg_0)
		}
		'should_use_minified_js_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.should_use_minified_js_file(dispatch_arg_0))
		}
		'get_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_url(dispatch_arg_0, dispatch_arg_1)
		}
		'get_file_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_file_version(dispatch_arg_0, dispatch_arg_1)
		}
		'get_script_asset_filename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.get_script_asset_filename(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_output_preload_link_tag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.maybe_output_preload_link_tag(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'output_header_preload_tags_for_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.output_header_preload_tags_for_type(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'output_header_preload_tags' {
			this.output_header_preload_tags()
			return rt.new_null()
		}
		'enqueue_assets' {
			this.enqueue_assets()
			return rt.new_null()
		}
		'modify_script_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.modify_script_dependencies(dispatch_arg_0, dispatch_arg_1)
		}
		'register_scripts' {
			this.register_scripts()
			return rt.new_null()
		}
		'inject_wc_settings_dependencies' {
			this.inject_wc_settings_dependencies()
			return rt.new_null()
		}
		'register_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.register_script(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'register_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets.register_style(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'preloaded_dependencies' { return this.preloaded_dependencies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_wcadminassets_php() {
}
