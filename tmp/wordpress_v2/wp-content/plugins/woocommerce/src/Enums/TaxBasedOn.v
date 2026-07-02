import rt

pub fn Class_Automattic_WooCommerce_Enums_TaxBasedOn.shipping() string {
	return 'shipping'
}

pub fn Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing() string {
	return 'billing'
}

pub fn Class_Automattic_WooCommerce_Enums_TaxBasedOn.base() string {
	return 'base'
}

struct Class_Automattic_WooCommerce_Enums_TaxBasedOn {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_taxbasedon(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_TaxBasedOn {
	mut obj := &Class_Automattic_WooCommerce_Enums_TaxBasedOn{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_TaxBasedOn) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_TaxBasedOn) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_TaxBasedOn) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
