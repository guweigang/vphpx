import rt

pub fn Class_ActionScheduler_Store.status_complete() string {
	return 'complete'
}
pub fn Class_ActionScheduler_Store.status_pending() string {
	return 'pending'
}
pub fn Class_ActionScheduler_Store.status_running() string {
	return 'in-progress'
}
pub fn Class_ActionScheduler_Store.status_failed() string {
	return 'failed'
}
pub fn Class_ActionScheduler_Store.status_canceled() string {
	return 'canceled'
}
pub fn Class_ActionScheduler_Store.default_class() string {
	return 'ActionScheduler_wpPostStore'
}
struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

fn init_static_actionscheduler_store() {
		rt.init_static_prop('ActionScheduler_Store', 'store', rt.new_null())
		rt.init_static_prop('ActionScheduler_Store', 'max_args_length', rt.new_int(191))
}

fn (mut this Class_ActionScheduler_Store) save_action(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime) {
}

fn (mut this Class_ActionScheduler_Store) fetch_action(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) find_action(var_hook rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_params_mutated := var_params
	var_params_mutated = rt.call_function('wp_parse_args', [var_params_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.new_null() }, rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_pending() }, rt.ArrayItem{ key: 'group', val: '' }])])
	var_params_mutated.array_set('hook', var_hook.clone())
	var_params_mutated.array_set('orderby', 'date')
	var_params_mutated.array_set('per_page', 1)
	if !(!rt.is_true(var_params_mutated.array_get(rt.new_string('status')))) {
		if rt.is_true(rt.identical(Class_ActionScheduler_Store.status_pending(), var_params_mutated.array_get(rt.new_string('status')))) {
			var_params_mutated.array_set('order', 'ASC')
		} else {
			var_params_mutated.array_set('order', 'DESC')
		}
	}
	mut var_results := this.query_actions(var_params_mutated.clone(), '')
	return if !rt.is_true(var_results) { rt.new_null() } else { var_results.array_get(rt.new_int(0)) }
}

fn (mut this Class_ActionScheduler_Store) query_actions(var_query rt.PhpVal, query_type string) {
	mut var_query_mutated := var_query
}

fn (mut this Class_ActionScheduler_Store) query_action(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	var_query_mutated.array_set('per_page', 1)
	var_query_mutated.array_set('offset', 0)
	mut var_results := this.query_actions(var_query_mutated.clone(), '')
	if !rt.is_true(var_results) {
		return rt.new_null()
	} else {
		return rt.new_int((var_results.array_get(rt.new_int(0))).to_i64())
	}
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_Store) action_counts() {
}

fn (mut this Class_ActionScheduler_Store) extra_action_counts() rt.PhpVal {
	mut var_extra_actions := map[string]rt.PhpVal{}
	mut var_pastdue_action_counts := rt.new_int((this.query_actions(rt.create_array([rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_pending() }, rt.ArrayItem{ key: 'date', val: rt.call_function('as_get_datetime_object', []rt.PhpVal{}) }]), 'count')).to_i64())
	if rt.is_true(var_pastdue_action_counts) {
		var_extra_actions['past-due'] = var_pastdue_action_counts.clone()
	}
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_extra_action_counts'), rt.create_array_from_native_map(var_extra_actions)])
}

fn (mut this Class_ActionScheduler_Store) cancel_action(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) delete_action(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) get_date(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) stake_claim(max_actions i64, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) {
}

fn (mut this Class_ActionScheduler_Store) get_claim_count() {
}

fn (mut this Class_ActionScheduler_Store) release_claim(mut var_claim Class_ActionScheduler_ActionClaim) {
}

fn (mut this Class_ActionScheduler_Store) unclaim_action(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) mark_failure(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) log_execution(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) mark_complete(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) get_status(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) get_claim_id(var_action_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) find_actions_by_claim_id(var_claim_id rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Store) validate_sql_comparator(var_comparison_operator rt.PhpVal) string {
	if rt.is_true(rt.call_function('in_array', [var_comparison_operator.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '!=' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '<' }, rt.ArrayItem{ key: none, val: '<=' }, rt.ArrayItem{ key: none, val: '=' }]), rt.new_bool(true)])) {
		return (var_comparison_operator).str()
	}
	return '='
}

fn (mut this Class_ActionScheduler_Store) get_scheduled_date_string(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime) rt.PhpVal {
	mut var_next := if var_scheduled_date.is_null() { rt.call_method(var_action.get_schedule(), 'get_date', []rt.PhpVal{}) } else { var_scheduled_date }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_next)))) {
	var_next = rt.call_function('date_create', []rt.PhpVal{})
	}
	rt.call_method(var_next, 'setTimezone', [create_datetimezone(rt.new_string('UTC'))])
	return rt.call_method(var_next, 'format', [rt.new_string('Y-m-d H:i:s')])
}

