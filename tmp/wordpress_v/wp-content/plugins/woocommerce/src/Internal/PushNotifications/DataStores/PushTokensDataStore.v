import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore.supported_meta() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'origin' }, rt.ArrayItem{ key: none, val: 'device_uuid' }, rt.ArrayItem{ key: none, val: 'token' }, rt.ArrayItem{ key: none, val: 'platform' }, rt.ArrayItem{ key: none, val: 'device_locale' }, rt.ArrayItem{ key: none, val: 'metadata' }])
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore {
	rt.PhpObjectBase
pub mut:
		tokens_by_roles_cache rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) create(mut var_data Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_array) rt.PhpVal {
	mut var_push_token := create_automattic_woocommerce_internal_pushnotifications_entities_pushtoken(var_data.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_push_token.can_be_created())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.new_string('Can\'t create push token because the push token data provided is invalid.'))))
	}
	mut var_id := rt.call_function('wp_insert_post', [rt.create_array([rt.ArrayItem{ key: 'post_author', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.post_type() }, rt.ArrayItem{ key: 'post_status', val: 'private' }, rt.ArrayItem{ key: 'meta_input', val: this.build_meta_array_from_token(mut var_push_token) }]), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_id.dup()])) {
		rt.throw_exception(rt.new_object('WC_Data_Exception', []string{}, create_wc_data_exception(// unsupported expression: Expr_Cast_String, rt.call_method(var_id, 'get_error_message', []rt.PhpVal{}), Class_WP_Http.internal_server_error())))
		// unsupported statement: Stmt_Nop
	}
	var_push_token.set_id(var_id.dup())
	return mut var_push_token
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) read(id i64) rt.PhpVal {
	mut id_mutated := id
	mut var_push_token := create_automattic_woocommerce_internal_pushnotifications_entities_pushtoken(rt.create_array([rt.ArrayItem{ key: 'id', val: id_mutated }]))
	mut var_post := rt.call_function('get_post', [var_push_token.get_id()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokennotfoundexception()))
	}
	mut var_meta := this.build_meta_array_from_database((// unsupported expression: Expr_Cast_Int).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(var_meta.array_get('token')) || !rt.is_true(var_meta.array_get('platform')) || !rt.is_true(var_meta.array_get('origin')) || rt.is_true(rt.new_bool(!rt.is_true(var_meta.array_get('device_uuid')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.new_string('Can\'t read push token because the push token record is malformed.'))))
	}
	var_push_token.set_user_id(// unsupported expression: Expr_Cast_Int)
	var_push_token.set_token(var_meta.array_get('token'))
	var_push_token.set_device_uuid(if !(var_meta.array_get('device_uuid')).is_null() { var_meta.array_get('device_uuid') } else { rt.new_null() })
	var_push_token.set_platform(var_meta.array_get('platform'))
	var_push_token.set_origin(var_meta.array_get('origin'))
	var_push_token.set_device_locale(if !(var_meta.array_get('device_locale')).is_null() { var_meta.array_get('device_locale') } else { Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.default_device_locale() })
	var_push_token.set_metadata(if !(var_meta.array_get('metadata')).is_null() { var_meta.array_get('metadata') } else { rt.new_array() })
	return mut var_push_token
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) update(mut var_push_token Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) bool {
	mut var_push_token_mutated := var_push_token
	if rt.is_true(rt.new_bool(!(rt.is_true(var_push_token_mutated.can_be_updated())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.new_string('Can\'t update push token because the push token data provided is invalid.'))))
	}
	mut var_result := rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'post_author', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.post_type() }, rt.ArrayItem{ key: 'post_status', val: 'private' }, rt.ArrayItem{ key: 'meta_input', val: this.build_meta_array_from_token(mut var_push_token_mutated) }]), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.throw_exception(rt.new_object('WC_Data_Exception', []string{}, create_wc_data_exception(// unsupported expression: Expr_Cast_String, rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}), Class_WP_Http.internal_server_error())))
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.identical(rt.new_null(), var_push_token_mutated.get_device_uuid())) {
		rt.call_function('delete_post_meta', [// unsupported expression: Expr_Cast_Int, rt.new_string('device_uuid')])
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) delete(id i64) bool {
	mut id_mutated := id
	mut var_post := rt.call_function('get_post', [rt.new_int(id_mutated).dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokennotfoundexception()))
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) get_by_token_or_device_id(mut var_data Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_array) rt.PhpVal {
	mut var_user_id := if !(var_data.array_get('user_id')).is_null() { var_data.array_get('user_id') } else { rt.new_null() }
	mut var_platform := if !(var_data.array_get('platform')).is_null() { var_data.array_get('platform') } else { rt.new_null() }
	mut var_origin := if !(var_data.array_get('origin')).is_null() { var_data.array_get('origin') } else { rt.new_null() }
	mut var_token := if !(var_data.array_get('token')).is_null() { var_data.array_get('token') } else { rt.new_null() }
	mut var_device_uuid := if !(var_data.array_get('device_uuid')).is_null() { var_data.array_get('device_uuid') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_platform)))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_origin)))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(var_token)))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_device_uuid)))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platform_browser(), var_platform)) && rt.is_true(rt.new_bool(!(rt.is_true(var_token)))))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception(rt.new_string('Can\'t retrieve push token because the push token data provided is invalid.'))))
	}
	mut var_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.post_type() }, rt.ArrayItem{ key: 'post_status', val: 'private' }, rt.ArrayItem{ key: 'author', val: var_user_id }, rt.ArrayItem{ key: 'posts_per_page', val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: 'orderby', val: 'ID' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'fields', val: 'ids' }]))
	mut var_post_ids := rt.get_property(var_query, 'posts')
	if !rt.is_true(var_post_ids) {
		return rt.new_null()
	}
	rt.call_function('update_meta_cache', [rt.new_string('post'), var_post_ids.dup()])
	{
		mut iter_1 := var_post_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_id := item_1.val
			mut var_meta := this.build_meta_array_from_database((var_post_id).to_i64())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_e := var_e_1.dup()
				rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string('Failed to load meta for push token.'), rt.create_array([rt.ArrayItem{ key: 'token_id', val: var_post_id }, rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
				continue
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_meta.array_get('platform'), var_platform)) && rt.is_true(rt.identical(var_meta.array_get('origin'), var_origin)))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_token) && rt.is_true(rt.identical(var_token, var_meta.array_get('token'))))) || rt.is_true(rt.new_bool(rt.is_true(var_device_uuid) && rt.is_true(rt.identical(var_device_uuid, var_meta.array_get('device_uuid'))))))))) {
				return create_automattic_woocommerce_internal_pushnotifications_entities_pushtoken(rt.create_array([rt.ArrayItem{ key: 'id', val: var_post_id }, rt.ArrayItem{ key: 'user_id', val: var_user_id }, rt.ArrayItem{ key: 'token', val: var_meta.array_get('token') }, rt.ArrayItem{ key: 'device_uuid', val: if !(var_meta.array_get('device_uuid')).is_null() { var_meta.array_get('device_uuid') } else { rt.new_null() } }, rt.ArrayItem{ key: 'platform', val: var_meta.array_get('platform') }, rt.ArrayItem{ key: 'origin', val: var_meta.array_get('origin') }, rt.ArrayItem{ key: 'device_locale', val: if !(var_meta.array_get('device_locale')).is_null() { var_meta.array_get('device_locale') } else { Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.default_device_locale() } }, rt.ArrayItem{ key: 'metadata', val: if !(var_meta.array_get('metadata')).is_null() { var_meta.array_get('metadata') } else { rt.new_array() } }]))
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) get_tokens_for_roles(mut var_roles Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_array, mut var_page Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_?int, mut var_per_page Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_?int) rt.PhpVal {
	mut var_paginate := rt.new_bool(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	mut var_cache_key := if rt.is_true(var_paginate) { (rt.call_function('implode', [rt.new_string(','), var_roles])).str() + ":${var_page.to_string()}:${var_per_page.to_string()}" } else { rt.call_function('implode', [rt.new_string(','), var_roles]) }
	mut var_empty_result := if rt.is_true(var_paginate) { rt.create_array([rt.ArrayItem{ key: 'tokens', val: rt.new_array() }, rt.ArrayItem{ key: 'total', val: 0 }, rt.ArrayItem{ key: 'total_pages', val: 0 }]) } else { rt.new_array() }
	if !rt.is_true(var_roles) {
		return var_empty_result.dup()
	}
	if this.tokens_by_roles_cache.array_isset(var_cache_key) {
		return this.tokens_by_roles_cache.array_get(var_cache_key)
	}
	mut var_user_ids := rt.call_function('get_users', [rt.create_array([rt.ArrayItem{ key: 'role__in', val: var_roles }, rt.ArrayItem{ key: 'fields', val: 'ID' }])])
	if !rt.is_true(var_user_ids) {
		this.tokens_by_roles_cache.array_set(var_cache_key, var_empty_result.dup())
		return this.tokens_by_roles_cache.array_get(var_cache_key)
	}
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.post_type() }, rt.ArrayItem{ key: 'post_status', val: 'private' }, rt.ArrayItem{ key: 'author__in', val: var_user_ids }, rt.ArrayItem{ key: 'posts_per_page', val: if rt.is_true(var_paginate) { var_per_page } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'fields', val: 'ids' }])
	if rt.is_true(var_paginate) {
		var_query_args.array_set('paged', var_page.dup())
		var_query_args.array_set('orderby', 'ID')
		var_query_args.array_set('order', 'ASC')
	}
	mut var_query := create_wp_query(var_query_args.dup())
	mut var_post_ids := rt.get_property(var_query, 'posts')
	if !rt.is_true(var_post_ids) {
		this.tokens_by_roles_cache.array_set(var_cache_key, var_empty_result.dup())
		return this.tokens_by_roles_cache.array_get(var_cache_key)
	}
	rt.call_function('update_meta_cache', [rt.new_string('post'), var_post_ids.dup()])
	mut var_tokens := rt.new_array()
	{
		mut iter_1 := var_post_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_id := item_1.val
			var_tokens.array_push(this.read((// unsupported expression: Expr_Cast_Int).to_i64()))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'WC_Data_Exception') {
				mut var_e := var_e_2.dup()
				rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string('Skipping malformed push token during role-based query.'), rt.create_array([rt.ArrayItem{ key: 'token_id', val: var_post_id }, rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
		}
	}
	mut var_result := if rt.is_true(var_paginate) { rt.create_array([rt.ArrayItem{ key: 'tokens', val: var_tokens }, rt.ArrayItem{ key: 'total', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'total_pages', val: // unsupported expression: Expr_Cast_Int }]) } else { var_tokens }
	this.tokens_by_roles_cache.array_set(var_cache_key, var_result.dup())
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) build_meta_array_from_database(id i64) rt.PhpVal {
	mut id_mutated := id
	mut var_meta_by_key := rt.call_function('array_fill_keys', [Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_static.supported_meta(), rt.new_null()])
	{
		mut iter_1 := Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_static.supported_meta().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			mut var_meta := rt.call_function('get_post_meta', [rt.new_int(id_mutated).dup(), var_key.dup(), rt.new_bool(true)])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_meta_by_key.array_set(var_key, var_meta.dup())
			}
		}
	}
	return var_meta_by_key.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) build_meta_array_from_token(mut var_push_token Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) rt.PhpVal {
	mut var_value := rt.new_null()
	mut var_push_token_mutated := var_push_token
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))
	}
	return rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'platform', val: var_push_token_mutated.get_platform() }, rt.ArrayItem{ key: 'token', val: var_push_token_mutated.get_token() }, rt.ArrayItem{ key: 'device_uuid', val: var_push_token_mutated.get_device_uuid() }, rt.ArrayItem{ key: 'origin', val: var_push_token_mutated.get_origin() }, rt.ArrayItem{ key: 'device_locale', val: var_push_token_mutated.get_device_locale() }, rt.ArrayItem{ key: 'metadata', val: var_push_token_mutated.get_metadata() }]), rt.new_closure(closure_1_fn)])
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException {
	rt.PhpObjectBase
}

struct Class_WC_Data_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_datastores_pushtokensdatastore() &Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		tokens_by_roles_cache: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_entities_pushtoken() &Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokeninvaliddataexception() &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_exception() &Class_WC_Data_Exception {
	mut obj := &Class_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokennotfoundexception() &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create(mut dispatch_arg_0)
		}
		'read' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.read(dispatch_arg_0)
		}
		'update' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.update(mut dispatch_arg_0))
		}
		'delete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.delete(dispatch_arg_0))
		}
		'get_by_token_or_device_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_by_token_or_device_id(mut dispatch_arg_0)
		}
		'get_tokens_for_roles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_tokens_for_roles(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'build_meta_array_from_database' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.build_meta_array_from_database(dispatch_arg_0)
		}
		'build_meta_array_from_token' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_meta_array_from_token(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tokens_by_roles_cache' { return this.tokens_by_roles_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tokens_by_roles_cache' { this.tokens_by_roles_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenInvalidDataException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_pushnotifications_datastores_pushtokensdatastore_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
