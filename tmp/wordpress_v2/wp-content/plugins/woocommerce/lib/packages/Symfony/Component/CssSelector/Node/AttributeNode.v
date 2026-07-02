import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode {
	rt.PhpObjectBase
pub mut:
		selector rt.PhpVal = rt.new_null()
		namespace rt.PhpVal = rt.new_null()
		attribute string
		operator string
		value rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) construct(mut var_selector Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface, mut var_namespace Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_?string, attribute string, operator string, mut var_value Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_?string) {
	mut attribute_mutated := attribute
	this.selector = var_selector
	this.namespace = var_namespace
	this.attribute = (rt.new_string(attribute_mutated)).str()
	this.operator = operator
	this.value = var_value
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) getselector() rt.PhpVal {
	return this.selector
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) getnamespace() string {
	return (this.namespace).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) getattribute() string {
	return this.attribute
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) getoperator() string {
	return this.operator
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) getvalue() string {
	return (this.value).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) getspecificity() rt.PhpVal {
	return rt.call_method(rt.call_method(this.selector, 'getSpecificity', []rt.PhpVal{}), 'plus', [create_automattic_woocommerce_vendor_symfony_component_cssselector_node_specificity(rt.new_int(0), rt.new_int(1), rt.new_int(0))])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) magic_tostring() string {
	mut var_attribute := rt.new_string((if rt.is_true(this.namespace) { (this.namespace).str() + '|' + this.attribute } else { this.attribute }).str())
	return (if rt.is_true(rt.identical(rt.new_string('exists'), this.operator)) { rt.call_function('sprintf', [rt.new_string('%s[%s[%s]]'), this.getnodename(), this.selector, var_attribute.clone()]) } else { rt.call_function('sprintf', [rt.new_string('%s[%s[%s %s \'%s\']]'), this.getnodename(), this.selector, var_attribute.clone(), rt.new_string(this.operator), this.value]) }).str()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_attributenode(arg_0 rt.PhpVal, arg_1 rt.PhpVal, attribute string, operator string, arg_4 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode{
		PhpObjectBase: rt.PhpObjectBase{}
		selector: rt.new_null()
		namespace: rt.new_null()
		attribute: ''
		operator: ''
		value: rt.new_null()
	}
	obj.construct(arg_0, arg_1, attribute, operator, arg_4)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_abstractnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_specificity(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'getSelector' {
			return this.getselector()
		}
		'getNamespace' {
			return rt.new_string(this.getnamespace())
		}
		'getAttribute' {
			return rt.new_string(this.getattribute())
		}
		'getOperator' {
			return rt.new_string(this.getoperator())
		}
		'getValue' {
			return rt.new_string(this.getvalue())
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

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'selector' { return this.selector }
		'namespace' { return this.namespace }
		'attribute' { return rt.new_string(this.attribute) }
		'operator' { return rt.new_string(this.operator) }
		'value' { return this.value }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'selector' { this.selector = val; return true }
		'namespace' { this.namespace = val; return true }
		'attribute' { this.attribute = (val).str(); return true }
		'operator' { this.operator = (val).str(); return true }
		'value' { this.value = val; return true }
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



fn main() {
	defer {
		rt.shutdown()
	}

}
