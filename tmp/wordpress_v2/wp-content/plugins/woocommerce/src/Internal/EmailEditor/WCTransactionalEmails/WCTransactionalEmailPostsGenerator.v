import rt
import crypto.sha1

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	rt.PhpObjectBase
pub mut:
	template_manager  rt.PhpVal = rt.new_null()
	default_templates rt.PhpVal = rt.new_array()
	transient_name    rt.PhpVal = rt.new_string('wc_email_editor_initial_templates_generated')
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) construct() {
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}
	mut iife_result_0 := iife_temp_0.get_instance()
	this.template_manager = iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) initialize() bool {
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	if rt.is_true(rt.identical(iife_result_1, rt.call_function('get_transient', [
		this.transient_name,
	])))
	{
		return true
	}
	this.init_default_transactional_emails()
	this.generate_initial_email_templates()
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) init_default_transactional_emails() {
	if !(!rt.is_true(this.default_templates)) {
		return
	}
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{}
	mut iife_result_2 := iife_temp_2.get_transactional_emails()
	mut var_core_transactional_emails := iife_result_2
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails{}
	mut iife_result_3 := iife_temp_3.instance()
	mut var_wc_emails := iife_result_3
	mut var_email_types := rt.call_method(var_wc_emails, 'get_emails', []rt.PhpVal{})
	closure_5_fn := fn [var_core_transactional_emails] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	var_email_types = rt.call_function('array_filter', [var_email_types.clone(),
		rt.new_closure(closure_5_fn)])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_email := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_acc.array_set(rt.get_property(var_email, 'id'), var_email.clone())
		return
	}
	this.default_templates = rt.call_function('array_reduce', [
		var_email_types.clone(), rt.new_closure(closure_6_fn),
		rt.new_array()])
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.resolve_block_template_name(var_email rt.PhpVal) string {
	if !(!rt.is_true(rt.get_property(var_email, 'template_block'))) {
		return (rt.get_property(var_email, 'template_block')).str()
	}
	mut var_template_plain := rt.new_string((rt.get_property(var_email, 'template_plain')).str())
	if rt.is_true(rt.identical(rt.new_string(''), var_template_plain)) {
		return ''
	}
	return (rt.call_function('str_replace', [rt.new_string('plain'),
		rt.new_string('block'), var_template_plain.clone()])).str()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.resolve_block_template_path(var_email rt.PhpVal) string {
	mut var_template_name :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.resolve_block_template_name(var_email.clone())
	if rt.is_true(rt.identical(rt.new_string(''), var_template_name)) {
		return ''
	}
	return (rt.call_function('wc_locate_template', [var_template_name.clone(),
		rt.new_string(''), rt.new_string((rt.get_property(var_email, 'template_base')).str())])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) get_email_template(var_email rt.PhpVal) rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.render_block_template_html(var_email.clone())
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.render_block_template_html(var_email rt.PhpVal) string {
	mut var_template_name :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.resolve_block_template_name(var_email.clone())
	mut var_template_html := rt.call_function('wc_get_template_html', [
		var_template_name.clone(), rt.new_array(), rt.new_string(''),
		rt.new_string((rt.get_property(var_email, 'template_base')).str())])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception')
	{
		mut var_e := var_e_1.clone()
		if rt.is_true(rt.greater(rt.call_function('ob_get_level', []rt.PhpVal{}), rt.new_int(0))) {
			rt.call_function('ob_end_clean', []rt.PhpVal{})
		}
		var_template_html = rt.new_string('')
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_6 := iife_temp_6.contains(var_template_html.clone(),
		rt.new_string('No such file or directory'), rt.new_bool(false))
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_7 := iife_temp_7.contains(var_template_html.clone(),
		rt.new_string('Failed to open stream'), rt.new_bool(false))
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_8 := iife_temp_8.contains(var_template_html.clone(),
		rt.new_string('Warning: include'), rt.new_bool(false))
	mut var_has_template_error := rt.new_bool(rt.is_true(iife_result_6) || rt.is_true(iife_result_7)
		|| rt.is_true(iife_result_8))
	if rt.is_true(rt.call_function('is_wp_error', [var_template_html.clone()]))
		|| !rt.is_true(var_template_html) || rt.is_true(var_has_template_error) {
		mut var_default_template_name := rt.new_string('emails/block/default-block-content.php')
		var_template_html = rt.call_function('wc_get_template_html', [
			var_default_template_name.clone(), rt.new_array()])
	}
	mut var_filtered_template_html := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_block_template_html'),
		var_template_html.clone(),
		var_email.clone(),
	])
	return (if var_filtered_template_html.clone().is_string() {
		var_filtered_template_html
	} else {
		var_template_html
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) generate_initial_email_templates() bool {
	mut iife_temp_9 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{}
	mut iife_result_9 := iife_temp_9.get_transactional_emails()
	mut var_core_transactional_emails := iife_result_9
	mut var_templates_to_generate := rt.new_array()
	mut iter_1 := var_core_transactional_emails.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_email_type := item_1.val
		if !rt.is_true(rt.call_method(this.template_manager, 'get_email_template_post_id', [
			var_email_type.clone(),
		])) {
			var_templates_to_generate.array_push(var_email_type.clone())
		}
	}
	if !rt.is_true(var_templates_to_generate) {
		return false
	}
	mut var_result := rt.new_bool(this.generate_email_templates(var_templates_to_generate.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return false
	}
	mut iife_temp_10 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_10 := iife_temp_10.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('set_transient', [this.transient_name, iife_result_10,
		rt.get_constant('WEEK_IN_SECONDS')])
	rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) generate_email_template_if_not_exists(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_data := this.default_templates.array_get(var_email_type)
	if rt.is_true(rt.call_method(this.template_manager, 'get_email_template_post_id', [var_email_type.clone()]))
		|| !rt.is_true(var_email_data) {
		return rt.call_method(this.template_manager, 'get_email_template_post_id', [
			var_email_type.clone(),
		])
	}
	return this.generate_single_template(var_email_type.clone(), var_email_data.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) generate_email_templates(var_templates_to_generate rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_templates_to_generate_mutated := var_templates_to_generate
	closure_12_fn := fn [var_templates_to_generate] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (rt.call_function('in_array', [var_email_id.clone(),
			var_templates_to_generate_mutated.clone(), rt.new_bool(true)])).to_bool()
	}
	mut var_core_emails := rt.call_function('array_filter', [this.default_templates,
		rt.new_closure(closure_12_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	if !rt.is_true(var_core_emails) {
		return false
	}
	rt.call_method(var_wpdb, 'query', [rt.new_string('START TRANSACTION')])
	mut iter_2 := var_core_emails.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_email_data := item_2.val
		mut var_email_type := item_2.key
		this.generate_single_template(var_email_type.clone(), var_email_data.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(var_wpdb, 'query', [rt.new_string('COMMIT')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return true
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception')
	{
		mut var_e := var_e_2.clone()
		rt.call_method(var_wpdb, 'query', [rt.new_string('ROLLBACK')])
		return (create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wp_error(rt.new_string('email_generation_failed'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return false
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.build_filtered_post_data(email_type string, var_email rt.PhpVal) rt.PhpVal {
	mut var_post_data := rt.create_array([
		rt.ArrayItem{
			key: 'post_type'
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
		rt.ArrayItem{ key: 'post_status', val: 'publish' },
		rt.ArrayItem{ key: 'post_name', val: email_type },
		rt.ArrayItem{ key: 'post_title', val: rt.call_method(var_email, 'get_title', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'post_excerpt', val: rt.call_method(var_email, 'get_description',
			[]rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'post_content'
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.render_block_template_html(var_email.clone())
		},
		rt.ArrayItem{ key: 'meta_input', val: rt.create_array([
			rt.ArrayItem{ key: '_wp_page_template', val: rt.call_method(create_automattic_woocommerce_internal_emaileditor_emailtemplates_wooemailtemplate(),
				'get_slug', []rt.PhpVal{}) },
		]) },
	])
	mut var_filtered_post_data := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_content_post_data'),
		var_post_data.clone(),
		rt.new_string(email_type),
		var_email.clone(),
	])
	return if var_filtered_post_data.clone().is_array() {
		var_filtered_post_data
	} else {
		var_post_data
	}
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.compute_canonical_post_content(var_email rt.PhpVal) string {
	mut var_post_data := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.build_filtered_post_data((rt.get_property(var_email, 'id')).str(),
		var_email.clone())
	return (if !(var_post_data.array_get(rt.new_string('post_content'))).is_null() {
		var_post_data.array_get(rt.new_string('post_content'))
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) generate_single_template(var_email_type rt.PhpVal, var_email_data rt.PhpVal) rt.PhpVal {
	mut var_email_data_mutated := var_email_data
	mut var_post_data := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.build_filtered_post_data(var_email_type.str(),
		var_email_data_mutated.clone())
	mut iife_temp_12 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{}
	mut iife_result_12 :=
		iife_temp_12.get_email_sync_config(rt.new_string((rt.get_property(var_email_data_mutated, 'id')).str()))
	mut var_sync_config := iife_result_12
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_sync_config)))) {
		if !(var_post_data.array_isset(rt.new_string('meta_input')))
			|| !(var_post_data.array_get(rt.new_string('meta_input')).is_array()) {
			var_post_data.array_set('meta_input', rt.new_array())
		}
		var_post_data.array_get_mut('meta_input').array_set(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.version_meta_key(),
			(var_sync_config.array_get(rt.new_string('version'))).str())
		var_post_data.array_get_mut('meta_input').array_set(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.source_hash_meta_key(), sha1.hexhash((if !(var_post_data.array_get(rt.new_string('post_content'))).is_null() {
			var_post_data.array_get(rt.new_string('post_content'))
		} else {
			rt.new_string('')
		}).str()))
		var_post_data.array_get_mut('meta_input').array_set(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.last_synced_at_meta_key(), rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
		]))
		var_post_data.array_get_mut('meta_input').array_set(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.last_core_render_meta_key(), (if !(var_post_data.array_get(rt.new_string('post_content'))).is_null() {
			var_post_data.array_get(rt.new_string('post_content'))
		} else {
			rt.new_string('')
		}).str())
	}
	mut var_post_id := rt.call_function('wp_insert_post', [var_post_data.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception',
			[]string{}, create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_exception(rt.call_function('esc_html', [
			rt.call_method(var_post_id, 'get_error_message', []rt.PhpVal{}),
		]))))
	}
	rt.call_method(this.template_manager, 'save_email_template_post_id', [
		var_email_type.clone(), var_post_id.clone()])
	return var_post_id.clone()
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{
		PhpObjectBase:     rt.PhpObjectBase{}
		template_manager:  rt.new_null()
		default_templates: rt.new_array()
		transient_name:    rt.new_string('wc_email_editor_initial_templates_generated')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemails(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wc_emails(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_emailtemplates_wooemailtemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'initialize' {
			return rt.new_bool(this.initialize())
		}
		'init_default_transactional_emails' {
			this.init_default_transactional_emails()
			return rt.new_null()
		}
		'resolve_block_template_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.resolve_block_template_name(dispatch_arg_0))
		}
		'resolve_block_template_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.resolve_block_template_path(dispatch_arg_0))
		}
		'get_email_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_template(dispatch_arg_0)
		}
		'render_block_template_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.render_block_template_html(dispatch_arg_0))
		}
		'generate_initial_email_templates' {
			return rt.new_bool(this.generate_initial_email_templates())
		}
		'generate_email_template_if_not_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_email_template_if_not_exists(dispatch_arg_0)
		}
		'generate_email_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.generate_email_templates(dispatch_arg_0))
		}
		'build_filtered_post_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.build_filtered_post_data(dispatch_arg_0,
				dispatch_arg_1)
		}
		'compute_canonical_post_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator.compute_canonical_post_content(dispatch_arg_0))
		}
		'generate_single_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_single_template(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_manager' { return this.template_manager }
		'default_templates' { return this.default_templates }
		'transient_name' { return this.transient_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'template_manager' {
			this.template_manager = val
			return true
		}
		'default_templates' {
			this.default_templates = val
			return true
		}
		'transient_name' {
			this.transient_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
