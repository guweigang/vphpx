import rt

struct Class_WP_REST_Application_Passwords_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base',
		rt.new_string('users/(?P<user_id>(?:[\\d]+|me))/application-passwords'))
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/introspect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_current_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_current_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<uuid>[\\w\\-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
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
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Application_Passwords_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('list_app_passwords'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_list_application_passwords'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to list application passwords for this user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut iife_temp_0 := Class_WP_Application_Passwords{}
	mut iife_result_0 := iife_temp_0.get_user_application_passwords(rt.get_property(var_user, 'ID'))
	mut var_passwords := iife_result_0
	mut var_response := rt.new_array()
	mut iter_1 := var_passwords.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_password := item_1.val
		var_response.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_password.clone(),
			var_request.clone())))
	}
	return rt.new_object('WP_REST_Response', []string{},
		create_wp_rest_response(var_response.clone()))
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('read_app_password'),
		rt.get_property(var_user, 'ID'),
		var_request.array_get(rt.new_string('uuid')),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_read_application_password'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to read this application password.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_password := this.get_application_password(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_password.clone()])) {
		return var_password.clone()
	}
	return this.prepare_item_for_response(var_password.clone(), var_request.clone())
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('create_app_password'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_create_application_passwords'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create application passwords for this user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut var_prepared := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared.clone()])) {
		return var_prepared.clone()
	}
	mut iife_temp_1 := Class_WP_Application_Passwords{}
	mut iife_result_1 := iife_temp_1.create_new_application_password(rt.get_property(var_user, 'ID'), rt.call_function('wp_slash', [
		rt.cast_array(var_prepared),
	]))
	mut var_created := iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_created.clone()])) {
		return var_created.clone()
	}
	mut var_password := var_created.array_get(rt.new_int(0))
	mut iife_temp_2 := Class_WP_Application_Passwords{}
	mut iife_result_2 := iife_temp_2.get_user_application_password(rt.get_property(var_user, 'ID'),
		var_created.array_get(rt.new_int(1)).array_get(rt.new_string('uuid')))
	mut var_item := iife_result_2
	mut iife_temp_3 := Class_WP_Application_Passwords{}
	mut iife_result_3 := iife_temp_3.chunk_password(var_password.clone())
	var_item.array_set('new_password', iife_result_3)
	mut var_fields_update := this.update_additional_fields_for_object(var_item.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_function('do_action', [
		rt.new_string('rest_after_insert_application_password'),
		var_item.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_item.clone(), var_request.clone())
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_method(var_response, 'get_links', []rt.PhpVal{}).array_get(rt.new_string('self')).array_get(rt.new_int(0)).array_get(rt.new_string('href'))])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_app_password'),
		rt.get_property(var_user, 'ID'),
		var_request.array_get(rt.new_string('uuid')),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_edit_application_password'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this application password.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut var_item := this.get_application_password(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_item.clone()])) {
		return var_item.clone()
	}
	mut var_prepared := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared.clone()])) {
		return var_prepared.clone()
	}
	mut iife_temp_4 := Class_WP_Application_Passwords{}
	mut iife_result_4 := iife_temp_4.update_application_password(rt.get_property(var_user, 'ID'),
		var_item.array_get(rt.new_string('uuid')), rt.call_function('wp_slash', [
		rt.cast_array(var_prepared),
	]))
	mut var_saved := iife_result_4
	if rt.is_true(rt.call_function('is_wp_error', [var_saved.clone()])) {
		return var_saved.clone()
	}
	mut var_fields_update := this.update_additional_fields_for_object(var_item.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	mut iife_temp_5 := Class_WP_Application_Passwords{}
	mut iife_result_5 := iife_temp_5.get_user_application_password(rt.get_property(var_user, 'ID'),
		var_item.array_get(rt.new_string('uuid')))
	var_item = iife_result_5
	rt.call_function('do_action', [
		rt.new_string('rest_after_insert_application_password'),
		var_item.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	return this.prepare_item_for_response(var_item.clone(), var_request.clone())
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_app_passwords'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_delete_application_passwords'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete application passwords for this user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut iife_temp_6 := Class_WP_Application_Passwords{}
	mut iife_result_6 :=
		iife_temp_6.delete_all_application_passwords(rt.get_property(var_user, 'ID'))
	mut var_deleted := iife_result_6
	if rt.is_true(rt.call_function('is_wp_error', [var_deleted.clone()])) {
		return var_deleted.clone()
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'deleted', val: true },
		rt.ArrayItem{ key: 'count', val: var_deleted },
	])))
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_app_password'),
		rt.get_property(var_user, 'ID'),
		var_request.array_get(rt.new_string('uuid')),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_delete_application_password'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this application password.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut var_password := this.get_application_password(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_password.clone()])) {
		return var_password.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_previous := this.prepare_item_for_response(var_password.clone(), var_request.clone())
	mut iife_temp_7 := Class_WP_Application_Passwords{}
	mut iife_result_7 := iife_temp_7.delete_application_password(rt.get_property(var_user, 'ID'),
		var_password.array_get(rt.new_string('uuid')))
	mut var_deleted := iife_result_7
	if rt.is_true(rt.call_function('is_wp_error', [var_deleted.clone()])) {
		return var_deleted.clone()
	}
	return create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'deleted', val: true },
		rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data', []rt.PhpVal{}) },
	]))
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_current_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id',
		[]rt.PhpVal{}), rt.get_property(var_user, 'ID')))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_introspect_app_password_for_non_authenticated_user'), rt.call_function('__', [
			rt.new_string('The authenticated application password can only be introspected for the current user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut var_uuid := rt.call_function('rest_get_authenticated_app_password', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_uuid)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_no_authenticated_app_password'), rt.call_function('__', [
			rt.new_string('Cannot introspect application password.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut iife_temp_8 := Class_WP_Application_Passwords{}
	mut iife_result_8 := iife_temp_8.get_user_application_password(rt.get_property(var_user, 'ID'),
		var_uuid.clone())
	mut var_password := iife_result_8
	if rt.is_true(rt.new_bool(!(rt.is_true(var_password)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_application_password_not_found'), rt.call_function('__', [
			rt.new_string('Application password not found.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	return this.prepare_item_for_response(var_password.clone(), var_request.clone())
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) do_permissions_check(var_request rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('5.7.0')])
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_user'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_manage_application_passwords'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to manage application passwords for this user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'name', val: var_request.array_get(rt.new_string('name')) },
	]))
	if rt.is_true(var_request.array_get(rt.new_string('app_id')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_request.array_get(rt.new_string('uuid')))))) {
		rt.set_property(var_prepared, 'app_id', var_request.array_get(rt.new_string('app_id')))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('rest_pre_insert_application_password'),
		var_prepared.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_prepared := rt.create_array([
		rt.ArrayItem{ key: 'uuid', val: var_item_mutated.array_get(rt.new_string('uuid')) },
		rt.ArrayItem{
			key: 'app_id'
			val: if !rt.is_true(var_item_mutated.array_get(rt.new_string('app_id'))) {
				rt.new_string('')
			} else {
				var_item_mutated.array_get(rt.new_string('app_id'))
			}
		},
		rt.ArrayItem{ key: 'name', val: var_item_mutated.array_get(rt.new_string('name')) },
		rt.ArrayItem{ key: 'created', val: rt.call_function('gmdate', [
			rt.new_string('Y-m-d\\TH:i:s'),
			var_item_mutated.array_get(rt.new_string('created')),
		]) },
		rt.ArrayItem{
			key: 'last_used'
			val: if rt.is_true(var_item_mutated.array_get(rt.new_string('last_used'))) { rt.call_function('gmdate', [
					rt.new_string('Y-m-d\\TH:i:s'),
					var_item_mutated.array_get(rt.new_string('last_used')),
				]) } else { rt.new_null() }
		},
		rt.ArrayItem{
			key: 'last_ip'
			val: if rt.is_true(var_item_mutated.array_get(rt.new_string('last_ip'))) {
				var_item_mutated.array_get(rt.new_string('last_ip'))
			} else {
				rt.new_null()
			}
		},
	])
	if var_item_mutated.array_isset(rt.new_string('new_password')) {
		var_prepared.array_set('password',
			var_item_mutated.array_get(rt.new_string('new_password')))
	}
	var_prepared = this.add_additional_fields_to_object(var_prepared.clone(), var_request.clone())
	var_prepared = this.filter_response_by_context(var_prepared.clone(),
		var_request.array_get(rt.new_string('context')))
	mut var_response := create_wp_rest_response(var_prepared.clone())
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [
			this.prepare_links(mut rt.cast_object_ptr[Class_WP_User](var_user),
				var_item_mutated.clone()),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('rest_prepare_application_password'),
		var_response.clone(),
		var_item_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) prepare_links(mut var_user Class_WP_User, var_item rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	mut var_item_mutated := var_item
	return rt.create_array([
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [
					rt.new_string('%s/users/%d/application-passwords/%s'),
					rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(var_user_mutated, 'ID'),
					var_item_mutated.array_get(rt.new_string('uuid')),
				]),
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_user(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_application_passwords_available',
		[]rt.PhpVal{})))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('application_passwords_disabled'), rt.call_function('__', [
			rt.new_string('Application passwords are not available.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	mut var_error := create_wp_error(rt.new_string('rest_user_invalid_id'), rt.call_function('__', [
		rt.new_string('Invalid user ID.'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	mut var_id := var_request.array_get(rt.new_string('user_id'))
	if rt.is_true(rt.identical(rt.new_string('me'), var_id)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_not_logged_in'), rt.call_function('__', [
				rt.new_string('You are not currently logged in.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }])))
		}
		mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	} else {
		var_id = rt.new_int(var_id.to_i64())
		if rt.is_true(rt.less_equal(var_id, rt.new_int(0))) {
			return mut var_error
		}
		var_user = rt.call_function('get_userdata', [var_id.clone()])
	}
	if !rt.is_true(var_user)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return mut var_error
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('user_can', [rt.get_property(var_user, 'ID'), rt.new_string('manage_sites')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [rt.get_property(var_user, 'ID')]))))) {
		return mut var_error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_application_passwords_available_for_user', [
		var_user.clone(),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('application_passwords_disabled_for_user'), rt.call_function('__', [
			rt.new_string('Application passwords are not available for your account. Please contact the site administrator for assistance.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_user)
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_application_password(var_request rt.PhpVal) rt.PhpVal {
	mut var_user := this.get_user(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut iife_temp_9 := Class_WP_Application_Passwords{}
	mut iife_result_9 := iife_temp_9.get_user_application_password(rt.get_property(var_user, 'ID'),
		var_request.array_get(rt.new_string('uuid')))
	mut var_password := iife_result_9
	if rt.is_true(rt.new_bool(!(rt.is_true(var_password)))) {
		return create_wp_error(rt.new_string('rest_application_password_not_found'), rt.call_function('__', [
			rt.new_string('Application password not found.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return var_password.clone()
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	this.dispatch_set_prop('schema', rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'application-password' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'uuid', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The unique identifier for the application password.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uuid' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'app_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('A UUID provided by the application to uniquely identify it. It is recommended to use an UUID v5 with the URL or DNS namespace.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'oneOf', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'format', val: 'uuid' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{ key: none, val: '' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The name of the application password.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'minLength', val: 1 },
				rt.ArrayItem{ key: 'pattern', val: '.*\\S.*' },
			]) },
			rt.ArrayItem{ key: 'password', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The generated password. Only available after adding an application.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'created', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The GMT date the application password was created.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'last_used', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The GMT date the application password was last used.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'format', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'last_ip', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The IP address the application password was last used by.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'format', val: 'ip' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Application_Passwords_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
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

fn create_wp_application_passwords(_args ...rt.PhpVal) &Class_WP_Application_Passwords {
	mut obj := &Class_WP_Application_Passwords{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_User](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
