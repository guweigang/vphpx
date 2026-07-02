import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter {
	rt.PhpObjectBase
pub mut:
	oFormat rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) construct(mut var_oFormat Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) {
	mut var_oFormat_mutated := var_oFormat
	this.oFormat = var_oFormat_mutated
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) space(var_sName rt.PhpVal, var_sType rt.PhpVal) rt.PhpVal {
	mut var_sSpaceString := rt.call_method(this.oFormat, 'get', [
		rt.new_string('Space${var_sName.to_string()}'),
	])
	if rt.is_true(rt.new_bool(var_sSpaceString.clone().is_array())) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sType, rt.new_null()))))
			&& var_sSpaceString.array_isset(var_sType) {
			var_sSpaceString = var_sSpaceString.array_get(var_sType)
		} else {
			var_sSpaceString = rt.call_function('reset', [var_sSpaceString.clone()])
		}
	}
	return this.preparespace(var_sSpaceString.clone())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spaceafterrulename() rt.PhpVal {
	return this.space(rt.new_string('AfterRuleName'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spacebeforerules() rt.PhpVal {
	return this.space(rt.new_string('BeforeRules'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spaceafterrules() rt.PhpVal {
	return this.space(rt.new_string('AfterRules'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spacebetweenrules() rt.PhpVal {
	return this.space(rt.new_string('BetweenRules'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spacebeforeblocks() rt.PhpVal {
	return this.space(rt.new_string('BeforeBlocks'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spaceafterblocks() rt.PhpVal {
	return this.space(rt.new_string('AfterBlocks'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spacebetweenblocks() rt.PhpVal {
	return this.space(rt.new_string('BetweenBlocks'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spacebeforeselectorseparator() rt.PhpVal {
	return this.space(rt.new_string('BeforeSelectorSeparator'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spaceafterselectorseparator() rt.PhpVal {
	return this.space(rt.new_string('AfterSelectorSeparator'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spacebeforelistargumentseparator(var_sSeparator rt.PhpVal) rt.PhpVal {
	mut var_spaceForSeparator := rt.call_method(this.oFormat,
		'getSpaceBeforeListArgumentSeparators', []rt.PhpVal{})
	if var_spaceForSeparator.array_isset(var_sSeparator) {
		return var_spaceForSeparator.array_get(var_sSeparator)
	}
	return this.space(rt.new_string('BeforeListArgumentSeparator'), var_sSeparator.clone())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spaceafterlistargumentseparator(var_sSeparator rt.PhpVal) rt.PhpVal {
	mut var_spaceForSeparator := rt.call_method(this.oFormat,
		'getSpaceAfterListArgumentSeparators', []rt.PhpVal{})
	if var_spaceForSeparator.array_isset(var_sSeparator) {
		return var_spaceForSeparator.array_get(var_sSeparator)
	}
	return this.space(rt.new_string('AfterListArgumentSeparator'), var_sSeparator.clone())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) spacebeforeopeningbrace() rt.PhpVal {
	return this.space(rt.new_string('BeforeOpeningBrace'), rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) safely(var_cCode rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(this.oFormat, 'get', [rt.new_string('IgnoreExceptions')])) {
		return rt.call_callable(var_cCode, []rt.PhpVal{})
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1,
			'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_OutputException')
		{
			mut var_e := var_e_1.clone()
			return rt.new_null()
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
		return rt.call_callable(var_cCode, []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) implode(var_sSeparator rt.PhpVal, mut var_aValues Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_array, bIncreaseLevel bool) rt.PhpVal {
	mut var_sResult := rt.new_string('')
	mut var_oFormat := this.oFormat
	if var_bIncreaseLevel {
		var_oFormat = rt.call_method(var_oFormat, 'nextLevel', []rt.PhpVal{})
	}
	mut var_bIsFirst := rt.new_bool(true)
	mut iter_1 := var_aValues.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_mValue := item_1.val
		if rt.is_true(var_bIsFirst) {
			var_bIsFirst = rt.new_bool(false)
		} else {
			var_sResult = rt.concat(var_sResult, var_sSeparator)
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_mValue,
			'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Renderable')))
		{
			var_sResult = rt.concat(var_sResult, rt.call_method(var_mValue, 'render', [
				var_oFormat.clone(),
			]))
		} else {
			var_sResult = rt.concat(var_sResult, var_mValue)
		}
	}
	return var_sResult.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) removelastsemicolon(var_sString rt.PhpVal) rt.PhpVal {
	mut var_sString_mutated := var_sString
	if rt.is_true(rt.call_method(this.oFormat, 'get', [
		rt.new_string('SemicolonAfterLastRule'),
	]))
	{
		return var_sString_mutated.clone()
	}
	var_sString_mutated = rt.call_function('explode', [rt.new_string(';'),
		var_sString_mutated.clone()])
	if var_sString_mutated.clone().array_count() < 2 {
		return var_sString_mutated.array_get(rt.new_int(0))
	}
	mut var_sLast := rt.call_function('array_pop', [var_sString_mutated.clone()])
	mut var_sNextToLast := rt.call_function('array_pop', [var_sString_mutated.clone()])
	var_sString_mutated.clone().array_push(rt.new_string(var_sNextToLast.str() + var_sLast.str()))
	return rt.call_function('implode', [rt.new_string(';'), var_sString_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) comments(mut var_oCommentable Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Commentable) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(this.oFormat, 'bRenderComments'))))) {
		return ''
	}
	mut var_sResult := rt.new_string('')
	mut var_aComments := var_oCommentable.getcomments()
	mut var_iLastCommentIndex := rt.new_int(var_aComments.clone().array_count() - 1)
	mut iter_2 := var_aComments.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_oComment := item_2.val
		mut var_i := item_2.key
		var_sResult = rt.concat(var_sResult, rt.call_method(var_oComment, 'render', [
			this.oFormat,
		]))
		var_sResult = rt.concat(var_sResult, if rt.is_true(rt.identical(var_i,
			var_iLastCommentIndex))
		{
			this.spaceafterblocks()
		} else {
			this.spacebetweenblocks()
		})
	}
	return var_sResult.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) preparespace(var_sSpaceString rt.PhpVal) rt.PhpVal {
	mut var_sSpaceString_mutated := var_sSpaceString
	return rt.call_function('str_replace', [rt.new_string('\n'),
		rt.new_string('\n' + (this.indent()).str()), var_sSpaceString_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) indent() rt.PhpVal {
	return rt.call_function('str_repeat', [rt.get_property(this.oFormat, 'sIndentation'),
		rt.call_method(this.oFormat, 'getIndentationLevel', []rt.PhpVal{})])
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformatter(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
		oFormat:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'space' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.space(dispatch_arg_0, dispatch_arg_1)
		}
		'spaceAfterRuleName' {
			return this.spaceafterrulename()
		}
		'spaceBeforeRules' {
			return this.spacebeforerules()
		}
		'spaceAfterRules' {
			return this.spaceafterrules()
		}
		'spaceBetweenRules' {
			return this.spacebetweenrules()
		}
		'spaceBeforeBlocks' {
			return this.spacebeforeblocks()
		}
		'spaceAfterBlocks' {
			return this.spaceafterblocks()
		}
		'spaceBetweenBlocks' {
			return this.spacebetweenblocks()
		}
		'spaceBeforeSelectorSeparator' {
			return this.spacebeforeselectorseparator()
		}
		'spaceAfterSelectorSeparator' {
			return this.spaceafterselectorseparator()
		}
		'spaceBeforeListArgumentSeparator' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.spacebeforelistargumentseparator(dispatch_arg_0)
		}
		'spaceAfterListArgumentSeparator' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.spaceafterlistargumentseparator(dispatch_arg_0)
		}
		'spaceBeforeOpeningBrace' {
			return this.spacebeforeopeningbrace()
		}
		'safely' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.safely(dispatch_arg_0)
		}
		'implode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.implode(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'removeLastSemicolon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.removelastsemicolon(dispatch_arg_0)
		}
		'comments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Commentable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.comments(mut dispatch_arg_0))
		}
		'prepareSpace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.preparespace(dispatch_arg_0)
		}
		'indent' {
			return this.indent()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'oFormat' { return this.oFormat }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'oFormat' {
			this.oFormat = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
