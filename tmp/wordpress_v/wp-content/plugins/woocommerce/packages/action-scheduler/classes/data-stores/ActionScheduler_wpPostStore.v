import rt

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
	mut var_post_id := this.save_post_array(var_post_array.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.save_post_schedule(var_post_id.dup(), rt.call_method(var_action_mutated, 'get_schedule', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.save_action_group(var_post_id.dup(), rt.call_method(var_action_mutated, 'get_group', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('action_scheduler_stored_action'), var_post_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_post_id.dup()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
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
	return var_post.dup()
}

fn (mut this Class_ActionScheduler_wpPostStore) save_post_array(var_post_array rt.PhpVal) rt.PhpVal {
	mut var_post_array_mutated := var_post_array
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'filter_insert_post_data' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10), rt.new_int(5)])
	mut var_has_kses := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(var_has_kses) {
		rt.call_function('kses_remove_filters', []rt.PhpVal{})
	}
	mut var_post_id := rt.call_function('wp_insert_post', [var_post_array_mutated.dup()])
	if rt.is_true(var_has_kses) {
		rt.call_function('kses_init_filters', []rt.PhpVal{})
	}
	rt.call_function('remove_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'filter_insert_post_data' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('pre_wp_unique_post_slug'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_unique_post_slug' }]), rt.new_int(10)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_post_id.dup()])) || !rt.is_true(var_post_id))) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.call_function('__', [rt.new_string('Unable to save action.'), rt.new_string('woocommerce')]))))
	}
	return var_post_id.dup()
}

fn (mut this Class_ActionScheduler_wpPostStore) filter_insert_post_data(var_postdata rt.PhpVal) rt.PhpVal {
	mut var_postdata_mutated := var_postdata
	if rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), var_postdata_mutated.array_get('post_type'))) {
		var_postdata_mutated.array_set('post_author', 0)
		if rt.is_true(rt.identical(rt.new_string('future'), var_postdata_mutated.array_get('post_status'))) {
			var_postdata_mutated.array_set('post_status', 'publish')
		}
	}
	return var_postdata_mutated.dup()
}

fn (mut this Class_ActionScheduler_wpPostStore) set_unique_post_slug(var_override_slug rt.PhpVal, var_slug rt.PhpVal, var_post_ID rt.PhpVal, var_post_status rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_override_slug_mutated := var_override_slug
	mut var_post_status_mutated := var_post_status
	if rt.is_true(rt.identical(Class_ActionScheduler_wpPostStore.post_type(), var_post_type)) {
		var_override_slug_mutated = rt.new_string((rt.call_function('uniqid', [Class_ActionScheduler_wpPostStore.post_type() + '-', rt.new_bool(true)])).str() + '-' + (rt.call_function('wp_generate_password', [rt.new_int(32), rt.new_bool(false)])).str())
	}
	return var_override_slug_mutated.dup()
}

fn (mut this Class_ActionScheduler_wpPostStore) save_post_schedule(var_post_id rt.PhpVal, var_schedule rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	mut var_schedule_mutated := var_schedule
	rt.call_function('update_post_meta', [var_post_id_mutated.dup(), Class_ActionScheduler_wpPostStore.schedule_meta_key(), var_schedule_mutated.dup()])
}

fn (mut this Class_ActionScheduler_wpPostStore) save_action_group(var_post_id rt.PhpVal, var_group rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	mut var_group_mutated := var_group
	if !rt.is_true(var_group_mutated) {
		rt.call_function('wp_set_object_terms', [var_post_id_mutated.dup(), rt.new_array(), Class_ActionScheduler_wpPostStore.group_taxonomy(), rt.new_bool(false)])
	} else {
		rt.call_function('wp_set_object_terms', [var_post_id_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_group_mutated }]), Class_ActionScheduler_wpPostStore.group_taxonomy(), rt.new_bool(false)])
	}
}

fn (mut this Class_ActionScheduler_wpPostStore) fetch_action(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_action_id.dup())
	if rt.is_true(rt.new_bool(!rt.is_true(var_post) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return this.get_null_action()
	}
	mut var_action := this.make_action_from_post(var_post.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'ActionScheduler_InvalidActionException') {
		mut var_exception := var_e_2.dup()
		rt.call_function('do_action', [rt.new_string('action_scheduler_failed_fetch_action'), rt.get_property(var_post, 'ID'), var_exception.dup()])
		return this.get_null_action()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return var_action.dup()
}

fn (mut this Class_ActionScheduler_wpPostStore) get_post(var_action_id rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_action_id) {
		return rt.new_null()
	}
	return rt.call_function('get_post', [var_action_id.dup()])
}

fn (mut this Class_ActionScheduler_wpPostStore) get_null_action() rt.PhpVal {
	return create_actionscheduler_nullaction()
}

