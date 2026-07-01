import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) getfunctiontranslators() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'nth-child', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateNthChild' }]) }, rt.ArrayItem{ key: 'nth-last-child', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateNthLastChild' }]) }, rt.ArrayItem{ key: 'nth-of-type', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateNthOfType' }]) }, rt.ArrayItem{ key: 'nth-last-of-type', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateNthLastOfType' }]) }, rt.ArrayItem{ key: 'contains', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateContains' }]) }, rt.ArrayItem{ key: 'lang', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateLang' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) translatenthchild(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode, last bool, addNameTest bool) rt.PhpVal {
	mut var_a := rt.new_null()
	mut var_b := rt.new_null()
	// unsupported assign target: Expr_List
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException') {
		mut var_e := var_e_1.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.call_function('sprintf', [rt.new_string('Invalid series: "%s".'), rt.call_function('implode', [rt.new_string('", "'), var_function.getarguments()])]), rt.new_int(0), var_e.dup())))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	var_xpath.addstarprefix()
	if var_addNameTest {
		var_xpath.addnametest()
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_a)) {
		return var_xpath.addcondition(rt.new_string('position() = ' + (if var_last { 'last() - ' + (rt.sub(var_b, rt.new_int(1))).str() } else { var_b }).str()))
	}
	if rt.is_true(rt.less(var_a, rt.new_int(0))) {
		if rt.is_true(rt.less(var_b, rt.new_int(1))) {
			return var_xpath.addcondition(rt.new_string('false()'))
		}
		mut var_sign := rt.new_string(rt.new_string('<='))
	} else {
		var_sign = rt.new_string(rt.new_string('>='))
	}
	mut var_expr := rt.new_string(rt.new_string('position()'))
	if var_last {
		var_expr = rt.new_string('last() - ' + (var_expr).str())
		rt.pre_dec(var_b)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_conditions := rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [rt.new_string('%s %s 0'), var_expr.dup(), var_sign.dup()]) }])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_conditions.array_push(rt.call_function('sprintf', [rt.new_string('(%s) mod %d = 0'), var_expr.dup(), var_a.dup()]))
	}
	return var_xpath.addcondition(rt.call_function('implode', [rt.new_string(' and '), var_conditions.dup()]))
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) translatenthlastchild(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode) rt.PhpVal {
	return this.translatenthchild(mut var_xpath, mut var_function, true, false)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) translatenthoftype(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode) rt.PhpVal {
	return this.translatenthchild(mut var_xpath, mut var_function, false, false)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) translatenthlastoftype(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('*'), var_xpath.getelement())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.new_string('"*:nth-of-type()" is not implemented.'))))
	}
	return this.translatenthchild(mut var_xpath, mut var_function, true, false)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) translatecontains(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode) rt.PhpVal {
	mut var_arguments := var_function.getarguments()
	{
		mut iter_1 := var_arguments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_token, 'isString', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_token, 'isIdentifier', []rt.PhpVal{}))))))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception('Expected a single string or identifier for :contains(), got ' + (rt.call_function('implode', [rt.new_string(', '), var_arguments.dup()])).str())))
			}
		}
	}
	return var_xpath.addcondition(rt.call_function('sprintf', [rt.new_string('contains(string(.), %s)'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}; return temp.getxpathliteral(arg_0) }(rt.call_method(var_arguments.array_get(0), 'getValue', []rt.PhpVal{}))]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) translatelang(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode) rt.PhpVal {
	mut var_arguments := var_function.getarguments()
	{
		mut iter_1 := var_arguments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_token, 'isString', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_token, 'isIdentifier', []rt.PhpVal{}))))))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception('Expected a single string or identifier for :lang(), got ' + (rt.call_function('implode', [rt.new_string(', '), var_arguments.dup()])).str())))
			}
		}
	}
	return var_xpath.addcondition(rt.call_function('sprintf', [rt.new_string('lang(%s)'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}; return temp.getxpathliteral(arg_0) }(rt.call_method(var_arguments.array_get(0), 'getValue', []rt.PhpVal{}))]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) getname() string {
	return 'function'
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_functionextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_abstractextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_translator() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getFunctionTranslators' {
			return this.getfunctiontranslators()
		}
		'translateNthChild' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.translatenthchild(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'translateNthLastChild' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.translatenthlastchild(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateNthOfType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.translatenthoftype(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateNthLastOfType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.translatenthlastoftype(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateContains' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.translatecontains(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateLang' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.translatelang(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_xpath_extension_functionextension_php() {
}
