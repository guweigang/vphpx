import rt

pub fn Class_ActionScheduler_HybridStore.demarkation_option() string {
	return 'action_scheduler_hybrid_store_demarkation'
}
struct Class_ActionScheduler_HybridStore {
	rt.PhpObjectBase
pub mut:
		primary_store rt.PhpVal = rt.new_null()
		secondary_store rt.PhpVal = rt.new_null()
		migration_runner rt.PhpVal = rt.new_null()
		demarkation_id rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_ActionScheduler_HybridStore) construct(mut var_config Class_?Config)  {
	mut var_config_mutated := var_config
	this.demarkation_id = // unsupported expression: Expr_Cast_Int
	if !rt.is_true(var_config_mutated) {
		var_config_mutated = rt.call_method(fn () rt.PhpVal { mut temp := Class_Action_Scheduler_Migration_Controller{}; return temp.instance() }(), 'get_migration_config_object', []rt.PhpVal{})
	}
	this.primary_store = rt.call_method(var_config_mutated, 'get_destination_store', []rt.PhpVal{})
	this.secondary_store = rt.call_method(var_config_mutated, 'get_source_store', []rt.PhpVal{})
	this.migration_runner = create_action_scheduler_migration_runner(var_config_mutated.dup())
}

fn (mut this Class_ActionScheduler_HybridStore) init()  {
	rt.call_function('add_action', [rt.new_string('action_scheduler/created_table'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_HybridStore', ['Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_autoincrement' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_method(this.primary_store, 'init', []rt.PhpVal{})
	rt.call_method(this.secondary_store, 'init', []rt.PhpVal{})
	rt.call_function('remove_action', [rt.new_string('action_scheduler/created_table'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_HybridStore', ['Store'], &this) }, rt.ArrayItem{ key: none, val: 'set_autoincrement' }]), rt.new_int(10)])
}

fn (mut this Class_ActionScheduler_HybridStore) set_autoincrement(var_table_name rt.PhpVal, var_table_suffix rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(Class_ActionScheduler_StoreSchema.actions_table(), var_table_suffix)) {
		if !rt.is_true(this.demarkation_id) {
			this.demarkation_id = this.set_demarkation_id(rt.new_null())
		}
		// unsupported statement: Stmt_Global
		mut var_default_date := create_datetime(rt.new_string('tomorrow'))
		mut var_null_action := create_actionscheduler_nullaction()
		mut var_date_gmt := this.get_scheduled_date_string(rt.new_object('ActionScheduler_NullAction', []string{}, var_null_action), rt.new_object('DateTime', []string{}, var_default_date))
		mut var_date_local := this.get_scheduled_date_string_local(rt.new_object('ActionScheduler_NullAction', []string{}, var_null_action), rt.new_object('DateTime', []string{}, var_default_date))
		mut var_row_count := rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, '{"nodeType":"Expr_ClassConstFetch","line":115,"class":"ActionScheduler_StoreSchema","name":"ACTIONS_TABLE"}'), rt.create_array([rt.ArrayItem{ key: 'action_id', val: this.demarkation_id }, rt.ArrayItem{ key: 'hook', val: '' }, rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'scheduled_date_gmt', val: var_date_gmt }, rt.ArrayItem{ key: 'scheduled_date_local', val: var_date_local }, rt.ArrayItem{ key: 'last_attempt_gmt', val: var_date_gmt }, rt.ArrayItem{ key: 'last_attempt_local', val: var_date_local }])])
		if rt.is_true(rt.greater(var_row_count, rt.new_int(0))) {
			rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, '{"nodeType":"Expr_ClassConstFetch","line":128,"class":"ActionScheduler_StoreSchema","name":"ACTIONS_TABLE"}'), rt.create_array([rt.ArrayItem{ key: 'action_id', val: this.demarkation_id }])])
		}
	}
}

fn (mut this Class_ActionScheduler_HybridStore) set_demarkation_id(var_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	if !rt.is_true(var_id_mutated) {
		// unsupported statement: Stmt_Global
		var_id_mutated = // unsupported expression: Expr_Cast_Int
		rt.post_inc(var_id_mutated)
	}
	rt.call_function('update_option', [Class_ActionScheduler_HybridStore.demarkation_option(), var_id_mutated.dup()])
	return var_id_mutated.dup()
}

fn (mut this Class_ActionScheduler_HybridStore) find_action(var_hook rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_found_unmigrated_action := rt.call_method(this.secondary_store, 'find_action', [var_hook.dup(), var_params.dup()])
	if !(!rt.is_true(var_found_unmigrated_action)) {
		this.migrate(rt.create_array([rt.ArrayItem{ key: none, val: var_found_unmigrated_action }]))
	}
	return rt.call_method(this.primary_store, 'find_action', [var_hook.dup(), var_params.dup()])
}

