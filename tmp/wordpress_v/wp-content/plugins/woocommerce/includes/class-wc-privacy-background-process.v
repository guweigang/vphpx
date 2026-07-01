import rt

struct Class_WC_Privacy_Background_Process {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Privacy_Background_Process) construct()  {
	this.dispatch_set_prop('prefix', 'wp_' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str())
	this.dispatch_set_prop('action', rt.new_string('wc_privacy_cleanup'))
	this.Class_WC_Background_Process.construct()
}

fn (mut this Class_WC_Privacy_Background_Process) task(var_item rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) || !rt.is_true(var_item.array_get('task')))) {
		return false
	}
	mut var_process_count := rt.new_int(rt.new_int(0))
	mut var_process_limit := rt.new_int(rt.new_int(20))
	mut switch_val_1 := var_item.array_get('task')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash_pending_orders'))) {
		var_process_count = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Privacy{}; return temp.trash_pending_orders(arg_0) }(var_process_limit.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash_failed_orders'))) {
		var_process_count = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Privacy{}; return temp.trash_failed_orders(arg_0) }(var_process_limit.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash_cancelled_orders'))) {
		var_process_count = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Privacy{}; return temp.trash_cancelled_orders(arg_0) }(var_process_limit.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('anonymize_refunded_orders'))) {
		var_process_count = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Privacy{}; return temp.anonymize_refunded_orders(arg_0) }(var_process_limit.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('anonymize_completed_orders'))) {
		var_process_count = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Privacy{}; return temp.anonymize_completed_orders(arg_0) }(var_process_limit.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_inactive_accounts'))) {
		var_process_count = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Privacy{}; return temp.delete_inactive_accounts(arg_0) }(var_process_limit.dup())
	}
	if rt.is_true(rt.identical(var_process_limit, var_process_count)) {
		return (var_item).to_bool()
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

fn create_wc_background_process() &Class_WC_Background_Process {
	mut obj := &Class_WC_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_privacy() &Class_WC_Privacy {
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_privacy_background_process_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Background_Process'), rt.new_bool(false)]))))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/abstracts/class-wc-background-process.php', '2')
	}
}
