import rt

struct Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider {
	rt.PhpObjectBase
pub mut:
	jwt rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) construct() {
	rt.call_function('add_filter', [
		rt.new_string('pre_update_option_woocommerce_address_autocomplete_enabled'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', [
				'WC_Address_Provider',
			], &this) },
			rt.ArrayItem{ key: none, val: 'refresh_cache' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', [
				'WC_Address_Provider',
			], &this) },
			rt.ArrayItem{ key: none, val: 'load_scripts' },
		])])
	this.dispatch_set_prop('branding_html',
		'Powered by&nbsp;<img style="height: 15px; width: 45px; margin-bottom: -2px;" src="' +
		(rt.call_function('plugins_url', [rt.new_string('/assets/images/address-autocomplete/google.svg'), rt.get_constant('WC_PLUGIN_FILE')])).str() +
		'" alt="Google logo" />')
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_address_service_jwt() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) can_telemetry() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) load_jwt() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_string_to_bool', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_address_autocomplete_enabled'),
			rt.new_string('no'),
		]),
	]), rt.new_bool(true)))))
	{
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_0 := iife_temp_0.shallow_validate(this.jwt)
	if rt.is_true(this.jwt) && this.jwt.is_string() && rt.is_true(iife_result_0) {
		return
	}
	mut var_cached_jwt := this.get_cached_option(rt.new_string('address_autocomplete_jwt'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_1 := iife_temp_1.shallow_validate(var_cached_jwt.clone())
	if rt.is_true(var_cached_jwt) && var_cached_jwt.clone().is_string() && rt.is_true(iife_result_1) {
		this.jwt = var_cached_jwt.clone()
		return
	}
	mut var_retry_data := this.get_cached_option(rt.new_string('jwt_retry_data'))
	if rt.is_true(var_retry_data) && var_retry_data.array_isset(rt.new_string('try_after'))
		&& rt.is_true(rt.greater(var_retry_data.array_get(rt.new_string('try_after')), rt.call_function('time', []rt.PhpVal{}))) {
		return
	}
	mut var_fresh_jwt := this.get_address_service_jwt()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_2 := iife_temp_2.shallow_validate(var_fresh_jwt.clone())
	if rt.is_true(var_fresh_jwt) && var_fresh_jwt.clone().is_string() && rt.is_true(iife_result_2) {
		this.set_jwt(var_fresh_jwt.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		this.delete_cached_option(rt.new_string('jwt_retry_data'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		return
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_Exception',
			[]string{},
			create_automattic_woocommerce_internal_addressprovider_exception(rt.new_string('Invalid JWT received from address service.'))))
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
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_AddressProvider_Exception') {
		mut var_e := var_e_1.clone()
		var_retry_data.array_set('attempts', if var_retry_data.array_isset(rt.new_string('attempts')) {
			rt.add(var_retry_data.array_get(rt.new_string('attempts')), rt.new_int(1))
		} else {
			rt.new_int(1)
		})
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.call_function('sprintf', [
				rt.new_string('Failed loading JWT for %1$s address autocomplete service (attempt %2$d) with error %3$s.'),
				rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', [
					'WC_Address_Provider',
				], &this), 'name'),
				var_retry_data.array_get(rt.new_string('attempts')),
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			]),
			rt.new_string('address-autocomplete'),
		])
		mut var_backoff_hours := rt.call_function('pow', [rt.new_int(2),
			rt.sub(var_retry_data.array_get(rt.new_string('attempts')), rt.new_int(1))])
		var_retry_data.array_set('try_after', rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(var_backoff_hours,
			rt.get_constant('HOUR_IN_SECONDS'))))
		this.update_cached_option(rt.new_string('jwt_retry_data'), var_retry_data.clone(),
			rt.get_constant('DAY_IN_SECONDS'))
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
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_jwt() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.jwt)) {
		this.load_jwt()
	}
	return this.jwt
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) set_jwt(var_jwt rt.PhpVal) {
	this.jwt = var_jwt.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_jwt)))) {
		mut var_cache_duration := this.get_jwt_cache_duration(var_jwt.clone())
		if rt.is_true(rt.identical(rt.new_int(0), var_cache_duration)) {
			this.jwt = rt.new_null()
			this.load_jwt()
			return
		}
		this.update_cached_option(rt.new_string('address_autocomplete_jwt'), var_jwt.clone(),
			var_cache_duration.clone())
	} else {
		this.delete_cached_option(rt.new_string('address_autocomplete_jwt'))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_jwt_cache_duration(var_jwt rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}
	mut iife_result_3 := iife_temp_3.get_parts(var_jwt.clone())
	mut var_parts := iife_result_3
	if rt.is_true(rt.call_function('property_exists', [
		rt.get_property(var_parts, 'payload'),
		rt.new_string('exp'),
	]))
	{
		return rt.call_function('max', [
			rt.sub(rt.get_property(rt.get_property(var_parts, 'payload'), 'exp'), rt.call_function('time',
				[]rt.PhpVal{})),
			rt.new_int(0),
		])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) refresh_cache(var_setting rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('wc_string_to_bool', [var_setting.clone()])) {
		this.load_jwt()
	} else {
		this.set_jwt(rt.new_null())
	}
	return var_setting.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_cached_option(var_key rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_function('get_option', [
		rt.new_string(
			(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() +
			'_' + var_key.str()),
	])
	if var_data.clone().is_array() && var_data.array_isset(rt.new_string('data')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.is_expired(var_data.clone()))))) {
			return var_data.array_get(rt.new_string('data'))
		}
		this.delete_cached_option(var_key.clone())
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) update_cached_option(var_key rt.PhpVal, var_value rt.PhpVal, var_ttl rt.PhpVal) {
	mut var_result := rt.call_function('update_option', [
		rt.new_string(
			(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() +
			'_' + var_key.str()),
		rt.create_array([
			rt.ArrayItem{ key: 'data', val: var_value },
			rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'ttl', val: var_ttl },
		]),
		rt.new_bool(false),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.call_function('wp_cache_delete', [
			rt.new_string(
				(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() +
				'_' + var_key.str()),
			rt.new_string('options'),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) delete_cached_option(var_key rt.PhpVal) {
	if rt.is_true(rt.call_function('delete_option', [
		rt.new_string(
			(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() +
			'_' + var_key.str()),
	]))
	{
		rt.call_function('wp_cache_delete', [
			rt.new_string(
				(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() +
				'_' + var_key.str()),
			rt.new_string('options'),
		])
	}
}

fn Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.is_expired(var_cache_contents rt.PhpVal) bool {
	if !(var_cache_contents.clone().is_array())
		|| !(var_cache_contents.array_isset(rt.new_string('updated')))
		|| !(var_cache_contents.array_isset(rt.new_string('ttl'))) {
		return true
	}
	if !(var_cache_contents.array_get(rt.new_string('updated')).is_long())
		|| !(var_cache_contents.array_get(rt.new_string('ttl')).is_long()) {
		return true
	}
	mut var_expires := rt.add(var_cache_contents.array_get(rt.new_string('updated')),
		var_cache_contents.array_get(rt.new_string('ttl')))
	mut var_now := rt.call_function('time', []rt.PhpVal{})
	return (rt.less(var_expires, var_now)).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.get_asset_url(var_path rt.PhpVal) rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.get_constant(rt.new_string('WC_PLUGIN_FILE'))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_asset_url'),
		rt.call_function('plugins_url', [var_path.clone(), iife_result_4]),
		var_path.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) load_scripts() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_string_to_bool', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_address_autocomplete_enabled'),
			rt.new_string('no'),
		]),
	]), rt.new_bool(true)))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_jwt())))) {
		return
	}
	mut iife_temp_5 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_5 := iife_temp_5.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_5) { '' } else { '.min' }).str())
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_6
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
		rt.new_string('a8c-address-autocomplete-service'),
		rt.new_string('registered'),
	])))))
	{
		rt.call_function('wp_register_script', [
			rt.new_string('a8c-address-autocomplete-service'),
			Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.get_asset_url(rt.new_string(
				'assets/js/frontend/a8c-address-autocomplete-service' + var_suffix.str() + '.js')),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wc-address-autocomplete' }]),
			var_version.clone(),
			rt.create_array([rt.ArrayItem{ key: 'strategy', val: 'defer' }]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
		rt.new_string('a8c-address-autocomplete-service'),
		rt.new_string('enqueued'),
	])))))
	{
		rt.call_function('wp_enqueue_script', [
			rt.new_string('a8c-address-autocomplete-service'),
		])
	}
	rt.call_function('wp_add_inline_script', [
		rt.new_string('a8c-address-autocomplete-service'),
		rt.call_function('sprintf', [
			rt.new_string('var a8cAddressAutocompleteServiceKeys = a8cAddressAutocompleteServiceKeys || {}; a8cAddressAutocompleteServiceKeys[ %1$s ] = { key: %2$s, canTelemetry: %3$s };'),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', [
					'WC_Address_Provider',
				], &this), 'id'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				this.get_jwt(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
			rt.call_function('wp_json_encode', [
				rt.new_bool(
					rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this.can_telemetry()))))
					&& rt.is_true(this.can_telemetry())),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		]),
		rt.new_string('before'),
	])
}

