import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute {
	rt.PhpObjectBase
pub mut:
	name  rt.PhpVal = rt.new_null()
	value rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_selectedattribute() &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		value:         rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'value' { return this.value }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_SelectedAttribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'value' {
			this.value = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_types_products_selectedattribute_php() {
	// unsupported statement: Stmt_Declare
}
