import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator {
	rt.PhpObjectBase
pub mut:
		mainParser rt.PhpVal = rt.new_null()
		shortcutParsers rt.PhpVal = rt.new_array()
		extensions rt.PhpVal = rt.new_array()
		nodeTranslators rt.PhpVal = rt.new_array()
		combinationTranslators rt.PhpVal = rt.new_array()
		functionTranslators rt.PhpVal = rt.new_array()
		pseudoClassTranslators rt.PhpVal = rt.new_array()
		attributeMatchingTranslators rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) construct(mut var_parser Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_?ParserInterface)  {
	this.mainParser = if !(var_parser).is_null() { var_parser } else { create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_parser() }
	rt.call_method(rt.call_method(rt.call_method(rt.call_method(this.registerextension(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_ExtensionInterface](create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_nodeextension())), 'registerExtension', [create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_combinationextension()]), 'registerExtension', [create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_functionextension()]), 'registerExtension', [create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_pseudoclassextension()]), 'registerExtension', [create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_attributematchingextension()])
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator.getxpathliteral(element string) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(element), rt.new_string('\'')]))))) {
		return '\'' + element + '\''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(element), rt.new_string('"')]))))) {
		return '"' + element + '"'
	}
	mut var_string := rt.new_string(rt.new_string(element))
	mut var_parts := rt.new_array()
	for true {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_parts.array_push(rt.call_function('sprintf', [rt.new_string('\'%s\''), rt.call_function('substr', [var_string.dup(), rt.new_int(0), var_pos.dup()])]))
			var_parts.array_push('"\'"')
			var_string = rt.call_function('substr', [var_string.dup(), rt.add(var_pos, rt.new_int(1))])
		} else {
			var_parts.array_push("'${var_string.to_string()}'")
			break
		}
	}
	return (rt.call_function('sprintf', [rt.new_string('concat(%s)'), rt.call_function('implode', [rt.new_string(', '), var_parts.dup()])])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) csstoxpath(cssExpr string, prefix string) string {
	mut var_selectors := this.parseselectors(cssExpr)
	{
		mut iter_1 := var_selectors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_selector := item_1.val
			mut var_index := item_1.key
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.new_string('Pseudo-elements are not supported.'))))
			}
			var_selectors.array_set(var_index, this.selectortoxpath(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode](var_selector), prefix))
		}
	}
	return (rt.call_function('implode', [rt.new_string(' | '), var_selectors.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) selectortoxpath(mut var_selector Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode, prefix string) string {
	return if var_prefix.len > 0 && var_prefix != '0' { prefix } else { '' } + (this.nodetoxpath(mut var_selector)).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) registerextension(mut var_extension Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_ExtensionInterface) rt.PhpVal {
	this.extensions.array_set(var_extension.getname(), var_extension.dup())
	this.nodeTranslators = rt.call_function('array_merge', [this.nodeTranslators, var_extension.getnodetranslators()])
	this.combinationTranslators = rt.call_function('array_merge', [this.combinationTranslators, var_extension.getcombinationtranslators()])
	this.functionTranslators = rt.call_function('array_merge', [this.functionTranslators, var_extension.getfunctiontranslators()])
	this.pseudoClassTranslators = rt.call_function('array_merge', [this.pseudoClassTranslators, var_extension.getpseudoclasstranslators()])
	this.attributeMatchingTranslators = rt.call_function('array_merge', [this.attributeMatchingTranslators, var_extension.getattributematchingtranslators()])
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) getextension(name string) rt.PhpVal {
	if !(this.extensions.array_isset(rt.new_string(name))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.call_function('sprintf', [rt.new_string('Extension "%s" not registered.'), rt.new_string(name)]))))
	}
	return this.extensions.array_get(name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) registerparsershortcut(mut var_shortcut Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_ParserInterface) rt.PhpVal {
	this.shortcutParsers.array_push(var_shortcut.dup())
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) nodetoxpath(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface) rt.PhpVal {
	if !(this.nodeTranslators.array_isset(var_node.getnodename())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.call_function('sprintf', [rt.new_string('Node "%s" not supported.'), var_node.getnodename()]))))
	}
	return rt.call_callable(this.nodeTranslators.array_get(var_node.getnodename()), [var_node, rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator', ['TranslatorInterface'], &this)])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) addcombination(combiner string, mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface, mut var_combinedXpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface) rt.PhpVal {
	if !(this.combinationTranslators.array_isset(rt.new_string(combiner))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.call_function('sprintf', [rt.new_string('Combiner "%s" not supported.'), rt.new_string(combiner)]))))
	}
	return rt.call_callable(this.combinationTranslators.array_get(combiner), [this.nodetoxpath(mut var_xpath), this.nodetoxpath(mut var_combinedXpath)])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) addfunction(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, mut var_function Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode) rt.PhpVal {
	if !(this.functionTranslators.array_isset(var_function.getname())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.call_function('sprintf', [rt.new_string('Function "%s" not supported.'), var_function.getname()]))))
	}
	return rt.call_callable(this.functionTranslators.array_get(var_function.getname()), [var_xpath, var_function])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) addpseudoclass(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, pseudoClass string) rt.PhpVal {
	if !(this.pseudoClassTranslators.array_isset(rt.new_string(pseudoClass))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.call_function('sprintf', [rt.new_string('Pseudo-class "%s" not supported.'), rt.new_string(pseudoClass)]))))
	}
	return rt.call_callable(this.pseudoClassTranslators.array_get(pseudoClass), [var_xpath])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) addattributematching(mut var_xpath Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr, operator string, attribute string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_?string) rt.PhpVal {
	if !(this.attributeMatchingTranslators.array_isset(rt.new_string(operator))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException', []string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_exception_expressionerrorexception(rt.call_function('sprintf', [rt.new_string('EmailEditorVendor_Attribute matcher operator "%s" not supported.'), rt.new_string(operator)]))))
	}
	return rt.call_callable(this.attributeMatchingTranslators.array_get(operator), [var_xpath, rt.new_string(attribute), var_value])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) parseselectors(css string) rt.PhpVal {
	{
		mut iter_1 := this.shortcutParsers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_shortcut := item_1.val
			mut var_tokens := rt.call_method(var_shortcut, 'parse', [rt.new_string(css)])
			if !(!rt.is_true(var_tokens)) {
				return var_tokens.dup()
			}
		}
	}
	return rt.call_method(this.mainParser, 'parse', [rt.new_string(css)])
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Parser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ExpressionErrorException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_translator(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator{
		PhpObjectBase: rt.PhpObjectBase{}
		mainParser: rt.new_null()
		shortcutParsers: rt.new_array()
		extensions: rt.new_array()
		nodeTranslators: rt.new_array()
		combinationTranslators: rt.new_array()
		functionTranslators: rt.new_array()
		pseudoClassTranslators: rt.new_array()
		attributeMatchingTranslators: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_parser() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Parser {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_nodeextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_combinationextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_functionextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_pseudoclassextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_xpath_extension_attributematchingextension() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_?ParserInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getXpathLiteral' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator.getxpathliteral(dispatch_arg_0))
		}
		'cssToXPath' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.csstoxpath(dispatch_arg_0, dispatch_arg_1))
		}
		'selectorToXPath' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_SelectorNode](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.selectortoxpath(mut dispatch_arg_0, dispatch_arg_1))
		}
		'registerExtension' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_ExtensionInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.registerextension(mut dispatch_arg_0)
		}
		'getExtension' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getextension(dispatch_arg_0)
		}
		'registerParserShortcut' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_ParserInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.registerparsershortcut(mut dispatch_arg_0)
		}
		'nodeToXPath' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.nodetoxpath(mut dispatch_arg_0)
		}
		'addCombination' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.addcombination(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'addFunction' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_FunctionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.addfunction(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'addPseudoClass' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.addpseudoclass(mut dispatch_arg_0, dispatch_arg_1)
		}
		'addAttributeMatching' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_XPathExpr](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.addattributematching(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'parseSelectors' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parseselectors(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'mainParser' { return this.mainParser }
		'shortcutParsers' { return this.shortcutParsers }
		'extensions' { return this.extensions }
		'nodeTranslators' { return this.nodeTranslators }
		'combinationTranslators' { return this.combinationTranslators }
		'functionTranslators' { return this.functionTranslators }
		'pseudoClassTranslators' { return this.pseudoClassTranslators }
		'attributeMatchingTranslators' { return this.attributeMatchingTranslators }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'mainParser' { this.mainParser = val; return true }
		'shortcutParsers' { this.shortcutParsers = val; return true }
		'extensions' { this.extensions = val; return true }
		'nodeTranslators' { this.nodeTranslators = val; return true }
		'combinationTranslators' { this.combinationTranslators = val; return true }
		'functionTranslators' { this.functionTranslators = val; return true }
		'pseudoClassTranslators' { this.pseudoClassTranslators = val; return true }
		'attributeMatchingTranslators' { this.attributeMatchingTranslators = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_NodeExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_CombinationExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_FunctionExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_PseudoClassExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_XPath_Extension_AttributeMatchingExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_xpath_translator_php() {
}
