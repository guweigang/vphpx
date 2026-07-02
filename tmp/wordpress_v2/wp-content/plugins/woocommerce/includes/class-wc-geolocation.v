import rt

pub fn Class_WC_Geolocation.geolite_db() string {
	return 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
}

pub fn Class_WC_Geolocation.geolite_ipv6_db() string {
	return 'http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz'
}

pub fn Class_WC_Geolocation.geolite2_db() string {
	return 'http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz'
}

struct Class_WC_Geolocation {
	rt.PhpObjectBase
}

fn init_static_wc_geolocation() {
	rt.init_static_prop('WC_Geolocation', 'ip_lookup_apis', rt.create_array([
		rt.ArrayItem{ key: 'ipify', val: 'http://api.ipify.org/' },
		rt.ArrayItem{ key: 'ipecho', val: 'http://ipecho.net/plain' },
		rt.ArrayItem{ key: 'ident', val: 'http://ident.me' },
		rt.ArrayItem{ key: 'tnedi', val: 'http://tnedi.me' },
	]))
	rt.init_static_prop('WC_Geolocation', 'geoip_apis', rt.create_array([
		rt.ArrayItem{ key: 'ipinfo.io', val: 'https://ipinfo.io/%s/json' },
		rt.ArrayItem{ key: 'ip-api.com', val: 'http://ip-api.com/json/%s' },
	]))
}

fn Class_WC_Geolocation.is_geolocation_enabled(var_current_settings rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_current_settings.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax()
			},
		]),
		rt.new_bool(true)])
}

fn Class_WC_Geolocation.get_ip_address() string {
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_REAL_IP')) {
		return (rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_REAL_IP')),
			]),
		])).str()
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_FORWARDED_FOR')) {
		mut var_value := rt.new_string(rt.call_function('current', [
			rt.call_function('preg_split', [rt.new_string('/,/'),
				rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_FORWARDED_FOR')),
					]),
				])]),
		]).to_string().trim_space())
		var_value = rt.call_function('preg_replace', [
			rt.new_string('/([0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)\\:.*|\\[([^]]+)\\].*/'),
			rt.new_string('$1$2'),
			var_value.clone(),
		])
		return (rt.call_function('rest_is_ip_address', [var_value.clone()])).str()
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REMOTE_ADDR')) {
		var_value = rt.new_string(rt.call_function('current', [
			rt.call_function('preg_split', [rt.new_string('/,/'),
				rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')),
					]),
				])]),
		]).to_string().trim_space())
		return (rt.call_function('rest_is_ip_address', [var_value.clone()])).str()
	}
	return ''
}

