import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
pub mut:
		sStringQuotingType rt.PhpVal = rt.new_string('"')
		bRGBHashNotation rt.PhpVal = rt.new_bool(true)
		bSemicolonAfterLastRule rt.PhpVal = rt.new_bool(true)
		sSpaceAfterRuleName rt.PhpVal = rt.new_string(' ')
		sSpaceBeforeRules rt.PhpVal = rt.new_string('')
		sSpaceAfterRules rt.PhpVal = rt.new_string('')
		sSpaceBetweenRules rt.PhpVal = rt.new_string('')
		sSpaceBeforeBlocks rt.PhpVal = rt.new_string('')
		sSpaceAfterBlocks rt.PhpVal = rt.new_string('')
		sSpaceBetweenBlocks rt.PhpVal = rt.new_string('\n')
		sBeforeAtRuleBlock rt.PhpVal = rt.new_string('')
		sAfterAtRuleBlock rt.PhpVal = rt.new_string('')
		sSpaceBeforeSelectorSeparator rt.PhpVal = rt.new_string('')
		sSpaceAfterSelectorSeparator rt.PhpVal = rt.new_string(' ')
		sSpaceBeforeListArgumentSeparator rt.PhpVal = rt.new_string('')
		aSpaceBeforeListArgumentSeparators rt.PhpVal = rt.new_array()
		sSpaceAfterListArgumentSeparator rt.PhpVal = rt.new_string('')
		aSpaceAfterListArgumentSeparators rt.PhpVal = rt.new_array()
		sSpaceBeforeOpeningBrace rt.PhpVal = rt.new_string(' ')
		sBeforeDeclarationBlock rt.PhpVal = rt.new_string('')
		sAfterDeclarationBlockSelectors rt.PhpVal = rt.new_string('')
		sAfterDeclarationBlock rt.PhpVal = rt.new_string('')
		sIndentation rt.PhpVal = rt.new_string('\t')
		bIgnoreExceptions bool
		bRenderComments rt.PhpVal = rt.new_bool(false)
		oFormatter rt.PhpVal = rt.new_null()
		oNextLevelFormat rt.PhpVal = rt.new_null()
		iIndentationLevel rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) construct()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) get(var_sName rt.PhpVal) rt.PhpVal {
	mut var_aVarPrefixes := rt.create_array([rt.ArrayItem{ key: none, val: 'a' }, rt.ArrayItem{ key: none, val: 's' }, rt.ArrayItem{ key: none, val: 'm' }, rt.ArrayItem{ key: none, val: 'b' }, rt.ArrayItem{ key: none, val: 'f' }, rt.ArrayItem{ key: none, val: 'o' }, rt.ArrayItem{ key: none, val: 'c' }, rt.ArrayItem{ key: none, val: 'i' }])
	{
		mut iter_1 := var_aVarPrefixes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sPrefix := item_1.val
			mut var_sFieldName := rt.new_string(rt.concat(var_sPrefix, rt.call_function('ucfirst', [var_sName.dup()])))
			if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat', []string{}, &this), '{"nodeType":"Expr_Variable","line":261,"name":"sFieldName"}')).is_null() {
				return rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat', []string{}, &this), '{"nodeType":"Expr_Variable","line":262,"name":"sFieldName"}')
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) set(var_aNames rt.PhpVal, var_mValue rt.PhpVal) bool {
	mut var_aNames_mutated := var_aNames
	mut var_aVarPrefixes := rt.create_array([rt.ArrayItem{ key: none, val: 'a' }, rt.ArrayItem{ key: none, val: 's' }, rt.ArrayItem{ key: none, val: 'm' }, rt.ArrayItem{ key: none, val: 'b' }, rt.ArrayItem{ key: none, val: 'f' }, rt.ArrayItem{ key: none, val: 'o' }, rt.ArrayItem{ key: none, val: 'c' }, rt.ArrayItem{ key: none, val: 'i' }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_aNames_mutated.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_aNames_mutated = rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('Before'), var_aNames_mutated.dup()]) }, rt.ArrayItem{ key: none, val: rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('Between'), var_aNames_mutated.dup()]) }, rt.ArrayItem{ key: none, val: rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('After'), var_aNames_mutated.dup()]) }])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_aNames_mutated.dup().is_array()))))) {
		var_aNames_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_aNames_mutated }])
	}
	{
		mut iter_1 := var_aVarPrefixes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sPrefix := item_1.val
			mut var_bDidReplace := rt.new_bool(rt.new_bool(false))
			{
				mut iter_2 := var_aNames_mutated.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_sName := item_2.val
					mut var_sFieldName := rt.new_string(rt.concat(var_sPrefix, rt.call_function('ucfirst', [var_sName.dup()])))
					if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat', []string{}, &this), '{"nodeType":"Expr_Variable","line":293,"name":"sFieldName"}')).is_null() {
						this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":294,"name":"sFieldName"}', var_mValue.dup())
						var_bDidReplace = rt.new_bool(rt.new_bool(true))
					}
				}
			}
			if rt.is_true(var_bDidReplace) {
				return this
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) magic_call(var_sMethodName rt.PhpVal, mut var_aArguments Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_array) rt.PhpVal {
	if rt.is_true(rt.identical(rt.call_function('strpos', [var_sMethodName.dup(), rt.new_string('set')]), rt.new_int(0))) {
		return rt.new_bool(this.set(rt.call_function('substr', [var_sMethodName.dup(), rt.new_int(3)]), var_aArguments.array_get(0)))
	} else if rt.is_true(rt.identical(rt.call_function('strpos', [var_sMethodName.dup(), rt.new_string('get')]), rt.new_int(0))) {
		return this.get(rt.call_function('substr', [var_sMethodName.dup(), rt.new_int(3)]))
	} else if rt.is_true(rt.call_function('method_exists', [Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormatter.class(), var_sMethodName.dup()])) {
		return rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: this.getformatter() }, rt.ArrayItem{ key: none, val: var_sMethodName }]), var_aArguments])
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Exception', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_exception('Unknown OutputFormat method called: ' + (var_sMethodName).str())))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) indentwithtabs(iNumber i64) rt.PhpVal {
	return this.setindentation(rt.call_function('str_repeat', [rt.new_string('\t'), rt.new_int(iNumber)]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) indentwithspaces(iNumber i64) rt.PhpVal {
	return this.setindentation(rt.call_function('str_repeat', [rt.new_string(' '), rt.new_int(iNumber)]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) nextlevel() rt.PhpVal {
	if rt.is_true(rt.identical(this.oNextLevelFormat, rt.new_null())) {
		this.oNextLevelFormat = // unsupported expression: Expr_Clone
		rt.post_inc(rt.get_property(this.oNextLevelFormat, 'iIndentationLevel'))
		rt.set_property(this.oNextLevelFormat, 'oFormatter', rt.new_null())
	}
	return this.oNextLevelFormat
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) belenient()  {
	this.bIgnoreExceptions = true
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) getformatter() rt.PhpVal {
	if rt.is_true(rt.identical(this.oFormatter, rt.new_null())) {
		this.oFormatter = create_automattic_woocommerce_vendor_sabberworm_css_outputformatter(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat', []string{}, &this).dup())
	}
	return this.oFormatter
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) level() rt.PhpVal {
	return this.iIndentationLevel
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.create() rt.PhpVal {
	return create_automattic_woocommerce_vendor_sabberworm_css_outputformat()
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.createcompact() rt.PhpVal {
	mut var_format := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.create()
	rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_format, 'set', [rt.new_string('Space*Rules'), rt.new_string('')]), 'set', [rt.new_string('Space*Blocks'), rt.new_string('')]), 'setSpaceAfterRuleName', [rt.new_string('')]), 'setSpaceBeforeOpeningBrace', [rt.new_string('')]), 'setSpaceAfterSelectorSeparator', [rt.new_string('')]), 'setRenderComments', [rt.new_bool(false)])
	return var_format.dup()
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.createpretty() rt.PhpVal {
	mut var_format := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.create()
	rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_format, 'set', [rt.new_string('Space*Rules'), rt.new_string('\n')]), 'set', [rt.new_string('Space*Blocks'), rt.new_string('\n')]), 'setSpaceBetweenBlocks', [rt.new_string('\n\n')]), 'set', [rt.new_string('SpaceAfterListArgumentSeparators'), rt.create_array([rt.ArrayItem{ key: ',', val: ' ' }])]), 'setRenderComments', [rt.new_bool(true)])
	return var_format.dup()
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormatter {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
		sStringQuotingType: rt.new_string('"')
		bRGBHashNotation: rt.new_bool(true)
		bSemicolonAfterLastRule: rt.new_bool(true)
		sSpaceAfterRuleName: rt.new_string(' ')
		sSpaceBeforeRules: rt.new_string('')
		sSpaceAfterRules: rt.new_string('')
		sSpaceBetweenRules: rt.new_string('')
		sSpaceBeforeBlocks: rt.new_string('')
		sSpaceAfterBlocks: rt.new_string('')
		sSpaceBetweenBlocks: rt.new_string('\n')
		sBeforeAtRuleBlock: rt.new_string('')
		sAfterAtRuleBlock: rt.new_string('')
		sSpaceBeforeSelectorSeparator: rt.new_string('')
		sSpaceAfterSelectorSeparator: rt.new_string(' ')
		sSpaceBeforeListArgumentSeparator: rt.new_string('')
		aSpaceBeforeListArgumentSeparators: rt.new_array()
		sSpaceAfterListArgumentSeparator: rt.new_string('')
		aSpaceAfterListArgumentSeparators: rt.new_array()
		sSpaceBeforeOpeningBrace: rt.new_string(' ')
		sBeforeDeclarationBlock: rt.new_string('')
		sAfterDeclarationBlockSelectors: rt.new_string('')
		sAfterDeclarationBlock: rt.new_string('')
		sIndentation: rt.new_string('\t')
		bIgnoreExceptions: false
		bRenderComments: rt.new_bool(false)
		oFormatter: rt.new_null()
		oNextLevelFormat: rt.new_null()
		iIndentationLevel: rt.new_int(0)
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_exception() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Exception {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_outputformatter() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormatter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1))
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.magic_call(dispatch_arg_0, mut dispatch_arg_1)
		}
		'indentWithTabs' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.indentwithtabs(dispatch_arg_0)
		}
		'indentWithSpaces' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.indentwithspaces(dispatch_arg_0)
		}
		'nextLevel' {
			return this.nextlevel()
		}
		'beLenient' {
			this.belenient()
			return rt.new_null()
		}
		'getFormatter' {
			return this.getformatter()
		}
		'level' {
			return this.level()
		}
		'create' {
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.create()
		}
		'createCompact' {
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.createcompact()
		}
		'createPretty' {
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat.createpretty()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sStringQuotingType' { return this.sStringQuotingType }
		'bRGBHashNotation' { return this.bRGBHashNotation }
		'bSemicolonAfterLastRule' { return this.bSemicolonAfterLastRule }
		'sSpaceAfterRuleName' { return this.sSpaceAfterRuleName }
		'sSpaceBeforeRules' { return this.sSpaceBeforeRules }
		'sSpaceAfterRules' { return this.sSpaceAfterRules }
		'sSpaceBetweenRules' { return this.sSpaceBetweenRules }
		'sSpaceBeforeBlocks' { return this.sSpaceBeforeBlocks }
		'sSpaceAfterBlocks' { return this.sSpaceAfterBlocks }
		'sSpaceBetweenBlocks' { return this.sSpaceBetweenBlocks }
		'sBeforeAtRuleBlock' { return this.sBeforeAtRuleBlock }
		'sAfterAtRuleBlock' { return this.sAfterAtRuleBlock }
		'sSpaceBeforeSelectorSeparator' { return this.sSpaceBeforeSelectorSeparator }
		'sSpaceAfterSelectorSeparator' { return this.sSpaceAfterSelectorSeparator }
		'sSpaceBeforeListArgumentSeparator' { return this.sSpaceBeforeListArgumentSeparator }
		'aSpaceBeforeListArgumentSeparators' { return this.aSpaceBeforeListArgumentSeparators }
		'sSpaceAfterListArgumentSeparator' { return this.sSpaceAfterListArgumentSeparator }
		'aSpaceAfterListArgumentSeparators' { return this.aSpaceAfterListArgumentSeparators }
		'sSpaceBeforeOpeningBrace' { return this.sSpaceBeforeOpeningBrace }
		'sBeforeDeclarationBlock' { return this.sBeforeDeclarationBlock }
		'sAfterDeclarationBlockSelectors' { return this.sAfterDeclarationBlockSelectors }
		'sAfterDeclarationBlock' { return this.sAfterDeclarationBlock }
		'sIndentation' { return this.sIndentation }
		'bIgnoreExceptions' { return rt.new_bool(this.bIgnoreExceptions) }
		'bRenderComments' { return this.bRenderComments }
		'oFormatter' { return this.oFormatter }
		'oNextLevelFormat' { return this.oNextLevelFormat }
		'iIndentationLevel' { return this.iIndentationLevel }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sStringQuotingType' { this.sStringQuotingType = val; return true }
		'bRGBHashNotation' { this.bRGBHashNotation = val; return true }
		'bSemicolonAfterLastRule' { this.bSemicolonAfterLastRule = val; return true }
		'sSpaceAfterRuleName' { this.sSpaceAfterRuleName = val; return true }
		'sSpaceBeforeRules' { this.sSpaceBeforeRules = val; return true }
		'sSpaceAfterRules' { this.sSpaceAfterRules = val; return true }
		'sSpaceBetweenRules' { this.sSpaceBetweenRules = val; return true }
		'sSpaceBeforeBlocks' { this.sSpaceBeforeBlocks = val; return true }
		'sSpaceAfterBlocks' { this.sSpaceAfterBlocks = val; return true }
		'sSpaceBetweenBlocks' { this.sSpaceBetweenBlocks = val; return true }
		'sBeforeAtRuleBlock' { this.sBeforeAtRuleBlock = val; return true }
		'sAfterAtRuleBlock' { this.sAfterAtRuleBlock = val; return true }
		'sSpaceBeforeSelectorSeparator' { this.sSpaceBeforeSelectorSeparator = val; return true }
		'sSpaceAfterSelectorSeparator' { this.sSpaceAfterSelectorSeparator = val; return true }
		'sSpaceBeforeListArgumentSeparator' { this.sSpaceBeforeListArgumentSeparator = val; return true }
		'aSpaceBeforeListArgumentSeparators' { this.aSpaceBeforeListArgumentSeparators = val; return true }
		'sSpaceAfterListArgumentSeparator' { this.sSpaceAfterListArgumentSeparator = val; return true }
		'aSpaceAfterListArgumentSeparators' { this.aSpaceAfterListArgumentSeparators = val; return true }
		'sSpaceBeforeOpeningBrace' { this.sSpaceBeforeOpeningBrace = val; return true }
		'sBeforeDeclarationBlock' { this.sBeforeDeclarationBlock = val; return true }
		'sAfterDeclarationBlockSelectors' { this.sAfterDeclarationBlockSelectors = val; return true }
		'sAfterDeclarationBlock' { this.sAfterDeclarationBlock = val; return true }
		'sIndentation' { this.sIndentation = val; return true }
		'bIgnoreExceptions' { this.bIgnoreExceptions = (val).to_bool(); return true }
		'bRenderComments' { this.bRenderComments = val; return true }
		'oFormatter' { this.oFormatter = val; return true }
		'oNextLevelFormat' { this.oNextLevelFormat = val; return true }
		'iIndentationLevel' { this.iIndentationLevel = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_outputformat_php() {
}
