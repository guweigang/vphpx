import rt

struct Class_WP_REST_Widgets_Controller {
	rt.PhpObjectBase
pub mut:
		widgets_retrieved bool
		allow_batch rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Widgets_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('widgets'))
}

fn (mut this Class_WP_REST_Widgets_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema() }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<id>[\\w\\-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to force removal of the widget, or move it to the inactive sidebar.')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Widgets_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	if var_request_mutated.array_isset(rt.new_string('sidebar')) && this.check_read_sidebar_permission(var_request_mutated.array_get('sidebar')) {
		return true
	}
	{
		mut iter_1 := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget_ids := item_1.val
			mut var_sidebar_id := item_1.key
			if this.check_read_sidebar_permission(var_sidebar_id.dup()) {
				return true
			}
		}
	}
	return this.permissions_check(var_request_mutated.dup())
}

fn (mut this Class_WP_REST_Widgets_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.call_method(var_request_mutated, 'is_method', [rt.new_string('HEAD')])) {
		return create_wp_rest_response(rt.new_array())
	}
	this.retrieve_widgets()
	mut var_prepared := rt.new_array()
	mut var_permissions_check := rt.new_bool(this.permissions_check(var_request_mutated.dup()))
	{
		mut iter_1 := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget_ids := item_1.val
			mut var_sidebar_id := item_1.key
			if rt.is_true(rt.new_bool(var_request_mutated.array_isset(rt.new_string('sidebar')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_permissions_check.dup()])) && !(this.check_read_sidebar_permission(var_sidebar_id.dup())))) {
				continue
			}
			{
				mut iter_2 := var_widget_ids.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_widget_id := item_2.val
					mut var_response := this.prepare_item_for_response(rt.call_function('compact', [rt.new_string('sidebar_id'), rt.new_string('widget_id')]), var_request_mutated.dup())
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()]))))) {
						var_prepared.array_push(this.prepare_response_for_collection(var_response.dup()))
					}
				}
			}
		}
	}
	return create_wp_rest_response(var_prepared.dup())
}

fn (mut this Class_WP_REST_Widgets_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get('id')
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [var_widget_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_sidebar_id) && this.check_read_sidebar_permission(var_sidebar_id.dup()))) {
		return true
	}
	return this.permissions_check(var_request_mutated.dup())
}

fn (mut this Class_WP_REST_Widgets_Controller) check_read_sidebar_permission(var_sidebar_id rt.PhpVal) bool {
	mut var_sidebar_id_mutated := var_sidebar_id
	mut var_sidebar := rt.call_function('wp_get_sidebar', [var_sidebar_id_mutated.dup()])
	return !(!rt.is_true(var_sidebar.array_get('show_in_rest')))
}

fn (mut this Class_WP_REST_Widgets_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get('id')
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [var_widget_id.dup()])
	if rt.is_true(rt.new_bool(var_sidebar_id.dup().is_null())) {
		return create_wp_error(rt.new_string('rest_widget_not_found'), rt.call_function('__', [rt.new_string('No widget was found with that id.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return this.prepare_item_for_response(rt.call_function('compact', [rt.new_string('widget_id'), rt.new_string('sidebar_id')]), var_request_mutated.dup())
}

fn (mut this Class_WP_REST_Widgets_Controller) create_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.dup()))
}

fn (mut this Class_WP_REST_Widgets_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_sidebar_id := var_request_mutated.array_get('sidebar')
	mut var_widget_id := this.save_widget(var_request_mutated.dup(), var_sidebar_id.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_widget_id.dup()])) {
		return var_widget_id.dup()
	}
	rt.call_function('wp_assign_widget_to_sidebar', [var_widget_id.dup(), var_sidebar_id.dup()])
	var_request_mutated.array_set('context', 'edit')
	mut var_response := this.prepare_item_for_response(rt.call_function('compact', [rt.new_string('sidebar_id'), rt.new_string('widget_id')]), var_request_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		return var_response.dup()
	}
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Widgets_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.dup()))
}

fn (mut this Class_WP_REST_Widgets_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_request_mutated := var_request
	// unsupported statement: Stmt_Global
	rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get('id')
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [var_widget_id.dup()])
	mut var_parsed_id := rt.call_function('wp_parse_widget_id', [var_widget_id.dup()])
	mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [var_parsed_id.array_get('id_base')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_sidebar_id.dup().is_null())) && rt.is_true(var_widget_object))) {
		return create_wp_error(rt.new_string('rest_widget_not_found'), rt.call_function('__', [rt.new_string('No widget was found with that id.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_request_mutated, 'has_param', [rt.new_string('instance')])) || rt.is_true(rt.call_method(var_request_mutated, 'has_param', [rt.new_string('form_data')])))) {
		mut var_maybe_error := this.save_widget(var_request_mutated.dup(), var_sidebar_id.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_maybe_error.dup()])) {
			return var_maybe_error.dup()
		}
	}
	if rt.is_true(rt.call_method(var_request_mutated, 'has_param', [rt.new_string('sidebar')])) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_sidebar_id = var_request_mutated.array_get('sidebar')
			rt.call_function('wp_assign_widget_to_sidebar', [var_widget_id.dup(), var_sidebar_id.dup()])
		}
	}
	var_request_mutated.array_set('context', 'edit')
	return this.prepare_item_for_response(rt.call_function('compact', [rt.new_string('widget_id'), rt.new_string('sidebar_id')]), var_request_mutated.dup())
}

fn (mut this Class_WP_REST_Widgets_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.dup()))
}

