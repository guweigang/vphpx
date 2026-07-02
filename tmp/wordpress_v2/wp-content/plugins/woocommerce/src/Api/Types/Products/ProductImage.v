import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductImage {
	rt.PhpObjectBase
pub mut:
	id       rt.PhpVal = rt.new_null()
	url      rt.PhpVal = rt.new_null()
	alt      rt.PhpVal = rt.new_null()
	position rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_productimage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductImage {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductImage{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_null()
		url:           rt.new_null()
		alt:           rt.new_null()
		position:      rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductImage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductImage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'url' { return this.url }
		'alt' { return this.alt }
		'position' { return this.position }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductImage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'url' {
			this.url = val
			return true
		}
		'alt' {
			this.alt = val
			return true
		}
		'position' {
			this.position = val
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
