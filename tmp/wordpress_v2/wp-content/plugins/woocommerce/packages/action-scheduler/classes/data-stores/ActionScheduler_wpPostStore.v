import rt
import crypto.md5

pub fn Class_ActionScheduler_wpPostStore.post_type() string {
	return 'scheduled-action'
}
pub fn Class_ActionScheduler_wpPostStore.group_taxonomy() string {
	return 'action-group'
}
pub fn Class_ActionScheduler_wpPostStore.schedule_meta_key() string {
	return '_action_manager_schedule'
}
pub fn Class_ActionScheduler_wpPostStore.dependencies_met() string {
	return 'as-post-store-dependencies-met'
}
struct Class_ActionScheduler_wpPostStore {
	rt.PhpObjectBase
pub mut:
		claim_before_date rt.PhpVal = rt.new_null()
		local_timezone rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) save_action(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime) rt.PhpVal {
	mut var_action_mutated := var_action
	this.validate_action(mut var_action_mutated)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_post_array := this.create_post_array(mut var_action_mutated, mut var_scheduled_date)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_post_id := this.save_post_array(var_post_array.clone())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.save_post_schedule(var_post_id.clone(), rt.call_method(var_action_mutated, 'get_schedule', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.save_action_group(var_post_id.clone(), rt.call_method(var_action_mutated, 'get_group', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('action_scheduler_stored_action'), var_post_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_post_id.clone()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error saving action: %s'), rt.new_string('woocommerce')]), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.new_int(0))))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) create_post_array(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime) rt.PhpVal {
	mut var_action_mutated := var_action
	mut var_post := rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_ActionScheduler_wpPostStore.post_type() }, rt.ArrayItem{ key: 'post_title', val: rt.call_method(var_action_mutated, 'get_hook', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_content', val: rt.call_function('wp_json_encode', [rt.call_method(var_action_mutated, 'get_args', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_status', val: if rt.is_true(rt.call_method(var_action_mutated, 'is_finished', []rt.PhpVal{})) { 'publish' } else { 'pending' } }, rt.ArrayItem{ key: 'post_date_gmt', val: this.get_scheduled_date_string(rt.new_object('ActionScheduler_Action', []string{}, var_action_mutated), rt.new_object('?DateTime', []string{}, var_scheduled_date)) }, rt.ArrayItem{ key: 'post_date', val: this.get_scheduled_date_string_local(rt.new_object('ActionScheduler_Action', []string{}, var_action_mutated), rt.new_object('?DateTime', []string{}, var_scheduled_date)) }])
	return var_post.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) save_post_array(var_post_array rt.PhpVal) rt.PhpVal {
	mut var_post_array_mutated := var_post_array
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'filter_insert_post_data' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10), rt.new_int(5)])
	mut var_has_kses := rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_filter', [rt.new_string('content_save_pre'), rt.new_string('wp_filter_post_kses')]))))
	if rt.is_true(var_has_kses) {
		rt.call_function('kses_remove_filters', []rt.PhpVal{})
	}
	mut var_post_id := rt.call_function('wp_insert_post', [var_post_array_mutated.clone()])
	if rt.is_true(var_has_kses) {
		rt.call_function('kses_init_filters', []rt.PhpVal{})
	}
	rt.call_function('remove_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'filter_insert_post_data' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) || !rt.is_true(var_post_id) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('__', [rt.new_string('Unable to save action.'), rt.new_string('woocommerce')]))))
	}
	return var_post_id.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) filter_insert_post_data(var_postdata rt.PhpVal) rt.PhpVal {
	mut var_postdata_mutated := var_postdata
	if rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), var_postdata_mutated.array_get(rt.new_string('post_type')))) {
		var_postdata_mutated.array_set('post_author', 0)
		if rt.is_true(rt.identical(rt.new_string('future'), var_postdata_mutated.array_get(rt.new_string('post_status')))) {
			var_postdata_mutated.array_set('post_status', 'publish')
		}
	}
	return var_postdata_mutated.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) set_unique_post_slug(var_override_slug rt.PhpVal, var_slug rt.PhpVal, var_post_ID rt.PhpVal, var_post_status rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_override_slug_mutated := var_override_slug
	mut var_post_status_mutated := var_post_status
	if rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), var_post_type)) {
	var_override_slug_mutated = rt.new_string((rt.call_function('uniqid', [rt.new_string(Class_ActionScheduler_wpPostStore.post_type() + '-'), rt.new_bool(true)])).str() + '-' + (rt.call_function('wp_generate_password', [rt.new_int(32), rt.new_bool(false)])).str())
	}
	return var_override_slug_mutated.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) save_post_schedule(var_post_id rt.PhpVal, var_schedule rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	mut var_schedule_mutated := var_schedule
	rt.call_function('update_post_meta', [var_post_id_mutated.clone(), rt.new_string(Class_ActionScheduler_wpPostStore.schedule_meta_key()), var_schedule_mutated.clone()])
}

