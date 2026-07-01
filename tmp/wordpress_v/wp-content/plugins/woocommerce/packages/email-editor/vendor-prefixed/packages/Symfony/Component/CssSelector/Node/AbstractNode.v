import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode {
	rt.PhpObjectBase
pub mut:
	nodeName rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode) getnodename() string {
	if rt.is_true(rt.identical(rt.new_null(), this.nodeName)) {
		this.nodeName = rt.call_function('preg_replace', [
			rt.new_string('~.*\\\\([^\\\\]+)Node$~'),
			rt.new_string('$1'),
			Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_static.class(),
		])
	}
	return (this.nodeName).str()
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_abstractnode() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode{
		PhpObjectBase: rt.PhpObjectBase{}
		nodeName:      rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getNodeName' {
			return rt.new_string(this.getnodename())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'nodeName' { return this.nodeName }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'nodeName' {
			this.nodeName = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_node_abstractnode_php() {
}
