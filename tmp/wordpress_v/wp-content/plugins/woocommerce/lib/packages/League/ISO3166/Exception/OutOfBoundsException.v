import rt

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_league_iso3166_exception_outofboundsexception() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_OutOfBoundsException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_league_iso3166_exception_outofboundsexception_php() {
	// unsupported statement: Stmt_Declare
}