fn Class_WC_Geolocation.get_external_ip_address() rt.PhpVal {
	mut var_external_ip_address := rt.new_string('0.0.0.0')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		Class_WC_Geolocation.get_ip_address()))))
	{
		mut var_transient_name := rt.new_string('external_ip_address_' +
			(Class_WC_Geolocation.get_ip_address()).str())
		var_external_ip_address = rt.call_function('get_transient', [
			var_transient_name.clone()])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_external_ip_address)) {
		var_external_ip_address = rt.new_string('0.0.0.0')
		mut var_ip_lookup_services := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_geolocation_ip_lookup_apis'),
			rt.get_static_prop('WC_Geolocation', 'ip_lookup_apis'),
		])
		mut var_ip_lookup_services_keys := rt.func_array_keys(var_ip_lookup_services.clone())
		rt.call_function('shuffle', [var_ip_lookup_services_keys.clone()])
		mut iter_1 := var_ip_lookup_services_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_service_name := item_1.val
			mut var_service_endpoint := var_ip_lookup_services.array_get(var_service_name)
			mut var_response := rt.call_function('wp_safe_remote_get', [
				var_service_endpoint.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'timeout', val: 2 },
					rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
						(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'version')).str() },
				])])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])))))
				&& rt.is_true(rt.call_function('rest_is_ip_address', [var_response.array_get(rt.new_string('body'))])) {
				var_external_ip_address = rt.call_function('apply_filters', [
					rt.new_string('woocommerce_geolocation_ip_lookup_api_response'),
					rt.call_function('wc_clean', [var_response.array_get(rt.new_string('body'))]),
					var_service_name.clone(),
				])
				break
			}
		}
		rt.call_function('set_transient', [var_transient_name.clone(),
			var_external_ip_address.clone(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return var_external_ip_address.clone()
}

fn Class_WC_Geolocation.geolocate_ip(ip_address string, fallback bool, api_fallback bool) rt.PhpVal {
	mut ip_address_mutated := ip_address
	mut var_country_code := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_geolocate_ip'),
		rt.new_bool(false),
		rt.new_string(ip_address_mutated).clone(),
		rt.new_bool(fallback),
		rt.new_bool(api_fallback),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_country_code)))) {
		return rt.create_array([rt.ArrayItem{ key: 'country', val: var_country_code },
			rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'city', val: '' },
			rt.ArrayItem{ key: 'postcode', val: '' }])
	}
	if ip_address_mutated == '' {
		ip_address_mutated = (Class_WC_Geolocation.get_ip_address()).str()
		var_country_code = Class_WC_Geolocation.get_country_code_from_headers()
	}
	mut var_geolocation := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_geolocation'),
		rt.create_array([
			rt.ArrayItem{
				key: 'country'
				val: if rt.is_true(var_country_code) { var_country_code } else { rt.new_string('') }
			},
			rt.ArrayItem{ key: 'state', val: '' },
			rt.ArrayItem{ key: 'city', val: '' },
			rt.ArrayItem{ key: 'postcode', val: '' },
		]),
		rt.new_string(ip_address_mutated).clone(),
	])
	if rt.is_true(rt.identical(rt.new_string(''), var_geolocation.array_get(rt.new_string('country'))))
		&& var_api_fallback {
		var_geolocation.array_set('country',
			Class_WC_Geolocation.geolocate_via_api(rt.new_string(ip_address_mutated)))
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_geolocation.array_get(rt.new_string('country'))))
		&& var_fallback {
		mut var_external_ip_address := Class_WC_Geolocation.get_external_ip_address()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0.0.0.0'), var_external_ip_address))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_external_ip_address, rt.new_string(ip_address_mutated))))) {
			return Class_WC_Geolocation.geolocate_ip(var_external_ip_address.str(), false,
				api_fallback)
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'country', val: var_geolocation.array_get(rt.new_string('country')) },
		rt.ArrayItem{ key: 'state', val: var_geolocation.array_get(rt.new_string('state')) },
		rt.ArrayItem{ key: 'city', val: var_geolocation.array_get(rt.new_string('city')) },
		rt.ArrayItem{ key: 'postcode', val: var_geolocation.array_get(rt.new_string('postcode')) },
	])
}

fn Class_WC_Geolocation.get_local_database_path(deprecated string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Geolocation::get_local_database_path'),
		rt.new_string('3.9.0'),
	])
	mut var_integration := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}),
		'integrations'), 'get_integration', [rt.new_string('maxmind_geolocation')])
	return rt.call_method(rt.call_method(var_integration, 'get_database_service', []rt.PhpVal{}),
		'get_database_path', []rt.PhpVal{})
}

fn Class_WC_Geolocation.update_database() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Geolocation::update_database'),
		rt.new_string('3.9.0'),
	])
	mut var_integration := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}),
		'integrations'), 'get_integration', [rt.new_string('maxmind_geolocation')])
	rt.call_method(var_integration, 'update_database', []rt.PhpVal{})
}

fn Class_WC_Geolocation.get_country_code_from_headers() rt.PhpVal {
	mut var_country_code := rt.new_string('')
	mut var_headers := ['MM_COUNTRY_CODE', 'GEOIP_COUNTRY_CODE', 'HTTP_CF_IPCOUNTRY',
		'HTTP_X_COUNTRY_CODE']
	for var_header in var_headers {
		if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string(header))) {
			continue
		}
		var_country_code = rt.new_string(rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_SERVER').array_get(rt.new_string(header))]),
		]).to_string().to_upper())
		break
	}
	return var_country_code.clone()
}

