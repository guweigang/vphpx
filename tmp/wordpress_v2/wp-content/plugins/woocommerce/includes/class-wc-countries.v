import rt

struct Class_WC_Countries {
	rt.PhpObjectBase
pub mut:
	locale          rt.PhpVal = rt.new_array()
	address_formats rt.PhpVal = rt.new_array()
	geo_cache       rt.PhpVal = rt.new_array()
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
	if !rt.is_true(this.geo_cache.array_get(rt.new_string('countries'))) {
		this.geo_cache.array_set('countries', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_countries'),
			rt.include_file(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
				'/i18n/countries.php', '1'),
		]))
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_sort_countries'),
			rt.new_bool(true),
		]))
		{
			rt.call_function('wc_asort_by_locale', [
				this.geo_cache.array_get(rt.new_string('countries')),
			])
		}
	}
	return this.geo_cache.array_get(rt.new_string('countries'))
}

fn (mut this Class_WC_Countries) country_exists(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	return rt.new_bool(this.get_countries().array_isset(var_country_code_mutated))
}

fn (mut this Class_WC_Countries) get_country_from_alpha_3_code(var_country_code rt.PhpVal) rt.PhpVal {
	mut var_country_code_mutated := var_country_code
	if !rt.is_true(var_country_code_mutated) || !(var_country_code_mutated.clone().is_string()) {
		return rt.new_null()
	}
	mut var_data := rt.call_method(create_automattic_woocommerce_vendor_league_iso3166_iso3166(),
		'alpha3', [var_country_code_mutated.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(var_data.array_isset(rt.new_string('alpha2'))) {
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('Alpha-2 country code not found for alpha-3 code.'))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_data.array_get(rt.new_string('alpha2'))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_null()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_Countries) get_continents() rt.PhpVal {
	if !rt.is_true(this.geo_cache.array_get(rt.new_string('continents'))) {
		this.geo_cache.array_set('continents', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_continents'),
			rt.include_file(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
				'/i18n/continents.php', '1'),
		]))
	}
	return this.geo_cache.array_get(rt.new_string('continents'))
}

fn (mut this Class_WC_Countries) get_continent_code_for_country(var_cc rt.PhpVal) string {
	mut var_cc_mutated := var_cc
	var_cc_mutated = rt.new_string(var_cc_mutated.clone().to_string().to_upper().trim_space())
	mut var_continents := this.get_continents()
	mut var_continents_and_ccs := rt.call_function('wp_list_pluck', [
		var_continents.clone(), rt.new_string('countries')])
	mut iter_1 := var_continents_and_ccs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_countries := item_1.val
		mut var_continent_code := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('array_search', [
			var_cc_mutated.clone(),
			var_countries.clone(),
			rt.new_bool(true),
		])))))
		{
			return var_continent_code.str()
		}
	}
	return ''
}

fn (mut this Class_WC_Countries) get_country_calling_code(var_cc rt.PhpVal) rt.PhpVal {
	mut var_cc_mutated := var_cc
	mut var_codes := rt.call_function('wp_cache_get', [rt.new_string('calling-codes'),
		rt.new_string('countries')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_codes)))) {
		var_codes = rt.include_file(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/i18n/phone.php', '1')
		rt.call_function('wp_cache_set', [rt.new_string('calling-codes'),
			var_codes.clone(), rt.new_string('countries')])
	}
	mut var_calling_code := if var_codes.array_isset(var_cc_mutated) {
		var_codes.array_get(var_cc_mutated)
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(var_calling_code.clone().is_array())) {
		var_calling_code = var_calling_code.array_get(rt.new_int(0))
	}
	return var_calling_code.clone()
}

fn (mut this Class_WC_Countries) get_shipping_continents() rt.PhpVal {
	mut var_continents := this.get_continents()
	mut var_shipping_countries := this.get_shipping_countries()
	mut var_shipping_country_codes := rt.func_array_keys(var_shipping_countries.clone())
	mut var_shipping_continents := rt.new_array()
	mut iter_2 := var_continents.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_continent := item_2.val
		mut var_continent_code := item_2.key
		if rt.is_true(rt.new_int(rt.call_function('array_intersect', [
			var_continent.array_get(rt.new_string('countries')),
			var_shipping_country_codes.clone(),
		]).array_count()))
		{
			var_shipping_continents.array_set(var_continent_code, var_continent.clone())
		}
	}
	return var_shipping_continents.clone()
}

fn (mut this Class_WC_Countries) load_country_states() {
	mut var_states := rt.get_superglobal('states')
	var_states = rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/i18n/states.php', '1')
	this.geo_cache.array_set('states', rt.call_function('apply_filters', [
		rt.new_string('woocommerce_states'),
		var_states.clone(),
	]))
}

fn (mut this Class_WC_Countries) get_states(var_cc rt.PhpVal) rt.PhpVal {
	mut var_cc_mutated := var_cc
	if !(this.geo_cache.array_isset(rt.new_string('states'))) {
		this.geo_cache.array_set('states', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_states'),
			rt.include_file(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
				'/i18n/states.php', '1'),
		]))
	}
	if !(var_cc_mutated.clone().is_null()) {
		return if this.geo_cache.array_get(rt.new_string('states')).array_isset(var_cc_mutated) {
			this.geo_cache.array_get(rt.new_string('states')).array_get(var_cc_mutated)
		} else {
			rt.new_bool(false)
		}
	} else {
		return this.geo_cache.array_get(rt.new_string('states'))
	}
	return rt.new_null()
}

fn (mut this Class_WC_Countries) get_base_address() rt.PhpVal {
	mut var_base_address := rt.call_function('get_option', [
		rt.new_string('woocommerce_store_address'),
		rt.new_string(''),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_base_address'),
		var_base_address.clone(),
	])
}

fn (mut this Class_WC_Countries) get_base_address_2() rt.PhpVal {
	mut var_base_address_2 := rt.call_function('get_option', [
		rt.new_string('woocommerce_store_address_2'),
		rt.new_string(''),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_base_address_2'),
		var_base_address_2.clone(),
	])
}

