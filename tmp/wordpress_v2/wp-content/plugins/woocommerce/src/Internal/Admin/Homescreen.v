import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Homescreen.menu_slug() string {
	return 'wc-admin'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Homescreen {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_homescreen() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Homescreen', 'instance',
		rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Homescreen.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Homescreen',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Homescreen', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self',
			[]string{}, create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Homescreen', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) construct() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_get_user_data_fields'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Homescreen',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_user_data_fields' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Homescreen',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_page' },
		])])
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('WC_VERSION'),
		rt.new_string('5.1'), rt.new_string('>=')]))
	{
		rt.call_function('add_action', [rt.new_string('admin_menu'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Homescreen',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'possibly_remove_woocommerce_menu' },
			])])
		rt.call_function('add_action', [rt.new_string('admin_menu'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Homescreen',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'update_link_structure' },
			]),
			rt.new_int(20)])
	} else {
		rt.call_function('add_action', [rt.new_string('admin_head'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Homescreen',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'update_link_structure' },
			]),
			rt.new_int(20)])
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_preload_options'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Homescreen',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'preload_options' },
		])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('shipping-smart-defaults'))
	if rt.is_true(iife_result_0) {
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_admin_shared_settings'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Homescreen',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'maybe_set_default_shipping_options_on_home' },
			]),
			rt.new_int(9999),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) maybe_set_default_shipping_options_on_home(var_settings rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_current_screen'),
	])))))
	{
		return var_settings.clone()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if !(!(rt.get_property(var_current_screen, 'id')).is_null())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-admin'), rt.get_property(var_current_screen, 'id'))))) {
		return var_settings.clone()
	}
	mut var_already_created := rt.call_function('get_option', [
		rt.new_string('woocommerce_admin_created_default_shipping_zones'),
	])
	if rt.is_true(rt.identical(rt.new_string('yes'), var_already_created)) {
		return var_settings.clone()
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('shipping-zone'))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('shipping-zone'))
	mut var_zone_count :=
		rt.new_int(rt.call_method(iife_result_1, 'get_zones', []rt.PhpVal{}).array_count())
	if rt.is_true(var_zone_count) {
		rt.call_function('update_option', [
			rt.new_string('woocommerce_admin_created_default_shipping_zones'),
			rt.new_string('yes'),
		])
		rt.call_function('update_option', [
			rt.new_string('woocommerce_admin_reviewed_default_shipping_zones'),
			rt.new_string('yes'),
		])
		return var_settings.clone()
	}
	mut var_user_skipped_obw := if !(var_settings.array_get(rt.new_string('onboarding')).array_get(rt.new_string('profile')).array_get(rt.new_string('skipped'))).is_null() {
		var_settings.array_get(rt.new_string('onboarding')).array_get(rt.new_string('profile')).array_get(rt.new_string('skipped'))
	} else {
		rt.new_bool(false)
	}
	mut var_store_address := if !(var_settings.array_get(rt.new_string('preloadSettings')).array_get(rt.new_string('general')).array_get(rt.new_string('woocommerce_store_address'))).is_null() {
		var_settings.array_get(rt.new_string('preloadSettings')).array_get(rt.new_string('general')).array_get(rt.new_string('woocommerce_store_address'))
	} else {
		rt.new_string('')
	}
	mut var_product_types := if !(var_settings.array_get(rt.new_string('onboarding')).array_get(rt.new_string('profile')).array_get(rt.new_string('product_types'))).is_null() {
		var_settings.array_get(rt.new_string('onboarding')).array_get(rt.new_string('profile')).array_get(rt.new_string('product_types'))
	} else {
		rt.new_array()
	}
	mut var_user_has_set_store_country := if !(var_settings.array_get(rt.new_string('onboarding')).array_get(rt.new_string('profile')).array_get(rt.new_string('is_store_country_set'))).is_null() {
		var_settings.array_get(rt.new_string('onboarding')).array_get(rt.new_string('profile')).array_get(rt.new_string('is_store_country_set'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_has_set_store_country)))) {
		return var_settings.clone()
	}
	if rt.is_true(var_user_skipped_obw)
		|| rt.is_true(rt.identical(rt.new_string(''), var_store_address)) {
		var_product_types.array_push('physical')
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('in_array', [
		rt.new_string('physical'),
		var_product_types.clone(),
		rt.new_bool(true),
	])))
	{
		return var_settings.clone()
	}
	mut var_country_code := rt.call_function('wc_format_country_state_string', [
		var_settings.array_get(rt.new_string('preloadSettings')).array_get(rt.new_string('general')).array_get(rt.new_string('woocommerce_default_country')),
	]).array_get(rt.new_string('country'))
	mut var_country_name := if !(rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{}).array_get(var_country_code)).is_null() {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_countries', []rt.PhpVal{}).array_get(var_country_code)
	} else {
		rt.new_null()
	}
	mut var_is_jetpack_installed := rt.call_function('in_array', [
		rt.new_string('jetpack'),
		if !(var_settings.array_get(rt.new_string('plugins')).array_get(rt.new_string('installedPlugins'))).is_null() {
			var_settings.array_get(rt.new_string('plugins')).array_get(rt.new_string('installedPlugins'))
		} else {
			rt.new_array()
		},
		rt.new_bool(true),
	])
	mut var_is_wcs_installed := rt.call_function('in_array', [
		rt.new_string('woocommerce-services'),
		if !(var_settings.array_get(rt.new_string('plugins')).array_get(rt.new_string('installedPlugins'))).is_null() {
			var_settings.array_get(rt.new_string('plugins')).array_get(rt.new_string('installedPlugins'))
		} else {
			rt.new_array()
		},
		rt.new_bool(true),
	])
	if ((rt.is_true(rt.identical(rt.new_string('US'), var_country_code))
		&& rt.is_true(var_is_jetpack_installed))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_country_code.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'US'
	}, rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'AU' }, rt.ArrayItem{
		key: none
		val: 'NZ'
	}, rt.ArrayItem{ key: none, val: 'SG' }, rt.ArrayItem{ key: none, val: 'HK' }, rt.ArrayItem{
		key: none
		val: 'GB'
	}, rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'IT' }, rt.ArrayItem{
		key: none
		val: 'DE'
	}, rt.ArrayItem{ key: none, val: 'FR' }, rt.ArrayItem{ key: none, val: 'MX' }, rt.ArrayItem{
		key: none
		val: 'CO'
	}, rt.ArrayItem{ key: none, val: 'CL' }, rt.ArrayItem{ key: none, val: 'AR' }, rt.ArrayItem{
		key: none
		val: 'PE'
	}, rt.ArrayItem{ key: none, val: 'BR' }, rt.ArrayItem{ key: none, val: 'UY' }, rt.ArrayItem{
		key: none
		val: 'GT'
	}, rt.ArrayItem{ key: none, val: 'NL' }, rt.ArrayItem{ key: none, val: 'AT' }, rt.ArrayItem{
		key: none
		val: 'BE'
	}]), rt.new_bool(true)]))))))
		|| (rt.is_true(rt.identical(rt.new_string('US'), var_country_code))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_is_jetpack_installed))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_is_wcs_installed))) {
		mut var_zone := create_automattic_woocommerce_internal_admin_wc_shipping_zone()
		var_zone.set_zone_name(var_country_name.clone())
		var_zone.add_location(var_country_code.clone(), rt.new_string('country'))
		mut var_instance_id := var_zone.add_shipping_method(rt.new_string('free_shipping'))
		mut var_request := create_automattic_woocommerce_internal_admin_wp_rest_request(rt.new_string('POST'),
			'/wc/v2/shipping/zones/' +
			(var_zone.get_id()).str() + '/methods/' + var_instance_id.str())
		var_request.set_body_params(rt.create_array([
			rt.ArrayItem{ key: 'settings', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: 'Free shipping' },
			]) },
		]))
		rt.call_function('rest_do_request', [var_request])
		rt.call_function('update_option', [
			rt.new_string('woocommerce_admin_created_default_shipping_zones'),
			rt.new_string('yes'),
		])
		mut iife_temp_3 :=
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping{}
		mut iife_result_3 := iife_temp_3.delete_zone_count_transient()
	}
	return var_settings.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) add_user_data_fields(var_user_data_fields rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_user_data_fields.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'homepage_layout' },
			rt.ArrayItem{ key: none, val: 'homepage_stats' },
			rt.ArrayItem{ key: none, val: 'task_list_tracked_started_tasks' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) register_page() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Homescreen.is_admin_user())))) {
		rt.call_function('wc_admin_register_page', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-home' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('WooCommerce'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{
					key: 'path'
					val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Homescreen.menu_slug()
				}, rt.ArrayItem{ key: 'capability', val: 'read' }]),
		])
		return
	}
	rt.call_function('wc_admin_register_page', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-home' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Home'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'parent', val: 'woocommerce' },
			rt.ArrayItem{
				key: 'path'
				val: Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Homescreen.menu_slug()
			}, rt.ArrayItem{ key: 'order', val: 0 }, rt.ArrayItem{ key: 'capability', val: 'read' }]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Homescreen.is_admin_user() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Menus'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/class-wc-admin-menus.php', '2')
	}
	if rt.is_true(rt.call_function('method_exists', [rt.new_string('WC_Admin_Menus'),
		rt.new_string('can_view_woocommerce_menu_item')]))
	{
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_WC_Admin_Menus{}
		mut iife_result_4 := iife_temp_4.can_view_woocommerce_menu_item()
		return rt.is_true(iife_result_4)
			|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
	} else {
		return
			rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_shop_orders')]))
			|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) possibly_remove_woocommerce_menu() {
	mut var_menu := rt.new_null()
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Homescreen.is_admin_user()) {
		return
	}
	mut iter_1 := var_menu.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_menu_item := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Homescreen.menu_slug(), var_menu_item.array_get(rt.new_int(2))))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('read'), var_menu_item.array_get(rt.new_int(1)))))) {
			continue
		}
		var_menu.array_unset(var_key)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) update_link_structure() {
	mut var_submenu := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))))
		|| !rt.is_true(var_submenu.array_get(rt.new_string('woocommerce'))) {
		return
	}
	mut var_wc_admin_key := rt.new_null()
	mut iter_2 := var_submenu.array_get(rt.new_string('woocommerce')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_submenu_item := item_2.val
		mut var_submenu_key := item_2.key
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Homescreen.menu_slug(),
			var_submenu_item.array_get(rt.new_int(2))))
		{
			var_wc_admin_key = var_submenu_key
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_admin_key)))) {
		return
	}
	mut var_menu := var_submenu.array_get(rt.new_string('woocommerce')).array_get(var_wc_admin_key)
	var_submenu.array_get(rt.new_string('woocommerce')).array_unset(var_wc_admin_key)
	rt.call_function('array_unshift', [var_submenu.array_get(rt.new_string('woocommerce')),
		var_menu.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) preload_options(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	var_options_mutated.array_push('woocommerce_default_homepage_layout')
	var_options_mutated.array_push('woocommerce_admin_install_timestamp')
	return var_options_mutated.clone()
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Admin_Menus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_homescreen() &Class_Automattic_WooCommerce_Internal_Admin_Homescreen {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Homescreen{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn create_automattic_woocommerce_internal_admin_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_shipping_zone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Shipping_Zone {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Shipping_Zone{
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

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_shipping(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_admin_menus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Admin_Menus {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Admin_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Homescreen.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'maybe_set_default_shipping_options_on_home' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.maybe_set_default_shipping_options_on_home(dispatch_arg_0)
		}
		'add_user_data_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_user_data_fields(dispatch_arg_0)
		}
		'register_page' {
			this.register_page()
			return rt.new_null()
		}
		'is_admin_user' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Homescreen.is_admin_user())
		}
		'possibly_remove_woocommerce_menu' {
			this.possibly_remove_woocommerce_menu()
			return rt.new_null()
		}
		'update_link_structure' {
			this.update_link_structure()
			return rt.new_null()
		}
		'preload_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.preload_options(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Homescreen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Homescreen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Admin_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Admin_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Admin_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
