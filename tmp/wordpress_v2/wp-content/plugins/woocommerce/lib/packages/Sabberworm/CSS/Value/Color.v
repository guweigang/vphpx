import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) construct(mut var_aColor Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array, iLineNo i64) {
	mut var_aColor_mutated := var_aColor
	this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction.construct(rt.call_function('implode', [
		rt.new_string(''),
		rt.func_array_keys(var_aColor_mutated),
	]), rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array', []string{},
		var_aColor_mutated), rt.new_string(','), rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color.parse(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState, bIgnoreCase bool) rt.PhpVal {
	mut var_aColor := rt.new_array()
	if rt.is_true(var_oParserState.comes(rt.new_string('#'))) {
		var_oParserState.consume(rt.new_string('#'))
		mut var_sValue := var_oParserState.parseidentifier(rt.new_bool(false))
		if rt.is_true(rt.identical(var_oParserState.strlen(var_sValue.clone()), rt.new_int(3))) {
			var_sValue = rt.new_string((var_sValue.array_get(rt.new_int(0))).str() +
				(var_sValue.array_get(rt.new_int(0))).str() +
				(var_sValue.array_get(rt.new_int(1))).str() +
				(var_sValue.array_get(rt.new_int(1))).str() +
				(var_sValue.array_get(rt.new_int(2))).str() +
				(var_sValue.array_get(rt.new_int(2))).str())
		} else if rt.is_true(rt.identical(var_oParserState.strlen(var_sValue.clone()),
			rt.new_int(4)))
		{
			var_sValue = rt.new_string((var_sValue.array_get(rt.new_int(0))).str() +
				(var_sValue.array_get(rt.new_int(0))).str() +
				(var_sValue.array_get(rt.new_int(1))).str() +
				(var_sValue.array_get(rt.new_int(1))).str() +
				(var_sValue.array_get(rt.new_int(2))).str() +
				(var_sValue.array_get(rt.new_int(2))).str() +
				(var_sValue.array_get(rt.new_int(3))).str() +
				(var_sValue.array_get(rt.new_int(3))).str())
		}
		if rt.is_true(rt.identical(var_oParserState.strlen(var_sValue.clone()), rt.new_int(8))) {
			var_aColor = rt.create_array([
				rt.ArrayItem{ key: 'r', val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(rt.new_string(
					(var_sValue.array_get(rt.new_int(0))).str() +
					(var_sValue.array_get(rt.new_int(1))).str()).to_i64()), rt.new_null(),
					rt.new_bool(true), var_oParserState.currentline()) },
				rt.ArrayItem{ key: 'g', val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(rt.new_string(
					(var_sValue.array_get(rt.new_int(2))).str() +
					(var_sValue.array_get(rt.new_int(3))).str()).to_i64()), rt.new_null(),
					rt.new_bool(true), var_oParserState.currentline()) },
				rt.ArrayItem{ key: 'b', val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(rt.new_string(
					(var_sValue.array_get(rt.new_int(4))).str() +
					(var_sValue.array_get(rt.new_int(5))).str()).to_i64()), rt.new_null(),
					rt.new_bool(true), var_oParserState.currentline()) },
				rt.ArrayItem{ key: 'a', val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.call_function('round', [
					Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color.maprange(rt.new_int(rt.new_string(
						(var_sValue.array_get(rt.new_int(6))).str() +
						(var_sValue.array_get(rt.new_int(7))).str()).to_i64()), rt.new_int(0),
						rt.new_int(255), rt.new_int(0), rt.new_int(1)),
					rt.new_int(2),
				]), rt.new_null(), rt.new_bool(true), var_oParserState.currentline()) },
			])
		} else if rt.is_true(rt.identical(var_oParserState.strlen(var_sValue.clone()),
			rt.new_int(6)))
		{
			var_aColor = rt.create_array([
				rt.ArrayItem{ key: 'r', val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(rt.new_string(
					(var_sValue.array_get(rt.new_int(0))).str() +
					(var_sValue.array_get(rt.new_int(1))).str()).to_i64()), rt.new_null(),
					rt.new_bool(true), var_oParserState.currentline()) },
				rt.ArrayItem{ key: 'g', val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(rt.new_string(
					(var_sValue.array_get(rt.new_int(2))).str() +
					(var_sValue.array_get(rt.new_int(3))).str()).to_i64()), rt.new_null(),
					rt.new_bool(true), var_oParserState.currentline()) },
				rt.ArrayItem{ key: 'b', val: create_automattic_woocommerce_vendor_sabberworm_css_value_size(rt.new_int(rt.new_string(
					(var_sValue.array_get(rt.new_int(4))).str() +
					(var_sValue.array_get(rt.new_int(5))).str()).to_i64()), rt.new_null(),
					rt.new_bool(true), var_oParserState.currentline()) },
			])
		} else {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException',
				[]string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_string('Invalid hex color value'),
				var_sValue.clone(), rt.new_string('custom'), var_oParserState.currentline())))
		}
	} else {
		mut var_sColorMode := var_oParserState.parseidentifier(rt.new_bool(true))
		var_oParserState.consumewhitespace()
		var_oParserState.consume(rt.new_string('('))
		mut var_bContainsVar := rt.new_bool(false)
		mut var_iLength := var_oParserState.strlen(var_sColorMode.clone())
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_iLength))) { break
			 }
			var_oParserState.consumewhitespace()
			if rt.is_true(var_oParserState.comes(rt.new_string('var'))) {
				mut iife_temp_0 :=
					Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction{}
				mut iife_result_0 := iife_temp_0.parseidentifierorfunction(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState',
					[]string{}, var_oParserState))
				var_aColor.array_set(var_sColorMode.array_get(var_i), iife_result_0)
				var_bContainsVar = rt.new_bool(true)
			} else {
				mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size{}
				mut iife_result_1 := iife_temp_1.parse(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState',
					[]string{}, var_oParserState), rt.new_bool(true))
				var_aColor.array_set(var_sColorMode.array_get(var_i), iife_result_1)
			}
			if rt.is_true(var_bContainsVar)
				&& rt.is_true(var_oParserState.comes(rt.new_string(')'))) {
				break
			}
			var_oParserState.consumewhitespace()
			if rt.is_true(rt.less(var_i, rt.sub(var_iLength, rt.new_int(1)))) {
				var_oParserState.consume(rt.new_string(','))
			}
			rt.pre_inc(var_i)
		}
		var_oParserState.consume(rt.new_string(')'))
		if rt.is_true(var_bContainsVar) {
			return rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction',
				[]string{}, create_automattic_woocommerce_vendor_sabberworm_css_value_cssfunction(var_sColorMode.clone(), rt.call_function('array_values', [
				var_aColor.clone(),
			]), rt.new_string(','), var_oParserState.currentline()))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color', [
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction',
	], create_automattic_woocommerce_vendor_sabberworm_css_value_color(var_aColor.clone(),
		var_oParserState.currentline()))
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color.maprange(var_fVal rt.PhpVal, var_fFromMin rt.PhpVal, var_fFromMax rt.PhpVal, var_fToMin rt.PhpVal, var_fToMax rt.PhpVal) rt.PhpVal {
	mut var_fFromRange := rt.sub(var_fFromMax, var_fFromMin)
	mut var_fToRange := rt.sub(var_fToMax, var_fToMin)
	mut var_fMultiplier := rt.div(var_fToRange, var_fFromRange)
	mut var_fNewVal := rt.sub(var_fVal, var_fFromMin)
	var_fNewVal = rt.mul(var_fNewVal, var_fMultiplier)
	return rt.add(var_fNewVal, var_fToMin)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) getcolor() rt.PhpVal {
	return rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color', [
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction',
	], &this), 'aComponents')
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) setcolor(mut var_aColor Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array) {
	mut var_aColor_mutated := var_aColor
	this.setname(rt.call_function('implode', [rt.new_string(''),
		rt.func_array_keys(var_aColor_mutated)]))
	this.dispatch_set_prop('aComponents', var_aColor_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) getcolordescription() rt.PhpVal {
	return this.getname()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_vendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) render(var_oOutputFormat rt.PhpVal) string {
	if rt.is_true(rt.call_method(var_oOutputFormat, 'getRGBHashNotation', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.call_function('implode', [rt.new_string(''), rt.func_array_keys(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color', ['Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction'], &this), 'aComponents'))]), rt.new_string('rgb'))) {
		mut var_sResult := rt.call_function('sprintf', [rt.new_string('%02x%02x%02x'),
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color', [
				'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction',
			], &this), 'aComponents').array_get(rt.new_string('r')), 'getSize', []rt.PhpVal{}),
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color', [
				'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction',
			], &this), 'aComponents').array_get(rt.new_string('g')), 'getSize', []rt.PhpVal{}),
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color', [
				'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction',
			], &this), 'aComponents').array_get(rt.new_string('b')), 'getSize', []rt.PhpVal{})])
		return '#' + (if rt.is_true(rt.equal(var_sResult.array_get(rt.new_int(0)), var_sResult.array_get(rt.new_int(1)))) && rt.is_true(rt.equal(var_sResult.array_get(rt.new_int(2)), var_sResult.array_get(rt.new_int(3)))) && rt.is_true(rt.equal(var_sResult.array_get(rt.new_int(4)), var_sResult.array_get(rt.new_int(5)))) {
			rt.concat(rt.concat(var_sResult.array_get(rt.new_int(0)), var_sResult.array_get(rt.new_int(2))), var_sResult.array_get(rt.new_int(4)))
		} else {
			var_sResult
		}).str()
	}
	return (this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction.render(var_oOutputFormat.clone())).str()
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Size {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_color(arg_0 rt.PhpVal, iLineNo i64) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, iLineNo)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_cssfunction(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction{
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

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color.parse(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		'mapRange' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color.maprange(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'getColor' {
			return this.getcolor()
		}
		'setColor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setcolor(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getColorDescription' {
			return this.getcolordescription()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_Color) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
