import rt

pub fn Class_WC_Admin_Menus.hide_css_class() string {
	return 'hide-if-js'
}

struct Class_WC_Admin_Menus {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Menus) construct() {
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'menu_highlight' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'menu_order_count' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_add_new_product_management_experience' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'admin_menu' },
		]),
		rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'orders_menu' },
		]),
		rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'reports_menu' },
		]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'settings_menu' },
		]),
		rt.new_int(50)])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'status_menu' },
		]),
		rt.new_int(60)])
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_show_addons_page'),
		rt.new_bool(true),
	]))
	{
		mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
		rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Marketplace.class(),
		])
		rt.call_function('add_action', [rt.new_string('admin_menu'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'addons_my_subscriptions' },
			]),
			rt.new_int(70)])
	}
	rt.call_function('add_filter', [rt.new_string('menu_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'menu_order' },
		])])
	rt.call_function('add_filter', [rt.new_string('custom_menu_order'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'custom_menu_order' },
		])])
	rt.call_function('add_filter', [rt.new_string('set-screen-option'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_screen_option' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('admin_head-nav-menus.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_nav_menu_meta_boxes' },
		])])
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_show_admin_bar_visit_store'),
		rt.new_bool(true),
	]))
	{
		rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'admin_bar_menus' },
			]),
			rt.new_int(31)])
	}
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_settings' },
		])])
}

fn (mut this Class_WC_Admin_Menus) admin_menu() {
	mut var_menu := []rt.PhpVal{}
	mut var_admin_page_hooks := map[string]rt.PhpVal{}
	mut var_woocommerce_icon :=
		rt.new_string('data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDg1LjkgNDcuNiI+CjxwYXRoIGZpbGw9IiNhMmFhYjIiIGQ9Ik03Ny40LDAuMWMtNC4zLDAtNy4xLDEuNC05LjYsNi4xTDU2LjQsMjcuN1Y4LjZjMC01LjctMi43LTguNS03LjctOC41cy03LjEsMS43LTkuNiw2LjVMMjguMywyNy43VjguOAoJYzAtNi4xLTIuNS04LjctOC42LTguN0g3LjNDMi42LDAuMSwwLDIuMywwLDYuM3MyLjUsNi40LDcuMSw2LjRoNS4xdjI0LjFjMCw2LjgsNC42LDEwLjgsMTEuMiwxMC44UzMzLDQ1LDM2LjMsMzguOWw3LjItMTMuNXYxMS40CgljMCw2LjcsNC40LDEwLjgsMTEuMSwxMC44czkuMi0yLjMsMTMtOC43bDE2LjYtMjhjMy42LTYuMSwxLjEtMTAuOC02LjktMTAuOEM3Ny4zLDAuMSw3Ny4zLDAuMSw3Ny40LDAuMXoiLz4KPC9zdmc+Cg==')
	if rt.is_true(Class_WC_Admin_Menus.can_view_woocommerce_menu_item()) {
		var_menu << rt.create_array([rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{
				key: none
				val: 'separator-woocommerce'
			}, rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{
				key: none
				val: 'wp-menu-separator woocommerce'
			}])
	}
	rt.call_function('add_menu_page', [
		rt.call_function('__', [rt.new_string('WooCommerce'),
			rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('WooCommerce'),
			rt.new_string('woocommerce')]),
		rt.new_string('edit_others_shop_orders'),
		rt.new_string('woocommerce'),
		rt.new_null(),
		var_woocommerce_icon.clone(),
		rt.new_string('55.5'),
	])
	var_admin_page_hooks['woocommerce'] = 'woocommerce'
	rt.call_function('add_submenu_page', [rt.new_string('edit.php?post_type=product'),
		rt.call_function('__', [rt.new_string('Attributes'), rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('Attributes'), rt.new_string('woocommerce')]),
		rt.new_string('manage_product_terms'), rt.new_string('product_attributes'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{},
			&this) }, rt.ArrayItem{ key: none, val: 'attributes_page' }])])
}

fn (mut this Class_WC_Admin_Menus) reports_menu() {
	if rt.is_true(Class_WC_Admin_Menus.can_view_woocommerce_menu_item()) {
		rt.call_function('add_submenu_page', [rt.new_string('woocommerce'),
			rt.call_function('__', [rt.new_string('Reports'),
				rt.new_string('woocommerce')]),
			rt.call_function('__', [rt.new_string('Reports'),
				rt.new_string('woocommerce')]),
			rt.new_string('view_woocommerce_reports'), rt.new_string('wc-reports'),
			rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus',
				[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'reports_page' }])])
	} else {
		rt.call_function('add_menu_page', [
			rt.call_function('__', [rt.new_string('Sales reports'),
				rt.new_string('woocommerce')]),
			rt.call_function('__', [rt.new_string('Sales reports'),
				rt.new_string('woocommerce')]),
			rt.new_string('view_woocommerce_reports'),
			rt.new_string('wc-reports'),
			rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus',
				[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'reports_page' }]),
			rt.new_string('dashicons-chart-bar'),
			rt.new_string('55.6'),
		])
	}
}