fn (mut this Class_WP_REST_Widgets_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_request_mutated := var_request
	// unsupported statement: Stmt_Global
	rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get('id')
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [var_widget_id.dup()])
	if rt.is_true(rt.new_bool(var_sidebar_id.dup().is_null())) {
		return create_wp_error(rt.new_string('rest_widget_not_found'), rt.call_function('__', [rt.new_string('No widget was found with that id.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	var_request_mutated.array_set('context', 'edit')
	if rt.is_true(var_request_mutated.array_get('force')) {
		mut var_response := this.prepare_item_for_response(rt.call_function('compact', [rt.new_string('widget_id'), rt.new_string('sidebar_id')]), var_request_mutated.dup())
		mut var_parsed_id := rt.call_function('wp_parse_widget_id', [var_widget_id.dup()])
		mut var_id_base := var_parsed_id.array_get('id_base')
		mut var_original_post := rt.get_superglobal('_POST').dup()
		mut var_original_request := rt.get_superglobal('_REQUEST').dup()
		mut var__POST := rt.create_array([rt.ArrayItem{ key: 'sidebar', val: var_sidebar_id }, rt.ArrayItem{ key: "widget-${var_id_base.to_string()}", val: rt.new_array() }, rt.ArrayItem{ key: 'the-widget-id', val: var_widget_id }, rt.ArrayItem{ key: 'delete_widget', val: '1' }])
		mut var__REQUEST := rt.get_superglobal('_POST').dup()
		rt.call_function('do_action', [rt.new_string('delete_widget'), var_widget_id.dup(), var_sidebar_id.dup(), var_id_base.dup()])
		mut var_callback := var_wp_registered_widget_updates.array_get(var_id_base).array_get('callback')
		mut var_params := var_wp_registered_widget_updates.array_get(var_id_base).array_get('params')
		if rt.is_true(rt.call_function('is_callable', [var_callback.dup()])) {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_function('call_user_func_array', [var_callback.dup(), var_params.dup()])
			rt.call_function('ob_end_clean', []rt.PhpVal{})
		}
		var__POST = var_original_post.dup()
		var__REQUEST = var_original_request.dup()
		mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [var_id_base.dup()])
		if rt.is_true(var_widget_object) {
			rt.set_property(var_widget_object, 'updated', rt.new_bool(false))
		}
		rt.call_function('wp_assign_widget_to_sidebar', [var_widget_id.dup(), rt.new_string('')])
		rt.call_method(var_response, 'set_data', [rt.create_array([rt.ArrayItem{ key: 'deleted', val: true }, rt.ArrayItem{ key: 'previous', val: rt.call_method(var_response, 'get_data', []rt.PhpVal{}) }])])
	} else {
		rt.call_function('wp_assign_widget_to_sidebar', [var_widget_id.dup(), rt.new_string('wp_inactive_widgets')])
		var_response = this.prepare_item_for_response(rt.create_array([rt.ArrayItem{ key: 'sidebar_id', val: 'wp_inactive_widgets' }, rt.ArrayItem{ key: 'widget_id', val: var_widget_id }]), var_request_mutated.dup())
	}
	rt.call_function('do_action', [rt.new_string('rest_delete_widget'), var_widget_id.dup(), var_sidebar_id.dup(), var_response.dup(), var_request_mutated.dup()])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Widgets_Controller) permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_manage_widgets'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage widgets on this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Widgets_Controller) retrieve_widgets()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.widgets_retrieved)))) {
		rt.call_function('retrieve_widgets', []rt.PhpVal{})
		this.widgets_retrieved = true
	}
}

fn (mut this Class_WP_REST_Widgets_Controller) save_widget(var_request rt.PhpVal, var_sidebar_id rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_request_mutated := var_request
	mut var_sidebar_id_mutated := var_sidebar_id
	// unsupported statement: Stmt_Global
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/widgets.php', '4')
	if var_request_mutated.array_isset(rt.new_string('id')) {
		mut var_id := var_request_mutated.array_get('id')
		mut var_parsed_id := rt.call_function('wp_parse_widget_id', [.dup()])
		mut var_id_base := 
		
	} else if rt.is_true() {
	} else {
	}
	if !(.array_isset()) {
	}
	if .array_isset() {
	} else if .array_isset() {
	} else {
	}
	
}

fn (mut this Class_WP_REST_Widgets_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Widgets_Controller) prepare_links(var_prepared rt.PhpVal) rt.PhpVal {
	mut var_prepared_mutated := var_prepared
}

fn (mut this Class_WP_REST_Widgets_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Widgets_Controller) get_item_schema() rt.PhpVal {
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_widgets_controller() &Class_WP_REST_Widgets_Controller {
	mut obj := &Class_WP_REST_Widgets_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		widgets_retrieved: false
		allow_batch: rt.new_array()
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

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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

fn (mut this Class_WP_REST_Widgets_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'check_read_sidebar_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_read_sidebar_permission(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item_permissions_check(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.permissions_check(dispatch_arg_0))
		}
		'retrieve_widgets' {
			this.retrieve_widgets()
			return rt.new_null()
		}
		'save_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.save_widget(dispatch_arg_0, dispatch_arg_1)
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
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Widgets_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'widgets_retrieved' { return rt.new_bool(this.widgets_retrieved) }
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Widgets_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'widgets_retrieved' { this.widgets_retrieved = (val).to_bool(); return true }
		'allow_batch' { this.allow_batch = val; return true }
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


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_widgets_controller_php() {
}
