import rt

struct Class_Automattic_WooCommerce_Internal_Email_EmailFont {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_email_emailfont() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Email_EmailFont', 'font', rt.create_array([
		rt.ArrayItem{ key: 'Arial', val: "Arial, 'Helvetica Neue', Helvetica, sans-serif" },
		rt.ArrayItem{
			key: 'Comic Sans MS'
			val: "'Comic Sans MS', 'Marker Felt-Thin', Arial, sans-serif"
		},
		rt.ArrayItem{
			key: 'Courier New'
			val: "'Courier New', Courier, 'Lucida Sans Typewriter', 'Lucida Typewriter', monospace"
		},
		rt.ArrayItem{ key: 'Georgia', val: "Georgia, Times, 'Times New Roman', serif" },
		rt.ArrayItem{
			key: 'Helvetica'
			val: "'Helvetica Neue', Helvetica, Roboto, Arial, sans-serif"
		},
		rt.ArrayItem{ key: 'Lucida', val: "'Lucida Sans Unicode', 'Lucida Grande', sans-serif" },
		rt.ArrayItem{ key: 'Tahoma', val: 'Tahoma, Verdana, Segoe, sans-serif' },
		rt.ArrayItem{
			key: 'Times New Roman'
			val: "'Times New Roman', Times, Baskerville, Georgia, serif"
		},
		rt.ArrayItem{
			key: 'Trebuchet MS'
			val: "'Trebuchet MS', 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', Tahoma, sans-serif"
		},
		rt.ArrayItem{ key: 'Verdana', val: 'Verdana, Geneva, sans-serif' },
	]))
}

fn create_automattic_woocommerce_internal_email_emailfont(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Email_EmailFont {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_EmailFont{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailFont) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_EmailFont) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_EmailFont) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