fn (mut this Class_WC_Admin_Menus) settings_menu() {
	mut var_settings_page := rt.call_function('add_submenu_page', [
		rt.new_string('woocommerce'),
		rt.call_function('__', [rt.new_string('WooCommerce settings'),
			rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('Settings'), rt.new_string('woocommerce')]),
		rt.new_string('manage_woocommerce'),
		rt.new_string('wc-settings'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{},
			&this) }, rt.ArrayItem{ key: none, val: 'settings_page' }]),
	])
	rt.call_function('add_action', [rt.new_string('load-' + var_settings_page.str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'settings_page_init' },
		])])
}

fn Class_WC_Admin_Menus.can_view_woocommerce_menu_item() rt.PhpVal {
	return rt.call_function('current_user_can', [
		rt.new_string('edit_others_shop_orders'),
	])
}

fn (mut this Class_WC_Admin_Menus) settings_page_init() {
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
	mut iife_temp_0 := Class_WC_Admin_Settings{}
	mut iife_result_0 := iife_temp_0.get_settings_pages()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc_error')))) {
		mut iife_temp_1 := Class_WC_Admin_Settings{}
		mut iife_result_1 := iife_temp_1.add_error(rt.call_function('wp_kses_post', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('wc_error'))]),
		]))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc_message')))) {
		mut iife_temp_2 := Class_WC_Admin_Settings{}
		mut iife_result_2 := iife_temp_2.add_message(rt.call_function('wp_kses_post', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('wc_message'))]),
		]))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_settings_page_init')])
}

fn (mut this Class_WC_Admin_Menus) save_settings() {
	mut var_current_tab := rt.get_superglobal('current_tab')
	mut var_current_section := rt.get_superglobal('current_section')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wc_admin_settings_page',
		[]rt.PhpVal{})))))
	{
		return
	}
	mut iife_temp_3 := Class_WC_Admin_Settings{}
	mut iife_result_3 := iife_temp_3.get_settings_pages()
	var_current_tab = if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('tab'))) { rt.new_string('general') } else { rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('tab'))]),
		]) }
	var_current_section = if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('section'))) { rt.new_string('') } else { rt.call_function('sanitize_title', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('section'))]),
		]) }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_current_section))))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_save_settings_${var_current_tab.to_string()}_${var_current_section.to_string()}'), rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('save')))))])) {
		mut iife_temp_4 := Class_WC_Admin_Settings{}
		mut iife_result_4 := iife_temp_4.save()
	} else if rt.is_true(rt.identical(rt.new_string(''), var_current_section))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_save_settings_${var_current_tab.to_string()}'), rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('save')))))])) {
		mut iife_temp_5 := Class_WC_Admin_Settings{}
		mut iife_result_5 := iife_temp_5.save()
	}
}

fn (mut this Class_WC_Admin_Menus) status_menu() {
	mut var_status_page := rt.call_function('add_submenu_page', [
		rt.new_string('woocommerce'),
		rt.call_function('__', [rt.new_string('WooCommerce status'),
			rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')]),
		rt.new_string('manage_woocommerce'),
		rt.new_string('wc-status'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{},
			&this) }, rt.ArrayItem{ key: none, val: 'status_page' }]),
	])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.identical(rt.new_string('logs'), rt.call_function('filter_input', [
			rt.get_constant('INPUT_GET'),
			rt.new_string('tab'),
		])))
		{
			rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
				Class_Automattic_WooCommerce_Internal_Admin_Logging_PageController.class(),
			])
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('load-' + var_status_page.str()),
		rt.new_closure(closure_7_fn), rt.new_int(1)])
}

fn (mut this Class_WC_Admin_Menus) addons_menu() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0')])
	mut iife_temp_7 := Class_WC_Helper_Updater{}
	mut iife_result_7 := iife_temp_7.get_updates_count_html()
	mut var_count_html := iife_result_7
	mut var_menu_title := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Extensions %s'),
			rt.new_string('woocommerce')]),
		var_count_html.clone(),
	])
	rt.call_function('add_submenu_page', [rt.new_string('woocommerce'),
		rt.call_function('__', [rt.new_string('WooCommerce extensions'),
			rt.new_string('woocommerce')]),
		var_menu_title.clone(), rt.new_string('manage_woocommerce'),
		rt.new_string('wc-addons'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'addons_page' }])])
}