fn (mut this Class_WC_Countries) get_base_country() rt.PhpVal {
	mut var_default := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_base_country'),
		var_default.array_get(rt.new_string('country')),
	])
}

fn (mut this Class_WC_Countries) get_base_state() rt.PhpVal {
	mut var_default := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_base_state'),
		var_default.array_get(rt.new_string('state')),
	])
}

fn (mut this Class_WC_Countries) get_base_city() rt.PhpVal {
	mut var_base_city := rt.call_function('get_option', [
		rt.new_string('woocommerce_store_city'),
		rt.new_string(''),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_base_city'),
		var_base_city.clone(),
	])
}

fn (mut this Class_WC_Countries) get_base_postcode() rt.PhpVal {
	mut var_base_postcode := rt.call_function('get_option', [
		rt.new_string('woocommerce_store_postcode'),
		rt.new_string(''),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_base_postcode'),
		var_base_postcode.clone(),
	])
}

fn (mut this Class_WC_Countries) get_allowed_countries() rt.PhpVal {
	mut var_countries := rt.get_property(rt.new_object('WC_Countries', []string{}, &this),
		'countries')
	mut var_allowed_countries := rt.call_function('get_option', [
		rt.new_string('woocommerce_allowed_countries'),
	])
	if rt.is_true(rt.identical(rt.new_string('all_except'), var_allowed_countries)) {
		mut var_except_countries := rt.call_function('get_option', [
			rt.new_string('woocommerce_all_except_countries'),
			rt.new_array(),
		])
		if rt.is_true(var_except_countries) {
			mut iter_3 := var_except_countries.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_country := item_3.val
				var_countries.array_unset(var_country)
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('specific'), var_allowed_countries)) {
		var_countries = rt.new_array()
		mut var_raw_countries := rt.call_function('get_option', [
			rt.new_string('woocommerce_specific_allowed_countries'),
			rt.new_array(),
		])
		if rt.is_true(var_raw_countries) {
			mut iter_4 := var_raw_countries.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_country := item_4.val
				var_countries.array_set(var_country, rt.get_property(rt.new_object('WC_Countries',
					[]string{}, &this), 'countries').array_get(var_country))
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_allowed_countries'),
		var_countries.clone(),
	])
}

fn (mut this Class_WC_Countries) get_shipping_countries() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('disabled'), rt.call_function('get_option', [
		rt.new_string('woocommerce_ship_to_countries'),
	])))
	{
		return rt.new_array()
	}
	mut var_countries := this.get_allowed_countries()
	if rt.is_true(rt.identical(rt.new_string('all'), rt.call_function('get_option', [
		rt.new_string('woocommerce_ship_to_countries'),
	])))
	{
		var_countries = rt.get_property(rt.new_object('WC_Countries', []string{}, &this),
			'countries')
	} else if rt.is_true(rt.identical(rt.new_string('specific'), rt.call_function('get_option', [
		rt.new_string('woocommerce_ship_to_countries'),
	])))
	{
		var_countries = rt.new_array()
		mut var_raw_countries := rt.call_function('get_option', [
			rt.new_string('woocommerce_specific_ship_to_countries'),
			rt.new_array(),
		])
		if rt.is_true(var_raw_countries) {
			mut iter_5 := var_raw_countries.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_country := item_5.val
				var_countries.array_set(var_country, rt.get_property(rt.new_object('WC_Countries',
					[]string{}, &this), 'countries').array_get(var_country))
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_shipping_countries'),
		var_countries.clone(),
	])
}

fn (mut this Class_WC_Countries) get_allowed_country_states() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_allowed_countries'),
	]), rt.new_string('specific')))))
	{
		return rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states')
	}
	mut var_states := rt.new_array()
	mut var_raw_countries := rt.call_function('get_option', [
		rt.new_string('woocommerce_specific_allowed_countries'),
	])
	if rt.is_true(var_raw_countries) {
		mut iter_6 := var_raw_countries.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_country := item_6.val
			if rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states').array_isset(var_country) {
				var_states.array_set(var_country, rt.get_property(rt.new_object('WC_Countries',
					[]string{}, &this), 'states').array_get(var_country))
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_allowed_country_states'),
		var_states.clone(),
	])
}

fn (mut this Class_WC_Countries) get_shipping_country_states() rt.PhpVal {
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_ship_to_countries'),
	]), rt.new_string('')))
	{
		return this.get_allowed_country_states()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_ship_to_countries'),
	]), rt.new_string('specific')))))
	{
		return rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states')
	}
	mut var_states := rt.new_array()
	mut var_raw_countries := rt.call_function('get_option', [
		rt.new_string('woocommerce_specific_ship_to_countries'),
	])
	if rt.is_true(var_raw_countries) {
		mut iter_7 := var_raw_countries.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_country := item_7.val
			if !(!rt.is_true(rt.get_property(rt.new_object('WC_Countries', []string{}, &this),
				'states').array_get(var_country))) {
				var_states.array_set(var_country, rt.get_property(rt.new_object('WC_Countries',
					[]string{}, &this), 'states').array_get(var_country))
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_shipping_country_states'),
		var_states.clone(),
	])
}

