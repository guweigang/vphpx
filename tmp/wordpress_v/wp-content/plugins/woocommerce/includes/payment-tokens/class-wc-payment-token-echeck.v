import rt

struct Class_WC_Payment_Token_ECheck {
	rt.PhpObjectBase
pub mut:
	prop_type  rt.PhpVal = rt.new_string('eCheck')
	extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Payment_Token_ECheck) get_display_name(deprecated string) rt.PhpVal {
	mut var_display := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('eCheck ending in %1$s'),
			rt.new_string('woocommerce')]),
		this.get_last4(''),
	])
	return var_display.dup()
}

fn (mut this Class_WC_Payment_Token_ECheck) get_hook_prefix() string {
	return 'woocommerce_payment_token_echeck_get_'
}

fn (mut this Class_WC_Payment_Token_ECheck) validate() bool {
	if rt.is_true(rt.identical(rt.new_bool(false), this.Class_WC_Payment_Token.validate())) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_last4('edit'))))) {
		return false
	}
	return true
}

fn (mut this Class_WC_Payment_Token_ECheck) get_last4(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('last4'), rt.new_string(context))
}

fn (mut this Class_WC_Payment_Token_ECheck) set_last4(var_last4 rt.PhpVal) {
	this.set_prop(rt.new_string('last4'), var_last4.dup())
}

struct Class_WC_Payment_Token {
	rt.PhpObjectBase
}

fn create_wc_payment_token_echeck() &Class_WC_Payment_Token_ECheck {
	mut obj := &Class_WC_Payment_Token_ECheck{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('eCheck')
		extra_data:    rt.new_array()
	}
	return obj
}

fn create_wc_payment_token() &Class_WC_Payment_Token {
	mut obj := &Class_WC_Payment_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Token_ECheck) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WC_Payment_Token_ECheck) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Payment_Token_ECheck) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_includes_payment_tokens_class_wc_payment_token_echeck_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
