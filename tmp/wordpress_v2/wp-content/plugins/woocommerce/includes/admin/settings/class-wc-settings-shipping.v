import rt

struct Class_WC_Settings_Shipping {
	rt.PhpObjectBase
pub mut:
	icon rt.PhpVal = rt.new_string('shipping')
}

fn (mut this Class_WC_Settings_Shipping) construct() {
	this.dispatch_set_prop('id', rt.new_string('shipping'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Shipping'),
		rt.new_string('woocommerce')]))
	this.Class_WC_Settings_Page.construct()
}

fn (mut this Class_WC_Settings_Shipping) add_settings_page(var_pages rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})) {
		this.Class_WC_Settings_Page.add_settings_page(var_pages.clone())
	} else {
		var_pages
	}
}

fn (mut this Class_WC_Settings_Shipping) get_own_sections() rt.PhpVal {
	mut var_sections := {
		'':        rt.call_function('__', [rt.new_string('Shipping zones'),
			rt.new_string('woocommerce')])
		'options': rt.call_function('__', [rt.new_string('Shipping settings'),
			rt.new_string('woocommerce')])
		'classes': rt.call_function('__', [rt.new_string('Classes'),
			rt.new_string('woocommerce')])
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('fulfillments'))
	if rt.is_true(iife_result_0) {
		var_sections['fulfillment-providers'] = rt.call_function('__', [
			rt.new_string('Shipping providers'),
			rt.new_string('woocommerce'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.wc_is_installing())))) {
		mut var_shipping_methods := this.get_shipping_methods()
		mut iter_1 := var_shipping_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'has_settings',
				[]rt.PhpVal{})))))
			{
				continue
			}
			mut var_title := if !rt.is_true(rt.get_property(var_method, 'method_title')) { rt.call_function('ucfirst', [
					rt.get_property(var_method, 'id'),
				]) } else { rt.get_property(var_method, 'method_title') }
			var_sections[rt.get_property(var_method, 'id').to_string().to_lower()] = rt.call_function('esc_html', [
				var_title.clone(),
			])
		}
	}
	return var_sections.clone()
}

fn (mut this Class_WC_Settings_Shipping) wc_is_installing() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.is_defined(rt.new_string('WC_INSTALLING'))
	return iife_result_1
}

