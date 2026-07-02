import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock {
	rt.PhpObjectBase
pub mut:
		aSelectors rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) construct(iLineNo i64) {
	this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet.construct(rt.new_int(iLineNo))
	this.aSelectors = rt.new_array()
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock.parse(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState, var_oList rt.PhpVal) rt.PhpVal {
	mut var_aComments := rt.new_array()
	mut var_oResult := create_automattic_woocommerce_vendor_sabberworm_css_ruleset_declarationblock(var_oParserState.currentline())
	mut var_aSelectorParts := rt.new_array()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_sStringWrapperChar := rt.new_bool(false)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	for {
		var_aSelectorParts.array_push((var_oParserState.consume(rt.new_int(1))).str() + (var_oParserState.consumeuntil(rt.create_array([rt.ArrayItem{ key: none, val: '{' }, rt.ArrayItem{ key: none, val: '}' }, rt.ArrayItem{ key: none, val: '\'' }, rt.ArrayItem{ key: none, val: '"' }]), rt.new_bool(false), rt.new_bool(false), var_aComments.clone())).str())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.call_function('in_array', [var_oParserState.peek(), rt.create_array([rt.ArrayItem{ key: none, val: '\'' }, rt.ArrayItem{ key: none, val: '"' }])])) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr', [rt.call_function('end', [var_aSelectorParts.clone()]), rt.new_int(-1)]), rt.new_string('\\'))))) {
			if rt.is_true(rt.identical(var_sStringWrapperChar, rt.new_bool(false))) {
				var_sStringWrapperChar = var_oParserState.peek()
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			} else if rt.is_true(rt.equal(var_sStringWrapperChar, var_oParserState.peek())) {
				var_sStringWrapperChar = rt.new_bool(false)
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_oParserState.peek(), rt.create_array([rt.ArrayItem{ key: none, val: '{' }, rt.ArrayItem{ key: none, val: '}' }])]))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sStringWrapperChar, rt.new_bool(false)))))) {
			break
		}
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_oResult.setselectors(rt.call_function('implode', [rt.new_string(''), var_aSelectorParts.clone()]), var_oList.clone())
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
		mut var_e := var_e_1.clone()
		if rt.is_true(rt.get_property(var_oParserState.getsettings(), 'bLenientParsing')) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState.comes(rt.new_string('}')))))) {
				var_oParserState.consumeuntil(rt.new_string('}'), rt.new_bool(false), rt.new_bool(true))
			}
			return rt.new_bool(false)
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
	var_oResult.setcomments(var_aComments.clone())
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet{}
	mut iife_result_0 := iife_temp_0.parseruleset(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState), rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock', []string{}, var_oResult))
	return rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock', []string{}, var_oResult)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) setselectors(var_mSelector rt.PhpVal, var_oList rt.PhpVal) {
	mut var_mSelector_mutated := var_mSelector
	if rt.is_true(rt.new_bool(var_mSelector_mutated.clone().is_array())) {
		this.aSelectors = var_mSelector_mutated.clone()
	} else {
		this.aSelectors = rt.call_function('explode', [rt.new_string(','), var_mSelector_mutated.clone()])
	}
	mut iter_1 := this.aSelectors.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_mSelector_shadow := item_1.val
		mut var_iKey := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mSelector_shadow, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector')))))) {
			if rt.is_true(rt.identical(var_oList, rt.new_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oList, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_KeyFrame')))))) {
				mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector{}
				mut iife_result_1 := iife_temp_1.isvalid(var_mSelector_shadow.clone())
				if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception('Selector did not match \'' + (Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector.selector_validation_rx()).str() + '\'.', var_mSelector_shadow.clone(), rt.new_string('custom'))))
				}
				this.aSelectors.array_set(var_iKey, create_automattic_woocommerce_vendor_sabberworm_css_property_selector(var_mSelector_shadow.clone()))
			} else {
				mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector{}
				mut iife_result_2 := iife_temp_2.isvalid(var_mSelector_shadow.clone())
				if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception('Selector did not match \'' + (Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector.selector_validation_rx()).str() + '\'.', var_mSelector_shadow.clone(), rt.new_string('custom'))))
				}
				this.aSelectors.array_set(var_iKey, create_automattic_woocommerce_vendor_sabberworm_css_property_keyframeselector(var_mSelector_shadow.clone()))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) removeselector(var_mSelector rt.PhpVal) bool {
	mut var_mSelector_mutated := var_mSelector
	if rt.is_true(rt.new_bool(rt.instance_of(var_mSelector_mutated, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector'))) {
	var_mSelector_mutated = rt.call_method(var_mSelector_mutated, 'getSelector', []rt.PhpVal{})
	}
	mut iter_2 := this.aSelectors.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_oSelector := item_2.val
		mut var_iKey := item_2.key
		if rt.is_true(rt.identical(rt.call_method(var_oSelector, 'getSelector', []rt.PhpVal{}), var_mSelector_mutated)) {
			this.aSelectors.array_unset(var_iKey)
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) getselector() rt.PhpVal {
	return this.getselectors()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) setselector(var_mSelector rt.PhpVal, var_oList rt.PhpVal) {
	mut var_mSelector_mutated := var_mSelector
	this.setselectors(var_mSelector_mutated.clone(), var_oList.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) getselectors() rt.PhpVal {
	return this.aSelectors
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandshorthands() {
	this.expandbordershorthand()
	this.expanddimensionsshorthand()
	this.expandfontshorthand()
	this.expandbackgroundshorthand()
	this.expandliststyleshorthand()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createshorthands() {
	this.createbackgroundshorthand()
	this.createdimensionsshorthand()
	this.createbordershorthand()
	this.createfontshorthand()
	this.createliststyleshorthand()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandbordershorthand() {
	mut var_aBorderRules := rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'border-left' }, rt.ArrayItem{ key: none, val: 'border-right' }, rt.ArrayItem{ key: none, val: 'border-top' }, rt.ArrayItem{ key: none, val: 'border-bottom' }])
	mut var_aBorderSizes := rt.create_array([rt.ArrayItem{ key: none, val: 'thin' }, rt.ArrayItem{ key: none, val: 'medium' }, rt.ArrayItem{ key: none, val: 'thick' }])
	mut var_aRules := this.getrulesassoc()
	mut iter_3 := var_aBorderRules.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_sBorderRule := item_3.val
		if !(var_aRules.array_isset(var_sBorderRule)) {
			continue
		}
		mut var_oRule := var_aRules.array_get(var_sBorderRule)
		mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
		mut var_aValues := rt.new_array()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
			var_aValues.array_push(var_mRuleValue.clone())
		} else {
		var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
		}
		mut iter_4 := var_aValues.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_mValue := item_4.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value'))) {
			mut var_mNewValue := var_mValue.dup()
			} else {
			var_mNewValue = var_mValue.clone()
			}
			if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size'))) {
			mut var_sNewRuleName := rt.new_string((var_sBorderRule).str() + '-width')
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color'))) {
			var_sNewRuleName = rt.new_string((var_sBorderRule).str() + '-color')
			} else {
				if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), var_aBorderSizes.clone()])) {
				var_sNewRuleName = rt.new_string((var_sBorderRule).str() + '-width')
				} else {
				var_sNewRuleName = rt.new_string((var_sBorderRule).str() + '-style')
				}
			}
			mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sNewRuleName.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
			var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
			var_oNewRule.addvalue(rt.create_array([rt.ArrayItem{ key: none, val: var_mNewValue }]))
			this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
		}
		this.removerule(var_sBorderRule.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expanddimensionsshorthand() {
	mut var_{"nodeType":"Expr_Variable","line":336,"name":"sPosition"} := rt.new_null()
	mut var_aExpansions := rt.create_array([rt.ArrayItem{ key: 'margin', val: 'margin-%s' }, rt.ArrayItem{ key: 'padding', val: 'padding-%s' }, rt.ArrayItem{ key: 'border-color', val: 'border-%s-color' }, rt.ArrayItem{ key: 'border-style', val: 'border-%s-style' }, rt.ArrayItem{ key: 'border-width', val: 'border-%s-width' }])
	mut var_aRules := this.getrulesassoc()
	mut iter_5 := var_aExpansions.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_sExpanded := item_5.val
		mut var_sProperty := item_5.key
		if !(var_aRules.array_isset(var_sProperty)) {
			continue
		}
		mut var_oRule := var_aRules.array_get(var_sProperty)
		mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
		mut var_aValues := rt.new_array()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
			var_aValues.array_push(var_mRuleValue.clone())
		} else {
		var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
		}
		mut var_left := rt.new_null()
		mut var_bottom := var_left
		mut var_right := var_bottom
		mut var_top := var_right
		match var_aValues.clone().array_count() {
			1 {
			var_left = var_aValues.array_get(rt.new_int(0))
			var_bottom = var_left
			var_right = var_bottom
			var_top = var_right
			}
			2 {
			var_bottom = var_aValues.array_get(rt.new_int(0))
			var_top = var_bottom
			var_right = var_aValues.array_get(rt.new_int(1))
			var_left = var_right
			}
			3 {
			var_top = var_aValues.array_get(rt.new_int(0))
			var_right = var_aValues.array_get(rt.new_int(1))
			var_left = var_right
			var_bottom = var_aValues.array_get(rt.new_int(2))
			}
			4 {
			var_top = var_aValues.array_get(rt.new_int(0))
			var_right = var_aValues.array_get(rt.new_int(1))
			var_bottom = var_aValues.array_get(rt.new_int(2))
			var_left = var_aValues.array_get(rt.new_int(3))
			}
		}
		mut iter_6 := rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'bottom' }, rt.ArrayItem{ key: none, val: 'left' }]).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_sPosition := item_6.val
			mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(rt.call_function('sprintf', [var_sExpanded.clone(), var_sPosition.clone()]), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
			var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
			var_oNewRule.addvalue(var_{"nodeType":"Expr_Variable","line":336,"name":"sPosition"}.clone())
			this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
		}
		this.removerule(var_sProperty.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandfontshorthand() {
	mut var_oSize := rt.new_null()
	mut var_oHeight := rt.new_null()
	mut var_aRules := this.getrulesassoc()
	if !(var_aRules.array_isset(rt.new_string('font'))) {
		return
	}
	mut var_oRule := var_aRules.array_get(rt.new_string('font'))
	mut var_aFontProperties := rt.create_array([rt.ArrayItem{ key: 'font-style', val: 'normal' }, rt.ArrayItem{ key: 'font-variant', val: 'normal' }, rt.ArrayItem{ key: 'font-weight', val: 'normal' }, rt.ArrayItem{ key: 'font-size', val: 'normal' }, rt.ArrayItem{ key: 'line-height', val: 'normal' }])
	mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
	mut var_aValues := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
		var_aValues.array_push(var_mRuleValue.clone())
	} else {
	var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
	}
	mut iter_7 := var_aValues.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_mValue := item_7.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value')))))) {
		var_mValue = rt.call_function('mb_strtolower', [var_mValue.clone()])
		}
		if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'normal' }, rt.ArrayItem{ key: none, val: 'inherit' }])])) {
			mut iter_8 := rt.create_array([rt.ArrayItem{ key: none, val: 'font-style' }, rt.ArrayItem{ key: none, val: 'font-weight' }, rt.ArrayItem{ key: none, val: 'font-variant' }]).iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_sProperty := item_8.val
				if !(var_aFontProperties.array_isset(var_sProperty)) {
					var_aFontProperties.array_set(var_sProperty, var_mValue.clone())
				}
			}
		} else if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'italic' }, rt.ArrayItem{ key: none, val: 'oblique' }])])) {
			var_aFontProperties.array_set('font-style', var_mValue.clone())
		} else if rt.is_true(rt.equal(var_mValue, rt.new_string('small-caps'))) {
			var_aFontProperties.array_set('font-variant', var_mValue.clone())
		} else if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'bold' }, rt.ArrayItem{ key: none, val: 'bolder' }, rt.ArrayItem{ key: none, val: 'lighter' }])])) || (rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size'))) && rt.is_true(rt.call_function('in_array', [rt.call_method(var_mValue, 'getSize', []rt.PhpVal{}), rt.call_function('range', [rt.new_int(100), rt.new_int(900), rt.new_int(100)])]))) {
			var_aFontProperties.array_set('font-weight', var_mValue.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList'))) && rt.is_true(rt.equal(rt.call_method(var_mValue, 'getListSeparator', []rt.PhpVal{}), rt.new_string('/'))) {
			mut list_tmp_1 := rt.call_method(var_mValue, 'getListComponents', []rt.PhpVal{})
			var_oSize = (list_tmp_1).array_get(0)
			var_oHeight = (list_tmp_1).array_get(1)
			var_aFontProperties.array_set('font-size', var_oSize.clone())
			var_aFontProperties.array_set('line-height', var_oHeight.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_mValue, 'getUnit', []rt.PhpVal{}), rt.new_null())))) {
			var_aFontProperties.array_set('font-size', var_mValue.clone())
		} else {
			var_aFontProperties.array_set('font-family', var_mValue.clone())
		}
	}
	mut iter_9 := var_aFontProperties.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_mValue := item_9.val
		mut var_sProperty := item_9.key
		mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sProperty.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
		var_oNewRule.addvalue(var_mValue.clone())
		var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
		this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
	}
	this.removerule(rt.new_string('font'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandbackgroundshorthand() {
	mut var_aRules := this.getrulesassoc()
	if !(var_aRules.array_isset(rt.new_string('background'))) {
		return
	}
	mut var_oRule := var_aRules.array_get(rt.new_string('background'))
	mut var_aBgProperties := rt.create_array([rt.ArrayItem{ key: 'background-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'transparent' }]) }, rt.ArrayItem{ key: 'background-image', val: rt.create_array([rt.ArrayItem{ key: none, val: 'none' }]) }, rt.ArrayItem{ key: 'background-repeat', val: rt.create_array([rt.ArrayItem{ key: none, val: 'repeat' }]) }, rt.ArrayItem{ key: 'background-attachment', val: rt.create_array([rt.ArrayItem{ key: none, val: 'scroll' }]) }, rt.ArrayItem{ key: 'background-position', val: rt.create_array([rt.ArrayItem{ key: none, val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(0), rt.new_string('%'), rt.new_bool(false), this.getlineno()) }, rt.ArrayItem{ key: none, val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(0), rt.new_string('%'), rt.new_bool(false), this.getlineno()) }]) }])
	mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
	mut var_aValues := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
		var_aValues.array_push(var_mRuleValue.clone())
	} else {
	var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
	}
	if var_aValues.clone().array_count() == 1 && rt.is_true(rt.equal(var_aValues.array_get(rt.new_int(0)), rt.new_string('inherit'))) {
		mut iter_10 := var_aBgProperties.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_mValue := item_10.val
			mut var_sProperty := item_10.key
			mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sProperty.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
			var_oNewRule.addvalue(rt.new_string('inherit'))
			var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
			this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
		}
		this.removerule(rt.new_string('background'))
		return
	}
	mut var_iNumBgPos := rt.new_int(0)
	mut iter_11 := var_aValues.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_mValue := item_11.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value')))))) {
		var_mValue = rt.call_function('mb_strtolower', [var_mValue.clone()])
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL'))) {
			var_aBgProperties.array_set('background-image', var_mValue.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color'))) {
			var_aBgProperties.array_set('background-color', var_mValue.clone())
		} else if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'scroll' }, rt.ArrayItem{ key: none, val: 'fixed' }])])) {
			var_aBgProperties.array_set('background-attachment', var_mValue.clone())
		} else if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'no-repeat' }, rt.ArrayItem{ key: none, val: 'repeat-x' }, rt.ArrayItem{ key: none, val: 'repeat-y' }])])) {
			var_aBgProperties.array_set('background-repeat', var_mValue.clone())
		} else if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'bottom' }])])) || rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size'))) {
			if rt.is_true(rt.equal(var_iNumBgPos, rt.new_int(0))) {
				var_aBgProperties.array_get_mut('background-position').array_set(0, var_mValue.clone())
				var_aBgProperties.array_get_mut('background-position').array_set(1, 'center')
			} else {
				var_aBgProperties.array_get_mut('background-position').array_set(var_iNumBgPos, var_mValue.clone())
			}
			rt.post_inc(var_iNumBgPos)
		}
	}
	mut iter_12 := var_aBgProperties.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_mValue := item_12.val
		mut var_sProperty := item_12.key
		mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sProperty.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
		var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
		var_oNewRule.addvalue(var_mValue.clone())
		this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
	}
	this.removerule(rt.new_string('background'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) expandliststyleshorthand() {
	mut var_aListProperties := rt.create_array([rt.ArrayItem{ key: 'list-style-type', val: 'disc' }, rt.ArrayItem{ key: 'list-style-position', val: 'outside' }, rt.ArrayItem{ key: 'list-style-image', val: 'none' }])
	mut var_aListStyleTypes := rt.create_array([rt.ArrayItem{ key: none, val: 'none' }, rt.ArrayItem{ key: none, val: 'disc' }, rt.ArrayItem{ key: none, val: 'circle' }, rt.ArrayItem{ key: none, val: 'square' }, rt.ArrayItem{ key: none, val: 'decimal-leading-zero' }, rt.ArrayItem{ key: none, val: 'decimal' }, rt.ArrayItem{ key: none, val: 'lower-roman' }, rt.ArrayItem{ key: none, val: 'upper-roman' }, rt.ArrayItem{ key: none, val: 'lower-greek' }, rt.ArrayItem{ key: none, val: 'lower-alpha' }, rt.ArrayItem{ key: none, val: 'lower-latin' }, rt.ArrayItem{ key: none, val: 'upper-alpha' }, rt.ArrayItem{ key: none, val: 'upper-latin' }, rt.ArrayItem{ key: none, val: 'hebrew' }, rt.ArrayItem{ key: none, val: 'armenian' }, rt.ArrayItem{ key: none, val: 'georgian' }, rt.ArrayItem{ key: none, val: 'cjk-ideographic' }, rt.ArrayItem{ key: none, val: 'hiragana' }, rt.ArrayItem{ key: none, val: 'hira-gana-iroha' }, rt.ArrayItem{ key: none, val: 'katakana-iroha' }, rt.ArrayItem{ key: none, val: 'katakana' }])
	mut var_aListStylePositions := rt.create_array([rt.ArrayItem{ key: none, val: 'inside' }, rt.ArrayItem{ key: none, val: 'outside' }])
	mut var_aRules := this.getrulesassoc()
	if !(var_aRules.array_isset(rt.new_string('list-style'))) {
		return
	}
	mut var_oRule := var_aRules.array_get(rt.new_string('list-style'))
	mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
	mut var_aValues := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
		var_aValues.array_push(var_mRuleValue.clone())
	} else {
	var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
	}
	if var_aValues.clone().array_count() == 1 && rt.is_true(rt.equal(var_aValues.array_get(rt.new_int(0)), rt.new_string('inherit'))) {
		mut iter_13 := var_aListProperties.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_mValue := item_13.val
			mut var_sProperty := item_13.key
			mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sProperty.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
			var_oNewRule.addvalue(rt.new_string('inherit'))
			var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
			this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
		}
		this.removerule(rt.new_string('list-style'))
		return
	}
	mut iter_14 := var_aValues.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_mValue := item_14.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value')))))) {
		var_mValue = rt.call_function('mb_strtolower', [var_mValue.clone()])
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_Url'))) {
			var_aListProperties.array_set('list-style-image', var_mValue.clone())
		} else if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), var_aListStyleTypes.clone()])) {
			var_aListProperties.array_set('list-style-types', var_mValue.clone())
		} else if rt.is_true(rt.call_function('in_array', [var_mValue.clone(), var_aListStylePositions.clone()])) {
			var_aListProperties.array_set('list-style-position', var_mValue.clone())
		}
	}
	mut iter_15 := var_aListProperties.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_mValue := item_15.val
		mut var_sProperty := item_15.key
		mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sProperty.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
		var_oNewRule.setisimportant(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))
		var_oNewRule.addvalue(var_mValue.clone())
		this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
	}
	this.removerule(rt.new_string('list-style'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createshorthandproperties(mut var_aProperties Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_array, var_sShorthand rt.PhpVal) {
	mut var_aProperties_mutated := var_aProperties
	mut var_aRules := this.getrulesassoc()
	mut var_oRule := rt.new_null()
	mut var_aNewValues := rt.new_array()
	mut iter_16 := var_aProperties_mutated.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_sProperty := item_16.val
		if !(var_aRules.array_isset(var_sProperty)) {
			continue
		}
		var_oRule = var_aRules.array_get(var_sProperty)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_oRule, 'getIsImportant', []rt.PhpVal{}))))) {
			mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
			mut var_aValues := rt.new_array()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
				var_aValues.array_push(var_mRuleValue.clone())
			} else {
			var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
			}
			mut iter_17 := var_aValues.iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_mValue := item_17.val
				var_aNewValues.array_push(var_mValue.clone())
			}
			this.removerule(var_sProperty.clone())
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_aNewValues, rt.new_array())))) && rt.is_true(rt.new_bool(rt.instance_of(var_oRule, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule'))) {
		mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sShorthand.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
		mut iter_18 := var_aNewValues.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_mValue := item_18.val
			var_oNewRule.addvalue(var_mValue.clone())
		}
		this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createbackgroundshorthand() {
	mut var_aProperties := rt.create_array([rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'background-image' }, rt.ArrayItem{ key: none, val: 'background-repeat' }, rt.ArrayItem{ key: none, val: 'background-position' }, rt.ArrayItem{ key: none, val: 'background-attachment' }])
	this.createshorthandproperties(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_array](var_aProperties), rt.new_string('background'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createliststyleshorthand() {
	mut var_aProperties := rt.create_array([rt.ArrayItem{ key: none, val: 'list-style-type' }, rt.ArrayItem{ key: none, val: 'list-style-position' }, rt.ArrayItem{ key: none, val: 'list-style-image' }])
	this.createshorthandproperties(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_array](var_aProperties), rt.new_string('list-style'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createbordershorthand() {
	mut var_aProperties := rt.create_array([rt.ArrayItem{ key: none, val: 'border-width' }, rt.ArrayItem{ key: none, val: 'border-style' }, rt.ArrayItem{ key: none, val: 'border-color' }])
	this.createshorthandproperties(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_array](var_aProperties), rt.new_string('border'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createdimensionsshorthand() {
	mut var_aPositions := rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'bottom' }, rt.ArrayItem{ key: none, val: 'left' }])
	mut var_aExpansions := rt.create_array([rt.ArrayItem{ key: 'margin', val: 'margin-%s' }, rt.ArrayItem{ key: 'padding', val: 'padding-%s' }, rt.ArrayItem{ key: 'border-color', val: 'border-%s-color' }, rt.ArrayItem{ key: 'border-style', val: 'border-%s-style' }, rt.ArrayItem{ key: 'border-width', val: 'border-%s-width' }])
	mut var_aRules := this.getrulesassoc()
	mut iter_19 := var_aExpansions.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_sExpanded := item_19.val
		mut var_sProperty := item_19.key
		mut var_aFoldable := rt.new_array()
		mut iter_20 := var_aRules.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_oRule := item_20.val
			mut var_sRuleName := item_20.key
			mut iter_21 := var_aPositions.iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_sPosition := item_21.val
				if rt.is_true(rt.equal(var_sRuleName, rt.call_function('sprintf', [var_sExpanded.clone(), var_sPosition.clone()]))) {
					var_aFoldable.array_set(var_sRuleName, var_oRule.clone())
				}
			}
		}
		if var_aFoldable.clone().array_count() == 4 {
			mut var_aValues := rt.new_array()
			mut iter_22 := var_aPositions.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_sPosition := item_22.val
				mut var_oRule := var_aRules.array_get(rt.call_function('sprintf', [var_sExpanded.clone(), var_sPosition.clone()]))
				mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
				mut var_aRuleValues := rt.new_array()
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
					var_aRuleValues.array_push(var_mRuleValue.clone())
				} else {
				var_aRuleValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
				}
				var_aValues.array_set(var_sPosition, var_aRuleValues.clone())
			}
			mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(var_sProperty.clone(), rt.call_method(var_oRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oRule, 'getColNo', []rt.PhpVal{}))
			if rt.is_true(rt.equal((var_aValues.array_get(rt.new_string('left')).array_get(rt.new_int(0))).str(), (var_aValues.array_get(rt.new_string('right')).array_get(rt.new_int(0))).str())) {
				if rt.is_true(rt.equal((var_aValues.array_get(rt.new_string('top')).array_get(rt.new_int(0))).str(), (var_aValues.array_get(rt.new_string('bottom')).array_get(rt.new_int(0))).str())) {
					if rt.is_true(rt.equal((var_aValues.array_get(rt.new_string('top')).array_get(rt.new_int(0))).str(), (var_aValues.array_get(rt.new_string('left')).array_get(rt.new_int(0))).str())) {
						var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('top')))
					} else {
						var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('top')))
						var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('left')))
					}
				} else {
					var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('top')))
					var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('left')))
					var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('bottom')))
				}
			} else {
				var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('top')))
				var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('left')))
				var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('bottom')))
				var_oNewRule.addvalue(var_aValues.array_get(rt.new_string('right')))
			}
			this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
			mut iter_23 := var_aPositions.iterator()
			for {
				item_23 := iter_23.next() or { break }
				mut var_sPosition := item_23.val
				this.removerule(rt.call_function('sprintf', [var_sExpanded.clone(), var_sPosition.clone()]))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) createfontshorthand() {
	mut var_aFontProperties := rt.create_array([rt.ArrayItem{ key: none, val: 'font-style' }, rt.ArrayItem{ key: none, val: 'font-variant' }, rt.ArrayItem{ key: none, val: 'font-weight' }, rt.ArrayItem{ key: none, val: 'font-size' }, rt.ArrayItem{ key: none, val: 'line-height' }, rt.ArrayItem{ key: none, val: 'font-family' }])
	mut var_aRules := this.getrulesassoc()
	if !(var_aRules.array_isset(rt.new_string('font-size'))) || !(var_aRules.array_isset(rt.new_string('font-family'))) {
		return
	}
	mut var_oOldRule := if var_aRules.array_isset(rt.new_string('font-size')) { var_aRules.array_get(rt.new_string('font-size')) } else { var_aRules.array_get(rt.new_string('font-family')) }
	mut var_oNewRule := create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(rt.new_string('font'), rt.call_method(var_oOldRule, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_oOldRule, 'getColNo', []rt.PhpVal{}))
	var_oOldRule = rt.new_null()
	mut iter_24 := rt.create_array([rt.ArrayItem{ key: none, val: 'font-style' }, rt.ArrayItem{ key: none, val: 'font-variant' }, rt.ArrayItem{ key: none, val: 'font-weight' }]).iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_sProperty := item_24.val
		if var_aRules.array_isset(var_sProperty) {
			mut var_oRule := var_aRules.array_get(var_sProperty)
			mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
			mut var_aValues := rt.new_array()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
				var_aValues.array_push(var_mRuleValue.clone())
			} else {
			var_aValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_aValues.array_get(rt.new_int(0)), rt.new_string('normal'))))) {
				var_oNewRule.addvalue(var_aValues.array_get(rt.new_int(0)))
			}
		}
	}
	mut var_oRule := var_aRules.array_get(rt.new_string('font-size'))
	mut var_mRuleValue := rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
	mut var_aFSValues := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
		var_aFSValues.array_push(var_mRuleValue.clone())
	} else {
	var_aFSValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
	}
	if var_aRules.array_isset(rt.new_string('line-height')) {
		var_oRule = var_aRules.array_get(rt.new_string('line-height'))
		var_mRuleValue = rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
		mut var_aLHValues := rt.new_array()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
			var_aLHValues.array_push(var_mRuleValue.clone())
		} else {
		var_aLHValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_aLHValues.array_get(rt.new_int(0)), rt.new_string('normal'))))) {
			mut var_val := create_automattic_woocommerce_vendor_sabberworm_css_value_rulevaluelist(rt.new_string('/'), this.getlineno())
			var_val.addlistcomponent(var_aFSValues.array_get(rt.new_int(0)))
			var_val.addlistcomponent(var_aLHValues.array_get(rt.new_int(0)))
			var_oNewRule.addvalue(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList', []string{}, var_val))
		}
	} else {
		var_oNewRule.addvalue(var_aFSValues.array_get(rt.new_int(0)))
	}
	var_oRule = var_aRules.array_get(rt.new_string('font-family'))
	var_mRuleValue = rt.call_method(var_oRule, 'getValue', []rt.PhpVal{})
	mut var_aFFValues := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mRuleValue, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList')))))) {
		var_aFFValues.array_push(var_mRuleValue.clone())
	} else {
	var_aFFValues = rt.call_method(var_mRuleValue, 'getListComponents', []rt.PhpVal{})
	}
	mut var_oFFValue := create_automattic_woocommerce_vendor_sabberworm_css_value_rulevaluelist(rt.new_string(','), this.getlineno())
	var_oFFValue.setlistcomponents(var_aFFValues.clone())
	var_oNewRule.addvalue(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList', []string{}, var_oFFValue))
	this.addrule(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule', []string{}, var_oNewRule))
	mut iter_25 := var_aFontProperties.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_sProperty := item_25.val
		this.removerule(var_sProperty.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) magic_tostring() rt.PhpVal {
	return this.render(create_automattic_woocommerce_vendor_sabberworm_css_outputformat())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock) render(var_oOutputFormat rt.PhpVal) rt.PhpVal {
	mut var_sResult := rt.call_method(var_oOutputFormat, 'comments', [rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock', ['Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet'], &this)])
	if this.aSelectors.array_count() == 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_outputexception(rt.new_string('Attempt to print declaration block with missing selector'), this.getlinenumber())))
	}
	var_sResult = rt.concat(var_sResult, rt.get_property(var_oOutputFormat, 'sBeforeDeclarationBlock'))
	var_sResult = rt.concat(var_sResult, rt.call_method(var_oOutputFormat, 'implode', [rt.new_string((rt.call_method(var_oOutputFormat, 'spaceBeforeSelectorSeparator', []rt.PhpVal{})).str() + ',' + (rt.call_method(var_oOutputFormat, 'spaceAfterSelectorSeparator', []rt.PhpVal{})).str()), this.aSelectors]))
	var_sResult = rt.concat(var_sResult, rt.get_property(var_oOutputFormat, 'sAfterDeclarationBlockSelectors'))
	var_sResult = rt.concat(var_sResult, rt.new_string((rt.call_method(var_oOutputFormat, 'spaceBeforeOpeningBrace', []rt.PhpVal{})).str() + '{'))
	var_sResult = rt.concat(var_sResult, this.renderrules(var_oOutputFormat.clone()))
	var_sResult = rt.concat(var_sResult, rt.new_string('}'))
	var_sResult = rt.concat(var_sResult, rt.get_property(var_oOutputFormat, 'sAfterDeclarationBlock'))
	return var_sResult.clone()
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

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException {
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

fn create_automattic_woocommerce_vendor_sabberworm_css_ruleset_ruleset(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_property_selector(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_Selector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_property_keyframeselector(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Property_KeyframeSelector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_rule_rule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_size(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_rulevaluelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_outputformat(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_outputexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException{
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


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
