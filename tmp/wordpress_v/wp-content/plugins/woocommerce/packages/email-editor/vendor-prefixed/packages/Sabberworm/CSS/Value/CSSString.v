import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	rt.PhpObjectBase
pub mut:
		sString rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) construct(var_sString rt.PhpVal, iLineNo i64)  {
	mut var_sString_mutated := var_sString
	this.sString = var_sString_mutated.dup()
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue.construct(rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString.parse(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) rt.PhpVal {
	mut var_sBegin := var_oParserState.peek()
	mut var_sQuote := rt.new_null()
	if rt.is_true(rt.identical(var_sBegin, rt.new_string('\''))) {
		var_sQuote = rt.new_string(rt.new_string('\''))
	} else if rt.is_true(rt.identical(var_sBegin, rt.new_string('"'))) {
		var_sQuote = rt.new_string(rt.new_string('"'))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_oParserState.consume(var_sQuote.dup())
	}
	mut var_sResult := rt.new_string(rt.new_string(''))
	mut var_sContent := rt.new_null()
	if rt.is_true(rt.identical(var_sQuote, rt.new_null())) {
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/[\\s{}()<>\\[\\]]/isu'), var_oParserState.peek()]))))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	} else {
		for rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState.comes(var_sQuote.dup()))))) {
			var_sContent = var_oParserState.parsecharacter(rt.new_bool(false))
			if rt.is_true(rt.identical(var_sContent, rt.new_null())) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException', []string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(rt.concat(rt.new_string('Non-well-formed quoted string '), var_oParserState.peek(rt.new_int(3))), var_oParserState.currentline())))
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_oParserState.consume(var_sQuote.dup())
	}
	return create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssstring(var_sResult, var_oParserState.currentline())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) setstring(var_sString rt.PhpVal)  {
	mut var_sString_mutated := var_sString
	this.sString = var_sString_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) getstring() rt.PhpVal {
	return this.sString
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) render(var_oOutputFormat rt.PhpVal) string {
	mut var_sString := rt.call_function('addslashes', [this.sString])
	var_sString = rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string('\\A'), var_sString.dup()])
	return (rt.call_method(var_oOutputFormat, 'getStringQuotingType', []rt.PhpVal{})).str() + (var_sString).str() + (rt.call_method(var_oOutputFormat, 'getStringQuotingType', []rt.PhpVal{})).str()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssstring(iLineNo i64, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString{
		PhpObjectBase: rt.PhpObjectBase{}
		sString: rt.new_null()
	}
	obj.construct(iLineNo, arg_1)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_primitivevalue() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue{
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

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString.parse(mut dispatch_arg_0)
		}
		'setString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setstring(dispatch_arg_0)
			return rt.new_null()
		}
		'getString' {
			return this.getstring()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sString' { return this.sString }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sString' { this.sString = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_value_cssstring_php() {
}
