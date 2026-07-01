import rt

struct Class_WC_Payment_Token {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
		prop_type rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Payment_Token) construct(token string)  {
	mut token_mutated := token
	this.Class_WC_Legacy_Payment_Token.construct(rt.new_string(token_mutated))
	if rt.is_true(rt.new_bool(rt.new_string(token_mutated).dup().is_long() || rt.new_string(token_mutated).dup().is_double())) {
		this.set_id(rt.new_string(token_mutated))
	} else if rt.is_true(rt.new_bool(rt.new_string(token_mutated).dup().is_object())) {
		mut var_token_id := rt.call_method(rt.new_string(token_mutated), 'get_id', []rt.PhpVal{})
		if !(!rt.is_true(var_token_id)) {
			this.set_id(rt.call_method(rt.new_string(token_mutated), 'get_id', []rt.PhpVal{}))
		}
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('payment-token')))
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Payment_Token', ['WC_Legacy_Payment_Token'], &this), 'data_store'), 'read', [rt.new_object('WC_Payment_Token', ['WC_Legacy_Payment_Token'], &this)])
	}
}

fn (mut this Class_WC_Payment_Token) get_token(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('token'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token) get_type(deprecated string) rt.PhpVal {
	return this.prop_type
}

fn (mut this Class_WC_Payment_Token) get_display_name(deprecated string) rt.PhpVal {
	return this.get_type('')
}

fn (mut this Class_WC_Payment_Token) get_user_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_id'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token) get_gateway_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('gateway_id'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token) get_is_default(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('is_default'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token) set_token(var_token rt.PhpVal)  {
	mut var_token_mutated := var_token
	this.set_prop(rt.new_string('token'), var_token_mutated.dup())
}

fn (mut this Class_WC_Payment_Token) set_user_id(var_user_id rt.PhpVal)  {
	this.set_prop(rt.new_string('user_id'), rt.call_function('absint', [var_user_id.dup()]))
}

fn (mut this Class_WC_Payment_Token) set_gateway_id(var_gateway_id rt.PhpVal)  {
	this.set_prop(rt.new_string('gateway_id'), var_gateway_id.dup())
}

fn (mut this Class_WC_Payment_Token) set_default(var_is_default rt.PhpVal)  {
	this.set_prop(rt.new_string('is_default'), // unsupported expression: Expr_Cast_Bool)
}

fn (mut this Class_WC_Payment_Token) is_default() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_WC_Payment_Token) validate() bool {
	mut var_token := this.get_prop(rt.new_string('token'), rt.new_string('edit'))
	if !rt.is_true(var_token) {
		return false
	}
	return true
}

struct Class_WC_Legacy_Payment_Token {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_payment_token(token string) &Class_WC_Payment_Token {
	mut obj := &Class_WC_Payment_Token{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		prop_type: rt.new_string('')
	}
	obj.construct(token)
	return obj
}

fn create_wc_legacy_payment_token() &Class_WC_Legacy_Payment_Token {
	mut obj := &Class_WC_Legacy_Payment_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_token(dispatch_arg_0)
		}
		'get_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_type(dispatch_arg_0)
		}
		'get_display_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_display_name(dispatch_arg_0)
		}
		'get_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_user_id(dispatch_arg_0)
		}
		'get_gateway_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_gateway_id(dispatch_arg_0)
		}
		'get_is_default' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_is_default(dispatch_arg_0)
		}
		'set_token' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_token(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_user_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_gateway_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_gateway_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_default(dispatch_arg_0)
			return rt.new_null()
		}
		'is_default' {
			return this.is_default()
		}
		'validate' {
			return rt.new_bool(this.validate())
		}
		else { return none }
	}
}

fn (this &Class_WC_Payment_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Payment_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'type' { this.prop_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Legacy_Payment_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Legacy_Payment_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Payment_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_payment_token_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/legacy/abstract-wc-legacy-payment-token.php', '4')
}
