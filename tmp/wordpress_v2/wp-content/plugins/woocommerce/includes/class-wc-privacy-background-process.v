import rt

struct Class_WC_Privacy_Background_Process {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Privacy_Background_Process) construct() {
	this.dispatch_set_prop('prefix', 'wp_' +
		(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str())
	this.dispatch_set_prop('action', rt.new_string('wc_privacy_cleanup'))
	this.Class_WC_Background_Process.construct()
}

fn (mut this Class_WC_Privacy_Background_Process) task(var_item rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item))))
		|| !rt.is_true(var_item.array_get(rt.new_string('task'))) {
		return false
	}
	mut var_process_count := rt.new_int(0)
	mut var_process_limit := rt.new_int(20)
	mut switch_val_1 := var_item.array_get(rt.new_string('task'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash_pending_orders'))) {
		mut iife_temp_0 := Class_WC_Privacy{}
		mut iife_result_0 := iife_temp_0.trash_pending_orders(var_process_limit.clone())
		var_process_count = iife_result_0
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash_failed_orders'))) {
		mut iife_temp_1 := Class_WC_Privacy{}
		mut iife_result_1 := iife_temp_1.trash_failed_orders(var_process_limit.clone())
		var_process_count = iife_result_1
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash_cancelled_orders'))) {
		mut iife_temp_2 := Class_WC_Privacy{}
		mut iife_result_2 := iife_temp_2.trash_cancelled_orders(var_process_limit.clone())
		var_process_count = iife_result_2
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('anonymize_refunded_orders'))) {
		mut iife_temp_3 := Class_WC_Privacy{}
		mut iife_result_3 := iife_temp_3.anonymize_refunded_orders(var_process_limit.clone())
		var_process_count = iife_result_3
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('anonymize_completed_orders'))) {
		mut iife_temp_4 := Class_WC_Privacy{}
		mut iife_result_4 := iife_temp_4.anonymize_completed_orders(var_process_limit.clone())
		var_process_count = iife_result_4
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_inactive_accounts'))) {
		mut iife_temp_5 := Class_WC_Privacy{}
		mut iife_result_5 := iife_temp_5.delete_inactive_accounts(var_process_limit.clone())
		var_process_count = iife_result_5
	}
	if rt.is_true(rt.identical(var_process_limit, var_process_count)) {
		return var_item.to_bool()
	}
	return false
}

struct Class_WC_Background_Process {
	rt.PhpObjectBase
}

struct Class_WC_Privacy {
	rt.PhpObjectBase
}

fn create_wc_privacy_background_process() &Class_WC_Privacy_Background_Process {
	mut obj := &Class_WC_Privacy_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_background_process(_args ...rt.PhpVal) &Class_WC_Background_Process {
	mut obj := &Class_WC_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_privacy(_args ...rt.PhpVal) &Class_WC_Privacy {
	mut obj := &Class_WC_Privacy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Privacy_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.task(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Privacy_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Privacy_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Privacy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Privacy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Privacy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Background_Process'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/abstracts/class-wc-background-process.php', '2')
	}
}
