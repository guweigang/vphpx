import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode {
	rt.PhpObjectBase
pub mut:
	selector  rt.PhpVal = rt.new_null()
	name      string
	arguments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) construct(mut var_selector Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface, name string, mut var_arguments Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_array) {
	mut var_arguments_mutated := var_arguments
	this.selector = var_selector.dup()
	this.name = name.to_lower()
	this.arguments = var_arguments_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) getselector() rt.PhpVal {
	return this.selector
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) getname() string {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) getarguments() rt.PhpVal {
	return this.arguments
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) getspecificity() rt.PhpVal {
	return rt.call_method(rt.call_method(this.selector, 'getSpecificity', []rt.PhpVal{}), 'plus', [
		create_automattic_woocommerce_vendor_symfony_component_cssselector_node_specificity(rt.new_int(0),
			rt.new_int(1), rt.new_int(0)),
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) magic_tostring() string {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return "'" + (rt.call_method(var_token, 'getValue', []rt.PhpVal{})).str() + "'"
		}
		mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return "'" + (rt.call_method(var_token, 'getValue', []rt.PhpVal{})).str() + "'"
	}
	mut var_arguments := rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.arguments])])
	return (rt.call_function('sprintf', [rt.new_string('%s[%s:%s(%s)]'),
		this.getnodename(), this.selector, this.name, if rt.is_true(var_arguments) {
			'[' + var_arguments.str() + ']'
		} else {
			rt.new_string('')
		}])).str()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AbstractNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_Specificity {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_functionnode(arg_0 rt.PhpVal, name string, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode{
		PhpObjectBase: rt.PhpObjectBase{}
		selector:      rt.new_null()
		name:          ''
		arguments:     rt.new_null()
	}
	obj.construct(arg_0, name, arg_2)
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

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_array](if args.len > 2 {
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
		'getName' {
			return rt.new_string(this.getname())
		}
		'getArguments' {
			return this.getarguments()
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

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'selector' { return this.selector }
		'name' { return rt.new_string(this.name) }
		'arguments' { return this.arguments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'selector' {
			this.selector = val
			return true
		}
		'name' {
			this.name = val.str()
			return true
		}
		'arguments' {
			this.arguments = val
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_node_functionnode_php() {
}
