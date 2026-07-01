import rt

struct Class_WC_Settings_Tax {
	rt.PhpObjectBase
pub mut:
		icon rt.PhpVal = rt.new_string('percent')
}

fn (mut this Class_WC_Settings_Tax) construct()  {
	this.dispatch_set_prop('id', rt.new_string('tax'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Tax'), rt.new_string('woocommerce')]))
	rt.call_function('add_filter', [rt.new_string('woocommerce_settings_tabs_array'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'add_settings_page' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_field_conflict_error'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'conflict_error' }])])
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		rt.call_function('add_action', ['woocommerce_sections_' + rt.get_property(rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this), 'id'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'output_sections' }])])
		rt.call_function('add_action', ['woocommerce_settings_' + rt.get_property(rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this), 'id'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'output' }])])
		rt.call_function('add_action', ['woocommerce_settings_save_' + rt.get_property(rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this), 'id'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'save' }])])
		rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tax', ['WC_Settings_Page'], &this) }, rt.ArrayItem{ key: none, val: 'tax_configuration_validation_notice' }])])
	}
}

fn (mut this Class_WC_Settings_Tax) conflict_error()  {
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Settings_Tax) add_settings_page(var_pages rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		return this.Class_WC_Settings_Page.add_settings_page(var_pages.dup())
	} else {
		return var_pages.dup()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Settings_Tax) get_own_sections() rt.PhpVal {
	mut var_sections := rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('Tax options'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'standard', val: rt.call_function('__', [rt.new_string('Standard rates'), rt.new_string('woocommerce')]) }])
	mut var_tax_classes := fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_classes() }()
	{
		mut iter_1 := var_tax_classes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_class := item_1.val
			var_sections.array_set(rt.call_function('sanitize_title', [var_class.dup()]), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s rates'), rt.new_string('woocommerce')]), var_class.dup()]))
		}
	}
	return var_sections.dup()
}

fn (mut this Class_WC_Settings_Tax) get_settings_for_default_section() rt.PhpVal {
	return rt.include_file(@DIR + '/views/settings-tax.php', '1')
}

fn (mut this Class_WC_Settings_Tax) output()  {
	mut var_current_section := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_tax_classes := fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_class_slugs() }()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('standard'), var_current_section)) || rt.is_true(rt.call_function('in_array', [var_current_section.dup(), rt.call_function('array_filter', [var_tax_classes.dup()]), rt.new_bool(true)])))) {
		this.output_tax_rates()
	} else {
		this.Class_WC_Settings_Page.output()
	}
}

