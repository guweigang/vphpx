import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL {
	rt.PhpObjectBase
pub mut:
	oURL rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) construct(mut var_oURL Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString, iLineNo i64) {
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue.construct(rt.new_int(iLineNo))
	this.oURL = var_oURL.dup()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL.parse(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) rt.PhpVal {
	mut var_oAnchor := var_oParserState.anchor()
	mut var_sIdentifier := rt.new_string(rt.new_string(''))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(3)))) { break
			 }
			mut var_sChar := var_oParserState.parsecharacter(rt.new_bool(true))
			if rt.is_true(rt.identical(var_sChar, rt.new_null())) {
				break
			}
			// unsupported expression: Expr_AssignOp_Concat
			rt.post_inc(var_i)
		}
	}
	mut var_bUseUrl := var_oParserState.streql(var_sIdentifier.dup(), rt.new_string('url'))
	if rt.is_true(var_bUseUrl) {
		var_oParserState.consumewhitespace()
		var_oParserState.consume(rt.new_string('('))
	} else {
		rt.call_method(var_oAnchor, 'backtrack', []rt.PhpVal{})
	}
	var_oParserState.consumewhitespace()
	mut var_oResult := create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_url(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString{}
		return temp.parse(arg_0)
	}(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
		[]string{}, var_oParserState)), var_oParserState.currentline())
	if rt.is_true(var_bUseUrl) {
		var_oParserState.consumewhitespace()
		var_oParserState.consume(rt.new_string(')'))
	}
	return mut var_oResult
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) seturl(mut var_oURL Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) {
	this.oURL = var_oURL.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) geturl() rt.PhpVal {
	return this.oURL
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) render(var_oOutputFormat rt.PhpVal) string {
	return rt.concat(rt.concat(rt.new_string('url('), rt.call_method(this.oURL, 'render', [
		var_oOutputFormat.dup(),
	])), rt.new_string(')'))
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_url(arg_0 rt.PhpVal, iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL{
		PhpObjectBase: rt.PhpObjectBase{}
		oURL:          rt.new_null()
	}
	obj.construct(arg_0, iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_primitivevalue() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue{
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

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL.parse(mut dispatch_arg_0)
		}
		'setURL' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.seturl(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getURL' {
			return this.geturl()
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

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'oURL' { return this.oURL }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'oURL' {
			this.oURL = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_value_url_php() {
}
