import rt

struct Class_ActionScheduler_DBStoreMigrator {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_DBStoreMigrator) save_action(mut var_action Class_ActionScheduler_Action, mut var_scheduled_date Class_?DateTime, mut var_last_attempt_date Class_?DateTime) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_action_id := this.Class_ActionScheduler_DBStore.save_action(rt.new_object('ActionScheduler_Action', []string{}, var_action), rt.new_object('?DateTime', []string{}, var_scheduled_date))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last_attempt_date)))) {
		mut var_data := rt.create_array([rt.ArrayItem{ key: 'last_attempt_gmt', val: this.get_scheduled_date_string(rt.new_object('ActionScheduler_Action', []string{}, var_action), rt.new_object('?DateTime', []string{}, var_last_attempt_date)) }, rt.ArrayItem{ key: 'last_attempt_local', val: this.get_scheduled_date_string_local(rt.new_object('ActionScheduler_Action', []string{}, var_action), rt.new_object('?DateTime', []string{}, var_last_attempt_date)) }])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'actionscheduler_actions'), var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'action_id', val: var_action_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_action_id.clone()
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

struct Class_ActionScheduler_DBStore {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

fn create_actionscheduler_dbstoremigrator(_args ...rt.PhpVal) &Class_ActionScheduler_DBStoreMigrator {
	mut obj := &Class_ActionScheduler_DBStoreMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_dbstore(_args ...rt.PhpVal) &Class_ActionScheduler_DBStore {
	mut obj := &Class_ActionScheduler_DBStore{
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

fn (mut this Class_ActionScheduler_DBStoreMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'save_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?DateTime](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.save_action(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_DBStoreMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DBStoreMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_DBStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_DBStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DBStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