fn (mut this Class_WC_Settings_Shipping) get_shipping_methods() rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping',
		[]rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_Shipping) get_settings_for_options_section() rt.PhpVal {
	mut var_settings := [
		[
			rt.call_function('__', [rt.new_string('Shipping settings'),
				rt.new_string('woocommerce')]),
			rt.new_string('title'),
			rt.new_string('shipping_options'),
		],
		[
			rt.call_function('__', [rt.new_string('Calculations'),
				rt.new_string('woocommerce')]),
			rt.call_function('__', [rt.new_string('Enable the shipping calculator on the cart page'),
				rt.new_string('woocommerce')]),
			rt.new_string('woocommerce_enable_shipping_calc'),
			rt.new_string('yes'),
			rt.new_string('checkbox'),
			rt.new_string('start'),
			rt.new_bool(false),
		],
		[
			rt.call_function('__', [rt.new_string('Hide shipping costs until an address is entered'),
				rt.new_string('woocommerce')]),
			rt.new_string('woocommerce_shipping_cost_requires_address'),
			rt.new_string('no'),
			rt.new_string('checkbox'),
			rt.new_string(''),
		],
		[
			rt.call_function('__', [
				rt.new_string('Hide shipping rates when free shipping is available'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('woocommerce_shipping_hide_rates_when_free'),
			rt.new_string('no'),
			rt.new_string('checkbox'),
			rt.new_bool(false),
			rt.new_string('end'),
		],
		[
			rt.call_function('__', [
				rt.new_string('Shipping destination'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('__', [
				rt.new_string('This controls which shipping address is used by default.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('woocommerce_ship_to_destination'),
			rt.new_string('billing'),
			rt.new_string('radio'),
			[
				rt.call_function('__', [
					rt.new_string('Default to customer shipping address'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('Default to customer billing address'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('Force shipping to the customer billing address'),
					rt.new_string('woocommerce'),
				]),
			],
			rt.new_bool(false),
			rt.new_bool(true),
			rt.new_string('option'),
		],
		[
			rt.call_function('__', [
				rt.new_string('Debug mode'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('__', [
				rt.new_string('Enable debug mode'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('__', [
				rt.new_string('Enable shipping debug mode to show matching shipping zones and to bypass shipping rate cache.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('woocommerce_shipping_debug_mode'),
			rt.new_string('no'),
			rt.new_string('checkbox'),
		],
		[
			rt.new_string('sectionend'),
			rt.new_string('shipping_options'),
		],
	]
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_settings'),
		rt.create_array_from_list(var_settings),
	])
}

fn (mut this Class_WC_Settings_Shipping) output() {
	mut var_current_section := rt.new_null()
	mut var_hide_save_button := rt.get_superglobal('hide_save_button')
	mut var_shipping_methods := this.get_shipping_methods()
	if rt.is_true(rt.identical(rt.new_string(''), var_current_section)) {
		this.output_zones_screen()
	} else if rt.is_true(rt.identical(rt.new_string('classes'), var_current_section)) {
		var_hide_save_button = rt.new_bool(true)
		this.output_shipping_class_screen()
		mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		mut iife_result_2 := iife_temp_2.feature_is_enabled(rt.new_string('fulfillments'))
	} else if rt.is_true(rt.identical(rt.new_string('fulfillment-providers'), var_current_section))
		&& rt.is_true(iife_result_2) {
		var_hide_save_button = rt.new_bool(true)
		this.output_shipping_providers_screen()
	} else {
		mut var_is_shipping_method := rt.new_bool(false)
		mut iter_2 := var_shipping_methods.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_method := item_2.val
			if rt.is_true(rt.call_function('in_array', [var_current_section.clone(), rt.create_array([rt.ArrayItem{
				key: none
				val: rt.get_property(var_method, 'id')
			}, rt.ArrayItem{
				key: none
				val: rt.call_function('sanitize_title', [rt.call_function('get_class', [var_method.clone()])])
			}]), rt.new_bool(true)]))
				&& rt.is_true(rt.call_method(var_method, 'has_settings', []rt.PhpVal{})) {
				var_is_shipping_method = rt.new_bool(true)
				rt.call_method(var_method, 'admin_options', []rt.PhpVal{})
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_shipping_method)))) {
			this.Class_WC_Settings_Page.output()
		}
	}
}

fn (mut this Class_WC_Settings_Shipping) save() {
	mut var_current_section := rt.new_null()
	mut switch_val_1 := var_current_section
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('options'))) {
		this.save_settings_for_current_section()
		this.do_update_options_action()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('classes'))) {
		this.do_update_options_action()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fulfillment-providers'))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		mut iife_result_3 := iife_temp_3.feature_is_enabled(rt.new_string('fulfillments'))
		if rt.is_true(iife_result_3) {
			this.do_update_options_action()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(''))) {
	} else {
		mut var_is_shipping_method := rt.new_bool(false)
		mut iter_3 := this.get_shipping_methods().iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_method := item_3.val
			mut var_method_id := item_3.key
			if rt.is_true(rt.call_function('in_array', [var_current_section.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(var_method, 'id') },
					rt.ArrayItem{ key: none, val: rt.call_function('sanitize_title', [
						rt.call_function('get_class', [var_method.clone()]),
					]) },
				]),
				rt.new_bool(true)]))
			{
				var_is_shipping_method = rt.new_bool(true)
				this.do_update_options_action(rt.get_property(var_method, 'id'))
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_shipping_method)))) {
			this.save_settings_for_current_section()
		}
	}
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.get_transient_version(rt.new_string('shipping'),
		rt.new_bool(true))
}

fn (mut this Class_WC_Settings_Shipping) output_zones_screen() {
	mut var_hide_save_button := rt.get_superglobal('hide_save_button')
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('zone_id')) {
		var_hide_save_button = rt.new_bool(true)
		this.zone_methods_screen(rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('zone_id'))]),
		]))
	} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('instance_id')) {
		this.instance_settings_screen(rt.call_function('absint', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('instance_id'))]),
		]))
	} else {
		var_hide_save_button = rt.new_bool(true)
		this.zones_screen()
	}
}

