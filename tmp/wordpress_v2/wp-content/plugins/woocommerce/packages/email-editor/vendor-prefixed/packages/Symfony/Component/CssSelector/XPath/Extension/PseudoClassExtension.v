import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) getpseudoclasstranslators() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'root', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateRoot' },
		]) },
		rt.ArrayItem{ key: 'first-child', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateFirstChild' },
		]) },
		rt.ArrayItem{ key: 'last-child', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateLastChild' },
		]) },
		rt.ArrayItem{ key: 'first-of-type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateFirstOfType' },
		]) },
		rt.ArrayItem{ key: 'last-of-type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateLastOfType' },
		]) },
		rt.ArrayItem{ key: 'only-child', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateOnlyChild' },
		]) },
		rt.ArrayItem{ key: 'only-of-type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateOnlyOfType' },
		]) },
		rt.ArrayItem{ key: 'empty', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateEmpty' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translateroot(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('not(parent::*)'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translatefirstchild(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return rt.call_method(rt.call_method(var_xpath.addstarprefix(), 'addNameTest', []rt.PhpVal{}),
		'addCondition', [rt.new_string('position() = 1')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translatelastchild(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return rt.call_method(rt.call_method(var_xpath.addstarprefix(), 'addNameTest', []rt.PhpVal{}),
		'addCondition', [rt.new_string('position() = last()')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translatefirstoftype(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('*'), var_xpath.getelement())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException',
			[]string{},
			create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.new_string('"*:first-of-type" is not implemented.'))))
	}
	return rt.call_method(var_xpath.addstarprefix(), 'addCondition', [
		rt.new_string('position() = 1'),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translatelastoftype(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('*'), var_xpath.getelement())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException',
			[]string{},
			create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.new_string('"*:last-of-type" is not implemented.'))))
	}
	return rt.call_method(var_xpath.addstarprefix(), 'addCondition', [
		rt.new_string('position() = last()'),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translateonlychild(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return rt.call_method(rt.call_method(var_xpath.addstarprefix(), 'addNameTest', []rt.PhpVal{}),
		'addCondition', [rt.new_string('last() = 1')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translateonlyoftype(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	mut var_element := var_xpath.getelement()
	return var_xpath.addcondition(rt.call_function('sprintf', [
		rt.new_string('count(preceding-sibling::%s)=0 and count(following-sibling::%s)=0'),
		var_element.clone(),
		var_element.clone(),
	]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) translateempty(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('not(*) and not(string-length())'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) getname() string {
	return 'pseudo-class'
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_pseudoclassextension(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_abstractextension(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getPseudoClassTranslators' {
			return this.getpseudoclasstranslators()
		}
		'translateRoot' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateroot(mut dispatch_arg_0)
		}
		'translateFirstChild' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatefirstchild(mut dispatch_arg_0)
		}
		'translateLastChild' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatelastchild(mut dispatch_arg_0)
		}
		'translateFirstOfType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatefirstoftype(mut dispatch_arg_0)
		}
		'translateLastOfType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatelastoftype(mut dispatch_arg_0)
		}
		'translateOnlyChild' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateonlychild(mut dispatch_arg_0)
		}
		'translateOnlyOfType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateonlyoftype(mut dispatch_arg_0)
		}
		'translateEmpty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateempty(mut dispatch_arg_0)
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
