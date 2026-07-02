import rt

struct Class_Automattic_WooCommerce_Utilities_PluginUtil {
	rt.PhpObjectBase
pub mut:
	proxy                                  rt.PhpVal = rt.new_null()
	woocommerce_aware_plugins              rt.PhpVal = rt.new_null()
	woocommerce_aware_active_plugins       rt.PhpVal = rt.new_null()
	plugins_excluded_from_compatibility_ui rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) construct() {
	rt.call_function('add_action', [rt.new_string('activated_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Utilities_PluginUtil',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_plugin_de_activation' },
		]),
		rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('deactivated_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Utilities_PluginUtil',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_plugin_de_activation' },
		]),
		rt.new_int(10), rt.new_int(0)])
	this.plugins_excluded_from_compatibility_ui = rt.create_array([
		rt.ArrayItem{ key: none, val: 'woocommerce-legacy-rest-api/woocommerce-legacy-rest-api.php' },
	])
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) init(mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy) {
	this.proxy = var_proxy
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/plugin.php', '4')
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) get_all_active_valid_plugins() rt.PhpVal {
	mut var_local := rt.call_function('wp_get_active_and_valid_plugins', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/ms-load.php',
			'4')
		mut var_network := rt.call_function('wp_get_active_network_plugins', []rt.PhpVal{})
	} else {
		var_network = rt.new_array()
	}
	mut var_all := rt.call_function('array_merge', [var_local.clone(),
		var_network.clone()])
	var_all = rt.call_function('array_unique', [var_all.clone()])
	var_all = rt.call_function('array_map', [rt.new_string('plugin_basename'),
		var_all.clone()])
	rt.call_function('sort', [var_all.clone()])
	return var_all.clone()
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) get_woocommerce_aware_plugins(active_only bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.woocommerce_aware_plugins.is_null())) {
		rt.call_function('wp_cache_delete', [rt.new_string('plugins'),
			rt.new_string('plugins')])
		mut var_all_plugins := rt.call_method(this.proxy, 'call_function', [
			rt.new_string('get_plugins'),
		])
		this.woocommerce_aware_plugins = rt.func_array_keys(rt.call_function('array_filter', [
			var_all_plugins.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Utilities_PluginUtil',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'is_woocommerce_aware_plugin' },
			]),
		]))
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_plugin_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(this.proxy, 'call_function', [
				rt.new_string('is_plugin_active'),
				var_plugin_name.clone(),
			])
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_plugin_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(this.proxy, 'call_function', [
				rt.new_string('is_plugin_active'),
				var_plugin_name.clone(),
			])
		}
		this.woocommerce_aware_active_plugins = rt.call_function('array_values', [
			rt.call_function('array_filter', [this.woocommerce_aware_plugins,
				rt.new_closure(closure_1_fn)]),
		])
	}
	return if var_active_only {
		this.woocommerce_aware_active_plugins
	} else {
		this.woocommerce_aware_plugins
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) get_plugin_name(plugin_id string) string {
	mut var_plugin_data := rt.call_method(this.proxy, 'call_function', [
		rt.new_string('get_plugin_data'),
		rt.new_string(
			(rt.get_constant('WP_PLUGIN_DIR')).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + plugin_id),
	])
	return (if !(var_plugin_data.array_get(rt.new_string('Name'))).is_null() {
		var_plugin_data.array_get(rt.new_string('Name'))
	} else {
		rt.new_string(plugin_id)
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) is_woocommerce_aware_plugin(var_plugin_file_or_data rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_plugin_file_or_data.clone().is_string())) {
		return (rt.call_function('in_array', [var_plugin_file_or_data.clone(),
			this.get_woocommerce_aware_plugins(false), rt.new_bool(true)])).to_bool()
	} else if rt.is_true(rt.new_bool(var_plugin_file_or_data.clone().is_array())) {
		return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), if !(var_plugin_file_or_data.array_get(rt.new_string('WC tested up to'))).is_null() {
			var_plugin_file_or_data.array_get(rt.new_string('WC tested up to'))
		} else {
			rt.new_string('')
		})))
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Utilities_Exception', []string{},
			create_automattic_woocommerce_utilities_exception(rt.new_string('is_woocommerce_aware_plugin requires a plugin name or an array of plugin data as input'))))
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) get_wp_plugin_id(var_plugin_file rt.PhpVal) bool {
	mut var_plugin_file_mutated := var_plugin_file
	mut var_wp_plugins := rt.func_array_keys(rt.call_method(this.proxy, 'call_function', [
		rt.new_string('get_plugins'),
	]))
	mut var_plugin_basename := rt.call_method(this.proxy, 'call_function', [
		rt.new_string('plugin_basename'),
		var_plugin_file_mutated.clone(),
	])
	if rt.is_true(rt.call_function('in_array', [var_plugin_basename.clone(),
		var_wp_plugins.clone(), rt.new_bool(true)]))
	{
		return var_plugin_basename.to_bool()
	}
	var_plugin_file_mutated = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '\\' },
			rt.ArrayItem{ key: none, val: '/' }]),
		rt.get_constant('DIRECTORY_SEPARATOR'),
		var_plugin_file_mutated.clone(),
	])
	mut var_file_name_parts := rt.call_function('explode', [
		rt.get_constant('DIRECTORY_SEPARATOR'),
		var_plugin_file_mutated.clone(),
	])
	mut var_file_name := rt.call_function('array_pop', [var_file_name_parts.clone()])
	mut var_directory_name := rt.call_function('array_pop', [
		var_file_name_parts.clone()])
	mut var_full_matches := rt.new_array()
	mut var_partial_matches := rt.new_array()
	mut iter_1 := var_wp_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_wp_plugin := item_1.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_wp_plugin.clone(),
			rt.new_string(var_directory_name.str() +
				(rt.get_constant('DIRECTORY_SEPARATOR')).str() + var_file_name.str()),
		])))))
		{
			var_full_matches.array_push(var_wp_plugin.clone())
		}
		if !(!rt.is_true(var_file_name))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_wp_plugin.clone(), var_file_name.clone()]))))) {
			var_partial_matches.array_push(var_wp_plugin.clone())
		}
	}
	if 1 == var_full_matches.clone().array_count() {
		return (var_full_matches.array_get(rt.new_int(0))).to_bool()
	}
	if 1 == var_partial_matches.clone().array_count() {
		return (var_partial_matches.array_get(rt.new_int(0))).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) handle_plugin_de_activation() {
	this.woocommerce_aware_plugins = rt.new_null()
	this.woocommerce_aware_active_plugins = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) generate_incompatible_plugin_feature_warning(feature_id string, mut var_plugin_feature_info Class_Automattic_WooCommerce_Utilities_array) string {
	mut var_incompatibles := this.get_items_considered_incompatible(feature_id, mut
		var_plugin_feature_info)
	var_incompatibles = rt.call_function('array_filter', [var_incompatibles.clone(),
		rt.new_string('is_plugin_active')])
	var_incompatibles = rt.call_function('array_values', [
		rt.call_function('array_diff', [var_incompatibles.clone(),
			this.get_plugins_excluded_from_compatibility_ui()]),
	])
	mut var_incompatible_count := rt.new_int(var_incompatibles.clone().array_count())
	mut var_feature_warnings := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('custom_order_tables'), rt.new_string(feature_id)))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_api_enabled')]))) {
		if rt.is_true(rt.call_function('is_plugin_active', [
			rt.new_string('woocommerce-legacy-rest-api/woocommerce-legacy-rest-api.php'),
		]))
		{
			mut var_legacy_api_and_hpos_incompatibility_warning_text := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('⚠ <b><a target="_blank" href="%s">The Legacy REST API plugin</a> is installed and active on this site.</b> Please be aware that the WooCommerce Legacy REST API is <b>not</b> compatible with HPOS.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('https://wordpress.org/plugins/woocommerce-legacy-rest-api/'),
			])
		} else {
			var_legacy_api_and_hpos_incompatibility_warning_text = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('⚠ <b><a target="_blank" href="%s">The Legacy REST API</a> is active on this site.</b> Please be aware that the WooCommerce Legacy REST API is <b>not</b> compatible with HPOS.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('admin_url', [
					rt.new_string('admin.php?page=wc-settings&tab=advanced&section=legacy_api'),
				]),
			])
		}
		var_legacy_api_and_hpos_incompatibility_warning_text = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_legacy_api_and_hpos_incompatibility_warning_text'),
			var_legacy_api_and_hpos_incompatibility_warning_text.clone(),
		])
		if !(var_legacy_api_and_hpos_incompatibility_warning_text.clone().is_null()) {
			var_feature_warnings.array_push(
				var_legacy_api_and_hpos_incompatibility_warning_text.str() + '\n')
		}
	}
	if rt.is_true(rt.greater(var_incompatible_count, rt.new_int(0))) {
		if rt.is_true(rt.identical(rt.new_int(1), var_incompatible_count)) {
			var_feature_warnings.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('⚠ 1 Incompatible plugin detected (%s).'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string(this.get_plugin_name((var_incompatibles.array_get(rt.new_int(0))).str())),
			]))
		} else if rt.is_true(rt.identical(rt.new_int(2), var_incompatible_count)) {
			var_feature_warnings.array_push(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('⚠ 2 Incompatible plugins detected (%1$s and %2$s).'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string(this.get_plugin_name((var_incompatibles.array_get(rt.new_int(0))).str())),
				rt.new_string(this.get_plugin_name((var_incompatibles.array_get(rt.new_int(1))).str())),
			]))
		} else {
			var_feature_warnings.array_push(rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('⚠ Incompatible plugins detected (%1$s, %2$s and %3$d other).'),
					rt.new_string('⚠ Incompatible plugins detected (%1$s and %2$s plugins and %3$d others).'),
					rt.sub(var_incompatible_count, rt.new_int(2)),
					rt.new_string('woocommerce'),
				]),
				rt.new_string(this.get_plugin_name((var_incompatibles.array_get(rt.new_int(0))).str())),
				rt.new_string(this.get_plugin_name((var_incompatibles.array_get(rt.new_int(1))).str())),
				rt.sub(var_incompatible_count, rt.new_int(2)),
			]))
		}
		mut var_incompatible_plugins_url := rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'plugin_status', val: 'incompatible_with_feature' },
				rt.ArrayItem{ key: 'feature_id', val: feature_id },
			]),
			rt.call_function('admin_url', [
				rt.new_string('plugins.php'),
			]),
		])
		var_feature_warnings.array_push(rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$sView and manage%2$s'),
				rt.new_string('woocommerce')]),
			rt.new_string('<a href="' +
				(rt.call_function('esc_url', [var_incompatible_plugins_url.clone()])).str() + '">'),
			rt.new_string('</a>'),
		]))
	}
	return (rt.call_function('str_replace', [rt.new_string('\n'),
		rt.new_string('<br>'),
		rt.call_function('implode', [rt.new_string('\n'),
			var_feature_warnings.clone()])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) get_items_considered_incompatible(feature_id string, mut var_compatibility_info Class_Automattic_WooCommerce_Utilities_array) rt.PhpVal {
	mut var_incompatible_by_default := rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible(), rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'get_default_plugin_compatibility', [rt.new_string(feature_id)]))))
	return if rt.is_true(var_incompatible_by_default) { rt.call_function('array_merge', [
			var_compatibility_info.array_get(rt.new_string('incompatible')),
			var_compatibility_info.array_get(rt.new_string('uncertain')),
		]) } else { var_compatibility_info.array_get(rt.new_string('incompatible')) }
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) get_plugins_excluded_from_compatibility_ui() rt.PhpVal {
	return this.plugins_excluded_from_compatibility_ui
}

