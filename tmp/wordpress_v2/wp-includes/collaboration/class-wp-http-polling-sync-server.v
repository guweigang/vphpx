import rt

pub fn Class_WP_HTTP_Polling_Sync_Server.rest_namespace() string {
	return 'wp-sync/v1'
}
pub fn Class_WP_HTTP_Polling_Sync_Server.awareness_timeout() i64 {
	return 30
}
pub fn Class_WP_HTTP_Polling_Sync_Server.compaction_threshold() i64 {
	return 50
}
pub fn Class_WP_HTTP_Polling_Sync_Server.max_body_size() rt.PhpVal {
	return 16 * rt.get_constant('MB_IN_BYTES')
}
pub fn Class_WP_HTTP_Polling_Sync_Server.max_rooms_per_request() i64 {
	return 50
}
pub fn Class_WP_HTTP_Polling_Sync_Server.max_update_data_size() rt.PhpVal {
	return rt.get_constant('MB_IN_BYTES')
}
pub fn Class_WP_HTTP_Polling_Sync_Server.update_type_compaction() string {
	return 'compaction'
}
pub fn Class_WP_HTTP_Polling_Sync_Server.update_type_sync_step1() string {
	return 'sync_step1'
}
pub fn Class_WP_HTTP_Polling_Sync_Server.update_type_sync_step2() string {
	return 'sync_step2'
}
pub fn Class_WP_HTTP_Polling_Sync_Server.update_type_update() string {
	return 'update'
}
struct Class_WP_HTTP_Polling_Sync_Server {
	rt.PhpObjectBase
pub mut:
		storage rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) construct(mut var_storage Class_WP_Sync_Storage) {
	this.storage = var_storage
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) register_routes() {
	mut var_typed_update_args := { 'properties': { 'data': { 'type': rt.new_string('string'), 'required': rt.new_bool(true), 'maxLength': Class_WP_HTTP_Polling_Sync_Server.max_update_data_size() }, 'type': { 'type': rt.new_string('string'), 'required': rt.new_bool(true), 'enum': map[string]rt.PhpVal{} } }, 'required': rt.new_bool(true), 'type': rt.new_string('object') }
	mut var_room_args := { 'after': { 'minimum': rt.new_int(0), 'required': rt.new_bool(true), 'type': rt.new_string('integer') }, 'awareness': { 'required': rt.new_bool(true), 'type': map[string]rt.PhpVal{} }, 'client_id': { 'minimum': rt.new_int(1), 'required': rt.new_bool(true), 'type': rt.new_string('integer') }, 'room': { 'required': rt.new_bool(true), 'type': rt.new_string('string'), 'pattern': rt.new_string('^[^/]+/[^/:]+(?::\\S+)?$') }, 'updates': { 'items': var_typed_update_args, 'minItems': rt.new_int(0), 'required': rt.new_bool(true), 'type': rt.new_string('array') } }
	rt.call_function('register_rest_route', [rt.new_string(Class_WP_HTTP_Polling_Sync_Server.rest_namespace()), rt.new_string('/updates'), rt.create_array([rt.ArrayItem{ key: 'methods', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_REST_Server.creatable() }]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_HTTP_Polling_Sync_Server', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_request' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_HTTP_Polling_Sync_Server', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'check_permissions' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_HTTP_Polling_Sync_Server', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'validate_request' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'rooms', val: rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'properties', val: var_room_args }, rt.ArrayItem{ key: 'type', val: 'object' }]) }, rt.ArrayItem{ key: 'maxItems', val: Class_WP_HTTP_Polling_Sync_Server.max_rooms_per_request() }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'array' }]) }]) }])])
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) check_permissions(mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [rt.new_string('You do not have permission to perform this action')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_rooms := var_request.array_get(rt.new_string('rooms'))
	mut var_wp_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut iter_1 := var_rooms.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_room := item_1.val
		mut var_client_id := var_room.array_get(rt.new_string('client_id'))
		var_room = var_room.array_get(rt.new_string('room'))
		mut var_existing_awareness := rt.call_method(this.storage, 'get_awareness_state', [var_room.clone()])
		mut iter_2 := var_existing_awareness.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_entry := item_2.val
			if rt.is_true(rt.identical(var_client_id, var_entry.array_get(rt.new_string('client_id')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_wp_user_id, var_entry.array_get(rt.new_string('wp_user_id')))))) {
				return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [rt.new_string('Client ID is already in use by another user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
			}
		}
		mut var_type_parts := rt.call_function('explode', [rt.new_string('/'), var_room.clone(), rt.new_int(2)])
		mut var_object_parts := rt.call_function('explode', [rt.new_string(':'), if !(var_type_parts.array_get(rt.new_int(1))).is_null() { var_type_parts.array_get(rt.new_int(1)) } else { rt.new_string('') }, rt.new_int(2)])
		mut var_entity_kind := var_type_parts.array_get(rt.new_int(0))
		mut var_entity_name := var_object_parts.array_get(rt.new_int(0))
		mut var_object_id := if !(var_object_parts.array_get(rt.new_int(1))).is_null() { var_object_parts.array_get(rt.new_int(1)) } else { rt.new_null() }
		if !(this.can_user_sync_entity_type((var_entity_kind).str(), (var_entity_name).str(), mut rt.cast_object_ptr[Class_?string](var_object_id))) {
			return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You do not have permission to sync this entity: %s.')]), var_room.clone()]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) validate_request(mut var_request Class_WP_REST_Request) bool {
	mut var_body := var_request.get_body()
	if var_body.clone().is_string() && rt.is_true(rt.greater(rt.new_int(var_body.clone().to_string().len), Class_WP_HTTP_Polling_Sync_Server.max_body_size())) {
		return (create_wp_error(rt.new_string('rest_sync_body_too_large'), rt.call_function('__', [rt.new_string('Request body is too large.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 413 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) handle_request(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_rooms := var_request.array_get(rt.new_string('rooms'))
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'rooms', val: rt.new_array() }])
	mut iter_3 := var_rooms.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_room_request := item_3.val
		mut var_awareness := var_room_request.array_get(rt.new_string('awareness'))
		mut var_client_id := var_room_request.array_get(rt.new_string('client_id'))
		mut var_cursor := var_room_request.array_get(rt.new_string('after'))
		mut var_room := var_room_request.array_get(rt.new_string('room'))
		mut var_merged_awareness := this.process_awareness_update((var_room).str(), (var_client_id).to_i64(), mut rt.cast_object_ptr[Class_?array](var_awareness))
		mut var_is_compactor := rt.new_bool(false)
		if var_merged_awareness.clone().array_count() > 0 {
		var_is_compactor = rt.identical(rt.call_function('min', [rt.func_array_keys(var_merged_awareness.clone())]), var_client_id)
		}
		mut iter_4 := var_room_request.array_get(rt.new_string('updates')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_update := item_4.val
			mut var_result := this.process_sync_update((var_room).str(), (var_client_id).to_i64(), (var_cursor).to_i64(), mut rt.cast_object_ptr[Class_array](var_update))
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				return var_result.clone()
			}
		}
		mut var_room_response := this.get_updates((var_room).str(), (var_client_id).to_i64(), (var_cursor).to_i64(), (var_is_compactor).to_bool())
		var_room_response.array_set('awareness', var_merged_awareness.clone())
		var_response.array_get_mut('rooms').array_push(var_room_response.clone())
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response.clone(), rt.new_int(200)))
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) can_user_sync_entity_type(entity_kind string, entity_name string, mut var_object_id Class_?string) bool {
	mut entity_kind_mutated := entity_kind
	mut entity_name_mutated := entity_name
	mut var_object_id_mutated := var_object_id
	if rt.is_true(rt.new_bool(var_object_id_mutated.is_string())) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_digit', [var_object_id_mutated]))))) {
			return false
		}
	var_object_id_mutated = rt.new_int((var_object_id_mutated).to_i64())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_object_id_mutated)))) && rt.is_true(rt.less_equal(var_object_id_mutated, rt.new_int(0))) {
		return false
	}
	if rt.is_true(rt.new_bool(var_object_id_mutated.is_long())) {
		if rt.is_true(rt.identical(rt.new_string('postType'), rt.new_string(entity_kind_mutated))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_type', [var_object_id_mutated]), rt.new_string(entity_name_mutated))))) {
				return false
			}
			return (rt.call_function('current_user_can', [rt.new_string('edit_post'), var_object_id_mutated])).to_bool()
		}
		if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.new_string(entity_kind_mutated))) {
			mut var_term_exists := rt.call_function('term_exists', [var_object_id_mutated, rt.new_string(entity_name_mutated).clone()])
			if !(var_term_exists.clone().is_array()) || !(var_term_exists.array_isset(rt.new_string('term_id'))) {
				return false
			}
			return (rt.call_function('current_user_can', [rt.new_string('edit_term'), var_object_id_mutated])).to_bool()
		}
		if rt.is_true(rt.identical(rt.new_string('root'), rt.new_string(entity_kind_mutated))) && rt.is_true(rt.identical(rt.new_string('comment'), rt.new_string(entity_name_mutated))) {
			return (rt.call_function('current_user_can', [rt.new_string('edit_comment'), var_object_id_mutated])).to_bool()
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_object_id_mutated)))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('postType'), rt.new_string(entity_kind_mutated))) {
		mut var_post_type_object := rt.call_function('get_post_type_object', [rt.new_string(entity_name_mutated).clone()])
		if !(!(rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_posts')).is_null()) {
			return false
		}
		return (rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_posts')])).to_bool()
	}
	mut var_allowed_collection_entity_kinds := ['postType', 'root', 'taxonomy']
	return (rt.call_function('in_array', [rt.new_string(entity_kind_mutated).clone(), rt.create_array_from_list(var_allowed_collection_entity_kinds), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) process_awareness_update(room string, client_id i64, mut var_awareness_update Class_?array) rt.PhpVal {
	mut room_mutated := room
	mut client_id_mutated := client_id
	mut var_existing_awareness := rt.call_method(this.storage, 'get_awareness_state', [rt.new_string(room_mutated).clone()])
	mut var_updated_awareness := rt.new_array()
	mut var_current_time := rt.call_function('time', []rt.PhpVal{})
	mut iter_5 := var_existing_awareness.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_entry := item_5.val
		if rt.is_true(rt.identical(rt.new_int(client_id_mutated), var_entry.array_get(rt.new_string('client_id')))) {
			continue
		}
		if rt.is_true(rt.greater_equal(rt.sub(var_current_time, var_entry.array_get(rt.new_string('updated_at'))), Class_WP_HTTP_Polling_Sync_Server.awareness_timeout())) {
			continue
		}
		var_updated_awareness << var_entry.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_awareness_update)))) {
		var_updated_awareness << rt.create_array([rt.ArrayItem{ key: 'client_id', val: client_id_mutated }, rt.ArrayItem{ key: 'state', val: var_awareness_update }, rt.ArrayItem{ key: 'updated_at', val: var_current_time }, rt.ArrayItem{ key: 'wp_user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }])
	}
	rt.call_method(this.storage, 'set_awareness_state', [rt.new_string(room_mutated).clone(), rt.create_array_from_list(var_updated_awareness)])
	mut var_response := rt.new_array()
	for var_entry in var_updated_awareness {
		var_response.array_set(var_entry.array_get(rt.new_string('client_id')), var_entry.array_get(rt.new_string('state')))
	}
	return var_response.clone()
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) process_sync_update(room string, client_id i64, cursor i64, mut var_update Class_array) rt.PhpVal {
	mut room_mutated := room
	mut client_id_mutated := client_id
	mut cursor_mutated := cursor
	mut var_update_mutated := var_update
	mut var_data := var_update_mutated.array_get(rt.new_string('data'))
	mut var_type := var_update_mutated.array_get(rt.new_string('type'))
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, Class_WP_HTTP_Polling_Sync_Server.update_type_compaction())) {
		mut var_updates_after_cursor := rt.call_method(this.storage, 'get_updates_after_cursor', [rt.new_string(room_mutated).clone(), rt.new_int(cursor_mutated).clone()])
		mut var_has_newer_compaction := rt.new_bool(false)
		mut iter_6 := var_updates_after_cursor.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_existing := item_6.val
			if rt.is_true(rt.identical(Class_WP_HTTP_Polling_Sync_Server.update_type_compaction(), var_existing.array_get(rt.new_string('type')))) {
			var_has_newer_compaction = rt.new_bool(true)
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_has_newer_compaction)))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.storage, 'remove_updates_before_cursor', [rt.new_string(room_mutated).clone(), rt.new_int(cursor_mutated).clone()]))))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_sync_storage_error'), rt.call_function('__', [rt.new_string('Failed to remove updates during compaction.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
			}
			return rt.new_bool(this.add_update(room_mutated, client_id_mutated, (var_type).str(), (var_data).str()))
		}
		return rt.new_bool(this.add_update(room_mutated, client_id_mutated, Class_WP_HTTP_Polling_Sync_Server.update_type_update(), (var_data).str()))
	} else if rt.is_true(rt.equal(switch_val_1, Class_WP_HTTP_Polling_Sync_Server.update_type_sync_step1())) || rt.is_true(rt.equal(switch_val_1, Class_WP_HTTP_Polling_Sync_Server.update_type_sync_step2())) || rt.is_true(rt.equal(switch_val_1, Class_WP_HTTP_Polling_Sync_Server.update_type_update())) {
		return rt.new_bool(this.add_update(room_mutated, client_id_mutated, (var_type).str(), (var_data).str()))
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_update_type'), rt.call_function('__', [rt.new_string('Invalid sync update type.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) add_update(room string, client_id i64, type string, data string) bool {
	mut room_mutated := room
	mut client_id_mutated := client_id
	mut type_mutated := type
	mut data_mutated := data
	mut var_update := { 'client_id': rt.new_int(client_id_mutated), 'data': rt.new_string(data_mutated), 'type': rt.new_string(type_mutated) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.storage, 'add_update', [rt.new_string(room_mutated).clone(), rt.create_array_from_native_map(var_update)]))))) {
		return (create_wp_error(rt.new_string('rest_sync_storage_error'), rt.call_function('__', [rt.new_string('Failed to store sync update.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) get_updates(room string, client_id i64, cursor i64, is_compactor bool) rt.PhpVal {
	mut room_mutated := room
	mut client_id_mutated := client_id
	mut cursor_mutated := cursor
	mut is_compactor_mutated := is_compactor
	mut var_updates_after_cursor := rt.call_method(this.storage, 'get_updates_after_cursor', [rt.new_string(room_mutated).clone(), rt.new_int(cursor_mutated).clone()])
	mut var_total_updates := rt.call_method(this.storage, 'get_update_count', [rt.new_string(room_mutated).clone()])
	mut var_typed_updates := rt.new_array()
	mut iter_7 := var_updates_after_cursor.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_update := item_7.val
		if rt.is_true(rt.identical(rt.new_int(client_id_mutated), var_update.array_get(rt.new_string('client_id')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTTP_Polling_Sync_Server.update_type_compaction(), var_update.array_get(rt.new_string('type')))))) {
			continue
		}
		var_typed_updates << rt.create_array([rt.ArrayItem{ key: 'data', val: var_update.array_get(rt.new_string('data')) }, rt.ArrayItem{ key: 'type', val: var_update.array_get(rt.new_string('type')) }])
	}
	mut var_should_compact := rt.new_bool(rt.is_true(rt.new_bool(is_compactor_mutated)) && rt.is_true(rt.greater(var_total_updates, Class_WP_HTTP_Polling_Sync_Server.compaction_threshold())))
	return rt.create_array([rt.ArrayItem{ key: 'end_cursor', val: rt.call_method(this.storage, 'get_cursor', [rt.new_string(room_mutated).clone()]) }, rt.ArrayItem{ key: 'room', val: room_mutated }, rt.ArrayItem{ key: 'should_compact', val: var_should_compact }, rt.ArrayItem{ key: 'total_updates', val: var_total_updates }, rt.ArrayItem{ key: 'updates', val: var_typed_updates }])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_http_polling_sync_server(arg_0 rt.PhpVal) &Class_WP_HTTP_Polling_Sync_Server {
	mut obj := &Class_WP_HTTP_Polling_Sync_Server{
		PhpObjectBase: rt.PhpObjectBase{}
		storage: rt.new_null()
	}
	obj.construct(arg_0)
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

fn (mut this Class_WP_HTTP_Polling_Sync_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Sync_Storage](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'check_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.check_permissions(mut dispatch_arg_0))
		}
		'validate_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate_request(mut dispatch_arg_0))
		}
		'handle_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_request(mut dispatch_arg_0)
		}
		'can_user_sync_entity_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.can_user_sync_entity_type(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'process_awareness_update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.process_awareness_update(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'process_sync_update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.process_sync_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'add_update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_bool(this.add_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_updates' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_updates(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_WP_HTTP_Polling_Sync_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'storage' { return this.storage }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTTP_Polling_Sync_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'storage' { this.storage = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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