fn (mut this Class_WC_Countries) get_european_union_countries(type string) rt.PhpVal {
	mut var_countries := rt.create_array([rt.ArrayItem{ key: none, val: 'AT' },
		rt.ArrayItem{ key: none, val: 'BE' }, rt.ArrayItem{ key: none, val: 'BG' },
		rt.ArrayItem{ key: none, val: 'CY' }, rt.ArrayItem{ key: none, val: 'CZ' },
		rt.ArrayItem{ key: none, val: 'DE' }, rt.ArrayItem{ key: none, val: 'DK' },
		rt.ArrayItem{ key: none, val: 'EE' }, rt.ArrayItem{ key: none, val: 'ES' },
		rt.ArrayItem{ key: none, val: 'FI' }, rt.ArrayItem{ key: none, val: 'FR' },
		rt.ArrayItem{ key: none, val: 'GR' }, rt.ArrayItem{ key: none, val: 'HR' },
		rt.ArrayItem{ key: none, val: 'HU' }, rt.ArrayItem{ key: none, val: 'IE' },
		rt.ArrayItem{ key: none, val: 'IT' }, rt.ArrayItem{ key: none, val: 'LT' },
		rt.ArrayItem{ key: none, val: 'LU' }, rt.ArrayItem{ key: none, val: 'LV' },
		rt.ArrayItem{ key: none, val: 'MT' }, rt.ArrayItem{ key: none, val: 'NL' },
		rt.ArrayItem{ key: none, val: 'PL' }, rt.ArrayItem{ key: none, val: 'PT' },
		rt.ArrayItem{ key: none, val: 'RO' }, rt.ArrayItem{ key: none, val: 'SE' },
		rt.ArrayItem{ key: none, val: 'SI' }, rt.ArrayItem{ key: none, val: 'SK' }])
	if rt.is_true(rt.identical(rt.new_string('eu_vat'), rt.new_string(type))) {
		var_countries.array_push('MC')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_european_union_countries'),
		var_countries.clone(),
		rt.new_string(type),
	])
}

fn (mut this Class_WC_Countries) countries_using_vat() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('countries_using_vat'),
		rt.new_string('4.0'), rt.new_string('WC_Countries::get_vat_countries')])
	mut var_countries := rt.create_array([rt.ArrayItem{ key: none, val: 'AE' },
		rt.ArrayItem{ key: none, val: 'AL' }, rt.ArrayItem{ key: none, val: 'AR' },
		rt.ArrayItem{ key: none, val: 'AZ' }, rt.ArrayItem{ key: none, val: 'BB' },
		rt.ArrayItem{ key: none, val: 'BH' }, rt.ArrayItem{ key: none, val: 'BO' },
		rt.ArrayItem{ key: none, val: 'BS' }, rt.ArrayItem{ key: none, val: 'BY' },
		rt.ArrayItem{ key: none, val: 'CL' }, rt.ArrayItem{ key: none, val: 'CO' },
		rt.ArrayItem{ key: none, val: 'EC' }, rt.ArrayItem{ key: none, val: 'EG' },
		rt.ArrayItem{ key: none, val: 'ET' }, rt.ArrayItem{ key: none, val: 'FJ' },
		rt.ArrayItem{ key: none, val: 'FO' }, rt.ArrayItem{ key: none, val: 'GH' },
		rt.ArrayItem{ key: none, val: 'GM' }, rt.ArrayItem{ key: none, val: 'GT' },
		rt.ArrayItem{ key: none, val: 'IL' }, rt.ArrayItem{ key: none, val: 'IR' },
		rt.ArrayItem{ key: none, val: 'IS' }, rt.ArrayItem{ key: none, val: 'KN' },
		rt.ArrayItem{ key: none, val: 'KR' }, rt.ArrayItem{ key: none, val: 'KZ' },
		rt.ArrayItem{ key: none, val: 'LK' }, rt.ArrayItem{ key: none, val: 'MD' },
		rt.ArrayItem{ key: none, val: 'ME' }, rt.ArrayItem{ key: none, val: 'MK' },
		rt.ArrayItem{ key: none, val: 'MN' }, rt.ArrayItem{ key: none, val: 'MU' },
		rt.ArrayItem{ key: none, val: 'MX' }, rt.ArrayItem{ key: none, val: 'NA' },
		rt.ArrayItem{ key: none, val: 'NG' }, rt.ArrayItem{ key: none, val: 'NP' },
		rt.ArrayItem{ key: none, val: 'PS' }, rt.ArrayItem{ key: none, val: 'PY' },
		rt.ArrayItem{ key: none, val: 'RS' }, rt.ArrayItem{ key: none, val: 'RU' },
		rt.ArrayItem{ key: none, val: 'RW' }, rt.ArrayItem{ key: none, val: 'SA' },
		rt.ArrayItem{ key: none, val: 'SV' }, rt.ArrayItem{ key: none, val: 'TH' },
		rt.ArrayItem{ key: none, val: 'TR' }, rt.ArrayItem{ key: none, val: 'UA' },
		rt.ArrayItem{ key: none, val: 'UY' }, rt.ArrayItem{ key: none, val: 'UZ' },
		rt.ArrayItem{ key: none, val: 'VE' }, rt.ArrayItem{ key: none, val: 'VN' },
		rt.ArrayItem{ key: none, val: 'ZA' }])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_using_vat'),
		var_countries.clone(),
	])
}

fn (mut this Class_WC_Countries) get_vat_countries() rt.PhpVal {
	mut var_eu_countries := this.get_european_union_countries('')
	mut var_vat_countries := ['AE', 'AL', 'AR', 'AZ', 'BB', 'BH', 'BO', 'BS', 'BY', 'CL', 'CO',
		'EC', 'EG', 'ET', 'FJ', 'FO', 'GB', 'GH', 'GM', 'GT', 'IL', 'IM', 'IR', 'IS', 'KN', 'KR',
		'KZ', 'LK', 'MC', 'MD', 'ME', 'MK', 'MN', 'MU', 'MX', 'NA', 'NG', 'NO', 'NP', 'PS', 'PY',
		'RS', 'RU', 'RW', 'SA', 'SV', 'TH', 'TR', 'UA', 'UY', 'UZ', 'VE', 'VN', 'XK', 'ZA']
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_vat_countries'),
		rt.call_function('array_merge', [var_eu_countries.clone(),
			rt.create_array_from_list(var_vat_countries)])])
}

