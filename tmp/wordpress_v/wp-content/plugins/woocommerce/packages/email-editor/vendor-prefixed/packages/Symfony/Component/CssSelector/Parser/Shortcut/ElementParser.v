import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser) parse(source string) rt.PhpVal {
	mut var_matches := rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^(?:([a-z]++)\\|)?([\\w-]++|\\*)$/i'),
		rt.new_string(source.trim_space()),
		var_matches.dup(),
	]))
	{
		return rt.create_array([
			rt.ArrayItem{ key: none, val: create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_selectornode(create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_elementnode(if rt.is_true(var_matches.array_get(1)) {
				var_matches.array_get(1)
			} else {
				rt.new_null()
			}, var_matches.array_get(2))) },
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

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_shortcut_elementparser() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_parser_shortcut_elementparser_php() {
}
