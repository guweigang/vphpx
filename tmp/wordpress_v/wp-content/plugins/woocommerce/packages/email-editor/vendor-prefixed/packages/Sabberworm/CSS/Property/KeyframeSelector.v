import rt

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_KeyframeSelector.selector_validation_rx() string {
	return '/\n    ^(\n        (?:\n            [a-zA-Z0-9\\x{00A0}-\\x{FFFF}_^$|*="\'~\\[\\]()\\-\\s\\.:#+>]* # any sequence of valid unescaped characters\n            (?:\\\\.)?                                              # a single escaped character\n            (?:([\'"]).*?(?<!\\\\)\\2)?                              # a quoted text like [id="example"]\n        )*\n    )|\n    (\\d+%)                                                          # keyframe animation progress percentage (e.g. 50%)\n    $\n    /ux'
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_KeyframeSelector {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_keyframeselector() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_KeyframeSelector {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_KeyframeSelector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_selector() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_KeyframeSelector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_KeyframeSelector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_KeyframeSelector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_property_keyframeselector_php() {
}
