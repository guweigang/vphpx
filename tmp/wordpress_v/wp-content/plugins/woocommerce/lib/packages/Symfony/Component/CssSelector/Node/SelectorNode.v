import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode {
	rt.PhpObjectBase
pub mut:
		tree rt.PhpVal = rt.new_null()
		pseudoElement rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) construct(mut var_tree Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface, mut var_pseudoElement Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_?string)  {
	this.tree = var_tree.dup()
	this.pseudoElement = if rt.is_true(var_pseudoElement) { rt.new_string(var_pseudoElement.to_string().to_lower()) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) gettree() rt.PhpVal {
	return this.tree
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) getpseudoelement() string {
	return (this.pseudoElement).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) getspecificity() rt.PhpVal {
	return rt.call_method(rt.call_method(this.tree, 'getSpecificity', []rt.PhpVal{}), 'plus', [create_automattic_woocommerce_vendor_symfony_component_cssselector_node_specificity(rt.new_int(0), rt.new_int(0), if rt.is_true(this.pseudoElement) { rt.new_int(1) } else { rt.new_int(0) })])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) magic_tostring() string {
	return (rt.call_function('sprintf', [rt.new_string('%s[%s%s]'), this.getnodename(), this.tree, if rt.is_true(this.pseudoElement) { '::' + (this.pseudoElement).str() } else { rt.new_string('') }])).str()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_selectornode(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode{
		PhpObjectBase: rt.PhpObjectBase{}
		tree: rt.new_null()
		pseudoElement: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
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

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'getTree' {
			return this.gettree()
		}
		'getPseudoElement' {
			return rt.new_string(this.getpseudoelement())
		}
		'getSpecificity' {
			return this.getspecificity()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree' { return this.tree }
		'pseudoElement' { return this.pseudoElement }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree' { this.tree = val; return true }
		'pseudoElement' { this.pseudoElement = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_node_selectornode_php() {
}
