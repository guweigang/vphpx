import rt

struct Class_WP_REST_Post_Statuses_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('statuses'))
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Post_Statuses_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Post_Statuses_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Statuses_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Statuses_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Statuses_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Post_Statuses_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Post_Statuses_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<status>[\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('An alphanumeric identifier for the status.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Statuses_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Statuses_Controller', [
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
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Statuses_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('edit'),
		var_request.array_get(rt.new_string('context'))))
	{
		mut var_types := rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
			rt.new_string('objects'),
		])
		mut iter_1 := var_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			if rt.is_true(rt.call_function('current_user_can', [
				rt.get_property(rt.get_property(var_type, 'cap'), 'edit_posts'),
			]))
			{
				return true
			}
		}
		return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to manage post statuses.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_statuses := rt.call_function('get_post_stati', [
		rt.create_array([rt.ArrayItem{ key: 'internal', val: false }]),
		rt.new_string('object'),
	])
	var_statuses.array_set('trash', rt.call_function('get_post_status_object', [
		rt.new_string('trash'),
	]))
	mut iter_2 := var_statuses.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_obj := item_2.val
		mut var_ret := rt.new_bool(this.check_read_permission(var_obj.clone()))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_ret)))) {
			continue
		}
		mut var_status := this.prepare_item_for_response(var_obj.clone(), var_request.clone())
		var_data.array_set(rt.get_property(var_obj, 'name'),
			this.prepare_response_for_collection(var_status.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_status := rt.call_function('get_post_status_object', [
		var_request.array_get(rt.new_string('status')),
	])
	if !rt.is_true(var_status) {
		return (create_wp_error(rt.new_string('rest_status_invalid'), rt.call_function('__', [
			rt.new_string('Invalid status.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))).to_bool()
	}
	mut var_check := rt.new_bool(this.check_read_permission(var_status.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_check)))) {
		return (create_wp_error(rt.new_string('rest_cannot_read_status'), rt.call_function('__', [
			rt.new_string('Cannot view status.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) check_read_permission(var_status rt.PhpVal) bool {
	mut var_status_mutated := var_status
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_status_mutated, 'public'))) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(var_status_mutated, 'internal')))
		|| rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_status_mutated, 'name'))) {
		mut var_types := rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
			rt.new_string('objects'),
		])
		mut iter_3 := var_types.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_type := item_3.val
			if rt.is_true(rt.call_function('current_user_can', [
				rt.get_property(rt.get_property(var_type, 'cap'), 'edit_posts'),
			]))
			{
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_obj := rt.call_function('get_post_status_object', [
		var_request.array_get(rt.new_string('status')),
	])
	if !rt.is_true(var_obj) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_status_invalid'), rt.call_function('__', [
			rt.new_string('Invalid status.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_data := this.prepare_item_for_response(var_obj.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_status := var_item
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [rt.new_string('name'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('name', rt.get_property(var_status, 'label'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('private'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('private', (rt.get_property(var_status, 'private')).to_bool())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('protected'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('protected', (rt.get_property(var_status, 'protected')).to_bool())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('public'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('public', (rt.get_property(var_status, 'public')).to_bool())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('queryable'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('queryable',
			(rt.get_property(var_status, 'publicly_queryable')).to_bool())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('show_in_list'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('show_in_list',
			(rt.get_property(var_status, 'show_in_admin_all_list')).to_bool())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('slug'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('slug', rt.get_property(var_status, 'name'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_floating'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('date_floating', rt.get_property(var_status, 'date_floating'))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	mut var_rest_url := rt.call_function('rest_url', [
		rt.call_function('rest_get_route_for_post_type_items', [
			rt.new_string('post')]),
	])
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_status, 'name'))) {
		rt.call_method(var_response, 'add_link', [rt.new_string('archives'),
			var_rest_url.clone()])
	} else {
		rt.call_method(var_response, 'add_link', [rt.new_string('archives'),
			rt.call_function('add_query_arg', [rt.new_string('status'),
				rt.get_property(var_status, 'name'), var_rest_url.clone()])])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_status'),
		var_response.clone(), var_status.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Post_Statuses_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Post_Statuses_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('status')
		'type':       rt.new_string('object')
		'properties': {
			'name':          {
				'description': rt.call_function('__', [
					rt.new_string('The title for the status.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'private':       {
				'description': rt.call_function('__', [
					rt.new_string('Whether posts with this status should be private.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'protected':     {
				'description': rt.call_function('__', [
					rt.new_string('Whether posts with this status should be protected.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'public':        {
				'description': rt.call_function('__', [
					rt.new_string('Whether posts of this status should be shown in the front end of the site.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'queryable':     {
				'description': rt.call_function('__', [
					rt.new_string('Whether posts with this status should be publicly-queryable.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'show_in_list':  {
				'description': rt.call_function('__', [
					rt.new_string('Whether to include posts in the edit listing for their post type.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'slug':          {
				'description': rt.call_function('__', [
					rt.new_string('An alphanumeric identifier for the status.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_floating': {
				'description': rt.call_function('__', [
					rt.new_string('Whether posts of this status may have floating published dates.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Post_Statuses_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_post_statuses_controller() &Class_WP_REST_Post_Statuses_Controller {
	mut obj := &Class_WP_REST_Post_Statuses_Controller{
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

fn (mut this Class_WP_REST_Post_Statuses_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'check_read_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_read_permission(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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

fn (this &Class_WP_REST_Post_Statuses_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
