import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) getnodetranslators() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) getcombinationtranslators() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) getfunctiontranslators() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) getpseudoclasstranslators() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) getattributematchingtranslators() rt.PhpVal {
	return rt.new_array()
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_extension_abstractextension() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getNodeTranslators' {
			return this.getnodetranslators()
		}
		'getCombinationTranslators' {
			return this.getcombinationtranslators()
		}
		'getFunctionTranslators' {
			return this.getfunctiontranslators()
		}
		'getPseudoClassTranslators' {
			return this.getpseudoclasstranslators()
		}
		'getAttributeMatchingTranslators' {
			return this.getattributematchingtranslators()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_xpath_extension_abstractextension_php() {
}
