import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr {
	rt.PhpObjectBase
pub mut:
		path string
		element rt.PhpVal = rt.new_null()
		condition rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) construct(path string, element string, condition string, starPrefix bool)  {
	mut path_mutated := path
	mut condition_mutated := condition
	this.path = (rt.new_string(path_mutated)).str()
	this.element = rt.new_string(element).dup()
	this.condition = rt.new_string(condition_mutated).dup()
	if var_starPrefix {
		this.addstarprefix()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) getelement() string {
	return (this.element).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) addcondition(condition string) rt.PhpVal {
	mut condition_mutated := condition
	this.condition = if rt.is_true(this.condition) { rt.call_function('sprintf', [rt.new_string('(%s) and (%s)'), this.condition, rt.new_string(condition_mutated).dup()]) } else { rt.new_string(condition_mutated) }
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) getcondition() string {
	return (this.condition).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) addnametest() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.addcondition('name() = ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator{}; return temp.getxpathliteral(arg_0) }(this.element)).str())
		this.element = rt.new_string('*')
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) addstarprefix() rt.PhpVal {
	// unsupported expression: Expr_AssignOp_Concat
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) join(combiner string, mut var_expr Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_self) rt.PhpVal {
	mut var_path := rt.new_string(this.magic_tostring() + combiner)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	this.path = (var_path).str()
	this.element = rt.get_property(var_expr, 'element')
	this.condition = rt.get_property(var_expr, 'condition')
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) magic_tostring() string {
	mut var_path := rt.new_string(this.path + (this.element).str())
	mut var_condition := rt.new_string(if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), this.condition)) || rt.is_true(rt.identical(rt.new_string(''), this.condition)))) { rt.new_string('') } else { '[' + (this.condition).str() + ']' })
	return (var_path).str() + (var_condition).str()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_xpathexpr(path string, element string, condition string, starPrefix bool) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr{
		PhpObjectBase: rt.PhpObjectBase{}
		path: ''
		element: rt.new_null()
		condition: rt.new_null()
	}
	obj.construct(path, element, condition, starPrefix)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_translator() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'getElement' {
			return rt.new_string(this.getelement())
		}
		'addCondition' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.addcondition(dispatch_arg_0)
		}
		'getCondition' {
			return rt.new_string(this.getcondition())
		}
		'addNameTest' {
			return this.addnametest()
		}
		'addStarPrefix' {
			return this.addstarprefix()
		}
		'join' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_self](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.join(dispatch_arg_0, mut dispatch_arg_1)
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'path' { return rt.new_string(this.path) }
		'element' { return this.element }
		'condition' { return this.condition }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'path' { this.path = (val).str(); return true }
		'element' { this.element = val; return true }
		'condition' { this.condition = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_xpath_xpathexpr_php() {
}
