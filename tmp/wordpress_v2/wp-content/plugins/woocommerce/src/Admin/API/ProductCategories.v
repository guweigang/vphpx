import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductCategories {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Categories_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productcategories(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_ProductCategories {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductCategories{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_product_categories_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Categories_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Categories_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductCategories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ProductCategories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductCategories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Categories_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Categories_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Categories_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
