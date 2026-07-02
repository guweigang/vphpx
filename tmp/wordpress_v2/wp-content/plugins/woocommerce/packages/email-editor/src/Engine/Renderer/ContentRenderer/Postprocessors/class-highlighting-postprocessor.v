import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor) postprocess(html string) string {
	return (rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '<mark' },
			rt.ArrayItem{ key: none, val: '</mark>' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '<span' },
			rt.ArrayItem{ key: none, val: '</span>' }]),
		rt.new_string(html),
	])).str()
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_highlighting_postprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'postprocess' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.postprocess(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
