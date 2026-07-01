import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode {
	rt.PhpObjectBase
pub mut:
	selector rt.PhpVal = rt.new_null()
	name     string
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) construct(mut var_selector Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface, name string) {
	this.selector = var_selector.dup()
	this.name = name
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) getselector() rt.PhpVal {
	return this.selector
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) getname() string {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) getspecificity() rt.PhpVal {
	return rt.call_method(rt.call_method(this.selector, 'getSpecificity', []rt.PhpVal{}), 'plus', [
		create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_specificity(rt.new_int(0),
			rt.new_int(1), rt.new_int(0)),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) magic_tostring() string {
	return (rt.call_function('sprintf', [rt.new_string('%s[%s.%s]'),
		this.getnodename(), this.selector, this.name])).str()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_classnode(arg_0 rt.PhpVal, name string) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode{
		PhpObjectBase: rt.PhpObjectBase{}
		selector:      rt.new_null()
		name:          ''
	}
	obj.construct(arg_0, name)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_abstractnode() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_specificity() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 {
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
		'getName' {
			return rt.new_string(this.getname())
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

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'selector' { return this.selector }
		'name' { return rt.new_string(this.name) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_ClassNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'selector' {
			this.selector = val
			return true
		}
		'name' {
			this.name = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_AbstractNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_node_classnode_php() {
}
