import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validatable_fields() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'user_id' }, rt.ArrayItem{ key: none, val: 'origin' }, rt.ArrayItem{ key: none, val: 'device_uuid' }, rt.ArrayItem{ key: none, val: 'device_locale' }, rt.ArrayItem{ key: none, val: 'platform' }, rt.ArrayItem{ key: none, val: 'token' }, rt.ArrayItem{ key: none, val: 'metadata' }])
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code() string {
	return 'woocommerce_invalid_data'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.device_locale_format() string {
	return '/^(?<language>[a-z]{2,3})(?:_(?<region>[A-Z]{2}))?$/'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.device_uuid_format() string {
	return '/^[A-Za-z0-9._:-]+$/'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.device_uuid_maximum_length() i64 {
	return 255
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.token_maximum_length() i64 {
	return 4096
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.token_format_apple() string {
	return '/^[A-Fa-f0-9]{64}$/'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.token_format_android() string {
	return '/^[A-Za-z0-9=:_\\-+\\/]+$/'
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate(mut var_data Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_array, mut var_fields Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_fields_mutated := var_fields
	var_fields_mutated = if !rt.is_true(var_fields_mutated) { Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validatable_fields() } else { var_fields_mutated }
	{
		mut iter_1 := var_fields_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_method := rt.new_string('validate_' + (var_field).str())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.class(), var_method.dup()]))))) {
				return (create_wp_error(rt.new_string('woocommerce_invalid_data'), rt.call_function('sprintf', [rt.new_string('Can\'t validate param \'%s\' as a validator does not exist for it.'), var_field.dup()]))).to_bool()
			}
			mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}; return temp.{"nodetype":"expr_variable","line":112,"name":"method"}(arg_0, arg_1) }(if !(var_data.array_get(var_field)).is_null() { var_data.array_get(var_field) } else { rt.new_null() }, rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Validators_array', []string{}, var_data))
			if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
				return (var_result).to_bool()
			}
		}
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_id(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_null())) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('ID is required.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double()))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('ID must be numeric.'))).to_bool()
	}
	if rt.is_true(rt.less_equal(var_value_mutated, rt.new_int(0))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('ID must be a positive integer.'))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_user_id(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_null())) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('User ID is required.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double()))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('User ID must be numeric.'))).to_bool()
	}
	if rt.is_true(rt.less_equal(var_value_mutated, rt.new_int(0))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('User ID must be a positive integer.'))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_origin(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_null())) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Origin is required.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Origin must be a string.'))).to_bool()
	}
	var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string().trim_space()))
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Origin cannot be empty.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.dup(), Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origins(), rt.new_bool(true)]))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.call_function('sprintf', [rt.new_string('Origin must be one of: %s.'), rt.call_function('implode', [rt.new_string(', '), Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origins()])]))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_device_uuid(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	mut var_maybe_platform := if !(var_context.array_get('platform')).is_null() { var_context.array_get('platform') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_apple(), var_maybe_platform)) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_android(), var_maybe_platform)))) {
		if rt.is_true(rt.new_bool(var_value_mutated.dup().is_null())) {
			return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device UUID is required.'))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
			return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device UUID must be a string.'))).to_bool()
		}
		var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string().trim_space()))
		if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
			return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device UUID cannot be empty.'))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.device_uuid_format(), var_value_mutated.dup()]))))) {
			return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device UUID is an invalid format.'))).to_bool()
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string())) && rt.is_true(rt.greater(rt.new_int(var_value_mutated.dup().to_string().len), Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.device_uuid_maximum_length())))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.call_function('sprintf', [rt.new_string('Device UUID exceeds maximum length of %s.'), Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.device_uuid_maximum_length()]))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_device_locale(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	if !(!(var_value_mutated).is_null()) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device locale is required.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device locale must be a string.'))).to_bool()
	}
	var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string().trim_space()))
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device locale cannot be empty.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.device_locale_format(), var_value_mutated.dup()]))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Device locale is an invalid format.'))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_platform(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_null())) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Platform is required.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Platform must be a string.'))).to_bool()
	}
	var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string().trim_space()))
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Platform cannot be empty.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.dup(), Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platforms(), rt.new_bool(true)]))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.call_function('sprintf', [rt.new_string('Platform must be one of: %s.'), rt.call_function('implode', [rt.new_string(', '), Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platforms()])]))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_token(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.dup().is_null())) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Token is required.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Token must be a string.'))).to_bool()
	}
	var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string().trim_space()))
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Token cannot be empty.'))).to_bool()
	}
	if rt.is_true(rt.greater(rt.new_int(var_value_mutated.dup().to_string().len), Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.token_maximum_length())) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.call_function('sprintf', [rt.new_string('Token exceeds maximum length of %s.'), Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.token_maximum_length()]))).to_bool()
	}
	if !(var_context.array_isset(rt.new_string('platform'))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_apple(), var_context.array_get('platform'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.token_format_apple(), var_value_mutated.dup()]))))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Token is an invalid format.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_android(), var_context.array_get('platform'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.token_format_android(), var_value_mutated.dup()]))))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Token is an invalid format.'))).to_bool()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_browser(), var_context.array_get('platform'))) {
		mut var_token_object := rt.call_function('json_decode', [var_value_mutated.dup(), rt.new_bool(true)])
		mut var_endpoint := if !(var_token_object.array_get('endpoint')).is_null() { var_token_object.array_get('endpoint') } else { rt.new_null() }
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_token_object.dup().is_null())) || rt.is_true(rt.call_function('json_last_error', []rt.PhpVal{})))) || !(var_token_object.array_get('keys').array_isset(rt.new_string('auth'))))) || !(var_token_object.array_get('keys').array_isset(rt.new_string('p256dh'))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_endpoint)))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_http_validate_url', [// unsupported expression: Expr_Cast_String]))))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Token is an invalid format.'))).to_bool()
		}
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_metadata(var_value rt.PhpVal, mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array) bool {
	mut var_value_mutated := var_value
	if !(!(var_value_mutated).is_null()) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Metadata is required.'))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))))) {
		return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Metadata must be an array.'))).to_bool()
	}
	{
		mut iter_1 := var_value_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_item.dup()]))))) {
				return (create_wp_error(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.error_code(), rt.new_string('Metadata items must be scalar values.'))).to_bool()
			}
		}
	}
	return true
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_validators_pushtokenvalidator() &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_id(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_user_id(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_origin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_origin(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_device_uuid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_device_uuid(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_device_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_device_locale(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_platform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_platform(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_token' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_token(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator.validate_metadata(dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_pushnotifications_validators_pushtokenvalidator_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
}
