import rt

struct Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput {
	rt.PhpObjectBase
pub mut:
	id   rt.PhpVal = rt.new_null()
	name rt.PhpVal = rt.new_null()
}

struct Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_inputtypes_products_updateproductinput() &Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput {
	mut obj := &Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_null()
		name:          rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_api_inputtypes_products_baseproductinput() &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput {
	mut obj := &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_UpdateProductInput) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
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

pub fn init_wp_content_plugins_woocommerce_src_api_inputtypes_products_updateproductinput_php() {
	// unsupported statement: Stmt_Declare
}