struct Class_WC_Address_Provider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_AddressProvider_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_addressprovider_abstractautomatticaddressprovider() &Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		jwt:           rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_address_provider(_args ...rt.PhpVal) &Class_WC_Address_Provider {
	mut obj := &Class_WC_Address_Provider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_jsonwebtoken(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_addressprovider_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_AddressProvider_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_AddressProvider_Exception{
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

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_address_service_jwt' {
			this.get_address_service_jwt()
			return rt.new_null()
		}
		'can_telemetry' {
			return rt.new_bool(this.can_telemetry())
		}
		'load_jwt' {
			this.load_jwt()
			return rt.new_null()
		}
		'get_jwt' {
			return this.get_jwt()
		}
		'set_jwt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_jwt(dispatch_arg_0)
			return rt.new_null()
		}
		'get_jwt_cache_duration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_jwt_cache_duration(dispatch_arg_0)
		}
		'refresh_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.refresh_cache(dispatch_arg_0)
		}
		'get_cached_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cached_option(dispatch_arg_0)
		}
		'update_cached_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.update_cached_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'delete_cached_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_cached_option(dispatch_arg_0)
			return rt.new_null()
		}
		'is_expired' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.is_expired(dispatch_arg_0))
		}
		'get_asset_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.get_asset_url(dispatch_arg_0)
		}
		'load_scripts' {
			this.load_scripts()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'jwt' { return this.jwt }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'jwt' {
			this.jwt = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Address_Provider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Address_Provider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Address_Provider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_AddressProvider_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
