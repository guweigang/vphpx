import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_expressionerrorexception() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_parseexception() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_exception_expressionerrorexception_php() {
}