struct Class_Automattic_WooCommerce_Utilities_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_pluginutil() &Class_Automattic_WooCommerce_Utilities_PluginUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_PluginUtil{
		PhpObjectBase:                          rt.PhpObjectBase{}
		proxy:                                  rt.new_null()
		woocommerce_aware_plugins:              rt.new_null()
		woocommerce_aware_active_plugins:       rt.new_null()
		plugins_excluded_from_compatibility_ui: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_utilities_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_Exception {
	mut obj := &Class_Automattic_WooCommerce_Utilities_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_all_active_valid_plugins' {
			return this.get_all_active_valid_plugins()
		}
		'get_woocommerce_aware_plugins' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_woocommerce_aware_plugins(dispatch_arg_0)
		}
		'get_plugin_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_plugin_name(dispatch_arg_0))
		}
		'is_woocommerce_aware_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_woocommerce_aware_plugin(dispatch_arg_0))
		}
		'get_wp_plugin_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_wp_plugin_id(dispatch_arg_0))
		}
		'handle_plugin_de_activation' {
			this.handle_plugin_de_activation()
			return rt.new_null()
		}
		'generate_incompatible_plugin_feature_warning' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generate_incompatible_plugin_feature_warning(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'get_items_considered_incompatible' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_items_considered_incompatible(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_plugins_excluded_from_compatibility_ui' {
			return this.get_plugins_excluded_from_compatibility_ui()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_PluginUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'proxy' { return this.proxy }
		'woocommerce_aware_plugins' { return this.woocommerce_aware_plugins }
		'woocommerce_aware_active_plugins' { return this.woocommerce_aware_active_plugins }
		'plugins_excluded_from_compatibility_ui' { return this.plugins_excluded_from_compatibility_ui }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_PluginUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'proxy' {
			this.proxy = val
			return true
		}
		'woocommerce_aware_plugins' {
			this.woocommerce_aware_plugins = val
			return true
		}
		'woocommerce_aware_active_plugins' {
			this.woocommerce_aware_active_plugins = val
			return true
		}
		'plugins_excluded_from_compatibility_ui' {
			this.plugins_excluded_from_compatibility_ui = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
