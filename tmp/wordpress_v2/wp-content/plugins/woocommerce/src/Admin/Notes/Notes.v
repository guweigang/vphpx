import rt

pub fn Class_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_hook() string {
	return 'wc_admin_unsnooze_admin_notes'
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.init() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'schedule_unsnooze_notes' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'possibly_delete_survey_notes' }])])
	rt.call_function('add_action', [
		rt.new_string('update_option_woocommerce_show_marketplace_suggestions'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'possibly_delete_marketing_notes' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_hook(),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsnooze_notes' }]),
	])
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.get_notes(context string, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	mut var_raw_notes := rt.call_method(var_data_store, 'get_notes', [
		var_args_mutated.clone()])
	mut var_notes := rt.new_array()
	mut iter_1 := rt.cast_array(var_raw_notes).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_raw_note := item_1.val
		mut var_note := create_automattic_woocommerce_admin_notes_note(var_raw_note.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_note = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_note_from_db'),
			var_note.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_note_id := rt.call_method(var_note, 'get_id', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_set(var_note_id, rt.call_method(var_note, 'get_data', []rt.PhpVal{}))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('name', rt.call_method(var_note, 'get_name', [
			rt.new_string(context),
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('type', rt.call_method(var_note, 'get_type', [
			rt.new_string(context),
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('locale', rt.call_method(var_note,
			'get_locale', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('title', rt.call_method(var_note,
			'get_title', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('content', rt.call_method(var_note,
			'get_content', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('content_data', rt.call_method(var_note,
			'get_content_data', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('status', rt.call_method(var_note,
			'get_status', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('source', rt.call_method(var_note,
			'get_source', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('date_created', rt.call_method(var_note,
			'get_date_created', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('date_reminder', rt.call_method(var_note,
			'get_date_reminder', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('actions', rt.call_method(var_note,
			'get_actions', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('layout', rt.call_method(var_note,
			'get_layout', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('image', rt.call_method(var_note,
			'get_image', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_notes.array_get_mut(var_note_id).array_set('is_deleted', rt.call_method(var_note,
			'get_is_deleted', [rt.new_string(context)]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Notes_Exception') {
			mut var_e := var_e_1.clone()
			rt.call_function('wc_caught_exception', [var_e.clone(),
				rt.new_string(@STRUCT + '::' + @FN),
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_note_id },
				])])
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
	return var_notes.clone()
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(var_note_id rt.PhpVal) bool {
	mut var_note_id_mutated := var_note_id
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_note_id_mutated)))) {
		return (create_automattic_woocommerce_admin_notes_note(var_note_id_mutated.clone())).to_bool()
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Admin_Notes_Exception') {
			mut var_e := var_e_2.clone()
			rt.call_function('wc_caught_exception', [var_e.clone(),
				rt.new_string(@STRUCT + '::' + @FN),
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_note_id_mutated },
				])])
			return false
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note_by_name(var_note_name rt.PhpVal) bool {
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		var_note_name.clone(),
	])
	if !rt.is_true(var_note_ids) {
		return false
	}
	return (Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(var_note_ids.array_get(rt.new_int(0)))).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.get_notes_count(var_type rt.PhpVal, var_status rt.PhpVal) rt.PhpVal {
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	return rt.call_method(var_data_store, 'get_notes_count', [
		var_type.clone(), var_status.clone()])
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.delete_notes_with_name(var_names rt.PhpVal) {
	mut var_names_mutated := var_names
	if rt.is_true(rt.new_bool(var_names_mutated.clone().is_string())) {
		var_names_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_names_mutated },
		])
	} else if !(var_names_mutated.clone().is_array()) {
		return
	}
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	mut iter_2 := var_names_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_name := item_2.val
		mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
			var_name.clone(),
		])
		mut iter_3 := rt.cast_array(var_note_ids).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_note_id := item_3.val
			mut var_note :=
				Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(var_note_id.clone())
			if rt.is_true(var_note) {
				rt.call_method(var_note, 'delete', []rt.PhpVal{})
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.update_note(var_note rt.PhpVal, var_requested_updates rt.PhpVal) {
	mut var_note_mutated := var_note
	mut var_note_changed := rt.new_bool(false)
	if var_requested_updates.array_isset(rt.new_string('status')) {
		rt.call_method(var_note_mutated, 'set_status', [
			var_requested_updates.array_get(rt.new_string('status')),
		])
		var_note_changed = rt.new_bool(true)
	}
	if var_requested_updates.array_isset(rt.new_string('date_reminder')) {
		rt.call_method(var_note_mutated, 'set_date_reminder', [
			var_requested_updates.array_get(rt.new_string('date_reminder')),
		])
		var_note_changed = rt.new_bool(true)
	}
	if var_requested_updates.array_isset(rt.new_string('is_deleted')) {
		rt.call_method(var_note_mutated, 'set_is_deleted', [
			var_requested_updates.array_get(rt.new_string('is_deleted')),
		])
		var_note_changed = rt.new_bool(true)
	}
	if var_requested_updates.array_isset(rt.new_string('is_read')) {
		rt.call_method(var_note_mutated, 'set_is_read', [
			var_requested_updates.array_get(rt.new_string('is_read')),
		])
		var_note_changed = rt.new_bool(true)
	}
	if rt.is_true(var_note_changed) {
		rt.call_method(var_note_mutated, 'save', []rt.PhpVal{})
	}
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.delete_note(var_note rt.PhpVal) {
	mut var_note_mutated := var_note
	rt.call_method(var_note_mutated, 'set_is_deleted', [rt.new_int(1)])
	rt.call_method(var_note_mutated, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.delete_all_notes(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'order', val: 'desc' },
		rt.ArrayItem{ key: 'orderby', val: 'date_created' }, rt.ArrayItem{ key: 'per_page', val: 25 },
		rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_warning()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_survey()
			},
		]) }, rt.ArrayItem{ key: 'is_deleted', val: 0 }])
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		var_defaults.clone()])
	mut var_raw_notes := rt.call_method(var_data_store, 'get_notes', [
		var_args_mutated.clone()])
	mut var_notes := rt.new_array()
	mut iter_4 := rt.cast_array(var_raw_notes).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_raw_note := item_4.val
		mut var_note := Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(rt.get_property(var_raw_note,
			'note_id'))
		if rt.is_true(var_note) {
			Class_Automattic_WooCommerce_Admin_Notes_Notes.delete_note(var_note.clone())
			var_notes.clone().array_push(var_note.clone())
		}
	}
	return var_notes.clone()
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_notes() {
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	mut var_raw_notes := rt.call_method(var_data_store, 'get_notes', [
		rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_snoozed()
				},
			]) },
		]),
	])
	mut var_now := create_automattic_woocommerce_admin_notes_datetime()
	mut iter_5 := var_raw_notes.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_raw_note := item_5.val
		mut var_note := Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(rt.get_property(var_raw_note,
			'note_id'))
		if rt.is_true(rt.identical(rt.new_bool(false), var_note)) {
			continue
		}
		mut var_date_reminder := rt.call_method(var_note, 'get_date_reminder', [
			rt.new_string('edit'),
		])
		if rt.is_true(rt.less(var_date_reminder, var_now)) {
			rt.call_method(var_note, 'set_status', [
				Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned(),
			])
			rt.call_method(var_note, 'set_date_reminder', [rt.new_null()])
			rt.call_method(var_note, 'save', []rt.PhpVal{})
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.schedule_unsnooze_notes() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [
		Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_hook(),
	])))))
	{
		rt.call_function('wp_schedule_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(5)),
			rt.new_string('hourly'),
			Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_hook(),
		])
	}
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.clear_queued_actions() {
	rt.call_function('wp_clear_scheduled_hook', [
		Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_hook(),
	])
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.possibly_delete_marketing_notes(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no'), var_value)))) {
		return
	}
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	mut var_note_ids := rt.call_method(var_data_store, 'get_note_ids_by_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing(),
	])
	mut iter_6 := var_note_ids.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_note_id := item_6.val
		mut var_note := Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(var_note_id.clone())
		if rt.is_true(var_note) {
			rt.call_method(var_note, 'delete', []rt.PhpVal{})
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.possibly_delete_survey_notes() {
	mut var_data_store := Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
	mut var_note_ids := rt.call_method(var_data_store, 'get_note_ids_by_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_survey(),
	])
	mut iter_7 := var_note_ids.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_note_id := item_7.val
		mut var_note := Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(var_note_id.clone())
		if rt.is_true(var_note)
			&& rt.is_true(rt.identical(rt.call_method(var_note, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned())) {
			rt.call_method(var_note, 'set_is_deleted', [rt.new_int(1)])
			rt.call_method(var_note, 'save', []rt.PhpVal{})
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note_status(var_note_name rt.PhpVal) bool {
	mut var_note :=
		Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note_by_name(var_note_name.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return false
	}
	return (rt.call_method(var_note, 'get_status', []rt.PhpVal{})).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.get_action_by_id(var_note rt.PhpVal, var_action_id rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	mut var_actions := rt.call_method(var_note_mutated, 'get_actions', [
		rt.new_string('edit'),
	])
	mut var_found_action := rt.new_bool(false)
	mut iter_8 := var_actions.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_action := item_8.val
		if rt.is_true(rt.identical(rt.get_property(var_action, 'id'), var_action_id)) {
			var_found_action = var_action
		}
	}
	return var_found_action.clone()
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.trigger_note_action(var_note rt.PhpVal, var_triggered_action rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	rt.call_function('do_action', [rt.new_string('woocommerce_note_action'),
		rt.get_property(var_triggered_action, 'name'), var_note_mutated.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_note_action_' +
			(rt.get_property(var_triggered_action, 'name')).str()),
		var_note_mutated.clone(),
	])
	if !(!rt.is_true(rt.get_property(var_triggered_action, 'status'))) {
		rt.call_method(var_note_mutated, 'set_status', [
			rt.get_property(var_triggered_action, 'status'),
		])
	}
	rt.call_method(var_note_mutated, 'save', []rt.PhpVal{})
	mut var_event_params := rt.create_array([
		rt.ArrayItem{ key: 'note_name', val: rt.call_method(var_note_mutated, 'get_name',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'note_type', val: rt.call_method(var_note_mutated, 'get_type',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'note_title', val: rt.call_method(var_note_mutated, 'get_title',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'note_content', val: rt.call_method(var_note_mutated, 'get_content',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'action_name', val: rt.get_property(var_triggered_action, 'name') },
		rt.ArrayItem{ key: 'action_label', val: rt.get_property(var_triggered_action, 'label') },
		rt.ArrayItem{
			key: 'screen'
			val: Class_Automattic_WooCommerce_Admin_Notes_Notes.get_screen_name()
		},
	])
	if rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_note_mutated, 'get_type', []rt.PhpVal{}),
		rt.create_array([rt.ArrayItem{ key: none, val: 'error' },
			rt.ArrayItem{ key: none, val: 'update' }]),
		rt.new_bool(true),
	]))
	{
		rt.call_function('wc_admin_record_tracks_event', [
			rt.new_string('store_alert_action'),
			var_event_params.clone(),
		])
	} else {
		Class_Automattic_WooCommerce_Admin_Notes_Notes.record_tracks_event_without_cookies(rt.new_string('inbox_action_click'),
			var_event_params.clone())
	}
	return var_note_mutated.clone()
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.record_tracks_event_with_user(var_user_id rt.PhpVal, var_event_name rt.PhpVal, var_params rt.PhpVal) {
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	rt.call_function('wp_set_current_user', [var_user_id.clone()])
	Class_Automattic_WooCommerce_Admin_Notes_Notes.record_tracks_event_without_cookies(var_event_name.clone(),
		var_params.clone())
	rt.call_function('wp_set_current_user', [var_current_user_id.clone()])
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.record_tracks_event_without_cookies(var_event_name rt.PhpVal, var_params rt.PhpVal) {
	mut var_anon_id := if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) {
		rt.get_superglobal('_COOKIE').array_get(rt.new_string('tk_ai'))
	} else {
		rt.new_null()
	}
	rt.get_superglobal('_COOKIE').array_unset(rt.new_string('tk_ai'))
	rt.call_function('wc_admin_record_tracks_event', [var_event_name.clone(),
		var_params.clone()])
	if !var_anon_id.is_null() {
		mut iife_temp_0 := Class_WC_Site_Tracking{}
		mut iife_result_0 := iife_temp_0.set_tracking_cookie(rt.new_string('tk_ai'),
			var_anon_id.clone())
	}
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.get_screen_name() rt.PhpVal {
	mut var_queries := rt.new_null()
	mut var_screen_name := rt.new_string('')
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_REFERER')) {
		rt.call_function('parse_str', [
			rt.call_function('wp_parse_url', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')),
				rt.get_constant('PHP_URL_QUERY'),
			]),
			var_queries.clone(),
		])
	}
	if !var_queries.is_null() {
		mut var_page := if var_queries.array_isset(rt.new_string('page')) {
			var_queries.array_get(rt.new_string('page'))
		} else {
			rt.new_null()
		}
		mut var_path := if var_queries.array_isset(rt.new_string('path')) {
			var_queries.array_get(rt.new_string('path'))
		} else {
			rt.new_null()
		}
		mut var_post_type := if var_queries.array_isset(rt.new_string('post_type')) {
			var_queries.array_get(rt.new_string('post_type'))
		} else {
			rt.new_null()
		}
		mut var_post := if var_queries.array_isset(rt.new_string('post')) { rt.call_function('get_post_type', [
				var_queries.array_get(rt.new_string('post')),
			]) } else { rt.new_null() }
	}
	if !var_page.is_null() {
		mut var_current_page := if rt.is_true(rt.identical(rt.new_string('wc-admin'), var_page)) {
			rt.new_string('home_screen')
		} else {
			var_page
		}
		var_screen_name = if !var_path.is_null() { rt.call_function('substr', [
				rt.call_function('str_replace', [rt.new_string('/'),
					rt.new_string('_'), var_path.clone()]),
				rt.new_int(1),
			]) } else { var_current_page }
	} else if !var_post_type.is_null() {
		var_screen_name = var_post_type.clone()
	} else if !var_post.is_null() {
		var_screen_name = var_post.clone()
	}
	return var_screen_name.clone()
}

fn Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('admin-note'))
	return iife_result_1
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Admin_Notes_Exception') {
		mut var_e := var_e_3.clone()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Notes_NotesUnavailableException',
			[]string{}, create_automattic_woocommerce_admin_notes_notesunavailableexception(rt.new_string('woocommerce_admin_notes_unavailable'), rt.call_function('__', [
			rt.new_string('Notes are unavailable because the "admin-note" data store cannot be loaded.'),
			rt.new_string('woocommerce'),
		]))))
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_DateTime {
	rt.PhpObjectBase
}

struct Class_WC_Site_Tracking {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
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

fn create_automattic_woocommerce_admin_notes_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_site_tracking(_args ...rt.PhpVal) &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notesunavailableexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_Notes_Notes.init()
			return rt.new_null()
		}
		'get_notes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Notes_Notes.get_notes(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note(dispatch_arg_0))
		}
		'get_note_by_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note_by_name(dispatch_arg_0))
		}
		'get_notes_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Notes_Notes.get_notes_count(dispatch_arg_0,
				dispatch_arg_1)
		}
		'delete_notes_with_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Notes_Notes.delete_notes_with_name(dispatch_arg_0)
			return rt.new_null()
		}
		'update_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Notes_Notes.update_note(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'delete_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Notes_Notes.delete_note(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_all_notes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Notes_Notes.delete_all_notes(dispatch_arg_0)
		}
		'unsnooze_notes' {
			Class_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_notes()
			return rt.new_null()
		}
		'schedule_unsnooze_notes' {
			Class_Automattic_WooCommerce_Admin_Notes_Notes.schedule_unsnooze_notes()
			return rt.new_null()
		}
		'clear_queued_actions' {
			Class_Automattic_WooCommerce_Admin_Notes_Notes.clear_queued_actions()
			return rt.new_null()
		}
		'possibly_delete_marketing_notes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Notes_Notes.possibly_delete_marketing_notes(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'possibly_delete_survey_notes' {
			Class_Automattic_WooCommerce_Admin_Notes_Notes.possibly_delete_survey_notes()
			return rt.new_null()
		}
		'get_note_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Notes_Notes.get_note_status(dispatch_arg_0))
		}
		'get_action_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Notes_Notes.get_action_by_id(dispatch_arg_0,
				dispatch_arg_1)
		}
		'trigger_note_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Notes_Notes.trigger_note_action(dispatch_arg_0,
				dispatch_arg_1)
		}
		'record_tracks_event_with_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Notes_Notes.record_tracks_event_with_user(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'record_tracks_event_without_cookies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Notes_Notes.record_tracks_event_without_cookies(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'get_screen_name' {
			return Class_Automattic_WooCommerce_Admin_Notes_Notes.get_screen_name()
		}
		'load_data_store' {
			return Class_Automattic_WooCommerce_Admin_Notes_Notes.load_data_store()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Site_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Site_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Site_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
