import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	rt.PhpObjectBase
pub mut:
		aComments rt.PhpVal = rt.new_null()
		aContents rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) construct(iLineNo i64)  {
	this.aComments = rt.new_array()
	this.aContents = rt.new_array()
	this.setposition(rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, mut var_oList Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList)  {
	mut var_oParserState_mutated := var_oParserState
	mut var_bIsRoot := rt.new_bool(false)
	if rt.is_true(rt.new_bool(var_oParserState_mutated.is_string())) {
		var_oParserState_mutated = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_parserstate(var_oParserState_mutated.dup(), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings{}; return temp.create() }())
	}
	mut var_bLenientParsing := rt.get_property(var_oParserState_mutated.getsettings(), 'bLenientParsing')
	mut var_aComments := rt.new_array()
	for rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState_mutated.isend())))) {
		var_aComments = rt.call_function('array_merge', [var_aComments.dup(), var_oParserState_mutated.consumewhitespace()])
		mut var_oListItem := rt.new_null()
		if rt.is_true(var_bLenientParsing) {
			var_oListItem = Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut var_oParserState_mutated, mut var_oList)
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException') {
				mut var_e := var_e_1.dup()
				var_oListItem = rt.new_bool(rt.new_bool(false))
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		} else {
			var_oListItem = Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut var_oParserState_mutated, mut var_oList)
		}
		if rt.is_true(rt.identical(var_oListItem, rt.new_null())) {
			return rt.new_null()
		}
		if rt.is_true(var_oListItem) {
			rt.call_method(var_oListItem, 'addComments', [var_aComments.dup()])
			var_oList.append(var_oListItem.dup())
		}
		var_aComments = var_oParserState_mutated.consumewhitespace()
	}
	var_oList.addcomments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](var_aComments))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_bIsRoot)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_bLenientParsing)))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(rt.new_string('Unexpected end of document'), var_oParserState_mutated.currentline())))
	}
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, mut var_oList Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) rt.PhpVal {
	mut var_oParserState_mutated := var_oParserState
	mut var_bIsRoot := rt.new_bool(false)
	if rt.is_true(var_oParserState_mutated.comes(rt.new_string('@'))) {
		mut var_oAtRule := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parseatrule(mut var_oParserState_mutated)
		if rt.is_true(rt.new_bool(rt.instance_of(var_oAtRule, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_bIsRoot)))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('@charset may only occur in root document'), rt.new_string(''), rt.new_string('custom'), var_oParserState_mutated.currentline())))
			}
			if var_oList.getcontents().array_count() > 0 {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('@charset must be the first parseable token in a document'), rt.new_string(''), rt.new_string('custom'), var_oParserState_mutated.currentline())))
			}
			var_oParserState_mutated.setcharset(rt.call_method(var_oAtRule, 'getCharset', []rt.PhpVal{}))
		}
		return var_oAtRule.dup()
	} else if rt.is_true(var_oParserState_mutated.comes(rt.new_string('}'))) {
		if rt.is_true(var_bIsRoot) {
			if rt.is_true(rt.get_property(var_oParserState_mutated.getsettings(), 'bLenientParsing')) {
				return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState_mutated))
			} else {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(rt.new_string('Unopened {'), var_oParserState_mutated.currentline())))
			}
		} else {
			return rt.new_null()
		}
	} else {
		return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock{}; return temp.parse(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState_mutated), rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList', []string{}, var_oList))
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
		mut var_oLocation := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState_mutated))
		var_oParserState_mutated.consumewhitespace()
		mut var_sMediaQuery := rt.new_null()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState_mutated.comes(rt.new_string(';')))))) {
			var_sMediaQuery = rt.new_string(rt.new_string(var_oParserState_mutated.consumeuntil(rt.create_array([rt.ArrayItem{ key: none, val: ';' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof() }])).to_string().trim_space()))
		}
		var_oParserState_mutated.consumeuntil(rt.create_array([rt.ArrayItem{ key: none, val: ';' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof() }]), rt.new_bool(true), rt.new_bool(true))
		return create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_import(var_oLocation.dup(), if rt.is_true(var_sMediaQuery) { var_sMediaQuery } else { rt.new_null() }, var_iIdentifierLineNum.dup())
	} else if rt.is_true(rt.identical(var_sIdentifier, rt.new_string('charset'))) {
		mut var_oCharsetString := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState_mutated))
		var_oParserState_mutated.consumewhitespace()
		var_oParserState_mutated.consumeuntil(rt.create_array([rt.ArrayItem{ key: none, val: ';' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof() }]), rt.new_bool(true), rt.new_bool(true))
		return create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_charset(var_oCharsetString.dup(), var_iIdentifierLineNum.dup())
	} else if rt.is_true(Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(var_sIdentifier.dup(), rt.new_string('keyframes'))) {
		mut var_oResult := create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_keyframe(var_iIdentifierLineNum.dup())
		var_oResult.setvendorkeyframe(var_sIdentifier.dup())
		var_oResult.setanimationname(rt.new_string(var_oParserState_mutated.consumeuntil(rt.new_string('{'), rt.new_bool(false), rt.new_bool(true)).to_string().trim_space()))
		Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut var_oParserState_mutated, mut var_oResult)
		if rt.is_true(var_oParserState_mutated.comes(rt.new_string('}'))) {
			var_oParserState_mutated.consume(rt.new_string('}'))
		}
		return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame', []string{}, var_oResult)
	} else if rt.is_true(rt.identical(var_sIdentifier, rt.new_string('namespace'))) {
		mut var_sPrefix := rt.new_null()
		mut var_mUrl := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{}; return temp.parseprimitivevalue(arg_0) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState_mutated))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState_mutated.comes(rt.new_string(';')))))) {
			var_sPrefix = var_mUrl.dup()
			var_mUrl = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{}; return temp.parseprimitivevalue(arg_0) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState_mutated))
		}
		var_oParserState_mutated.consumeuntil(rt.create_array([rt.ArrayItem{ key: none, val: ';' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState.eof() }]), rt.new_bool(true), rt.new_bool(true))
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_sPrefix.dup().is_string()))))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('Wrong namespace prefix'), var_sPrefix.dup(), rt.new_string('custom'), var_iIdentifierLineNum.dup())))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_mUrl, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString'))) || rt.is_true(rt.new_bool(rt.instance_of(var_mUrl, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL')))))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('Wrong namespace url of invalid type'), var_mUrl.dup(), rt.new_string('custom'), var_iIdentifierLineNum.dup())))
		}
		return create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_cssnamespace(var_mUrl.dup(), var_sPrefix.dup(), var_iIdentifierLineNum.dup())
	} else {
		mut var_sArgs := rt.new_string(rt.new_string(var_oParserState_mutated.consumeuntil(rt.new_string('{'), rt.new_bool(false), rt.new_bool(true)).to_string().trim_space()))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
			if rt.is_true(rt.get_property(var_oParserState_mutated.getsettings(), 'bLenientParsing')) {
				return rt.new_null()
			} else {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(rt.new_string('Unmatched brace count in media query'), var_oParserState_mutated.currentline())))
			}
		}
		mut var_bUseRuleSet := rt.new_bool(rt.new_bool(true))
		{
			mut iter_1 := rt.call_function('explode', [rt.new_string('/'), Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_AtRule.block_rules()]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_sBlockRuleName := item_1.val
				if rt.is_true(Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(var_sIdentifier.dup(), var_sBlockRuleName.dup())) {
					var_bUseRuleSet = rt.new_bool(rt.new_bool(false))
					break
				}
			}
		}
		if rt.is_true(var_bUseRuleSet) {
			mut var_oAtRule := create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_atruleset(var_sIdentifier.dup(), var_sArgs.dup(), var_iIdentifierLineNum.dup())
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet{}; return temp.parseruleset(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState_mutated), var_oAtRule.dup())
		} else {
			var_oAtRule = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_atruleblocklist(var_sIdentifier.dup(), var_sArgs.dup(), var_iIdentifierLineNum.dup())
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut var_oParserState_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList](var_oAtRule))
			if rt.is_true(var_oParserState_mutated.comes(rt.new_string('}'))) {
				var_oParserState_mutated.consume(rt.new_string('}'))
			}
		}
		return var_oAtRule.dup()
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(var_sIdentifier rt.PhpVal, var_sMatch rt.PhpVal) rt.PhpVal {
	mut var_sIdentifier_mutated := var_sIdentifier
	return if rt.is_true(rt.identical(rt.call_function('strcasecmp', [.dup(), .dup()]), rt.new_int(0))) { rt.identical(rt.call_function('strcasecmp', [.dup(), .dup()]), rt.new_int(0)) } else { rt.identical(rt.call_function('preg_match', [, .dup()]), rt.new_int(1)) }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) prepend(var_oItem rt.PhpVal)  {
	rt.call_function('array_unshift', [this.aContents, var_oItem.dup()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) append(var_oItem rt.PhpVal)  {
	.array_push(.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) splice(var_iOffset rt.PhpVal, var_iLength rt.PhpVal, var_mReplacement rt.PhpVal)  {
	
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) insertbefore(var_item rt.PhpVal, var_sibling rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) remove(var_oItemToRemove rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) replace(var_oOldItem rt.PhpVal, var_mNewItem rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) setcontents(mut var_aContents Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array)  {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) removedeclarationblockbyselector(var_mSelector rt.PhpVal, bRemoveAll bool)  {
	mut var_mSelector_mutated := var_mSelector
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) magic_tostring() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) renderlistcontents(mut var_oOutputFormat Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) isrootlist()  {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) getcontents() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) addcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array)  {
	mut var_aComments_mutated := var_aComments
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) getcomments() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) setcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array)  {
	mut var_aComments_mutated := var_aComments
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

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_csslist(iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList{
		PhpObjectBase: rt.PhpObjectBase{}
		aComments: rt.new_null()
		aContents: rt.new_null()
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_parserstate() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_settings() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_declarationblock() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_url() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_import() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssstring() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_charset() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_keyframe() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_value() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_cssnamespace() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_atruleset() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_AtRuleSet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_ruleset_ruleset() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_atruleblocklist() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselist(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'parseListItem' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parselistitem(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'parseAtRule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.parseatrule(mut dispatch_arg_0)
		}
		'identifierIs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.identifieris(dispatch_arg_0, dispatch_arg_1)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.addcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getComments' {
			return this.getcomments()
		}
		'setComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
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
		'aComments' { this.aComments = val; return true }
		'aContents' { this.aContents = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_csslist_csslist_php() {
}
