import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider.main_patterns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '/^\\d{16}$/' },
		rt.ArrayItem{ key: none, val: '/^[A-Z]{1,2}\\d{14,15}$/' },
		rt.ArrayItem{ key: none, val: '/^MH\\d{16}$/' }, rt.ArrayItem{
			key: none
			val: '/^(?:[A-Z]\\d{2}[A-Z0-9]{13}|\\d{16})$/'
		}])
}

pub fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider.calling_card_pattern() string {
	return '/^\\d{8}$/'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider.legacy_patterns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '/^\\d{13,15}$/' }])
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) get_key() string {
	return 'evri-hermes'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) get_name() string {
	return 'Evri (Hermes)'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) get_icon() string {
	return
		(rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() +
		'/assets/images/shipping_providers/evri-hermes.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) get_shipping_from_countries() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'GB' }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) get_shipping_to_countries() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'GB' },
		rt.ArrayItem{ key: none, val: 'AL' }, rt.ArrayItem{ key: none, val: 'DZ' },
		rt.ArrayItem{ key: none, val: 'AS' }, rt.ArrayItem{ key: none, val: 'AD' },
		rt.ArrayItem{ key: none, val: 'AO' }, rt.ArrayItem{ key: none, val: 'AI' },
		rt.ArrayItem{ key: none, val: 'AG' }, rt.ArrayItem{ key: none, val: 'AR' },
		rt.ArrayItem{ key: none, val: 'AM' }, rt.ArrayItem{ key: none, val: 'AW' },
		rt.ArrayItem{ key: none, val: 'AU' }, rt.ArrayItem{ key: none, val: 'AT' },
		rt.ArrayItem{ key: none, val: 'AZ' }, rt.ArrayItem{ key: none, val: 'PT' },
		rt.ArrayItem{ key: none, val: 'BS' }, rt.ArrayItem{ key: none, val: 'BH' },
		rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'BD' },
		rt.ArrayItem{ key: none, val: 'BB' }, rt.ArrayItem{ key: none, val: 'BE' },
		rt.ArrayItem{ key: none, val: 'BZ' }, rt.ArrayItem{ key: none, val: 'BJ' },
		rt.ArrayItem{ key: none, val: 'BM' }, rt.ArrayItem{ key: none, val: 'BT' },
		rt.ArrayItem{ key: none, val: 'BO' }, rt.ArrayItem{ key: none, val: 'BQ' },
		rt.ArrayItem{ key: none, val: 'BA' }, rt.ArrayItem{ key: none, val: 'BA' },
		rt.ArrayItem{ key: none, val: 'BW' }, rt.ArrayItem{ key: none, val: 'BR' },
		rt.ArrayItem{ key: none, val: 'VG' }, rt.ArrayItem{ key: none, val: 'BN' },
		rt.ArrayItem{ key: none, val: 'BG' }, rt.ArrayItem{ key: none, val: 'BF' },
		rt.ArrayItem{ key: none, val: 'BI' }, rt.ArrayItem{ key: none, val: 'KH' },
		rt.ArrayItem{ key: none, val: 'CM' }, rt.ArrayItem{ key: none, val: 'CA' },
		rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'CV' },
		rt.ArrayItem{ key: none, val: 'KY' }, rt.ArrayItem{ key: none, val: 'CF' },
		rt.ArrayItem{ key: none, val: 'TD' }, rt.ArrayItem{ key: none, val: 'JE' },
		rt.ArrayItem{ key: none, val: 'CL' }, rt.ArrayItem{ key: none, val: 'CN' },
		rt.ArrayItem{ key: none, val: 'CO' }, rt.ArrayItem{ key: none, val: 'KM' },
		rt.ArrayItem{ key: none, val: 'CG' }, rt.ArrayItem{ key: none, val: 'CK' },
		rt.ArrayItem{ key: none, val: 'CR' }, rt.ArrayItem{ key: none, val: 'GR' },
		rt.ArrayItem{ key: none, val: 'HR' }, rt.ArrayItem{ key: none, val: 'CW' },
		rt.ArrayItem{ key: none, val: 'CY' }, rt.ArrayItem{ key: none, val: 'CZ' },
		rt.ArrayItem{ key: none, val: 'CD' }, rt.ArrayItem{ key: none, val: 'DK' },
		rt.ArrayItem{ key: none, val: 'DJ' }, rt.ArrayItem{ key: none, val: 'DM' },
		rt.ArrayItem{ key: none, val: 'DO' }, rt.ArrayItem{ key: none, val: 'TL' },
		rt.ArrayItem{ key: none, val: 'EC' }, rt.ArrayItem{ key: none, val: 'EG' },
		rt.ArrayItem{ key: none, val: 'SV' }, rt.ArrayItem{ key: none, val: 'GQ' },
		rt.ArrayItem{ key: none, val: 'ER' }, rt.ArrayItem{ key: none, val: 'EE' },
		rt.ArrayItem{ key: none, val: 'SZ' }, rt.ArrayItem{ key: none, val: 'ET' },
		rt.ArrayItem{ key: none, val: 'FK' }, rt.ArrayItem{ key: none, val: 'FO' },
		rt.ArrayItem{ key: none, val: 'FJ' }, rt.ArrayItem{ key: none, val: 'FI' },
		rt.ArrayItem{ key: none, val: 'FR' }, rt.ArrayItem{ key: none, val: 'GF' },
		rt.ArrayItem{ key: none, val: 'PF' }, rt.ArrayItem{ key: none, val: 'GA' },
		rt.ArrayItem{ key: none, val: 'GM' }, rt.ArrayItem{ key: none, val: 'GE' },
		rt.ArrayItem{ key: none, val: 'DE' }, rt.ArrayItem{ key: none, val: 'GI' },
		rt.ArrayItem{ key: none, val: 'GR' }, rt.ArrayItem{ key: none, val: 'GL' },
		rt.ArrayItem{ key: none, val: 'GD' }, rt.ArrayItem{ key: none, val: 'GP' },
		rt.ArrayItem{ key: none, val: 'GU' }, rt.ArrayItem{ key: none, val: 'GT' },
		rt.ArrayItem{ key: none, val: 'GG' }, rt.ArrayItem{ key: none, val: 'GN' },
		rt.ArrayItem{ key: none, val: 'GW' }, rt.ArrayItem{ key: none, val: 'GY' },
		rt.ArrayItem{ key: none, val: 'HT' }, rt.ArrayItem{ key: none, val: 'HN' },
		rt.ArrayItem{ key: none, val: 'HK' }, rt.ArrayItem{ key: none, val: 'HU' },
		rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'IS' },
		rt.ArrayItem{ key: none, val: 'IN' }, rt.ArrayItem{ key: none, val: 'ID' },
		rt.ArrayItem{ key: none, val: 'IQ' }, rt.ArrayItem{ key: none, val: 'IE' },
		rt.ArrayItem{ key: none, val: 'IL' }, rt.ArrayItem{ key: none, val: 'IT' },
		rt.ArrayItem{ key: none, val: 'JM' }, rt.ArrayItem{ key: none, val: 'JP' },
		rt.ArrayItem{ key: none, val: 'JE' }, rt.ArrayItem{ key: none, val: 'JO' },
		rt.ArrayItem{ key: none, val: 'KZ' }, rt.ArrayItem{ key: none, val: 'KE' },
		rt.ArrayItem{ key: none, val: 'KI' }, rt.ArrayItem{ key: none, val: 'KW' },
		rt.ArrayItem{ key: none, val: 'LA' }, rt.ArrayItem{ key: none, val: 'LV' },
		rt.ArrayItem{ key: none, val: 'LB' }, rt.ArrayItem{ key: none, val: 'LS' },
		rt.ArrayItem{ key: none, val: 'LR' }, rt.ArrayItem{ key: none, val: 'LY' },
		rt.ArrayItem{ key: none, val: 'LI' }, rt.ArrayItem{ key: none, val: 'LT' },
		rt.ArrayItem{ key: none, val: 'LU' }, rt.ArrayItem{ key: none, val: 'MO' },
		rt.ArrayItem{ key: none, val: 'MG' }, rt.ArrayItem{ key: none, val: 'ES' },
		rt.ArrayItem{ key: none, val: 'MW' }, rt.ArrayItem{ key: none, val: 'MY' },
		rt.ArrayItem{ key: none, val: 'MV' }, rt.ArrayItem{ key: none, val: 'ML' },
		rt.ArrayItem{ key: none, val: 'MT' }, rt.ArrayItem{ key: none, val: 'MH' },
		rt.ArrayItem{ key: none, val: 'MQ' }, rt.ArrayItem{ key: none, val: 'MR' },
		rt.ArrayItem{ key: none, val: 'MU' }, rt.ArrayItem{ key: none, val: 'YT' },
		rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'MX' },
		rt.ArrayItem{ key: none, val: 'FM' }, rt.ArrayItem{ key: none, val: 'MD' },
		rt.ArrayItem{ key: none, val: 'MC' }, rt.ArrayItem{ key: none, val: 'MN' },
		rt.ArrayItem{ key: none, val: 'ME' }, rt.ArrayItem{ key: none, val: 'MS' },
		rt.ArrayItem{ key: none, val: 'MA' }, rt.ArrayItem{ key: none, val: 'MZ' },
		rt.ArrayItem{ key: none, val: 'NA' }, rt.ArrayItem{ key: none, val: 'NR' },
		rt.ArrayItem{ key: none, val: 'NP' }, rt.ArrayItem{ key: none, val: 'NL' },
		rt.ArrayItem{ key: none, val: 'AN' }, rt.ArrayItem{ key: none, val: 'NC' },
		rt.ArrayItem{ key: none, val: 'NZ' }, rt.ArrayItem{ key: none, val: 'NI' },
		rt.ArrayItem{ key: none, val: 'NE' }, rt.ArrayItem{ key: none, val: 'MK' },
		rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'NO' },
		rt.ArrayItem{ key: none, val: 'OM' }, rt.ArrayItem{ key: none, val: 'PK' },
		rt.ArrayItem{ key: none, val: 'PW' }, rt.ArrayItem{ key: none, val: 'PS' },
		rt.ArrayItem{ key: none, val: 'PA' }, rt.ArrayItem{ key: none, val: 'PG' },
		rt.ArrayItem{ key: none, val: 'PY' }, rt.ArrayItem{ key: none, val: 'PE' },
		rt.ArrayItem{ key: none, val: 'PH' }, rt.ArrayItem{ key: none, val: 'PL' },
		rt.ArrayItem{ key: none, val: 'PT' }, rt.ArrayItem{ key: none, val: 'PR' },
		rt.ArrayItem{ key: none, val: 'QA' }, rt.ArrayItem{ key: none, val: 'RE' },
		rt.ArrayItem{ key: none, val: 'RO' }, rt.ArrayItem{ key: none, val: 'RW' },
		rt.ArrayItem{ key: none, val: 'MP' }, rt.ArrayItem{ key: none, val: 'WS' },
		rt.ArrayItem{ key: none, val: 'SM' }, rt.ArrayItem{ key: none, val: 'SA' },
		rt.ArrayItem{ key: none, val: 'SN' }, rt.ArrayItem{ key: none, val: 'RS' },
		rt.ArrayItem{ key: none, val: 'SC' }, rt.ArrayItem{ key: none, val: 'SL' },
		rt.ArrayItem{ key: none, val: 'SG' }, rt.ArrayItem{ key: none, val: 'SK' },
		rt.ArrayItem{ key: none, val: 'SI' }, rt.ArrayItem{ key: none, val: 'SB' },
		rt.ArrayItem{ key: none, val: 'KR' }, rt.ArrayItem{ key: none, val: 'ES' },
		rt.ArrayItem{ key: none, val: 'LK' }, rt.ArrayItem{ key: none, val: 'BL' },
		rt.ArrayItem{ key: none, val: 'BQ' }, rt.ArrayItem{ key: none, val: 'KN' },
		rt.ArrayItem{ key: none, val: 'LC' }, rt.ArrayItem{ key: none, val: 'SX' },
		rt.ArrayItem{ key: none, val: 'VC' }, rt.ArrayItem{ key: none, val: 'SR' },
		rt.ArrayItem{ key: none, val: 'SE' }, rt.ArrayItem{ key: none, val: 'CH' },
		rt.ArrayItem{ key: none, val: 'TW' }, rt.ArrayItem{ key: none, val: 'TJ' },
		rt.ArrayItem{ key: none, val: 'TZ' }, rt.ArrayItem{ key: none, val: 'TH' },
		rt.ArrayItem{ key: none, val: 'TG' }, rt.ArrayItem{ key: none, val: 'TO' },
		rt.ArrayItem{ key: none, val: 'TT' }, rt.ArrayItem{ key: none, val: 'TN' },
		rt.ArrayItem{ key: none, val: 'TR' }, rt.ArrayItem{ key: none, val: 'TM' },
		rt.ArrayItem{ key: none, val: 'TC' }, rt.ArrayItem{ key: none, val: 'TV' },
		rt.ArrayItem{ key: none, val: 'UG' }, rt.ArrayItem{ key: none, val: 'GB' },
		rt.ArrayItem{ key: none, val: 'UA' }, rt.ArrayItem{ key: none, val: 'AE' },
		rt.ArrayItem{ key: none, val: 'UY' }, rt.ArrayItem{ key: none, val: 'US' },
		rt.ArrayItem{ key: none, val: 'UZ' }, rt.ArrayItem{ key: none, val: 'VU' },
		rt.ArrayItem{ key: none, val: 'VA' }, rt.ArrayItem{ key: none, val: 'VN' },
		rt.ArrayItem{ key: none, val: 'VI' }, rt.ArrayItem{ key: none, val: 'WF' },
		rt.ArrayItem{ key: none, val: 'YE' }, rt.ArrayItem{ key: none, val: 'ZM' },
		rt.ArrayItem{ key: none, val: 'ZW' }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) get_tracking_url(tracking_number string) string {
	return 'https://www.evri.com/track/' +
		(rt.call_function('rawurlencode', [rt.new_string(tracking_number)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	if tracking_number == '' || shipping_from == '' || shipping_to == '' {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.can_ship_from_to(rt.new_string(shipping_from),
		rt.new_string(shipping_to))))))
	{
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
	{
		mut iter_1 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider.main_patterns().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(),
				var_normalized.dup()]))
			{
				mut var_confidence := rt.new_int(rt.new_int(90))
				if rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(shipping_from))) {
					var_confidence = rt.call_function('min', [
						rt.new_int(98), rt.add(var_confidence, rt.new_int(2))])
				}
				return rt.create_array([
					rt.ArrayItem{ key: 'url', val: this.get_tracking_url(var_normalized.str()) },
					rt.ArrayItem{ key: 'ambiguity_score', val: var_confidence },
				])
			}
		}
	}
	if rt.is_true(rt.call_function('preg_match', [
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider.calling_card_pattern(),
		var_normalized.dup(),
	]))
	{
		return rt.create_array([
			rt.ArrayItem{ key: 'url', val: this.get_tracking_url(var_normalized.str()) },
			rt.ArrayItem{ key: 'ambiguity_score', val: 80 },
		])
	}
	{
		mut iter_1 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider.legacy_patterns().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(),
				var_normalized.dup()]))
			{
				mut var_confidence := rt.new_int(rt.new_int(75))
				if rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(shipping_from))) {
					var_confidence = rt.call_function('min', [
						rt.new_int(95), rt.add(var_confidence, rt.new_int(15))])
				}
				return rt.create_array([
					rt.ArrayItem{ key: 'url', val: this.get_tracking_url(var_normalized.str()) },
					rt.ArrayItem{ key: 'ambiguity_score', val: var_confidence },
				])
			}
		}
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_evrihermesshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_EvriHermesShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_providers_evrihermesshippingprovider_php() {
	// unsupported statement: Stmt_Declare
}
