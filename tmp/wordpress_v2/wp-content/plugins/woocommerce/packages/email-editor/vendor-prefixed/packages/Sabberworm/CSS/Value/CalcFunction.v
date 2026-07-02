import rt

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction.t_operand() i64 {
	return 1
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction.t_operator() i64 {
	return 2
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction.parse(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, bIgnoreCase bool) rt.PhpVal {
	mut var_aOperators := rt.create_array([rt.ArrayItem{ key: none, val: '+' },
		rt.ArrayItem{ key: none, val: '-' }, rt.ArrayItem{ key: none, val: '*' },
		rt.ArrayItem{ key: none, val: '/' }])
	mut var_sFunction := var_oParserState.parseidentifier()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_oParserState.peek(), rt.new_string('('))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('('),
			var_oParserState.peek(), rt.new_string('literal'), var_oParserState.currentline())))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_sFunction.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'calc' },
			rt.ArrayItem{ key: none, val: '-moz-calc' }, rt.ArrayItem{
				key: none
				val: '-webkit-calc'
			}]),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('calc'),
			var_sFunction.clone(), rt.new_string('literal'), var_oParserState.currentline())))
	}
	var_oParserState.consume(rt.new_string('('))
	mut var_oCalcList :=
		create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_calcrulevaluelist(var_oParserState.currentline())
	mut var_oList := create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_rulevaluelist(rt.new_string(','),
		var_oParserState.currentline())
	mut var_iNestingLevel := rt.new_int(0)
	mut var_iLastComponentType := rt.new_null()
	for rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState.comes(rt.new_string(')'))))))
		|| rt.is_true(rt.greater(var_iNestingLevel, rt.new_int(0))) {
		if rt.is_true(var_oParserState.isend())
			&& rt.is_true(rt.identical(var_iNestingLevel, rt.new_int(0))) {
			break
		}
		var_oParserState.consumewhitespace()
		if rt.is_true(var_oParserState.comes(rt.new_string('('))) {
			rt.post_inc(var_iNestingLevel)
			var_oCalcList.addlistcomponent(var_oParserState.consume(rt.new_int(1)))
			var_oParserState.consumewhitespace()
			continue
		} else if rt.is_true(var_oParserState.comes(rt.new_string(')'))) {
			rt.post_dec(var_iNestingLevel)
			var_oCalcList.addlistcomponent(var_oParserState.consume(rt.new_int(1)))
			var_oParserState.consumewhitespace()
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_iLastComponentType,
			Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction.t_operand()))))
		{
			mut iife_temp_0 :=
				Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{}
			mut iife_result_0 := iife_temp_0.parseprimitivevalue(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
				[]string{}, var_oParserState))
			mut var_oVal := iife_result_0
			var_oCalcList.addlistcomponent(var_oVal.clone())
			var_iLastComponentType =
				Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction.t_operand()
		} else {
			if rt.is_true(rt.call_function('in_array', [var_oParserState.peek(),
				var_aOperators.clone()]))
			{
				if rt.is_true(var_oParserState.comes(rt.new_string('-')))
					|| rt.is_true(var_oParserState.comes(rt.new_string('+'))) {
					if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_oParserState.peek(rt.new_int(1), rt.new_int(-1)), rt.new_string(' ')))))
						|| !(rt.is_true(var_oParserState.comes(rt.new_string('- ')))
						|| rt.is_true(var_oParserState.comes(rt.new_string('+ ')))) {
						rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
							[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.concat(rt.concat(rt.new_string(' '),
							var_oParserState.peek()), rt.new_string(' ')),
							(var_oParserState.peek(rt.new_int(1), rt.new_int(-1))).str() +
							(var_oParserState.peek(rt.new_int(2))).str(), rt.new_string('literal'),
							var_oParserState.currentline())))
					}
				}
				var_oCalcList.addlistcomponent(var_oParserState.consume(rt.new_int(1)))
				var_iLastComponentType =
					Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction.t_operator()
			} else {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
					[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(rt.call_function('sprintf', [
					rt.new_string('Next token was expected to be an operand of type %s. Instead "%s" was found.'),
					rt.call_function('implode', [rt.new_string(', '),
						var_aOperators.clone()]),
					var_oParserState.peek(),
				]), rt.new_string(''), rt.new_string('custom'), var_oParserState.currentline())))
			}
		}
		var_oParserState.consumewhitespace()
	}
	var_oList.addlistcomponent(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcRuleValueList',
		[]string{}, var_oCalcList))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState.isend())))) {
		var_oParserState.consume(rt.new_string(')'))
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction', [
		'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction',
	], create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_calcfunction(var_sFunction.clone(),
		var_oList, rt.new_string(','), var_oParserState.currentline()))
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcRuleValueList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_calcfunction(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssfunction(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction{
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

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_calcrulevaluelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcRuleValueList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcRuleValueList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_rulevaluelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction.parse(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcRuleValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcRuleValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CalcRuleValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
