import rt

struct Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider {
	rt.PhpObjectBase
pub mut:
		jwt rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) construct()  {
	rt.call_function('add_filter', [rt.new_string('pre_update_option_woocommerce_address_autocomplete_enabled'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this) }, rt.ArrayItem{ key: none, val: 'refresh_cache' }])])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this) }, rt.ArrayItem{ key: none, val: 'load_scripts' }])])
	this.dispatch_set_prop('branding_html', 'Powered by&nbsp;<img style="height: 15px; width: 45px; margin-bottom: -2px;" src="' + (rt.call_function('plugins_url', [rt.new_string('/assets/images/address-autocomplete/google.svg'), rt.get_constant('WC_PLUGIN_FILE')])).str() + '" alt="Google logo" />')
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_address_service_jwt()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) can_telemetry() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) load_jwt()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.jwt) && rt.is_true(rt.new_bool(this.jwt.is_string())))) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}; return temp.shallow_validate(arg_0) }(this.jwt)))) {
		return rt.new_null()
	}
	mut var_cached_jwt := this.get_cached_option(rt.new_string('address_autocomplete_jwt'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_cached_jwt) && rt.is_true(rt.new_bool(var_cached_jwt.dup().is_string())))) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}; return temp.shallow_validate(arg_0) }(var_cached_jwt.dup())))) {
		this.jwt = var_cached_jwt.dup()
		return rt.new_null()
	}
	mut var_retry_data := this.get_cached_option(rt.new_string('jwt_retry_data'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_retry_data) && var_retry_data.array_isset(rt.new_string('try_after')))) && rt.is_true(rt.greater(var_retry_data.array_get('try_after'), rt.call_function('time', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_fresh_jwt := this.get_address_service_jwt()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_fresh_jwt) && rt.is_true(rt.new_bool(var_fresh_jwt.dup().is_string())))) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}; return temp.shallow_validate(arg_0) }(var_fresh_jwt.dup())))) {
		this.set_jwt(var_fresh_jwt.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.delete_cached_option(rt.new_string('jwt_retry_data'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return rt.new_null()
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_Exception', []string{}, create_automattic_woocommerce_internal_addressprovider_exception(rt.new_string('Invalid JWT received from address service.'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_AddressProvider_Exception') {
		mut var_e := var_e_1.dup()
		var_retry_data.array_set('attempts', if var_retry_data.array_isset(rt.new_string('attempts')) { rt.add(var_retry_data.array_get('attempts'), rt.new_int(1)) } else { rt.new_int(1) })
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed loading JWT for %1$s address autocomplete service (attempt %2$d) with error %3$s.'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'name'), var_retry_data.array_get('attempts'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.new_string('address-autocomplete')])
		mut var_backoff_hours := rt.call_function('pow', [rt.new_int(2), rt.sub(var_retry_data.array_get('attempts'), rt.new_int(1))])
		var_retry_data.array_set('try_after', rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(var_backoff_hours, rt.get_constant('HOUR_IN_SECONDS'))))
		this.update_cached_option(rt.new_string('jwt_retry_data'), var_retry_data.dup(), rt.get_constant('DAY_IN_SECONDS'))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_jwt() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.jwt)) {
		this.load_jwt()
	}
	return this.jwt
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) set_jwt(var_jwt rt.PhpVal)  {
	this.jwt = var_jwt.dup()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_cache_duration := this.get_jwt_cache_duration(var_jwt.dup())
		if rt.is_true(rt.identical(rt.new_int(0), var_cache_duration)) {
			this.jwt = rt.new_null()
			this.load_jwt()
			return rt.new_null()
		}
		this.update_cached_option(rt.new_string('address_autocomplete_jwt'), var_jwt.dup(), var_cache_duration.dup())
	} else {
		this.delete_cached_option(rt.new_string('address_autocomplete_jwt'))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_jwt_cache_duration(var_jwt rt.PhpVal) rt.PhpVal {
	mut var_parts := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{}; return temp.get_parts(arg_0) }(var_jwt.dup())
	if rt.is_true(rt.call_function('property_exists', [rt.get_property(var_parts, 'payload'), rt.new_string('exp')])) {
		return rt.call_function('max', [rt.sub(rt.get_property(rt.get_property(var_parts, 'payload'), 'exp'), rt.call_function('time', []rt.PhpVal{})), rt.new_int(0)])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) refresh_cache(var_setting rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('wc_string_to_bool', [var_setting.dup()])) {
		this.load_jwt()
	} else {
		this.set_jwt(rt.new_null())
	}
	return var_setting.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) get_cached_option(var_key rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_function('get_option', [(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() + '_' + (var_key).str()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_data.dup().is_array())) && var_data.array_isset(rt.new_string('data')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.is_expired(var_data.dup()))))) {
			return var_data.array_get('data')
		}
		this.delete_cached_option(var_key.dup())
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) update_cached_option(var_key rt.PhpVal, var_value rt.PhpVal, var_ttl rt.PhpVal)  {
	mut var_result := rt.call_function('update_option', [(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() + '_' + (var_key).str(), rt.create_array([rt.ArrayItem{ key: 'data', val: var_value }, rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'ttl', val: var_ttl }]), rt.new_bool(false)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.call_function('wp_cache_delete', [(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() + '_' + (var_key).str(), rt.new_string('options')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) delete_cached_option(var_key rt.PhpVal)  {
	if rt.is_true(rt.call_function('delete_option', [(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() + '_' + (var_key).str()])) {
		rt.call_function('wp_cache_delete', [(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id')).str() + '_' + (var_key).str(), rt.new_string('options')])
	}
}

fn Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.is_expired(var_cache_contents rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache_contents.dup().is_array()))))) || !(var_cache_contents.array_isset(rt.new_string('updated'))))) || !(var_cache_contents.array_isset(rt.new_string('ttl'))))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache_contents.array_get('updated').is_long()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache_contents.array_get('ttl').is_long()))))))) {
		return true
	}
	mut var_expires := rt.add(var_cache_contents.array_get('updated'), var_cache_contents.array_get('ttl'))
	mut var_now := rt.call_function('time', []rt.PhpVal{})
	return (rt.less(var_expires, var_now)).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.get_asset_url(var_path rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_asset_url'), rt.call_function('plugins_url', [var_path.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_PLUGIN_FILE'))]), var_path.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider) load_scripts()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_jwt())))) {
		return rt.new_null()
	}
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [rt.new_string('a8c-address-autocomplete-service'), rt.new_string('registered')]))))) {
		rt.call_function('wp_register_script', [rt.new_string('a8c-address-autocomplete-service'), Class_Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider.get_asset_url(rt.new_string('assets/js/frontend/a8c-address-autocomplete-service' + (var_suffix).str() + '.js')), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-address-autocomplete' }]), var_version.dup(), rt.create_array([rt.ArrayItem{ key: 'strategy', val: 'defer' }])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [rt.new_string('a8c-address-autocomplete-service'), rt.new_string('enqueued')]))))) {
		rt.call_function('wp_enqueue_script', [rt.new_string('a8c-address-autocomplete-service')])
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('a8c-address-autocomplete-service'), rt.call_function('sprintf', [rt.new_string('var a8cAddressAutocompleteServiceKeys = a8cAddressAutocompleteServiceKeys || {}; a8cAddressAutocompleteServiceKeys[ %1$s ] = { key: %2$s, canTelemetry: %3$s };'), rt.call_function('wp_json_encode', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_AddressProvider_AbstractAutomatticAddressProvider', ['WC_Address_Provider'], &this), 'id'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [this.get_jwt(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_Cast_Bool)), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('before')])
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
		jwt: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_address_provider() &Class_WC_Address_Provider {
	mut obj := &Class_WC_Address_Provider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_jsonwebtoken() &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_JsonWebToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_addressprovider_exception() &Class_Automattic_WooCommerce_Internal_AddressProvider_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_AddressProvider_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
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
		else { return none }
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
		'jwt' { this.jwt = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_internal_addressprovider_abstractautomatticaddressprovider_php() {
	// unsupported statement: Stmt_Declare
}
