import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.tracking_patterns() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'DE', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^02\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^05\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^09\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{24}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 80 },
			rt.ArrayItem{ key: 'services', val: rt.create_array([
				rt.ArrayItem{ key: 'classic', val: 80 },
				rt.ArrayItem{ key: 'express', val: 85 },
				rt.ArrayItem{ key: 'predict', val: 85 },
				rt.ArrayItem{ key: 's10', val: 90 },
			]) },
		]) },
		rt.ArrayItem{ key: 'GB', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}GB$/' },
				rt.ArrayItem{ key: none, val: '/^03\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^06\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^1[56]\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{24}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 90 },
			rt.ArrayItem{ key: 'services', val: rt.create_array([
				rt.ArrayItem{ key: 'next_day', val: 88 },
				rt.ArrayItem{ key: 'express', val: 88 },
				rt.ArrayItem{ key: 's10', val: 90 },
			]) },
		]) },
		rt.ArrayItem{ key: 'FR', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^02\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^04\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{24}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 78 },
			rt.ArrayItem{ key: 'services', val: rt.create_array([
				rt.ArrayItem{ key: 'relais', val: 82 },
				rt.ArrayItem{ key: 'predict', val: 82 },
				rt.ArrayItem{ key: 's10', val: 90 },
			]) },
		]) },
		rt.ArrayItem{ key: 'NL', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^03\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^07\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{24}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 78 },
			rt.ArrayItem{ key: 'services', val: rt.create_array([
				rt.ArrayItem{ key: 'classic', val: 82 },
				rt.ArrayItem{ key: 'express', val: 85 },
				rt.ArrayItem{ key: 's10', val: 90 },
			]) },
		]) },
		rt.ArrayItem{ key: 'BE', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^03\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^08\\d{12}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{24}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 78 },
			rt.ArrayItem{ key: 'services', val: rt.create_array([
				rt.ArrayItem{ key: 'classic', val: 82 },
				rt.ArrayItem{ key: 'express', val: 85 },
				rt.ArrayItem{ key: 's10', val: 90 },
			]) },
		]) },
		rt.ArrayItem{ key: 'PL', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{24}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 90 },
		]) },
		rt.ArrayItem{ key: 'IE', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}IE$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 85 },
		]) },
		rt.ArrayItem{ key: 'AT', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 75 },
		]) },
		rt.ArrayItem{ key: 'CH', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{9}CH$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 85 },
		]) },
		rt.ArrayItem{ key: 'ES', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 85 },
		]) },
		rt.ArrayItem{ key: 'IT', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 85 },
		]) },
		rt.ArrayItem{ key: 'LU', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 75 },
		]) },
		rt.ArrayItem{ key: 'CZ', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 90 },
		]) },
		rt.ArrayItem{ key: 'SK', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 90 },
		]) },
		rt.ArrayItem{ key: 'HU', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 90 },
		]) },
		rt.ArrayItem{ key: 'SI', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 80 },
		]) },
		rt.ArrayItem{ key: 'HR', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 80 },
		]) },
		rt.ArrayItem{ key: 'RO', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 75 },
		]) },
		rt.ArrayItem{ key: 'BG', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 70 },
		]) },
		rt.ArrayItem{ key: 'LT', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 70 },
		]) },
		rt.ArrayItem{ key: 'LV', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 70 },
		]) },
		rt.ArrayItem{ key: 'EE', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 70 },
		]) },
		rt.ArrayItem{ key: 'FI', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 65 },
		]) },
		rt.ArrayItem{ key: 'DK', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 65 },
		]) },
		rt.ArrayItem{ key: 'SE', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 65 },
		]) },
		rt.ArrayItem{ key: 'NO', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^\\d{12}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 60 },
		]) },
		rt.ArrayItem{ key: 'GR', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 85 },
		]) },
		rt.ArrayItem{ key: 'PT', val: rt.create_array([
			rt.ArrayItem{ key: 'patterns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '/^\\d{14}$/' },
				rt.ArrayItem{ key: none, val: '/^[A-Z]{2}\\d{10}$/' },
			]) },
			rt.ArrayItem{ key: 'confidence', val: 85 },
		]) },
	])
}

