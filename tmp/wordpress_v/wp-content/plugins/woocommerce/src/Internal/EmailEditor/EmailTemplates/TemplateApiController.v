import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController) get_template_data(var_template_data rt.PhpVal) rt.PhpVal {
	mut var_template_slug := if !(var_template_data.array_get('slug')).is_null() { var_template_data.array_get('slug') } else { rt.new_null() }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'sender_settings', val: rt.create_array([rt.ArrayItem{ key: 'from_name', val: rt.call_function('get_option', [rt.new_string('woocommerce_email_from_name'), rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')])]) }, rt.ArrayItem{ key: 'from_address', val: rt.call_function('get_option', [rt.new_string('woocommerce_email_from_address')]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController) save_template_data(mut var_data Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_array, mut var_template_post Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Block_Template) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate.template_slug(), rt.get_property(var_template_post, 'slug'))) && var_data.array_isset(rt.new_string('sender_settings')))) {
		mut var_new_from_name := if !(var_data.array_get('sender_settings').array_get('from_name')).is_null() { var_data.array_get('sender_settings').array_get('from_name') } else { rt.new_null() }
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('update_option', [rt.new_string('woocommerce_email_from_name'), var_new_from_name.dup()])
		}
		mut var_new_from_address := if !(var_data.array_get('sender_settings').array_get('from_address')).is_null() { var_data.array_get('sender_settings').array_get('from_address') } else { rt.new_null() }
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_new_from_address)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [var_new_from_address.dup(), rt.get_constant('FILTER_VALIDATE_EMAIL')]))))))) {
			return create_automattic_woocommerce_internal_emaileditor_emailtemplates_wp_error(rt.new_string('invalid_email_address'), rt.call_function('__', [rt.new_string('Invalid email address provided for sender settings'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		rt.call_function('update_option', [rt.new_string('woocommerce_email_from_address'), var_new_from_address.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController) get_template_data_schema() rt.PhpVal {
	return rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}; return temp.object(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'sender_settings', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}; return temp.object(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'preheader', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}; return temp.string() }() }, rt.ArrayItem{ key: 'preview_url', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}; return temp.string() }() }])) }])), 'to_array', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_emailtemplates_templateapicontroller() &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_emailtemplates_wp_error() &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_builder() &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_template_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_template_data(dispatch_arg_0)
		}
		'save_template_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Block_Template](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.save_template_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_template_data_schema' {
			return this.get_template_data_schema()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_emailtemplates_templateapicontroller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