fn (mut this Class_ActionScheduler_Store) get_scheduled_date_string_local(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime) rt.PhpVal {
	mut var_next := if var_scheduled_date.is_null() { rt.call_method(var_action.get_schedule(), 'get_date', []rt.PhpVal{}) } else { var_scheduled_date }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_next)))) {
	var_next = rt.call_function('date_create', []rt.PhpVal{})
	}
	mut iife_temp_0 := Class_ActionScheduler_TimezoneHelper{}
	mut iife_result_0 := iife_temp_0.set_local_timezone(var_next.clone())
	return rt.call_method(var_next, 'format', [rt.new_string('Y-m-d H:i:s')])
}

fn (mut this Class_ActionScheduler_Store) validate_args(var_args rt.PhpVal, var_action_id rt.PhpVal) {
	if !(var_args.clone().is_array()) {
		mut iife_temp_1 := Class_ActionScheduler_InvalidActionException{}
		mut iife_result_1 := iife_temp_1.from_decoding_args(var_action_id.clone())
		rt.throw_exception(iife_result_1)
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('json_last_error')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'), rt.call_function('json_last_error', []rt.PhpVal{}))))) {
		mut iife_temp_2 := Class_ActionScheduler_InvalidActionException{}
		mut iife_result_2 := iife_temp_2.from_decoding_args(var_action_id.clone(), var_args.clone())
		rt.throw_exception(iife_result_2)
	}
}

fn (mut this Class_ActionScheduler_Store) validate_schedule(var_schedule rt.PhpVal, var_action_id rt.PhpVal) {
	if !rt.is_true(var_schedule) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_schedule.clone(), rt.new_string('ActionScheduler_Schedule')]))))) {
		mut iife_temp_3 := Class_ActionScheduler_InvalidActionException{}
		mut iife_result_3 := iife_temp_3.from_schedule(var_action_id.clone(), var_schedule.clone())
		rt.throw_exception(iife_result_3)
	}
}

fn (mut this Class_ActionScheduler_Store) validate_action(mut var_action Class_ActionScheduler_Action) {
	if rt.is_true(rt.greater(rt.new_int(rt.call_function('wp_json_encode', [var_action.get_args()]).to_string().len), rt.get_static_prop('ActionScheduler_Store', 'max_args_length'))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('ActionScheduler_Action::$args too long. To ensure the args column can be indexed, action args should not be more than %d characters when encoded as JSON.'), rt.new_string('woocommerce')]), rt.get_static_prop('ActionScheduler_Store', 'max_args_length')]))))
	}
}

fn (mut this Class_ActionScheduler_Store) cancel_actions_by_hook(var_hook rt.PhpVal) {
	mut var_action_ids := rt.new_bool(true)
	for !(!rt.is_true(var_action_ids)) {
		var_action_ids = this.query_actions(rt.create_array([rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_pending() }, rt.ArrayItem{ key: 'per_page', val: 1000 }, rt.ArrayItem{ key: 'orderby', val: 'none' }]), '')
		this.bulk_cancel_actions(var_action_ids.clone())
	}
}

fn (mut this Class_ActionScheduler_Store) cancel_actions_by_group(var_group rt.PhpVal) {
	mut var_action_ids := rt.new_bool(true)
	for !(!rt.is_true(var_action_ids)) {
		var_action_ids = this.query_actions(rt.create_array([rt.ArrayItem{ key: 'group', val: var_group }, rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_pending() }, rt.ArrayItem{ key: 'per_page', val: 1000 }, rt.ArrayItem{ key: 'orderby', val: 'none' }]), '')
		this.bulk_cancel_actions(var_action_ids.clone())
	}
}

fn (mut this Class_ActionScheduler_Store) bulk_cancel_actions(var_action_ids rt.PhpVal) {
	mut var_action_ids_mutated := var_action_ids
	mut iter_1 := var_action_ids_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action_id := item_1.val
		this.cancel_action(var_action_id.clone())
	}
	rt.call_function('do_action', [rt.new_string('action_scheduler_bulk_cancel_actions'), var_action_ids_mutated.clone()])
}

