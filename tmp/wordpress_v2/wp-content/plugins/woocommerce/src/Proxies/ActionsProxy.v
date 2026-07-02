import rt

struct Class_Automattic_WooCommerce_Proxies_ActionsProxy {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Proxies_ActionsProxy) did_action(var_tag rt.PhpVal) rt.PhpVal {
	return rt.call_function('did_action', [var_tag.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Proxies_ActionsProxy) apply_filters(var_tag rt.PhpVal, var_value rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [var_tag.clone(),
		var_value.clone(), var_parameters.clone()])
}

fn create_automattic_woocommerce_proxies_actionsproxy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Proxies_ActionsProxy {
	mut obj := &Class_Automattic_WooCommerce_Proxies_ActionsProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Proxies_ActionsProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'did_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.did_action(dispatch_arg_0)
		}
		'apply_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_filters(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Proxies_ActionsProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Proxies_ActionsProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
