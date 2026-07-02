import rt

pub fn Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.no_default() string {
	return ''
}

pub fn Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base() string {
	return 'base'
}

pub fn Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation() string {
	return 'geolocation'
}

pub fn Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax() string {
	return 'geolocation_ajax'
}

struct Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_defaultcustomeraddress(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress {
	mut obj := &Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