fn (mut this Class_WC_Countries) shipping_to_prefix(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = (if rt.is_true(rt.new_string(country_code_mutated)) {
		rt.new_string(country_code_mutated)
	} else {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'),
			'get_shipping_country', []rt.PhpVal{})
	}).str()
	mut var_countries := rt.create_array([rt.ArrayItem{ key: none, val: 'AE' },
		rt.ArrayItem{ key: none, val: 'CZ' }, rt.ArrayItem{ key: none, val: 'DO' },
		rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'NL' },
		rt.ArrayItem{ key: none, val: 'PH' }, rt.ArrayItem{ key: none, val: 'US' },
		rt.ArrayItem{ key: none, val: 'USAF' }])
	mut var_return := if rt.is_true(rt.call_function('in_array', [
		rt.new_string(country_code_mutated).clone(), var_countries.clone(),
		rt.new_bool(true)]))
	{ rt.call_function('_x', [rt.new_string('to the'), rt.new_string('shipping country prefix'),
			rt.new_string('woocommerce')]) } else { rt.call_function('_x', [
			rt.new_string('to'),
			rt.new_string('shipping country prefix'),
			rt.new_string('woocommerce'),
		]) }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_shipping_to_prefix'),
		var_return.clone(),
		rt.new_string(country_code_mutated).clone(),
	])
}

fn (mut this Class_WC_Countries) estimated_for_prefix(country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = (if rt.is_true(rt.new_string(country_code_mutated)) {
		rt.new_string(country_code_mutated)
	} else {
		this.get_base_country()
	}).str()
	mut var_countries := rt.create_array([rt.ArrayItem{ key: none, val: 'AE' },
		rt.ArrayItem{ key: none, val: 'CZ' }, rt.ArrayItem{ key: none, val: 'DO' },
		rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'NL' },
		rt.ArrayItem{ key: none, val: 'PH' }, rt.ArrayItem{ key: none, val: 'US' },
		rt.ArrayItem{ key: none, val: 'USAF' }])
	mut var_return := rt.new_string((if rt.is_true(rt.call_function('in_array', [
		rt.new_string(country_code_mutated).clone(),
		var_countries.clone(),
		rt.new_bool(true),
	]))
	{
		(rt.call_function('__', [rt.new_string('the'), rt.new_string('woocommerce')])).str() + ' '
	} else {
		''
	}).str())
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_estimated_for_prefix'),
		var_return.clone(),
		rt.new_string(country_code_mutated).clone(),
	])
}

fn (mut this Class_WC_Countries) tax_or_vat() rt.PhpVal {
	mut var_return := if rt.is_true(rt.call_function('in_array', [
		this.get_base_country(), this.get_vat_countries(), rt.new_bool(true)]))
	{ rt.call_function('__', [rt.new_string('VAT'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('Tax'),
			rt.new_string('woocommerce'),
		]) }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_tax_or_vat'),
		var_return.clone(),
	])
}

fn (mut this Class_WC_Countries) inc_tax_or_vat() rt.PhpVal {
	mut var_return := if rt.is_true(rt.call_function('in_array', [
		this.get_base_country(), this.get_vat_countries(), rt.new_bool(true)]))
	{ rt.call_function('__', [rt.new_string('(incl. VAT)'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('(incl. tax)'),
			rt.new_string('woocommerce'),
		]) }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_inc_tax_or_vat'),
		var_return.clone(),
	])
}

fn (mut this Class_WC_Countries) ex_tax_or_vat() rt.PhpVal {
	mut var_return := if rt.is_true(rt.call_function('in_array', [
		this.get_base_country(), this.get_vat_countries(), rt.new_bool(true)]))
	{ rt.call_function('__', [rt.new_string('(ex. VAT)'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('(ex. tax)'),
			rt.new_string('woocommerce'),
		]) }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_countries_ex_tax_or_vat'),
		var_return.clone(),
	])
}

fn (mut this Class_WC_Countries) country_dropdown_options(selected_country string, selected_state string, escape bool) {
	mut selected_state_mutated := selected_state
	if rt.is_true(rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'countries')) {
		mut iter_8 :=
			rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'countries').iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value := item_8.val
			mut var_key := item_8.key
			mut var_states := this.get_states(var_key.clone())
			if rt.is_true(var_states) {
				if rt.is_true(rt.identical(rt.new_string(selected_country), var_key))
					&& rt.is_true(rt.identical(rt.new_string('*'), rt.new_string(selected_state_mutated))) {
					selected_state_mutated = (if !(rt.call_function('key', [
						var_states.clone()])).is_null() { rt.call_function('key', [
							var_states.clone(),
						]) } else { rt.new_string('*') }).str()
				}
				print('<optgroup label="' +
					(rt.call_function('esc_attr', [var_value.clone()])).str() + '">')
				mut iter_9 := var_states.iterator()
				for {
					item_9 := iter_9.next() or { break }
					mut var_state_value := item_9.val
					mut var_state_key := item_9.key
					print('<option value="' +
						(rt.call_function('esc_attr', [var_key.clone()])).str() + ':' +
						(rt.call_function('esc_attr', [var_state_key.clone()])).str() + '"')
					if rt.is_true(rt.identical(rt.new_string(selected_country), var_key))
						&& rt.is_true(rt.identical(rt.new_string(selected_state_mutated), var_state_key)) {
						print(' selected="selected"')
					}
					print('>' + (rt.call_function('esc_html', [var_value.clone()])).str() +
						' &mdash; ' +
						(if var_escape { rt.call_function('esc_html', [var_state_value.clone()]) } else { var_state_value }).str() +
						'</option>')
				}
				print('</optgroup>')
			} else {
				print('<option')
				if rt.is_true(rt.identical(rt.new_string(selected_country), var_key))
					&& rt.is_true(rt.identical(rt.new_string('*'), rt.new_string(selected_state_mutated))) {
					print(' selected="selected"')
				}
				print(' value="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '">' +
					(if var_escape { rt.call_function('esc_html', [var_value.clone()]) } else { var_value }).str() +
					'</option>')
			}
		}
	}
}