fn (mut this Class_WC_Admin_Menus) addons_my_subscriptions() {
	rt.call_function('add_submenu_page', [rt.new_string('woocommerce'),
		rt.call_function('__', [rt.new_string('WooCommerce extensions'),
			rt.new_string('woocommerce')]),
		rt.new_null(), rt.new_string('manage_woocommerce'), rt.new_string('wc-addons'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{},
			&this) }, rt.ArrayItem{ key: none, val: 'addons_page' }])])
	this.hide_submenu_page(rt.new_string('woocommerce'), rt.new_string('wc-addons'))
}

fn (mut this Class_WC_Admin_Menus) menu_highlight() {
	mut var_post_type := rt.new_null()
	mut var_parent_file := rt.get_superglobal('parent_file')
	mut var_submenu_file := rt.get_superglobal('submenu_file')
	mut switch_val_1 := var_post_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('shop_order')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('shop_coupon'))) {
		var_parent_file = rt.new_string('woocommerce')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
		mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
		if rt.is_true(var_screen)
			&& rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_screen, 'taxonomy')])) {
			var_submenu_file = rt.new_string('product_attributes')
			var_parent_file = rt.new_string('edit.php?post_type=product')
		}
	}
}

fn (mut this Class_WC_Admin_Menus) menu_order_count() {
	mut var_submenu := rt.new_null()
	if var_submenu.array_isset(rt.new_string('woocommerce')) {
		var_submenu.array_get(rt.new_string('woocommerce')).array_unset(rt.new_int(0))
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_include_processing_order_count_in_menu'), rt.new_bool(true)]))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_shop_orders')])) {
			mut var_order_count := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_menu_order_count'),
				rt.call_function('wc_processing_order_count', []rt.PhpVal{}),
			])
			if rt.is_true(var_order_count) {
				mut iter_1 := var_submenu.array_get(rt.new_string('woocommerce')).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_menu_item := item_1.val
					mut var_key := item_1.key
					if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
						var_menu_item.array_get(rt.new_int(0)),
						rt.call_function('_x', [rt.new_string('Orders'),
							rt.new_string('Admin menu name'),
							rt.new_string('woocommerce')]),
					])))
					{
						var_submenu.array_get(rt.new_string('woocommerce')).array_get(var_key).array_get(rt.new_int(0)) = rt.concat(var_submenu.array_get(rt.new_string('woocommerce')).array_get(var_key).array_get(rt.new_int(0)), rt.new_string(
							' <span class="menu-counter count-' +
							(rt.call_function('esc_attr', [var_order_count.clone()])).str() +
							'"><span class="processing-count">' +
							(rt.call_function('number_format_i18n', [var_order_count.clone()])).str() +
							'</span></span>'))
						break
					}
				}
			}
		}
	}
}

fn (mut this Class_WC_Admin_Menus) menu_order(var_menu_order rt.PhpVal) rt.PhpVal {
	mut var_woocommerce_menu_order := []rt.PhpVal{}
	mut var_woocommerce_separator := rt.call_function('array_search', [
		rt.new_string('separator-woocommerce'),
		var_menu_order.clone(),
		rt.new_bool(true),
	])
	mut var_woocommerce_product := rt.call_function('array_search', [
		rt.new_string('edit.php?post_type=product'),
		var_menu_order.clone(),
		rt.new_bool(true),
	])
	mut iter_2 := var_menu_order.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item := item_2.val
		mut var_index := item_2.key
		if rt.is_true(rt.identical(rt.new_string('woocommerce'), var_item)) {
			var_woocommerce_menu_order << rt.new_string('separator-woocommerce')
			var_woocommerce_menu_order << var_item.clone()
			var_woocommerce_menu_order << rt.new_string('edit.php?post_type=product')
			var_menu_order.array_unset(var_woocommerce_separator)
			var_menu_order.array_unset(var_woocommerce_product)
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_item.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'separator-woocommerce' }]),
			rt.new_bool(true),
		])))))
		{
			var_woocommerce_menu_order << var_item.clone()
		}
	}
	return var_woocommerce_menu_order.clone()
}

fn (mut this Class_WC_Admin_Menus) custom_menu_order(var_enabled rt.PhpVal) bool {
	return rt.is_true(var_enabled)
		|| rt.is_true(Class_WC_Admin_Menus.can_view_woocommerce_menu_item())
}