fn (mut this Class_ActionScheduler_wpPostStore) save_action_group(var_post_id rt.PhpVal, var_group rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	mut var_group_mutated := var_group
	if !rt.is_true(var_group_mutated) {
		rt.call_function('wp_set_object_terms', [var_post_id_mutated.clone(), rt.new_array(), rt.new_string(Class_ActionScheduler_wpPostStore.group_taxonomy()), rt.new_bool(false)])
	} else {
		rt.call_function('wp_set_object_terms', [var_post_id_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_group_mutated }]), rt.new_string(Class_ActionScheduler_wpPostStore.group_taxonomy()), rt.new_bool(false)])
	}
}

fn (mut this Class_ActionScheduler_wpPostStore) fetch_action(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_action_id.clone())
	if !rt.is_true(var_post) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), rt.get_property(var_post, 'post_type'))))) {
		return this.get_null_action()
	}
	mut var_action := this.make_action_from_post(var_post.clone())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'ActionScheduler_InvalidActionException') {
		mut var_exception := var_e_2.clone()
		rt.call_function('do_action', [rt.new_string('action_scheduler_failed_fetch_action'), rt.get_property(var_post, 'ID'), var_exception.clone()])
		return this.get_null_action()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return var_action.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) get_post(var_action_id rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_action_id) {
		return rt.new_null()
	}
	return rt.call_function('get_post', [var_action_id.clone()])
}

fn (mut this Class_ActionScheduler_wpPostStore) get_null_action() rt.PhpVal {
	return rt.new_object('ActionScheduler_NullAction', []string{}, create_actionscheduler_nullaction())
}

fn (mut this Class_ActionScheduler_wpPostStore) make_action_from_post(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_hook := rt.get_property(var_post_mutated, 'post_title')
	mut var_args := rt.call_function('json_decode', [rt.get_property(var_post_mutated, 'post_content'), rt.new_bool(true)])
	this.validate_args(var_args.clone(), rt.get_property(var_post_mutated, 'ID'))
	mut var_schedule := rt.call_function('get_post_meta', [rt.get_property(var_post_mutated, 'ID'), rt.new_string(Class_ActionScheduler_wpPostStore.schedule_meta_key()), rt.new_bool(true)])
	this.validate_schedule(var_schedule.clone(), rt.get_property(var_post_mutated, 'ID'))
	mut var_group := rt.call_function('wp_get_object_terms', [rt.get_property(var_post_mutated, 'ID'), rt.new_string(Class_ActionScheduler_wpPostStore.group_taxonomy()), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }])])
	var_group = if !rt.is_true(var_group) { rt.new_string('') } else { rt.call_function('reset', [var_group.clone()]) }
	mut iife_temp_0 := Class_ActionScheduler{}
	mut iife_result_0 := iife_temp_0.factory()
	return rt.call_method(iife_result_0, 'get_stored_action', [this.get_action_status_by_post_status(rt.get_property(var_post_mutated, 'post_status')), var_hook.clone(), var_args.clone(), var_schedule.clone(), var_group.clone()])
}

