import rt

struct Class_Automattic_WooCommerce_Admin_Marketing_Price {
	rt.PhpObjectBase
pub mut:
	value    string
	currency string
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Price) construct(value string, currency string) {
	this.value = value
	this.currency = currency
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Price) get_value() string {
	return this.value
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Price) get_currency() string {
	return this.currency
}

fn create_automattic_woocommerce_admin_marketing_price(value string, currency string) &Class_Automattic_WooCommerce_Admin_Marketing_Price {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_Price{
		PhpObjectBase: rt.PhpObjectBase{}
		value:         ''
		currency:      ''
	}
	obj.construct(value, currency)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Price) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_value' {
			return rt.new_string(this.get_value())
		}
		'get_currency' {
			return rt.new_string(this.get_currency())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_Price) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'value' { return rt.new_string(this.value) }
		'currency' { return rt.new_string(this.currency) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Price) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'value' {
			this.value = val.str()
			return true
		}
		'currency' {
			this.currency = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
