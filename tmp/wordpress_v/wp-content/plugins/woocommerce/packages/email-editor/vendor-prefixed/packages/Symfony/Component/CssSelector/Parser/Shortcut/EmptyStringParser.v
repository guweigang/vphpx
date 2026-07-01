import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser) parse(source string) rt.PhpVal {
	if rt.is_true(rt.equal(rt.new_string(''), rt.new_string(source))) {
		return rt.create_array([
			rt.ArrayItem{ key: none, val: create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_selectornode(create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_elementnode(rt.new_null(),
				rt.new_string('*'))) },
		])
	}
	return rt.new_array()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ElementNode {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_shortcut_emptystringparser() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_selectornode() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_elementnode() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ElementNode {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ElementNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ElementNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ElementNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ElementNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_parser_shortcut_emptystringparser_php() {
}
