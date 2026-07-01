import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct {
	rt.PhpObjectBase
pub mut:
	product_url rt.PhpVal = rt.new_null()
	button_text rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_externalproduct() &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct{
		PhpObjectBase: rt.PhpObjectBase{}
		product_url:   rt.new_null()
		button_text:   rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_url' { return this.product_url }
		'button_text' { return this.button_text }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ExternalProduct) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_url' {
			this.product_url = val
			return true
		}
		'button_text' {
			this.button_text = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_types_products_externalproduct_php() {
	// unsupported statement: Stmt_Declare
}