fn (mut this Class_WC_Countries) get_address_formats() rt.PhpVal {
	if !rt.is_true(this.address_formats) {
		this.address_formats = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_localisation_address_formats'),
			rt.create_array([
				rt.ArrayItem{
					key: 'default'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{city}\n{state}\n{postcode}\n{country}'
				},
				rt.ArrayItem{
					key: 'AT'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'AU'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{city} {state} {postcode}\n{country}'
				},
				rt.ArrayItem{
					key: 'BE'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'CA'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{city} {state_code} {postcode}\n{country}'
				},
				rt.ArrayItem{
					key: 'CH'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'CL'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{state}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'CN'
					val: '{country} {postcode}\n{state}, {city}, {address_2}, {address_1}\n{company}\n{name}'
				},
				rt.ArrayItem{
					key: 'CZ'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'DE'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'DK'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'EE'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'ES'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{postcode} {city}\n{state}\n{country}'
				},
				rt.ArrayItem{
					key: 'FI'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'FR'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city_upper}\n{country}'
				},
				rt.ArrayItem{
					key: 'HK'
					val: '{company}\n{first_name} {last_name_upper}\n{address_1}\n{address_2}\n{city_upper}\n{state_upper}\n{country}'
				},
				rt.ArrayItem{
					key: 'HU'
					val: '{last_name} {first_name}\n{company}\n{city}\n{address_1}\n{address_2}\n{postcode}\n{country}'
				},
				rt.ArrayItem{
					key: 'IN'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{city} {postcode}\n{state}, {country}'
				},
				rt.ArrayItem{
					key: 'IS'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'IT'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode}\n{city}\n{state_upper}\n{country}'
				},
				rt.ArrayItem{
					key: 'JM'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{city}\n{state}\n{postcode_upper}\n{country}'
				},
				rt.ArrayItem{
					key: 'JP'
					val: '{postcode}\n{state} {city} {address_1}\n{address_2}\n{company}\n{last_name} {first_name}\n{country}'
				},
				rt.ArrayItem{
					key: 'LI'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'NL'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'NO'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'NZ'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{city} {postcode}\n{country}'
				},
				rt.ArrayItem{
					key: 'PL'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'PR'
					val: '{company}\n{name}\n{address_1} {address_2}\n{city} \n{country} {postcode}'
				},
				rt.ArrayItem{
					key: 'PT'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'RS'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'SE'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'SI'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'SK'
					val: '{company}\n{name}\n{address_1}\n{address_2}\n{postcode} {city}\n{country}'
				},
				rt.ArrayItem{
					key: 'TR'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{postcode} {city} {state}\n{country}'
				},
				rt.ArrayItem{
					key: 'TW'
					val: '{company}\n{last_name} {first_name}\n{address_1}\n{address_2}\n{state}, {city} {postcode}\n{country}'
				},
				rt.ArrayItem{
					key: 'UG'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{city}\n{state}, {country}'
				},
				rt.ArrayItem{
					key: 'US'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{city}, {state_code} {postcode}\n{country}'
				},
				rt.ArrayItem{
					key: 'VN'
					val: '{name}\n{company}\n{address_1}\n{address_2}\n{city} {postcode}\n{country}'
				},
			]),
		])
	}
	return this.address_formats
}

