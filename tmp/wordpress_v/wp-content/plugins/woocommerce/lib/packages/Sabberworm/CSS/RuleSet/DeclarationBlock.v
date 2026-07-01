import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock {
	rt.PhpObjectBase
pub mut:
		aSelectors rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) construct(iLineNo i64)  {
	this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet.construct(rt.new_int(iLineNo))
	this.aSelectors = rt.new_array()
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock.parse(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState, var_oList rt.PhpVal) rt.PhpVal {
	mut var_aComments := rt.new_array()
	mut var_oResult := create_automattic_woocommerce_vendor_sabberworm_css_ruleset_declarationblock(var_oParserState.currentline())
	mut var_aSelectorParts := rt.new_array()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_sStringWrapperChar := rt.new_bool(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	for {
		var_aSelectorParts.array_push((var_oParserState.consume(rt.new_int(1))).str() + (var_oParserState.consumeuntil(rt.create_array([rt.ArrayItem{ key: none, val: '{' }, rt.ArrayItem{ key: none, val: '}' }, rt.ArrayItem{ key: none, val: '\'' }, rt.ArrayItem{ key: none, val: '"' }]), rt.new_bool(false), rt.new_bool(false), var_aComments.dup())).str())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_oParserState.peek(), rt.create_array([rt.ArrayItem{ key: none, val: '\'' }, rt.ArrayItem{ key: none, val: '"' }])])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
			if rt.is_true(rt.identical(var_sStringWrapperChar, rt.new_bool(false))) {
				var_sStringWrapperChar = var_oParserState.peek()
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			} else if rt.is_true(rt.equal(var_sStringWrapperChar, var_oParserState.peek())) {
				var_sStringWrapperChar = rt.new_bool(rt.new_bool(false))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_oParserState.peek(), rt.create_array([rt.ArrayItem{ key: none, val: '{' }, rt.ArrayItem{ key: none, val: '}' }])]))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))) {
			break
		}
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_oResult.setselectors(rt.call_function('implode', [rt.new_string(''), var_aSelectorParts.dup()]), var_oList.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(var_oParserState.comes(rt.new_string('{'))) {
		var_oParserState.consume(rt.new_int(1))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException') {
		mut var_e := var_e_1.dup()
		if rt.is_true(rt.get_property(var_oParserState.getsettings(), 'bLenientParsing')) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState.comes(rt.new_string('}')))))) {
				var_oParserState.consumeuntil(rt.new_string('}'), rt.new_bool(false), rt.new_bool(true))
			}
			return mut false
		} else {
			rt.throw_exception(var_e)
		}
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	var_oResult.setcomments(var_aComments.dup())
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet{}; return temp.parseruleset(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState), rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock', []string{}, var_oResult))
	return mut var_oResult
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) setselectors(var_mSelector rt.PhpVal, var_oList rt.PhpVal)  {
	mut var_mSelector_mutated := var_mSelector
	if rt.is_true(rt.new_bool(var_mSelector_mutated.dup().is_array())) {
		this.aSelectors = var_mSelector_mutated.dup()
	} else {
		this.aSelectors = rt.call_function('explode', [rt.new_string(','), var_mSelector_mutated.dup()])
	}
	{
		mut iter_1 := this.aSelectors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_mSelector_shadow := item_1.val
			mut var_iKey := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mSelector_shadow, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector')))))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_oList, rt.new_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oList, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_KeyFrame')))))))) {
					if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector{}; return temp.isvalid(arg_0) }(var_mSelector_shadow.dup()))))) {
						rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception('Selector did not match \'' + (Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.selector_validation_rx()).str() + '\'.', var_mSelector_shadow.dup(), rt.new_string('custom'))))
					}
					this.aSelectors.array_set(var_iKey, create_automattic_woocommerce_vendor_sabberworm_css_property_selector(var_mSelector_shadow.dup()))
				} else {
					if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector{}; return temp.isvalid(arg_0) }(var_mSelector_shadow.dup()))))) {
						rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception('Selector did not match \'' + (Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector.selector_validation_rx()).str() + '\'.', var_mSelector_shadow.dup(), rt.new_string('custom'))))
					}
					this.aSelectors.array_set(var_iKey, create_automattic_woocommerce_vendor_sabberworm_css_property_keyframeselector(var_mSelector_shadow.dup()))
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) removeselector(var_mSelector rt.PhpVal) bool {
	mut var_mSelector_mutated := var_mSelector
	if rt.is_true(rt.new_bool(rt.instance_of(var_mSelector_mutated, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector'))) {
		var_mSelector_mutated = rt.call_method(var_mSelector_mutated, 'getSelector', []rt.PhpVal{})
	}
	{
		mut iter_1 := this.aSelectors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_oSelector := item_1.val
			mut var_iKey := item_1.key
			if rt.is_true(rt.identical(rt.call_method(var_oSelector, 'getSelector', []rt.PhpVal{}), var_mSelector_mutated)) {
				this.aSelectors.array_unset(var_iKey)
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) getselector() rt.PhpVal {
	return this.getselectors()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) setselector(var_mSelector rt.PhpVal, var_oList rt.PhpVal)  {
	mut var_mSelector_mutated := var_mSelector
	this.setselectors(var_mSelector_mutated.dup(), var_oList.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) getselectors() rt.PhpVal {
	return this.aSelectors
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandshorthands()  {
	this.expandbordershorthand()
	this.expanddimensionsshorthand()
	this.expandfontshorthand()
	this.expandbackgroundshorthand()
	this.expandliststyleshorthand()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createshorthands()  {
	this.createbackgroundshorthand()
	this.createdimensionsshorthand()
	this.createbordershorthand()
	this.createfontshorthand()
	this.createliststyleshorthand()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandbordershorthand()  {
	mut var_aBorderRules := rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'border-left' }, rt.ArrayItem{ key: none, val: 'border-right' }, rt.ArrayItem{ key: none, val: 'border-top' }, rt.ArrayItem{ key: none, val: 'border-bottom' }])
	mut var_aBorderSizes := rt.create_array([rt.ArrayItem{ key: none, val: 'thin' }, rt.ArrayItem{ key: none, val: 'medium' }, rt.ArrayItem{ key: none, val: 'thick' }])
	mut var_aRules := this.getrulesassoc()
	{
		mut iter_1 := var_aBorderRules.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sBorderRule := item_1.val
			if !(var_aRules.array_isset(var_sBorderRule)) {
				continue
			}
			mut var_oRule := var_aRules.array_get(var_sBorderRule)
			mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
			mut var_aValues := rt.new_array()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
				var_aValues.array_push(var_mRuleValue.dup())
			} else {
				var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
			}
			{
				mut iter_2 := var_aValues.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_mValue := item_2.val
					if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value'))) {
						mut var_mNewValue := // unsupported expression: Expr_Clone
					} else {
						var_mNewValue = var_mValue.dup()
					}
					if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size'))) {
						mut var_sNewRuleName := rt.new_string((var_sBorderRule).str() + '-width')
					} else if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color'))) {
						var_sNewRuleName = rt.new_string((var_sBorderRule).str() + '-color')
					} else {
						if rt.is_true(rt.call_function('in_array', [var_mValue.dup(), var_aBorderSizes.dup()])) {
							var_sNewRuleName = rt.new_string((var_sBorderRule).str() + '-width')
						} else {
							var_sNewRuleName = rt.new_string((var_sBorderRule).str() + '-style')
						}
					}
					mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sNewRuleName.dup(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
					var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
					var_oNewRule.addvalue(rt.create_array([rt.ArrayItem{ key: none, val: var_mNewValue }]))
					this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
				}
			}
			this.removerule(var_sBorderRule.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expanddimensionsshorthand()  {
	mut var_{"nodeType":"Expr_Variable","line":336,"name":"sPosition"} := rt.new_null()
	mut var_aExpansions := rt.create_array([rt.ArrayItem{ key: 'margin', val: 'margin-%s' }, rt.ArrayItem{ key: 'padding', val: 'padding-%s' }, rt.ArrayItem{ key: 'border-color', val: 'border-%s-color' }, rt.ArrayItem{ key: 'border-style', val: 'border-%s-style' }, rt.ArrayItem{ key: 'border-width', val: 'border-%s-width' }])
	mut var_aRules := this.getrulesassoc()
	{
		mut iter_1 := var_aExpansions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sExpanded := item_1.val
			mut var_sProperty := item_1.key
			if !(var_aRules.array_isset(var_sProperty)) {
				continue
			}
			mut var_oRule := var_aRules.array_get(var_sProperty)
			mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
			mut var_aValues := rt.new_array()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
				var_aValues.array_push(var_mRuleValue.dup())
			} else {
				var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
			}
			mut var_top := mut var_right := mut var_bottom := mut var_left := rt.new_null()
			match var_aValues.dup().array_count() {
				1 {
					var_top = var_right = var_bottom = var_left = .array_get()
				}
				2 {
					var_top = var_bottom = var_aValues.array_get(0)
					var_left = var_right = .array_get()
				}
				3 {
					var_top = .array_get()
					var_left = 
					
				}
				4 {
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandfontshorthand()  {
	mut var_oSize := rt.new_null()
	mut var_oHeight := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandbackgroundshorthand()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandliststyleshorthand()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createshorthandproperties(mut var_aProperties Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_array, var_sShorthand rt.PhpVal)  {
	mut var_aProperties_mutated := var_aProperties
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createbackgroundshorthand()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createliststyleshorthand()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createbordershorthand()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createdimensionsshorthand()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createfontshorthand()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) magic_tostring() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) render(var_oOutputFormat rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_ruleset_declarationblock(iLineNo i64) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		aSelectors: rt.new_null()
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_ruleset_ruleset() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_property_selector() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_property_keyframeselector() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_rule_rule() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock.parse(mut dispatch_arg_0, dispatch_arg_1)
		}
		'setSelectors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.setselectors(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'removeSelector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.removeselector(dispatch_arg_0))
		}
		'getSelector' {
			return this.getselector()
		}
		'setSelector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.setselector(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getSelectors' {
			return this.getselectors()
		}
		'expandShorthands' {
			this.expandshorthands()
			return rt.new_null()
		}
		'createShorthands' {
			this.createshorthands()
			return rt.new_null()
		}
		'expandBorderShorthand' {
			this.expandbordershorthand()
			return rt.new_null()
		}
		'expandDimensionsShorthand' {
			this.expanddimensionsshorthand()
			return rt.new_null()
		}
		'expandFontShorthand' {
			this.expandfontshorthand()
			return rt.new_null()
		}
		'expandBackgroundShorthand' {
			this.expandbackgroundshorthand()
			return rt.new_null()
		}
		'expandListStyleShorthand' {
			this.expandliststyleshorthand()
			return rt.new_null()
		}
		'createShorthandProperties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.createshorthandproperties(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'createBackgroundShorthand' {
			this.createbackgroundshorthand()
			return rt.new_null()
		}
		'createListStyleShorthand' {
			this.createliststyleshorthand()
			return rt.new_null()
		}
		'createBorderShorthand' {
			this.createbordershorthand()
			return rt.new_null()
		}
		'createDimensionsShorthand' {
			this.createdimensionsshorthand()
			return rt.new_null()
		}
		'createFontShorthand' {
			this.createfontshorthand()
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'aSelectors' { return this.aSelectors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'aSelectors' { this.aSelectors = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_ruleset_declarationblock_php() {
}
