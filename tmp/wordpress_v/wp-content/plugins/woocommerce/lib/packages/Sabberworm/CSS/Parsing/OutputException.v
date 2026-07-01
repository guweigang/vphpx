import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException) construct(var_sMessage rt.PhpVal, iLineNo i64) {
	this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_SourceException.construct(var_sMessage.dup(),
		rt.new_int(iLineNo))
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_SourceException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_outputexception(iLineNo i64, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(iLineNo, arg_1)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_sourceexception() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_SourceException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_SourceException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_OutputException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_SourceException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_SourceException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_SourceException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_parsing_outputexception_php() {
}