fn (mut this Class_WC_Settings_Tax) save()  {
	mut var_current_section := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_section)))) {
		this.save_settings_for_current_section()
		if rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_tax_classes')) {
			this.save_tax_classes(rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('woocommerce_tax_classes')]))
			// unsupported statement: Stmt_Nop
		}
	} else if !(!rt.is_true(rt.get_superglobal('_POST').array_get('tax_rate_country'))) {
		this.save_tax_rates()
	} else {
		this.save_settings_for_current_section()
	}
	this.do_update_options_action()
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.invalidate_cache_group(arg_0) }(rt.new_string('taxes'))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('shipping'), rt.new_bool(true))
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Settings_Tax) save_tax_classes(var_raw_tax_classes rt.PhpVal) rt.PhpVal {
	mut var_tax_classes := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('\n'), var_raw_tax_classes.dup()])])])
	mut var_existing_tax_classes := fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_classes() }()
	mut var_removed := rt.call_function('array_diff', [var_existing_tax_classes.dup(), var_tax_classes.dup()])
	mut var_added := rt.call_function('array_diff', [var_tax_classes.dup(), var_existing_tax_classes.dup()])
	{
		mut iter_1 := var_removed.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name := item_1.val
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.delete_tax_class_by(arg_0, arg_1) }(rt.new_string('name'), var_name.dup())
		}
	}
	{
		mut iter_1 := var_added.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name := item_1.val
			mut var_tax_class := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.create_tax_class(arg_0) }(var_name.dup())
			if rt.is_true(rt.call_function('is_wp_error', [var_tax_class.dup()])) {
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.add_error(arg_0) }(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Additional tax class "%1$s" couldn\'t be saved. %2$s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_name.dup()]), rt.call_method(var_tax_class, 'get_error_message', []rt.PhpVal{})]))
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_WC_Settings_Tax) output_tax_rates()  {
	mut var_current_section := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_current_class := Class_WC_Settings_Tax.get_current_tax_class()
	mut var_countries := []rt.PhpVal{}
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_value := item_1.key
			var_countries << rt.create_array([rt.ArrayItem{ key: 'value', val: var_value }, rt.ArrayItem{ key: 'label', val: rt.call_function('esc_js', [rt.call_function('html_entity_decode', [var_label.dup()])]) }])
		}
	}
	mut var_states := []rt.PhpVal{}
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_country_states', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			{
				mut iter_2 := var_label.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_state := item_2.val
					mut var_code := item_2.key
					var_states << rt.create_array([rt.ArrayItem{ key: 'value', val: var_code }, rt.ArrayItem{ key: 'label', val: rt.call_function('esc_js', [rt.call_function('html_entity_decode', [var_state.dup()])]) }])
				}
			}
		}
	}
	mut var_base_url := rt.call_function('admin_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-settings' }, rt.ArrayItem{ key: 'tab', val: 'tax' }, rt.ArrayItem{ key: 'section', val: var_current_section }]), rt.new_string('admin.php')])])
	rt.call_function('wp_localize_script', [rt.new_string('wc-settings-tax'), rt.new_string('htmlSettingsTaxLocalizeScript'), rt.create_array([rt.ArrayItem{ key: 'current_class', val: var_current_class }, rt.ArrayItem{ key: 'wc_tax_nonce', val: rt.call_function('wp_create_nonce', ['wc_tax_nonce-class:' + (var_current_class).str()]) }, rt.ArrayItem{ key: 'base_url', val: var_base_url }, rt.ArrayItem{ key: 'rates', val: rt.call_function('array_values', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_rates_for_tax_class(arg_0) }(var_current_class.dup())]) }, rt.ArrayItem{ key: 'page', val: if !(!rt.is_true(rt.get_superglobal('_GET').array_get('p'))) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get('p')]) } else { rt.new_int(1) } }, rt.ArrayItem{ key: 'limit', val: 100 }, rt.ArrayItem{ key: 'countries', val: var_countries }, rt.ArrayItem{ key: 'states', val: var_states }, rt.ArrayItem{ key: 'default_rate', val: rt.create_array([rt.ArrayItem{ key: 'tax_rate_id', val: 0 }, rt.ArrayItem{ key: 'tax_rate_country', val: '' }, rt.ArrayItem{ key: 'tax_rate_state', val: '' }, rt.ArrayItem{ key: 'tax_rate', val: '' }, rt.ArrayItem{ key: 'tax_rate_name', val: '' }, rt.ArrayItem{ key: 'tax_rate_priority', val: 1 }, rt.ArrayItem{ key: 'tax_rate_compound', val: 0 }, rt.ArrayItem{ key: 'tax_rate_shipping', val: 1 }, rt.ArrayItem{ key: 'tax_rate_order', val: rt.new_null() }, rt.ArrayItem{ key: 'tax_rate_class', val: var_current_class }]) }, rt.ArrayItem{ key: 'strings', val: rt.create_array([rt.ArrayItem{ key: 'no_rows_selected', val: rt.call_function('__', [rt.new_string('No row(s) selected'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'unload_confirmation_msg', val: rt.call_function('__', [rt.new_string('Your changed data will be lost if you leave this page without saving.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'csv_data_cols', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Country code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('State code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Postcode / ZIP'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Rate %'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Tax name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Priority'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Compound'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Shipping'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Tax class'), rt.new_string('woocommerce')]) }]) }]) }])])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-settings-tax')])
	rt.include_file(@DIR + '/views/html-settings-tax.php', '1')
}

fn Class_WC_Settings_Tax.get_current_tax_class() rt.PhpVal {
	mut var_current_section := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_tax_classes := fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_classes() }()
	mut var_current_class := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_tax_classes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_class := item_1.val
			if rt.is_true(rt.identical(rt.call_function('sanitize_title', [var_class.dup()]), var_current_section)) {
				var_current_class = var_class
			}
		}
	}
	return var_current_class.dup()
}

