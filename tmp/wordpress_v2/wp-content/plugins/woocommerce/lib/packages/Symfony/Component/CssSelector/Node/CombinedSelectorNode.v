import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode {
	rt.PhpObjectBase
pub mut:
	selector    rt.PhpVal = rt.new_null()
	combinator  string
	subSelector rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) construct(mut var_selector Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface, combinator string, mut var_subSelector Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface) {
	mut combinator_mutated := combinator
	this.selector = var_selector
	this.combinator = (rt.new_string(combinator_mutated)).str()
	this.subSelector = var_subSelector
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) getselector() rt.PhpVal {
	return this.selector
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) getcombinator() string {
	return this.combinator
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) getsubselector() rt.PhpVal {
	return this.subSelector
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) getspecificity() rt.PhpVal {
	return rt.call_method(rt.call_method(this.selector, 'getSpecificity', []rt.PhpVal{}), 'plus', [
		rt.call_method(this.subSelector, 'getSpecificity', []rt.PhpVal{}),
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) magic_tostring() string {
	mut var_combinator := rt.new_string((if rt.is_true(rt.identical(rt.new_string(' '),
		this.combinator))
	{
		'<followed>'
	} else {
		this.combinator
	}).str())
	return (rt.call_function('sprintf', [rt.new_string('%s[%s %s %s]'),
		this.getnodename(), this.selector, var_combinator.clone(), this.subSelector])).str()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_combinedselectornode(arg_0 rt.PhpVal, combinator string, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode{
		PhpObjectBase: rt.PhpObjectBase{}
		selector:      rt.new_null()
		combinator:    ''
		subSelector:   rt.new_null()
	}
	obj.construct(arg_0, combinator, arg_2)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_abstractnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'getSelector' {
			return this.getselector()
		}
		'getCombinator' {
			return rt.new_string(this.getcombinator())
		}
		'getSubSelector' {
			return this.getsubselector()
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

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'selector' { return this.selector }
		'combinator' { return rt.new_string(this.combinator) }
		'subSelector' { return this.subSelector }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'selector' {
			this.selector = val
			return true
		}
		'combinator' {
			this.combinator = val.str()
			return true
		}
		'subSelector' {
			this.subSelector = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