fn (mut this Class_WC_Countries) get_formatted_address(var_args rt.PhpVal, separator string) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_default_args := {
		'first_name': ''
		'last_name':  ''
		'company':    ''
		'address_1':  ''
		'address_2':  ''
		'city':       ''
		'state':      ''
		'postcode':   ''
		'country':    ''
	}
	var_args_mutated = rt.call_function('array_map', [rt.new_string('trim'),
		rt.call_function('wp_parse_args', [var_args_mutated.clone(),
			rt.create_array_from_native_map(var_default_args)])])
	mut var_state := var_args_mutated.array_get(rt.new_string('state'))
	mut var_country := var_args_mutated.array_get(rt.new_string('country'))
	mut var_formats := this.get_address_formats()
	mut var_format := if rt.is_true(var_country) && var_formats.array_isset(var_country) {
		var_formats.array_get(var_country)
	} else {
		var_formats.array_get(rt.new_string('default'))
	}
	mut var_full_country := if rt.get_property(rt.new_object('WC_Countries', []string{}, &this),
		'countries').array_isset(var_country)
	{
		rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'countries').array_get(var_country)
	} else {
		var_country
	}
	if rt.is_true(rt.identical(var_country, this.get_base_country()))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_formatted_address_force_country_display'), rt.new_bool(false)]))))) {
		var_format = rt.call_function('str_replace', [rt.new_string('{country}'),
			rt.new_string(''), var_format.clone()])
	}
	mut var_full_state := if rt.is_true(var_country) && rt.is_true(var_state)
		&& rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states').array_get(var_country).array_isset(var_state) {
		rt.get_property(rt.new_object('WC_Countries', []string{}, &this), 'states').array_get(var_country).array_get(var_state)
	} else {
		var_state
	}
	mut var_replace := rt.call_function('array_map', [rt.new_string('esc_html'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_formatted_address_replacements'),
			rt.create_array([
				rt.ArrayItem{
					key: '{first_name}'
					val: var_args_mutated.array_get(rt.new_string('first_name'))
				},
				rt.ArrayItem{
					key: '{last_name}'
					val: var_args_mutated.array_get(rt.new_string('last_name'))
				},
				rt.ArrayItem{ key: '{name}', val: rt.call_function('sprintf', [
					rt.call_function('_x', [
						rt.new_string('%1$s %2$s'),
						rt.new_string('full name'),
						rt.new_string('woocommerce'),
					]),
					var_args_mutated.array_get(rt.new_string('first_name')),
					var_args_mutated.array_get(rt.new_string('last_name')),
				]) },
				rt.ArrayItem{
					key: '{company}'
					val: var_args_mutated.array_get(rt.new_string('company'))
				},
				rt.ArrayItem{
					key: '{address_1}'
					val: var_args_mutated.array_get(rt.new_string('address_1'))
				},
				rt.ArrayItem{
					key: '{address_2}'
					val: var_args_mutated.array_get(rt.new_string('address_2'))
				},
				rt.ArrayItem{ key: '{city}', val: var_args_mutated.array_get(rt.new_string('city')) },
				rt.ArrayItem{ key: '{state}', val: var_full_state },
				rt.ArrayItem{
					key: '{postcode}'
					val: var_args_mutated.array_get(rt.new_string('postcode'))
				},
				rt.ArrayItem{ key: '{country}', val: var_full_country },
				rt.ArrayItem{ key: '{first_name_upper}', val: rt.call_function('wc_strtoupper', [
					var_args_mutated.array_get(rt.new_string('first_name')),
				]) },
				rt.ArrayItem{ key: '{last_name_upper}', val: rt.call_function('wc_strtoupper', [
					var_args_mutated.array_get(rt.new_string('last_name')),
				]) },
				rt.ArrayItem{ key: '{name_upper}', val: rt.call_function('wc_strtoupper', [
					rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%1$s %2$s'),
							rt.new_string('full name'), rt.new_string('woocommerce')]),
						var_args_mutated.array_get(rt.new_string('first_name')),
						var_args_mutated.array_get(rt.new_string('last_name')),
					]),
				]) },
				rt.ArrayItem{ key: '{company_upper}', val: rt.call_function('wc_strtoupper', [
					var_args_mutated.array_get(rt.new_string('company')),
				]) },
				rt.ArrayItem{ key: '{address_1_upper}', val: rt.call_function('wc_strtoupper', [
					var_args_mutated.array_get(rt.new_string('address_1')),
				]) },
				rt.ArrayItem{ key: '{address_2_upper}', val: rt.call_function('wc_strtoupper', [
					var_args_mutated.array_get(rt.new_string('address_2')),
				]) },
				rt.ArrayItem{ key: '{city_upper}', val: rt.call_function('wc_strtoupper', [
					var_args_mutated.array_get(rt.new_string('city')),
				]) },
				rt.ArrayItem{ key: '{state_upper}', val: rt.call_function('wc_strtoupper', [
					var_full_state.clone(),
				]) },
				rt.ArrayItem{ key: '{state_code}', val: rt.call_function('wc_strtoupper', [
					var_state.clone(),
				]) },
				rt.ArrayItem{ key: '{postcode_upper}', val: rt.call_function('wc_strtoupper', [
					var_args_mutated.array_get(rt.new_string('postcode')),
				]) },
				rt.ArrayItem{ key: '{country_upper}', val: rt.call_function('wc_strtoupper', [
					var_full_country.clone(),
				]) },
			]),
			var_args_mutated.clone(),
		])])
	mut var_formatted_address := rt.call_function('str_replace', [
		rt.func_array_keys(var_replace.clone()),
		var_replace.clone(),
		var_format.clone(),
	])
	var_formatted_address = rt.call_function('preg_replace', [
		rt.new_string('/  +/'), rt.new_string(' '),
		rt.new_string(var_formatted_address.clone().to_string().trim_space())])
	var_formatted_address = rt.call_function('preg_replace', [
		rt.new_string('/\\n\\n+/'), rt.new_string('\n'), var_formatted_address.clone()])
	var_formatted_address = rt.call_function('array_filter', [
		rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Countries', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'trim_formatted_address_line' },
			]),
			rt.call_function('explode', [
				rt.new_string('\n'),
				var_formatted_address.clone(),
			]),
		]),
	])
	var_formatted_address = rt.call_function('implode', [rt.new_string(separator),
		var_formatted_address.clone()])
	return var_formatted_address.clone()
}

fn (mut this Class_WC_Countries) trim_formatted_address_line(var_line rt.PhpVal) string {
	return var_line.clone().to_string().trim_space()
}