fn (mut this Class_WC_Settings_Tax) get_posted_tax_rate(var_key rt.PhpVal, var_order rt.PhpVal, var_class rt.PhpVal) rt.PhpVal {
	mut var_tax_rate := []rt.PhpVal{}
	mut var_tax_rate_keys := ['tax_rate_country', 'tax_rate_state', 'tax_rate', 'tax_rate_name', 'tax_rate_priority']
	for var_tax_rate_key in var_tax_rate_keys {
		if rt.get_superglobal('_POST').array_isset(rt.new_string(tax_rate_key)) && rt.get_superglobal('_POST').array_get(tax_rate_key).array_isset(var_key) {
			var_tax_rate.array_set(tax_rate_key, rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(tax_rate_key).array_get(var_key)])]))
		}
	}
	var_tax_rate.array_set('tax_rate_compound', if rt.get_superglobal('_POST').array_get('tax_rate_compound').array_isset(var_key) { 1 } else { 0 })
	var_tax_rate.array_set('tax_rate_shipping', if rt.get_superglobal('_POST').array_get('tax_rate_shipping').array_isset(var_key) { 1 } else { 0 })
	var_tax_rate.array_set('tax_rate_order', var_order.dup())
	var_tax_rate.array_set('tax_rate_class', var_class.dup())
	return var_tax_rate.dup()
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Settings_Tax) save_tax_rates()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_current_class := rt.call_function('sanitize_title', [Class_WC_Settings_Tax.get_current_tax_class()])
	mut var_posted_countries := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('tax_rate_country')])])
	mut var_first_tax_rate_id := rt.call_function('key', [var_posted_countries.dup()])
	mut var_tax_rate_order := rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT tax_rate_order FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %s')), var_first_tax_rate_id.dup()])])])
	mut var_index := if !(var_tax_rate_order).is_null() { var_tax_rate_order } else { rt.new_int(0) }
	{
		mut iter_1 := var_posted_countries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_mode := rt.new_string(if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_key.dup(), rt.new_string('new-')]))) { rt.new_string('insert') } else { rt.new_string('update') })
			mut var_tax_rate := this.get_posted_tax_rate(var_key.dup(), rt.post_inc(var_index), var_current_class.dup())
			if rt.is_true(rt.identical(rt.new_string('insert'), var_mode)) {
				mut var_tax_rate_id := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._insert_tax_rate(arg_0) }(var_tax_rate.dup())
			} else if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('remove_tax_rate').array_isset(var_key) && rt.is_true(rt.identical(rt.new_int(1), rt.call_function('absint', [rt.get_superglobal('_POST').array_get('remove_tax_rate').array_get(var_key)]))))) {
				var_tax_rate_id = rt.call_function('absint', [var_key.dup()])
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._delete_tax_rate(arg_0) }(var_tax_rate_id.dup())
				continue
			} else {
				var_tax_rate_id = rt.call_function('absint', [var_key.dup()])
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._update_tax_rate(arg_0, arg_1) }(var_tax_rate_id.dup(), var_tax_rate.dup())
			}
			if rt.get_superglobal('_POST').array_get('tax_rate_postcode').array_isset(var_key) {
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._update_tax_rate_postcodes(arg_0, arg_1) }(var_tax_rate_id.dup(), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('tax_rate_postcode').array_get(var_key)])]))
			}
			if rt.get_superglobal('_POST').array_get('tax_rate_city').array_isset(var_key) {
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._update_tax_rate_cities(arg_0, arg_1) }(var_tax_rate_id.dup(), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('tax_rate_city').array_get(var_key)])]))
			}
		}
	}
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Settings_Tax) tax_configuration_validation_notice()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_screen)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_adjust_non_base_location_prices'), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	if !rt.is_true(var_base_location.array_get('country')) {
		return rt.new_null()
	}
	mut var_has_base_rate := 
	if rt.is_true() {
	}
}

fn (mut this Class_WC_Settings_Tax) has_standard_tax_rate_for_country(var_country rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_wc_settings_tax() &Class_WC_Settings_Tax {
	mut obj := &Class_WC_Settings_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
		icon: rt.new_string('percent')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page() &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings() &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'conflict_error' {
			this.conflict_error()
			return rt.new_null()
		}
		'add_settings_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings_page(dispatch_arg_0)
		}
		'get_own_sections' {
			return this.get_own_sections()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		'save_tax_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save_tax_classes(dispatch_arg_0)
		}
		'output_tax_rates' {
			this.output_tax_rates()
			return rt.new_null()
		}
		'get_current_tax_class' {
			return Class_WC_Settings_Tax.get_current_tax_class()
		}
		'get_posted_tax_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_posted_tax_rate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'save_tax_rates' {
			this.save_tax_rates()
			return rt.new_null()
		}
		'tax_configuration_validation_notice' {
			this.tax_configuration_validation_notice()
			return rt.new_null()
		}
		'has_standard_tax_rate_for_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.has_standard_tax_rate_for_country(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Settings_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' { this.icon = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_class_wc_settings_tax_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Settings_Tax'), rt.new_bool(false)])) {
		return create_wc_settings_tax()
	}
}
