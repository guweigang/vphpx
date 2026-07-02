import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.post_type() string {
	return 'wc_push_token'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.default_device_locale() string {
	return 'en_US'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_apple() string {
	return 'apple'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_android() string {
	return 'android'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_browser() string {
	return 'browser'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_android() string {
	return 'com.woocommerce.android'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_android_dev() string {
	return 'com.woocommerce.android:dev'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_ios() string {
	return 'com.automattic.woocommerce'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_ios_dev() string {
	return 'com.automattic.woocommerce:dev'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_browser() string {
	return 'browser'
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platforms() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_apple() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_android() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_browser() }])
}
pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origins() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_browser() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_android() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_android_dev() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_ios() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origin_woocommerce_ios_dev() }])
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken {
	rt.PhpObjectBase
pub mut:
		id rt.PhpVal = rt.new_null()
		user_id rt.PhpVal = rt.new_null()
		token string
		device_uuid rt.PhpVal = rt.new_null()
		platform string
		origin string
		device_locale string
		metadata rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) construct(mut var_data Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_array) {
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('id')))) {
		this.set_id(rt.new_int((var_data.array_get(rt.new_string('id'))).to_i64()))
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('user_id')))) {
		this.set_user_id(rt.new_int((var_data.array_get(rt.new_string('user_id'))).to_i64()))
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('token')))) {
		this.set_token((var_data.array_get(rt.new_string('token'))).str())
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('device_uuid')))) {
		this.set_device_uuid(mut (var_data.array_get(rt.new_string('device_uuid'))).str())
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('platform')))) {
		this.set_platform((var_data.array_get(rt.new_string('platform'))).str())
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('origin')))) {
		this.set_origin((var_data.array_get(rt.new_string('origin'))).str())
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('device_locale')))) {
		this.set_device_locale((var_data.array_get(rt.new_string('device_locale'))).str())
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('metadata')))) {
		this.set_metadata(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_array](rt.cast_array(var_data.array_get(rt.new_string('metadata')))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_id(id i64) {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_0 := iife_temp_0.validate(rt.call_function('compact', [rt.new_string('id')]), rt.create_array([rt.ArrayItem{ key: none, val: 'id' }]))
	mut var_result := iife_result_0
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	this.id = rt.new_int(id)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_user_id(user_id i64) {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_1 := iife_temp_1.validate(rt.call_function('compact', [rt.new_string('user_id')]), rt.create_array([rt.ArrayItem{ key: none, val: 'user_id' }]))
	mut var_result := iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	this.user_id = rt.new_int(user_id)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_token(token string) {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_2 := iife_temp_2.validate(rt.call_function('compact', [rt.new_string('token')]), rt.create_array([rt.ArrayItem{ key: none, val: 'token' }]))
	mut var_result := iife_result_2
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	this.token = token.trim_space()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_device_uuid(mut var_device_uuid Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_?string) {
	mut var_device_uuid_mutated := var_device_uuid
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_3 := iife_temp_3.validate(rt.call_function('compact', [rt.new_string('device_uuid')]), rt.create_array([rt.ArrayItem{ key: none, val: 'device_uuid' }]))
	mut var_result := iife_result_3
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_device_uuid_mutated)))) {
	var_device_uuid_mutated = rt.new_string(var_device_uuid_mutated.to_string().trim_space())
	}
	this.device_uuid = if rt.is_true(var_device_uuid_mutated) { var_device_uuid_mutated } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_device_locale(device_locale string) {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_4 := iife_temp_4.validate(rt.call_function('compact', [rt.new_string('device_locale')]), rt.create_array([rt.ArrayItem{ key: none, val: 'device_locale' }]))
	mut var_result := iife_result_4
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	this.device_locale = device_locale.trim_space()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_platform(platform string) {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_5 := iife_temp_5.validate(rt.call_function('compact', [rt.new_string('platform')]), rt.create_array([rt.ArrayItem{ key: none, val: 'platform' }]))
	mut var_result := iife_result_5
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	this.platform = platform.trim_space()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_origin(origin string) {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_6 := iife_temp_6.validate(rt.call_function('compact', [rt.new_string('origin')]), rt.create_array([rt.ArrayItem{ key: none, val: 'origin' }]))
	mut var_result := iife_result_6
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	this.origin = origin.trim_space()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) set_metadata(mut var_metadata Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_array) {
	mut var_metadata_mutated := var_metadata
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_7 := iife_temp_7.validate(rt.call_function('compact', [rt.new_string('metadata')]), rt.create_array([rt.ArrayItem{ key: none, val: 'metadata' }]))
	mut var_result := iife_result_7
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	if !(!rt.is_true(var_metadata_mutated)) {
	mut var_keys := rt.call_function('array_map', [rt.new_string('sanitize_key'), rt.func_array_keys(var_metadata_mutated)])
	mut var_values := rt.call_function('array_map', [rt.new_string('sanitize_text_field'), rt.call_function('array_values', [var_metadata_mutated])])
	var_metadata_mutated = rt.call_function('array_combine', [var_keys.clone(), var_values.clone()])
	}
	this.metadata = var_metadata_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_id() i64 {
	return (this.id).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_user_id() i64 {
	return (this.user_id).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_token() string {
	return this.token
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_device_uuid() string {
	return (this.device_uuid).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_platform() string {
	return this.platform
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_origin() string {
	return this.origin
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_device_locale() string {
	return this.device_locale
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) get_metadata() rt.PhpVal {
	return this.metadata
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) to_wpcom_format() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'user_id', val: this.user_id }, rt.ArrayItem{ key: 'token', val: this.token }, rt.ArrayItem{ key: 'origin', val: this.origin }, rt.ArrayItem{ key: 'device_locale', val: if !(this.device_locale).is_null() { this.device_locale } else { Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.default_device_locale() } }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) can_be_created() bool {
	return rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) && this.has_required_parameters()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) can_be_updated() bool {
	return rt.is_true(this.get_id()) && this.has_required_parameters()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) can_be_read() bool {
	return (this.get_id()).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) can_be_deleted() bool {
	return (this.get_id()).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) has_required_parameters() bool {
	return rt.is_true(this.get_user_id()) && rt.is_true(this.get_token()) && rt.is_true(this.get_platform()) && rt.is_true(this.get_origin()) && rt.is_true(this.get_device_locale()) && rt.is_true(this.get_device_uuid()) || rt.is_true(rt.identical(this.get_platform(), Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_browser()))
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_entities_pushtoken(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken{
		PhpObjectBase: rt.PhpObjectBase{}
		id: rt.new_null()
		user_id: rt.new_null()
		token: ''
		device_uuid: rt.new_null()
		platform: ''
		origin: ''
		device_locale: ''
		metadata: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_validators_pushtokenvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_user_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_token(dispatch_arg_0)
			return rt.new_null()
		}
		'set_device_uuid' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_device_uuid(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_device_locale' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_device_locale(dispatch_arg_0)
			return rt.new_null()
		}
		'set_platform' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_platform(dispatch_arg_0)
			return rt.new_null()
		}
		'set_origin' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_origin(dispatch_arg_0)
			return rt.new_null()
		}
		'set_metadata' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_metadata(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_int(this.get_id())
		}
		'get_user_id' {
			return rt.new_int(this.get_user_id())
		}
		'get_token' {
			return rt.new_string(this.get_token())
		}
		'get_device_uuid' {
			return rt.new_string(this.get_device_uuid())
		}
		'get_platform' {
			return rt.new_string(this.get_platform())
		}
		'get_origin' {
			return rt.new_string(this.get_origin())
		}
		'get_device_locale' {
			return rt.new_string(this.get_device_locale())
		}
		'get_metadata' {
			return this.get_metadata()
		}
		'to_wpcom_format' {
			return this.to_wpcom_format()
		}
		'can_be_created' {
			return rt.new_bool(this.can_be_created())
		}
		'can_be_updated' {
			return rt.new_bool(this.can_be_updated())
		}
		'can_be_read' {
			return rt.new_bool(this.can_be_read())
		}
		'can_be_deleted' {
			return rt.new_bool(this.can_be_deleted())
		}
		'has_required_parameters' {
			return rt.new_bool(this.has_required_parameters())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'user_id' { return this.user_id }
		'token' { return rt.new_string(this.token) }
		'device_uuid' { return this.device_uuid }
		'platform' { return rt.new_string(this.platform) }
		'origin' { return rt.new_string(this.origin) }
		'device_locale' { return rt.new_string(this.device_locale) }
		'metadata' { return this.metadata }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = val; return true }
		'user_id' { this.user_id = val; return true }
		'token' { this.token = (val).str(); return true }
		'device_uuid' { this.device_uuid = val; return true }
		'platform' { this.platform = (val).str(); return true }
		'origin' { this.origin = (val).str(); return true }
		'device_locale' { this.device_locale = (val).str(); return true }
		'metadata' { this.metadata = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