fn Class_WC_Geolocation.geolocate_via_api(var_ip_address rt.PhpVal) string {
	mut var_ip_address_mutated := var_ip_address
	mut var_country_code := rt.call_function('get_transient', [
		rt.new_string('geoip_' + var_ip_address_mutated.str()),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_country_code)) {
		mut var_geoip_services := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_geolocation_geoip_apis'),
			rt.get_static_prop('WC_Geolocation', 'geoip_apis'),
		])
		if !rt.is_true(var_geoip_services) {
			return ''
		}
		mut var_geoip_services_keys := rt.func_array_keys(var_geoip_services.clone())
		rt.call_function('shuffle', [var_geoip_services_keys.clone()])
		mut iter_2 := var_geoip_services_keys.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_service_name := item_2.val
			mut var_service_endpoint := var_geoip_services.array_get(var_service_name)
			mut var_response := rt.call_function('wp_safe_remote_get', [
				rt.call_function('sprintf', [var_service_endpoint.clone(),
					var_ip_address_mutated.clone()]),
				rt.create_array([rt.ArrayItem{ key: 'timeout', val: 2 },
					rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
						(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'version')).str() }]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])))))
				&& rt.is_true(var_response.array_get(rt.new_string('body'))) {
				mut switch_val_1 := var_service_name
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('ipinfo.io'))) {
					mut var_data := rt.call_function('json_decode', [
						var_response.array_get(rt.new_string('body')),
					])
					var_country_code = if !(rt.get_property(var_data, 'country')).is_null() {
						rt.get_property(var_data, 'country')
					} else {
						rt.new_string('')
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ip-api.com'))) {
					var_data = rt.call_function('json_decode', [
						var_response.array_get(rt.new_string('body')),
					])
					var_country_code = if !(rt.get_property(var_data, 'countryCode')).is_null() {
						rt.get_property(var_data, 'countryCode')
					} else {
						rt.new_string('')
					}
				} else {
					var_country_code = rt.call_function('apply_filters', [
						rt.new_string('woocommerce_geolocation_geoip_response_' +
							var_service_name.str()),
						rt.new_string(''),
						var_response.array_get(rt.new_string('body')),
					])
				}
				var_country_code = rt.call_function('sanitize_text_field', [
					rt.new_string(var_country_code.clone().to_string().to_upper()),
				])
				if rt.is_true(var_country_code) {
					break
				}
			}
		}
		rt.call_function('set_transient', [
			rt.new_string('geoip_' + var_ip_address_mutated.str()),
			var_country_code.clone(),
			rt.get_constant('DAY_IN_SECONDS'),
		])
	}
	return var_country_code.str()
}

fn Class_WC_Geolocation.init() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Geolocation::init'),
		rt.new_string('3.9.0')])
	return rt.new_null()
}

fn Class_WC_Geolocation.disable_geolocation_on_legacy_php(var_default_customer_address rt.PhpVal) rt.PhpVal {
	mut var_default_customer_address_mutated := var_default_customer_address
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Geolocation::disable_geolocation_on_legacy_php'),
		rt.new_string('3.9.0'),
	])
	if rt.is_true(Class_WC_Geolocation.is_geolocation_enabled(var_default_customer_address_mutated.clone())) {
		var_default_customer_address_mutated =
			Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base()
	}
	return var_default_customer_address_mutated.clone()
}

fn Class_WC_Geolocation.maybe_update_database(var_new_value rt.PhpVal, var_old_value rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Geolocation::maybe_update_database'),
		rt.new_string('3.9.0'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_value, var_old_value))))
		&& rt.is_true(Class_WC_Geolocation.is_geolocation_enabled(var_new_value.clone())) {
		Class_WC_Geolocation.update_database()
	}
	return var_new_value.clone()
}

fn create_wc_geolocation(_args ...rt.PhpVal) &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_geolocation_enabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Geolocation.is_geolocation_enabled(dispatch_arg_0)
		}
		'get_ip_address' {
			return rt.new_string(Class_WC_Geolocation.get_ip_address())
		}
		'get_external_ip_address' {
			return Class_WC_Geolocation.get_external_ip_address()
		}
		'geolocate_ip' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_WC_Geolocation.geolocate_ip(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_local_database_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_Geolocation.get_local_database_path(dispatch_arg_0)
		}
		'update_database' {
			Class_WC_Geolocation.update_database()
			return rt.new_null()
		}
		'get_country_code_from_headers' {
			return Class_WC_Geolocation.get_country_code_from_headers()
		}
		'geolocate_via_api' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Geolocation.geolocate_via_api(dispatch_arg_0))
		}
		'init' {
			return Class_WC_Geolocation.init()
		}
		'disable_geolocation_on_legacy_php' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Geolocation.disable_geolocation_on_legacy_php(dispatch_arg_0)
		}
		'maybe_update_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Geolocation.maybe_update_database(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
