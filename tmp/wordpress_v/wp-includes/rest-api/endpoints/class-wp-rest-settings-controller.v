import rt

struct Class_WP_REST_Settings_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Settings_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('settings'))
}

fn (mut this Class_WP_REST_Settings_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Settings_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		'/' +
			rt.get_property(rt.new_object('WP_REST_Settings_Controller', ['WP_REST_Controller'], &this), 'rest_base'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Settings_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.new_array() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Settings_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Settings_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Settings_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Settings_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Settings_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_options')])
}

fn (mut this Class_WP_REST_Settings_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_options := this.get_registered_options()
	mut var_response := rt.new_array()
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_name := item_1.key
			var_response.array_set(var_name, rt.call_function('apply_filters', [
				rt.new_string('rest_pre_get_setting'),
				rt.new_null(),
				var_name.dup(),
				var_args.dup(),
			]))
			if rt.is_true(rt.new_bool(var_response.array_get(var_name).is_null())) {
				var_response.array_set(var_name, rt.call_function('get_option', [
					var_args.array_get('option_name'),
					var_args.array_get('schema').array_get('default'),
				]))
			}
			var_response.array_set(var_name, this.prepare_value(var_response.array_get(var_name),
				var_args.array_get('schema')))
		}
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Settings_Controller) prepare_value(var_value rt.PhpVal, var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.call_function('is_wp_error', [
		rt.call_function('rest_validate_value_from_schema', [
			var_value.dup(), var_schema_mutated.dup()]),
	]))
	{
		return rt.new_null()
	}
	return rt.call_function('rest_sanitize_value_from_schema', [
		var_value.dup(), var_schema_mutated.dup()])
}

fn (mut this Class_WP_REST_Settings_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_options := this.get_registered_options()
	mut var_params := rt.call_method(var_request, 'get_params', []rt.PhpVal{})
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_name := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_params.dup().array_isset(var_name.dup())))))) {
				continue
			}
			mut var_updated := rt.call_function('apply_filters', [
				rt.new_string('rest_pre_update_setting'),
				rt.new_bool(false),
				var_name.dup(),
				var_request.array_get(var_name),
				var_args.dup(),
			])
			if rt.is_true(var_updated) {
				continue
			}
			if rt.is_true(rt.new_bool(var_request.array_get(var_name).is_null())) {
				if rt.is_true(rt.call_function('is_wp_error', [
					rt.call_function('rest_validate_value_from_schema', [
						rt.call_function('get_option', [var_args.array_get('option_name'),
							rt.new_bool(false)]),
						var_args.array_get('schema'),
					]),
				]))
				{
					return create_wp_error(rt.new_string('rest_invalid_stored_value'), rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('The %s property has an invalid stored value, and cannot be updated to null.'),
						]),
						var_name.dup(),
					]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
				}
				rt.call_function('delete_option', [var_args.array_get('option_name')])
			} else {
				rt.call_function('update_option', [var_args.array_get('option_name'),
					var_request.array_get(var_name)])
			}
		}
	}
	return this.get_item(var_request.dup())
}

fn (mut this Class_WP_REST_Settings_Controller) get_registered_options() rt.PhpVal {
	mut var_rest_options := rt.new_array()
	{
		mut iter_1 := rt.call_function('get_registered_settings', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_name := item_1.key
			if !rt.is_true(var_args.array_get('show_in_rest')) {
				continue
			}
			mut var_rest_args := rt.new_array()
			if rt.is_true(rt.new_bool(var_args.array_get('show_in_rest').is_array())) {
				var_rest_args = var_args.array_get('show_in_rest')
			}
			mut var_defaults := {
				'name':   if !(!rt.is_true(var_rest_args.array_get('name'))) {
					var_rest_args.array_get('name')
				} else {
					var_name
				}
				'schema': rt.new_array()
			}
			var_rest_args = rt.call_function('array_merge', [
				var_defaults.dup(), var_rest_args.dup()])
			mut var_default_schema := {
				'type':        if !rt.is_true(var_args.array_get('type')) {
					rt.new_null()
				} else {
					var_args.array_get('type')
				}
				'title':       if !rt.is_true(var_args.array_get('label')) {
					rt.new_string('')
				} else {
					var_args.array_get('label')
				}
				'description': if !rt.is_true(var_args.array_get('description')) {
					rt.new_string('')
				} else {
					var_args.array_get('description')
				}
				'default':     if !(var_args.array_get('default')).is_null() {
					var_args.array_get('default')
				} else {
					rt.new_null()
				}
			}
			var_rest_args.array_set('schema', rt.call_function('array_merge', [
				var_default_schema.dup(), var_rest_args.array_get('schema')]))
			var_rest_args.array_set('option_name', var_name.dup())
			if !rt.is_true(var_rest_args.array_get('schema').array_get('type')) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_rest_args.array_get('schema').array_get('type'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'number' },
					rt.ArrayItem{ key: none, val: 'integer' },
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'boolean' },
					rt.ArrayItem{ key: none, val: 'array' }, rt.ArrayItem{ key: none, val: 'object' }]),
				rt.new_bool(true),
			])))))
			{
				continue
			}
			var_rest_args.array_set('schema', rt.call_function('rest_default_additional_properties_to_false', [
				var_rest_args.array_get('schema'),
			]))
			var_rest_options.array_set(var_rest_args.array_get('name'), var_rest_args.dup())
		}
	}
	return var_rest_options.dup()
}

fn (mut this Class_WP_REST_Settings_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Settings_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Settings_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_options := this.get_registered_options()
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('settings')
		'type':       rt.new_string('object')
		'properties': rt.new_array()
	}
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			mut var_option_name := item_1.key
			var_schema.array_get_mut('properties').array_set(var_option_name,
				var_option.array_get('schema'))
			var_schema.array_get_mut('properties').array_get_mut(var_option_name).array_set('arg_options', rt.create_array([
				rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Settings_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'sanitize_callback' },
				]) },
			]))
		}
	}
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Settings_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Settings_Controller) sanitize_callback(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_value.dup().is_null())) {
		return var_value.dup()
	}
	return rt.call_function('rest_parse_request_arg', [var_value.dup(),
		var_request.dup(), var_param.dup()])
}

fn (mut this Class_WP_REST_Settings_Controller) set_additional_properties_to_false(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('6.1.0'), rt.new_string('rest_default_additional_properties_to_false()')])
	return rt.call_function('rest_default_additional_properties_to_false', [
		var_schema_mutated.dup()])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_settings_controller() &Class_WP_REST_Settings_Controller {
	mut obj := &Class_WP_REST_Settings_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
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

fn (mut this Class_WP_REST_Settings_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'prepare_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_value(dispatch_arg_0, dispatch_arg_1)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'get_registered_options' {
			return this.get_registered_options()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'sanitize_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.sanitize_callback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_additional_properties_to_false' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_additional_properties_to_false(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Settings_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Settings_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_settings_controller_php() {
}