fn (mut this Class_WC_Admin_Menus) set_screen_option(var_status rt.PhpVal, var_option rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_screen_options := [rt.new_string('woocommerce_keys_per_page'),
		rt.new_string('woocommerce_webhooks_per_page'),
		Class_FileListTable.per_page_user_option_key(),
		Class_SearchListTable.per_page_user_option_key(),
		Class_WC_Admin_Log_Table_List.per_page_user_option_key()]
	if rt.is_true(rt.call_function('in_array', [var_option.clone(),
		rt.create_array_from_list(var_screen_options), rt.new_bool(true)]))
	{
		return var_value.clone()
	}
	return var_status.clone()
}

fn (mut this Class_WC_Admin_Menus) reports_page() {
	mut iife_temp_8 := Class_WC_Admin_Reports{}
	mut iife_result_8 := iife_temp_8.output()
}

fn (mut this Class_WC_Admin_Menus) settings_page() {
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_9 := iife_temp_9.is_enabled(rt.new_string('settings'))
	if rt.is_true(iife_result_9) {
		print('<div id="wc-settings-page"/>')
	} else {
		mut iife_temp_10 := Class_WC_Admin_Settings{}
		mut iife_result_10 := iife_temp_10.output()
	}
}

fn (mut this Class_WC_Admin_Menus) attributes_page() {
	mut iife_temp_11 := Class_WC_Admin_Attributes{}
	mut iife_result_11 := iife_temp_11.output()
}

fn (mut this Class_WC_Admin_Menus) status_page() {
	mut iife_temp_12 := Class_WC_Admin_Status{}
	mut iife_result_12 := iife_temp_12.output()
}

fn (mut this Class_WC_Admin_Menus) addons_page() {
	mut iife_temp_13 := Class_WC_Admin_Addons{}
	mut iife_result_13 := iife_temp_13.handle_legacy_marketplace_redirects()
}

fn (mut this Class_WC_Admin_Menus) orders_menu() {
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))
	{
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class(),
		]), 'setup', []rt.PhpVal{})
	} else {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController.class(),
		]), 'setup', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Admin_Menus) add_nav_menu_meta_boxes() {
	rt.call_function('add_meta_box', [rt.new_string('woocommerce_endpoints_nav_link'),
		rt.call_function('__', [rt.new_string('WooCommerce endpoints'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Menus', []string{},
			&this) }, rt.ArrayItem{ key: none, val: 'nav_menu_links' }]),
		rt.new_string('nav-menus'), rt.new_string('side'), rt.new_string('low')])
}

fn (mut this Class_WC_Admin_Menus) nav_menu_links() {
	mut var_endpoints := rt.call_function('wc_get_account_menu_items', []rt.PhpVal{})
	if var_endpoints.array_isset(rt.new_string('dashboard')) {
		var_endpoints.array_unset(rt.new_string('dashboard'))
	}
	if !(!rt.is_true(rt.call_function('get_option', [
		rt.new_string('woocommerce_myaccount_lost_password_endpoint'),
	]))) {
		var_endpoints.array_set('lost-password', rt.call_function('__', [
			rt.new_string('Lost password'),
			rt.new_string('woocommerce'),
		]))
	}
	var_endpoints = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_custom_nav_menu_items'),
		var_endpoints.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_i := rt.new_int(-1)
	mut iter_3 := var_endpoints.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_value.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wc_get_account_endpoint_url', [
				var_key.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.pre_dec(var_i)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Select all'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add to menu'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add to menu'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Menus) admin_bar_menus(var_wp_admin_bar rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin_bar_showing', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_super_admin', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_int(rt.call_function('get_option', [
		rt.new_string('page_on_front'),
	]).to_i64()), rt.call_function('wc_get_page_id', [rt.new_string('shop')])))
	{
		return
	}
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'site-name' },
			rt.ArrayItem{ key: 'id', val: 'view-store' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Visit Store'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('wc_get_page_permalink', [
				rt.new_string('shop'),
			]) }]),
	])
}

fn (mut this Class_WC_Admin_Menus) maybe_add_new_product_management_experience() {
	mut var_submenu := rt.new_null()
	mut iife_temp_14 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_14 := iife_temp_14.feature_is_enabled(rt.new_string('product_block_editor'))
	if rt.is_true(iife_result_14) {
		if var_submenu.array_get(rt.new_string('edit.php?post_type=product')).array_isset(rt.new_int(10)) {
			var_submenu.array_get_mut('edit.php?post_type=product').array_get_mut(10).array_set(2,
				'admin.php?page=wc-admin&path=/add-product')
		}
	}
}