fn (mut this Class_ActionScheduler_wpPostStore) get_action_status_by_post_status(var_post_status rt.PhpVal) rt.PhpVal {
	mut var_post_status_mutated := var_post_status
	mut switch_val_1 := var_post_status_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish'))) {
	mut var_action_status := Class_ActionScheduler_wpPostStore.status_complete()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) {
	var_action_status = Class_ActionScheduler_wpPostStore.status_canceled()
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.get_status_labels().array_isset(var_post_status_mutated.clone())))))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Invalid post status: "%s". No matching action status available.'), var_post_status_mutated.clone()]))))
		}
	var_action_status = var_post_status_mutated.clone()
	}
	return var_action_status.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) get_post_status_by_action_status(var_action_status rt.PhpVal) rt.PhpVal {
	mut var_action_status_mutated := var_action_status
	mut switch_val_2 := var_action_status_mutated
	if rt.is_true(rt.equal(switch_val_2, Class_ActionScheduler_wpPostStore.status_complete())) {
	mut var_post_status := rt.new_string('publish')
	} else if rt.is_true(rt.equal(switch_val_2, Class_ActionScheduler_wpPostStore.status_canceled())) {
	var_post_status = rt.new_string('trash')
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.get_status_labels().array_isset(var_action_status_mutated.clone())))))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Invalid action status: "%s".'), var_action_status_mutated.clone()]))))
		}
	var_post_status = var_action_status_mutated.clone()
	}
	return var_post_status.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) get_query_actions_sql(mut var_query Class_array, select_or_count string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(select_or_count), rt.create_array([rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'count' }]), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('Invalid schedule. Cannot save action.'), rt.new_string('woocommerce')]))))
	}
	var_query_mutated = rt.call_function('wp_parse_args', [var_query_mutated, rt.create_array([rt.ArrayItem{ key: 'hook', val: '' }, rt.ArrayItem{ key: 'args', val: rt.new_null() }, rt.ArrayItem{ key: 'date', val: rt.new_null() }, rt.ArrayItem{ key: 'date_compare', val: '<=' }, rt.ArrayItem{ key: 'modified', val: rt.new_null() }, rt.ArrayItem{ key: 'modified_compare', val: '<=' }, rt.ArrayItem{ key: 'group', val: '' }, rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'claimed', val: rt.new_null() }, rt.ArrayItem{ key: 'per_page', val: 5 }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'search', val: '' }])])
	mut var_sql := rt.new_string((if rt.is_true(rt.identical(rt.new_string('count'), rt.new_string(select_or_count))) { 'SELECT count(p.ID)' } else { 'SELECT p.ID ' }).str())
	var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' p')))
	mut var_sql_params := rt.new_array()
	if !rt.is_true(var_query_mutated.array_get(rt.new_string('group'))) && rt.is_true(rt.identical(rt.new_string('group'), var_query_mutated.array_get(rt.new_string('orderby')))) {
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr ON tr.object_id=p.ID')))
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON tr.term_taxonomy_id=tt.term_taxonomy_id')))
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'terms')), rt.new_string(' t ON tt.term_id=t.term_id')))
	} else if !(!rt.is_true(var_query_mutated.array_get(rt.new_string('group')))) {
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr ON tr.object_id=p.ID')))
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON tr.term_taxonomy_id=tt.term_taxonomy_id')))
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb, 'terms')), rt.new_string(' t ON tt.term_id=t.term_id')))
		var_sql = rt.concat(var_sql, rt.new_string(' AND t.slug=%s'))
		var_sql_params.array_push(var_query_mutated.array_get(rt.new_string('group')))
	}
	var_sql = rt.concat(var_sql, rt.new_string(' WHERE post_type=%s'))
	var_sql_params.array_push(Class_ActionScheduler_wpPostStore.post_type())
	if rt.is_true(var_query_mutated.array_get(rt.new_string('hook'))) {
		var_sql = rt.concat(var_sql, rt.new_string(' AND p.post_title=%s'))
		var_sql_params.array_push(var_query_mutated.array_get(rt.new_string('hook')))
	}
	if !(var_query_mutated.array_get(rt.new_string('args')).is_null()) {
		var_sql = rt.concat(var_sql, rt.new_string(' AND p.post_content=%s'))
		var_sql_params.array_push(rt.call_function('wp_json_encode', [var_query_mutated.array_get(rt.new_string('args'))]))
	}
	if rt.is_true(var_query_mutated.array_get(rt.new_string('status'))) {
		mut var_post_statuses := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'get_post_status_by_action_status' }]), rt.cast_array(var_query_mutated.array_get(rt.new_string('status')))])
		mut var_placeholders := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_post_statuses.clone().array_count()), rt.new_string('%s')])
		var_sql = rt.concat(var_sql, rt.new_string(' AND p.post_status IN (' + (rt.call_function('join', [rt.new_string(', '), var_placeholders.clone()])).str() + ')'))
	var_sql_params = rt.call_function('array_merge', [var_sql_params.clone(), rt.call_function('array_values', [var_post_statuses.clone()])])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_query_mutated.array_get(rt.new_string('date')), 'DateTime'))) {
		mut var_date := var_query_mutated.array_get(rt.new_string('date')).dup()
		rt.call_method(var_date, 'setTimezone', [create_datetimezone(rt.new_string('UTC'))])
		mut var_date_string := rt.call_method(var_date, 'format', [rt.new_string('Y-m-d H:i:s')])
		mut var_comparator := this.validate_sql_comparator(var_query_mutated.array_get(rt.new_string('date_compare')))
		var_sql = rt.concat(var_sql, rt.new_string(" AND p.post_date_gmt ${var_comparator.to_string()} %s"))
		var_sql_params.array_push(var_date_string.clone())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_query_mutated.array_get(rt.new_string('modified')), 'DateTime'))) {
		mut var_modified := var_query_mutated.array_get(rt.new_string('modified')).dup()
		rt.call_method(var_modified, 'setTimezone', [create_datetimezone(rt.new_string('UTC'))])
		var_date_string = rt.call_method(var_modified, 'format', [rt.new_string('Y-m-d H:i:s')])
		var_comparator = this.validate_sql_comparator(var_query_mutated.array_get(rt.new_string('modified_compare')))
		var_sql = rt.concat(var_sql, rt.new_string(" AND p.post_modified_gmt ${var_comparator.to_string()} %s"))
		var_sql_params.array_push(var_date_string.clone())
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_query_mutated.array_get(rt.new_string('claimed')))) {
		var_sql = rt.concat(var_sql, rt.new_string(' AND p.post_password != \'\''))
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_query_mutated.array_get(rt.new_string('claimed')))) {
		var_sql = rt.concat(var_sql, rt.new_string(' AND p.post_password = \'\''))
	} else if !(var_query_mutated.array_get(rt.new_string('claimed')).is_null()) {
		var_sql = rt.concat(var_sql, rt.new_string(' AND p.post_password = %s'))
		var_sql_params.array_push(var_query_mutated.array_get(rt.new_string('claimed')))
	}
	if !(!rt.is_true(var_query_mutated.array_get(rt.new_string('search')))) {
		var_sql = rt.concat(var_sql, rt.new_string(' AND (p.post_title LIKE %s OR p.post_content LIKE %s OR p.post_password LIKE %s)'))
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(3)))) { break }
			var_sql_params.array_push(rt.call_function('sprintf', [rt.new_string('%%%s%%'), var_query_mutated.array_get(rt.new_string('search'))]))
			rt.post_inc(var_i)
		}
	}
	if rt.is_true(rt.identical(rt.new_string('select'), rt.new_string(select_or_count))) {
		mut switch_val_3 := var_query_mutated.array_get(rt.new_string('orderby'))
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('hook'))) {
		mut var_orderby := rt.new_string('p.post_title')
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('group'))) {
		var_orderby = rt.new_string('t.name')
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('status'))) {
		var_orderby = rt.new_string('p.post_status')
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('modified'))) {
		var_orderby = rt.new_string('p.post_modified')
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('claim_id'))) {
		var_orderby = rt.new_string('p.post_password')
		} else {
		var_orderby = rt.new_string('p.post_date_gmt')
		}
		if rt.is_true(rt.identical(rt.new_string('ASC'), rt.new_string(var_query_mutated.array_get(rt.new_string('order')).to_string().to_upper()))) {
		mut var_order := rt.new_string('ASC')
		} else {
		var_order = rt.new_string('DESC')
		}
		var_sql = rt.concat(var_sql, rt.new_string(" ORDER BY ${var_orderby.to_string()} ${var_order.to_string()}"))
		if rt.is_true(rt.greater(var_query_mutated.array_get(rt.new_string('per_page')), rt.new_int(0))) {
			var_sql = rt.concat(var_sql, rt.new_string(' LIMIT %d, %d'))
			var_sql_params.array_push(var_query_mutated.array_get(rt.new_string('offset')))
			var_sql_params.array_push(var_query_mutated.array_get(rt.new_string('per_page')))
		}
	}
	return rt.call_method(var_wpdb, 'prepare', [var_sql.clone(), var_sql_params.clone()])
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) query_actions(var_query rt.PhpVal, query_type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	mut var_sql := this.get_query_actions_sql(mut rt.cast_object_ptr[Class_array](var_query_mutated), query_type)
	return if rt.is_true(rt.identical(rt.new_string('count'), rt.new_string(query_type))) { rt.call_method(var_wpdb, 'get_var', [var_sql.clone()]) } else { rt.call_method(var_wpdb, 'get_col', [var_sql.clone()]) }
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) action_counts() rt.PhpVal {
	mut var_action_counts_by_status := rt.new_array()
	mut var_action_stati_and_labels := this.get_status_labels()
	mut var_posts_count_by_status := rt.cast_array(rt.call_function('wp_count_posts', [rt.new_string(Class_ActionScheduler_wpPostStore.post_type()), rt.new_string('readable')]))
	mut iter_1 := var_posts_count_by_status.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_count := item_1.val
		mut var_post_status_name := item_1.key
		mut var_action_status_name := this.get_action_status_by_post_status(var_post_status_name.clone())
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Exception') {
			mut var_e := var_e_3.clone()
			continue
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
		if rt.is_true(rt.new_bool(var_action_stati_and_labels.clone().array_isset(var_action_status_name.clone()))) {
			var_action_counts_by_status.array_set(var_action_status_name, var_count.clone())
		}
	}
	return var_action_counts_by_status.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) cancel_action(var_action_id rt.PhpVal) {
	mut var_post := rt.call_function('get_post', [var_action_id.clone()])
	if !rt.is_true(var_post) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), rt.get_property(var_post, 'post_type'))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unidentified action %s: we were unable to cancel this action. It may may have been deleted by another process.'), rt.new_string('woocommerce')]), var_action_id.clone()]))))
	}
	rt.call_function('do_action', [rt.new_string('action_scheduler_canceled_action'), var_action_id.clone()])
	rt.call_function('add_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10), rt.new_int(5)])
	rt.call_function('wp_trash_post', [var_action_id.clone()])
	rt.call_function('remove_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10)])
}

fn (mut this Class_ActionScheduler_wpPostStore) delete_action(var_action_id rt.PhpVal) {
	mut var_post := rt.call_function('get_post', [var_action_id.clone()])
	if !rt.is_true(var_post) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), rt.get_property(var_post, 'post_type'))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unidentified action %s: we were unable to delete this action. It may may have been deleted by another process.'), rt.new_string('woocommerce')]), var_action_id.clone()]))))
	}
	rt.call_function('do_action', [rt.new_string('action_scheduler_deleted_action'), var_action_id.clone()])
	rt.call_function('wp_delete_post', [var_action_id.clone(), rt.new_bool(true)])
}