fn (mut this Class_ActionScheduler_HybridStore) query_actions(var_query rt.PhpVal, query_type string) rt.PhpVal {
	mut var_found_unmigrated_actions := rt.call_method(this.secondary_store, 'query_actions', [var_query.dup(), rt.new_string('select')])
	if !(!rt.is_true(var_found_unmigrated_actions)) {
		this.migrate(var_found_unmigrated_actions.dup())
	}
	return rt.call_method(this.primary_store, 'query_actions', [var_query.dup(), rt.new_string(query_type)])
}

fn (mut this Class_ActionScheduler_HybridStore) action_counts() rt.PhpVal {
	mut var_unmigrated_actions_count := rt.call_method(this.secondary_store, 'action_counts', []rt.PhpVal{})
	mut var_migrated_actions_count := rt.call_method(this.primary_store, 'action_counts', []rt.PhpVal{})
	mut var_actions_count_by_status := rt.new_array()
	{
		mut iter_1 := this.get_status_labels().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status_label := item_1.val
			mut var_status_key := item_1.key
			mut var_count := rt.new_int(rt.new_int(0))
			if var_unmigrated_actions_count.array_isset(var_status_key) {
				// unsupported expression: Expr_AssignOp_Plus
			}
			if var_migrated_actions_count.array_isset(var_status_key) {
				// unsupported expression: Expr_AssignOp_Plus
			}
			var_actions_count_by_status.array_set(var_status_key, var_count.dup())
		}
	}
	var_actions_count_by_status = rt.call_function('array_filter', [var_actions_count_by_status.dup()])
	return var_actions_count_by_status.dup()
}

fn (mut this Class_ActionScheduler_HybridStore) stake_claim(max_actions i64, mut var_before_date Class_?DateTime, var_hooks rt.PhpVal, group string) rt.PhpVal {
	mut var_claim := rt.call_method(this.secondary_store, 'stake_claim', [rt.new_int(max_actions), var_before_date, var_hooks.dup(), rt.new_string(group)])
	mut var_claimed_actions := rt.call_method(var_claim, 'get_actions', []rt.PhpVal{})
	if !(!rt.is_true(var_claimed_actions)) {
		this.migrate(var_claimed_actions.dup())
	}
	rt.call_method(this.secondary_store, 'release_claim', [var_claim.dup()])
	return rt.call_method(this.primary_store, 'stake_claim', [rt.new_int(max_actions), var_before_date, var_hooks.dup(), rt.new_string(group)])
}

fn (mut this Class_ActionScheduler_HybridStore) migrate(var_action_ids rt.PhpVal)  {
	rt.call_method(this.migration_runner, 'migrate_actions', [var_action_ids.dup()])
}

fn (mut this Class_ActionScheduler_HybridStore) save_action(mut var_action Class_ActionScheduler_Action, mut var_date Class_?DateTime) rt.PhpVal {
	mut var_action_mutated := var_action
	return rt.call_method(this.primary_store, 'save_action', [var_action_mutated.dup(), var_date])
}

fn (mut this Class_ActionScheduler_HybridStore) fetch_action(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), true)
	if rt.is_true(var_store) {
		return rt.call_method(var_store, 'fetch_action', [var_action_id.dup()])
	} else {
		return create_actionscheduler_nullaction()
	}
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_HybridStore) cancel_action(var_action_id rt.PhpVal)  {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), false)
	if rt.is_true(var_store) {
		rt.call_method(var_store, 'cancel_action', [var_action_id.dup()])
	}
}

fn (mut this Class_ActionScheduler_HybridStore) delete_action(var_action_id rt.PhpVal)  {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), false)
	if rt.is_true(var_store) {
		rt.call_method(var_store, 'delete_action', [var_action_id.dup()])
	}
}

fn (mut this Class_ActionScheduler_HybridStore) get_date(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), false)
	if rt.is_true(var_store) {
		return rt.call_method(var_store, 'get_date', [var_action_id.dup()])
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_HybridStore) mark_failure(var_action_id rt.PhpVal)  {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), false)
	if rt.is_true(var_store) {
		rt.call_method(var_store, 'mark_failure', [var_action_id.dup()])
	}
}

fn (mut this Class_ActionScheduler_HybridStore) log_execution(var_action_id rt.PhpVal)  {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), false)
	if rt.is_true(var_store) {
		rt.call_method(var_store, 'log_execution', [var_action_id.dup()])
	}
}

