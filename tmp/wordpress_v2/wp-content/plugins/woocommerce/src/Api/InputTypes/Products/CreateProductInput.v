import rt

struct Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput {
	rt.PhpObjectBase
pub mut:
	name rt.PhpVal = rt.new_null()
}

struct Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_inputtypes_products_createproductinput(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput {
	mut obj := &Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_api_inputtypes_products_baseproductinput(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput {
	mut obj := &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_CreateProductInput) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