fn (mut this Class_ActionScheduler_wpPostStore) get_date(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_next := this.get_date_gmt(var_action_id.clone())
	mut iife_temp_1 := Class_ActionScheduler_TimezoneHelper{}
	mut iife_result_1 := iife_temp_1.set_local_timezone(var_next.clone())
	return iife_result_1
}

fn (mut this Class_ActionScheduler_wpPostStore) get_date_gmt(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_post := rt.call_function('get_post', [var_action_id.clone()])
	if !rt.is_true(var_post) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), rt.get_property(var_post, 'post_type'))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unidentified action %s: we were unable to determine the date of this action. It may may have been deleted by another process.'), rt.new_string('woocommerce')]), var_action_id.clone()]))))
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status'))) {
		return rt.call_function('as_get_datetime_object', [rt.get_property(var_post, 'post_modified_gmt')])
	} else {
		return rt.call_function('as_get_datetime_object', [rt.get_property(var_post, 'post_date_gmt')])
	}
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) stake_claim(max_actions i64, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) rt.PhpVal {
	mut var_before_date_mutated := var_before_date
	mut group_mutated := group
	this.claim_before_date = var_before_date_mutated
	mut var_claim_id := this.generate_claim_id()
	this.claim_actions(var_claim_id.clone(), rt.new_int(max_actions), mut var_before_date_mutated, var_hooks.clone(), group_mutated)
	mut var_action_ids := this.find_actions_by_claim_id(var_claim_id.clone())
	this.claim_before_date = rt.new_null()
	return rt.new_object('ActionScheduler_ActionClaim', []string{}, create_actionscheduler_actionclaim(var_claim_id.clone(), var_action_ids.clone()))
}

