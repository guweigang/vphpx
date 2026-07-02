import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	rt.PhpObjectBase
pub mut:
	aComments rt.PhpVal = rt.new_null()
	aContents rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) construct(iLineNo i64) {
	this.aComments = rt.new_array()
	this.aContents = rt.new_array()
	this.setposition(rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, mut var_oList Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) {
	mut var_oParserState_mutated := var_oParserState
	mut var_bIsRoot := rt.new_bool(false)
	if rt.is_true(rt.new_bool(var_oParserState_mutated.is_string())) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings{}
		mut iife_result_0 := iife_temp_0.create()
		var_oParserState_mutated = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_parserstate(var_oParserState_mutated,
			iife_result_0)
	}
	mut var_bLenientParsing := rt.get_property(var_oParserState_mutated.getsettings(),
		'bLenientParsing')
	mut var_aComments := rt.new_array()
	for rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState_mutated.isend())))) {
		var_aComments = rt.call_function('array_merge', [var_aComments.clone(),
			var_oParserState_mutated.consumewhitespace()])
		mut var_oListItem := rt.new_null()
		if rt.is_true(var_bLenientParsing) {
			var_oListItem = Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut var_oParserState_mutated, mut
				var_oList)
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			unsafe {
				goto end_label_1
			}
			catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1,
				'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException')
			{
				mut var_e := var_e_1.clone()
				var_oListItem = rt.new_bool(false)
				unsafe {
					goto end_label_1
				}
			} else {
				rt.throw_exception(var_e_1)
				unsafe {
					goto end_label_1
				}
			}

			end_label_1:
		} else {
			var_oListItem = Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut var_oParserState_mutated, mut
				var_oList)
		}
		if rt.is_true(rt.identical(var_oListItem, rt.new_null())) {
			return
		}
		if rt.is_true(var_oListItem) {
			rt.call_method(var_oListItem, 'addComments', [var_aComments.clone()])
			var_oList.append(var_oListItem.clone())
		}
		var_aComments = var_oParserState_mutated.consumewhitespace()
	}
	var_oList.addcomments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](var_aComments))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_bIsRoot))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_bLenientParsing)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(rt.new_string('Unexpected end of document'),
			var_oParserState_mutated.currentline())))
	}
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, mut var_oList Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) rt.PhpVal {
	mut var_oParserState_mutated := var_oParserState
	mut var_bIsRoot := rt.new_bool(false)
	if rt.is_true(var_oParserState_mutated.comes(rt.new_string('@'))) {
		mut var_oAtRule :=
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parseatrule(mut var_oParserState_mutated)
		if rt.is_true(rt.new_bool(rt.instance_of(var_oAtRule,
			'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset')))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(var_bIsRoot)))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
					[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('@charset may only occur in root document'),
					rt.new_string(''), rt.new_string('custom'),
					var_oParserState_mutated.currentline())))
			}
			if var_oList.getcontents().array_count() > 0 {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
					[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('@charset must be the first parseable token in a document'),
					rt.new_string(''), rt.new_string('custom'),
					var_oParserState_mutated.currentline())))
			}
			var_oParserState_mutated.setcharset(rt.call_method(var_oAtRule, 'getCharset',
				[]rt.PhpVal{}))
		}
		return var_oAtRule.clone()
	} else if rt.is_true(var_oParserState_mutated.comes(rt.new_string('}'))) {
		if rt.is_true(var_bIsRoot) {
			if rt.is_true(rt.get_property(var_oParserState_mutated.getsettings(), 'bLenientParsing')) {
				mut iife_temp_1 :=
					Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock{}
				mut iife_result_1 := iife_temp_1.parse(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
					[]string{}, var_oParserState_mutated))
				return iife_result_1
			} else {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException',
					[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(rt.new_string('Unopened {'),
					var_oParserState_mutated.currentline())))
			}
		} else {
			return rt.new_null()
		}
	} else {
		mut iife_temp_2 :=
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock{}
		mut iife_result_2 := iife_temp_2.parse(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
			[]string{}, var_oParserState_mutated), rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList',
			[]string{}, var_oList))
		return iife_result_2
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parseatrule(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) rt.PhpVal {
	mut var_oParserState_mutated := var_oParserState
	var_oParserState_mutated.consume(rt.new_string('@'))
	mut var_sIdentifier := var_oParserState_mutated.parseidentifier()
	mut var_iIdentifierLineNum := var_oParserState_mutated.currentline()
	var_oParserState_mutated.consumewhitespace()
	if rt.is_true(rt.identical(var_sIdentifier, rt.new_string('import'))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL{}
		mut iife_result_3 := iife_temp_3.parse(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
			[]string{}, var_oParserState_mutated))
		mut var_oLocation := iife_result_3
		var_oParserState_mutated.consumewhitespace()
		mut var_sMediaQuery := rt.new_null()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState_mutated.comes(rt.new_string(';')))))) {
			var_sMediaQuery = rt.new_string(var_oParserState_mutated.consumeuntil(rt.create_array([
				rt.ArrayItem{ key: none, val: ';' },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof()
				},
			])).to_string().trim_space())
		}
		var_oParserState_mutated.consumeuntil(rt.create_array([
			rt.ArrayItem{ key: none, val: ';' },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof()
			},
		]), rt.new_bool(true), rt.new_bool(true))
		return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_import(var_oLocation.clone(), if rt.is_true(var_sMediaQuery) {
			var_sMediaQuery
		} else {
			rt.new_null()
		}, var_iIdentifierLineNum.clone()))
	} else if rt.is_true(rt.identical(var_sIdentifier, rt.new_string('charset'))) {
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString{}
		mut iife_result_4 := iife_temp_4.parse(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
			[]string{}, var_oParserState_mutated))
		mut var_oCharsetString := iife_result_4
		var_oParserState_mutated.consumewhitespace()
		var_oParserState_mutated.consumeuntil(rt.create_array([
			rt.ArrayItem{ key: none, val: ';' },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof()
			},
		]), rt.new_bool(true), rt.new_bool(true))
		return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_charset(var_oCharsetString.clone(),
			var_iIdentifierLineNum.clone()))
	} else if rt.is_true(Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(var_sIdentifier.clone(),
		rt.new_string('keyframes')))
	{
		mut var_oResult :=
			create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_keyframe(var_iIdentifierLineNum.clone())
		var_oResult.setvendorkeyframe(var_sIdentifier.clone())
		var_oResult.setanimationname(rt.new_string((var_oParserState_mutated.consumeuntil(rt.new_string('{'),
			rt.new_bool(false), rt.new_bool(true)).to_string().trim_space()).str()))
		Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut var_oParserState_mutated, mut
			var_oResult)
		if rt.is_true(var_oParserState_mutated.comes(rt.new_string('}'))) {
			var_oParserState_mutated.consume(rt.new_string('}'))
		}
		return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame',
			[]string{}, var_oResult)
	} else if rt.is_true(rt.identical(var_sIdentifier, rt.new_string('namespace'))) {
		mut var_sPrefix := rt.new_null()
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{}
		mut iife_result_5 := iife_temp_5.parseprimitivevalue(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
			[]string{}, var_oParserState_mutated))
		mut var_mUrl := iife_result_5
		if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState_mutated.comes(rt.new_string(';')))))) {
			var_sPrefix = var_mUrl.clone()
			mut iife_temp_6 :=
				Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{}
			mut iife_result_6 := iife_temp_6.parseprimitivevalue(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
				[]string{}, var_oParserState_mutated))
			var_mUrl = iife_result_6
		}
		var_oParserState_mutated.consumeuntil(rt.create_array([
			rt.ArrayItem{ key: none, val: ';' },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof()
			},
		]), rt.new_bool(true), rt.new_bool(true))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sPrefix, rt.new_null()))))
			&& !(var_sPrefix.clone().is_string()) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
				[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('Wrong namespace prefix'),
				var_sPrefix.clone(), rt.new_string('custom'), var_iIdentifierLineNum.clone())))
		}
		if !(
			rt.is_true(rt.new_bool(rt.instance_of(var_mUrl, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString')))
			|| rt.is_true(rt.new_bool(rt.instance_of(var_mUrl, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL')))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
				[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('Wrong namespace url of invalid type'),
				var_mUrl.clone(), rt.new_string('custom'), var_iIdentifierLineNum.clone())))
		}
		return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_cssnamespace(var_mUrl.clone(),
			var_sPrefix.clone(), var_iIdentifierLineNum.clone()))
	} else {
		mut var_sArgs := rt.new_string(var_oParserState_mutated.consumeuntil(rt.new_string('{'),
			rt.new_bool(false), rt.new_bool(true)).to_string().trim_space())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('substr_count', [
			var_sArgs.clone(),
			rt.new_string('('),
		]), rt.call_function('substr_count', [var_sArgs.clone(),
			rt.new_string(')')])))))
		{
			if rt.is_true(rt.get_property(var_oParserState_mutated.getsettings(), 'bLenientParsing')) {
				return rt.new_null()
			} else {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException',
					[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(rt.new_string('Unmatched brace count in media query'),
					var_oParserState_mutated.currentline())))
			}
		}
		mut var_bUseRuleSet := rt.new_bool(true)
		mut iter_1 := rt.call_function('explode', [rt.new_string('/'),
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_AtRule.block_rules()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sBlockRuleName := item_1.val
			if rt.is_true(Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(var_sIdentifier.clone(),
				var_sBlockRuleName.clone()))
			{
				var_bUseRuleSet = rt.new_bool(false)
				break
			}
		}
		if rt.is_true(var_bUseRuleSet) {
			mut var_oAtRule := create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_atruleset(var_sIdentifier.clone(),
				var_sArgs.clone(), var_iIdentifierLineNum.clone())
			mut iife_temp_7 :=
				Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet{}
			mut iife_result_7 := iife_temp_7.parseruleset(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
				[]string{}, var_oParserState_mutated), var_oAtRule.clone())
		} else {
			var_oAtRule = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_atruleblocklist(var_sIdentifier.clone(),
				var_sArgs.clone(), var_iIdentifierLineNum.clone())
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut var_oParserState_mutated, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList](var_oAtRule))
			if rt.is_true(var_oParserState_mutated.comes(rt.new_string('}'))) {
				var_oParserState_mutated.consume(rt.new_string('}'))
			}
		}
		return var_oAtRule.clone()
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(var_sIdentifier rt.PhpVal, var_sMatch rt.PhpVal) rt.PhpVal {
	mut var_sIdentifier_mutated := var_sIdentifier
	return if rt.is_true(rt.identical(rt.call_function('strcasecmp', [
		var_sIdentifier_mutated.clone(), var_sMatch.clone()]), rt.new_int(0)))
	{ rt.identical(rt.call_function('strcasecmp', [var_sIdentifier_mutated.clone(),
			var_sMatch.clone()]), rt.new_int(0)) } else { rt.identical(rt.call_function('preg_match', [
			rt.concat(rt.concat(rt.new_string('/^(-\\w+-)?'), var_sMatch), rt.new_string('$/i')),
			var_sIdentifier_mutated.clone(),
		]), rt.new_int(1)) }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) prepend(var_oItem rt.PhpVal) {
	rt.call_function('array_unshift', [this.aContents, var_oItem.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) append(var_oItem rt.PhpVal) {
	this.aContents.array_push(var_oItem.clone())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) splice(var_iOffset rt.PhpVal, var_iLength rt.PhpVal, var_mReplacement rt.PhpVal) {
	rt.call_function('array_splice', [this.aContents, var_iOffset.clone(),
		var_iLength.clone(), var_mReplacement.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) insertbefore(var_item rt.PhpVal, var_sibling rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array',
		[var_sibling.clone(), this.aContents, rt.new_bool(true)]))
	{
		this.replace(var_sibling.clone(), rt.create_array([
			rt.ArrayItem{ key: none, val: var_item },
			rt.ArrayItem{ key: none, val: var_sibling },
		]))
	} else {
		this.append(var_item.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) remove(var_oItemToRemove rt.PhpVal) bool {
	mut var_iKey := rt.call_function('array_search', [var_oItemToRemove.clone(), this.aContents,
		rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_iKey, rt.new_bool(false))))) {
		this.aContents.array_unset(var_iKey)
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) replace(var_oOldItem rt.PhpVal, var_mNewItem rt.PhpVal) bool {
	mut var_iKey := rt.call_function('array_search', [var_oOldItem.clone(), this.aContents,
		rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_iKey, rt.new_bool(false))))) {
		if rt.is_true(rt.new_bool(var_mNewItem.clone().is_array())) {
			rt.call_function('array_splice', [this.aContents, var_iKey.clone(),
				rt.new_int(1), var_mNewItem.clone()])
		} else {
			rt.call_function('array_splice', [this.aContents, var_iKey.clone(),
				rt.new_int(1), rt.create_array([
					rt.ArrayItem{ key: none, val: var_mNewItem },
				])])
		}
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) setcontents(mut var_aContents Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array) {
	this.aContents = rt.new_array()
	mut iter_2 := var_aContents.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_content := item_2.val
		this.append(var_content.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) removedeclarationblockbyselector(var_mSelector rt.PhpVal, bRemoveAll bool) {
	mut var_mSelector_mutated := var_mSelector
	if rt.is_true(rt.new_bool(rt.instance_of(var_mSelector_mutated,
		'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock')))
	{
		var_mSelector_mutated = rt.call_method(var_mSelector_mutated, 'getSelectors', []rt.PhpVal{})
	}
	if !(var_mSelector_mutated.clone().is_array()) {
		var_mSelector_mutated = rt.call_function('explode', [
			rt.new_string(','), var_mSelector_mutated.clone()])
	}
	mut iter_3 := var_mSelector_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_mSel := item_3.val
		mut var_iKey := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mSel,
			'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector'))))))
		{
			mut iife_temp_8 :=
				Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector{}
			mut iife_result_8 := iife_temp_8.isvalid(var_mSel.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
					[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(
					"Selector did not match '" +
					(Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector.selector_validation_rx()).str() + "'.",
					var_mSel.clone(), rt.new_string('custom'))))
			}
			var_mSel =
				create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_selector(var_mSel.clone())
		}
	}
	mut iter_4 := this.aContents.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_mItem := item_4.val
		mut var_iKey := item_4.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mItem,
			'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock'))))))
		{
			continue
		}
		if rt.is_true(rt.equal(rt.call_method(var_mItem, 'getSelectors', []rt.PhpVal{}),
			var_mSelector_mutated))
		{
			this.aContents.array_unset(var_iKey)
			if !var_bRemoveAll {
				return
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) magic_tostring() rt.PhpVal {
	return this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) renderlistcontents(mut var_oOutputFormat Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) rt.PhpVal {
	mut var_sResult := rt.new_string('')
	mut var_bIsFirst := rt.new_bool(true)
	mut var_oNextLevel := var_oOutputFormat
	if rt.is_true(rt.new_bool(!(rt.is_true(this.isrootlist())))) {
		var_oNextLevel = var_oOutputFormat.nextlevel()
	}
	mut iter_5 := this.aContents.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_oContent := item_5.val
		closure_10_fn := fn [var_oNextLevel, var_oContent] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return rt.call_method(var_oContent, 'render', [var_oNextLevel.clone()])
		}
		mut var_sRendered := var_oOutputFormat.safely(rt.new_closure(closure_10_fn))
		if rt.is_true(rt.identical(var_sRendered, rt.new_null())) {
			continue
		}
		if rt.is_true(var_bIsFirst) {
			var_bIsFirst = rt.new_bool(false)
			var_sResult = rt.concat(var_sResult, rt.call_method(var_oNextLevel,
				'spaceBeforeBlocks', []rt.PhpVal{}))
		} else {
			var_sResult = rt.concat(var_sResult, rt.call_method(var_oNextLevel,
				'spaceBetweenBlocks', []rt.PhpVal{}))
		}
		var_sResult = rt.concat(var_sResult, var_sRendered)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_bIsFirst)))) {
		var_sResult = rt.concat(var_sResult, var_oOutputFormat.spaceafterblocks())
	}
	return var_sResult.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) isrootlist() {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) getcontents() rt.PhpVal {
	return this.aContents
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) addcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array) {
	mut var_aComments_mutated := var_aComments
	this.aComments = rt.call_function('array_merge', [this.aComments, var_aComments_mutated])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) getcomments() rt.PhpVal {
	return this.aComments
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) setcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array) {
	mut var_aComments_mutated := var_aComments
	this.aComments = var_aComments_mutated
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_csslist(iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList{
		PhpObjectBase: rt.PhpObjectBase{}
		aComments:     rt.new_null()
		aContents:     rt.new_null()
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_parserstate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_settings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_declarationblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_url(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_import(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssstring(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_charset(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_keyframe(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_value(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_cssnamespace(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_atruleset(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_ruleset(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_atruleblocklist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_selector(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parseList' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut dispatch_arg_0, mut
				dispatch_arg_1)
			return rt.new_null()
		}
		'parseListItem' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'parseAtRule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parseatrule(mut dispatch_arg_0)
		}
		'identifierIs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(dispatch_arg_0,
				dispatch_arg_1)
		}
		'prepend' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepend(dispatch_arg_0)
			return rt.new_null()
		}
		'append' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.append(dispatch_arg_0)
			return rt.new_null()
		}
		'splice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.splice(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'insertBefore' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.insertbefore(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove(dispatch_arg_0))
		}
		'replace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.replace(dispatch_arg_0, dispatch_arg_1))
		}
		'setContents' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setcontents(mut dispatch_arg_0)
			return rt.new_null()
		}
		'removeDeclarationBlockBySelector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.removedeclarationblockbyselector(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'renderListContents' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.renderlistcontents(mut dispatch_arg_0)
		}
		'isRootList' {
			this.isrootlist()
			return rt.new_null()
		}
		'getContents' {
			return this.getcontents()
		}
		'addComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.addcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getComments' {
			return this.getcomments()
		}
		'setComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'aComments' { return this.aComments }
		'aContents' { return this.aContents }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'aComments' {
			this.aComments = val
			return true
		}
		'aContents' {
			this.aContents = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Selector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
