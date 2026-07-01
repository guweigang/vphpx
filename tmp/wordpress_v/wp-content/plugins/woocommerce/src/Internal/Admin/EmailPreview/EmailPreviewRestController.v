import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController.nonce_key() string {
	return 'email-preview-nonce'
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController {
	rt.PhpObjectBase
pub mut:
	email_preview   rt.PhpVal = rt.new_null()
	route_namespace rt.PhpVal = rt.new_string('wc-admin-email')
	rest_base       rt.PhpVal = rt.new_string('settings/email')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) get_rest_api_namespace() string {
	return 'wc-admin-email'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) construct() {
	this.email_preview = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.class(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) register_routes() {
	mut var_request := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return this.send_email_preview(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
		}
		mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		'/' + (this.rest_base).str() + '/send-preview',
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_send_preview() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_with_message() },
			]) },
		])])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return rt.create_array([
				rt.ArrayItem{ key: 'subject', val: rt.call_method(this.email_preview,
					'get_subject', []rt.PhpVal{}) },
			])
		}
		mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		'/' + (this.rest_base).str() + '/preview-subject',
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_4_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_preview_subject() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_for_preview_subject() },
			]) },
		])])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return this.save_transient(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
		}
		mut var_request := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		'/' + (this.rest_base).str() + '/save-transient',
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_5_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_6_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_save_transient() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_with_message() },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) get_args_for_send_preview() rt.PhpVal {
	mut var_key := rt.new_null()
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return this.validate_email_type(var_key.str())
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The email type to preview.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_7_fn) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		]) },
		rt.ArrayItem{ key: 'email', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Email address to send the email preview to.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'email' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_email' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) get_args_for_preview_subject() rt.PhpVal {
	mut var_key := rt.new_null()
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return this.validate_email_type(var_key.str())
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The email type to get subject for.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_8_fn) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) get_args_for_save_transient() rt.PhpVal {
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_key.dup(),
				fn () rt.PhpVal {
					mut temp :=
						Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{}
					return temp.get_all_email_setting_ids()
				}(),
				rt.new_bool(true),
			])))))
			{
				return create_wp_error(rt.new_string('woocommerce_rest_not_allowed_key'), rt.call_function('sprintf', [
					rt.new_string('The provided key "%s" is not allowed.'),
					var_key.dup(),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			}
			return rt.new_bool(true)
		}
		mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		mut var_key := rt.call_method(var_request, 'get_param', [
			rt.new_string('key')])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('woocommerce_email_footer_text'), var_key))
			|| rt.is_true(rt.call_function('preg_match', [rt.new_string('/_additional_content$/'), var_key.dup()]))))
		{
			return rt.call_function('wp_kses_post', [
				rt.new_string(var_value.dup().to_string().trim_space()),
			])
		}
		return rt.call_function('sanitize_text_field', [var_value.dup()])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'key', val: rt.create_array([
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'description'
				val: 'The key for the transient. Must be one of the allowed options.'
			},
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_9_fn) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		]) },
		rt.ArrayItem{ key: 'value', val: rt.create_array([
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'description', val: 'The value to be saved for the transient.' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
			rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_10_fn) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) get_schema_with_message() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'email-preview-with-message' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'message', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('A message indicating that the action completed successfully.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) get_schema_for_preview_subject() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'email-preview-subject' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'subject', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('A subject for provided email type after filters are applied and placeholders replaced.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) validate_email_type(email_type string) bool {
	rt.call_method(this.email_preview, 'set_email_type', [rt.new_string(email_type)])
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
		'Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException')
	{
		mut var_e := var_e_1.dup()
		return (create_wp_error(rt.new_string('woocommerce_rest_invalid_email_type'), rt.call_function('__', [
			rt.new_string('Invalid email type.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
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
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) check_permissions(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_nonce := var_request.get_param(rt.new_string('nonce'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
		var_nonce.dup(),
		Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController.nonce_key()])))))
	{
		return create_wp_error(rt.new_string('invalid_nonce'), rt.call_function('__', [
			rt.new_string('Invalid nonce.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))
	}
	return this.check_permission(rt.new_object('WP_REST_Request', []string{}, var_request),
		rt.new_string('manage_woocommerce'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) send_email_preview(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_email_address := var_request.get_param(rt.new_string('email'))
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_email_content := rt.call_method(this.email_preview, 'render', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Admin_EmailPreview_Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		return create_wp_error(rt.new_string('woocommerce_rest_email_preview_not_rendered'), rt.call_function('__', [
			rt.new_string('There was an error rendering an email preview.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
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
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	mut var_email_subject := rt.call_method(this.email_preview, 'get_subject', []rt.PhpVal{})
	mut var_email := create_automattic_woocommerce_internal_admin_emailpreview_wc_emails()
	mut var_sent := var_email.send(var_email_address.dup(), var_email_subject.dup(),
		var_email_content.dup())
	if rt.is_true(var_sent) {
		return rt.create_array([
			rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Test email sent to %s.'),
					rt.new_string('woocommerce')]),
				var_email_address.dup(),
			]) },
		])
	}
	return create_wp_error(rt.new_string('woocommerce_rest_email_preview_not_sent'), rt.call_function('__', [
		rt.new_string('Error sending test email. Please try again.'),
		rt.new_string('woocommerce'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) save_transient(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_key := var_request.get_param(rt.new_string('key'))
	mut var_value := var_request.get_param(rt.new_string('value'))
	mut var_is_set := rt.call_function('set_transient', [var_key.dup(),
		var_value.dup(), rt.get_constant('HOUR_IN_SECONDS')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_set)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_transient_not_set'), rt.call_function('__', [
			rt.new_string('Error saving transient. Please try again.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Transient saved for key %s.'),
				rt.new_string('woocommerce')]),
			var_key.dup(),
		]) },
	])
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WC_Emails {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_emailpreview_emailpreviewrestcontroller() &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController{
		PhpObjectBase:   rt.PhpObjectBase{}
		email_preview:   rt.new_null()
		route_namespace: rt.new_string('wc-admin-email')
		rest_base:       rt.new_string('settings/email')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase() &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailpreview_emailpreview() &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailpreview_wc_emails() &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_args_for_send_preview' {
			return this.get_args_for_send_preview()
		}
		'get_args_for_preview_subject' {
			return this.get_args_for_preview_subject()
		}
		'get_args_for_save_transient' {
			return this.get_args_for_save_transient()
		}
		'get_schema_with_message' {
			return this.get_schema_with_message()
		}
		'get_schema_for_preview_subject' {
			return this.get_schema_for_preview_subject()
		}
		'validate_email_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.validate_email_type(dispatch_arg_0))
		}
		'check_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.check_permissions(mut dispatch_arg_0)
		}
		'send_email_preview' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.send_email_preview(mut dispatch_arg_0)
		}
		'save_transient' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.save_transient(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'email_preview' { return this.email_preview }
		'route_namespace' { return this.route_namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreviewRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'email_preview' {
			this.email_preview = val
			return true
		}
		'route_namespace' {
			this.route_namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_admin_emailpreview_emailpreviewrestcontroller_php() {
	// unsupported statement: Stmt_Declare
}
