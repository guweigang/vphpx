import rt

struct Class_Automattic_WooCommerce_Internal_Email_EmailFont {
	rt.PhpObjectBase
pub mut:
	font rt.PhpVal = rt.new_array()
}

fn create_automattic_woocommerce_internal_email_emailfont() &Class_Automattic_WooCommerce_Internal_Email_EmailFont {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_EmailFont{
		PhpObjectBase: rt.PhpObjectBase{}
		font:          rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailFont) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_EmailFont) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'font' { return this.font }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailFont) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'font' {
			this.font = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_internal_email_emailfont_php() {
	// unsupported statement: Stmt_Declare
}
