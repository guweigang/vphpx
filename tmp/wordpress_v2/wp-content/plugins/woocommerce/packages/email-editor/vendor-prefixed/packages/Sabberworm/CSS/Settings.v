import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings {
	rt.PhpObjectBase
pub mut:
	bMultibyteSupport rt.PhpVal = rt.new_null()
	sDefaultCharset   rt.PhpVal = rt.new_string('utf-8')
	bLenientParsing   rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) construct() {
	this.bMultibyteSupport = rt.call_function('extension_loaded', [
		rt.new_string('mbstring'),
	])
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings.create() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings',
		[]string{}, create_automattic_woocommerce_emaileditorvendor_sabberworm_css_settings())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) withmultibytesupport(bMultibyteSupport bool) rt.PhpVal {
	this.bMultibyteSupport = rt.new_bool(bMultibyteSupport)
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) withdefaultcharset(var_sDefaultCharset rt.PhpVal) rt.PhpVal {
	this.sDefaultCharset = var_sDefaultCharset.clone()
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) withlenientparsing(bLenientParsing bool) rt.PhpVal {
	this.bLenientParsing = rt.new_bool(bLenientParsing)
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) bestrict() rt.PhpVal {
	return this.withlenientparsing(false)
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_settings() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings{
		PhpObjectBase:     rt.PhpObjectBase{}
		bMultibyteSupport: rt.new_null()
		sDefaultCharset:   rt.new_string('utf-8')
		bLenientParsing:   rt.new_bool(true)
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'create' {
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings.create()
		}
		'withMultibyteSupport' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.withmultibytesupport(dispatch_arg_0)
		}
		'withDefaultCharset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.withdefaultcharset(dispatch_arg_0)
		}
		'withLenientParsing' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.withlenientparsing(dispatch_arg_0)
		}
		'beStrict' {
			return this.bestrict()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'bMultibyteSupport' { return this.bMultibyteSupport }
		'sDefaultCharset' { return this.sDefaultCharset }
		'bLenientParsing' { return this.bLenientParsing }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'bMultibyteSupport' {
			this.bMultibyteSupport = val
			return true
		}
		'sDefaultCharset' {
			this.sDefaultCharset = val
			return true
		}
		'bLenientParsing' {
			this.bLenientParsing = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
