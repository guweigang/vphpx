import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer {
	rt.PhpObjectBase
pub mut:
		template_registry rt.PhpVal = rt.new_null()
		assets_manager rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer) construct()  {
	mut var_editor_container := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}; return temp.container() }()
	this.template_registry = rt.call_method(var_editor_container, 'get', [Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry.class()])
	mut var_assets_manager := rt.call_method(var_editor_container, 'get', [Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager.class()])
	rt.call_method(var_assets_manager, 'set_assets_path', [(rt.get_constant('WC_ABSPATH')).str() + (rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + 'email-editor/'])
	rt.call_method(var_assets_manager, 'set_assets_url', [(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/' + (rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + 'email-editor/'])
	this.assets_manager = var_assets_manager.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer) render()  {
	mut var_post_id := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('post')) { rt.new_int(rt.get_superglobal('_GET').array_get('post').to_i64()) } else { rt.new_int(0) })
	mut var_template_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('template')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('template')])]) } else { rt.new_string('') }
	mut var_post_type := if rt.is_true(var_template_id) { rt.new_string('wp_template') } else { Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type() }
	var_post_id = if rt.is_true(var_template_id) { var_template_id } else { var_post_id }
	mut var_edited_item := this.get_edited_item(var_post_id.dup(), (var_post_type).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_edited_item)))) {
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_script_localization_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_PageRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_localized_data' }])])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('email-editor-integration'), rt.new_bool(true))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_style(arg_0, arg_1, arg_2) }(rt.new_string('email-editor-integration'), rt.new_string('style'), rt.new_bool(true))
	rt.call_method(this.assets_manager, 'load_editor_assets', [var_edited_item.dup(), rt.new_string('wc-admin-email-editor-integration')])
	rt.call_method(this.assets_manager, 'render_email_editor_html', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('woocommerce_email_editor_script_localization_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_PageRenderer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_localized_data' }]), rt.new_int(10)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer) update_localized_data(mut var_localized_data Class_Automattic_WooCommerce_Internal_EmailEditor_array) rt.PhpVal {
	mut var_localized_data_mutated := var_localized_data
	mut var_wc_emails := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails{}; return temp.instance() }()
	mut var_email_types := rt.call_method(var_wc_emails, 'get_emails', []rt.PhpVal{})
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_email := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_email, 'id') }, rt.ArrayItem{ key: 'label', val: rt.get_property(var_email, 'title') }, rt.ArrayItem{ key: 'id', val: rt.call_function('get_class', [var_email.dup()]) }])
	}
	mut var_email := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_email, 'id') }, rt.ArrayItem{ key: 'label', val: rt.get_property(var_email, 'title') }, rt.ArrayItem{ key: 'id', val: rt.call_function('get_class', [var_email.dup()]) }])
	}
	mut var_email := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_email, 'id') }, rt.ArrayItem{ key: 'label', val: rt.get_property(var_email, 'title') }, rt.ArrayItem{ key: 'id', val: rt.call_function('get_class', [var_email.dup()]) }])
	}
	mut var_email := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_email, 'id') }, rt.ArrayItem{ key: 'label', val: rt.get_property(var_email, 'title') }, rt.ArrayItem{ key: 'id', val: rt.call_function('get_class', [var_email.dup()]) }])
	}
	var_email_types = rt.call_function('array_values', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_email_types.dup()])])
	var_localized_data_mutated.array_set('email_types', var_email_types.dup())
	var_localized_data_mutated.array_get_mut('editor_settings').array_set('isFullScreenForced', true)
	var_localized_data_mutated.array_get_mut('editor_settings').array_set('displaySendEmailButton', false)
	return rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_array', []string{}, var_localized_data_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer) get_edited_item(var_id rt.PhpVal, type string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('wp_template'), rt.new_string(type))) {
		mut var_wp_template := rt.call_function('get_block_template', [var_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_template)))) {
			return rt.new_null()
		}
		mut var_email_template := rt.call_method(this.template_registry, 'get_by_slug', [rt.get_property(var_wp_template, 'slug')])
		return if rt.is_true(rt.new_bool(rt.instance_of(var_email_template, 'Automattic_WooCommerce_EmailEditor_Engine_Templates_Template'))) { var_wp_template } else { rt.new_null() }
	}
	mut var_post := rt.call_function('get_post', [var_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Internal_EmailEditor_WP_Post'))) && rt.is_true(rt.identical(rt.new_string(type), rt.get_property(var_post, 'post_type'))))) {
		return var_post.dup()
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_pagerenderer() &Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer{
		PhpObjectBase: rt.PhpObjectBase{}
		template_registry: rt.new_null()
		assets_manager: rt.new_null()
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

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wc_emails() &Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		'update_localized_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update_localized_data(mut dispatch_arg_0)
		}
		'get_edited_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_edited_item(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_registry' { return this.template_registry }
		'assets_manager' { return this.assets_manager }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'template_registry' { this.template_registry = val; return true }
		'assets_manager' { this.assets_manager = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_pagerenderer_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
