import rt

pub fn Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() string {
	return 'taxable'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping() string {
	return 'shipping'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() string {
	return 'none'
}

struct Class_Automattic_WooCommerce_Enums_ProductTaxStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_producttaxstatus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_ProductTaxStatus {
	mut obj := &Class_Automattic_WooCommerce_Enums_ProductTaxStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductTaxStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_ProductTaxStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductTaxStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
