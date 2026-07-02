import rt

struct Class_WP_REST_Post_Types_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Post_Types_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('types'))
}

fn (mut this Class_WP_REST_Post_Types_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Types_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<type>[\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('An alphanumeric identifier for the post type.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Types_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Post_Types_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
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
			rt.new_string('Sorry, you are not allowed to edit posts in this post type.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Post_Types_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	mut var_data := rt.new_array()
	mut var_types := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('objects'),
	])
	mut iter_2 := var_types.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_type := item_2.val
		if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context'))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_type, 'cap'), 'edit_posts')]))))) {
			continue
		}
		mut var_post_type := this.prepare_item_for_response(var_type.clone(), var_request.clone())
		var_data.array_set(rt.get_property(var_type, 'name'),
			this.prepare_response_for_collection(var_post_type.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Post_Types_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_obj := rt.call_function('get_post_type_object', [
		var_request.array_get(rt.new_string('type')),
	])
	if !rt.is_true(var_obj) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_type_invalid'), rt.call_function('__', [
			rt.new_string('Invalid post type.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	if !rt.is_true(rt.get_property(var_obj, 'show_in_rest')) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_read_type'), rt.call_function('__', [
			rt.new_string('Cannot view post type.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		])))
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_obj, 'cap'), 'edit_posts')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit posts in this post type.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		])))
	}
	mut var_data := this.prepare_item_for_response(var_obj.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Post_Types_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_type := var_item
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [
			rt.new_string('rest_prepare_post_type'),
			create_wp_rest_response(rt.new_array()),
			var_post_type.clone(),
			var_request.clone(),
		])
	}
	mut var_taxonomies := rt.call_function('wp_list_filter', [
		rt.call_function('get_object_taxonomies', [
			rt.get_property(var_post_type, 'name'),
			rt.new_string('objects'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'show_in_rest', val: true },
		]),
	])
	var_taxonomies = rt.call_function('wp_list_pluck', [var_taxonomies.clone(),
		rt.new_string('name')])
	mut var_base := if !(!rt.is_true(rt.get_property(var_post_type, 'rest_base'))) {
		rt.get_property(var_post_type, 'rest_base')
	} else {
		rt.get_property(var_post_type, 'name')
	}
	mut var_namespace := if !(!rt.is_true(rt.get_property(var_post_type, 'rest_namespace'))) {
		rt.get_property(var_post_type, 'rest_namespace')
	} else {
		rt.new_string('wp/v2')
	}
	mut var_supports := rt.call_function('get_all_post_type_supports', [
		rt.get_property(var_post_type, 'name'),
	])
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('capabilities'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('capabilities', rt.get_property(var_post_type, 'cap'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('description'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('description', rt.get_property(var_post_type, 'description'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('hierarchical'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('hierarchical', rt.get_property(var_post_type, 'hierarchical'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('has_archive'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('has_archive', rt.get_property(var_post_type, 'has_archive'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('visibility'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('visibility', rt.create_array([
			rt.ArrayItem{ key: 'show_in_nav_menus', val: (rt.get_property(var_post_type,
				'show_in_nav_menus')).to_bool() },
			rt.ArrayItem{ key: 'show_ui', val: (rt.get_property(var_post_type, 'show_ui')).to_bool() },
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('viewable'), var_fields.clone()]))
	{
		var_data.array_set('viewable', rt.call_function('is_post_type_viewable', [
			var_post_type.clone(),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('labels'), var_fields.clone()]))
	{
		var_data.array_set('labels', rt.get_property(var_post_type, 'labels'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('name'), var_fields.clone()]))
	{
		var_data.array_set('name', rt.get_property(var_post_type, 'label'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('slug'), var_fields.clone()]))
	{
		var_data.array_set('slug', rt.get_property(var_post_type, 'name'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('icon'), var_fields.clone()]))
	{
		var_data.array_set('icon', rt.get_property(var_post_type, 'menu_icon'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('supports'), var_fields.clone()]))
	{
		var_data.array_set('supports', var_supports.clone())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('taxonomies'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('taxonomies', rt.call_function('array_values', [
			var_taxonomies.clone()]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('rest_base'), var_fields.clone()]))
	{
		var_data.array_set('rest_base', var_base.clone())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('rest_namespace'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('rest_namespace', var_namespace.clone())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('template'), var_fields.clone()]))
	{
		var_data.array_set('template', if !(rt.get_property(var_post_type, 'template')).is_null() {
			rt.get_property(var_post_type, 'template')
		} else {
			rt.new_array()
		})
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('template_lock'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('template_lock', if !(!rt.is_true(rt.get_property(var_post_type,
			'template_lock'))) {
			rt.get_property(var_post_type, 'template_lock')
		} else {
			rt.new_bool(false)
		})
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
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [
			this.prepare_links(var_post_type.clone()),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_post_type'),
		var_response.clone(), var_post_type.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Post_Types_Controller) prepare_links(var_post_type rt.PhpVal) rt.PhpVal {
	mut var_post_type_mutated := var_post_type
	return rt.create_array([
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			]) },
		]) },
		rt.ArrayItem{ key: 'https://api.w.org/items', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('rest_get_route_for_post_type_items', [
					rt.get_property(var_post_type_mutated, 'name')]),
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Post_Types_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('type')
		'type':       rt.new_string('object')
		'properties': {
			'capabilities':   {
				'description': rt.call_function('__', [
					rt.new_string('All capabilities used by the post type.'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'description':    {
				'description': rt.call_function('__', [
					rt.new_string('A human-readable description of the post type.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'hierarchical':   {
				'description': rt.call_function('__', [
					rt.new_string('Whether or not the post type should have children.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'viewable':       {
				'description': rt.call_function('__', [
					rt.new_string('Whether or not the post type can be viewed.'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'labels':         {
				'description': rt.call_function('__', [
					rt.new_string('Human-readable labels for the post type for various contexts.'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'name':           {
				'description': rt.call_function('__', [
					rt.new_string('The title for the post type.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'slug':           {
				'description': rt.call_function('__', [
					rt.new_string('An alphanumeric identifier for the post type.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'supports':       {
				'description': rt.call_function('__', [
					rt.new_string('All features, supported by the post type.'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'has_archive':    {
				'description': rt.call_function('__', [
					rt.new_string('If the value is a string, the value will be used as the archive slug. If the value is false the post type has no archive.'),
				])
				'type':        map[string]rt.PhpVal{}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'taxonomies':     {
				'description': rt.call_function('__', [
					rt.new_string('Taxonomies associated with post type.'),
				])
				'type':        rt.new_string('array')
				'items':       {
					'type': rt.new_string('string')
				}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'rest_base':      {
				'description': rt.call_function('__', [
					rt.new_string('REST base route for the post type.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'rest_namespace': {
				'description': rt.call_function('__', [
					rt.new_string("REST route's namespace for the post type."),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'visibility':     {
				'description': rt.call_function('__', [
					rt.new_string('The visibility settings for the post type.'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'properties':  {
					'show_ui':           {
						'description': rt.call_function('__', [
							rt.new_string('Whether to generate a default UI for managing this post type.'),
						])
						'type':        rt.new_string('boolean')
					}
					'show_in_nav_menus': {
						'description': rt.call_function('__', [
							rt.new_string('Whether to make the post type available for selection in navigation menus.'),
						])
						'type':        rt.new_string('boolean')
					}
				}
			}
			'icon':           {
				'description': rt.call_function('__', [
					rt.new_string('The icon for the post type.'),
				])
				'type':        map[string]rt.PhpVal{}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'template':       {
				'type':        map[string]rt.PhpVal{}
				'description': rt.call_function('__', [
					rt.new_string('The block template associated with the post type.'),
				])
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'template_lock':  {
				'type':        map[string]rt.PhpVal{}
				'enum':        map[string]rt.PhpVal{}
				'description': rt.call_function('__', [
					rt.new_string('The template_lock associated with the post type, or false if none.'),
				])
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
		}
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Post_Types_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Post_Types_Controller) get_collection_params() rt.PhpVal {
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

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_post_types_controller() &Class_WP_REST_Post_Types_Controller {
	mut obj := &Class_WP_REST_Post_Types_Controller{
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

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Post_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
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

fn (this &Class_WP_REST_Post_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