fn (mut this Class_WC_Countries) get_default_address_fields() rt.PhpVal {
	mut var_address_2_label := rt.call_function('__', [
		rt.new_string('Apartment, suite, unit, etc.'),
		rt.new_string('woocommerce'),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_0 := iife_temp_0.get_address_2_field_visibility()
	if rt.is_true(rt.identical(rt.new_string('optional'), iife_result_0)) {
		mut var_address_2_placeholder := rt.call_function('__', [
			rt.new_string('Apartment, suite, unit, etc. (optional)'),
			rt.new_string('woocommerce'),
		])
	} else {
		var_address_2_placeholder = var_address_2_label.clone()
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_1 := iife_temp_1.get_company_field_visibility()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_2 := iife_temp_2.get_address_2_field_visibility()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_3 := iife_temp_3.get_phone_field_visibility()
	mut var_fields := rt.create_array([
		rt.ArrayItem{ key: 'first_name', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('First name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-first' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'given-name' },
			rt.ArrayItem{ key: 'priority', val: 10 },
		]) },
		rt.ArrayItem{ key: 'last_name', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Last name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-last' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'family-name' },
			rt.ArrayItem{ key: 'priority', val: 20 },
		]) },
		rt.ArrayItem{ key: 'company', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Company name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'organization' },
			rt.ArrayItem{ key: 'priority', val: 30 },
			rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('required'),
				iife_result_1) },
		]) },
		rt.ArrayItem{ key: 'country', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'country' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Country / Region'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
				rt.ArrayItem{ key: none, val: 'address-field' },
				rt.ArrayItem{ key: none, val: 'update_totals_on_change' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'country' },
			rt.ArrayItem{ key: 'priority', val: 40 },
		]) },
		rt.ArrayItem{ key: 'address_1', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Street address'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [
				rt.new_string('House number and street name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
				rt.ArrayItem{ key: none, val: 'address-field' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'address-line1' },
			rt.ArrayItem{ key: 'priority', val: 50 },
		]) },
		rt.ArrayItem{ key: 'address_2', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: var_address_2_label },
			rt.ArrayItem{ key: 'label_class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'screen-reader-text' },
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr', [
				var_address_2_placeholder.clone(),
			]) },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
				rt.ArrayItem{ key: none, val: 'address-field' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'address-line2' },
			rt.ArrayItem{ key: 'priority', val: 60 },
			rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('required'),
				iife_result_2) },
		]) },
		rt.ArrayItem{ key: 'city', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Town / City'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
				rt.ArrayItem{ key: none, val: 'address-field' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'address-level2' },
			rt.ArrayItem{ key: 'priority', val: 70 },
		]) },
		rt.ArrayItem{ key: 'state', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'state' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('State / County'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
				rt.ArrayItem{ key: none, val: 'address-field' },
			]) },
			rt.ArrayItem{ key: 'validate', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'state' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'address-level1' },
			rt.ArrayItem{ key: 'priority', val: 80 },
		]) },
		rt.ArrayItem{ key: 'postcode', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Postcode / ZIP'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
				rt.ArrayItem{ key: none, val: 'address-field' },
			]) },
			rt.ArrayItem{ key: 'validate', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postcode' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'postal-code' },
			rt.ArrayItem{ key: 'priority', val: 90 },
		]) },
		rt.ArrayItem{ key: 'phone', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Phone'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('required'),
				iife_result_3) },
			rt.ArrayItem{ key: 'type', val: 'tel' },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
			]) },
			rt.ArrayItem{ key: 'validate', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'phone' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'tel' },
			rt.ArrayItem{ key: 'priority', val: 100 },
		]) },
	])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_4 := iife_temp_4.get_phone_field_visibility()
	if rt.is_true(rt.identical(rt.new_string('hidden'), iife_result_4)) {
		var_fields.array_unset(rt.new_string('phone'))
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_5 := iife_temp_5.get_company_field_visibility()
	if rt.is_true(rt.identical(rt.new_string('hidden'), iife_result_5)) {
		var_fields.array_unset(rt.new_string('company'))
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_6 := iife_temp_6.get_address_2_field_visibility()
	if rt.is_true(rt.identical(rt.new_string('hidden'), iife_result_6)) {
		var_fields.array_unset(rt.new_string('address_2'))
	}
	mut var_default_address_fields := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_default_address_fields'),
		var_fields.clone(),
	])
	rt.call_function('uasort', [var_default_address_fields.clone(),
		rt.new_string('wc_checkout_fields_uasort_comparison')])
	return var_default_address_fields.clone()
}

fn (mut this Class_WC_Countries) get_country_locale_field_selectors() rt.PhpVal {
	mut var_locale_fields := {
		'address_1': '#billing_address_1_field, #shipping_address_1_field'
		'address_2': '#billing_address_2_field, #shipping_address_2_field'
		'state':     '#billing_state_field, #shipping_state_field, #calc_shipping_state_field'
		'postcode':  '#billing_postcode_field, #shipping_postcode_field, #calc_shipping_postcode_field'
		'city':      '#billing_city_field, #shipping_city_field, #calc_shipping_city_field'
		'country':   '#billing_country_field, #shipping_country_field, #calc_shipping_country_field'
		'phone':     '#billing_phone_field, #shipping_phone_field'
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_country_locale_field_selectors'),
		rt.create_array_from_native_map(var_locale_fields),
	])
}

fn (mut this Class_WC_Countries) get_country_locale() rt.PhpVal {
	if !rt.is_true(this.locale) {
		this.locale = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_country_locale'),
			rt.create_array([
				rt.ArrayItem{ key: 'AE', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'AF', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'AL', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('County'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'AO', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'AT', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'AU', val: rt.create_array([
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Suburb'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postcode'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('State'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'AX', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'BA', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Canton'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'BD', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('District'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'BE', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'BG', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'BH', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'BI', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'BO', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'BS', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'BW', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('District'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'BZ', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'CA', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postal code'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'CH', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Canton'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'CL', val: rt.create_array([
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: rt.identical(rt.new_string('CL'),
							this.get_base_country()) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Region'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'CN', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'CO', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'CR', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'CW', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'CY', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'CZ', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'DE', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'DK', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'DO', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'EC', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'EE', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'ET', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'FI', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'FR', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'GG', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Parish'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'GH', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Region'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'GP', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'GF', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'GR', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'GT', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'HK', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Town / District'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Region'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'HN', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'HU', val: rt.create_array([
					rt.ArrayItem{ key: 'last_name', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-first' },
						]) },
						rt.ArrayItem{ key: 'priority', val: 10 },
					]) },
					rt.ArrayItem{ key: 'first_name', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-last' },
						]) },
						rt.ArrayItem{ key: 'priority', val: 20 },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-first' },
							rt.ArrayItem{ key: none, val: 'address-field' },
						]) },
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-last' },
							rt.ArrayItem{ key: none, val: 'address-field' },
						]) },
					]) },
					rt.ArrayItem{ key: 'address_1', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 71 },
					]) },
					rt.ArrayItem{ key: 'address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 72 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('County'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'ID', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'IE', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Eircode'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('County'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'IS', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'IL', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'IM', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'IN', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('PIN Code'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('State'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'IR', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 50 },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 60 },
					]) },
					rt.ArrayItem{ key: 'address_1', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 70 },
					]) },
					rt.ArrayItem{ key: 'address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 80 },
					]) },
				]) },
				rt.ArrayItem{ key: 'IT', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'JM', val: rt.create_array([
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Town / City / Post Office'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postal Code'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Parish'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'JP', val: rt.create_array([
					rt.ArrayItem{ key: 'last_name', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-first' },
						]) },
						rt.ArrayItem{ key: 'priority', val: 10 },
					]) },
					rt.ArrayItem{ key: 'first_name', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-last' },
						]) },
						rt.ArrayItem{ key: 'priority', val: 20 },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-first' },
							rt.ArrayItem{ key: none, val: 'address-field' },
						]) },
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Prefecture'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'class', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'form-row-last' },
							rt.ArrayItem{ key: none, val: 'address-field' },
						]) },
						rt.ArrayItem{ key: 'priority', val: 66 },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 67 },
					]) },
					rt.ArrayItem{ key: 'address_1', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 68 },
					]) },
					rt.ArrayItem{ key: 'address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 69 },
					]) },
				]) },
				rt.ArrayItem{ key: 'KN', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postal code'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Parish'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'KR', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'KW', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'LV', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Municipality'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'LB', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'MF', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'MQ', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'MT', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'MZ', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'NI', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'NL', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'NG', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postcode'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('State'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'NZ', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postcode'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Region'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'NO', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'NP', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('State / Zone'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'PA', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'PL', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'PR', val: rt.create_array([
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Municipality'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'PT', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'PY', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'RE', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'RO', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('County'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'RS', val: rt.create_array([
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('District'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'RW', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'SG', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'SK', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'SI', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'SR', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'SV', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'ES', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'LI', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'LK', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'LU', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'MD', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Municipality / District'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'SE', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'TR', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'UG', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Town / Village'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('District'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'US', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('ZIP Code'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('State'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'UY', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Department'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'GB', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postcode'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('County'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'ST', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('District'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'VN', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'priority', val: 65 },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: false },
					]) },
					rt.ArrayItem{ key: 'address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'WS', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'YT', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'ZA', val: rt.create_array([
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Province'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'ZW', val: rt.create_array([
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'hidden', val: true },
					]) },
				]) },
			]),
		])
		this.locale = rt.call_function('array_intersect_key', [this.locale,
			rt.call_function('array_merge', [this.get_allowed_countries(),
				this.get_shipping_countries()])])
		this.locale.array_set('default', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_country_locale_default'),
			this.get_default_address_fields(),
		]))
		if !(this.locale.array_isset(this.get_base_country())) {
			this.locale.array_set(this.get_base_country(),
				this.locale.array_get(rt.new_string('default')))
		}
		this.locale.array_set('default', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_country_locale_base'),
			this.locale.array_get(rt.new_string('default')),
		]))
		this.locale.array_set(this.get_base_country(), rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_country_locale_base'),
			this.locale.array_get(this.get_base_country()),
		]))
		mut iter_10 := this.locale.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_locale_entry := item_10.val
			if var_locale_entry.array_isset(rt.new_string('country')) {
				var_locale_entry.array_get_mut('country').array_set('hidden', false)
				var_locale_entry.array_get_mut('country').array_set('required', true)
			}
		}
		var_locale_entry = rt.new_null()
	}
	return this.locale
}