fn (mut this Class_ActionScheduler_wpPostStore) get_claim_count() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT COUNT(DISTINCT post_password) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_password != \'\' AND post_type = %s AND post_status IN (\'in-progress\',\'pending\')')), rt.create_array([rt.ArrayItem{ key: none, val: Class_ActionScheduler_wpPostStore.post_type() }])])])
}

fn (mut this Class_ActionScheduler_wpPostStore) generate_claim_id() rt.PhpVal {
	mut var_claim_id := rt.new_string(md5.hexhash((rt.call_function('microtime', [rt.new_bool(true)])).str() + (rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(1000)])).str()))
	return rt.call_function('substr', [var_claim_id.clone(), rt.new_int(0), rt.new_int(20)])
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) claim_actions(var_claim_id rt.PhpVal, var_limit rt.PhpVal, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) i64 {
	mut var_wpdb := rt.new_null()
	mut var_claim_id_mutated := var_claim_id
	mut var_before_date_mutated := var_before_date
	mut group_mutated := group
	mut var_date := if rt.is_true(rt.identical(rt.new_null(), var_before_date_mutated)) { rt.call_function('as_get_datetime_object', []rt.PhpVal{}) } else { var_before_date_mutated.dup() }
	mut var_limit_ids := rt.new_bool(!(group_mutated == ''))
	mut var_ids := if rt.is_true(var_limit_ids) { this.get_actions_by_group(rt.new_string(group_mutated), var_limit.clone(), mut rt.cast_object_ptr[Class_DateTime](var_date)) } else { rt.new_array() }
	if rt.is_true(var_limit_ids) && 0 == var_ids.clone().array_count() {
		return 0
	}
	mut var_update := rt.new_string((rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' SET post_password = %s, post_modified_gmt = %s, post_modified = %s'))).str())
	mut var_params := rt.create_array([rt.ArrayItem{ key: none, val: var_claim_id_mutated }, rt.ArrayItem{ key: none, val: rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]) }, rt.ArrayItem{ key: none, val: rt.call_function('current_time', [rt.new_string('mysql')]) }])
	mut var_where := rt.new_string('WHERE post_type = %s AND post_status = %s AND post_password = \'\'')
	var_params.array_push(Class_ActionScheduler_wpPostStore.post_type())
	var_params.array_push(Class_ActionScheduler_Store.status_pending())
	if !(!rt.is_true(var_hooks)) {
		mut var_placeholders := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_hooks.clone().array_count()), rt.new_string('%s')])
		var_where = rt.concat(var_where, rt.new_string(' AND post_title IN (' + (rt.call_function('join', [rt.new_string(', '), var_placeholders.clone()])).str() + ')'))
	var_params = rt.call_function('array_merge', [var_params.clone(), rt.call_function('array_values', [var_hooks.clone()])])
	}
	if rt.is_true(var_limit_ids) {
		var_where = rt.concat(var_where, rt.new_string(' AND ID IN (' + (rt.call_function('join', [rt.new_string(','), var_ids.clone()])).str() + ')'))
	} else {
		var_where = rt.concat(var_where, rt.new_string(' AND post_date_gmt <= %s'))
		var_params.array_push(rt.call_method(var_date, 'format', [rt.new_string('Y-m-d H:i:s')]))
	}
	mut var_order := rt.new_string('ORDER BY menu_order ASC, post_date_gmt ASC, ID ASC LIMIT %d')
	var_params.array_push(var_limit.clone())
	mut var_rows_affected := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("${var_update.to_string()} ${var_where.to_string()} ${var_order.to_string()}"), var_params.clone()])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_rows_affected)) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('__', [rt.new_string('Unable to claim actions. Database error.'), rt.new_string('woocommerce')]))))
	}
	return rt.new_int((var_rows_affected).to_i64())
}