fn (mut this Class_ActionScheduler_Store) get_status_labels() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: Class_ActionScheduler_Store.status_complete(), val: rt.call_function('__', [rt.new_string('Complete'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_ActionScheduler_Store.status_pending(), val: rt.call_function('__', [rt.new_string('Pending'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_ActionScheduler_Store.status_running(), val: rt.call_function('__', [rt.new_string('In-progress'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_ActionScheduler_Store.status_failed(), val: rt.call_function('__', [rt.new_string('Failed'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_ActionScheduler_Store.status_canceled(), val: rt.call_function('__', [rt.new_string('Canceled'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_ActionScheduler_Store) has_pending_actions_due() bool {
	mut var_pending_actions := this.query_actions(rt.create_array([rt.ArrayItem{ key: 'per_page', val: 1 }, rt.ArrayItem{ key: 'date', val: rt.call_function('as_get_datetime_object', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_pending() }, rt.ArrayItem{ key: 'orderby', val: 'none' }]), 'count')
	return !(!rt.is_true(var_pending_actions))
}

fn (mut this Class_ActionScheduler_Store) init() {
}

fn (mut this Class_ActionScheduler_Store) mark_migrated(var_action_id rt.PhpVal) {
}

fn Class_ActionScheduler_Store.instance() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('ActionScheduler_Store', 'store')) {
		mut var_class := rt.call_function('apply_filters', [rt.new_string('action_scheduler_store_class'), rt.new_string(Class_ActionScheduler_Store.default_class())])
		rt.set_static_prop('ActionScheduler_Store', 'store', rt.new_object('', []string{}, rt.create_object_dynamically(var_class, []rt.PhpVal{})))
	}
	return rt.get_static_prop('ActionScheduler_Store', 'store')
}

struct Class_ActionScheduler_Store_Deprecated {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_TimezoneHelper {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_InvalidActionException {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store_deprecated(_args ...rt.PhpVal) &Class_ActionScheduler_Store_Deprecated {
	mut obj := &Class_ActionScheduler_Store_Deprecated{
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

fn create_actionscheduler_invalidactionexception(_args ...rt.PhpVal) &Class_ActionScheduler_InvalidActionException {
	mut obj := &Class_ActionScheduler_InvalidActionException{
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

fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'save_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			this.save_action(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'fetch_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.fetch_action(dispatch_arg_0)
			return rt.new_null()
		}
		'find_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.find_action(dispatch_arg_0, dispatch_arg_1)
		}
		'query_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.query_actions(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'query_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query_action(dispatch_arg_0)
		}
		'action_counts' {
			this.action_counts()
			return rt.new_null()
		}
		'extra_action_counts' {
			return this.extra_action_counts()
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
			this.get_date(dispatch_arg_0)
			return rt.new_null()
		}
		'stake_claim' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.stake_claim(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_claim_count' {
			this.get_claim_count()
			return rt.new_null()
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
		'get_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_status(dispatch_arg_0)
			return rt.new_null()
		}
		'get_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_claim_id(dispatch_arg_0)
			return rt.new_null()
		}
		'find_actions_by_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.find_actions_by_claim_id(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_sql_comparator' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.validate_sql_comparator(dispatch_arg_0))
		}
		'get_scheduled_date_string' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_scheduled_date_string(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_scheduled_date_string_local' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_scheduled_date_string_local(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'validate_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_args(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_schedule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_schedule(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validate_action(mut dispatch_arg_0)
			return rt.new_null()
		}
		'cancel_actions_by_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.cancel_actions_by_hook(dispatch_arg_0)
			return rt.new_null()
		}
		'cancel_actions_by_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.cancel_actions_by_group(dispatch_arg_0)
			return rt.new_null()
		}
		'bulk_cancel_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bulk_cancel_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'get_status_labels' {
			return this.get_status_labels()
		}
		'has_pending_actions_due' {
			return rt.new_bool(this.has_pending_actions_due())
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'mark_migrated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mark_migrated(dispatch_arg_0)
			return rt.new_null()
		}
		'instance' {
			return Class_ActionScheduler_Store.instance()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Store_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ActionScheduler_InvalidActionException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_InvalidActionException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_InvalidActionException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
	rt.register_class_factory('ActionScheduler_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_store()
		return rt.new_object('ActionScheduler_Store', ['ActionScheduler_Store_Deprecated'], obj)
	})
	rt.register_class_factory('ActionScheduler_Store_Deprecated', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_store_deprecated()
		return rt.new_object('ActionScheduler_Store_Deprecated', []string{}, obj)
	})
	rt.register_class_factory('DateTimeZone', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_datetimezone()
		return rt.new_object('DateTimeZone', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_TimezoneHelper', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_timezonehelper()
		return rt.new_object('ActionScheduler_TimezoneHelper', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_InvalidActionException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_invalidactionexception()
		return rt.new_object('ActionScheduler_InvalidActionException', []string{}, obj)
	})
	rt.register_class_factory('InvalidArgumentException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_invalidargumentexception()
		return rt.new_object('InvalidArgumentException', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
