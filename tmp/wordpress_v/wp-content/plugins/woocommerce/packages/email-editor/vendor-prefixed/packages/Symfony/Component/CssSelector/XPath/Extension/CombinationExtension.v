import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) getcombinationtranslators() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: ' ', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateDescendant' },
		]) },
		rt.ArrayItem{ key: '>', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateChild' },
		]) },
		rt.ArrayItem{ key: '+', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateDirectAdjacent' },
		]) },
		rt.ArrayItem{ key: '~', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension', [
				'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateIndirectAdjacent' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) translatedescendant(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_combinedXpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.join(rt.new_string('/descendant-or-self::*/'), rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr',
		[]string{}, var_combinedXpath))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) translatechild(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_combinedXpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.join(rt.new_string('/'), rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr',
		[]string{}, var_combinedXpath))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) translatedirectadjacent(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_combinedXpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return rt.call_method(rt.call_method(var_xpath.join(rt.new_string('/following-sibling::'), rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr',
		[]string{}, var_combinedXpath)), 'addNameTest', []rt.PhpVal{}), 'addCondition', [
		rt.new_string('position() = 1'),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) translateindirectadjacent(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_combinedXpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr) rt.PhpVal {
	return var_xpath.join(rt.new_string('/following-sibling::'), rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr',
		[]string{}, var_combinedXpath))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) getname() string {
	return 'combination'
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_combinationextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getCombinationTranslators' {
			return this.getcombinationtranslators()
		}
		'translateDescendant' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatedescendant(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateChild' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatechild(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateDirectAdjacent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatedirectadjacent(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateIndirectAdjacent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translateindirectadjacent(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_xpath_extension_combinationextension_php() {
}
