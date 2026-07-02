import rt

struct Class_WC_Payment_Token_CC {
	rt.PhpObjectBase
pub mut:
	prop_type  rt.PhpVal = rt.new_string('CC')
	extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Payment_Token_CC) get_display_name(deprecated string) rt.PhpVal {
	mut var_display := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s ending in %2$s (expires %3$s/%4$s)'),
			rt.new_string('woocommerce')]),
		rt.call_function('wc_get_credit_card_type_label', [this.get_card_type('')]),
		this.get_last4(''),
		this.get_expiry_month(''),
		rt.call_function('substr', [this.get_expiry_year(''),
			rt.new_int(2)]),
	])
	return var_display.clone()
}

fn (mut this Class_WC_Payment_Token_CC) get_hook_prefix() string {
	return 'woocommerce_payment_token_cc_get_'
}

fn (mut this Class_WC_Payment_Token_CC) validate() bool {
	if rt.is_true(rt.identical(rt.new_bool(false), this.Class_WC_Payment_Token.validate())) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_last4('edit'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_expiry_year('edit'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_expiry_month('edit'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_card_type('edit'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(4 != this.get_expiry_year('edit').to_string().len)) {
		return false
	}
	if rt.is_true(rt.new_bool(2 != this.get_expiry_month('edit').to_string().len)) {
		return false
	}
	return true
}

fn (mut this Class_WC_Payment_Token_CC) get_card_type(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('card_type'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token_CC) set_card_type(var_type rt.PhpVal) {
	this.set_prop(rt.new_string('card_type'), var_type.clone())
}

fn (mut this Class_WC_Payment_Token_CC) get_expiry_year(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('expiry_year'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token_CC) set_expiry_year(var_year rt.PhpVal) {
	this.set_prop(rt.new_string('expiry_year'), var_year.clone())
}

fn (mut this Class_WC_Payment_Token_CC) get_expiry_month(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('expiry_month'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token_CC) set_expiry_month(var_month rt.PhpVal) {
	this.set_prop(rt.new_string('expiry_month'), rt.call_function('str_pad', [
		var_month.clone(), rt.new_int(2), rt.new_string('0'),
		rt.get_constant('STR_PAD_LEFT')]))
}

fn (mut this Class_WC_Payment_Token_CC) get_last4(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('last4'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token_CC) set_last4(var_last4 rt.PhpVal) {
	this.set_prop(rt.new_string('last4'), var_last4.clone())
}

struct Class_WC_Payment_Token {
	rt.PhpObjectBase
}

fn create_wc_payment_token_cc(_args ...rt.PhpVal) &Class_WC_Payment_Token_CC {
	mut obj := &Class_WC_Payment_Token_CC{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('CC')
		extra_data:    rt.new_array()
	}
	return obj
}

fn create_wc_payment_token(_args ...rt.PhpVal) &Class_WC_Payment_Token {
	mut obj := &Class_WC_Payment_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Token_CC) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_display_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_display_name(dispatch_arg_0)
		}
		'get_hook_prefix' {
			return rt.new_string(this.get_hook_prefix())
		}
		'validate' {
			return rt.new_bool(this.validate())
		}
		'get_card_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_card_type(dispatch_arg_0)
		}
		'set_card_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_card_type(dispatch_arg_0)
			return rt.new_null()
		}
		'get_expiry_year' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_expiry_year(dispatch_arg_0)
		}
		'set_expiry_year' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_expiry_year(dispatch_arg_0)
			return rt.new_null()
		}
		'get_expiry_month' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_expiry_month(dispatch_arg_0)
		}
		'set_expiry_month' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_expiry_month(dispatch_arg_0)
			return rt.new_null()
		}
		'get_last4' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_last4(dispatch_arg_0)
		}
		'set_last4' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_last4(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Payment_Token_CC) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Payment_Token_CC) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'extra_data' {
			this.extra_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Payment_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
