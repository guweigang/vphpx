import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) getattributematchingtranslators() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'exists', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateExists' }]) }, rt.ArrayItem{ key: '=', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateEquals' }]) }, rt.ArrayItem{ key: '~=', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateIncludes' }]) }, rt.ArrayItem{ key: '|=', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateDashMatch' }]) }, rt.ArrayItem{ key: '^=', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translatePrefixMatch' }]) }, rt.ArrayItem{ key: '$=', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateSuffixMatch' }]) }, rt.ArrayItem{ key: '*=', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateSubstringMatch' }]) }, rt.ArrayItem{ key: '!=', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension', ['Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension'], &this) }, rt.ArrayItem{ key: none, val: 'translateDifferent' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translateexists(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	return var_xpath.addcondition(rt.new_string(attribute))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translateequals(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_0 := iife_temp_0.getxpathliteral(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string', []string{}, var_value))
	return var_xpath.addcondition(rt.call_function('sprintf', [rt.new_string('%s = %s'), rt.new_string(attribute), iife_result_0]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translateincludes(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_1 := iife_temp_1.getxpathliteral(rt.new_string(' ' + (var_value).str() + ' '))
	return var_xpath.addcondition(if rt.is_true(var_value) { rt.call_function('sprintf', [rt.new_string('%1$s and contains(concat(\' \', normalize-space(%1$s), \' \'), %2$s)'), rt.new_string(attribute), iife_result_1]) } else { rt.new_string('0') })
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translatedashmatch(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_2 := iife_temp_2.getxpathliteral(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string', []string{}, var_value))
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_3 := iife_temp_3.getxpathliteral(rt.new_string((var_value).str() + '-'))
	return var_xpath.addcondition(rt.call_function('sprintf', [rt.new_string('%1$s and (%1$s = %2$s or starts-with(%1$s, %3$s))'), rt.new_string(attribute), iife_result_2, iife_result_3]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translateprefixmatch(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_4 := iife_temp_4.getxpathliteral(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string', []string{}, var_value))
	return var_xpath.addcondition(if rt.is_true(var_value) { rt.call_function('sprintf', [rt.new_string('%1$s and starts-with(%1$s, %2$s)'), rt.new_string(attribute), iife_result_4]) } else { rt.new_string('0') })
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translatesuffixmatch(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_5 := iife_temp_5.getxpathliteral(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string', []string{}, var_value))
	return var_xpath.addcondition(if rt.is_true(var_value) { rt.call_function('sprintf', [rt.new_string('%1$s and substring(%1$s, string-length(%1$s)-%2$s) = %3$s'), rt.new_string(attribute), rt.new_int(var_value.to_string().len - 1), iife_result_5]) } else { rt.new_string('0') })
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translatesubstringmatch(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	mut iife_temp_6 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_6 := iife_temp_6.getxpathliteral(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string', []string{}, var_value))
	return var_xpath.addcondition(if rt.is_true(var_value) { rt.call_function('sprintf', [rt.new_string('%1$s and contains(%1$s, %2$s)'), rt.new_string(attribute), iife_result_6]) } else { rt.new_string('0') })
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) translatedifferent(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string) rt.PhpVal {
	mut iife_temp_7 := Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_7 := iife_temp_7.getxpathliteral(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string', []string{}, var_value))
	return var_xpath.addcondition(rt.call_function('sprintf', [rt.new_string((if rt.is_true(var_value) { 'not(%1$s) or %1$s != %2$s' } else { '%s != %s' }).str()), rt.new_string(attribute), iife_result_7]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) getname() string {
	return 'attribute-matching'
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_attributematchingextension(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension{
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

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_translator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getAttributeMatchingTranslators' {
			return this.getattributematchingtranslators()
		}
		'translateExists' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translateexists(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'translateEquals' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translateequals(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'translateIncludes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translateincludes(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'translateDashMatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translatedashmatch(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'translatePrefixMatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translateprefixmatch(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'translateSuffixMatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translatesuffixmatch(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'translateSubstringMatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translatesubstringmatch(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'translateDifferent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.translatedifferent(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
