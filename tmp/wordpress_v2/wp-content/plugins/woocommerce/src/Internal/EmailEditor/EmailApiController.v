import rt
import crypto.sha1

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController {
	rt.PhpObjectBase
pub mut:
		post_manager rt.PhpVal = rt.new_null()
		posts_generator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) init() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}
	mut iife_result_0 := iife_temp_0.get_instance()
	this.post_manager = iife_result_0
	this.posts_generator = create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) get_email_data(var_post_data rt.PhpVal) rt.PhpVal {
	mut var_email_type := rt.call_method(this.post_manager, 'get_email_type_from_post_id', [var_post_data.array_get(rt.new_string('id'))])
	mut var_email := this.get_email_by_type(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_?string](if !(var_email_type).is_null() { var_email_type } else { rt.new_string('') }))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email)))) {
		return rt.create_array([rt.ArrayItem{ key: 'subject', val: rt.new_null() }, rt.ArrayItem{ key: 'subject_full', val: rt.new_null() }, rt.ArrayItem{ key: 'subject_partial', val: rt.new_null() }, rt.ArrayItem{ key: 'preheader', val: rt.new_null() }, rt.ArrayItem{ key: 'default_subject', val: rt.new_null() }, rt.ArrayItem{ key: 'email_type', val: rt.new_null() }, rt.ArrayItem{ key: 'recipient', val: rt.new_null() }, rt.ArrayItem{ key: 'cc', val: rt.new_null() }, rt.ArrayItem{ key: 'bcc', val: rt.new_null() }])
	}
	mut var_form_fields := rt.call_method(var_email, 'get_form_fields', []rt.PhpVal{})
	mut var_enabled := rt.call_method(var_email, 'get_option', [rt.new_string('enabled')])
	return rt.create_array([rt.ArrayItem{ key: 'enabled', val: if var_enabled.clone().is_null() { rt.call_method(var_email, 'is_enabled', []rt.PhpVal{}) } else { rt.identical(rt.new_string('yes'), var_enabled) } }, rt.ArrayItem{ key: 'is_manual', val: rt.call_method(var_email, 'is_manual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subject', val: rt.call_method(var_email, 'get_option', [rt.new_string('subject')]) }, rt.ArrayItem{ key: 'subject_full', val: rt.call_method(var_email, 'get_option', [rt.new_string('subject_full')]) }, rt.ArrayItem{ key: 'subject_partial', val: rt.call_method(var_email, 'get_option', [rt.new_string('subject_partial')]) }, rt.ArrayItem{ key: 'preheader', val: rt.call_method(var_email, 'get_option', [rt.new_string('preheader')]) }, rt.ArrayItem{ key: 'default_subject', val: rt.call_method(var_email, 'get_default_subject', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'email_type', val: var_email_type }, rt.ArrayItem{ key: 'recipient', val: if rt.is_true(rt.new_bool(var_form_fields.clone().array_isset(rt.new_string('recipient')))) { rt.call_method(var_email, 'get_option', [rt.new_string('recipient'), rt.call_function('get_option', [rt.new_string('admin_email')])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'cc', val: rt.call_method(var_email, 'get_option', [rt.new_string('cc')]) }, rt.ArrayItem{ key: 'bcc', val: rt.call_method(var_email, 'get_option', [rt.new_string('bcc')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) save_email_data(mut var_data Class_Automattic_WooCommerce_Internal_EmailEditor_array, mut var_post Class_Automattic_WooCommerce_Internal_EmailEditor_WP_Post) rt.PhpVal {
	mut var_error := this.validate_email_data(mut var_data)
	if rt.is_true(rt.call_function('is_wp_error', [var_error.clone()])) {
		return create_wp_error(rt.new_string('invalid_email_data'), rt.call_function('implode', [rt.new_string(' '), rt.call_method(var_error, 'get_error_messages', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('subject'))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('preheader'))))))) {
		return rt.new_null()
	}
	mut var_email_type := rt.call_method(this.post_manager, 'get_email_type_from_post_id', [rt.get_property(var_post, 'ID')])
	mut var_email := this.get_email_by_type(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_?string](if !(var_email_type).is_null() { var_email_type } else { rt.new_string('') }))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('customer_refunded_order'), var_email_type)) {
		if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('subject_full')))) {
			rt.call_method(var_email, 'update_option', [rt.new_string('subject_full'), var_data.array_get(rt.new_string('subject_full'))])
		}
		if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('subject_partial')))) {
			rt.call_method(var_email, 'update_option', [rt.new_string('subject_partial'), var_data.array_get(rt.new_string('subject_partial'))])
		}
	} else if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('subject')))) {
		rt.call_method(var_email, 'update_option', [rt.new_string('subject'), var_data.array_get(rt.new_string('subject'))])
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('preheader')))) {
		rt.call_method(var_email, 'update_option', [rt.new_string('preheader'), var_data.array_get(rt.new_string('preheader'))])
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('enabled')))) {
		rt.call_method(var_email, 'update_option', [rt.new_string('enabled'), rt.new_string((if rt.is_true(var_data.array_get(rt.new_string('enabled'))) { 'yes' } else { 'no' }).str())])
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('recipient')))) {
		rt.call_method(var_email, 'update_option', [rt.new_string('recipient'), var_data.array_get(rt.new_string('recipient'))])
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('cc')))) {
		rt.call_method(var_email, 'update_option', [rt.new_string('cc'), var_data.array_get(rt.new_string('cc'))])
	}
	if rt.is_true(rt.new_bool(var_data.array_isset(rt.new_string('bcc')))) {
		rt.call_method(var_email, 'update_option', [rt.new_string('bcc'), var_data.array_get(rt.new_string('bcc'))])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) validate_email_data(mut var_data Class_Automattic_WooCommerce_Internal_EmailEditor_array) rt.PhpVal {
	mut var_error := create_wp_error()
	mut var_invalid_recipients := this.filter_invalid_email_addresses(if !(var_data.array_get(rt.new_string('recipient'))).is_null() { var_data.array_get(rt.new_string('recipient')) } else { rt.new_string('') })
	if !(!rt.is_true(var_invalid_recipients)) {
		mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('One or more Recipient email addresses are invalid: “%s”. Please enter valid email addresses separated by commas.'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(','), var_invalid_recipients.clone()])])
		rt.call_method(var_error, 'add', [rt.new_string('invalid_recipient_email_address'), var_error_message.clone()])
	}
	mut var_invalid_cc := this.filter_invalid_email_addresses(if !(var_data.array_get(rt.new_string('cc'))).is_null() { var_data.array_get(rt.new_string('cc')) } else { rt.new_string('') })
	if !(!rt.is_true(var_invalid_cc)) {
		var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('One or more CC email addresses are invalid: “%s”. Please enter valid email addresses separated by commas.'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(','), var_invalid_cc.clone()])])
		rt.call_method(var_error, 'add', [rt.new_string('invalid_cc_email_address'), var_error_message.clone()])
	}
	mut var_invalid_bcc := this.filter_invalid_email_addresses(if !(var_data.array_get(rt.new_string('bcc'))).is_null() { var_data.array_get(rt.new_string('bcc')) } else { rt.new_string('') })
	if !(!rt.is_true(var_invalid_bcc)) {
		var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('One or more BCC email addresses are invalid: “%s”. Please enter valid email addresses separated by commas.'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(','), var_invalid_bcc.clone()])])
		rt.call_method(var_error, 'add', [rt.new_string('invalid_bcc_email_address'), var_error_message.clone()])
	}
	if rt.is_true(rt.call_method(var_error, 'has_errors', []rt.PhpVal{})) {
		return var_error.clone()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) filter_invalid_email_addresses(var_comma_separated_email_addresses rt.PhpVal) rt.PhpVal {
	mut var_invalid_email_addresses := rt.new_array()
	if var_comma_separated_email_addresses.clone().to_string().trim_space() == '' {
		return var_invalid_email_addresses.clone()
	}
	mut iter_1 := rt.call_function('explode', [rt.new_string(','), var_comma_separated_email_addresses.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_email_address := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [rt.new_string(var_email_address.clone().to_string().trim_space()), rt.get_constant('FILTER_VALIDATE_EMAIL')]))))) {
			var_invalid_email_addresses.array_push(var_email_address.clone().to_string().trim_space())
		}
	}
	return var_invalid_email_addresses.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) get_email_data_schema() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_1 := iife_temp_1.string()
	mut iife_temp_2 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_2 := iife_temp_2.string()
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_3 := iife_temp_3.string()
	mut iife_temp_4 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_4 := iife_temp_4.string()
	mut iife_temp_5 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_5 := iife_temp_5.string()
	mut iife_temp_6 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_6 := iife_temp_6.string()
	mut iife_temp_7 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_7 := iife_temp_7.string()
	mut iife_temp_8 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_8 := iife_temp_8.string()
	mut iife_temp_9 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_9 := iife_temp_9.string()
	mut iife_temp_10 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_10 := iife_temp_10.object(rt.create_array([rt.ArrayItem{ key: 'subject', val: rt.call_method(iife_result_1, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subject_full', val: rt.call_method(iife_result_2, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subject_partial', val: rt.call_method(iife_result_3, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'preheader', val: rt.call_method(iife_result_4, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'default_subject', val: rt.call_method(iife_result_5, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'email_type', val: rt.call_method(iife_result_6, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'recipient', val: rt.call_method(iife_result_7, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'cc', val: rt.call_method(iife_result_8, 'nullable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'bcc', val: rt.call_method(iife_result_9, 'nullable', []rt.PhpVal{}) }]))
	return rt.call_method(iife_result_10, 'to_array', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) get_emails() rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) get_email_by_type(mut var_id Class_Automattic_WooCommerce_Internal_EmailEditor_?string) rt.PhpVal {
	mut iter_2 := this.get_emails().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_email := item_2.val
		if rt.is_true(rt.identical(rt.get_property(var_email, 'id'), var_id)) {
			return var_email.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) register_routes() {
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
		}
	rt.call_function('register_rest_route', [rt.new_string('woocommerce-email-editor/v1'), rt.new_string('/emails/(?P<id>\\d+)/default-content'), rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_EmailEditor_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_EmailApiController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_default_content_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_12_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID of the woo_email post.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_EmailApiController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_default_content_schema' }]) }])])
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
		}
	rt.call_function('register_rest_route', [rt.new_string('woocommerce-email-editor/v1'), rt.new_string('/emails/(?P<id>\\d+)/reset'), rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Internal_EmailEditor_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_EmailApiController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'reset_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_13_fn) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID of the woo_email post.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_EmailApiController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_reset_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) get_default_content_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'woo_email_default_content' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'content', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The default block content for the email.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) get_default_content_response(mut var_request Class_WP_REST_Request) rt.PhpVal {
	if !(rt.is_true(this.post_manager) && rt.is_true(this.posts_generator)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_email_editor_not_initialized'), rt.call_function('__', [rt.new_string('Email editor is not initialized.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_post_id := rt.new_int((var_request.get_param(rt.new_string('id'))).to_i64())
	mut var_email_type := rt.call_method(this.post_manager, 'get_email_type_from_post_id', [var_post_id.clone()])
	mut var_email := this.get_email_by_type(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_?string](if !(var_email_type).is_null() { var_email_type } else { rt.new_string('') }))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_email_not_found'), rt.call_function('__', [rt.new_string('No email found for the given post ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'content', val: rt.call_method(this.posts_generator, 'get_email_template', [var_email.clone()]) }]), rt.new_int(200)))
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) get_reset_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'woo_email_reset' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'content', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The canonical block content written to the post.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'version', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The core block template @version stamped on the post, or null when the email is not sync-enabled.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'source_hash', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('sha1 of the canonical block content stamped on the post, or null when the email is not sync-enabled.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'synced_at', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('UTC timestamp when the post was stamped (Y-m-d H:i:s), or null when the email is not sync-enabled.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The post-reset sync status (in_sync on success for sync-enabled emails, null otherwise).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) reset_response(mut var_request Class_WP_REST_Request) rt.PhpVal {
	if !(rt.is_true(this.post_manager) && rt.is_true(this.posts_generator)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_email_editor_not_initialized'), rt.call_function('__', [rt.new_string('Email editor is not initialized.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_post_id := rt.new_int((var_request.get_param(rt.new_string('id'))).to_i64())
	mut var_email_type := rt.call_method(this.post_manager, 'get_email_type_from_post_id', [var_post_id.clone()])
	mut var_email := this.get_email_by_type(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_?string](if !(var_email_type).is_null() { var_email_type } else { rt.new_string('') }))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_email_not_found'), rt.call_function('__', [rt.new_string('No email found for the given post ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{}
	mut iife_result_13 := iife_temp_13.compute_canonical_post_content(var_email.clone())
	mut var_canonical := iife_result_13
	mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{}
	mut iife_result_14 := iife_temp_14.get_email_sync_config(rt.new_string((var_email_type).str()))
	mut var_sync_config := iife_result_14
	mut var_update_result := rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_post_id }, rt.ArrayItem{ key: 'post_content', val: var_canonical }]), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_update_result.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_email_reset_failed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Failed to reset email content: %s'), rt.new_string('woocommerce')]), rt.call_method(var_update_result, 'get_error_message', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_source_hash := rt.new_null()
	mut var_synced_at := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_sync_config)))) {
		var_source_hash = rt.new_string(sha1.hexhash(var_canonical.clone().to_string()))
		var_synced_at = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])
		rt.call_function('update_post_meta', [var_post_id.clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.version_meta_key(), rt.new_string((var_sync_config.array_get(rt.new_string('version'))).str())])
		rt.call_function('update_post_meta', [var_post_id.clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.source_hash_meta_key(), var_source_hash.clone()])
		rt.call_function('update_post_meta', [var_post_id.clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.last_synced_at_meta_key(), var_synced_at.clone()])
		rt.call_function('update_post_meta', [var_post_id.clone(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_meta_key(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_in_sync()])
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'content', val: var_canonical }, rt.ArrayItem{ key: 'version', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_sync_config)))) { (var_sync_config.array_get(rt.new_string('version'))).str() } else { rt.new_null() } }, rt.ArrayItem{ key: 'source_hash', val: var_source_hash }, rt.ArrayItem{ key: 'synced_at', val: var_synced_at }, rt.ArrayItem{ key: 'status', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_sync_config)))) { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_in_sync() } else { rt.new_null() } }]), rt.new_int(200)))
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_emailapicontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController{
		PhpObjectBase: rt.PhpObjectBase{}
		post_manager: rt.new_null()
		posts_generator: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_builder(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_email_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_data(dispatch_arg_0)
		}
		'save_email_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WP_Post](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.save_email_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'validate_email_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.validate_email_data(mut dispatch_arg_0)
		}
		'filter_invalid_email_addresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_invalid_email_addresses(dispatch_arg_0)
		}
		'get_email_data_schema' {
			return this.get_email_data_schema()
		}
		'get_emails' {
			return this.get_emails()
		}
		'get_email_by_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_email_by_type(mut dispatch_arg_0)
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_default_content_schema' {
			return this.get_default_content_schema()
		}
		'get_default_content_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_default_content_response(mut dispatch_arg_0)
		}
		'get_reset_schema' {
			return this.get_reset_schema()
		}
		'reset_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.reset_response(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_manager' { return this.post_manager }
		'posts_generator' { return this.posts_generator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailApiController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_manager' { this.post_manager = val; return true }
		'posts_generator' { this.posts_generator = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
