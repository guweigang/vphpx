import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation {
	rt.PhpObjectBase
pub mut:
	parent_id           rt.PhpVal = rt.new_null()
	selected_attributes rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_productvariation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation{
		PhpObjectBase:       rt.PhpObjectBase{}
		parent_id:           rt.new_null()
		selected_attributes: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parent_id' { return this.parent_id }
		'selected_attributes' { return this.selected_attributes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductVariation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parent_id' {
			this.parent_id = val
			return true
		}
		'selected_attributes' {
			this.selected_attributes = val
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
