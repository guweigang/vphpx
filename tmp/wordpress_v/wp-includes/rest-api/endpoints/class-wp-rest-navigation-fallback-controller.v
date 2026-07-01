import rt

struct Class_WP_REST_Navigation_Fallback_Controller {
	rt.PhpObjectBase
pub mut:
		post_type string
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp-block-editor/v1'))
	this.dispatch_set_prop('rest_base', rt.new_string('navigation-fallback'))
	this.post_type = 'wp_navigation'
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.readable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post_type := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'create_posts')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')]))))))) {
		return (create_wp_error(rt.new_string('rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create Navigation Menus as this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit Navigation Menus as this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := fn () rt.PhpVal { mut temp := Class_WP_Navigation_Fallback{}; return temp.get_fallback() }()
	if !rt.is_true(var_post) {
		return rt.call_function('rest_ensure_response', [create_wp_error(rt.new_string('no_fallback_menu'), rt.call_function('__', [rt.new_string('No fallback menu found.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))])
	}
	mut var_response := this.prepare_item_for_response(var_post.dup(), var_request.dup())
	return var_response.dup()
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this), 'schema'))
	}
	this.dispatch_set_prop('schema', rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'navigation-fallback' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The unique identifier for the Navigation Menu.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Navigation_Fallback_Controller', ['WP_REST_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_fields := this.get_fields_for_response(var_request.dup())
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('id'), var_fields.dup()])) {
		var_data.array_set('id', // unsupported expression: Expr_Cast_Int)
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		mut var_links := this.prepare_links(var_item.dup())
		rt.call_method(var_response, 'add_links', [var_links.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	return rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post', [rt.get_property(var_post_mutated, 'ID')])]) }, rt.ArrayItem{ key: 'embeddable', val: true }]) }])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Navigation_Fallback {
	rt.PhpObjectBase
}

fn create_wp_rest_navigation_fallback_controller() &Class_WP_REST_Navigation_Fallback_Controller {
	mut obj := &Class_WP_REST_Navigation_Fallback_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		post_type: ''
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

fn create_wp_navigation_fallback() &Class_WP_Navigation_Fallback {
	mut obj := &Class_WP_Navigation_Fallback{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
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
		else { return none }
	}
}

fn (this &Class_WP_REST_Navigation_Fallback_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_type' { return rt.new_string(this.post_type) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Navigation_Fallback_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_type' { this.post_type = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_WP_Navigation_Fallback) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Navigation_Fallback) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Navigation_Fallback) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_navigation_fallback_controller_php() {
}
