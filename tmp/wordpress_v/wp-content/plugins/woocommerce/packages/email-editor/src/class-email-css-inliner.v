import rt

struct Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner {
	rt.PhpObjectBase
pub mut:
		inliner rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) from_html(unprocessed_html string) rt.PhpVal {
	mut var_inliner_class := rt.new_string(this.get_inliner_class())
	mut var_that := create_automattic_woocommerce_emaileditor_self()
	rt.set_property(var_that, 'inliner', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_{"nodeType":"Expr_Variable","line":40,"name":"inliner_class"}{}; return temp.fromhtml(arg_0) }(rt.new_string(unprocessed_html)))
	return mut var_that
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) inline_css(css string) rt.PhpVal {
	if !(!(this.inliner).is_null()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_LogicException', []string{}, create_automattic_woocommerce_emaileditor_logicexception(rt.new_string('You must call from_html before calling inline_css'))))
	}
	rt.call_method(this.inliner, 'inlineCss', [rt.new_string(css)])
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Email_Css_Inliner', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) render() string {
	if !(!(this.inliner).is_null()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_LogicException', []string{}, create_automattic_woocommerce_emaileditor_logicexception(rt.new_string('You must call from_html before calling render'))))
	}
	return (rt.call_method(this.inliner, 'render', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) get_inliner_class() string {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Automattic\\WooCommerce\\Vendor\\Pelago\\Emogrifier\\CssInliner')])) {
		return 'Automattic\\WooCommerce\\Vendor\\Pelago\\Emogrifier\\CssInliner'
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Automattic\\WooCommerce\\EmailEditorVendor\\Pelago\\Emogrifier\\CssInliner')])) {
		return 'Automattic\\WooCommerce\\EmailEditorVendor\\Pelago\\Emogrifier\\CssInliner'
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Exception', []string{}, create_automattic_woocommerce_emaileditor_exception(rt.new_string('CssInliner class not found'))))
	return ''
}

struct Class_Automattic_WooCommerce_EmailEditor_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_{"nodeType":"Expr_Variable","line":40,"name":"inliner_class"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_LogicException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_email_css_inliner() &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner{
		PhpObjectBase: rt.PhpObjectBase{}
		inliner: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_self() &Class_Automattic_WooCommerce_EmailEditor_self {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_{"nodetype":"expr_variable","line":40,"name":"inliner_class"}() &Class_Automattic_WooCommerce_EmailEditor_{"nodeType":"Expr_Variable","line":40,"name":"inliner_class"} {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_{"nodeType":"Expr_Variable","line":40,"name":"inliner_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_logicexception() &Class_Automattic_WooCommerce_EmailEditor_LogicException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_exception() &Class_Automattic_WooCommerce_EmailEditor_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'from_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.from_html(dispatch_arg_0)
		}
		'inline_css' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.inline_css(dispatch_arg_0)
		}
		'render' {
			return rt.new_string(this.render())
		}
		'get_inliner_class' {
			return rt.new_string(this.get_inliner_class())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'inliner' { return this.inliner }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'inliner' { this.inliner = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_{"nodeType":"Expr_Variable","line":40,"name":"inliner_class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_{"nodeType":"Expr_Variable","line":40,"name":"inliner_class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_{"nodeType":"Expr_Variable","line":40,"name":"inliner_class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_class_email_css_inliner_php() {
	// unsupported statement: Stmt_Declare
}
