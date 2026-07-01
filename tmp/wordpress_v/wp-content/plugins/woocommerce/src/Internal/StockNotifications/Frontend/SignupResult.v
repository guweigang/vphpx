import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult {
	rt.PhpObjectBase
pub mut:
		code string
		notification rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) construct(code string, mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_?Notification)  {
	this.code = code
	this.notification = var_notification.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) get_code() string {
	return this.code
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) get_notification() rt.PhpVal {
	return this.notification
}

fn create_automattic_woocommerce_internal_stocknotifications_frontend_signupresult(code string, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult{
		PhpObjectBase: rt.PhpObjectBase{}
		code: ''
		notification: rt.new_null()
	}
	obj.construct(code, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_?Notification](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_code' {
			return rt.new_string(this.get_code())
		}
		'get_notification' {
			return this.get_notification()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'code' { return rt.new_string(this.code) }
		'notification' { return this.notification }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Frontend_SignupResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'code' { this.code = (val).str(); return true }
		'notification' { this.notification = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_frontend_signupresult_php() {
	// unsupported statement: Stmt_Declare
}
