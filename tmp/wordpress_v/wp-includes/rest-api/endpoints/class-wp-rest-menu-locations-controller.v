import rt

struct Class_WP_REST_Menu_Locations_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('menu-locations'))
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<location>[\\w-]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'location', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('An alphanumeric identifier for the menu location.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.check_has_read_only_access(var_request.dup()))
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	{
		mut iter_1 := rt.call_function('get_registered_nav_menus', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_description := item_1.val
			mut var_name := item_1.key
			mut var_location := create_stdclass()
			rt.set_property(var_location, 'name', var_name.dup())
			rt.set_property(var_location, 'description', var_description.dup())
			var_location = this.prepare_item_for_response(var_location.dup(), var_request.dup())
			var_data.array_set(var_name, this.prepare_response_for_collection(var_location.dup()))
		}
	}
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.check_has_read_only_access(var_request.dup()))
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_registered_menus := rt.call_function('get_registered_nav_menus', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_registered_menus.dup().array_isset(var_request.array_get('location'))))))) {
		return create_wp_error(rt.new_string('rest_menu_location_invalid'), rt.call_function('__', [rt.new_string('Invalid menu location.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_location := create_stdclass()
	rt.set_property(var_location, 'name', var_request.array_get('location'))
	rt.set_property(var_location, 'description', var_registered_menus.array_get(rt.get_property(var_location, 'name')))
	mut var_data := this.prepare_item_for_response(var_location.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) check_has_read_only_access(var_request rt.PhpVal) bool {
	mut var_read_only_access := rt.call_function('apply_filters', [rt.new_string('rest_menu_read_access'), rt.new_bool(false), var_request.dup(), rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this)])
	if rt.is_true(var_read_only_access) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view menu locations.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_location := var_item
	mut var_locations := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	mut var_menu := if !(var_locations.array_get(rt.get_property(var_location, 'name'))).is_null() { var_locations.array_get(rt.get_property(var_location, 'name')) } else { rt.new_int(0) }
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('name'), var_fields.dup()])) {
		var_data.array_set('name', rt.get_property(var_location, 'name'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('description'), var_fields.dup()])) {
		var_data.array_set('description', rt.get_property(var_location, 'description'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('menu'), var_fields.dup()])) {
		var_data.array_set('menu', // unsupported expression: Expr_Cast_Int)
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_location.dup())])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_menu_location'), var_response.dup(), var_location.dup(), var_request.dup()])
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) prepare_links(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	mut var_base := rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'rest_base')])
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.concat(rt.call_function('trailingslashit', [var_base.dup()]), rt.get_property(var_location_mutated, 'name'))]) }, 'collection': { 'href': rt.call_function('rest_url', [var_base.dup()]) } }
	mut var_locations := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	mut var_menu := if !(var_locations.array_get(rt.get_property(var_location_mutated, 'name'))).is_null() { var_locations.array_get(rt.get_property(var_location_mutated, 'name')) } else { rt.new_int(0) }
	if rt.is_true(var_menu) {
		mut var_path := rt.call_function('rest_get_route_for_term', [var_menu.dup()])
		if rt.is_true(var_path) {
			mut var_url := rt.call_function('rest_url', [var_path.dup()])
			var_links.array_get_mut('https://api.w.org/menu').array_push(rt.create_array([rt.ArrayItem{ key: 'href', val: var_url }, rt.ArrayItem{ key: 'embeddable', val: true }]))
		}
	}
	return var_links.dup()
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'schema'))
	}
	this.dispatch_set_prop('schema', rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'menu-location' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The name of the menu location.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }, rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The description of the menu location.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }, rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'menu', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID of the assigned menu.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }, rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Menu_Locations_Controller', ['WP_REST_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_menu_locations_controller() &Class_WP_REST_Menu_Locations_Controller {
	mut obj := &Class_WP_REST_Menu_Locations_Controller{
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

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn (mut this Class_WP_REST_Menu_Locations_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'check_has_read_only_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_has_read_only_access(dispatch_arg_0))
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
		else { return none }
	}
}

fn (this &Class_WP_REST_Menu_Locations_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Menu_Locations_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_menu_locations_controller_php() {
}
