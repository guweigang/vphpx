import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) construct(mut var_aComponents Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array, iLineNo i64) {
	this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList.construct(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_array',
		[]string{}, var_aComponents), rt.new_string(' '), rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName.parse(mut var_oParserState Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) rt.PhpVal {
	var_oParserState.consume(rt.new_string('['))
	var_oParserState.consumewhitespace()
	mut var_aNames := rt.new_array()
	for {
		if rt.is_true(rt.get_property(var_oParserState.getsettings(), 'bLenientParsing')) {
			var_aNames.array_push(var_oParserState.parseidentifier())
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
				'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException')
			{
				mut var_e := var_e_1.clone()
				if rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState.comes(rt.new_string(']')))))) {
					rt.throw_exception(var_e)
				}
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
			var_aNames.array_push(var_oParserState.parseidentifier())
		}
		var_oParserState.consumewhitespace()
		if !(rt.is_true(rt.new_bool(!(rt.is_true(var_oParserState.comes(rt.new_string(']'))))))) {
			break
		}
	}
	var_oParserState.consume(rt.new_string(']'))
	return rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName', [
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList',
	], create_automattic_woocommerce_vendor_sabberworm_css_value_linename(var_aNames.clone(),
		var_oParserState.currentline()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_vendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) render(var_oOutputFormat rt.PhpVal) string {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat{}
	mut iife_result_0 := iife_temp_0.createcompact()
	return '[' +
		(this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList.render(iife_result_0)).str() + ']'
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_linename(arg_0 rt.PhpVal, iLineNo i64) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, iLineNo)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_value_valuelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName.parse(mut dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_LineName) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
