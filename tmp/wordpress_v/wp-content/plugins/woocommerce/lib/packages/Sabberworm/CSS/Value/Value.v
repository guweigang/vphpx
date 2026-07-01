import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value) construct(iLineNo i64)  {
	this.setposition(rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parsevalue(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState, mut var_aListDelimiters Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array) rt.PhpVal {
	mut var_aStack := rt.new_array()
	var_oParserState.consumewhitespace()
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_oParserState.comes(rt.new_string('}'))) || rt.is_true(var_oParserState.comes(rt.new_string(';'))))) || rt.is_true(var_oParserState.comes(rt.new_string('!'))))) || rt.is_true(var_oParserState.comes(rt.new_string(')'))))) || rt.is_true(var_oParserState.comes(rt.new_string('\\'))))) || rt.is_true(var_oParserState.isend())))))) {
		if var_aStack.dup().array_count() > 0 {
			mut var_bFoundDelimiter := rt.new_bool(rt.new_bool(false))
			{
				mut iter_1 := var_aListDelimiters.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_sDelimiter := item_1.val
					if rt.is_true(var_oParserState.comes(var_sDelimiter.dup())) {
						var_aStack.dup().array_push(var_oParserState.consume(var_sDelimiter.dup()))
						var_oParserState.consumewhitespace()
						var_bFoundDelimiter = rt.new_bool(rt.new_bool(true))
						break
					}
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_bFoundDelimiter)))) {
				var_aStack.dup().array_push(rt.new_string(' '))
			}
		}
		var_aStack.dup().array_push(Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseprimitivevalue(mut var_oParserState))
		var_oParserState.consumewhitespace()
	}
	{
		mut iter_1 := var_aListDelimiters.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sDelimiter := item_1.val
			mut var_iStackLength := rt.new_int(rt.new_int(var_aStack.dup().array_count()))
			if rt.is_true(rt.identical(var_iStackLength, rt.new_int(1))) {
				return var_aStack.array_get(0)
			}
			mut var_aNewStack := rt.new_array()
			{
				mut var_iStartPosition := rt.new_int(rt.new_int(0))
				for {
					if !(rt.is_true(rt.less(var_iStartPosition, var_iStackLength))) { break }
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_iStartPosition, rt.sub(var_iStackLength, rt.new_int(1)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
						var_aNewStack.array_push(var_aStack.array_get(var_iStartPosition))
						continue
					}
					mut var_iLength := rt.new_int(rt.new_int(2))
					{
						mut var_i := rt.add(var_iStartPosition, rt.new_int(3))
						for {
							if !(rt.is_true(rt.less(var_i, var_iStackLength))) { break }
							if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								break
							}
							// unsupported expression: Expr_AssignOp_Plus
							rt.pre_inc(var_iLength)
						}
					}
					mut var_oList := create_automattic_woocommerce_vendor_sabberworm_css_value_rulevaluelist(var_sDelimiter.dup(), var_oParserState.currentline())
					{
						mut var_i := var_iStartPosition.dup()
						for {
							if !(rt.is_true(rt.less(rt.sub(var_i, var_iStartPosition), rt.mul(var_iLength, rt.new_int(2))))) { break }
							var_oList.addlistcomponent(var_aStack.array_get(var_i))
							// unsupported expression: Expr_AssignOp_Plus
						}
					}
					var_aNewStack.array_push(var_oList.dup())
					// unsupported expression: Expr_AssignOp_Plus
					rt.pre_inc(var_iStartPosition)
				}
			}
			mut var_aStack := var_aNewStack.dup()
		}
	}
	if !(var_aStack.array_isset(rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception(rt.concat(rt.concat(rt.new_string(' '), var_oParserState.peek()), rt.new_string(' ')), rt.concat(var_oParserState.peek(rt.new_int(1), // unsupported expression: Expr_UnaryMinus), var_oParserState.peek(rt.new_int(2))), rt.new_string('literal'), var_oParserState.currentline())))
	}
	return var_aStack.array_get(0)
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseidentifierorfunction(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState, bIgnoreCase bool) rt.PhpVal {
	mut var_oAnchor := var_oParserState.anchor()
	mut var_mResult := var_oParserState.parseidentifier(rt.new_bool(bIgnoreCase))
	if rt.is_true(var_oParserState.comes(rt.new_string('('))) {
		rt.call_method(var_oAnchor, 'backtrack', []rt.PhpVal{})
		if rt.is_true(var_oParserState.streql(rt.new_string('url'), var_mResult.dup())) {
			var_mResult = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_oParserState.streql(rt.new_string('calc'), var_mResult.dup())) || rt.is_true(var_oParserState.streql(rt.new_string('-webkit-calc'), var_mResult.dup())))) || rt.is_true(var_oParserState.streql(rt.new_string('-moz-calc'), var_mResult.dup())))) {
			var_mResult = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcFunction{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState))
		} else {
			var_mResult = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction{}; return temp.parse(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState), rt.new_bool(bIgnoreCase))
		}
	}
	return var_mResult.dup()
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseprimitivevalue(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) rt.PhpVal {
	mut var_oValue := rt.new_null()
	var_oParserState.consumewhitespace()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_oParserState.peek().is_long() || var_oParserState.peek().is_double())) || rt.is_true(rt.new_bool(rt.is_true(var_oParserState.comes(rt.new_string('-.'))) && rt.is_true(rt.new_bool(var_oParserState.peek(rt.new_int(1), rt.new_int(2)).is_long() || var_oParserState.peek(rt.new_int(1), rt.new_int(2)).is_double())))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_oParserState.comes(rt.new_string('-'))) || rt.is_true(var_oParserState.comes(rt.new_string('.'))))) && rt.is_true(rt.new_bool(var_oParserState.peek(rt.new_int(1), rt.new_int(1)).is_long() || var_oParserState.peek(rt.new_int(1), rt.new_int(1)).is_double())))))) {
		var_oValue = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_oParserState.comes(rt.new_string('#'))) || rt.is_true(var_oParserState.comes(rt.new_string('rgb'), rt.new_bool(true))))) || rt.is_true(var_oParserState.comes(rt.new_string('hsl'), rt.new_bool(true))))) {
		var_oValue = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState))
	} else if rt.is_true(rt.new_bool(rt.is_true(var_oParserState.comes(rt.new_string('\''))) || rt.is_true(var_oParserState.comes(rt.new_string('"'))))) {
		var_oValue = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSString{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState))
	} else if rt.is_true(rt.new_bool(rt.is_true(var_oParserState.comes(rt.new_string('progid:'))) && rt.is_true(rt.get_property(var_oParserState.getsettings(), 'bLenientParsing')))) {
		var_oValue = Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parsemicrosoftfilter(mut var_oParserState)
	} else if rt.is_true(var_oParserState.comes(rt.new_string('['))) {
		var_oValue = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName{}; return temp.parse(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, var_oParserState))
	} else if rt.is_true(var_oParserState.comes(rt.new_string('U+'))) {
		var_oValue = Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseunicoderangevalue(mut var_oParserState)
	} else {
		mut var_sNextChar := var_oParserState.peek(rt.new_int(1))
		var_oValue = Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseidentifierorfunction(mut var_oParserState)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException') {
			mut var_e := var_e_1.dup()
			if rt.is_true(rt.call_function('in_array', [var_sNextChar.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '-' }, rt.ArrayItem{ key: none, val: '*' }, rt.ArrayItem{ key: none, val: '/' }]), rt.new_bool(true)])) {
				var_oValue = var_oParserState.consume(rt.new_int(1))
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
	}
	var_oParserState.consumewhitespace()
	return var_oValue.dup()
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parsemicrosoftfilter(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) rt.PhpVal {
	mut var_sFunction := var_oParserState.consumeuntil(rt.new_string('('), rt.new_bool(false), rt.new_bool(true))
	mut var_aArguments := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parsevalue(mut var_oParserState, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array](rt.create_array([rt.ArrayItem{ key: none, val: ',' }, rt.ArrayItem{ key: none, val: '=' }])))
	return create_automattic_woocommerce_vendor_sabberworm_css_value_cssfunction(var_sFunction.dup(), var_aArguments.dup(), rt.new_string(','), var_oParserState.currentline())
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseunicoderangevalue(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) string {
	mut var_iCodepointMaxLength := rt.new_int(rt.new_int(6))
	mut var_sRange := rt.new_string(rt.new_string(''))
	var_oParserState.consume(rt.new_string('U+'))
	for {
		if rt.is_true(var_oParserState.comes(rt.new_string('-'))) {
			var_iCodepointMaxLength = rt.new_int(rt.new_int(13))
			// unsupported statement: Stmt_Nop
		}
		// unsupported expression: Expr_AssignOp_Concat
		if !(rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.new_int(var_sRange.dup().to_string().len), var_iCodepointMaxLength)) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/[A-Fa-f0-9\\?-]/'), var_oParserState.peek()]))))) {
			break
		}
	}
	return "U+${var_sRange.to_string()}"
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcFunction {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSString {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_value(iLineNo i64) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_rulevaluelist() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_RuleValueList{
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

fn create_automattic_woocommerce_vendor_sabberworm_css_value_url() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_calcfunction() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcFunction {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcFunction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_cssfunction() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_size() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_color() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_cssstring() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSString {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSString{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_linename() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parseValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parsevalue(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'parseIdentifierOrFunction' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseidentifierorfunction(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parsePrimitiveValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseprimitivevalue(mut dispatch_arg_0)
		}
		'parseMicrosoftFilter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parsemicrosoftfilter(mut dispatch_arg_0)
		}
		'parseUnicodeRangeValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value.parseunicoderangevalue(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_URL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CalcFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_value_value_php() {
}
