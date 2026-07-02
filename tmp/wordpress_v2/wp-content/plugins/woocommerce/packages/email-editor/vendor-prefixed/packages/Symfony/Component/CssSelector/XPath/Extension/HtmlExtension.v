import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) construct(mut var_translator Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) {
	rt.call_method(rt.call_method(var_translator.getextension(rt.new_string('node')), 'setFlag', [
		Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.element_name_in_lower_case(),
		rt.new_bool(true),
	]), 'setFlag', [
		Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.attribute_name_in_lower_case(),
		rt.new_bool(true),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) getpseudoclasstranslators() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'checked', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateChecked' },
		]) },
		rt.ArrayItem{ key: 'link', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateLink' },
		]) },
		rt.ArrayItem{ key: 'disabled', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateDisabled' },
		]) },
		rt.ArrayItem{ key: 'enabled', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateEnabled' },
		]) },
		rt.ArrayItem{ key: 'selected', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateSelected' },
		]) },
		rt.ArrayItem{ key: 'invalid', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateInvalid' },
		]) },
		rt.ArrayItem{ key: 'hover', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateHover' },
		]) },
		rt.ArrayItem{ key: 'visited', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateVisited' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) getfunctiontranslators() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'lang', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateLang' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translatechecked(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('(@checked ' +
		"and (name(.) = 'input' or name(.) = 'command')" +
		"and (@type = 'checkbox' or @type = 'radio'))"))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translatelink(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string("@href and (name(.) = 'a' or name(.) = 'link' or name(.) = 'area')"))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translatedisabled(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('(' + '@disabled and' + '(' +
		"(name(.) = 'input' and @type != 'hidden')" + " or name(.) = 'button'" +
		" or name(.) = 'select'" + " or name(.) = 'textarea'" + " or name(.) = 'command'" +
		" or name(.) = 'fieldset'" + " or name(.) = 'optgroup'" + " or name(.) = 'option'" + ')' +
		') or (' + "(name(.) = 'input' and @type != 'hidden')" + " or name(.) = 'button'" +
		" or name(.) = 'select'" + " or name(.) = 'textarea'" + ')' +
		' and ancestor::fieldset[@disabled]'))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translateenabled(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('(' + '@href and (' + "name(.) = 'a'" +
		" or name(.) = 'link'" + " or name(.) = 'area'" + ')' +
		') or (' + '(' + "name(.) = 'command'" + " or name(.) = 'fieldset'" +
		" or name(.) = 'optgroup'" + ')' + ' and not(@disabled)' +
		') or (' + '(' + "(name(.) = 'input' and @type != 'hidden')" + " or name(.) = 'button'" +
		" or name(.) = 'select'" + " or name(.) = 'textarea'" + " or name(.) = 'keygen'" + ')' +
		' and not (@disabled or ancestor::fieldset[@disabled])' + ') or (' + "name(.) = 'option' and not(" +
		'@disabled or ancestor::optgroup[@disabled]' + ')' + ')'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translatelang(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode) rt.PhpVal {
	mut var_arguments := var_function.getarguments()
	mut iter_1 := var_arguments.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_token := item_1.val
		if !(rt.is_true(rt.call_method(var_token, 'isString', []rt.PhpVal{}))
			|| rt.is_true(rt.call_method(var_token, 'isIdentifier', []rt.PhpVal{}))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException',
				[]string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(
				'Expected a single string or identifier for :lang(), got ' +
				(rt.call_function('implode', [rt.new_string(', '), var_arguments.clone()])).str())))
		}
	}
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_0 := iife_temp_0.getxpathliteral(rt.new_string((
		rt.call_method(var_arguments.array_get(rt.new_int(0)), 'getValue', []rt.PhpVal{}).to_string().to_lower() +
		'-').str()))
	return var_xpath.addcondition(rt.call_function('sprintf', [
		rt.new_string('ancestor-or-self::*[@lang][1][starts-with(concat(' +
			"translate(@%s, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '-')" +
			', %s)]'),
		rt.new_string('lang'),
		iife_result_0,
	]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translateselected(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string("(@selected and name(.) = 'option')"))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translateinvalid(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('0'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translatehover(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('0'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) translatevisited(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string('0'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) getname() string {
	return 'html'
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

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_htmlextension(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
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

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_translator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getPseudoClassTranslators' {
			return this.getpseudoclasstranslators()
		}
		'getFunctionTranslators' {
			return this.getfunctiontranslators()
		}
		'translateChecked' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatechecked(mut dispatch_arg_0)
		}
		'translateLink' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatelink(mut dispatch_arg_0)
		}
		'translateDisabled' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatedisabled(mut dispatch_arg_0)
		}
		'translateEnabled' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateenabled(mut dispatch_arg_0)
		}
		'translateLang' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatelang(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateSelected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateselected(mut dispatch_arg_0)
		}
		'translateInvalid' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateinvalid(mut dispatch_arg_0)
		}
		'translateHover' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatehover(mut dispatch_arg_0)
		}
		'translateVisited' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translatevisited(mut dispatch_arg_0)
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
