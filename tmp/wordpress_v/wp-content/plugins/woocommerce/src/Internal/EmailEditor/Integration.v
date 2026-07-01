import rt

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type() string {
	return 'woo_email'
}
struct Class_Automattic_WooCommerce_Internal_EmailEditor_Integration {
	rt.PhpObjectBase
pub mut:
		editor_page_renderer rt.PhpVal = rt.new_null()
		dependency_check rt.PhpVal = rt.new_null()
		template_api_controller rt.PhpVal = rt.new_null()
		email_api_controller rt.PhpVal = rt.new_null()
		wc_email_instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) construct()  {
	mut var_editor_container := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}; return temp.container() }()
	this.dependency_check = rt.call_method(var_editor_container, 'get', [Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) init()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.dependency_check, 'are_dependencies_met', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'initialize' }])])
	rt.call_function('add_action', [rt.new_string('before_delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'delete_email_template_associated_with_email_editor_post' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) initialize()  {
	this.init_logger()
	this.init_hooks()
	this.extend_post_api()
	this.extend_template_post_api()
	this.register_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) init_logger()  {
	mut var_editor_container := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}; return temp.container() }()
	mut var_logger := rt.call_method(var_editor_container, 'get', [Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger.class()])
	rt.call_method(var_logger, 'set_logger', [create_automattic_woocommerce_internal_emaileditor_logger(rt.call_function('wc_get_logger', []rt.PhpVal{}))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) init_hooks()  {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplatesController.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTagManager.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.class()])
	rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails.class()])
	this.editor_page_renderer = rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_PageRenderer.class()])
	this.template_api_controller = rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_TemplateApiController.class()])
	this.email_api_controller = rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController.class()])
	mut var_registered_emails := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails{}; return temp.instance() }(), 'get_emails', []rt.PhpVal{})
	if var_registered_emails.array_isset(rt.new_string('WC_Email_New_Order')) {
		this.wc_email_instance = var_registered_emails.array_get('WC_Email_New_Order')
	} else {
		mut var_first_email_key := rt.call_function('array_key_first', [var_registered_emails.dup()])
		this.wc_email_instance = var_registered_emails.array_get(var_first_email_key)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) register_hooks()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_post_types'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_email_post_type' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_is_email_editor_page'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'is_editor_page' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('replace_editor'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'replace_editor' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_send_preview_email_rendered_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_send_preview_email_rendered_data' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_send_preview_email_personalizer_context'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_send_preview_email_personalizer_context' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_preview_post_template_html'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_preview_post_template_html_data' }]), rt.new_int(100), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_editor_send_preview_email_before_wp_mail'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'send_preview_email_before_wp_mail' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_editor_send_preview_email_after_wp_mail'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'send_preview_email_after_wp_mail' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_send_preview_email_subject'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Integration', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_email_subject_for_send_preview_email' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: this.email_api_controller }, rt.ArrayItem{ key: none, val: 'register_routes' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.class() }, rt.ArrayItem{ key: none, val: 'run_sweep' }]), rt.new_int(20)])
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill.backfill_complete_action(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.class() }, rt.ArrayItem{ key: none, val: 'run_sweep' }]), rt.new_int(10)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) add_email_post_type(mut var_post_types Class_Automattic_WooCommerce_Internal_EmailEditor_array) rt.PhpVal {
	mut var_post_types_mutated := var_post_types
	var_post_types_mutated.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type() }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Emails'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [rt.new_string('Email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [rt.new_string('Add Email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [rt.new_string('Edit Email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'new_item', val: rt.call_function('__', [rt.new_string('New Email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [rt.new_string('View Email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [rt.new_string('Search Emails'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'rewrite', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type() }]) }, rt.ArrayItem{ key: 'supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: 'editor', val: rt.create_array([rt.ArrayItem{ key: 'default-mode', val: 'template-locked' }]) }, rt.ArrayItem{ key: none, val: 'excerpt' }]) }, rt.ArrayItem{ key: 'capability_type', val: Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type() }, rt.ArrayItem{ key: 'capabilities', val: rt.create_array([rt.ArrayItem{ key: 'edit_post', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'read_post', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'delete_post', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'edit_posts', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'edit_others_posts', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'delete_posts', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'publish_posts', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'read_private_posts', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'create_posts', val: 'manage_woocommerce' }]) }, rt.ArrayItem{ key: 'map_meta_cap', val: false }]) }]))
	return rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_array', []string{}, var_post_types_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) is_editor_page(is_editor_page bool) bool {
	if var_is_editor_page {
		return is_editor_page
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.get_superglobal('_GET').array_isset(rt.new_string('post')))) && rt.get_superglobal('_GET').array_isset(rt.new_string('action')))) && rt.is_true(rt.identical(rt.new_string('edit'), rt.get_superglobal('_GET').array_get('action'))))) {
		mut var_post := rt.call_function('get_post', [// unsupported expression: Expr_Cast_Int])
		return rt.is_true(var_post) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type(), rt.get_property(var_post, 'post_type')))
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) replace_editor(var_replace rt.PhpVal, var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type(), rt.get_property(var_post_mutated, 'post_type'))) && rt.is_true(var_current_screen))) {
		rt.call_method(this.editor_page_renderer, 'render', []rt.PhpVal{})
		return true
	}
	return (var_replace).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) delete_email_template_associated_with_email_editor_post(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	mut var_post_mutated := var_post
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_post_manager := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }()
	mut var_email_type := rt.call_method(var_post_manager, 'get_email_type_from_post_id', [var_post_id_mutated.dup(), rt.new_bool(true)])
	if !rt.is_true(var_email_type) {
		return rt.new_null()
	}
	rt.call_method(var_post_manager, 'delete_email_template', [var_email_type.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) extend_template_post_api()  {
	rt.call_function('register_rest_field', [rt.new_string('wp_template'), rt.new_string('woocommerce_data'), rt.create_array([rt.ArrayItem{ key: 'get_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.template_api_controller }, rt.ArrayItem{ key: none, val: 'get_template_data' }]) }, rt.ArrayItem{ key: 'update_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.template_api_controller }, rt.ArrayItem{ key: none, val: 'save_template_data' }]) }, rt.ArrayItem{ key: 'schema', val: rt.call_method(this.template_api_controller, 'get_template_data_schema', []rt.PhpVal{}) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) update_email_preview_data(var_data rt.PhpVal, email_type string, post_id i64) rt.PhpVal {
	mut email_type_mutated := email_type
	mut post_id_mutated := post_id
	mut var_type_param := Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.default_email_type()
	if !(post_id_mutated == 0) {
		var_type_param = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }(), 'get_email_type_class_name_from_post_id', [rt.new_int(post_id_mutated).dup()])
	} else if !(email_type_mutated == '') {
		var_type_param = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }(), 'get_email_type_class_name_from_email_id', [rt.new_string(email_type_mutated).dup()])
	}
	mut var_email_preview := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.class()])
	mut var_message := rt.call_method(var_email_preview, 'generate_placeholder_content', [var_type_param.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_EmailEditor_InvalidArgumentException') {
		mut var_e := var_e_1.dup()
		var_message = rt.call_method(var_email_preview, 'generate_placeholder_content', [Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.default_email_type()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_EmailEditor_Throwable') {
			mut var_e := var_e_2.dup()
			return var_data.dup()
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_EmailEditor_Throwable') {
		mut var_e := var_e_1.dup()
		return var_data.dup()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.call_function('str_replace', [Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder(), var_message.dup(), var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) update_send_preview_email_rendered_data(var_data rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_email_type := rt.new_string(rt.new_string(''))
	mut var_post_body := rt.call_function('file_get_contents', [rt.new_string('php://input')])
	if rt.is_true(var_post_body) {
		mut var_decoded_body := rt.call_function('json_decode', [var_post_body.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('json_last_error', []rt.PhpVal{}), rt.get_constant('JSON_ERROR_NONE'))) && !(rt.get_property(var_decoded_body, 'postId')).is_null())) {
			mut var_post_id := rt.call_function('absint', [rt.get_property(var_decoded_body, 'postId')])
			var_email_type = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }(), 'get_email_type_from_post_id', [var_post_id.dup()])
			if !(!rt.is_true(var_email_type)) {
				return this.update_email_preview_data(var_data.dup(), (var_email_type).str(), 0)
			}
		}
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_post_mutated)) && rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'WP_Post'))))) {
		var_email_type = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }(), 'get_email_type_from_post_id', [rt.get_property(var_post_mutated, 'ID')])
		if !(!rt.is_true(var_email_type)) {
			return this.update_email_preview_data(var_data.dup(), (var_email_type).str(), (rt.get_property(var_post_mutated, 'ID')).to_i64())
		}
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) update_send_preview_email_personalizer_context(var_context rt.PhpVal) rt.PhpVal {
	mut var_post_manager := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }()
	mut var_email_id := rt.call_method(var_post_manager, 'get_email_type_from_post_id', [rt.call_function('get_the_ID', []rt.PhpVal{})])
	mut var_email_type := if rt.is_true(var_email_id) { rt.call_method(var_post_manager, 'get_email_type_class_name_from_email_id', [var_email_id.dup()]) } else { Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.default_email_type() }
	mut var_email_preview := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.class()])
	rt.call_method(var_email_preview, 'set_email_type', [var_email_type.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Internal_EmailEditor_InvalidArgumentException') {
		mut var_e := var_e_3.dup()
		return var_context.dup()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	mut var_email := rt.call_method(, 'get_email', []rt.PhpVal{})
	rt.set_property(, 'recipient', )
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) update_preview_post_template_html_data(var_data rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) extend_post_api()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) send_preview_email_before_wp_mail()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) send_preview_email_after_wp_mail()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) update_email_subject_for_send_preview_email(var_subject rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Emails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_integration() &Class_Automattic_WooCommerce_Internal_EmailEditor_Integration {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Integration{
		PhpObjectBase: rt.PhpObjectBase{}
		editor_page_renderer: rt.new_null()
		dependency_check: rt.new_null()
		template_api_controller: rt.new_null()
		email_api_controller: rt.new_null()
		wc_email_instance: rt.new_null()
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

fn create_automattic_woocommerce_internal_emaileditor_logger() &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger{
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

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'init_logger' {
			this.init_logger()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'add_email_post_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_email_post_type(mut dispatch_arg_0)
		}
		'is_editor_page' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.is_editor_page(dispatch_arg_0))
		}
		'replace_editor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.replace_editor(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_email_template_associated_with_email_editor_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete_email_template_associated_with_email_editor_post(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'extend_template_post_api' {
			this.extend_template_post_api()
			return rt.new_null()
		}
		'update_email_preview_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.update_email_preview_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_send_preview_email_rendered_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_send_preview_email_rendered_data(dispatch_arg_0, dispatch_arg_1)
		}
		'update_send_preview_email_personalizer_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_send_preview_email_personalizer_context(dispatch_arg_0)
		}
		'update_preview_post_template_html_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_preview_post_template_html_data(dispatch_arg_0)
		}
		'extend_post_api' {
			this.extend_post_api()
			return rt.new_null()
		}
		'send_preview_email_before_wp_mail' {
			this.send_preview_email_before_wp_mail()
			return rt.new_null()
		}
		'send_preview_email_after_wp_mail' {
			this.send_preview_email_after_wp_mail()
			return rt.new_null()
		}
		'update_email_subject_for_send_preview_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_email_subject_for_send_preview_email(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'editor_page_renderer' { return this.editor_page_renderer }
		'dependency_check' { return this.dependency_check }
		'template_api_controller' { return this.template_api_controller }
		'email_api_controller' { return this.email_api_controller }
		'wc_email_instance' { return this.wc_email_instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Integration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'editor_page_renderer' { this.editor_page_renderer = val; return true }
		'dependency_check' { this.dependency_check = val; return true }
		'template_api_controller' { this.template_api_controller = val; return true }
		'email_api_controller' { this.email_api_controller = val; return true }
		'wc_email_instance' { this.wc_email_instance = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_integration_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
