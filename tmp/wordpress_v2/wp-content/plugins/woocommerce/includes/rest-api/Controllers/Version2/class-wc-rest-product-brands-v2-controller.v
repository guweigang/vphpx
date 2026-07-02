import rt

struct Class_WC_REST_Product_Brands_V2_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('products/brands')
	taxonomy  rt.PhpVal = rt.new_string('product_brand')
}

struct Class_WC_REST_Product_Categories_V2_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_product_brands_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Brands_V2_Controller {
	mut obj := &Class_WC_REST_Product_Brands_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('products/brands')
		taxonomy:      rt.new_string('product_brand')
	}
	return obj
}

fn create_wc_rest_product_categories_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Categories_V2_Controller {
	mut obj := &Class_WC_REST_Product_Categories_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Product_Brands_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Brands_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'taxonomy' { return this.taxonomy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Brands_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'taxonomy' {
			this.taxonomy = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Product_Categories_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Categories_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Categories_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