pub fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.international_pattern() string {
	return '/^\\d{28}$/'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.s10_pattern() string {
	return '/^[A-Z]{2}\\d{9}[A-Z]{2}$/'
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) get_key() string {
	return 'dpd'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) get_name() string {
	return 'DPD'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) get_icon() string {
	return
		(rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() +
		'/assets/images/shipping_providers/dpd.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) get_shipping_from_countries() rt.PhpVal {
	return rt.func_array_keys(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.tracking_patterns())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) get_shipping_to_countries() rt.PhpVal {
	return this.get_shipping_from_countries()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) get_tracking_url(tracking_number string) string {
	return 'https://www.dpd.com/tracking/' +
		(rt.call_function('rawurlencode', [rt.new_string(tracking_number)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) validate_country_pattern(tracking_number string, country_code string) rt.PhpVal {
	if !(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.tracking_patterns().array_isset(rt.new_string(country_code))) {
		return rt.new_bool(false)
	}
	mut var_country_data :=
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.tracking_patterns().array_get(country_code)
	mut var_detected_service := rt.new_null()
	mut var_confidence_boost := rt.new_int(rt.new_int(0))
	if var_country_data.array_isset(rt.new_string('services')) {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^02\\d{12}$/'),
			rt.new_string(tracking_number)]))
		{
			var_detected_service = rt.new_string(rt.new_string('classic'))
			var_confidence_boost = if !(var_country_data.array_get('services').array_get('classic')).is_null() {
				var_country_data.array_get('services').array_get('classic')
			} else {
				rt.new_int(0)
			}
		} else if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^0[34578]\\d{12}$/'),
			rt.new_string(tracking_number),
		]))
		{
			var_detected_service = rt.new_string(rt.new_string('express'))
			var_confidence_boost = if !(var_country_data.array_get('services').array_get('express')).is_null() {
				var_country_data.array_get('services').array_get('express')
			} else {
				rt.new_int(0)
			}
		} else if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^0[49]\\d{12}$/'),
			rt.new_string(tracking_number),
		]))
		{
			var_detected_service = rt.new_string(rt.new_string('predict'))
			var_confidence_boost = if !(var_country_data.array_get('services').array_get('predict')).is_null() {
				var_country_data.array_get('services').array_get('predict')
			} else {
				rt.new_int(0)
			}
		} else if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('preg_match', [rt.new_string('/^03\\d{12}$/'), rt.new_string(tracking_number)]))
			&& rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(country_code)))))
		{
			var_detected_service = rt.new_string(rt.new_string('next_day'))
			var_confidence_boost = if !(var_country_data.array_get('services').array_get('next_day')).is_null() {
				var_country_data.array_get('services').array_get('next_day')
			} else {
				rt.new_int(0)
			}
		} else if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('preg_match', [rt.new_string('/^02\\d{12}$/'), rt.new_string(tracking_number)]))
			&& rt.is_true(rt.identical(rt.new_string('FR'), rt.new_string(country_code)))))
		{
			var_detected_service = rt.new_string(rt.new_string('relais'))
			var_confidence_boost = if !(var_country_data.array_get('services').array_get('relais')).is_null() {
				var_country_data.array_get('services').array_get('relais')
			} else {
				rt.new_int(0)
			}
		} else if rt.is_true(rt.call_function('preg_match', [
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.s10_pattern(),
			rt.new_string(tracking_number),
		]))
		{
			var_detected_service = rt.new_string(rt.new_string('s10'))
			var_confidence_boost = if !(var_country_data.array_get('services').array_get('s10')).is_null() {
				var_country_data.array_get('services').array_get('s10')
			} else {
				rt.new_int(90)
			}
		}
	}
	{
		mut iter_1 := var_country_data.array_get('patterns').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(),
				rt.new_string(tracking_number)]))
			{
				return rt.create_array([rt.ArrayItem{ key: 'valid', val: true },
					rt.ArrayItem{ key: 'service', val: var_detected_service },
					rt.ArrayItem{ key: 'confidence_boost', val: var_confidence_boost }])
			}
		}
	}
	return rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut shipping_from_mutated := shipping_from
	mut shipping_to_mutated := shipping_to
	if tracking_number == '' || shipping_from_mutated == '' || shipping_to_mutated == '' {
		return rt.new_null()
	}
	mut var_normalized := rt.new_string(rt.new_string(rt.call_function('preg_replace', [
		rt.new_string('/\\s+/'),
		rt.new_string(''),
		rt.new_string(tracking_number),
	]).to_string().to_upper()))
	if !rt.is_true(var_normalized) {
		return rt.new_null()
	}
	shipping_from_mutated = shipping_from_mutated.to_upper()
	shipping_to_mutated = shipping_to_mutated.to_upper()
	if rt.is_true(rt.call_function('preg_match', [
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.international_pattern(),
		var_normalized.dup(),
	]))
	{
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from_mutated).dup(), this.get_shipping_from_countries(), rt.new_bool(true)]))
			&& rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_to_mutated).dup(), this.get_shipping_to_countries(), rt.new_bool(true)]))))
		{
			return rt.create_array([
				rt.ArrayItem{ key: 'url', val: this.get_tracking_url(var_normalized.str()) },
				rt.ArrayItem{ key: 'ambiguity_score', val: 95 },
			])
		}
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('preg_match', [
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.s10_pattern(),
		var_normalized.dup(),
	]))
	{
		return rt.create_array([
			rt.ArrayItem{ key: 'url', val: this.get_tracking_url(var_normalized.str()) },
			rt.ArrayItem{ key: 'ambiguity_score', val: 90 },
		])
	}
	mut var_validation_result := this.validate_country_pattern(var_normalized.str(),
		shipping_from_mutated)
	if rt.is_true(rt.new_bool(rt.is_true(var_validation_result)
		&& rt.is_true(rt.new_bool(var_validation_result.dup().is_array()))))
	{
		mut var_confidence :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider.tracking_patterns().array_get(shipping_from_mutated).array_get('confidence')
		if rt.is_true(rt.greater(var_validation_result.array_get('confidence_boost'), rt.new_int(0))) {
			var_confidence = rt.call_function('min', [rt.new_int(95),
				var_validation_result.array_get('confidence_boost')])
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_to_mutated).dup(),
			this.get_shipping_to_countries(), rt.new_bool(true)]))
		{
			var_confidence = rt.call_function('min', [rt.new_int(98),
				rt.add(var_confidence, rt.new_int(3))])
		}
		if rt.is_true(rt.identical(rt.new_string('express'),
			var_validation_result.array_get('service')))
		{
			var_confidence = rt.call_function('min', [rt.new_int(98),
				rt.add(var_confidence, rt.new_int(2))])
		}
		return rt.create_array([
			rt.ArrayItem{ key: 'url', val: this.get_tracking_url(var_normalized.str()) },
			rt.ArrayItem{ key: 'ambiguity_score', val: var_confidence },
		])
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\d{12,24}$/'),
		var_normalized.dup()]))
	{
		return rt.create_array([
			rt.ArrayItem{ key: 'url', val: this.get_tracking_url(var_normalized.str()) },
			rt.ArrayItem{ key: 'ambiguity_score', val: 60 },
		])
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_dpdshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_abstractshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_key' {
			return rt.new_string(this.get_key())
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_icon' {
			return rt.new_string(this.get_icon())
		}
		'get_shipping_from_countries' {
			return this.get_shipping_from_countries()
		}
		'get_shipping_to_countries' {
			return this.get_shipping_to_countries()
		}
		'get_tracking_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_tracking_url(dispatch_arg_0))
		}
		'validate_country_pattern' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.validate_country_pattern(dispatch_arg_0, dispatch_arg_1)
		}
		'try_parse_tracking_number' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.try_parse_tracking_number(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DPDShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_providers_dpdshippingprovider_php() {
	// unsupported statement: Stmt_Declare
}
