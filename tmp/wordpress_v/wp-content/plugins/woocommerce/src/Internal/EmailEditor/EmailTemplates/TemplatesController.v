import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController {
	rt.PhpObjectBase
pub mut:
		template_prefix rt.PhpVal = rt.new_string('woocommerce')
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController) init()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_register_templates'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_templates' }])])
	rt.call_function('add_filter', [rt.new_string('get_block_templates'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_email_templates' }]), rt.new_int(100), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController) filter_email_templates(var_templates rt.PhpVal) rt.PhpVal {
	mut var_templates_mutated := var_templates
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')])) && rt.is_true(rt.get_constant('REST_REQUEST')))) {
		return var_templates_mutated.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')]))))))) {
		return var_templates_mutated.dup()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_current_screen) && rt.is_true(rt.identical(rt.new_string('site-editor'), rt.get_property(var_current_screen, 'id'))))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
		var_templates_mutated = rt.call_function('array_filter', [var_templates_mutated.dup(), rt.new_closure(closure_1_fn)])
	}
	return var_templates_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController) register_templates(mut var_templates_registry Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) rt.PhpVal {
	mut var_templates := rt.new_array()
	var_templates.array_push(create_automattic_woocommerce_internal_emaileditor_emailtemplates_wooemailtemplate())
	{
		mut iter_1 := var_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			mut var_the_template := create_automattic_woocommerce_emaileditor_engine_templates_template(this.template_prefix, rt.call_method(var_template, 'get_slug', []rt.PhpVal{}), rt.call_method(var_template, 'get_title', []rt.PhpVal{}), rt.call_method(var_template, 'get_description', []rt.PhpVal{}), rt.call_method(var_template, 'get_content', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type() }]))
			var_templates_registry.register(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Template', []string{}, var_the_template))
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry', []string{}, var_templates_registry)
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_emailtemplates_templatescontroller() &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController{
		PhpObjectBase: rt.PhpObjectBase{}
		template_prefix: rt.new_string('woocommerce')
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_emailtemplates_wooemailtemplate() &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_templates_template() &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'filter_email_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_email_templates(dispatch_arg_0)
		}
		'register_templates' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.register_templates(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_prefix' { return this.template_prefix }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'template_prefix' { this.template_prefix = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_emailtemplates_templatescontroller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
