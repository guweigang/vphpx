import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions {
	rt.PhpObjectBase
pub mut:
	length rt.PhpVal = rt.new_null()
	width  rt.PhpVal = rt.new_null()
	height rt.PhpVal = rt.new_null()
	weight rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_productdimensions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions{
		PhpObjectBase: rt.PhpObjectBase{}
		length:        rt.new_null()
		width:         rt.new_null()
		height:        rt.new_null()
		weight:        rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'length' { return this.length }
		'width' { return this.width }
		'height' { return this.height }
		'weight' { return this.weight }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductDimensions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'length' {
			this.length = val
			return true
		}
		'width' {
			this.width = val
			return true
		}
		'height' {
			this.height = val
			return true
		}
		'weight' {
			this.weight = val
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
