import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute {
	rt.PhpObjectBase
pub mut:
	name        rt.PhpVal = rt.new_null()
	slug        rt.PhpVal = rt.new_null()
	options     rt.PhpVal = rt.new_null()
	position    rt.PhpVal = rt.new_null()
	visible     rt.PhpVal = rt.new_null()
	variation   rt.PhpVal = rt.new_null()
	is_taxonomy rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_productattribute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		slug:          rt.new_null()
		options:       rt.new_null()
		position:      rt.new_null()
		visible:       rt.new_null()
		variation:     rt.new_null()
		is_taxonomy:   rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'slug' { return this.slug }
		'options' { return this.options }
		'position' { return this.position }
		'visible' { return this.visible }
		'variation' { return this.variation }
		'is_taxonomy' { return this.is_taxonomy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductAttribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'slug' {
			this.slug = val
			return true
		}
		'options' {
			this.options = val
			return true
		}
		'position' {
			this.position = val
			return true
		}
		'visible' {
			this.visible = val
			return true
		}
		'variation' {
			this.variation = val
			return true
		}
		'is_taxonomy' {
			this.is_taxonomy = val
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
