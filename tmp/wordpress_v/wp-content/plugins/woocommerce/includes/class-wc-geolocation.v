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
pub mut:
		ip_lookup_apis rt.PhpVal = rt.new_array()
		geoip_apis rt.PhpVal = rt.new_array()
}

fn Class_WC_Geolocation.is_geolocation_enabled(var_current_settings rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_current_settings.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax() }]), rt.new_bool(true)])
}

fn Class_WC_Geolocation.get_ip_address() string {
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_REAL_IP')) {
		return (rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_X_REAL_IP')])])).str()
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_FORWARDED_FOR')) {
		mut var_value := rt.new_string(rt.new_string(rt.call_function('current', [rt.call_function('preg_split', [rt.new_string('/,/'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_X_FORWARDED_FOR')])])])]).to_string().trim_space()))
		var_value = rt.call_function('preg_replace', [rt.new_string('/([0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)\\:.*|\\[([^]]+)\\].*/'), rt.new_string('$1$2'), var_value.dup()])
		return (// unsupported expression: Expr_Cast_String).str()
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REMOTE_ADDR')) {
		var_value = rt.new_string(rt.new_string(rt.call_function('current', [rt.call_function('preg_split', [rt.new_string('/,/'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR')])])])]).to_string().trim_space()))
		return (// unsupported expression: Expr_Cast_String).str()
	}
	return ''
}

fn Class_WC_Geolocation.get_external_ip_address() rt.PhpVal {
	mut var_external_ip_address := rt.new_string(rt.new_string('0.0.0.0'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_transient_name := rt.new_string('external_ip_address_' + (Class_WC_Geolocation.get_ip_address()).str())
		var_external_ip_address = rt.call_function('get_transient', [var_transient_name.dup()])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_external_ip_address)) {
		var_external_ip_address = rt.new_string(rt.new_string('0.0.0.0'))
		mut var_ip_lookup_services := rt.call_function('apply_filters', [rt.new_string('woocommerce_geolocation_ip_lookup_apis'), // unsupported expression: Expr_StaticPropertyFetch])
		mut var_ip_lookup_services_keys := rt.func_array_keys(var_ip_lookup_services.dup())
		rt.call_function('shuffle', [var_ip_lookup_services_keys.dup()])
		{
			mut iter_1 := var_ip_lookup_services_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_service_name := item_1.val
				mut var_service_endpoint := var_ip_lookup_services.array_get(var_service_name)
				mut var_response := rt.call_function('wp_safe_remote_get', [var_service_endpoint.dup(), rt.create_array([rt.ArrayItem{ key: 'timeout', val: 2 }, rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' + (rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'version')).str() }])])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()]))))) && rt.is_true(rt.call_function('rest_is_ip_address', [var_response.array_get('body')])))) {
					var_external_ip_address = rt.call_function('apply_filters', [rt.new_string('woocommerce_geolocation_ip_lookup_api_response'), rt.call_function('wc_clean', [var_response.array_get('body')]), var_service_name.dup()])
					break
				}
			}
		}
		rt.call_function('set_transient', [var_transient_name.dup(), var_external_ip_address.dup(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return var_external_ip_address.dup()
}

fn Class_WC_Geolocation.geolocate_ip(ip_address string, fallback bool, api_fallback bool) rt.PhpVal {
	mut ip_address_mutated := ip_address
	mut var_country_code := rt.call_function('apply_filters', [rt.new_string('woocommerce_geolocate_ip'), rt.new_bool(false), rt.new_string(ip_address_mutated).dup(), rt.new_bool(fallback), rt.new_bool(api_fallback)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.create_array([rt.ArrayItem{ key: 'country', val: var_country_code }, rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'city', val: '' }, rt.ArrayItem{ key: 'postcode', val: '' }])
	}
	if ip_address_mutated == '' {
		ip_address_mutated = (Class_WC_Geolocation.get_ip_address()).str()
		var_country_code = Class_WC_Geolocation.get_country_code_from_headers()
	}
	mut var_geolocation := rt.call_function('apply_filters', [rt.new_string('woocommerce_get_geolocation'), rt.create_array([rt.ArrayItem{ key: 'country', val: if rt.is_true(var_country_code) { var_country_code } else { rt.new_string('') } }, rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'city', val: '' }, rt.ArrayItem{ key: 'postcode', val: '' }]), rt.new_string(ip_address_mutated).dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_geolocation.array_get('country'))) && var_api_fallback)) {
		var_geolocation.array_set('country', Class_WC_Geolocation.geolocate_via_api(rt.new_string(ip_address_mutated)))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_geolocation.array_get('country'))) && var_fallback)) {
		mut var_external_ip_address := Class_WC_Geolocation.get_external_ip_address()
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return Class_WC_Geolocation.geolocate_ip((var_external_ip_address).str(), false, api_fallback)
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'country', val: var_geolocation.array_get('country') }, rt.ArrayItem{ key: 'state', val: var_geolocation.array_get('state') }, rt.ArrayItem{ key: 'city', val: var_geolocation.array_get('city') }, rt.ArrayItem{ key: 'postcode', val: var_geolocation.array_get('postcode') }])
}

fn Class_WC_Geolocation.get_local_database_path(deprecated string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Geolocation::get_local_database_path'), rt.new_string('3.9.0')])
	mut var_integration := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'integrations'), 'get_integration', [rt.new_string('maxmind_geolocation')])
	return rt.call_method(rt.call_method(var_integration, 'get_database_service', []rt.PhpVal{}), 'get_database_path', []rt.PhpVal{})
}

fn Class_WC_Geolocation.update_database()  {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Geolocation::update_database'), rt.new_string('3.9.0')])
	mut var_integration := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'integrations'), 'get_integration', [rt.new_string('maxmind_geolocation')])
	rt.call_method(var_integration, 'update_database', []rt.PhpVal{})
}

fn Class_WC_Geolocation.get_country_code_from_headers() rt.PhpVal {
	mut var_country_code := rt.new_string(rt.new_string(''))
	mut var_headers := ['MM_COUNTRY_CODE', 'GEOIP_COUNTRY_CODE', 'HTTP_CF_IPCOUNTRY', 'HTTP_X_COUNTRY_CODE']
	for var_header in var_headers {
		if !rt.is_true(rt.get_superglobal('_SERVER').array_get(header)) {
			continue
		}
		var_country_code = rt.new_string(rt.new_string(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(header)])]).to_string().to_upper()))
		break
	}
	return var_country_code.dup()
}

fn Class_WC_Geolocation.geolocate_via_api(var_ip_address rt.PhpVal) string {
	mut var_ip_address_mutated := var_ip_address
	mut var_country_code := rt.call_function('get_transient', ['geoip_' + (var_ip_address_mutated).str()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_country_code)) {
		mut var_geoip_services := rt.call_function('apply_filters', [rt.new_string('woocommerce_geolocation_geoip_apis'), // unsupported expression: Expr_StaticPropertyFetch])
		if !rt.is_true(var_geoip_services) {
			return ''
		}
		mut var_geoip_services_keys := rt.func_array_keys(var_geoip_services.dup())
		rt.call_function('shuffle', [var_geoip_services_keys.dup()])
		{
			mut iter_1 := var_geoip_services_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_service_name := item_1.val
				mut var_service_endpoint := var_geoip_services.array_get(var_service_name)
				mut var_response := rt.call_function('wp_safe_remote_get', [rt.call_function('sprintf', [var_service_endpoint.dup(), var_ip_address_mutated.dup()]), rt.create_array([rt.ArrayItem{ key: 'timeout', val: 2 }, rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' + (rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'version')).str() }])])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()]))))) && rt.is_true(var_response.array_get('body')))) {
					mut switch_val_1 := var_service_name
					if rt.is_true(rt.equal(switch_val_1, rt.new_string('ipinfo.io'))) {
						mut var_data := rt.call_function('json_decode', [var_response.array_get('body')])
						var_country_code = if !(rt.get_property(var_data, 'country')).is_null() { rt.get_property(var_data, 'country') } else { rt.new_string('') }
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ip-api.com'))) {
						var_data = rt.call_function('json_decode', [var_response.array_get('body')])
						var_country_code = if !(rt.get_property(var_data, 'countryCode')).is_null() { rt.get_property(var_data, 'countryCode') } else { rt.new_string('') }
					} else {
						var_country_code = rt.call_function('apply_filters', ['woocommerce_geolocation_geoip_response_' + (var_service_name).str(), rt.new_string(''), var_response.array_get('body')])
					}
					var_country_code = rt.call_function('sanitize_text_field', [rt.new_string(var_country_code.dup().to_string().to_upper())])
					if rt.is_true(var_country_code) {
						break
					}
				}
			}
		}
		rt.call_function('set_transient', ['geoip_' + (var_ip_address_mutated).str(), var_country_code.dup(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return (var_country_code).str()
}

fn Class_WC_Geolocation.init() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Geolocation::init'), rt.new_string('3.9.0')])
	return rt.new_null()
}

fn Class_WC_Geolocation.disable_geolocation_on_legacy_php(var_default_customer_address rt.PhpVal) rt.PhpVal {
	mut var_default_customer_address_mutated := var_default_customer_address
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Geolocation::disable_geolocation_on_legacy_php'), rt.new_string('3.9.0')])
	if rt.is_true(Class_WC_Geolocation.is_geolocation_enabled(var_default_customer_address_mutated.dup())) {
		var_default_customer_address_mutated = Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base()
	}
	return var_default_customer_address_mutated.dup()
}

fn Class_WC_Geolocation.maybe_update_database(var_new_value rt.PhpVal, var_old_value rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Geolocation::maybe_update_database'), rt.new_string('3.9.0')])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(Class_WC_Geolocation.is_geolocation_enabled(var_new_value.dup())))) {
		Class_WC_Geolocation.update_database()
	}
	return var_new_value.dup()
}

fn create_wc_geolocation() &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
		ip_lookup_apis: rt.new_array()
		geoip_apis: rt.new_array()
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
		else { return none }
	}
}

fn (this &Class_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ip_lookup_apis' { return this.ip_lookup_apis }
		'geoip_apis' { return this.geoip_apis }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ip_lookup_apis' { this.ip_lookup_apis = val; return true }
		'geoip_apis' { this.geoip_apis = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_geolocation_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