fn (mut this Class_ActionScheduler_HybridStore) mark_complete(var_action_id rt.PhpVal)  {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), false)
	if rt.is_true(var_store) {
		rt.call_method(var_store, 'mark_complete', [var_action_id.dup()])
	}
}

fn (mut this Class_ActionScheduler_HybridStore) get_status(var_action_id rt.PhpVal) rt.PhpVal {
	mut var_store := this.get_store_from_action_id(var_action_id.dup(), false)
	if rt.is_true(var_store) {
		return rt.call_method(var_store, 'get_status', [var_action_id.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_HybridStore) get_store_from_action_id(var_action_id rt.PhpVal, primary_first bool) rt.PhpVal {
	if var_primary_first {
		mut var_stores := [this.primary_store, this.secondary_store]
	} else if rt.is_true(rt.less(var_action_id, this.demarkation_id)) {
		var_stores = [this.secondary_store, this.primary_store]
	} else {
		var_stores = [this.primary_store]
	}
	for var_store in var_stores {
		mut var_action := rt.call_method(var_store, 'fetch_action', [var_action_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_action.dup(), rt.new_string('ActionScheduler_NullAction')]))))) {
			return var_store.dup()
		}
	}
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_HybridStore) get_claim_count() rt.PhpVal {
	return rt.call_method(this.primary_store, 'get_claim_count', []rt.PhpVal{})
}

fn (mut this Class_ActionScheduler_HybridStore) get_claim_id(var_action_id rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.primary_store, 'get_claim_id', [var_action_id.dup()])
}

fn (mut this Class_ActionScheduler_HybridStore) release_claim(mut var_claim Class_ActionScheduler_ActionClaim)  {
	mut var_claim_mutated := var_claim
	rt.call_method(this.primary_store, 'release_claim', [var_claim_mutated.dup()])
}

fn (mut this Class_ActionScheduler_HybridStore) unclaim_action(var_action_id rt.PhpVal)  {
	rt.call_method(this.primary_store, 'unclaim_action', [var_action_id.dup()])
}

fn (mut this Class_ActionScheduler_HybridStore) find_actions_by_claim_id(var_claim_id rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.primary_store, 'find_actions_by_claim_id', [var_claim_id.dup()])
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Controller {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Runner {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullAction {
	rt.PhpObjectBase
}

fn create_actionscheduler_hybridstore(arg_0 rt.PhpVal) &Class_ActionScheduler_HybridStore {
	mut obj := &Class_ActionScheduler_HybridStore{
		PhpObjectBase: rt.PhpObjectBase{}
		primary_store: rt.new_null()
		secondary_store: rt.new_null()
		migration_runner: rt.new_null()
		demarkation_id: rt.new_int(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_actionscheduler_store() &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_controller() &Class_Action_Scheduler_Migration_Controller {
	mut obj := &Class_Action_Scheduler_Migration_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_runner() &Class_Action_Scheduler_Migration_Runner {
	mut obj := &Class_Action_Scheduler_Migration_Runner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
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

fn (mut this Class_ActionScheduler_HybridStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?Config](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'set_autoincrement' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_autoincrement(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_demarkation_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_demarkation_id(dispatch_arg_0)
		}
		'find_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.find_action(dispatch_arg_0, dispatch_arg_1)
		}
		'query_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.query_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'action_counts' {
			return this.action_counts()
		}
		'stake_claim' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.stake_claim(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'migrate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.migrate(dispatch_arg_0)
			return rt.new_null()
		}
		'save_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.save_action(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'fetch_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_action(dispatch_arg_0)
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
			return this.get_status(dispatch_arg_0)
		}
		'get_store_from_action_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_store_from_action_id(dispatch_arg_0, dispatch_arg_1)
		}
		'get_claim_count' {
			return this.get_claim_count()
		}
		'get_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_claim_id(dispatch_arg_0)
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
		'find_actions_by_claim_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_actions_by_claim_id(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_HybridStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'primary_store' { return this.primary_store }
		'secondary_store' { return this.secondary_store }
		'migration_runner' { return this.migration_runner }
		'demarkation_id' { return this.demarkation_id }
		else { return this.Class_Store.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_HybridStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'primary_store' { this.primary_store = val; return true }
		'secondary_store' { this.secondary_store = val; return true }
		'migration_runner' { this.migration_runner = val; return true }
		'demarkation_id' { this.demarkation_id = val; return true }
		else { return this.Class_Store.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Runner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_data_stores_actionscheduler_hybridstore_php() {
}
