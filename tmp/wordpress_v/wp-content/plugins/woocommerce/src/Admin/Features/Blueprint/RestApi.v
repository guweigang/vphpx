import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi.max_file_size() i64 {
	return 52428800
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi {
	rt.PhpObjectBase
pub mut:
	namespace          rt.PhpVal = rt.new_string('wc-admin')
	coming_soon_helper rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) construct() {
	this.coming_soon_helper = create_automattic_woocommerce_internal_comingsoon_comingsoonhelper()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) get_max_file_size() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_blueprint_upload_max_file_size'),
		Class_Automattic_WooCommerce_Admin_Features_Blueprint_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi.max_file_size(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/blueprint/export'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'export' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'check_export_permission' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'steps', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('A list of plugins to install'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'settings', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'array' },
								rt.ArrayItem{ key: 'items', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
								]) },
							]) },
							rt.ArrayItem{ key: 'plugins', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'array' },
								rt.ArrayItem{ key: 'items', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
								]) },
							]) },
							rt.ArrayItem{ key: 'themes', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'array' },
								rt.ArrayItem{ key: 'items', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
								]) },
							]) },
						]) },
						rt.ArrayItem{ key: 'default', val: rt.new_array() },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/blueprint/import-step'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Server.creatable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'import_step' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'check_import_permission' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'step_definition', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The step definition to import'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'get_import_step_response_schema' },
			]) },
		])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])
	}
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/blueprint/import-allowed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'get_import_allowed' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_1_fn) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_RestApi',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'get_import_allowed_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) check_export_permission() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot export WooCommerce Blueprints.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) check_import_permission() bool {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')])))))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot import WooCommerce Blueprints.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) export(var_request rt.PhpVal) rt.PhpVal {
	mut var_payload := rt.call_method(var_request, 'get_param', [
		rt.new_string('steps')])
	mut var_steps := this.steps_payload_to_blueprint_steps(var_payload.dup())
	mut var_exporter := create_automattic_woocommerce_blueprint_exportschema()
	if var_payload.array_isset(rt.new_string('plugins')) {
		closure_3_fn := fn [var_payload] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_exporter := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			closure_3_fn := fn [var_payload] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_plugins := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				return rt.call_function('array_intersect_key', [
					var_plugins.dup(),
					rt.call_function('array_flip', [
						var_payload.array_get('plugins'),
					])])
			}
			var_exporter.filter(rt.new_closure(closure_3_fn))
			return rt.new_null()
		}
		var_exporter.on_before_export(rt.new_string('installPlugin'), rt.new_closure(closure_3_fn))
	}
	if var_payload.array_isset(rt.new_string('themes')) {
		closure_5_fn := fn [var_payload] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_exporter := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			closure_5_fn := fn [var_payload] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_plugins := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				return rt.call_function('array_intersect_key', [
					var_plugins.dup(), rt.call_function('array_flip', [
						var_payload.array_get('themes'),
					])])
			}
			var_exporter.filter(rt.new_closure(closure_5_fn))
			return rt.new_null()
		}
		var_exporter.on_before_export(rt.new_string('installTheme'), rt.new_closure(closure_5_fn))
	}
	mut var_data := var_exporter.export(var_steps.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
		return create_automattic_woocommerce_admin_features_blueprint_wp_rest_response(var_data.dup(),
			rt.new_int(400))
	}
	return create_automattic_woocommerce_admin_features_blueprint_wp_http_response(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_data },
		rt.ArrayItem{ key: 'type', val: 'json' },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) steps_payload_to_blueprint_steps(var_steps rt.PhpVal) rt.PhpVal {
	mut var_steps_mutated := var_steps
	mut var_blueprint_steps := rt.new_array()
	if var_steps_mutated.array_isset(rt.new_string('settings'))
		&& var_steps_mutated.array_get('settings').array_count() > 0 {
		var_blueprint_steps = rt.call_function('array_merge', [
			var_blueprint_steps.dup(), var_steps_mutated.array_get('settings')])
	}
	if var_steps_mutated.array_isset(rt.new_string('plugins'))
		&& var_steps_mutated.array_get('plugins').array_count() > 0 {
		var_blueprint_steps.array_push('installPlugin')
	}
	if var_steps_mutated.array_isset(rt.new_string('themes'))
		&& var_steps_mutated.array_get('themes').array_count() > 0 {
		var_blueprint_steps.array_push('installTheme')
	}
	return var_blueprint_steps.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) import_step(mut var_request Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Request) rt.PhpVal {
	mut var_session_token := var_request.get_header(rt.new_string('X-Blueprint-Import-Session'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_session_token)))) {
		var_session_token = if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_generate_uuid4'),
		]))
		{ rt.call_function('wp_generate_uuid4', []rt.PhpVal{}) } else { rt.call_function('uniqid', [
				rt.new_string('bp_'),
				rt.new_bool(true),
			]) }
	}
	if !(this.can_import_blueprint(var_session_token.dup())) {
		return rt.create_array([rt.ArrayItem{ key: 'success', val: false },
			rt.ArrayItem{ key: 'messages', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('Blueprint imports are disabled'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'error' },
				]) },
			]) }])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_transient', [
		'blueprint_import_session_' + var_session_token.str(),
	])))
	{
		rt.call_function('set_transient', [
			'blueprint_import_session_' + var_session_token.str(),
			rt.new_bool(true),
			rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS')),
		])
	}
	mut var_body_size := rt.new_int(rt.new_int(var_request.get_body().to_string().len))
	if rt.is_true(rt.greater(var_body_size, this.get_max_file_size())) {
		return rt.create_array([rt.ArrayItem{ key: 'success', val: false },
			rt.ArrayItem{ key: 'messages', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Blueprint step definition size exceeds maximum limit of %s MB'),
							rt.new_string('woocommerce'),
						]),
						rt.div(this.get_max_file_size(), 1024 * 1024),
					]) },
					rt.ArrayItem{ key: 'type', val: 'error' },
				]) },
			]) }])
	}
	mut var_step_definition := rt.call_function('json_decode', [
		rt.call_function('wp_json_encode', [
			var_request.get_param(rt.new_string('step_definition')),
		]),
	])
	mut var_step_importer :=
		create_automattic_woocommerce_blueprint_importstep(var_step_definition.dup())
	mut var_result := var_step_importer.import()
	mut var_response := create_automattic_woocommerce_admin_features_blueprint_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'success', val: rt.call_method(var_result, 'is_success', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'messages', val: rt.call_method(var_result, 'get_messages',
			[]rt.PhpVal{}) },
	]))
	var_response.header(rt.new_string('X-Blueprint-Import-Session'), var_session_token.dup())
	return rt.new_object('Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Response',
		[]string{}, var_response)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) can_import_blueprint(var_session_token rt.PhpVal) bool {
	mut var_session_token_mutated := var_session_token
	if rt.is_true(rt.new_bool(rt.is_true(var_session_token_mutated)
		&& rt.is_true(rt.call_function('get_transient', ['blueprint_import_session_' + var_session_token_mutated.str()]))))
	{
		return true
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('defined', [rt.new_string('ALLOW_BLUEPRINT_IMPORT_IN_LIVE_MODE')]))
		&& rt.is_true(rt.get_constant('ALLOW_BLUEPRINT_IMPORT_IN_LIVE_MODE'))))
	{
		return true
	}
	if rt.is_true(rt.call_method(this.coming_soon_helper, 'is_site_live', []rt.PhpVal{})) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) get_import_allowed() rt.PhpVal {
	mut var_can_import := rt.new_bool(this.can_import_blueprint(rt.new_null()))
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'import_allowed', val: var_can_import }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) get_import_allowed_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'blueprint-import-allowed' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'import_allowed', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Whether blueprint imports are currently allowed'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) get_import_step_response_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'import-step' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'success', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'boolean' },
			]) },
			rt.ArrayItem{ key: 'messages', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'message', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]) },
					rt.ArrayItem{ key: 'required', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'message' },
						rt.ArrayItem{ key: none, val: 'type' },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'success' },
			rt.ArrayItem{ key: none, val: 'messages' },
		]) },
	])
	return var_schema.dup()
}