fn (mut this Class_WC_Settings_Shipping) get_region_options(var_allowed_countries rt.PhpVal, var_shipping_continents rt.PhpVal) rt.PhpVal {
	mut var_allowed_countries_mutated := var_allowed_countries
	mut var_shipping_continents_mutated := var_shipping_continents
	mut var_options := []rt.PhpVal{}
	mut iter_4 := var_shipping_continents_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_continent := item_4.val
		mut var_continent_code := item_4.key
		mut var_continent_data := {
			'value':    'continent:' +
				(rt.call_function('esc_attr', [var_continent_code.clone()])).str()
			'label':    rt.call_function('esc_html', [
				var_continent.array_get(rt.new_string('name')),
			])
			'children': []rt.PhpVal{}
		}
		mut var_countries := rt.call_function('array_intersect', [
			rt.func_array_keys(var_allowed_countries_mutated.clone()),
			var_continent.array_get(rt.new_string('countries')),
		])
		mut iter_5 := var_countries.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_country_code := item_5.val
			mut var_country_data := {
				'value':    'country:' +
					(rt.call_function('esc_attr', [var_country_code.clone()])).str()
				'label':    rt.call_function('esc_html',
					[var_allowed_countries_mutated.array_get(var_country_code)])
				'children': []rt.PhpVal{}
			}
			mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'countries'), 'get_states', [var_country_code.clone()])
			if rt.is_true(var_states) {
				mut iter_6 := var_states.iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_state_name := item_6.val
					mut var_state_code := item_6.key
					var_country_data.array_get_mut('children').array_push(rt.create_array([
						rt.ArrayItem{ key: 'value', val: 'state:' +
							(rt.call_function('esc_attr', [rt.new_string(var_country_code.str() +
							':' + var_state_code.str())])).str() },
						rt.ArrayItem{ key: 'label', val: rt.call_function('esc_html', [
							rt.new_string(var_state_name.str() + ', ' +
								(var_allowed_countries_mutated.array_get(var_country_code)).str()),
						]) },
					]))
				}
			}
			var_continent_data.array_get_mut('children').array_push(var_country_data.clone())
		}
		var_options << var_continent_data.clone()
	}
	return var_options.clone()
}

