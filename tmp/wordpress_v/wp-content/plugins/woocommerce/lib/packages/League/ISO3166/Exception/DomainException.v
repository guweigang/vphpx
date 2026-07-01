import rt

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_league_iso3166_exception_domainexception() &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_Exception_DomainException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_league_iso3166_exception_domainexception_php() {
	// unsupported statement: Stmt_Declare
}