fn (mut this Class_ActionScheduler_wpPostStore) get_actions_by_group(var_group rt.PhpVal, var_limit rt.PhpVal, mut var_date Class_DateTime) rt.PhpVal {
	mut var_group_mutated := var_group
	mut var_date_mutated := var_date
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('term_exists', [var_group_mutated.clone(), rt.new_string(Class_ActionScheduler_wpPostStore.group_taxonomy())]))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The group "%s" does not exist.'), rt.new_string('woocommerce')]), var_group_mutated.clone()]))))
	}
	mut var_query := create_wp_query()
	mut var_query_args := { 'fields': rt.new_string('ids'), 'post_type': Class_ActionScheduler_wpPostStore.post_type(), 'post_status': Class_ActionScheduler_Store.status_pending(), 'has_password': rt.new_bool(false), 'posts_per_page': var_limit * 3, 'suppress_filters': rt.new_bool(true), 'no_found_rows': rt.new_bool(true), 'orderby': { 'menu_order': rt.new_string('ASC'), 'date': rt.new_string('ASC'), 'ID': rt.new_string('ASC') }, 'date_query': { 'column': rt.new_string('post_date_gmt'), 'before': rt.call_method(var_date_mutated, 'format', [rt.new_string('Y-m-d H:i')]), 'inclusive': rt.new_bool(true) }, 'tax_query': map[string]rt.PhpVal{} }
	return rt.call_method(var_query, 'query', [rt.create_array_from_native_map(var_query_args)])
}

fn (mut this Class_ActionScheduler_wpPostStore) find_actions_by_claim_id(var_claim_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_claim_id_mutated := var_claim_id
	mut var_action_ids := rt.new_array()
	mut var_before_date := if !(this.claim_before_date).is_null() { this.claim_before_date } else { rt.call_function('as_get_datetime_object', []rt.PhpVal{}) }
	mut var_cut_off := rt.call_method(var_before_date, 'format', [rt.new_string('Y-m-d H:i:s')])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_date_gmt FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = %s AND post_password = %s')), rt.create_array([rt.ArrayItem{ key: none, val: Class_ActionScheduler_wpPostStore.post_type() }, rt.ArrayItem{ key: none, val: var_claim_id_mutated }])])])
	mut iter_2 := var_results.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_claimed_action := item_2.val
		if rt.is_true(rt.less_equal(rt.get_property(var_claimed_action, 'post_date_gmt'), var_cut_off)) {
			var_action_ids.array_push(rt.call_function('absint', [rt.get_property(var_claimed_action, 'ID')]))
		}
	}
	return var_action_ids.clone()
}

fn (mut this Class_ActionScheduler_wpPostStore) release_claim(mut var_claim Class_ActionScheduler_ActionClaim) {
	mut var_wpdb := rt.new_null()
	mut var_claim_id := var_claim.get_id()
	if rt.is_true(rt.identical(rt.new_string(var_claim_id.clone().to_string().trim_space()), rt.new_string(''))) {
		return
	}
	mut var_action_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_date_gmt FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = %s AND post_password = %s AND post_status = %s')), rt.new_string(Class_ActionScheduler_wpPostStore.post_type()), var_claim_id.clone(), Class_ActionScheduler_wpPostStore.status_pending()])])
	if !rt.is_true(var_action_ids) {
		return
	}
	mut var_action_id_string := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('intval'), var_action_ids.clone()])])
	mut var_result := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' SET post_password = \'\' WHERE ID IN (')), var_action_id_string), rt.new_string(') AND post_password = %s')), rt.create_array([rt.ArrayItem{ key: none, val: var_claim.get_id() }])])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to unlock claim %s. Database error.'), rt.new_string('woocommerce')]), var_claim.get_id()]))))
	}
}

fn (mut this Class_ActionScheduler_wpPostStore) unclaim_action(var_action_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_result := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' SET post_password = \'\' WHERE ID = %d AND post_type = %s')), var_action_id.clone(), rt.new_string(Class_ActionScheduler_wpPostStore.post_type())])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to unlock claim on action %s. Database error.'), rt.new_string('woocommerce')]), var_action_id.clone()]))))
	}
}

fn (mut this Class_ActionScheduler_wpPostStore) mark_failure(var_action_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_result := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' SET post_status = %s WHERE ID = %d AND post_type = %s')), Class_ActionScheduler_wpPostStore.status_failed(), var_action_id.clone(), rt.new_string(Class_ActionScheduler_wpPostStore.post_type())])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to mark failure on action %s. Database error.'), rt.new_string('woocommerce')]), var_action_id.clone()]))))
	}
}

