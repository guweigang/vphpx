import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct {
	rt.PhpObjectBase
pub mut:
	variations rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_variableproduct() &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct{
		PhpObjectBase: rt.PhpObjectBase{}
		variations:    rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'variations' { return this.variations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_VariableProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'variations' {
			this.variations = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_types_products_variableproduct_php() {
	// unsupported statement: Stmt_Declare
}