fn (mut this Class_WC_Countries) get_address_fields(country string, type string) rt.PhpVal {
	mut country_mutated := country
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(country_mutated))))) {
		country_mutated = (this.get_base_country()).str()
	}
	mut var_fields := this.get_default_address_fields()
	mut var_locale := this.get_country_locale()
	if var_locale.array_isset(rt.new_string(country_mutated)) {
		var_fields = rt.call_function('wc_array_overlay', [var_fields.clone(),
			var_locale.array_get(rt.new_string(country_mutated))])
	}
	mut var_address_fields := rt.new_array()
	mut var_address_type := rt.new_string(type.trim_right(' \t\n\r'))
	mut iter_11 := var_fields.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_value := item_11.val
		mut var_key := item_11.key
		if rt.is_true(rt.identical(rt.new_string('state'), var_key)) {
			var_value.array_set('country_field', type + 'country')
			var_value.array_set('country', country_mutated)
		}
		if !(!rt.is_true(var_value.array_get(rt.new_string('autocomplete')))) {
			var_value.array_set('autocomplete', 'section-' + var_address_type.str() + ' ' +
				var_address_type.str() + ' ' +
				(var_value.array_get(rt.new_string('autocomplete'))).str())
		}
		var_address_fields.array_set(type + var_key.str(), var_value.clone())
	}
	if rt.is_true(rt.identical(rt.new_string('billing_'), rt.new_string(type))) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
		mut iife_result_7 := iife_temp_7.get_phone_field_visibility()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('hidden'), iife_result_7)))) {
			mut iife_temp_8 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
			mut iife_result_8 := iife_temp_8.get_phone_field_visibility()
			var_address_fields.array_set('billing_phone', rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Phone'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('required'),
					iife_result_8) },
				rt.ArrayItem{ key: 'type', val: 'tel' },
				rt.ArrayItem{ key: 'class', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'form-row-wide' },
				]) },
				rt.ArrayItem{ key: 'validate', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'phone' },
				]) },
				rt.ArrayItem{ key: 'autocomplete', val: 'section-' + var_address_type.str() + ' ' +
					var_address_type.str() + ' tel' },
				rt.ArrayItem{ key: 'priority', val: 100 },
			]))
		}
		var_address_fields.array_set('billing_email', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Email address'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'type', val: 'email' },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'form-row-wide' },
			]) },
			rt.ArrayItem{ key: 'validate', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'email' },
			]) },
			rt.ArrayItem{ key: 'autocomplete', val: 'section-' + var_address_type.str() + ' ' +
				var_address_type.str() + ' email' },
			rt.ArrayItem{ key: 'priority', val: 110 },
		]))
	}
	var_address_fields = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' + type + 'fields'),
		var_address_fields.clone(),
		rt.new_string(country_mutated).clone(),
	])
	rt.call_function('uasort', [var_address_fields.clone(),
		rt.new_string('wc_checkout_fields_uasort_comparison')])
	return var_address_fields.clone()
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166 {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

fn create_wc_countries(_args ...rt.PhpVal) &Class_WC_Countries {
	mut obj := &Class_WC_Countries{
		PhpObjectBase:   rt.PhpObjectBase{}
		locale:          rt.new_array()
		address_formats: rt.new_array()
		geo_cache:       rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_league_iso3166_iso3166(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166 {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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
		else {
			return none
		}
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
		'locale' {
			this.locale = val
			return true
		}
		'address_formats' {
			this.address_formats = val
			return true
		}
		'geo_cache' {
			this.geo_cache = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
		else {
			return none
		}
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
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