fn (mut this Class_WC_Admin_Menus) hide_submenu_page(var_menu_slug rt.PhpVal, var_submenu_slug rt.PhpVal) rt.PhpVal {
	mut var_submenu := rt.new_null()
	if !(var_submenu.array_isset(var_menu_slug)) {
		return rt.new_bool(false)
	}
	mut iter_4 := var_submenu.array_get(var_menu_slug).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_item := item_4.val
		mut var_i := item_4.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_submenu_slug,
			var_item.array_get(rt.new_int(2))))))
		{
			continue
		}
		this.hide_submenu_element(var_i.clone(), var_menu_slug.clone(), var_item.clone())
		return var_item.clone()
	}
	return rt.new_bool(false)
}

fn (mut this Class_WC_Admin_Menus) hide_submenu_element(var_index rt.PhpVal, var_parent_slug rt.PhpVal, var_item rt.PhpVal) {
	mut var_submenu := rt.new_null()
	mut var_css_classes := rt.new_string((if !rt.is_true(var_item.array_get(rt.new_int(4))) {
		Class_WC_Admin_Menus.hide_css_class()
	} else {
		(var_item.array_get(rt.new_int(4))).str() + ' ' + Class_WC_Admin_Menus.hide_css_class()
	}).str())
	var_submenu.array_get_mut(var_parent_slug).array_get_mut(var_index).array_set(4,
		var_css_classes.clone())
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Reports {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Attributes {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Addons {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_admin_menus() &Class_WC_Admin_Menus {
	mut obj := &Class_WC_Admin_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_updater(_args ...rt.PhpVal) &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_reports(_args ...rt.PhpVal) &Class_WC_Admin_Reports {
	mut obj := &Class_WC_Admin_Reports{
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

fn create_wc_admin_attributes(_args ...rt.PhpVal) &Class_WC_Admin_Attributes {
	mut obj := &Class_WC_Admin_Attributes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_status(_args ...rt.PhpVal) &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
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

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'admin_menu' {
			this.admin_menu()
			return rt.new_null()
		}
		'reports_menu' {
			this.reports_menu()
			return rt.new_null()
		}
		'settings_menu' {
			this.settings_menu()
			return rt.new_null()
		}
		'can_view_woocommerce_menu_item' {
			return Class_WC_Admin_Menus.can_view_woocommerce_menu_item()
		}
		'settings_page_init' {
			this.settings_page_init()
			return rt.new_null()
		}
		'save_settings' {
			this.save_settings()
			return rt.new_null()
		}
		'status_menu' {
			this.status_menu()
			return rt.new_null()
		}
		'addons_menu' {
			this.addons_menu()
			return rt.new_null()
		}
		'addons_my_subscriptions' {
			this.addons_my_subscriptions()
			return rt.new_null()
		}
		'menu_highlight' {
			this.menu_highlight()
			return rt.new_null()
		}
		'menu_order_count' {
			this.menu_order_count()
			return rt.new_null()
		}
		'menu_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.menu_order(dispatch_arg_0)
		}
		'custom_menu_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.custom_menu_order(dispatch_arg_0))
		}
		'set_screen_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.set_screen_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'reports_page' {
			this.reports_page()
			return rt.new_null()
		}
		'settings_page' {
			this.settings_page()
			return rt.new_null()
		}
		'attributes_page' {
			this.attributes_page()
			return rt.new_null()
		}
		'status_page' {
			this.status_page()
			return rt.new_null()
		}
		'addons_page' {
			this.addons_page()
			return rt.new_null()
		}
		'orders_menu' {
			this.orders_menu()
			return rt.new_null()
		}
		'add_nav_menu_meta_boxes' {
			this.add_nav_menu_meta_boxes()
			return rt.new_null()
		}
		'nav_menu_links' {
			this.nav_menu_links()
			return rt.new_null()
		}
		'admin_bar_menus' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.admin_bar_menus(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_add_new_product_management_experience' {
			this.maybe_add_new_product_management_experience()
			return rt.new_null()
		}
		'hide_submenu_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.hide_submenu_page(dispatch_arg_0, dispatch_arg_1)
		}
		'hide_submenu_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.hide_submenu_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Reports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Reports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Reports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Admin_Attributes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Attributes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Attributes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Menus'),
		rt.new_bool(false)]))
	{
		return rt.new_object('WC_Admin_Menus', []string{}, create_wc_admin_menus())
	}
	return rt.new_object('WC_Admin_Menus', []string{}, create_wc_admin_menus())
}
