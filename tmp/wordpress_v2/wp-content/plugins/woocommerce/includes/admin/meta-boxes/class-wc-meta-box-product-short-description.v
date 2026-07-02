import rt

struct Class_WC_Meta_Box_Product_Short_Description {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Product_Short_Description.output(var_post rt.PhpVal) {
	mut var_settings := {
		'textarea_name': rt.new_string('excerpt')
		'quicktags':     {
			'buttons': rt.new_string('em,strong,link')
		}
		'tinymce':       {
			'theme_advanced_buttons1': rt.new_string('bold,italic,strikethrough,separator,bullist,numlist,separator,blockquote,separator,justifyleft,justifycenter,justifyright,separator,link,unlink,separator,undo,redo,separator')
			'theme_advanced_buttons2': rt.new_string('')
		}
		'editor_css':    rt.new_string('<style>#wp-excerpt-editor-container .wp-editor-area{height:175px; width:100%;}</style>')
	}
	rt.call_function('wp_editor', [
		rt.call_function('htmlspecialchars_decode', [
			rt.get_property(var_post, 'post_excerpt'),
			rt.get_constant('ENT_QUOTES'),
		]),
		rt.new_string('excerpt'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_short_description_editor_settings'),
			rt.create_array_from_native_map(var_settings),
		]),
	])
}

fn create_wc_meta_box_product_short_description(_args ...rt.PhpVal) &Class_WC_Meta_Box_Product_Short_Description {
	mut obj := &Class_WC_Meta_Box_Product_Short_Description{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Product_Short_Description) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Short_Description.output(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Product_Short_Description) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Product_Short_Description) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
