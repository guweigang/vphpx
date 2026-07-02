import rt

struct Class_Automattic_WooCommerce_Api_Attributes_ScalarType {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_ScalarType) construct(type string) {
}

fn create_automattic_woocommerce_api_attributes_scalartype(type string) &Class_Automattic_WooCommerce_Api_Attributes_ScalarType {
	mut obj := &Class_Automattic_WooCommerce_Api_Attributes_ScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(type)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_ScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Attributes_ScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_ScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
