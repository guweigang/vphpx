import rt

struct Class_WC_Countries {
	rt.PhpObjectBase
pub mut:
		locale rt.PhpVal = rt.new_array()
		address_formats rt.PhpVal = rt.new_array()
		geo_cache rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Countries) magic_get(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('countries'), var_key)) {
		return this.get_countries()
	} else if rt.is_true(rt.identical(rt.new_string('states'), var_key)) {
		return this.get_states(rt.new_null())
	} else if rt.is_true(rt.identical(rt.new_string('continents'), var_key)) {
		return this.get_continents()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Countries) get_countries() rt.PhpVal {
	if !rt.is_true(this.geo_cache.array_get('countries')) {
		this.geo_cache.array_set('countries', rt.call_function('apply_filters', [rt.new_string('woocommerce_countries'), rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/countries.php', '1')]))
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_sort_countries'), rt.new_bool(true)])) {
			rt.call_function('wc_asort_by_locale', [this.geo_cache.array_get('countries')])
		}
	}
	return this.geo_cache.array_get('countries')
}

fn (mut this Class_WC_Countries) country_exists(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	return rt.new_bool(this.get_countries().array_isset(var_country_code_mutated))
}

fn (mut this Class_WC_Countries) get_country_from_alpha_3_code(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	if rt.is_true(rt.new_bool(!rt.is_true(var_country_code_mutated) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_country_code_mutated.dup().is_string()))))))) {
		return rt.new_null()
	}
	mut var_data := rt.call_method(create_automattic_woocommerce_vendor_league_iso3166_iso3166(), 'alpha3', [var_country_code_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_data.array_isset(rt.new_string('alpha2'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Alpha-2 country code not found for alpha-3 code.'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_data.array_get('alpha2')
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_Countries) get_continents() rt.PhpVal {
	if !rt.is_true(this.geo_cache.array_get('continents')) {
		this.geo_cache.array_set('continents', rt.call_function('apply_filters', [rt.new_string('woocommerce_continents'), rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/continents.php', '1')]))
	}
	return this.geo_cache.array_get('continents')
}

fn (mut this Class_WC_Countries) get_continent_code_for_country(var_cc rt.PhpVal) string {
	mut var_cc_mutated := var_cc
	var_cc_mutated = rt.new_string(rt.new_string(var_cc_mutated.dup().to_string().to_upper().trim_space()))
	mut var_continents := this.get_continents()
	mut var_continents_and_ccs := rt.call_function('wp_list_pluck', [var_continents.dup(), rt.new_string('countries')])
	{
		mut iter_1 := var_continents_and_ccs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_countries := item_1.val
			mut var_continent_code := item_1.key
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return (var_continent_code).str()
			}
		}
	}
	return ''
}

fn (mut this Class_WC_Countries) get_country_calling_code(var_cc rt.PhpVal) rt.PhpVal {
	mut var_cc_mutated := var_cc
	mut var_codes := rt.call_function('wp_cache_get', [rt.new_string('calling-codes'), rt.new_string('countries')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_codes)))) {
		var_codes = rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/phone.php', '1')
		rt.call_function('wp_cache_set', [rt.new_string('calling-codes'), var_codes.dup(), rt.new_string('countries')])
	}
	mut var_calling_code := if var_codes.array_isset(var_cc_mutated) { var_codes.array_get(var_cc_mutated) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(var_calling_code.dup().is_array())) {
		var_calling_code = var_calling_code.array_get(0)
	}
	return var_calling_code.dup()
}

fn (mut this Class_WC_Countries) get_shipping_continents() rt.PhpVal {
	mut var_continents := this.get_continents()
	mut var_shipping_countries := this.get_shipping_countries()
	mut var_shipping_country_codes := rt.func_array_keys(var_shipping_countries.dup())
	mut var_shipping_continents := rt.new_array()
	{
		mut iter_1 := var_continents.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_continent := item_1.val
			mut var_continent_code := item_1.key
			if rt.is_true(rt.new_int(rt.call_function('array_intersect', [var_continent.array_get('countries'), var_shipping_country_codes.dup()]).array_count())) {
				var_shipping_continents.array_set(var_continent_code, var_continent.dup())
			}
		}
	}
	return var_shipping_continents.dup()
}

fn (mut this Class_WC_Countries) load_country_states()  {
	// unsupported statement: Stmt_Global
	mut var_states := rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/states.php', '1')
	this.geo_cache.array_set('states', rt.call_function('apply_filters', [rt.new_string('woocommerce_states'), var_states.dup()]))
}

fn (mut this Class_WC_Countries) get_states(var_cc rt.PhpVal) rt.PhpVal {
	mut var_cc_mutated := var_cc
	if !(this.geo_cache.array_isset(rt.new_string('states'))) {
		this.geo_cache.array_set('states', rt.call_function('apply_filters', [rt.new_string('woocommerce_states'), rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/states.php', '1')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cc_mutated.dup().is_null()))))) {
		return if this.geo_cache.array_get('states').array_isset(var_cc_mutated) { this.geo_cache.array_get('states').array_get(var_cc_mutated) } else { rt.new_bool(false) }
	} else {
		return this.geo_cache.array_get('states')
	}
	return rt.new_null()
}

fn (mut this Class_WC_Countries) get_base_address() rt.PhpVal {
	mut var_base_address := rt.call_function('get_option', [rt.new_string('woocommerce_store_address'), rt.new_string('')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_base_address'), var_base_address.dup()])
}

fn (mut this Class_WC_Countries) get_base_address_2() rt.PhpVal {
	mut var_base_address_2 := rt.call_function('get_option', [rt.new_string('woocommerce_store_address_2'), rt.new_string('')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_base_address_2'), var_base_address_2.dup()])
}

fn (mut this Class_WC_Countries) get_base_country() rt.PhpVal {
	mut var_default := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_base_country'), var_default.array_get('country')])
}

fn (mut this Class_WC_Countries) get_base_state() rt.PhpVal {
	mut var_default := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_base_state'), var_default.array_get('state')])
}

fn (mut this Class_WC_Countries) get_base_city() rt.PhpVal {
	mut var_base_city := rt.call_function('get_option', [rt.new_string('woocommerce_store_city'), rt.new_string('')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_base_city'), var_base_city.dup()])
}

fn (mut this Class_WC_Countries) get_base_postcode() rt.PhpVal {
	mut var_base_postcode := rt.call_function('get_option', [rt.new_string('woocommerce_store_postcode'), rt.new_string('')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_base_postcode'), var_base_postcode.dup()])
}

fn (mut this Class_WC_Countries) get_allowed_countries() rt.PhpVal {
	mut var_countries := rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'countries')
	mut var_allowed_countries := rt.call_function('get_option', [rt.new_string('woocommerce_allowed_countries')])
	if rt.is_true(rt.identical(rt.new_string('all_except'), var_allowed_countries)) {
		mut var_except_countries := rt.call_function('get_option', [rt.new_string('woocommerce_all_except_countries'), rt.new_array()])
		if rt.is_true(var_except_countries) {
			{
				mut iter_1 := var_except_countries.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_country := item_1.val
					var_countries.array_unset(var_country)
				}
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('specific'), var_allowed_countries)) {
		var_countries = rt.new_array()
		mut var_raw_countries := rt.call_function('get_option', [rt.new_string('woocommerce_specific_allowed_countries'), rt.new_array()])
		if rt.is_true(var_raw_countries) {
			{
				mut iter_1 := var_raw_countries.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_country := item_1.val
					var_countries.array_set(var_country, rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'countries').array_get(var_country))
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_allowed_countries'), var_countries.dup()])
}

fn (mut this Class_WC_Countries) get_shipping_countries() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('disabled'), rt.call_function('get_option', [rt.new_string('woocommerce_ship_to_countries')]))) {
		return rt.new_array()
	}
	mut var_countries := this.get_allowed_countries()
	if rt.is_true(rt.identical(rt.new_string('all'), rt.call_function('get_option', [rt.new_string('woocommerce_ship_to_countries')]))) {
		var_countries = rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'countries')
	} else if rt.is_true(rt.identical(rt.new_string('specific'), rt.call_function('get_option', [rt.new_string('woocommerce_ship_to_countries')]))) {
		var_countries = rt.new_array()
		mut var_raw_countries := rt.call_function('get_option', [rt.new_string('woocommerce_specific_ship_to_countries'), rt.new_array()])
		if rt.is_true(var_raw_countries) {
			{
				mut iter_1 := var_raw_countries.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_country := item_1.val
					var_countries.array_set(var_country, rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'countries').array_get(var_country))
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_shipping_countries'), var_countries.dup()])
}

fn (mut this Class_WC_Countries) get_allowed_country_states() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states')
	}
	mut var_states := rt.new_array()
	mut var_raw_countries := rt.call_function('get_option', [rt.new_string('woocommerce_specific_allowed_countries')])
	if rt.is_true(var_raw_countries) {
		{
			mut iter_1 := var_raw_countries.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_country := item_1.val
				if rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states').array_isset(var_country) {
					var_states.array_set(var_country, rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states').array_get(var_country))
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_allowed_country_states'), var_states.dup()])
}

fn (mut this Class_WC_Countries) get_shipping_country_states() rt.PhpVal {
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_ship_to_countries')]), rt.new_string(''))) {
		return this.get_allowed_country_states()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states')
	}
	mut var_states := rt.new_array()
	mut var_raw_countries := rt.call_function('get_option', [rt.new_string('woocommerce_specific_ship_to_countries')])
	if rt.is_true(var_raw_countries) {
		{
			mut iter_1 := var_raw_countries.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_country := item_1.val
				if !(!rt.is_true(rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states').array_get(var_country))) {
					var_states.array_set(var_country, rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states').array_get(var_country))
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_shipping_country_states'), var_states.dup()])
}

fn (mut this Class_WC_Countries) get_european_union_countries(type string) rt.PhpVal {
	mut var_countries := rt.create_array([rt.ArrayItem{ key: none, val: 'AT' }, rt.ArrayItem{ key: none, val: 'BE' }, rt.ArrayItem{ key: none, val: 'BG' }, rt.ArrayItem{ key: none, val: 'CY' }, rt.ArrayItem{ key: none, val: 'CZ' }, rt.ArrayItem{ key: none, val: 'DE' }, rt.ArrayItem{ key: none, val: 'DK' }, rt.ArrayItem{ key: none, val: 'EE' }, rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'FI' }, rt.ArrayItem{ key: none, val: 'FR' }, rt.ArrayItem{ key: none, val: 'GR' }, rt.ArrayItem{ key: none, val: 'HR' }, rt.ArrayItem{ key: none, val: 'HU' }, rt.ArrayItem{ key: none, val: 'IE' }, rt.ArrayItem{ key: none, val: 'IT' }, rt.ArrayItem{ key: none, val: 'LT' }, rt.ArrayItem{ key: none, val: 'LU' }, rt.ArrayItem{ key: none, val: 'LV' }, rt.ArrayItem{ key: none, val: 'MT' }, rt.ArrayItem{ key: none, val: 'NL' }, rt.ArrayItem{ key: none, val: 'PL' }, rt.ArrayItem{ key: none, val: 'PT' }, rt.ArrayItem{ key: none, val: 'RO' }, rt.ArrayItem{ key: none, val: 'SE' }, rt.ArrayItem{ key: none, val: 'SI' }, rt.ArrayItem{ key: none, val: 'SK' }])
	if rt.is_true(rt.identical(rt.new_string('eu_vat'), rt.new_string(type))) {
		var_countries.array_push('MC')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_european_union_countries'), var_countries.dup(), rt.new_string(type)])
}

fn (mut this Class_WC_Countries) countries_using_vat() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('countries_using_vat'), rt.new_string('4.0'), rt.new_string('WC_Countries::get_vat_countries')])
	mut var_countries := rt.create_array([rt.ArrayItem{ key: none, val: 'AE' }, rt.ArrayItem{ key: none, val: 'AL' }, rt.ArrayItem{ key: none, val: 'AR' }, rt.ArrayItem{ key: none, val: 'AZ' }, rt.ArrayItem{ key: none, val: 'BB' }, rt.ArrayItem{ key: none, val: 'BH' }, rt.ArrayItem{ key: none, val: 'BO' }, rt.ArrayItem{ key: none, val: 'BS' }, rt.ArrayItem{ key: none, val: 'BY' }, rt.ArrayItem{ key: none, val: 'CL' }, rt.ArrayItem{ key: none, val: 'CO' }, rt.ArrayItem{ key: none, val: 'EC' }, rt.ArrayItem{ key: none, val: 'EG' }, rt.ArrayItem{ key: none, val: 'ET' }, rt.ArrayItem{ key: none, val: 'FJ' }, rt.ArrayItem{ key: none, val: 'FO' }, rt.ArrayItem{ key: none, val: 'GH' }, rt.ArrayItem{ key: none, val: 'GM' }, rt.ArrayItem{ key: none, val: 'GT' }, rt.ArrayItem{ key: none, val: 'IL' }, rt.ArrayItem{ key: none, val: 'IR' }, rt.ArrayItem{ key: none, val: 'IS' }, rt.ArrayItem{ key: none, val: 'KN' }, rt.ArrayItem{ key: none, val: 'KR' }, rt.ArrayItem{ key: none, val: 'KZ' }, rt.ArrayItem{ key: none, val: 'LK' }, rt.ArrayItem{ key: none, val: 'MD' }, rt.ArrayItem{ key: none, val: 'ME' }, rt.ArrayItem{ key: none, val: 'MK' }, rt.ArrayItem{ key: none, val: 'MN' }, rt.ArrayItem{ key: none, val: 'MU' }, rt.ArrayItem{ key: none, val: 'MX' }, rt.ArrayItem{ key: none, val: 'NA' }, rt.ArrayItem{ key: none, val: 'NG' }, rt.ArrayItem{ key: none, val: 'NP' }, rt.ArrayItem{ key: none, val: 'PS' }, rt.ArrayItem{ key: none, val: 'PY' }, rt.ArrayItem{ key: none, val: 'RS' }, rt.ArrayItem{ key: none, val: 'RU' }, rt.ArrayItem{ key: none, val: 'RW' }, rt.ArrayItem{ key: none, val: 'SA' }, rt.ArrayItem{ key: none, val: 'SV' }, rt.ArrayItem{ key: none, val: 'TH' }, rt.ArrayItem{ key: none, val: 'TR' }, rt.ArrayItem{ key: none, val: 'UA' }, rt.ArrayItem{ key: none, val: 'UY' }, rt.ArrayItem{ key: none, val: 'UZ' }, rt.ArrayItem{ key: none, val: 'VE' }, rt.ArrayItem{ key: none, val: 'VN' }, rt.ArrayItem{ key: none, val: 'ZA' }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_countries_using_vat'), var_countries.dup()])
}

fn (mut this Class_WC_Countries) get_vat_countries() rt.PhpVal {
	mut var_eu_countries := this.get_european_union_countries('')
	mut var_vat_countries := ['AE', 'AL', 'AR', 'AZ', 'BB', 'BH', 'BO', 'BS', 'BY', 'CL', 'CO', 'EC', 'EG', 'ET', 'FJ', 'FO', 'GB', 'GH', 'GM', 'GT', 'IL', 'IM', 'IR', 'IS', 'KN', 'KR', 'KZ', 'LK', 'MC', 'MD', 'ME', 'MK', 'MN', 'MU', 'MX', 'NA', 'NG', 'NO', 'NP', 'PS', 'PY', 'RS', 'RU', 'RW', 'SA', 'SV', 'TH', 'TR', 'UA', 'UY', 'UZ', 'VE', 'VN', 'XK', 'ZA']
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_vat_countries'), rt.call_function('array_merge', [var_eu_countries.dup(), var_vat_countries.dup()])])
}

fn (mut this Class_WC_Countries) shipping_to_prefix(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = (if rt.is_true(rt.new_string(country_code_mutated)) { rt.new_string(country_code_mutated) } else { rt.call_method(rt.get_property(, 'customer'), 'get_shipping_country', []rt.PhpVal{}) }).str()
	mut var_countries := rt.create_array([rt.ArrayItem{ key: none, val: 'AE' }, rt.ArrayItem{ key: none, val: 'CZ' }, rt.ArrayItem{ key: none, val: 'DO' }, rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'NL' }, rt.ArrayItem{ key: none, val: 'PH' }, rt.ArrayItem{ key: none, val: 'US' }, rt.ArrayItem{ key: none, val: 'USAF' }])
	mut var_return := if rt.is_true() {  } else {  }
	return rt.call_function('apply_filters', [, .dup(), .dup()])
}

fn (mut this Class_WC_Countries) estimated_for_prefix(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	
}

fn (mut this Class_WC_Countries) tax_or_vat() rt.PhpVal {
}

fn (mut this Class_WC_Countries) inc_tax_or_vat() rt.PhpVal {
}

fn (mut this Class_WC_Countries) ex_tax_or_vat() rt.PhpVal {
}

fn (mut this Class_WC_Countries) country_dropdown_options(selected_country string, selected_state string, escape bool)  {
	mut selected_state_mutated := selected_state
}

fn (mut this Class_WC_Countries) get_address_formats() rt.PhpVal {
}

fn (mut this Class_WC_Countries) get_formatted_address(var_args rt.PhpVal, separator string) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Countries) trim_formatted_address_line(var_line rt.PhpVal) string {
}

fn (mut this Class_WC_Countries) get_default_address_fields() rt.PhpVal {
}

fn (mut this Class_WC_Countries) get_country_locale_field_selectors() rt.PhpVal {
}

fn (mut this Class_WC_Countries) get_country_locale() rt.PhpVal {
}

fn (mut this Class_WC_Countries) get_address_fields(country string, type string) rt.PhpVal {
	mut country_mutated := country
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166 {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_countries() &Class_WC_Countries {
	mut obj := &Class_WC_Countries{
		PhpObjectBase: rt.PhpObjectBase{}
		locale: rt.new_array()
		address_formats: rt.new_array()
		geo_cache: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_league_iso3166_iso3166() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166 {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Countries) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'get_countries' {
			return this.get_countries()
		}
		'country_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.country_exists(dispatch_arg_0)
		}
		'get_country_from_alpha_3_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_country_from_alpha_3_code(dispatch_arg_0)
		}
		'get_continents' {
			return this.get_continents()
		}
		'get_continent_code_for_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_continent_code_for_country(dispatch_arg_0))
		}
		'get_country_calling_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_country_calling_code(dispatch_arg_0)
		}
		'get_shipping_continents' {
			return this.get_shipping_continents()
		}
		'load_country_states' {
			this.load_country_states()
			return rt.new_null()
		}
		'get_states' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_states(dispatch_arg_0)
		}
		'get_base_address' {
			return this.get_base_address()
		}
		'get_base_address_2' {
			return this.get_base_address_2()
		}
		'get_base_country' {
			return this.get_base_country()
		}
		'get_base_state' {
			return this.get_base_state()
		}
		'get_base_city' {
			return this.get_base_city()
		}
		'get_base_postcode' {
			return this.get_base_postcode()
		}
		'get_allowed_countries' {
			return this.get_allowed_countries()
		}
		'get_shipping_countries' {
			return this.get_shipping_countries()
		}
		'get_allowed_country_states' {
			return this.get_allowed_country_states()
		}
		'get_shipping_country_states' {
			return this.get_shipping_country_states()
		}
		'get_european_union_countries' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_european_union_countries(dispatch_arg_0)
		}
		'countries_using_vat' {
			return this.countries_using_vat()
		}
		'get_vat_countries' {
			return this.get_vat_countries()
		}
		'shipping_to_prefix' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.shipping_to_prefix(dispatch_arg_0)
		}
		'estimated_for_prefix' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.estimated_for_prefix(dispatch_arg_0)
		}
		'tax_or_vat' {
			return this.tax_or_vat()
		}
		'inc_tax_or_vat' {
			return this.inc_tax_or_vat()
		}
		'ex_tax_or_vat' {
			return this.ex_tax_or_vat()
		}
		'country_dropdown_options' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.country_dropdown_options(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_address_formats' {
			return this.get_address_formats()
		}
		'get_formatted_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_formatted_address(dispatch_arg_0, dispatch_arg_1)
		}
		'trim_formatted_address_line' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.trim_formatted_address_line(dispatch_arg_0))
		}
		'get_default_address_fields' {
			return this.get_default_address_fields()
		}
		'get_country_locale_field_selectors' {
			return this.get_country_locale_field_selectors()
		}
		'get_country_locale' {
			return this.get_country_locale()
		}
		'get_address_fields' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_address_fields(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Countries) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'locale' { return this.locale }
		'address_formats' { return this.address_formats }
		'geo_cache' { return this.geo_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Countries) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'locale' { this.locale = val; return true }
		'address_formats' { this.address_formats = val; return true }
		'geo_cache' { this.geo_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_countries_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