fn (mut this Class_ActionScheduler_wpPostStore) make_action_from_post(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_hook := rt.get_property(var_post_mutated, 'post_title')
	mut var_args := rt.call_function('json_decode', [rt.get_property(var_post_mutated, 'post_content'), rt.new_bool(true)])
	this.validate_args(var_args.dup(), rt.get_property(var_post_mutated, 'ID'))
	mut var_schedule := rt.call_function('get_post_meta', [rt.get_property(var_post_mutated, 'ID'), Class_ActionScheduler_wpPostStore.schedule_meta_key(), rt.new_bool(true)])
	this.validate_schedule(var_schedule.dup(), rt.get_property(var_post_mutated, 'ID'))
	mut var_group := rt.call_function('wp_get_object_terms', [rt.get_property(var_post_mutated, 'ID'), Class_ActionScheduler_wpPostStore.group_taxonomy(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }])])
	var_group = if !rt.is_true(var_group) { rt.new_string('') } else { rt.call_function('reset', [var_group.dup()]) }
	return rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.factory() }(), 'get_stored_action', [this.get_action_status_by_post_status(rt.get_property(var_post_mutated, 'post_status')), var_hook.dup(), var_args.dup(), var_schedule.dup(), var_group.dup()])
}

fn (mut this Class_ActionScheduler_wpPostStore) get_action_status_by_post_status(var_post_status rt.PhpVal) rt.PhpVal {
	mut var_post_status_mutated := var_post_status
	mut switch_val_1 := var_post_status_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish'))) {
		mut var_action_status := Class_ActionScheduler_wpPostStore.status_complete()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash'))) {
		var_action_status = Class_ActionScheduler_wpPostStore.status_canceled()
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.get_status_labels().array_isset(var_post_status_mutated.dup())))))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Invalid post status: "%s". No matching action status available.'), var_post_status_mutated.dup()]))))
		}
		var_action_status = var_post_status_mutated.dup()
	}
	return var_action_status.dup()
}

fn (mut this Class_ActionScheduler_wpPostStore) get_post_status_by_action_status(var_action_status rt.PhpVal) rt.PhpVal {
	mut var_action_status_mutated := var_action_status
	mut switch_val_2 := var_action_status_mutated
	if rt.is_true(rt.equal(switch_val_2, Class_ActionScheduler_wpPostStore.status_complete())) {
		mut var_post_status := rt.new_string(rt.new_string('publish'))
	} else if rt.is_true(rt.equal(switch_val_2, Class_ActionScheduler_wpPostStore.status_canceled())) {
		var_post_status = rt.new_string(rt.new_string('trash'))
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.get_status_labels().array_isset(var_action_status_mutated.dup())))))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Invalid action status: "%s".'), var_action_status_mutated.dup()]))))
		}
		var_post_status = var_action_status_mutated.dup()
	}
	return var_post_status.dup()
}