fn (mut this Class_ActionScheduler_wpPostStore) get_claim_id(var_action_id rt.PhpVal) rt.PhpVal {
	return this.get_post_column(var_action_id.clone(), rt.new_string('post_password'))
}

fn (mut this Class_ActionScheduler_wpPostStore) get_status(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_status := this.get_post_column(var_action_id.clone(), rt.new_string('post_status'))
	if rt.is_true(rt.identical(rt.new_null(), var_status)) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('Invalid action ID. No status found.'), rt.new_string('woocommerce')]))))
	}
	return this.get_action_status_by_post_status(var_status.clone())
}

fn (mut this Class_ActionScheduler_wpPostStore) get_post_column(var_action_id rt.PhpVal, var_column_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_column_name), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID=%d AND post_type=%s')), var_action_id.clone(), rt.new_string(Class_ActionScheduler_wpPostStore.post_type())])])
}

fn (mut this Class_ActionScheduler_wpPostStore) log_execution(var_action_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_status_updated := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' SET menu_order = menu_order+1, post_status=%s, post_modified_gmt = %s, post_modified = %s WHERE ID = %d AND post_type = %s')), Class_ActionScheduler_wpPostStore.status_running(), rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]), rt.call_function('current_time', [rt.new_string('mysql')]), var_action_id.clone(), rt.new_string(Class_ActionScheduler_wpPostStore.post_type())])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_status_updated)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to update the status of action %1$d to %2$s.'), rt.new_string('woocommerce')]), var_action_id.clone(), Class_ActionScheduler_wpPostStore.status_running()]))))
	}
}

fn (mut this Class_ActionScheduler_wpPostStore) mark_complete(var_action_id rt.PhpVal) {
	mut var_post := rt.call_function('get_post', [var_action_id.clone()])
	if !rt.is_true(var_post) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), rt.get_property(var_post, 'post_type'))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unidentified action %s: we were unable to mark this action as having completed. It may may have been deleted by another process.'), rt.new_string('woocommerce')]), var_action_id.clone()]))))
	}
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'filter_insert_post_data' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10), rt.new_int(5)])
	mut var_result := rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_action_id }, rt.ArrayItem{ key: 'post_status', val: 'publish' }]), rt.new_bool(true)])
	rt.call_function('remove_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'filter_insert_post_data' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10)])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
	}
	rt.call_function('do_action', [rt.new_string('action_scheduler_completed_action'), var_action_id.clone()])
}

fn (mut this Class_ActionScheduler_wpPostStore) mark_migrated(var_action_id rt.PhpVal) {
	rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_action_id }, rt.ArrayItem{ key: 'post_status', val: 'migrated' }])])
}

