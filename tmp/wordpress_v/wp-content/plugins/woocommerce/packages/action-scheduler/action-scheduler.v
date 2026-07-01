import rt

fn action_scheduler_register_3_dot_9_dot_3() {
	mut var_versions := fn () rt.PhpVal {
		mut temp := Class_ActionScheduler_Versions{}
		return temp.instance()
	}()
	rt.call_method(var_versions, 'register', [rt.new_string('3.9.3'),
		rt.new_string('action_scheduler_initialize_3_dot_9_dot_3')])
	// unsupported statement: Stmt_Nop
}

fn action_scheduler_initialize_3_dot_9_dot_3() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ActionScheduler'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(@DIR + '/classes/abstracts/ActionScheduler.php', '4')
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ActionScheduler{}
			return temp.init(arg_0)
		}(rt.new_string(@FILE))
	}
}

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

fn create_actionscheduler_versions() &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
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

fn (mut this Class_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_action_scheduler_php() {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('action_scheduler_register_3_dot_9_dot_3')])))))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('add_action')]))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
			rt.new_string('ActionScheduler_Versions'),
			rt.new_bool(false),
		])))))
		{
			rt.include_file(@DIR + '/classes/ActionScheduler_Versions.php', '4')
			rt.call_function('add_action', [rt.new_string('plugins_loaded'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'ActionScheduler_Versions' },
					rt.ArrayItem{ key: none, val: 'initialize_latest_version' },
				]),
				rt.new_int(1), rt.new_int(0)])
		}
		rt.call_function('add_action', [rt.new_string('plugins_loaded'),
			rt.new_string('action_scheduler_register_3_dot_9_dot_3'),
			rt.new_int(0), rt.new_int(0)])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('plugins_loaded')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('plugins_loaded')])))))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('ActionScheduler'), rt.new_bool(false)])))))))
		{
			action_scheduler_initialize_3_dot_9_dot_3()
			rt.call_function('do_action', [
				rt.new_string('action_scheduler_pre_theme_init'),
			])
			fn () rt.PhpVal {
				mut temp := Class_ActionScheduler_Versions{}
				return temp.initialize_latest_version()
			}()
		}
	}
}
