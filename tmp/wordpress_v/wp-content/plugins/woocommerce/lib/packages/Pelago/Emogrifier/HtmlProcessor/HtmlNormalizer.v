import rt

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlNormalizer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_htmlprocessor_htmlnormalizer() &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlNormalizer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlNormalizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor() &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlNormalizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlNormalizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlNormalizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_pelago_emogrifier_htmlprocessor_htmlnormalizer_php() {
	// unsupported statement: Stmt_Declare
}
