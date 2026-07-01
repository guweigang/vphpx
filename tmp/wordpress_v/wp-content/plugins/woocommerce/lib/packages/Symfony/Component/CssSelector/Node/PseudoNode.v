import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode {
	rt.PhpObjectBase
pub mut:
	selector   rt.PhpVal = rt.new_null()
	identifier string
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) construct(mut var_selector Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface, identifier string) {
	this.selector = var_selector.dup()
	this.identifier = identifier.to_lower()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) getselector() rt.PhpVal {
	return this.selector
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) getidentifier() string {
	return this.identifier
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) getspecificity() rt.PhpVal {
	return rt.call_method(rt.call_method(this.selector, 'getSpecificity', []rt.PhpVal{}), 'plus', [
		create_automattic_woocommerce_vendor_symfony_component_cssselector_node_specificity(rt.new_int(0),
			rt.new_int(1), rt.new_int(0)),
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) magic_tostring() string {
	return (rt.call_function('sprintf', [rt.new_string('%s[%s:%s]'),
		this.getnodename(), this.selector, this.identifier])).str()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_pseudonode(arg_0 rt.PhpVal, identifier string) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode{
		PhpObjectBase: rt.PhpObjectBase{}
		selector:      rt.new_null()
		identifier:    ''
	}
	obj.construct(arg_0, identifier)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_abstractnode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_specificity() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getSelector' {
			return this.getselector()
		}
		'getIdentifier' {
			return rt.new_string(this.getidentifier())
		}
		'getSpecificity' {
			return this.getspecificity()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'selector' { return this.selector }
		'identifier' { return rt.new_string(this.identifier) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'selector' {
			this.selector = val
			return true
		}
		'identifier' {
			this.identifier = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_node_pseudonode_php() {
}
