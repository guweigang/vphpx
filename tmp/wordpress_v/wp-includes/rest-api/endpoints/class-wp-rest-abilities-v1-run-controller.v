import rt

struct Class_WP_REST_Abilities_V1_Run_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wp-abilities/v1')
	rest_base rt.PhpVal = rt.new_string('abilities')
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace,
		'/' + (this.rest_base).str() + '/(?P<name>[a-zA-Z0-9\\-\\/]+?)/run',
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the ability.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'pattern', val: '^[a-zA-Z0-9\\-\\/]+$' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.allmethods() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_Run_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'execute_ability' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_Run_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'check_ability_permissions' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_run_args() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_Run_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_run_schema' },
			]) },
		])])
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) execute_ability(var_request rt.PhpVal) rt.PhpVal {
	mut var_ability := rt.call_function('wp_get_ability', [var_request.array_get('name')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ability)))) {
		return create_wp_error(rt.new_string('rest_ability_not_found'), rt.call_function('__', [
			rt.new_string('Ability not found.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_input := this.get_input_from_request(var_request.dup())
	mut var_result := rt.call_method(var_ability, 'execute', [
		var_input.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return var_result.dup()
	}
	return rt.call_function('rest_ensure_response', [var_result.dup()])
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) validate_request_method(request_method string, mut var_annotations Class_array) bool {
	mut var_expected_method := rt.new_string(rt.new_string('POST'))
	if !(!rt.is_true(var_annotations.array_get('readonly'))) {
		var_expected_method = rt.new_string(rt.new_string('GET'))
	} else if !(!rt.is_true(var_annotations.array_get('destructive')))
		&& !(!rt.is_true(var_annotations.array_get('idempotent'))) {
		var_expected_method = rt.new_string(rt.new_string('DELETE'))
	}
	if rt.is_true(rt.identical(var_expected_method, rt.new_string(request_method))) {
		return true
	}
	mut var_error_message := rt.call_function('__', [
		rt.new_string('Abilities that perform updates require POST method.'),
	])
	if rt.is_true(rt.identical(rt.new_string('GET'), var_expected_method)) {
		var_error_message = rt.call_function('__', [
			rt.new_string('Read-only abilities require GET method.'),
		])
	} else if rt.is_true(rt.identical(rt.new_string('DELETE'), var_expected_method)) {
		var_error_message = rt.call_function('__', [
			rt.new_string('Abilities that perform destructive actions require DELETE method.'),
		])
	}
	return (create_wp_error(rt.new_string('rest_ability_invalid_method'), var_error_message.dup(), rt.create_array([
		rt.ArrayItem{ key: 'status', val: 405 },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) check_ability_permissions(var_request rt.PhpVal) bool {
	mut var_ability := rt.call_function('wp_get_ability', [var_request.array_get('name')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_ability))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_ability, 'get_meta_item', [rt.new_string('show_in_rest')])))))))
	{
		return (create_wp_error(rt.new_string('rest_ability_not_found'), rt.call_function('__', [
			rt.new_string('Ability not found.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))).to_bool()
	}
	mut var_is_valid := rt.new_bool(this.validate_request_method((rt.call_method(var_request,
		'get_method', []rt.PhpVal{})).str(), mut rt.cast_object_ptr[Class_array](rt.call_method(var_ability,
		'get_meta_item', [rt.new_string('annotations')]))))
	if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.dup()])) {
		return var_is_valid.to_bool()
	}
	mut var_input := this.get_input_from_request(var_request.dup())
	var_input = rt.call_method(var_ability, 'normalize_input', [
		var_input.dup()])
	var_is_valid = rt.call_method(var_ability, 'validate_input', [
		var_input.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.dup()])) {
		rt.call_method(var_is_valid, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
		])
		return var_is_valid.to_bool()
	}
	mut var_result := rt.call_method(var_ability, 'check_permissions', [
		var_input.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.call_method(var_result, 'add_data', [
			rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]),
		])
		return var_result.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_wp_error(rt.new_string('rest_ability_cannot_execute'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to execute this ability.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) get_input_from_request(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_request, 'get_method', []rt.PhpVal{}),
		rt.create_array([rt.ArrayItem{ key: none, val: 'GET' },
			rt.ArrayItem{ key: none, val: 'DELETE' }]),
		rt.new_bool(true),
	]))
	{
		mut var_query_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
		return if !(var_query_params.array_get('input')).is_null() {
			var_query_params.array_get('input')
		} else {
			rt.new_null()
		}
	}
	mut var_json_params := rt.call_method(var_request, 'get_json_params', []rt.PhpVal{})
	return if !(var_json_params.array_get('input')).is_null() {
		var_json_params.array_get('input')
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) get_run_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'input', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Input parameters for the ability execution.'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'integer' },
				rt.ArrayItem{ key: none, val: 'number' },
				rt.ArrayItem{ key: none, val: 'boolean' },
				rt.ArrayItem{ key: none, val: 'string' },
				rt.ArrayItem{ key: none, val: 'array' },
				rt.ArrayItem{ key: none, val: 'object' },
				rt.ArrayItem{ key: none, val: 'null' },
			]) },
			rt.ArrayItem{ key: 'default', val: rt.new_null() },
		]) },
	])
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) get_run_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'ability-execution' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'result', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The result of the ability execution.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'integer' },
					rt.ArrayItem{ key: none, val: 'number' },
					rt.ArrayItem{ key: none, val: 'boolean' },
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'array' },
					rt.ArrayItem{ key: none, val: 'object' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_abilities_v1_run_controller() &Class_WP_REST_Abilities_V1_Run_Controller {
	mut obj := &Class_WP_REST_Abilities_V1_Run_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wp-abilities/v1')
		rest_base:     rt.new_string('abilities')
	}
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'execute_ability' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.execute_ability(dispatch_arg_0)
		}
		'validate_request_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.validate_request_method(dispatch_arg_0, mut dispatch_arg_1))
		}
		'check_ability_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_ability_permissions(dispatch_arg_0))
		}
		'get_input_from_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_input_from_request(dispatch_arg_0)
		}
		'get_run_args' {
			return this.get_run_args()
		}
		'get_run_schema' {
			return this.get_run_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Abilities_V1_Run_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Abilities_V1_Run_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
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

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_abilities_v1_run_controller_php() {
	// unsupported statement: Stmt_Declare
}