fn (mut this Class_WC_Settings_Shipping) zone_methods_screen(var_zone_id rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('new'), var_zone_id)) {
		mut var_zone := create_wc_shipping_zone()
	} else {
		mut iife_temp_5 := Class_WC_Shipping_Zones{}
		mut iife_result_5 := iife_temp_5.get_zone(rt.call_function('absint', [
			var_zone_id.clone()]))
		var_zone = iife_result_5
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_zone)))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [rt.new_string('Zone does not exist!'),
				rt.new_string('woocommerce')]),
		])
	}
	mut var_allowed_countries := rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{})
	mut var_shipping_continents := rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'countries'), 'get_shipping_continents', []rt.PhpVal{})
	mut var_locations := []rt.PhpVal{}
	mut var_postcodes := []rt.PhpVal{}
	mut iter_7 := rt.call_method(var_zone, 'get_zone_locations', []rt.PhpVal{}).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_location := item_7.val
		if rt.is_true(rt.identical(rt.new_string('postcode'), rt.get_property(var_location, 'type'))) {
			var_postcodes << rt.get_property(var_location, 'code')
		} else {
			var_locations << (rt.get_property(var_location, 'type')).str() + ':' +
				(rt.get_property(var_location, 'code')).str()
		}
	}
	mut var_localized_object := {
		'methods':                 rt.call_method(var_zone, 'get_shipping_methods', [
			rt.new_bool(false),
			rt.new_string('json'),
		])
		'zone_name':               rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{})
		'zone_id':                 rt.call_method(var_zone, 'get_id', []rt.PhpVal{})
		'locations':               var_locations
		'wc_shipping_zones_nonce': rt.call_function('wp_create_nonce', [
			rt.new_string('wc_shipping_zones_nonce'),
		])
		'strings':                 {
			'unload_confirmation_msg':             rt.call_function('__', [
				rt.new_string('Your changed data will be lost if you leave this page without saving.'),
				rt.new_string('woocommerce'),
			])
			'save_changes_prompt':                 rt.call_function('__', [
				rt.new_string('Do you wish to save your changes first? Your changed data will be discarded if you choose to cancel.'),
				rt.new_string('woocommerce'),
			])
			'save_failed':                         rt.call_function('__', [
				rt.new_string('Your changes were not saved. Please retry.'),
				rt.new_string('woocommerce'),
			])
			'add_method_failed':                   rt.call_function('__', [
				rt.new_string('Shipping method could not be added. Please retry.'),
				rt.new_string('woocommerce'),
			])
			'remove_method_failed':                rt.call_function('__', [
				rt.new_string('Shipping method could not be removed. Please retry.'),
				rt.new_string('woocommerce'),
			])
			'yes':                                 rt.call_function('__', [
				rt.new_string('Yes'),
				rt.new_string('woocommerce'),
			])
			'no':                                  rt.call_function('__', [
				rt.new_string('No'),
				rt.new_string('woocommerce'),
			])
			'default_zone_name':                   rt.call_function('__', [
				rt.new_string('Zone'),
				rt.new_string('woocommerce'),
			])
			'delete_shipping_method_confirmation': rt.call_function('__', [
				rt.new_string('Are you sure you want to delete this shipping method?'),
				rt.new_string('woocommerce'),
			])
			'invalid_number_format':               rt.call_function('__', [
				rt.new_string('Please enter a valid number.'),
				rt.new_string('woocommerce'),
			])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_zone,
		'get_id', []rt.PhpVal{})))))
	{
		mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
		mut iife_result_6 := iife_temp_6.register_script(rt.new_string('wp-admin-scripts'),
			rt.new_string('shipping-settings-region-picker'), rt.new_bool(true), rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-shipping-zone-methods' },
		]))
		var_localized_object['region_options'] = this.get_region_options(var_allowed_countries.clone(),
			var_shipping_continents.clone())
	}
	rt.call_function('wp_localize_script', [rt.new_string('wc-shipping-zone-methods'),
		rt.new_string('shippingZoneMethodsLocalizeScript'),
		rt.create_array_from_native_map(var_localized_object)])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-shipping-zone-methods')])
	rt.include_file(@DIR + '/views/html-admin-page-shipping-zone-methods.php', '2')
}

fn (mut this Class_WC_Settings_Shipping) zones_screen() {
	mut var_method_count := rt.call_function('wc_get_shipping_method_count', [
		rt.new_bool(false),
		rt.new_bool(true),
	])
	mut iife_temp_7 := Class_WC_Shipping_Zones{}
	mut iife_result_7 := iife_temp_7.get_zones(rt.new_string('json'))
	rt.call_function('wp_localize_script', [rt.new_string('wc-shipping-zones'),
		rt.new_string('shippingZonesLocalizeScript'),
		rt.create_array([
			rt.ArrayItem{ key: 'zones', val: iife_result_7 },
			rt.ArrayItem{ key: 'default_zone', val: rt.create_array([
				rt.ArrayItem{ key: 'zone_id', val: 0 },
				rt.ArrayItem{ key: 'zone_name', val: '' },
				rt.ArrayItem{ key: 'zone_order', val: rt.new_null() },
			]) },
			rt.ArrayItem{ key: 'wc_shipping_zones_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc_shipping_zones_nonce'),
			]) },
			rt.ArrayItem{ key: 'strings', val: rt.create_array([
				rt.ArrayItem{ key: 'unload_confirmation_msg', val: rt.call_function('__', [
					rt.new_string('Your changed data will be lost if you leave this page without saving.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'delete_confirmation_msg', val: rt.call_function('__', [
					rt.new_string('Are you sure you want to delete this zone? This action cannot be undone.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'save_failed', val: rt.call_function('__', [
					rt.new_string('Your changes were not saved. Please retry.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'no_shipping_methods_offered', val: rt.call_function('__', [
					rt.new_string('No shipping methods offered to this zone.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		])])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-shipping-zones')])
	rt.include_file(@DIR + '/views/html-admin-page-shipping-zones.php', '2')
}

fn (mut this Class_WC_Settings_Shipping) instance_settings_screen(var_instance_id rt.PhpVal) {
	mut iife_temp_8 := Class_WC_Shipping_Zones{}
	mut iife_result_8 := iife_temp_8.get_zone_by(rt.new_string('instance_id'),
		var_instance_id.clone())
	mut var_zone := iife_result_8
	mut iife_temp_9 := Class_WC_Shipping_Zones{}
	mut iife_result_9 := iife_temp_9.get_shipping_method(var_instance_id.clone())
	mut var_shipping_method := iife_result_9
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shipping_method)))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [rt.new_string('Invalid shipping method!'),
				rt.new_string('woocommerce')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_zone)))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [rt.new_string('Zone does not exist!'),
				rt.new_string('woocommerce')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_shipping_method, 'has_settings',
		[]rt.PhpVal{})))))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('This shipping method does not have any settings to configure.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('save')))) {
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))]), rt.new_string('woocommerce-settings')]))))) {
			print('<div class="updated error"><p>' +
				(rt.call_function('esc_html__', [rt.new_string('Edit failed. Please try again.'), rt.new_string('woocommerce')])).str() +
				'</p></div>')
		}
		rt.call_method(var_shipping_method, 'process_admin_options', []rt.PhpVal{})
		rt.call_method(var_shipping_method, 'display_errors', []rt.PhpVal{})
	}
	rt.include_file(@DIR + '/views/html-admin-page-shipping-zones-instance.php', '2')
}

