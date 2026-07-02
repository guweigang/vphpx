import rt

pub fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.element_name_in_lower_case() i64 {
	return 1
}

pub fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.attribute_name_in_lower_case() i64 {
	return 2
}

pub fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.attribute_value_in_lower_case() i64 {
	return 4
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension {
	rt.PhpObjectBase
pub mut:
	flags i64
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) construct(flags i64) {
	this.flags = flags
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) setflag(flag i64, on bool) rt.PhpVal {
	if var_on && !(this.hasflag(flag)) {
		this.flags = rt.add(this.flags, rt.new_int(flag))
	}
	if !var_on && this.hasflag(flag) {
		this.flags = rt.sub(this.flags, rt.new_int(flag))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) hasflag(flag i64) bool {
	return (this.flags & flag).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) getnodetranslators() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'Selector', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateSelector' },
		]) },
		rt.ArrayItem{ key: 'CombinedSelector', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateCombinedSelector' },
		]) },
		rt.ArrayItem{ key: 'Negation', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateNegation' },
		]) },
		rt.ArrayItem{ key: 'Function', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateFunction' },
		]) },
		rt.ArrayItem{ key: 'Pseudo', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translatePseudo' },
		]) },
		rt.ArrayItem{ key: 'WC_Vendor_Attribute', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateAttribute' },
		]) },
		rt.ArrayItem{ key: 'Class', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateClass' },
		]) },
		rt.ArrayItem{ key: 'Hash', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateHash' },
		]) },
		rt.ArrayItem{ key: 'Element', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension', [
				'Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translateElement' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translateselector(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	return var_translator.nodetoxpath(var_node.gettree())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translatecombinedselector(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	return var_translator.addcombination(var_node.getcombinator(), var_node.getselector(),
		var_node.getsubselector())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translatenegation(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	mut var_xpath := var_translator.nodetoxpath(var_node.getselector())
	mut var_subXpath := var_translator.nodetoxpath(var_node.getsubselector())
	rt.call_method(var_subXpath, 'addNameTest', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_subXpath, 'getCondition', []rt.PhpVal{})) {
		return rt.call_method(var_xpath, 'addCondition', [
			rt.call_function('sprintf', [rt.new_string('not(%s)'),
				rt.call_method(var_subXpath, 'getCondition', []rt.PhpVal{})]),
		])
	}
	return rt.call_method(var_xpath, 'addCondition', [rt.new_string('0')])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translatefunction(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	mut var_xpath := var_translator.nodetoxpath(var_node.getselector())
	return var_translator.addfunction(var_xpath.clone(), rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode',
		[]string{}, var_node))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translatepseudo(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	mut var_xpath := var_translator.nodetoxpath(var_node.getselector())
	return var_translator.addpseudoclass(var_xpath.clone(), var_node.getidentifier())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translateattribute(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	mut var_name := var_node.getattribute()
	mut var_safe := rt.new_bool(this.issafename(var_name.str()))
	if this.hasflag((Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.attribute_name_in_lower_case()).to_i64()) {
		var_name = rt.new_string(var_name.clone().to_string().to_lower())
	}
	if rt.is_true(var_node.getnamespace()) {
		var_name = rt.call_function('sprintf', [rt.new_string('%s:%s'),
			var_node.getnamespace(), var_name.clone()])
		var_safe = rt.new_bool(rt.is_true(var_safe)
			&& this.issafename((var_node.getnamespace()).str()))
	}
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator{}
	mut iife_result_0 := iife_temp_0.getxpathliteral(var_name.clone())
	mut var_attribute := if rt.is_true(var_safe) { '@' + var_name.str() } else { rt.call_function('sprintf', [
			rt.new_string('attribute::*[name() = %s]'),
			iife_result_0,
		]) }
	mut var_value := var_node.getvalue()
	mut var_xpath := var_translator.nodetoxpath(var_node.getselector())
	if this.hasflag((Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.attribute_value_in_lower_case()).to_i64()) {
		var_value = rt.new_string(var_value.clone().to_string().to_lower())
	}
	return var_translator.addattributematching(var_xpath.clone(), var_node.getoperator(),
		var_attribute.clone(), var_value.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translateclass(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	mut var_xpath := var_translator.nodetoxpath(var_node.getselector())
	return var_translator.addattributematching(var_xpath.clone(), rt.new_string('~='),
		rt.new_string('@class'), var_node.getname())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translatehash(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode, mut var_translator Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) rt.PhpVal {
	mut var_xpath := var_translator.nodetoxpath(var_node.getselector())
	return var_translator.addattributematching(var_xpath.clone(), rt.new_string('='),
		rt.new_string('@id'), var_node.getid())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) translateelement(mut var_node Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode) rt.PhpVal {
	mut var_element := var_node.getelement()
	if rt.is_true(var_element)
		&& this.hasflag((Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension.element_name_in_lower_case()).to_i64()) {
		var_element = rt.new_string(var_element.clone().to_string().to_lower())
	}
	if rt.is_true(var_element) {
		mut var_safe := rt.new_bool(this.issafename(var_element.str()))
	} else {
		var_element = rt.new_string('*')
		var_safe = rt.new_bool(true)
	}
	if rt.is_true(var_node.getnamespace()) {
		var_element = rt.call_function('sprintf', [rt.new_string('%s:%s'),
			var_node.getnamespace(), var_element.clone()])
		var_safe = rt.new_bool(rt.is_true(var_safe)
			&& this.issafename((var_node.getnamespace()).str()))
	}
	mut var_xpath := create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_xpathexpr(rt.new_string(''),
		var_element.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_safe)))) {
		rt.call_method(var_xpath, 'addNameTest', []rt.PhpVal{})
	}
	return var_xpath.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) getname() string {
	return 'node'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) issafename(name string) bool {
	mut name_mutated := name
	return (rt.less(rt.new_int(0), rt.call_function('preg_match', [
		rt.new_string('~^[a-zA-Z_][a-zA-Z0-9_.-]*$~'),
		rt.new_string(name_mutated).clone(),
	]))).to_bool()
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_extension_nodeextension(flags i64) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension{
		PhpObjectBase: rt.PhpObjectBase{}
		flags:         i64(0)
	}
	obj.construct(flags)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_extension_abstractextension(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_translator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_xpathexpr(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'setFlag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.setflag(dispatch_arg_0, dispatch_arg_1)
		}
		'hasFlag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.hasflag(dispatch_arg_0))
		}
		'getNodeTranslators' {
			return this.getnodetranslators()
		}
		'translateSelector' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translateselector(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateCombinedSelector' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatecombinedselector(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateNegation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatenegation(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateFunction' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatefunction(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translatePseudo' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatepseudo(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateAttribute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translateattribute(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateClass' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translateclass(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateHash' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.translatehash(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'translateElement' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.translateelement(mut dispatch_arg_0)
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		'isSafeName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.issafename(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'flags' { return rt.new_int(this.flags) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'flags' {
			this.flags = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_AbstractExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_XPathExpr) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