struct Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_ExportSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_HTTP_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_ImportStep {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_restapi() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi{
		PhpObjectBase:      rt.PhpObjectBase{}
		namespace:          rt.new_string('wc-admin')
		coming_soon_helper: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_comingsoon_comingsoonhelper() &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper{
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

fn create_automattic_woocommerce_blueprint_exportschema() &Class_Automattic_WooCommerce_Blueprint_ExportSchema {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ExportSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_wp_rest_response() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Response {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_wp_http_response() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_HTTP_Response {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_HTTP_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importstep() &Class_Automattic_WooCommerce_Blueprint_ImportStep {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ImportStep{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_max_file_size' {
			return this.get_max_file_size()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'check_export_permission' {
			return rt.new_bool(this.check_export_permission())
		}
		'check_import_permission' {
			return rt.new_bool(this.check_import_permission())
		}
		'export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export(dispatch_arg_0)
		}
		'steps_payload_to_blueprint_steps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.steps_payload_to_blueprint_steps(dispatch_arg_0)
		}
		'import_step' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.import_step(mut dispatch_arg_0)
		}
		'can_import_blueprint' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.can_import_blueprint(dispatch_arg_0))
		}
		'get_import_allowed' {
			return this.get_import_allowed()
		}
		'get_import_allowed_schema' {
			return this.get_import_allowed_schema()
		}
		'get_import_step_response_schema' {
			return this.get_import_step_response_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'coming_soon_helper' { return this.coming_soon_helper }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_RestApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'coming_soon_helper' {
			this.coming_soon_helper = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_HTTP_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_HTTP_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_WP_HTTP_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_blueprint_restapi_php() {
	// unsupported statement: Stmt_Declare
}
