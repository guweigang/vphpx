import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_plugins_transient() string {
	return 'woocommerce_blueprint_installed_wp_org_plugins'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_themes_transient() string {
	return 'woocommerce_blueprint_installed_wp_org_themes'
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init {
	rt.PhpObjectBase
pub mut:
	initialized_exporters rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) construct() {
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_rest_api' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_js_vars' },
		])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('add_filter', [rt.new_string('wooblueprint_export_landingpage'),
		rt.new_closure(closure_1_fn)])
	rt.call_function('add_filter', [rt.new_string('wooblueprint_exporters'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_woo_exporters' },
		])])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clear_installed_wp_org_plugins_transient' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('deleted_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clear_installed_wp_org_plugins_transient' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clear_installed_wp_org_themes_transient' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('switch_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clear_installed_wp_org_themes_transient' },
		])])
	rt.call_function('add_action', [rt.new_string('deleted_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clear_installed_wp_org_themes_transient' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) init_rest_api() {
	rt.call_method(create_automattic_woocommerce_admin_features_blueprint_restapi(),
		'register_routes', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) get_woo_exporters() rt.PhpVal {
	mut var_classnames := rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsGeneral.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsProducts.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsTax.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCPaymentGateways.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsAccount.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsEmails.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsIntegrations.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsSiteVisibility.class()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsAdvanced.class()
		},
	])
	mut var_exporters := rt.new_array()
	{
		mut iter_1 := var_classnames.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_classname := item_1.val
			var_exporters.array_set(var_classname, if !(this.initialized_exporters.array_get(var_classname)).is_null() {
				this.initialized_exporters.array_get(var_classname)
			} else {
				rt.create_object_dynamically(var_classname, []rt.PhpVal{})
			})
			this.initialized_exporters.array_set(var_classname,
				var_exporters.array_get(var_classname))
		}
	}
	return rt.call_function('array_values', [var_exporters.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) add_woo_exporters(mut var_exporters Class_Automattic_WooCommerce_Admin_Features_Blueprint_array) rt.PhpVal {
	mut var_exporters_mutated := var_exporters
	return rt.call_function('array_merge', [var_exporters_mutated.dup(),
		this.get_woo_exporters()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) get_plugins_for_export_group() rt.PhpVal {
	mut var_plugins := this.get_installed_wp_org_plugins()
	mut var_active_plugins := this.wp_get_option(rt.new_string('active_plugins'), rt.new_array())
	closure_3_fn := fn [var_active_plugins] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_2_fn := fn [var_active_plugins] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			mut var_plugin := if args.len > 1 { args[1].dup() } else { rt.new_null() }
			return rt.create_array([rt.ArrayItem{ key: 'id', val: var_key },
				rt.ArrayItem{ key: 'label', val: var_plugin.array_get('Name') },
				rt.ArrayItem{ key: 'checked', val: rt.call_function('in_array', [
					var_key.dup(),
					var_active_plugins.dup(),
					rt.new_bool(true),
				]) }])
		}
		mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_plugin := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: 'id', val: var_key },
			rt.ArrayItem{ key: 'label', val: var_plugin.array_get('Name') },
			rt.ArrayItem{ key: 'checked', val: rt.call_function('in_array', [
				var_key.dup(), var_active_plugins.dup(), rt.new_bool(true)]) }])
	}
	var_plugins = rt.call_function('array_map', [rt.new_closure(closure_2_fn),
		rt.func_array_keys(var_plugins.dup()), var_plugins.dup()])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		return
	}
	rt.call_function('usort', [var_plugins.dup(), rt.new_closure(closure_4_fn)])
	return var_plugins.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) clear_installed_wp_org_plugins_transient() {
	rt.call_function('delete_transient', [
		Class_Automattic_WooCommerce_Admin_Features_Blueprint_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_plugins_transient(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) clear_installed_wp_org_themes_transient() {
	rt.call_function('delete_transient', [
		Class_Automattic_WooCommerce_Admin_Features_Blueprint_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_themes_transient(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) get_themes_for_export_group() rt.PhpVal {
	mut var_themes := this.get_installed_wp_org_themes()
	mut var_active_theme := this.wp_get_theme()
	closure_6_fn := fn [var_active_theme] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_5_fn := fn [var_active_theme] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_theme := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.call_method(var_theme, 'get_stylesheet',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'label', val: rt.call_method(var_theme, 'get', [
					rt.new_string('Name'),
				]) },
				rt.ArrayItem{ key: 'checked', val: rt.identical(rt.call_method(var_theme,
					'get_stylesheet', []rt.PhpVal{}), rt.call_method(var_active_theme,
					'get_stylesheet', []rt.PhpVal{})) },
			])
		}
		mut var_theme := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'label', val: rt.call_method(var_theme, 'get', [
				rt.new_string('Name'),
			]) },
			rt.ArrayItem{ key: 'checked', val: rt.identical(rt.call_method(var_theme,
				'get_stylesheet', []rt.PhpVal{}), rt.call_method(var_active_theme,
				'get_stylesheet', []rt.PhpVal{})) },
		])
	}
	var_themes = rt.call_function('array_map', [rt.new_closure(closure_5_fn),
		var_themes.dup()])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		return
	}
	rt.call_function('usort', [var_themes.dup(), rt.new_closure(closure_7_fn)])
	return rt.call_function('array_values', [var_themes.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) get_step_groups_for_js() rt.PhpVal {
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_exporter := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{
					key: 'id'
					val: if rt.is_true(rt.new_bool(rt.instance_of(var_exporter,
						'Automattic_WooCommerce_Blueprint_Exporters_HasAlias')))
					{
						rt.call_method(var_exporter, 'get_alias', []rt.PhpVal{})
					} else {
						rt.call_method(var_exporter, 'get_step_name', []rt.PhpVal{})
					}
				},
				rt.ArrayItem{ key: 'label', val: rt.call_method(var_exporter, 'get_label',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'description', val: rt.call_method(var_exporter,
					'get_description', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'checked', val: true },
			])
		}
		mut var_exporter := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{
				key: 'id'
				val: if rt.is_true(rt.new_bool(rt.instance_of(var_exporter,
					'Automattic_WooCommerce_Blueprint_Exporters_HasAlias')))
				{
					rt.call_method(var_exporter, 'get_alias', []rt.PhpVal{})
				} else {
					rt.call_method(var_exporter, 'get_step_name', []rt.PhpVal{})
				}
			},
			rt.ArrayItem{ key: 'label', val: rt.call_method(var_exporter, 'get_label',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'description', val: rt.call_method(var_exporter, 'get_description',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'checked', val: true },
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'settings' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Includes all the items featured in WooCommerce | Settings.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('WooCommerce Settings'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'icon', val: 'settings' },
			rt.ArrayItem{ key: 'items', val: rt.call_function('array_map', [
				rt.new_closure(closure_8_fn),
				this.get_woo_exporters(),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'plugins' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Includes all the installed plugins.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Plugins'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'icon', val: 'plugins' },
			rt.ArrayItem{ key: 'items', val: this.get_plugins_for_export_group() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'themes' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Includes all the installed themes.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Themes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'icon', val: 'layout' },
			rt.ArrayItem{ key: 'items', val: this.get_themes_for_export_group() },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) add_js_vars(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return var_settings_mutated.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings-advanced-blueprint'), rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.get_instance()
	}(), 'get_current_screen_id', []rt.PhpVal{})))
	{
		var_settings_mutated.array_set('blueprint_step_groups', this.get_step_groups_for_js())
		var_settings_mutated.array_set('blueprint_max_step_size_bytes',
			Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi.max_file_size())
	}
	return var_settings_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) get_installed_wp_org_plugins() rt.PhpVal {
	mut var_wp_org_plugins := rt.call_function('get_transient', [
		Class_Automattic_WooCommerce_Admin_Features_Blueprint_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_plugins_transient(),
	])
	if rt.is_true(rt.new_bool(var_wp_org_plugins.dup().is_array())) {
		return var_wp_org_plugins.dup()
	}
	mut var_all_plugins := this.wp_get_plugins()
	mut var_plugin_slugs := rt.new_array()
	{
		mut iter_1 := var_all_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_key := item_1.key
			mut var_slug := rt.call_function('dirname', [var_key.dup()])
			var_slug = rt.call_function('apply_filters', [
				rt.new_string('wp_plugin_dependencies_slug'),
				var_slug.dup(),
			])
			var_plugin_slugs.array_push(var_slug.dup())
			var_all_plugins.array_get_mut(var_key).array_set('slug', var_slug.dup())
		}
	}
	mut var_api_response := this.wp_plugins_api(rt.new_string('plugin_information'), rt.create_array([
		rt.ArrayItem{ key: 'fields', val: rt.create_array([
			rt.ArrayItem{ key: 'short_description', val: false },
			rt.ArrayItem{ key: 'sections', val: false },
			rt.ArrayItem{ key: 'description', val: false },
			rt.ArrayItem{ key: 'tested', val: false },
			rt.ArrayItem{ key: 'requires', val: false },
			rt.ArrayItem{ key: 'rating', val: false },
			rt.ArrayItem{ key: 'ratings', val: false },
			rt.ArrayItem{ key: 'downloaded', val: false },
			rt.ArrayItem{ key: 'downloadlink', val: false },
			rt.ArrayItem{ key: 'last_updated', val: false },
			rt.ArrayItem{ key: 'added', val: false },
			rt.ArrayItem{ key: 'tags', val: false },
			rt.ArrayItem{ key: 'compatibility', val: false },
			rt.ArrayItem{ key: 'homepage', val: false },
			rt.ArrayItem{ key: 'versions', val: false },
			rt.ArrayItem{ key: 'donate_link', val: false },
			rt.ArrayItem{ key: 'reviews', val: false },
			rt.ArrayItem{ key: 'banners', val: false },
			rt.ArrayItem{ key: 'icons', val: false },
			rt.ArrayItem{ key: 'active_installs', val: false },
		]) },
		rt.ArrayItem{ key: 'slugs', val: var_plugin_slugs },
	]))
	if rt.is_true(rt.call_function('is_wp_error', [var_api_response.dup()])) {
		return var_all_plugins.dup()
	}
	closure_10_fn := fn [var_api_response] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_slug := var_plugin.array_get('slug')
		return rt.new_bool(
			!(rt.get_property(var_api_response, '{"nodeType":"Expr_Variable","line":321,"name":"slug"}')).is_null()
			&& !(rt.get_property(var_api_response, '{"nodeType":"Expr_Variable","line":321,"name":"slug"}').array_isset(rt.new_string('error'))))
	}
	var_wp_org_plugins = rt.call_function('array_filter', [var_all_plugins.dup(),
		rt.new_closure(closure_10_fn)])
	rt.call_function('set_transient', [
		Class_Automattic_WooCommerce_Admin_Features_Blueprint_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_plugins_transient(),
		var_wp_org_plugins.dup(),
	])
	return var_wp_org_plugins.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) get_installed_wp_org_themes() rt.PhpVal {
	mut var_wp_org_themes := rt.call_function('get_transient', [
		Class_Automattic_WooCommerce_Admin_Features_Blueprint_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_themes_transient(),
	])
	if rt.is_true(rt.new_bool(var_wp_org_themes.dup().is_array())) {
		return var_wp_org_themes.dup()
	}
	mut var_all_themes := this.wp_get_themes()
	mut var_theme_slugs := rt.new_array()
	{
		mut iter_1 := var_all_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_key.dup().is_string())) {
				var_theme_slugs.array_push(var_key.dup().to_string().to_lower())
			}
		}
	}
	mut var_api_response := this.wp_themes_api(rt.new_string('theme_information'), rt.create_array([
		rt.ArrayItem{ key: 'fields', val: rt.create_array([
			rt.ArrayItem{ key: 'downloadlink', val: true },
			rt.ArrayItem{ key: 'sections', val: false },
			rt.ArrayItem{ key: 'description', val: false },
			rt.ArrayItem{ key: 'rating', val: false },
			rt.ArrayItem{ key: 'ratings', val: false },
			rt.ArrayItem{ key: 'downloaded', val: false },
			rt.ArrayItem{ key: 'last_updated', val: false },
			rt.ArrayItem{ key: 'tags', val: false },
			rt.ArrayItem{ key: 'homepage', val: false },
			rt.ArrayItem{ key: 'screenshots', val: false },
			rt.ArrayItem{ key: 'screenshot_url', val: false },
			rt.ArrayItem{ key: 'parent', val: false },
			rt.ArrayItem{ key: 'versions', val: false },
			rt.ArrayItem{ key: 'extended_author', val: false },
		]) },
		rt.ArrayItem{ key: 'slugs', val: var_theme_slugs },
	]))
	if rt.is_true(rt.call_function('is_wp_error', [var_api_response.dup()])) {
		return var_all_themes.dup()
	}
	closure_11_fn := fn [var_api_response] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_theme := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_slug := rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
		return rt.new_bool(rt.get_property(var_api_response,
			'{"nodeType":"Expr_Variable","line":384,"name":"slug"}').array_isset(rt.new_string('download_link')))
	}
	var_wp_org_themes = rt.call_function('array_filter', [var_all_themes.dup(),
		rt.new_closure(closure_11_fn)])
	rt.call_function('set_transient', [
		Class_Automattic_WooCommerce_Admin_Features_Blueprint_Automattic_WooCommerce_Admin_Features_Blueprint_Init.installed_wp_org_themes_transient(),
		var_wp_org_themes.dup(),
	])
	return var_wp_org_themes.dup()
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_init() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init{
		PhpObjectBase:         rt.PhpObjectBase{}
		initialized_exporters: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_restapi() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_rest_api' {
			this.init_rest_api()
			return rt.new_null()
		}
		'get_woo_exporters' {
			return this.get_woo_exporters()
		}
		'add_woo_exporters' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Blueprint_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_woo_exporters(mut dispatch_arg_0)
		}
		'get_plugins_for_export_group' {
			return this.get_plugins_for_export_group()
		}
		'clear_installed_wp_org_plugins_transient' {
			this.clear_installed_wp_org_plugins_transient()
			return rt.new_null()
		}
		'clear_installed_wp_org_themes_transient' {
			this.clear_installed_wp_org_themes_transient()
			return rt.new_null()
		}
		'get_themes_for_export_group' {
			return this.get_themes_for_export_group()
		}
		'get_step_groups_for_js' {
			return this.get_step_groups_for_js()
		}
		'add_js_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_js_vars(dispatch_arg_0)
		}
		'get_installed_wp_org_plugins' {
			return this.get_installed_wp_org_plugins()
		}
		'get_installed_wp_org_themes' {
			return this.get_installed_wp_org_themes()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'initialized_exporters' { return this.initialized_exporters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'initialized_exporters' {
			this.initialized_exporters = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Blueprint_Init', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_blueprint_init()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_Init', []string{},
			obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_blueprint_restapi()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi', []string{},
			obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_PageController', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_pagecontroller()
		return rt.new_object('Automattic_WooCommerce_Admin_PageController', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_blueprint_init_php() {
	// unsupported statement: Stmt_Declare
}
