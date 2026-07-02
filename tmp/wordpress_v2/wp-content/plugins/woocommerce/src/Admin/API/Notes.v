import rt

struct Class_Automattic_WooCommerce_Admin_API_Notes {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
	rest_base rt.PhpVal = rt.new_string('admin/notes')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
					'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique ID for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
					'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/delete/(?P<id>[\\d-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.deletable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
					'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Notes_Note{}
	mut iife_result_0 := iife_temp_0.get_allowed_statuses()
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/delete/all'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.deletable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_all_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'status', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Status of note.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' },
						rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
						rt.ArrayItem{ key: 'items', val: rt.create_array([
							rt.ArrayItem{ key: 'enum', val: iife_result_0 },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
					'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/update'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_update_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
					'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' +
			(this.rest_base).str() + '/experimental-activate-promo/(?P<promo_note_name>[\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'activate_promo_note' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
						'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Notes', [
					'Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_1 := iife_temp_1.get_note(rt.call_method(var_request, 'get_param', [
		rt.new_string('id'),
	]))
	mut var_note := iife_result_1
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_id'), rt.call_function('__', [
			rt.new_string('Sorry, there is no resource with that ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_note.clone()])) {
		return var_note.clone()
	}
	mut var_data := this.prepare_note_data_for_response(var_note.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.clone())
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_2 := iife_temp_2.get_notes(rt.new_string('edit'), var_query_args.clone())
	mut var_notes := iife_result_2
	mut var_data := rt.new_array()
	mut iter_1 := rt.cast_array(var_notes).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_note_obj := item_1.val
		mut var_note := this.prepare_item_for_response(var_note_obj.clone(), var_request.clone())
		var_note = this.prepare_response_for_collection(var_note.clone())
		var_data.array_push(var_note.clone())
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_data.clone().array_count())])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) is_tasklist_experiment_assigned_treatment() bool {
	mut var_anon_id := if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').array_get(rt.new_string('tk_ai'))]),
		]) } else { rt.new_string('') }
	mut var_allow_tracking := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
	]))
	mut var_abtest := create_automattic_woocommerce_admin_api_woocommerce_admin_experimental_abtest(var_anon_id.clone(),
		rt.new_string('woocommerce'), var_allow_tracking.clone())
	mut var_date := create_automattic_woocommerce_admin_api_datetime()
	var_date.settimezone(create_automattic_woocommerce_admin_api_datetimezone(rt.new_string('UTC')))
	mut var_experiment_name := rt.call_function('sprintf', [
		rt.new_string('woocommerce_tasklist_progression_headercard_%s_%s'),
		var_date.format(rt.new_string('Y')),
		var_date.format(rt.new_string('m')),
	])
	mut var_experiment_name_2col := rt.call_function('sprintf', [
		rt.new_string('woocommerce_tasklist_progression_headercard_2col_%s_%s'),
		var_date.format(rt.new_string('Y')),
		var_date.format(rt.new_string('m')),
	])
	return
		rt.is_true(rt.identical(var_abtest.get_variation(var_experiment_name.clone()), rt.new_string('treatment')))
		|| rt.is_true(rt.identical(var_abtest.get_variation(var_experiment_name_2col.clone()), rt.new_string('treatment')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('order', var_request.array_get(rt.new_string('order')))
	var_args.array_set('orderby', var_request.array_get(rt.new_string('orderby')))
	var_args.array_set('per_page', var_request.array_get(rt.new_string('per_page')))
	var_args.array_set('page', var_request.array_get(rt.new_string('page')))
	var_args.array_set('type', if var_request.array_isset(rt.new_string('type')) {
		var_request.array_get(rt.new_string('type'))
	} else {
		rt.new_array()
	})
	var_args.array_set('status', if var_request.array_isset(rt.new_string('status')) {
		var_request.array_get(rt.new_string('status'))
	} else {
		rt.new_array()
	})
	var_args.array_set('source', if var_request.array_isset(rt.new_string('source')) {
		var_request.array_get(rt.new_string('source'))
	} else {
		rt.new_array()
	})
	var_args.array_set('is_deleted', 0)
	if var_request.array_isset(rt.new_string('is_read')) {
		var_args.array_set('is_read', rt.call_function('filter_var', [
			var_request.array_get(rt.new_string('is_read')),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get(rt.new_string('orderby')))) {
		var_args.array_set('orderby', 'date_created')
	}
	var_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_notes_object_query'),
		var_args.clone(),
		var_request.clone(),
	])
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('system_status'),
		rt.new_string('read'),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('system_status'),
		rt.new_string('read'),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_3 := iife_temp_3.get_note(rt.call_method(var_request, 'get_param', [
		rt.new_string('id'),
	]))
	mut var_note := iife_result_3
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_id'), rt.call_function('__', [
			rt.new_string('Sorry, there is no resource with that ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_4 := iife_temp_4.update_note(var_note.clone(),
		this.get_requested_updates(var_request.clone()))
	return this.get_item(var_request.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_5 := iife_temp_5.get_note(rt.call_method(var_request, 'get_param', [
		rt.new_string('id'),
	]))
	mut var_note := iife_result_5
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_id'), rt.call_function('__', [
			rt.new_string('Sorry, there is no note with that ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_6 := iife_temp_6.delete_note(var_note.clone())
	mut var_data := this.prepare_note_data_for_response(var_note.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) delete_all_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	if var_request.array_isset(rt.new_string('status')) {
		var_args.array_set('status', var_request.array_get(rt.new_string('status')))
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_7 := iife_temp_7.delete_all_notes(var_args.clone())
	mut var_notes := iife_result_7
	mut var_data := rt.new_array()
	mut iter_2 := rt.cast_array(var_notes).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_note_obj := item_2.val
		var_data.array_push(this.prepare_note_data_for_response(var_note_obj.clone(),
			var_request.clone()))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_8 := iife_temp_8.get_notes_count(rt.create_array([
		rt.ArrayItem{ key: none, val: 'info' },
		rt.ArrayItem{ key: none, val: 'warning' },
	]), rt.new_array())
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), iife_result_8])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_note_data_for_response(var_note rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	var_note_mutated = rt.call_method(var_note_mutated, 'get_data', []rt.PhpVal{})
	var_note_mutated = this.prepare_item_for_response(var_note_mutated.clone(), var_request.clone())
	return this.prepare_response_for_collection(var_note_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_requested_updates(var_request rt.PhpVal) rt.PhpVal {
	mut var_requested_updates := rt.new_array()
	if !(rt.call_method(var_request, 'get_param', [rt.new_string('status')]).is_null()) {
		var_requested_updates.array_set('status', rt.call_method(var_request, 'get_param', [
			rt.new_string('status'),
		]))
	}
	if !(rt.call_method(var_request, 'get_param', [rt.new_string('date_reminder')]).is_null()) {
		var_requested_updates.array_set('date_reminder', rt.call_method(var_request, 'get_param', [
			rt.new_string('date_reminder'),
		]))
	}
	if !(rt.call_method(var_request, 'get_param', [rt.new_string('is_deleted')]).is_null()) {
		var_requested_updates.array_set('is_deleted', rt.call_method(var_request, 'get_param', [
			rt.new_string('is_deleted'),
		]))
	}
	if !(rt.call_method(var_request, 'get_param', [rt.new_string('is_read')]).is_null()) {
		var_requested_updates.array_set('is_read', rt.call_method(var_request, 'get_param', [
			rt.new_string('is_read'),
		]))
	}
	return var_requested_updates.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) batch_update_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_note_ids := rt.call_method(var_request, 'get_param', [
		rt.new_string('noteIds'),
	])
	if !(!var_note_ids.is_null()) || !(var_note_ids.clone().is_array()) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_ids'), rt.call_function('__', [
			rt.new_string('Please provide an array of IDs through the noteIds param.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 422 }])))
	}
	mut iter_3 := rt.cast_array(var_note_ids).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_note_id := item_3.val
		mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_9 := iife_temp_9.get_note(rt.new_int(var_note_id.to_i64()))
		mut var_note := iife_result_9
		if rt.is_true(var_note) {
			mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
			mut iife_result_10 := iife_temp_10.update_note(var_note.clone(),
				this.get_requested_updates(var_request.clone()))
			var_data.array_push(this.prepare_note_data_for_response(var_note.clone(),
				var_request.clone()))
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_11 := iife_temp_11.get_notes_count(rt.create_array([
		rt.ArrayItem{ key: none, val: 'info' },
		rt.ArrayItem{ key: none, val: 'warning' },
	]), rt.new_array())
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), iife_result_11])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) activate_promo_note(var_request rt.PhpVal) rt.PhpVal {
	mut var_allowed_promo_notes := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_allowed_promo_notes'),
		rt.new_array(),
	])
	mut var_promo_note_name := rt.call_method(var_request, 'get_param', [
		rt.new_string('promo_note_name'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_promo_note_name.clone(), var_allowed_promo_notes.clone(),
		rt.new_bool(true)])))))
	{
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_promo_note_name'), rt.call_function('__', [
			rt.new_string('Please provide a valid promo note name.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 422 }])))
	}
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_12 := iife_temp_12.load_data_store()
	mut var_data_store := iife_result_12
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		var_promo_note_name.clone(),
	])
	if !rt.is_true(var_note_ids) {
		mut var_note := create_automattic_woocommerce_admin_notes_note()
		rt.call_method(var_note, 'set_name', [var_promo_note_name.clone()])
		rt.call_method(var_note, 'set_status', [
			Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned(),
		])
		rt.call_method(var_data_store, 'create', [var_note.clone()])
	} else {
		mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_13 := iife_temp_13.get_note(var_note_ids.array_get(rt.new_int(0)))
		var_note = iife_result_13
		mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_14 := iife_temp_14.update_note(var_note.clone(), rt.create_array([
			rt.ArrayItem{
				key: 'status'
				val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()
			},
		]))
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) update_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('edit'),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot edit this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_query_for_response(var_query rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_query) {
		return var_query.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('https://'), rt.call_function('substr', [
		var_query.clone(),
		rt.new_int(0),
		rt.new_int(8),
	])))
	{
		return var_query.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('http://'), rt.call_function('substr', [
		var_query.clone(),
		rt.new_int(0),
		rt.new_int(7),
	])))
	{
		return var_query.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('?'), rt.call_function('substr', [
		var_query.clone(),
		rt.new_int(0),
		rt.new_int(1),
	])))
	{
		return rt.call_function('admin_url', [
			rt.new_string('admin.php' + var_query.str()),
		])
	}
	return rt.call_function('admin_url', [var_query.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) maybe_add_nonce_to_url(url string, action string, name string) string {
	mut name_mutated := name
	if action == '' {
		return url
	}
	if name_mutated == '' {
		name_mutated = '_wpnonce'
	}
	return (rt.call_function('add_query_arg', [rt.new_string(name_mutated).clone(),
		rt.call_function('wp_create_nonce', [rt.new_string(action)]),
		rt.new_string(url)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) prepare_item_for_response(var_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data_mutated = this.add_additional_fields_to_object(var_data_mutated.clone(),
		var_request.clone())
	var_data_mutated.array_set('date_created_gmt', rt.call_function('wc_rest_prepare_date_response', [
		var_data_mutated.array_get(rt.new_string('date_created')),
	]))
	var_data_mutated.array_set('date_created', rt.call_function('wc_rest_prepare_date_response', [
		var_data_mutated.array_get(rt.new_string('date_created')),
		rt.new_bool(false),
	]))
	var_data_mutated.array_set('date_reminder_gmt', rt.call_function('wc_rest_prepare_date_response', [
		var_data_mutated.array_get(rt.new_string('date_reminder')),
	]))
	var_data_mutated.array_set('date_reminder', rt.call_function('wc_rest_prepare_date_response', [
		var_data_mutated.array_get(rt.new_string('date_reminder')),
		rt.new_bool(false),
	]))
	var_data_mutated.array_set('title', rt.call_function('stripslashes', [
		var_data_mutated.array_get(rt.new_string('title')),
	]))
	var_data_mutated.array_set('content', rt.call_function('stripslashes', [
		var_data_mutated.array_get(rt.new_string('content')),
	]))
	var_data_mutated.array_set('is_snoozable',
		(var_data_mutated.array_get(rt.new_string('is_snoozable'))).to_bool())
	var_data_mutated.array_set('is_deleted',
		(var_data_mutated.array_get(rt.new_string('is_deleted'))).to_bool())
	var_data_mutated.array_set('is_read',
		(var_data_mutated.array_get(rt.new_string('is_read'))).to_bool())
	mut iter_4 := rt.cast_array(var_data_mutated.array_get(rt.new_string('actions'))).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		rt.set_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
			'label', rt.call_function('stripslashes', [
			rt.get_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
				'label'),
		]))
		rt.set_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
			'url', this.maybe_add_nonce_to_url((this.prepare_query_for_response(rt.get_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
			'query'))).str(), (rt.get_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
			'nonce_action')).str(), (rt.get_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
			'nonce_name')).str()))
		rt.set_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
			'status', rt.call_function('stripslashes', [
			rt.get_property(var_data_mutated.array_get(rt.new_string('actions')).array_get(var_key),
				'status'),
		]))
	}
	var_data_mutated = this.filter_response_by_context(var_data_mutated.clone(),
		var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data_mutated.clone()])
	rt.call_method(var_response, 'add_links', [
		rt.create_array([
			rt.ArrayItem{ key: 'self', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
						this.rest_base, var_data_mutated.array_get(rt.new_string('id'))]),
				]) },
			]) },
			rt.ArrayItem{ key: 'collection', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf',
						[rt.new_string('%s/%s'), this.namespace, this.rest_base]),
				]) },
			]) },
		]),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_note'),
		var_response.clone(),
		var_data_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) track_opened_email(var_request rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.6.0')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param(rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'view' },
	])))
	var_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'desc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by object attribute.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'note_id' },
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'type' },
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'status' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Current page of the collection.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 1 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_params.array_set('per_page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Maximum number of items to be returned in result set.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 10 },
		rt.ArrayItem{ key: 'minimum', val: 1 },
		rt.ArrayItem{ key: 'maximum', val: 100 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_Notes_Note{}
	mut iife_result_15 := iife_temp_15.get_allowed_types()
	var_params.array_set('type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Type of note.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'enum', val: iife_result_15 },
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_Notes_Note{}
	mut iife_result_16 := iife_temp_16.get_allowed_statuses()
	var_params.array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Status of note.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'enum', val: iife_result_16 },
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	var_params.array_set('source', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Source of note.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'note' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('ID of the note record.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Name of the note.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The type of the note (e.g. error, warning, etc.).'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'locale', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Locale used for the note title and content.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Title of the note.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'content', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Content of the note.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'content_data', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Content data for the note. JSON string. Available for re-localization.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The status of the note (e.g. unactioned, actioned).'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'source', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Source of the note.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_created', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date the note was created.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date the note was created (GMT).'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_reminder', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date after which the user should be reminded of the note, if any.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_reminder_gmt', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Date after which the user should be reminded of the note, if any (GMT).'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'is_snoozable', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Whether or not a user can request to be reminded about the note.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'actions', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('An array of actions, if any, for the note.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'layout', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The layout of the note (e.g. banner, thumbnail, plain).'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'image', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The image of the note, if any.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'is_deleted', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Registers whether the note is deleted or not'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'is_read', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Registers whether the note is read or not'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
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

fn create_automattic_woocommerce_admin_api_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
		rest_base:     rt.new_string('admin/notes')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_crud_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_CRUD_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_woocommerce_admin_experimental_abtest(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WooCommerce_Admin_Experimental_Abtest{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_DateTimeZone {
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
			return rt.new_string(this.maybe_add_nonce_to_url(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
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
		else {
			return none
		}
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
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
