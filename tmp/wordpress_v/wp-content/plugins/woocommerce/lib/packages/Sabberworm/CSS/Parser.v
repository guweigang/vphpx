import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser {
	rt.PhpObjectBase
pub mut:
	oParserState rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser) construct(var_sText rt.PhpVal, var_oParserSettings rt.PhpVal, iLineNo i64) {
	mut var_oParserSettings_mutated := var_oParserSettings
	if rt.is_true(rt.identical(var_oParserSettings_mutated, rt.new_null())) {
		var_oParserSettings_mutated = fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings{}
			return temp.create()
		}()
	}
	this.oParserState = create_automattic_woocommerce_vendor_sabberworm_css_parsing_parserstate(var_sText.dup(),
		var_oParserSettings_mutated.dup(), rt.new_int(iLineNo).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser) setcharset(var_sCharset rt.PhpVal) {
	rt.call_method(this.oParserState, 'setCharset', [var_sCharset.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser) getcharset() {
	rt.call_method(this.oParserState, 'getCharset', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser) parse() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_Document{}
		return temp.parse(arg_0)
	}(this.oParserState)
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_Document {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parser(arg_0 rt.PhpVal, iLineNo i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		oParserState:  rt.new_null()
	}
	obj.construct(arg_0, iLineNo, arg_2)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_settings() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_parserstate() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_csslist_document() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_Document {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_Document{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'setCharset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setcharset(dispatch_arg_0)
			return rt.new_null()
		}
		'getCharset' {
			this.getcharset()
			return rt.new_null()
		}
		'parse' {
			return this.parse()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'oParserState' { return this.oParserState }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'oParserState' {
			this.oParserState = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_Document) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_Document) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_Document) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_parser_php() {
}
