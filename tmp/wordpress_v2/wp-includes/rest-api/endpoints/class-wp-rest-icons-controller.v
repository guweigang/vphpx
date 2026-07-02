import rt

struct Class_WP_REST_Icons_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Icons_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('icons'))
}

fn (mut this Class_WP_REST_Icons_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Icons_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Icons_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Icons_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Icons_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Icons_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Icons_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Icons_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<name>[a-z][a-z0-9-]*/[a-z][a-z0-9-]*)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Icon name.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Icons_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Icons_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Icons_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Icons_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	mut iter_1 := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('objects'),
	]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post_type := item_1.val
		if rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
		]))
		{
			return true
		}
	}
	return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to view the registered icons.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Icons_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_check := rt.new_bool(this.get_items_permissions_check(var_request.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_check.clone()])) {
		return var_check.to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Icons_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_response := []rt.PhpVal{}
	mut var_search := rt.call_method(var_request, 'get_param', [
		rt.new_string('search')])
	mut iife_temp_0 := Class_WP_Icons_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_icons := rt.call_method(iife_result_0, 'get_registered_icons', [
		var_search.clone()])
	mut iter_2 := var_icons.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_icon := item_2.val
		mut var_prepared_icon := this.prepare_item_for_response(var_icon.clone(),
			var_request.clone())
		var_response << this.prepare_response_for_collection(var_prepared_icon.clone())
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_response),
	])
}

fn (mut this Class_WP_REST_Icons_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_icon := this.get_icon(var_request.array_get(rt.new_string('name')))
	if rt.is_true(rt.call_function('is_wp_error', [var_icon.clone()])) {
		return var_icon.clone()
	}
	mut var_data := this.prepare_item_for_response(var_icon.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Icons_Controller) get_icon(var_name rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_WP_Icons_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_registry := iife_result_1
	mut var_icon := rt.call_method(var_registry, 'get_registered_icon', [
		var_name.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_icon)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_icon_not_found'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Icon not found: "%s".')]),
			var_name.clone(),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return var_icon.clone()
}

fn (mut this Class_WP_REST_Icons_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_keys := {
		'name':    'name'
		'label':   'label'
		'content': 'content'
	}
	mut var_data := []rt.PhpVal{}
	for var_item_key, var_rest_key in var_keys {
		if var_item.array_isset(rt.new_string(item_key))
			&& rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string(rest_key), var_fields.clone()])) {
			var_data.array_set(rest_key, var_item.array_get(rt.new_string(item_key)))
		}
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Icons_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Icons_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Icons_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('icon')
		'type':       rt.new_string('object')
		'properties': {
			'name':    {
				'description': rt.call_function('__', [rt.new_string('The icon name.')])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'label':   {
				'description': rt.call_function('__', [rt.new_string('The icon label.')])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'content': {
				'description': rt.call_function('__', [
					rt.new_string('The icon content (SVG markup).'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
		}
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Icons_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Icons_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('context').array_set('default', 'view')
	return var_query_params.clone()
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Icons_Registry {
	rt.PhpObjectBase
}

fn create_wp_rest_icons_controller() &Class_WP_REST_Icons_Controller {
	mut obj := &Class_WP_REST_Icons_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_wp_icons_registry(_args ...rt.PhpVal) &Class_WP_Icons_Registry {
	mut obj := &Class_WP_Icons_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Icons_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_icon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_icon(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Icons_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Icons_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Icons_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Icons_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Icons_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
