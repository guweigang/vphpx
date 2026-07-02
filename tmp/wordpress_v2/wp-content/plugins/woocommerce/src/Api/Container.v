import rt

struct Class_Automattic_WooCommerce_Api_Container {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Api_Container.get(class_name string) rt.PhpVal {
	return rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		rt.new_string(class_name),
	])
}

fn create_automattic_woocommerce_api_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Container {
	mut obj := &Class_Automattic_WooCommerce_Api_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Api_Container.get(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
