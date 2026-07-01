import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception {
	rt.PhpObjectBase
pub mut:
	more_info string
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) construct(message string, more_info string) {
	this.Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Exception.construct(rt.new_string(message))
	this.more_info = more_info
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) get_more_info() string {
	return this.more_info
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_html2text_exception(message string, more_info string) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		more_info:     ''
	}
	obj.construct(message, more_info)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_exception() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_more_info' {
			return rt.new_string(this.get_more_info())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'more_info' { return rt.new_string(this.more_info) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'more_info' {
			this.more_info = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_class_html2text_exception_php() {
	// unsupported statement: Stmt_Declare
}
