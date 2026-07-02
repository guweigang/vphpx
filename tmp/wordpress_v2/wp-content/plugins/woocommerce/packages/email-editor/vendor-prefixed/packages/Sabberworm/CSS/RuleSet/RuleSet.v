import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet {
	rt.PhpObjectBase
pub mut:
		aRules rt.PhpVal = rt.new_null()
		aComments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) construct(iLineNo i64) {
	this.aRules = rt.new_array()
	this.setposition(rt.new_int(iLineNo))
	this.aComments = rt.new_array()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet.parseruleset(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, mut var_oRuleSet Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) {
	for rt.is_true(var_oParserState.comes(rt.new_string(';'))) {
		var_oParserState.consume(rt.new_string(';'))
	}
	for true {
		mut var_commentsBeforeRule := var_oParserState.consumewhitespace()
		if rt.is_true(var_oParserState.comes(rt.new_string('}'))) {
			break
		}
		mut var_oRule := rt.new_null()
		if rt.is_true(rt.get_property(var_oParserState.getsettings(), 'bLenientParsing')) {
			mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule{}
			mut iife_result_0 := iife_temp_0.parse(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState), var_commentsBeforeRule.clone())
			var_oRule = iife_result_0
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException') {
				mut var_e := var_e_1.clone()
				mut var_sConsume := var_oParserState.consumeuntil(rt.create_array([rt.ArrayItem{ key: none, val: '\n' }, rt.ArrayItem{ key: none, val: ';' }, rt.ArrayItem{ key: none, val: '}' }]), rt.new_bool(true))
				if rt.has_exception() { unsafe { goto catch_label_2 } }
				if rt.is_true(var_oParserState.streql(rt.call_function('substr', [var_sConsume.clone(), rt.new_int(-1)]), rt.new_string('}'))) {
					var_oParserState.backtrack(rt.new_int(1))
					if rt.has_exception() { unsafe { goto catch_label_2 } }
				} else {
					for rt.is_true(var_oParserState.comes(rt.new_string(';'))) {
						var_oParserState.consume(rt.new_string(';'))
						if rt.has_exception() { unsafe { goto catch_label_2 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_2 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_2 } }
				unsafe { goto end_label_2 }

catch_label_2:
				mut var_e_2 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_2, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException') {
					var_e = var_e_2.clone()
					return
					unsafe { goto end_label_2 }
				}
				else {
					rt.throw_exception(var_e_2)
					unsafe { goto end_label_2 }
				}

end_label_2:
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		} else {
		mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule{}
		mut iife_result_1 := iife_temp_1.parse(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState), var_commentsBeforeRule.clone())
		var_oRule = iife_result_1
		}
		if rt.is_true(var_oRule) {
			var_oRuleSet.addrule(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule](var_oRule), rt.new_null())
		}
	}
	var_oParserState.consume(rt.new_string('}'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) addrule(mut var_oRule Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule, var_oSibling rt.PhpVal) {
	mut var_oRule_mutated := var_oRule
	mut var_sRule := rt.call_method(var_oRule_mutated, 'getRule', []rt.PhpVal{})
	if !(this.aRules.array_isset(var_sRule)) {
		this.aRules.array_set(var_sRule, rt.new_array())
	}
	mut var_iPosition := rt.new_int(this.aRules.array_get(var_sRule).array_count())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_oSibling, rt.new_null())))) {
		mut var_iSiblingPos := rt.call_function('array_search', [var_oSibling.clone(), this.aRules.array_get(var_sRule), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_iSiblingPos, rt.new_bool(false))))) {
			var_iPosition = var_iSiblingPos.clone()
			rt.call_method(var_oRule_mutated, 'setPosition', [rt.call_method(var_oSibling, 'getLineNo', []rt.PhpVal{}), rt.sub(rt.call_method(var_oSibling, 'getColNo', []rt.PhpVal{}), rt.new_int(1))])
		}
	}
	if rt.is_true(rt.identical(rt.call_method(var_oRule_mutated, 'getLineNumber', []rt.PhpVal{}), rt.new_null())) {
		mut var_columnNumber := rt.call_method(var_oRule_mutated, 'getColNo', []rt.PhpVal{})
		mut var_rules := this.getrules(rt.new_null())
		mut var_pos := rt.new_int(var_rules.clone().array_count())
		if rt.is_true(rt.greater(var_pos, rt.new_int(0))) {
			mut var_last := var_rules.array_get(rt.sub(var_pos, rt.new_int(1)))
			rt.call_method(var_oRule_mutated, 'setPosition', [rt.add(rt.call_method(var_last, 'getLineNo', []rt.PhpVal{}), rt.new_int(1)), var_columnNumber.clone()])
		} else {
			rt.call_method(var_oRule_mutated, 'setPosition', [rt.new_int(1), var_columnNumber.clone()])
		}
	} else if rt.is_true(rt.identical(rt.call_method(var_oRule_mutated, 'getColumnNumber', []rt.PhpVal{}), rt.new_null())) {
		rt.call_method(var_oRule_mutated, 'setPosition', [rt.call_method(var_oRule_mutated, 'getLineNumber', []rt.PhpVal{}), rt.new_int(0)])
	}
	rt.call_function('array_splice', [this.aRules.array_get(var_sRule), var_iPosition.clone(), rt.new_int(0), rt.create_array([rt.ArrayItem{ key: none, val: var_oRule_mutated }])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) getrules(var_mRule rt.PhpVal) rt.PhpVal {
	mut var_mRule_mutated := var_mRule
	if rt.is_true(rt.new_bool(rt.instance_of(var_mRule_mutated, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule'))) {
	var_mRule_mutated = rt.call_method(var_mRule_mutated, 'getRule', []rt.PhpVal{})
	}
	mut var_aResult := rt.new_array()
	mut iter_1 := this.aRules.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_aRules := item_1.val
		mut var_sName := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_mRule_mutated)))) || rt.is_true(rt.identical(var_sName, var_mRule_mutated)) || (rt.is_true(rt.identical(rt.call_function('strrpos', [var_mRule_mutated.clone(), rt.new_string('-')]), var_mRule_mutated.clone().to_string().len - '-'.len)) && rt.is_true(rt.identical(rt.call_function('strpos', [var_sName.clone(), var_mRule_mutated.clone()]), rt.new_int(0))) || rt.is_true(rt.identical(var_sName, rt.call_function('substr', [var_mRule_mutated.clone(), rt.new_int(0), rt.new_int(-1)])))) {
		var_aResult = rt.call_function('array_merge', [var_aResult.clone(), var_aRules.clone()])
		}
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_first := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_second := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.call_method(var_first, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_second, 'getLineNo', []rt.PhpVal{}))) {
			return rt.sub(rt.call_method(var_first, 'getColNo', []rt.PhpVal{}), rt.call_method(var_second, 'getColNo', []rt.PhpVal{}))
		}
		return rt.sub(rt.call_method(var_first, 'getLineNo', []rt.PhpVal{}), rt.call_method(var_second, 'getLineNo', []rt.PhpVal{}))
		}
	rt.call_function('usort', [var_aResult.clone(), rt.new_closure(closure_3_fn)])
	return var_aResult.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) setrules(mut var_aRules Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_array) {
	this.aRules = rt.new_array()
	mut iter_2 := var_aRules.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_rule := item_2.val
		this.addrule(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule](var_rule), rt.new_null())
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) getrulesassoc(var_mRule rt.PhpVal) rt.PhpVal {
	mut var_mRule_mutated := var_mRule
	mut var_aResult := rt.new_array()
	mut iter_3 := this.getrules(var_mRule_mutated.clone()).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_oRule := item_3.val
		var_aResult.array_set(rt.call_method(var_oRule, 'getRule', []rt.PhpVal{}), var_oRule.clone())
	}
	return var_aResult.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) removerule(var_mRule rt.PhpVal) {
	mut var_mRule_mutated := var_mRule
	if rt.is_true(rt.new_bool(rt.instance_of(var_mRule_mutated, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule'))) {
		mut var_sRule := rt.call_method(var_mRule_mutated, 'getRule', []rt.PhpVal{})
		if !(this.aRules.array_isset(var_sRule)) {
			return
		}
		mut iter_4 := this.aRules.array_get(var_sRule).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_oRule := item_4.val
			mut var_iKey := item_4.key
			if rt.is_true(rt.identical(var_oRule, var_mRule_mutated)) {
				this.aRules.array_get(var_sRule).array_unset(var_iKey)
			}
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_mRule_mutated, rt.new_null())))) {
		this.removematchingrules(var_mRule_mutated.clone())
	} else {
		this.removeallrules()
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) removematchingrules(var_searchPattern rt.PhpVal) {
	mut iter_5 := this.aRules.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_rules := item_5.val
		mut var_propertyName := item_5.key
		if rt.is_true(rt.identical(var_propertyName, var_searchPattern)) || (rt.is_true(rt.identical(rt.call_function('strrpos', [var_searchPattern.clone(), rt.new_string('-')]), var_searchPattern.clone().to_string().len - '-'.len)) && rt.is_true(rt.identical(rt.call_function('strpos', [var_propertyName.clone(), var_searchPattern.clone()]), rt.new_int(0))) || rt.is_true(rt.identical(var_propertyName, rt.call_function('substr', [var_searchPattern.clone(), rt.new_int(0), rt.new_int(-1)])))) {
			this.aRules.array_unset(var_propertyName)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) removeallrules() {
	this.aRules = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) magic_tostring() rt.PhpVal {
	return this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) renderrules(mut var_oOutputFormat Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) rt.PhpVal {
	mut var_sResult := rt.new_string('')
	mut var_bIsFirst := rt.new_bool(true)
	mut var_oNextLevel := var_oOutputFormat.nextlevel()
	mut iter_6 := this.getrules(rt.new_null()).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_oRule := item_6.val
		closure_4_fn := fn [var_oRule, var_oNextLevel] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return rt.call_method(var_oRule, 'render', [var_oNextLevel.clone()])
			}
		mut var_sRendered := rt.call_method(var_oNextLevel, 'safely', [rt.new_closure(closure_4_fn)])
		if rt.is_true(rt.identical(var_sRendered, rt.new_null())) {
			continue
		}
		if rt.is_true(var_bIsFirst) {
			var_bIsFirst = rt.new_bool(false)
			var_sResult = rt.concat(var_sResult, rt.call_method(var_oNextLevel, 'spaceBeforeRules', []rt.PhpVal{}))
		} else {
			var_sResult = rt.concat(var_sResult, rt.call_method(var_oNextLevel, 'spaceBetweenRules', []rt.PhpVal{}))
		}
		var_sResult = rt.concat(var_sResult, var_sRendered)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_bIsFirst)))) {
		var_sResult = rt.concat(var_sResult, var_oOutputFormat.spaceafterrules())
	}
	return var_oOutputFormat.removelastsemicolon(var_sResult.clone())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) addcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_array) {
	this.aComments = rt.call_function('array_merge', [this.aComments, var_aComments])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) getcomments() rt.PhpVal {
	return this.aComments
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) setcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_array) {
	this.aComments = var_aComments
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_ruleset(iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet{
		PhpObjectBase: rt.PhpObjectBase{}
		aRules: rt.new_null()
		aComments: rt.new_null()
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_rule_rule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parseRuleSet' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet.parseruleset(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'addRule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.addrule(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getRules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getrules(dispatch_arg_0)
		}
		'setRules' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setrules(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getRulesAssoc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getrulesassoc(dispatch_arg_0)
		}
		'removeRule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.removerule(dispatch_arg_0)
			return rt.new_null()
		}
		'removeMatchingRules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.removematchingrules(dispatch_arg_0)
			return rt.new_null()
		}
		'removeAllRules' {
			this.removeallrules()
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'renderRules' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.renderrules(mut dispatch_arg_0)
		}
		'addComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.addcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getComments' {
			return this.getcomments()
		}
		'setComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'aRules' { return this.aRules }
		'aComments' { return this.aComments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'aRules' { this.aRules = val; return true }
		'aComments' { this.aComments = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
