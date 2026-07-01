import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule {
	rt.PhpObjectBase
pub mut:
		sRule rt.PhpVal = rt.new_null()
		mValue rt.PhpVal = rt.new_null()
		bIsImportant rt.PhpVal = rt.new_null()
		aIeHack rt.PhpVal = rt.new_null()
		aComments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) construct(var_sRule rt.PhpVal, iLineNo i64, iColNo i64)  {
	this.sRule = var_sRule.dup()
	this.mValue = rt.new_null()
	this.bIsImportant = rt.new_bool(false)
	this.aIeHack = rt.new_array()
	this.setposition(rt.new_int(iLineNo), rt.new_int(iColNo))
	this.aComments = rt.new_array()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule.parse(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, var_commentsBeforeRule rt.PhpVal) rt.PhpVal {
	mut var_aComments := rt.call_function('array_merge', [var_commentsBeforeRule.dup(), var_oParserState.consumewhitespace()])
	mut var_oRule := create_automattic_woocommerce_emaileditorvendor_sabberworm_css_rule_rule(var_oParserState.parseidentifier(rt.new_bool(!(rt.is_true(var_oParserState.comes(rt.new_string('--')))))), var_oParserState.currentline(), var_oParserState.currentcolumn())
	var_oRule.setcomments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array](var_aComments))
	var_oRule.addcomments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array](var_oParserState.consumewhitespace()))
	var_oParserState.consume(rt.new_string(':'))
	mut var_oValue := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{}; return temp.parsevalue(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState), Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule.listdelimiterforrule(var_oRule.getrule()))
	var_oRule.setvalue(var_oValue.dup())
	if rt.is_true(rt.get_property(var_oParserState.getsettings(), 'bLenientParsing')) {
		for rt.is_true(var_oParserState.comes(rt.new_string('\\'))) {
			var_oParserState.consume(rt.new_string('\\'))
			var_oRule.addiehack(var_oParserState.consume())
			var_oParserState.consumewhitespace()
		}
	}
	var_oParserState.consumewhitespace()
	if rt.is_true(var_oParserState.comes(rt.new_string('!'))) {
		var_oParserState.consume(rt.new_string('!'))
		var_oParserState.consumewhitespace()
		var_oParserState.consume(rt.new_string('important'))
		var_oRule.setisimportant(true)
	}
	var_oParserState.consumewhitespace()
	for rt.is_true(var_oParserState.comes(rt.new_string(';'))) {
		var_oParserState.consume(rt.new_string(';'))
	}
	return mut var_oRule
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule.listdelimiterforrule(var_sRule rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^font($|-)/'), var_sRule.dup()])) {
		return rt.create_array([rt.ArrayItem{ key: none, val: ',' }, rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: ' ' }])
	}
	mut switch_val_1 := var_sRule
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('src'))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: ' ' }, rt.ArrayItem{ key: none, val: ',' }])
	} else {
		return rt.create_array([rt.ArrayItem{ key: none, val: ',' }, rt.ArrayItem{ key: none, val: ' ' }, rt.ArrayItem{ key: none, val: '/' }])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) setrule(var_sRule rt.PhpVal)  {
	this.sRule = var_sRule.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) getrule() rt.PhpVal {
	return this.sRule
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) getvalue() rt.PhpVal {
	return this.mValue
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) setvalue(var_mValue rt.PhpVal)  {
	mut var_mValue_mutated := var_mValue
	this.mValue = var_mValue_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) setvalues(mut var_aSpaceSeparatedValues Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array) rt.PhpVal {
	mut var_oSpaceSeparatedList := rt.new_null()
	if var_aSpaceSeparatedValues.array_count() > 1 {
		var_oSpaceSeparatedList = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_rulevaluelist(rt.new_string(' '), rt.get_property(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule', ['Commentable', 'CSSElement', 'Positionable'], &this), 'iLineNo'))
	}
	{
		mut iter_1 := var_aSpaceSeparatedValues.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_aCommaSeparatedValues := item_1.val
			mut var_oCommaSeparatedList := rt.new_null()
			if var_aCommaSeparatedValues.dup().array_count() > 1 {
				var_oCommaSeparatedList = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_rulevaluelist(rt.new_string(','), rt.get_property(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule', ['Commentable', 'CSSElement', 'Positionable'], &this), 'iLineNo'))
			}
			{
				mut iter_2 := var_aCommaSeparatedValues.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_mValue := item_2.val
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_oSpaceSeparatedList)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_oCommaSeparatedList)))))) {
						this.mValue = var_mValue.dup()
						return var_mValue.dup()
					}
					if rt.is_true(var_oCommaSeparatedList) {
						rt.call_method(var_oCommaSeparatedList, 'addListComponent', [var_mValue.dup()])
					} else {
						rt.call_method(var_oSpaceSeparatedList, 'addListComponent', [var_mValue.dup()])
					}
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_oSpaceSeparatedList)))) {
				this.mValue = var_oCommaSeparatedList.dup()
				return var_oCommaSeparatedList.dup()
			} else {
				rt.call_method(var_oSpaceSeparatedList, 'addListComponent', [var_oCommaSeparatedList.dup()])
			}
		}
	}
	this.mValue = var_oSpaceSeparatedList.dup()
	return var_oSpaceSeparatedList.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) getvalues() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.mValue, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList')))))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: this.mValue }]) }])
	}
	if rt.is_true(rt.identical(rt.call_method(this.mValue, 'getListSeparator', []rt.PhpVal{}), rt.new_string(','))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(this.mValue, 'getListComponents', []rt.PhpVal{}) }])
	}
	mut var_aResult := rt.new_array()
	{
		mut iter_1 := rt.call_method(this.mValue, 'getListComponents', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_mValue := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_mValue, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_aResult.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_mValue }]))
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_method(this.mValue, 'getListSeparator', []rt.PhpVal{}), rt.new_string(' '))) || var_aResult.dup().array_count() == 0)) {
				var_aResult.array_push(rt.new_array())
			}
			{
				mut iter_2 := rt.call_method(var_mValue_shadow, 'getListComponents', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_mValue_shadow := item_2.val
					var_aResult.array_get_mut(var_aResult.dup().array_count() - 1).array_push(var_mValue_shadow.dup())
				}
			}
		}
	}
	return var_aResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) addvalue(var_mValue rt.PhpVal, sType string)  {
	mut var_mValue_mutated := var_mValue
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_mValue_mutated.dup().is_array()))))) {
		var_mValue_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_mValue_mutated }])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.mValue, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_mCurrentValue := this.mValue
		this.mValue = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_rulevaluelist(rt.new_string(sType).dup(), this.getlinenumber())
		if rt.is_true(var_mCurrentValue) {
			rt.call_method(this.mValue, 'addListComponent', [var_mCurrentValue.dup()])
		}
	}
	{
		mut iter_1 := var_mValue_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_mValueItem := item_1.val
			rt.call_method(this.mValue, 'addListComponent', [var_mValueItem.dup()])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) addiehack(var_iModifier rt.PhpVal)  {
	this.aIeHack.array_push(var_iModifier.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) setiehack(mut var_aModifiers Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array)  {
	this.aIeHack = var_aModifiers.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) getiehack() rt.PhpVal {
	return this.aIeHack
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) setisimportant(bIsImportant bool)  {
	this.bIsImportant = rt.new_bool(bIsImportant).dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) getisimportant() rt.PhpVal {
	return this.bIsImportant
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) magic_tostring() rt.PhpVal {
	return this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) render(var_oOutputFormat rt.PhpVal) rt.PhpVal {
	mut var_sResult := rt.new_string(rt.concat(rt.concat(rt.concat(rt.call_method(var_oOutputFormat, 'comments', [rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule', ['Commentable', 'CSSElement', 'Positionable'], &this)]), this.sRule), rt.new_string(':')), rt.call_method(var_oOutputFormat, 'spaceAfterRuleName', []rt.PhpVal{})))
	if rt.is_true(rt.new_bool(rt.instance_of(this.mValue, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value'))) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(this.aIeHack)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(this.bIsImportant) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	return var_sResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) addcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array)  {
	mut var_aComments_mutated := var_aComments
	this.aComments = rt.call_function('array_merge', [this.aComments, var_aComments_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) getcomments() rt.PhpVal {
	return this.aComments
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) setcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array)  {
	mut var_aComments_mutated := var_aComments
	this.aComments = var_aComments_mutated.dup()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_rule_rule(iLineNo i64, iColNo i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
		sRule: rt.new_null()
		mValue: rt.new_null()
		bIsImportant: rt.new_null()
		aIeHack: rt.new_null()
		aComments: rt.new_null()
	}
	obj.construct(iLineNo, iColNo, arg_2)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_value() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_rulevaluelist() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule.parse(mut dispatch_arg_0, dispatch_arg_1)
		}
		'listDelimiterForRule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule.listdelimiterforrule(dispatch_arg_0)
		}
		'setRule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setrule(dispatch_arg_0)
			return rt.new_null()
		}
		'getRule' {
			return this.getrule()
		}
		'getValue' {
			return this.getvalue()
		}
		'setValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setvalue(dispatch_arg_0)
			return rt.new_null()
		}
		'setValues' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setvalues(mut dispatch_arg_0)
		}
		'getValues' {
			return this.getvalues()
		}
		'addValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.addvalue(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'addIeHack' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.addiehack(dispatch_arg_0)
			return rt.new_null()
		}
		'setIeHack' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setiehack(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getIeHack' {
			return this.getiehack()
		}
		'setIsImportant' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.setisimportant(dispatch_arg_0)
			return rt.new_null()
		}
		'getIsImportant' {
			return this.getisimportant()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		'addComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.addcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getComments' {
			return this.getcomments()
		}
		'setComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sRule' { return this.sRule }
		'mValue' { return this.mValue }
		'bIsImportant' { return this.bIsImportant }
		'aIeHack' { return this.aIeHack }
		'aComments' { return this.aComments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Rule_Rule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sRule' { this.sRule = val; return true }
		'mValue' { this.mValue = val; return true }
		'bIsImportant' { this.bIsImportant = val; return true }
		'aIeHack' { this.aIeHack = val; return true }
		'aComments' { this.aComments = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_rule_rule_php() {
}
