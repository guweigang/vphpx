import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	rt.PhpObjectBase
pub mut:
	sExpected  rt.PhpVal = rt.new_null()
	sFound     rt.PhpVal = rt.new_null()
	sMatchType rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) construct(var_sExpected rt.PhpVal, var_sFound rt.PhpVal, sMatchType string, iLineNo i64) {
	this.sExpected = var_sExpected.dup()
	this.sFound = var_sFound.dup()
	this.sMatchType = rt.new_string(sMatchType).dup()
	mut var_sMessage :=
		rt.new_string(rt.new_string('Token “${var_sExpected.to_string()}” (${var_sMatchType}) not found. Got “${var_sFound.to_string()}”.'))
	if rt.is_true(rt.identical(this.sMatchType, rt.new_string('search'))) {
		var_sMessage =
			rt.new_string(rt.new_string('Search for “${var_sExpected.to_string()}” returned no results. Context: “${var_sFound.to_string()}”.'))
	} else if rt.is_true(rt.identical(this.sMatchType, rt.new_string('count'))) {
		var_sMessage =
			rt.new_string(rt.new_string('Next token was expected to have ${var_sExpected.to_string()} chars. Context: “${var_sFound.to_string()}”.'))
	} else if rt.is_true(rt.identical(this.sMatchType, rt.new_string('identifier'))) {
		var_sMessage =
			rt.new_string(rt.new_string('Identifier expected. Got “${var_sFound.to_string()}”'))
	} else if rt.is_true(rt.identical(this.sMatchType, rt.new_string('custom'))) {
		var_sMessage =
			rt.new_string(rt.new_string('${var_sExpected.to_string()} ${var_sFound.to_string()}'.trim_space()))
	}
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException.construct(var_sMessage.dup(),
		rt.new_int(iLineNo))
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_unexpectedtokenexception(sMatchType string, iLineNo i64, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException{
		PhpObjectBase: rt.PhpObjectBase{}
		sExpected:     rt.new_null()
		sFound:        rt.new_null()
		sMatchType:    rt.new_null()
	}
	obj.construct(sMatchType, iLineNo, arg_2, arg_3)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sExpected' { return this.sExpected }
		'sFound' { return this.sFound }
		'sMatchType' { return this.sMatchType }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sExpected' {
			this.sExpected = val
			return true
		}
		'sFound' {
			this.sFound = val
			return true
		}
		'sMatchType' {
			this.sMatchType = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_parsing_unexpectedtokenexception_php() {
}