fn (mut this Class_ActionScheduler_wpPostStore) migration_dependencies_met(var_setting rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_dependencies_met := rt.call_function('get_transient', [rt.new_string(Class_ActionScheduler_wpPostStore.dependencies_met())])
	if !rt.is_true(var_dependencies_met) {
		mut var_maximum_args_length := rt.call_function('apply_filters', [rt.new_string('action_scheduler_maximum_args_length'), rt.new_int(191)])
		mut var_found_action := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = %s AND CHAR_LENGTH(post_content) > %d LIMIT 1')), var_maximum_args_length.clone(), rt.new_string(Class_ActionScheduler_wpPostStore.post_type())])])
		var_dependencies_met = rt.new_string((if rt.is_true(var_found_action) { 'no' } else { 'yes' }).str())
		rt.call_function('set_transient', [rt.new_string(Class_ActionScheduler_wpPostStore.dependencies_met()), var_dependencies_met.clone(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return if rt.is_true(rt.identical(rt.new_string('yes'), var_dependencies_met)) { var_setting } else { rt.new_bool(false) }
}

fn (mut this Class_ActionScheduler_wpPostStore) validate_action(mut var_action Class_ActionScheduler_Action) {
	mut var_action_mutated := var_action
	this.Class_ActionScheduler_Store.validate_action(rt.new_object('ActionScheduler_Action', []string{}, var_action_mutated))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s Support for strings longer than this will be removed in a future version.'), rt.new_string('woocommerce')]), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])
		rt.call_function('_doing_it_wrong', [rt.new_string('ActionScheduler_Action::$args'), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('2.1.0')])
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
}

fn (mut this Class_ActionScheduler_wpPostStore) init() {
	rt.call_function('add_filter', [rt.new_string('action_scheduler_migration_dependencies_met'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'migration_dependencies_met' }])])
	mut var_post_type_registrar := create_actionscheduler_wppoststore_posttyperegistrar()
	var_post_type_registrar.register()
	mut var_post_status_registrar := create_actionscheduler_wppoststore_poststatusregistrar()
	var_post_status_registrar.register()
	mut var_taxonomy_registrar := create_actionscheduler_wppoststore_taxonomyregistrar()
	var_taxonomy_registrar.register()
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullAction {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_TimezoneHelper {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_ActionClaim {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_ActionScheduler_wpPostStore_PostTypeRegistrar {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_wpPostStore_PostStatusRegistrar {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_wpPostStore_TaxonomyRegistrar {
	rt.PhpObjectBase
}

fn create_actionscheduler_wppoststore(_args ...rt.PhpVal) &Class_ActionScheduler_wpPostStore {
	mut obj := &Class_ActionScheduler_wpPostStore{
		PhpObjectBase: rt.PhpObjectBase{}
		claim_before_date: rt.new_null()
		local_timezone: rt.new_null()
	}
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception(_args ...rt.PhpVal) &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nullaction(_args ...rt.PhpVal) &Class_ActionScheduler_NullAction {
	mut obj := &Class_ActionScheduler_NullAction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_timezonehelper(_args ...rt.PhpVal) &Class_ActionScheduler_TimezoneHelper {
	mut obj := &Class_ActionScheduler_TimezoneHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_actionclaim(_args ...rt.PhpVal) &Class_ActionScheduler_ActionClaim {
	mut obj := &Class_ActionScheduler_ActionClaim{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_actionscheduler_wppoststore_posttyperegistrar(_args ...rt.PhpVal) &Class_ActionScheduler_wpPostStore_PostTypeRegistrar {
	mut obj := &Class_ActionScheduler_wpPostStore_PostTypeRegistrar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_wppoststore_poststatusregistrar(_args ...rt.PhpVal) &Class_ActionScheduler_wpPostStore_PostStatusRegistrar {
	mut obj := &Class_ActionScheduler_wpPostStore_PostStatusRegistrar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_wppoststore_taxonomyregistrar(_args ...rt.PhpVal) &Class_ActionScheduler_wpPostStore_TaxonomyRegistrar {
	mut obj := &Class_ActionScheduler_wpPostStore_TaxonomyRegistrar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_wpPostStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'save_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.save_action(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'create_post_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.create_post_array(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'save_post_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save_post_array(dispatch_arg_0)
		}
		'filter_insert_post_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_insert_post_data(dispatch_arg_0)
		}
		'set_unique_post_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.set_unique_post_slug(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'save_post_schedule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save_post_schedule(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save_action_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save_action_group(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'fetch_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_action(dispatch_arg_0)
		}
		'get_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post(dispatch_arg_0)
		}
		'get_null_action' {
			return this.get_null_action()
		}
		'make_action_from_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.make_action_from_post(dispatch_arg_0)
		}
		'get_action_status_by_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_action_status_by_post_status(dispatch_arg_0)
		}
		'get_post_status_by_action_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post_status_by_action_status(dispatch_arg_0)
		}
		'get_query_actions_sql' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_query_actions_sql(mut dispatch_arg_0, dispatch_arg_1)
		}
		'query_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.query_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'action_counts' {
			return this.action_counts()
		}
		'cancel_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.cancel_action(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_action(dispatch_arg_0)
			return rt.new_null()
		}
		'get_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_date(dispatch_arg_0)
		}
		'get_date_gmt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_date_gmt(dispatch_arg_0)
		}
		'stake_claim' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.stake_claim(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_claim_count' {
			return this.get_claim_count()
		}
		'generate_claim_id' {
			return this.generate_claim_id()
		}
		'claim_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_int(this.claim_actions(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'get_actions_by_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_actions_by_group(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'find_actions_by_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_actions_by_claim_id(dispatch_arg_0)
		}
		'release_claim' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_ActionClaim](if args.len > 0 { args[0] } else { rt.new_null() })
			this.release_claim(mut dispatch_arg_0)
			return rt.new_null()
		}
		'unclaim_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.unclaim_action(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_failure' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mark_failure(dispatch_arg_0)
			return rt.new_null()
		}
		'get_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_claim_id(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_status(dispatch_arg_0)
		}
		'get_post_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_post_column(dispatch_arg_0, dispatch_arg_1)
		}
		'log_execution' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.log_execution(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mark_complete(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_migrated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mark_migrated(dispatch_arg_0)
			return rt.new_null()
		}
		'migration_dependencies_met' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.migration_dependencies_met(dispatch_arg_0)
		}
		'validate_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validate_action(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_wpPostStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'claim_before_date' { return this.claim_before_date }
		'local_timezone' { return this.local_timezone }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_wpPostStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'claim_before_date' { this.claim_before_date = val; return true }
		'local_timezone' { this.local_timezone = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_NullAction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_NullAction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullAction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_TimezoneHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_ActionClaim) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_ActionClaim) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_ActionClaim) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_wpPostStore_PostTypeRegistrar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_wpPostStore_PostTypeRegistrar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpPostStore_PostTypeRegistrar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_wpPostStore_PostStatusRegistrar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpPostStore_PostStatusRegistrar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_wpPostStore_TaxonomyRegistrar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
