import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException) construct(var_sMessage rt.PhpVal, iLineNo i64) {
	this.setposition(rt.new_int(iLineNo))
	if !(iLineNo == 0) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Exception.construct(var_sMessage.dup())
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_sourceexception(iLineNo i64, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(iLineNo, arg_1)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_exception() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_SourceException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_parsing_sourceexception_php() {
}
