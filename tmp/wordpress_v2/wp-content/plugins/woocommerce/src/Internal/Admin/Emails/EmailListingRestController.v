import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController.nonce_key() string {
	return 'email-listing-nonce'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController {
	rt.PhpObjectBase
pub mut:
	route_namespace          rt.PhpVal = rt.new_string('wc-admin-email')
	rest_base                rt.PhpVal = rt.new_string('settings/email/listing')
	email_template_generator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) get_rest_api_namespace() string {
	return 'wc-admin-email-listing'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) construct() {
	this.email_template_generator =
		create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) initialize_template_generator() {
	rt.call_method(this.email_template_generator, 'init_default_transactional_emails',
		[]rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) register_routes() {
	mut var_request := rt.new_null()
	this.initialize_template_generator()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.recreate_email_post(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.check_permissions(mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	}
	rt.call_function('register_rest_route', [this.route_namespace,
		rt.new_string('/' + (this.rest_base).str() + '/recreate-email-post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Internal_Admin_Emails_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
				rt.ArrayItem{ key: 'args', val: this.get_args_for_recreate_email_post() },
				rt.ArrayItem{ key: 'schema', val: this.get_schema_with_message() },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) get_args_for_recreate_email_post() rt.PhpVal {
	mut var_email_id := rt.new_null()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_email_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.validate_email_id(var_email_id.str())
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'email_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The email ID to recreate the post for.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_3_fn) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) get_schema_with_message() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'email-listing-with-message' },
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
			rt.ArrayItem{ key: 'post_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The post ID of the generated email post.'),
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) validate_email_id(email_id string) bool {
	mut email_id_mutated := email_id
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{}
	mut iife_result_3 := iife_temp_3.get_transactional_emails()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(email_id_mutated).clone(), iife_result_3, rt.new_bool(true)])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_not_allowed_email_id'), rt.call_function('sprintf', [
			rt.new_string('The provided email ID "%s" is not allowed.'),
			rt.new_string(email_id_mutated).clone(),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) check_permissions(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_nonce := var_request.get_param(rt.new_string('nonce'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
		var_nonce.clone(),
		Class_Automattic_WooCommerce_Internal_Admin_Emails_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController.nonce_key(),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_nonce'), rt.call_function('__', [
			rt.new_string('Invalid nonce.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }])))
	}
	return this.check_permission(rt.new_object('WP_REST_Request', []string{}, var_request),
		rt.new_string('manage_woocommerce'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) recreate_email_post(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_email_id := var_request.get_param(rt.new_string('email_id'))
	mut var_generated_post_id := rt.new_string('')
	var_generated_post_id = rt.call_method(this.email_template_generator,
		'generate_email_template_if_not_exists', [var_email_id.clone()])
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
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Emails_Exception') {
		mut var_e := var_e_1.clone()
		return create_wp_error(rt.new_string('woocommerce_rest_email_post_generation_failed'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Error generating email post. Error: %s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
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
	if rt.is_true(var_generated_post_id) {
		return rt.create_array([
			rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Email post generated for %s.'),
					rt.new_string('woocommerce')]),
				var_email_id.clone(),
			]) },
			rt.ArrayItem{ key: 'post_id', val: var_generated_post_id.str() },
		])
	}
	return create_wp_error(rt.new_string('woocommerce_rest_email_post_generation_error'), rt.call_function('__', [
		rt.new_string('Error unable to generate email post.'),
		rt.new_string('woocommerce'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_emails_emaillistingrestcontroller() &Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController{
		PhpObjectBase:            rt.PhpObjectBase{}
		route_namespace:          rt.new_string('wc-admin-email')
		rest_base:                rt.new_string('settings/email/listing')
		email_template_generator: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
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

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemails(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'initialize_template_generator' {
			this.initialize_template_generator()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_args_for_recreate_email_post' {
			return this.get_args_for_recreate_email_post()
		}
		'get_schema_with_message' {
			return this.get_schema_with_message()
		}
		'validate_email_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.validate_email_id(dispatch_arg_0))
		}
		'check_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.check_permissions(mut dispatch_arg_0)
		}
		'recreate_email_post' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.recreate_email_post(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'route_namespace' { return this.route_namespace }
		'rest_base' { return this.rest_base }
		'email_template_generator' { return this.email_template_generator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Emails_EmailListingRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'route_namespace' {
			this.route_namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'email_template_generator' {
			this.email_template_generator = val
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

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
