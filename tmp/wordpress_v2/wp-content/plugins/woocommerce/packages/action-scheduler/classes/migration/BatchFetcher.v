import rt

struct Class_Action_Scheduler_Migration_BatchFetcher {
	rt.PhpObjectBase
pub mut:
	store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_BatchFetcher) construct(mut var_source_store Class_ActionScheduler_Store) {
	this.store = var_source_store
}

fn (mut this Class_Action_Scheduler_Migration_BatchFetcher) fetch(count i64) rt.PhpVal {
	mut iter_1 := this.get_query_strategies(rt.new_int(count)).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_query := item_1.val
		mut var_action_ids := rt.call_method(this.store, 'query_actions', [
			var_query.clone()])
		if !(!rt.is_true(var_action_ids)) {
			return var_action_ids.clone()
		}
	}
	return rt.new_array()
}

fn (mut this Class_Action_Scheduler_Migration_BatchFetcher) get_query_strategies(var_count rt.PhpVal) {
	mut var_now := rt.call_function('as_get_datetime_object', []rt.PhpVal{})
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'date', val: var_now },
		rt.ArrayItem{ key: 'per_page', val: var_count }, rt.ArrayItem{ key: 'offset', val: 0 },
		rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'ASC' }])
	mut var_priorities := rt.create_array([
		rt.ArrayItem{ key: none, val: Class_ActionScheduler_Store.status_pending() },
		rt.ArrayItem{ key: none, val: Class_ActionScheduler_Store.status_failed() },
		rt.ArrayItem{ key: none, val: Class_ActionScheduler_Store.status_canceled() },
		rt.ArrayItem{ key: none, val: Class_ActionScheduler_Store.status_complete() },
		rt.ArrayItem{ key: none, val: Class_ActionScheduler_Store.status_running() },
		rt.ArrayItem{ key: none, val: '' },
	])
	mut iter_2 := var_priorities.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_status := item_2.val
		rt.new_null()
		rt.new_null()
	}
}

fn create_action_scheduler_migration_batchfetcher(arg_0 rt.PhpVal) &Class_Action_Scheduler_Migration_BatchFetcher {
	mut obj := &Class_Action_Scheduler_Migration_BatchFetcher{
		PhpObjectBase: rt.PhpObjectBase{}
		store:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_BatchFetcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Store](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'fetch' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.fetch(dispatch_arg_0)
		}
		'get_query_strategies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_query_strategies(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_Migration_BatchFetcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'store' { return this.store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_Migration_BatchFetcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'store' {
			this.store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
