import rt

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_null()
	code      rt.PhpVal = rt.new_null()
	message   rt.PhpVal = rt.new_null()
	param     rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) construct(var_type rt.PhpVal, var_code rt.PhpVal, var_message rt.PhpVal, var_param rt.PhpVal) {
	this.prop_type = var_type.clone()
	this.code = var_code.clone()
	this.message = var_message.clone()
	this.param = var_param.clone()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.invalid_request(var_code rt.PhpVal, var_message rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.invalid_request(),
		var_code.clone(), var_message.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.request_not_idempotent(var_code rt.PhpVal, var_message rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.request_not_idempotent(),
		var_code.clone(), var_message.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.processing_error(var_code rt.PhpVal, var_message rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.processing_error(),
		var_code.clone(), var_message.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.service_unavailable(var_code rt.PhpVal, var_message rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.service_unavailable(),
		var_code.clone(), var_message.clone(), var_param.clone()))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) to_rest_response() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'type', val: this.prop_type },
		rt.ArrayItem{ key: 'code', val: this.code }, rt.ArrayItem{ key: 'message', val: this.message }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.param)))) {
		var_data.array_set('param', this.param)
	}
	mut var_status_code := rt.new_int(this.get_http_status_code())
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_data.clone(),
		var_status_code.clone()))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) get_http_status_code() i64 {
	mut switch_val_1 := this.prop_type
	if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.invalid_request()))
	{
		return 400
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.request_not_idempotent()))
	{
		return 409
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.processing_error()))
	{
		return 500
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.service_unavailable()))
	{
		return 503
	} else {
		return 500
	}
	return i64(0)
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_error(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_null()
		code:          rt.new_null()
		message:       rt.new_null()
		param:         rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'invalid_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.invalid_request(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'request_not_idempotent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.request_not_idempotent(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'processing_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.processing_error(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'service_unavailable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error.service_unavailable(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'to_rest_response' {
			return this.to_rest_response()
		}
		'get_http_status_code' {
			return rt.new_int(this.get_http_status_code())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'code' { return this.code }
		'message' { return this.message }
		'param' { return this.param }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'code' {
			this.code = val
			return true
		}
		'message' {
			this.message = val
			return true
		}
		'param' {
			this.param = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
