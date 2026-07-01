import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor {
	rt.PhpObjectBase
pub mut:
		theme_controller rt.PhpVal = rt.new_null()
		css_inliner rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) construct()  {
	this.theme_controller = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class()])
	this.css_inliner = create_automattic_woocommerce_emaileditor_email_css_inliner()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) get_woo_content(mut var_wc_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) string {
	mut var_woo_content := rt.new_string(this.capture_woo_content(mut var_wc_email))
	mut var_woo_content_with_css := rt.new_string(this.inline_css((var_woo_content).str()))
	return this.get_html_body_content((var_woo_content_with_css).str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) prepare_css(css string) string {
	mut css_mutated := css
	rt.call_function('remove_filter', [rt.new_string('woocommerce_email_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'prepare_css' }])])
	return (// unsupported expression: Expr_Cast_String).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) get_html_body_content(html string) string {
	mut var_matches := rt.new_null()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<body[^>]*>(.*?)<\\/body>/is'), rt.new_string(html), var_matches.dup()])) {
		return (var_matches.array_get(1)).str()
	}
	return html
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) inline_css(woo_content string) string {
	mut woo_content_mutated := woo_content
	if woo_content_mutated == '' {
		return ''
	}
	mut var_css := rt.call_method(this.theme_controller, 'get_stylesheet_for_rendering', []rt.PhpVal{})
	// unsupported expression: Expr_AssignOp_Concat
	return (rt.call_method(rt.call_method(rt.call_method(this.css_inliner, 'from_html', [rt.new_string(woo_content_mutated).dup()]), 'inline_css', [var_css.dup()]), 'render', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) get_woo_content_styles() string {
	return '\n\t\t\t.email-order-details td,\n\t\t\t.email-order-details th {\n\t\t\t\tpadding: 8px 12px;\n\t\t\t}\n\t\t\t.email-order-details td:first-child,\n\t\t\t.email-order-details th:first-child {\n\t\t\t\tpadding-left: 0;\n\t\t\t}\n\t\t\t.email-order-details td:last-child,\n\t\t\t.email-order-details th:last-child {\n\t\t\t\tpadding-right: 0;\n\t\t\t}\n\t\t\t.order-item-data td {\n\t\t\t\tborder: 0;\n\t\t\t\tpadding: 0;\n\t\t\t\tvertical-align: top;\n\t\t\t}\n\t\t\t.order-item-data img {\n\t\t\t\tborder-radius: 4px;\n\t\t\t}\n\t\t\t.order-totals th,\n\t\t\t.order-totals td {\n\t\t\t\tfont-weight: 400;\n\t\t\t\tpadding-bottom: 5px;\n\t\t\t\tpadding-top: 5px;\n\t\t\t}\n\t\t\t.order-totals-total th {\n\t\t\t\tfont-weight: 700;\n\t\t\t}\n\t\t\t.order-totals-total td {\n\t\t\t\tfont-weight: 700;\n\t\t\t\tfont-size: 20px;\n\t\t\t}\n\t\t\th2.email-order-detail-heading {\n\t\t\t\tfont-size: 20px;\n\t\t\t\tfont-weight: 700;\n\t\t\t\tline-height: 1.6;\n\t\t\t}\n\t\t\th2.email-order-detail-heading span {\n\t\t\t\tfont-size: 14px;\n\t\t\t\tfont-weight: 400;\n\t\t\t\tcolor: #757575;\n\t\t\t}\n\t\t\t.email-order-item-meta {\n\t\t\t\tfont-size: 14px;\n\t\t\t\tline-height: 1.4;\n\t\t\t}\n\t\t'
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) capture_woo_content(mut var_wc_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) string {
	return (var_wc_email.get_block_editor_email_template_content()).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_woocontentprocessor() &Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		theme_controller: rt.new_null()
		css_inliner: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_editor_container() &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_css_inliner() &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_woo_content' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_woo_content(mut dispatch_arg_0))
		}
		'prepare_css' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.prepare_css(dispatch_arg_0))
		}
		'get_html_body_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_html_body_content(dispatch_arg_0))
		}
		'inline_css' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.inline_css(dispatch_arg_0))
		}
		'get_woo_content_styles' {
			return rt.new_string(this.get_woo_content_styles())
		}
		'capture_woo_content' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.capture_woo_content(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_controller' { return this.theme_controller }
		'css_inliner' { return this.css_inliner }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_controller' { this.theme_controller = val; return true }
		'css_inliner' { this.css_inliner = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_woocontentprocessor_php() {
	// unsupported statement: Stmt_Declare
}
