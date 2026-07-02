import rt

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError {
	rt.PhpObjectBase
pub mut:
		prop_type rt.PhpVal = rt.new_null()
		code string
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) construct(code string, content string, mut var_param Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_?string) {
	this.code = code
	this.dispatch_set_prop('content', rt.new_string(content))
	this.dispatch_set_prop('param', var_param)
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.missing(var_content rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.missing(), var_content.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.invalid(var_content rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_content.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.out_of_stock(var_content rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.out_of_stock(), var_content.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.payment_declined(var_content rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.payment_declined(), var_content.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.requires_sign_in(var_content rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.requires_sign_in(), var_content.clone(), var_param.clone()))
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.requires_3ds(var_content rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self', []string{}, create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_self(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.requires_3ds(), var_content.clone(), var_param.clone()))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) is_error() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) to_array() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'type', val: this.prop_type }, rt.ArrayItem{ key: 'code', val: this.code }, rt.ArrayItem{ key: 'content_type', val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError', ['Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message'], &this), 'content_type') }, rt.ArrayItem{ key: 'content', val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError', ['Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message'], &this), 'content') }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError', ['Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message'], &this), 'param'))))) {
		var_data.array_set('param', rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError', ['Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message'], &this), 'param'))
	}
	return var_data.clone()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_messageerror(code string, content string, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type: rt.new_null()
		code: ''
	}
	obj.construct(code, content, arg_2)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_message(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'missing' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.missing(dispatch_arg_0, dispatch_arg_1)
		}
		'invalid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.invalid(dispatch_arg_0, dispatch_arg_1)
		}
		'out_of_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.out_of_stock(dispatch_arg_0, dispatch_arg_1)
		}
		'payment_declined' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.payment_declined(dispatch_arg_0, dispatch_arg_1)
		}
		'requires_sign_in' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.requires_sign_in(dispatch_arg_0, dispatch_arg_1)
		}
		'requires_3ds' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError.requires_3ds(dispatch_arg_0, dispatch_arg_1)
		}
		'is_error' {
			return rt.new_bool(this.is_error())
		}
		'to_array' {
			return this.to_array()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'code' { return rt.new_string(this.code) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' { this.prop_type = val; return true }
		'code' { this.code = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