fn (mut this Class_WC_Settings_Shipping) output_shipping_class_screen() {
	mut iife_temp_10 := Class_WC_Shipping{}
	mut iife_result_10 := iife_temp_10.instance()
	mut var_wc_shipping := iife_result_10
	rt.call_function('wp_localize_script', [rt.new_string('wc-shipping-classes'),
		rt.new_string('shippingClassesLocalizeScript'),
		rt.create_array([
			rt.ArrayItem{ key: 'classes', val: rt.call_method(var_wc_shipping,
				'get_shipping_classes', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'default_shipping_class', val: rt.create_array([
				rt.ArrayItem{ key: 'term_id', val: 0 },
				rt.ArrayItem{ key: 'name', val: '' },
				rt.ArrayItem{ key: 'description', val: '' },
			]) },
			rt.ArrayItem{ key: 'wc_shipping_classes_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc_shipping_classes_nonce'),
			]) },
			rt.ArrayItem{ key: 'strings', val: rt.create_array([
				rt.ArrayItem{ key: 'unload_confirmation_msg', val: rt.call_function('__', [
					rt.new_string('Your changed data will be lost if you leave this page without saving.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'save_failed', val: rt.call_function('__', [
					rt.new_string('Your changes were not saved. Please retry.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		])])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-shipping-classes')])
	mut var_shipping_class_columns := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_classes_columns'),
		rt.create_array([
			rt.ArrayItem{ key: 'wc-shipping-class-name', val: rt.call_function('__', [
				rt.new_string('Shipping class'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'wc-shipping-class-slug', val: rt.call_function('__', [
				rt.new_string('Slug'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'wc-shipping-class-description', val: rt.call_function('__', [
				rt.new_string('Description'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'wc-shipping-class-count', val: rt.call_function('__', [
				rt.new_string('Product count'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	rt.include_file(@DIR + '/views/html-admin-page-shipping-classes.php', '2')
}

fn (mut this Class_WC_Settings_Shipping) output_shipping_providers_screen() {
	mut var_providers := rt.call_function('get_terms', [
		rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'wc_fulfillment_shipping_provider' },
			rt.ArrayItem{ key: 'hide_empty', val: false },
		]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_providers.clone()])) {
		var_providers = []rt.PhpVal{}
	}
	mut var_shipping_providers := []rt.PhpVal{}
	mut iter_8 := var_providers.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_provider := item_8.val
		var_shipping_providers << rt.create_array([
			rt.ArrayItem{ key: 'term_id', val: rt.get_property(var_provider, 'term_id') },
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_provider, 'name') },
			rt.ArrayItem{ key: 'slug', val: rt.get_property(var_provider, 'slug') },
			rt.ArrayItem{ key: 'tracking_url_template', val: rt.call_function('get_term_meta', [
				rt.get_property(var_provider, 'term_id'),
				rt.new_string('tracking_url_template'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.call_function('get_term_meta', [
				rt.get_property(var_provider, 'term_id'),
				rt.new_string('icon'),
				rt.new_bool(true),
			]) },
		])
	}
	rt.call_function('wp_localize_script', [rt.new_string('wc-shipping-providers'),
		rt.new_string('shippingProvidersLocalizeScript'),
		rt.create_array([
			rt.ArrayItem{ key: 'providers', val: var_shipping_providers },
			rt.ArrayItem{ key: 'default_shipping_provider', val: rt.create_array([
				rt.ArrayItem{ key: 'term_id', val: 0 },
				rt.ArrayItem{ key: 'name', val: '' },
				rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'tracking_url_template', val: '' },
				rt.ArrayItem{ key: 'icon', val: '' },
			]) },
			rt.ArrayItem{ key: 'wc_shipping_providers_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc_shipping_providers_nonce'),
			]) },
			rt.ArrayItem{ key: 'strings', val: rt.create_array([
				rt.ArrayItem{ key: 'unload_confirmation_msg', val: rt.call_function('__', [
					rt.new_string('Your changed data will be lost if you leave this page without saving.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'save_failed', val: rt.call_function('__', [
					rt.new_string('Your changes were not saved. Please retry.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'delete_confirmation', val: rt.call_function('__', [
					rt.new_string('Are you sure you want to delete this shipping provider?'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		])])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-shipping-providers')])
	mut var_shipping_provider_columns := {
		'wc-shipping-provider-name':                  rt.call_function('__', [
			rt.new_string('Name'),
			rt.new_string('woocommerce'),
		])
		'wc-shipping-provider-slug':                  rt.call_function('__', [
			rt.new_string('Slug'),
			rt.new_string('woocommerce'),
		])
		'wc-shipping-provider-tracking-url-template': rt.call_function('__', [
			rt.new_string('Tracking URL template'),
			rt.new_string('woocommerce'),
		])
		'wc-shipping-provider-icon':                  rt.call_function('__', [
			rt.new_string('Icon URL'),
			rt.new_string('woocommerce'),
		])
	}
	rt.include_file(@DIR + '/views/html-admin-page-shipping-providers.php', '2')
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_WC_Shipping {
	rt.PhpObjectBase
}

fn create_wc_settings_shipping() &Class_WC_Settings_Shipping {
	mut obj := &Class_WC_Settings_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
		icon:          rt.new_string('shipping')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page(_args ...rt.PhpVal) &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
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

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zone(_args ...rt.PhpVal) &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zones(_args ...rt.PhpVal) &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
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

fn create_wc_shipping(_args ...rt.PhpVal) &Class_WC_Shipping {
	mut obj := &Class_WC_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_settings_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings_page(dispatch_arg_0)
		}
		'get_own_sections' {
			return this.get_own_sections()
		}
		'wc_is_installing' {
			return this.wc_is_installing()
		}
		'get_shipping_methods' {
			return this.get_shipping_methods()
		}
		'get_settings_for_options_section' {
			return this.get_settings_for_options_section()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		'output_zones_screen' {
			this.output_zones_screen()
			return rt.new_null()
		}
		'get_region_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_region_options(dispatch_arg_0, dispatch_arg_1)
		}
		'zone_methods_screen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.zone_methods_screen(dispatch_arg_0)
			return rt.new_null()
		}
		'zones_screen' {
			this.zones_screen()
			return rt.new_null()
		}
		'instance_settings_screen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.instance_settings_screen(dispatch_arg_0)
			return rt.new_null()
		}
		'output_shipping_class_screen' {
			this.output_shipping_class_screen()
			return rt.new_null()
		}
		'output_shipping_providers_screen' {
			this.output_shipping_providers_screen()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' {
			this.icon = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Settings_Shipping'),
		rt.new_bool(false),
	]))
	{
		return rt.new_object('WC_Settings_Shipping', ['WC_Settings_Page'],
			create_wc_settings_shipping())
	}
	return rt.new_object('WC_Settings_Shipping', ['WC_Settings_Page'],
		create_wc_settings_shipping())
}