fn (mut this Class_ActionScheduler_wpPostStore) get_query_actions_sql(mut var_query Class_array, select_or_count string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(select_or_count), rt.create_array([rt.ArrayItem{ key: none, val: 'select' }, rt.ArrayItem{ key: none, val: 'count' }]), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('Invalid schedule. Cannot save action.'), rt.new_string('woocommerce')]))))
	}
	var_query_mutated = rt.call_function('wp_parse_args', [var_query_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'hook', val: '' }, rt.ArrayItem{ key: 'args', val: rt.new_null() }, rt.ArrayItem{ key: 'date', val: rt.new_null() }, rt.ArrayItem{ key: 'date_compare', val: '<=' }, rt.ArrayItem{ key: 'modified', val: rt.new_null() }, rt.ArrayItem{ key: 'modified_compare', val: '<=' }, rt.ArrayItem{ key: 'group', val: '' }, rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'claimed', val: rt.new_null() }, rt.ArrayItem{ key: 'per_page', val: 5 }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'search', val: '' }])])
	// unsupported statement: Stmt_Global
	mut var_sql := rt.new_string(if rt.is_true(rt.identical(rt.new_string('count'), rt.new_string(select_or_count))) { rt.new_string('SELECT count(p.ID)') } else { rt.new_string('SELECT p.ID ') })
	// unsupported expression: Expr_AssignOp_Concat
	mut var_sql_params := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(var_query_mutated.array_get('group')) && rt.is_true(rt.identical(rt.new_string('group'), var_query_mutated.array_get('orderby'))))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else if !(!rt.is_true(var_query_mutated.array_get('group'))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params.array_push(var_query_mutated.array_get('group'))
	}
	// unsupported expression: Expr_AssignOp_Concat
	var_sql_params.array_push(Class_ActionScheduler_wpPostStore.post_type())
	if rt.is_true(var_query_mutated.array_get('hook')) {
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params.array_push(var_query_mutated.array_get('hook'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_query_mutated.array_get('args').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params.array_push(rt.call_function('wp_json_encode', [var_query_mutated.array_get('args')]))
	}
	if rt.is_true(var_query_mutated.array_get('status')) {
		mut var_post_statuses := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_wpPostStore', ['ActionScheduler_Store'], &this) }, rt.ArrayItem{ key: none, val: 'get_post_status_by_action_status' }]), rt.cast_array(var_query_mutated.array_get('status'))])
		mut var_placeholders := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_post_statuses.dup().array_count()), rt.new_string('%s')])
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params = rt.call_function('array_merge', [var_sql_params.dup(), rt.call_function('array_values', [var_post_statuses.dup()])])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_query_mutated.array_get('date'), 'DateTime'))) {
		mut var_date := // unsupported expression: Expr_Clone
		rt.call_method(var_date, 'setTimezone', [create_datetimezone(rt.new_string('UTC'))])
		mut var_date_string := rt.call_method(var_date, 'format', [rt.new_string('Y-m-d H:i:s')])
		mut var_comparator := this.validate_sql_comparator(var_query_mutated.array_get('date_compare'))
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params.array_push(var_date_string.dup())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_query_mutated.array_get('modified'), 'DateTime'))) {
		mut var_modified := // unsupported expression: Expr_Clone
		rt.call_method(var_modified, 'setTimezone', [create_datetimezone(rt.new_string('UTC'))])
		var_date_string = rt.call_method(var_modified, 'format', [rt.new_string('Y-m-d H:i:s')])
		var_comparator = this.validate_sql_comparator(var_query_mutated.array_get('modified_compare'))
		// unsupported expression: Expr_AssignOp_Concat
		var_sql_params.array_push(var_date_string.dup())
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_query_mutated.array_get('claimed'))) {
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.identical(rt.new_bool(false), .array_get())) {
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		
	}
	if !(!rt.is_true()) {
	}
	if rt.is_true() {
	}
	return 
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) query_actions(var_query rt.PhpVal, query_type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_mutated := var_query
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) action_counts() rt.PhpVal {
}

fn (mut this Class_ActionScheduler_wpPostStore) cancel_action(var_action_id rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_wpPostStore) delete_action(var_action_id rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_wpPostStore) get_date(var_action_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_ActionScheduler_wpPostStore) get_date_gmt(var_action_id rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) stake_claim(max_actions i64, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) rt.PhpVal {
	mut var_before_date_mutated := var_before_date
	mut group_mutated := group
}

fn (mut this Class_ActionScheduler_wpPostStore) get_claim_count() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) generate_claim_id() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) claim_actions(var_claim_id rt.PhpVal, var_limit rt.PhpVal, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) i64 {
	mut var_wpdb := rt.new_null()
	mut var_claim_id_mutated := var_claim_id
	mut var_before_date_mutated := var_before_date
	mut group_mutated := group
}

fn (mut this Class_ActionScheduler_wpPostStore) get_actions_by_group(var_group rt.PhpVal, var_limit rt.PhpVal, mut var_date Class_DateTime) rt.PhpVal {
	mut var_group_mutated := var_group
	mut var_date_mutated := var_date
}

fn (mut this Class_ActionScheduler_wpPostStore) find_actions_by_claim_id(var_claim_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_claim_id_mutated := var_claim_id
}

fn (mut this Class_ActionScheduler_wpPostStore) release_claim(mut var_claim Class_ActionScheduler_ActionClaim)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) unclaim_action(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) mark_failure(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) get_claim_id(var_action_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_ActionScheduler_wpPostStore) get_status(var_action_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_ActionScheduler_wpPostStore) get_post_column(var_action_id rt.PhpVal, var_column_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) log_execution(var_action_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) mark_complete(var_action_id rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_wpPostStore) mark_migrated(var_action_id rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_wpPostStore) migration_dependencies_met(var_setting rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_ActionScheduler_wpPostStore) validate_action(mut var_action Class_ActionScheduler_Action)  {
	mut var_action_mutated := var_action
}

fn (mut this Class_ActionScheduler_wpPostStore) init()  {
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

fn create_actionscheduler_wppoststore() &Class_ActionScheduler_wpPostStore {
	mut obj := &Class_ActionScheduler_wpPostStore{
		PhpObjectBase: rt.PhpObjectBase{}
		claim_before_date: rt.new_null()
		local_timezone: rt.new_null()
	}
	return obj
}

fn create_actionscheduler_store() &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception() &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nullaction() &Class_ActionScheduler_NullAction {
	mut obj := &Class_ActionScheduler_NullAction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_data_stores_actionscheduler_wppoststore_php() {
}
