import rt

struct Class_WP_REST_Application_Passwords_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('users/(?P<user_id>(?:[\\d]+|me))/application-passwords'))
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/introspect', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_current_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_current_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<uuid>[\\w\\-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_app_passwords'), rt.get_property(var_user, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_list_application_passwords'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to list application passwords for this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_passwords := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.get_user_application_passwords(arg_0) }(rt.get_property(var_user, 'ID'))
	mut var_response := rt.new_array()
	{
		mut iter_1 := var_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_password := item_1.val
			var_response.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_password.dup(), var_request.dup())))
		}
	}
	return create_wp_rest_response(var_response.dup())
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_app_password'), rt.get_property(var_user, 'ID'), var_request.array_get('uuid')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_read_application_password'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to read this application password.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_password := this.get_application_password(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_password.dup()])) {
		return var_password.dup()
	}
	return this.prepare_item_for_response(var_password.dup(), var_request.dup())
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_app_password'), rt.get_property(var_user, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_create_application_passwords'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create application passwords for this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_prepared := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared.dup()])) {
		return var_prepared.dup()
	}
	mut var_created := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.create_new_application_password(arg_0, arg_1) }(rt.get_property(var_user, 'ID'), rt.call_function('wp_slash', [rt.cast_array(var_prepared)]))
	if rt.is_true(rt.call_function('is_wp_error', [var_created.dup()])) {
		return var_created.dup()
	}
	mut var_password := var_created.array_get(0)
	mut var_item := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.get_user_application_password(arg_0, arg_1) }(rt.get_property(var_user, 'ID'), var_created.array_get(1).array_get('uuid'))
	var_item.array_set('new_password', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.chunk_password(arg_0) }(var_password.dup()))
	mut var_fields_update := this.update_additional_fields_for_object(var_item.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	rt.call_function('do_action', [rt.new_string('rest_after_insert_application_password'), var_item.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_item.dup(), var_request.dup())
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_method(var_response, 'get_links', []rt.PhpVal{}).array_get('self').array_get(0).array_get('href')])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_app_password'), rt.get_property(var_user, 'ID'), var_request.array_get('uuid')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_edit_application_password'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this application password.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_item := this.get_application_password(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_item.dup()])) {
		return var_item.dup()
	}
	mut var_prepared := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared.dup()])) {
		return var_prepared.dup()
	}
	mut var_saved := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.update_application_password(arg_0, arg_1, arg_2) }(rt.get_property(var_user, 'ID'), var_item.array_get('uuid'), rt.call_function('wp_slash', [rt.cast_array(var_prepared)]))
	if rt.is_true(rt.call_function('is_wp_error', [var_saved.dup()])) {
		return var_saved.dup()
	}
	mut var_fields_update := this.update_additional_fields_for_object(var_item.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	var_item = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.get_user_application_password(arg_0, arg_1) }(rt.get_property(var_user, 'ID'), var_item.array_get('uuid'))
	rt.call_function('do_action', [rt.new_string('rest_after_insert_application_password'), var_item.dup(), var_request.dup(), rt.new_bool(false)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	return this.prepare_item_for_response(var_item.dup(), var_request.dup())
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_app_passwords'), rt.get_property(var_user, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_delete_application_passwords'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete application passwords for this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_deleted := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.delete_all_application_passwords(arg_0) }(rt.get_property(var_user, 'ID'))
	if rt.is_true(rt.call_function('is_wp_error', [var_deleted.dup()])) {
		return var_deleted.dup()
	}
	return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'deleted', val: true }, rt.ArrayItem{ key: 'count', val: var_deleted }]))
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_app_password'), rt.get_property(var_user, 'ID'), var_request.array_get('uuid')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_delete_application_password'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this application password.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_password := this.get_application_password(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_password.dup()])) {
		return var_password.dup()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_previous := this.prepare_item_for_response(var_password.dup(), var_request.dup())
	mut var_deleted := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.delete_application_password(arg_0, arg_1) }(rt.get_property(var_user, 'ID'), var_password.array_get('uuid'))
	if rt.is_true(rt.call_function('is_wp_error', [var_deleted.dup()])) {
		return var_deleted.dup()
	}
	return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'deleted', val: true }, rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data', []rt.PhpVal{}) }]))
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_current_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (create_wp_error(rt.new_string('rest_cannot_introspect_app_password_for_non_authenticated_user'), rt.call_function('__', [rt.new_string('The authenticated application password can only be introspected for the current user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_uuid := rt.call_function('rest_get_authenticated_app_password', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_uuid)))) {
		return create_wp_error(rt.new_string('rest_no_authenticated_app_password'), rt.call_function('__', [rt.new_string('Cannot introspect application password.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_password := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.get_user_application_password(arg_0, arg_1) }(rt.get_property(var_user, 'ID'), var_uuid.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_password)))) {
		return create_wp_error(rt.new_string('rest_application_password_not_found'), rt.call_function('__', [rt.new_string('Application password not found.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	return this.prepare_item_for_response(var_password.dup(), var_request.dup())
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) do_permissions_check(var_request rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.7.0')])
	mut var_user := this.get_user(.dup())
	if rt.is_true(rt.call_function('is_wp_error', [.dup()])) {
		return ().to_bool()
	}
	if rt.is_true() {
	}
	return 
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) prepare_links(mut var_user Class_WP_User, var_item rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	mut var_item_mutated := var_item
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_user(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_application_password(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_item_schema() rt.PhpVal {
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Application_Passwords {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_application_passwords_controller() &Class_WP_REST_Application_Passwords_Controller {
	mut obj := &Class_WP_REST_Application_Passwords_Controller{
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

fn create_wp_application_passwords() &Class_WP_Application_Passwords {
	mut obj := &Class_WP_Application_Passwords{
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

fn (mut this Class_WP_REST_Application_Passwords_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_items_permissions_check(dispatch_arg_0))
		}
		'delete_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_items(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'get_current_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_current_item_permissions_check(dispatch_arg_0))
		}
		'get_current_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_current_item(dispatch_arg_0)
		}
		'do_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.do_permissions_check(dispatch_arg_0))
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_User](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_user(dispatch_arg_0)
		}
		'get_application_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_application_password(dispatch_arg_0)
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

fn (this &Class_WP_REST_Application_Passwords_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Application_Passwords) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Application_Passwords) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Application_Passwords) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_application_passwords_controller_php() {
}
