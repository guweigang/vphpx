import rt

struct Class_Automattic_WooCommerce_Admin_API_Notes {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
		rest_base rt.PhpVal = rt.new_string('admin/notes')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d-]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique ID for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/delete/(?P<id>[\\d-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/delete/all', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_all_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Status of note.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Note{}; return temp.get_allowed_statuses() }() }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/update', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_update_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/experimental-activate-promo/(?P<promo_note_name>[\\w-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'activate_promo_note' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', ['Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_note := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_note(arg_0) }(rt.call_method(var_request, 'get_param', [rt.new_string('id')]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_id'), rt.call_function('__', [rt.new_string('Sorry, there is no resource with that ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_note.dup()])) {
		return var_note.dup()
	}
	mut var_data := this.prepare_note_data_for_response(var_note.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.dup())
	mut var_notes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_notes(arg_0, arg_1) }(rt.new_string('edit'), var_query_args.dup())
	mut var_data := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_notes).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_obj := item_1.val
			mut var_note := this.prepare_item_for_response(var_note_obj.dup(), var_request.dup())
			var_note = this.prepare_response_for_collection(var_note.dup())
			var_data.array_push(var_note.dup())
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), rt.new_int(var_data.dup().array_count())])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) is_tasklist_experiment_assigned_treatment() bool {
	mut var_anon_id := if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').array_get('tk_ai')])]) } else { rt.new_string('') }
	mut var_allow_tracking := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking')]))
	mut var_abtest := create_automattic_woocommerce_admin_api_woocommerce_admin_experimental_abtest(var_anon_id.dup(), rt.new_string('woocommerce'), var_allow_tracking.dup())
	mut var_date := create_automattic_woocommerce_admin_api_datetime()
	var_date.settimezone(create_automattic_woocommerce_admin_api_datetimezone(rt.new_string('UTC')))
	mut var_experiment_name := rt.call_function('sprintf', [rt.new_string('woocommerce_tasklist_progression_headercard_%s_%s'), var_date.format(rt.new_string('Y')), var_date.format(rt.new_string('m'))])
	mut var_experiment_name_2col := rt.call_function('sprintf', [rt.new_string('woocommerce_tasklist_progression_headercard_2col_%s_%s'), var_date.format(rt.new_string('Y')), var_date.format(rt.new_string('m'))])
	return rt.is_true(rt.identical(var_abtest.get_variation(var_experiment_name.dup()), rt.new_string('treatment'))) || rt.is_true(rt.identical(var_abtest.get_variation(var_experiment_name_2col.dup()), rt.new_string('treatment')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('per_page', var_request.array_get('per_page'))
	var_args.array_set('page', var_request.array_get('page'))
	var_args.array_set('type', if var_request.array_isset(rt.new_string('type')) { var_request.array_get('type') } else { rt.new_array() })
	var_args.array_set('status', if var_request.array_isset(rt.new_string('status')) { var_request.array_get('status') } else { rt.new_array() })
	var_args.array_set('source', if var_request.array_isset(rt.new_string('source')) { var_request.array_get('source') } else { rt.new_array() })
	var_args.array_set('is_deleted', 0)
	if var_request.array_isset(rt.new_string('is_read')) {
		var_args.array_set('is_read', rt.call_function('filter_var', [var_request.array_get('is_read'), rt.get_constant('FILTER_VALIDATE_BOOLEAN')]))
	}
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'date_created')
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_notes_object_query'), var_args.dup(), var_request.dup()])
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('system_status'), rt.new_string('read')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('system_status'), rt.new_string('read')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_note := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_note(arg_0) }(rt.call_method(var_request, 'get_param', [rt.new_string('id')]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_id'), rt.call_function('__', [rt.new_string('Sorry, there is no resource with that ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.update_note(arg_0, arg_1) }(var_note.dup(), this.get_requested_updates(var_request.dup()))
	return this.get_item(var_request.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_note := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_note(arg_0) }(rt.call_method(var_request, 'get_param', [rt.new_string('id')]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_id'), rt.call_function('__', [rt.new_string('Sorry, there is no note with that ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.delete_note(arg_0) }(var_note.dup())
	mut var_data := this.prepare_note_data_for_response(var_note.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) delete_all_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	if var_request.array_isset(rt.new_string('status')) {
		var_args.array_set('status', var_request.array_get('status'))
	}
	mut var_notes := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.delete_all_notes(arg_0) }(var_args.dup())
	mut var_data := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_notes).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_obj := item_1.val
			var_data.array_push(this.prepare_note_data_for_response(var_note_obj.dup(), var_request.dup()))
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_notes_count(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: 'info' }, rt.ArrayItem{ key: none, val: 'warning' }]), rt.new_array())])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_note_data_for_response(var_note rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	var_note_mutated = rt.call_method(var_note_mutated, 'get_data', []rt.PhpVal{})
	var_note_mutated = this.prepare_item_for_response(var_note_mutated.dup(), var_request.dup())
	return this.prepare_response_for_collection(var_note_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_requested_updates(var_request rt.PhpVal) rt.PhpVal {
	mut var_requested_updates := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('status')]).is_null()))))) {
		var_requested_updates.array_set('status', rt.call_method(var_request, 'get_param', [rt.new_string('status')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('date_reminder')]).is_null()))))) {
		var_requested_updates.array_set('date_reminder', rt.call_method(var_request, 'get_param', [rt.new_string('date_reminder')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('is_deleted')]).is_null()))))) {
		var_requested_updates.array_set('is_deleted', rt.call_method(var_request, 'get_param', [rt.new_string('is_deleted')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('is_read')]).is_null()))))) {
		var_requested_updates.array_set('is_read', rt.call_method(var_request, 'get_param', [rt.new_string('is_read')]))
	}
	return var_requested_updates.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) batch_update_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_note_ids := rt.call_method(var_request, 'get_param', [rt.new_string('noteIds')])
	if rt.is_true(rt.new_bool(!(!(var_note_ids).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_note_ids.dup().is_array()))))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_ids'), rt.call_function('__', [rt.new_string('Please provide an array of IDs through the noteIds param.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 422 }]))
	}
	{
		mut iter_1 := rt.cast_array(var_note_ids).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_id := item_1.val
			mut var_note := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_note(arg_0) }(// unsupported expression: Expr_Cast_Int)
			if rt.is_true(var_note) {
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.update_note(arg_0, arg_1) }(var_note.dup(), this.get_requested_updates(var_request.dup()))
				var_data.array_push(this.prepare_note_data_for_response(var_note.dup(), var_request.dup()))
			}
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_notes_count(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: 'info' }, rt.ArrayItem{ key: none, val: 'warning' }]), rt.new_array())])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) activate_promo_note(var_request rt.PhpVal) rt.PhpVal {
	mut var_allowed_promo_notes := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_allowed_promo_notes'), rt.new_array()])
	mut var_promo_note_name := rt.call_method(var_request, 'get_param', [rt.new_string('promo_note_name')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_promo_note_name.dup(), var_allowed_promo_notes.dup(), rt.new_bool(true)]))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_promo_note_name'), rt.call_function('__', [rt.new_string('Please provide a valid promo note name.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 422 }]))
	}
	mut var_data_store := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.load_data_store() }()
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [var_promo_note_name.dup()])
	if !rt.is_true(var_note_ids) {
		mut var_note := create_automattic_woocommerce_admin_notes_note()
		rt.call_method(var_note, 'set_name', [var_promo_note_name.dup()])
		rt.call_method(var_note, 'set_status', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()])
		rt.call_method(var_data_store, 'create', [var_note.dup()])
	} else {
		var_note = 
		
	}
	return 
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) update_items_permissions_check(var_request rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_query_for_response(var_query rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) maybe_add_nonce_to_url(url string, action string, name string) string {
	mut name_mutated := name
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_item_for_response(var_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) track_opened_email(var_request rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_collection_params() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_item_schema() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_DateTimeZone {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_notes() &Class_Automattic_WooCommerce_Admin_API_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
		rest_base: rt.new_string('admin/notes')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_crud_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note() &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_woocommerce_admin_experimental_abtest() &Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_datetime() &Class_Automattic_WooCommerce_Admin_API_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_datetimezone() &Class_Automattic_WooCommerce_Admin_API_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'is_tasklist_experiment_assigned_treatment' {
			return rt.new_bool(this.is_tasklist_experiment_assigned_treatment())
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'delete_all_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_all_items(dispatch_arg_0)
		}
		'prepare_note_data_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_note_data_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_requested_updates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_requested_updates(dispatch_arg_0)
		}
		'batch_update_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.batch_update_items(dispatch_arg_0)
		}
		'activate_promo_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.activate_promo_note(dispatch_arg_0)
		}
		'update_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_items_permissions_check(dispatch_arg_0))
		}
		'prepare_query_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_query_for_response(dispatch_arg_0)
		}
		'maybe_add_nonce_to_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.maybe_add_nonce_to_url(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'track_opened_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_opened_email(dispatch_arg_0)
			return rt.new_null()
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

fn (this &Class_Automattic_WooCommerce_Admin_API_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_notes_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
