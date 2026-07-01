import rt
import crypto.md5

struct Class_WP_Dependencies {
	rt.PhpObjectBase
pub mut:
		registered rt.PhpVal = rt.new_array()
		queue rt.PhpVal = rt.new_array()
		to_do rt.PhpVal = rt.new_array()
		done rt.PhpVal = rt.new_array()
		args rt.PhpVal = rt.new_array()
		groups rt.PhpVal = rt.new_array()
		group rt.PhpVal = rt.new_int(0)
		all_queued_deps rt.PhpVal = rt.new_null()
		queued_before_register rt.PhpVal = rt.new_array()
		dependencies_with_missing_dependencies rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Dependencies) do_items(handles bool, group bool) rt.PhpVal {
	mut handles_mutated := handles
	mut group_mutated := group
	handles_mutated = (if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(handles_mutated))) { this.queue } else { rt.cast_array(rt.new_bool(handles_mutated)) }).to_bool()
	this.all_deps(rt.new_bool(handles_mutated), false, false)
	{
		mut iter_1 := this.to_do.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_handle.dup(), this.done, rt.new_bool(true)]))))) && this.registered.array_isset(var_handle))) {
				if rt.is_true(this.do_item(var_handle.dup(), group_mutated)) {
					this.done.array_push(var_handle.dup())
				}
				this.to_do.array_unset(var_key)
			}
		}
	}
	return this.done
}

fn (mut this Class_WP_Dependencies) do_item(var_handle rt.PhpVal, group bool) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut group_mutated := group
	return rt.new_bool(this.registered.array_isset(var_handle_mutated))
}

fn (mut this Class_WP_Dependencies) all_deps(var_handles rt.PhpVal, recursion bool, group bool) bool {
	mut var_handles_mutated := var_handles
	mut group_mutated := group
	var_handles_mutated = rt.cast_array(var_handles_mutated)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_handles_mutated)))) {
		return false
	}
	{
		mut iter_1 := var_handles_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			mut var_handle_parts := rt.call_function('explode', [rt.new_string('?'), var_handle.dup()])
			var_handle = var_handle_parts.array_get(0)
			mut var_queued := rt.call_function('in_array', [var_handle.dup(), this.to_do, rt.new_bool(true)])
			if rt.is_true(rt.call_function('in_array', [var_handle.dup(), this.done, rt.new_bool(true)])) {
				continue
			}
			mut var_moved := rt.new_bool(this.set_group(var_handle.dup(), rt.new_bool(recursion), rt.new_bool(group_mutated)))
			mut var_new_group := this.groups.array_get(var_handle)
			if rt.is_true(rt.new_bool(rt.is_true(var_queued) && rt.is_true(rt.new_bool(!(rt.is_true(var_moved)))))) {
				continue
			}
			mut var_keep_going := rt.new_bool(rt.new_bool(true))
			mut var_missing_dependencies := rt.new_array()
			if this.registered.array_isset(var_handle) && rt.get_property(this.registered.array_get(var_handle), 'deps').array_count() > 0 {
				var_missing_dependencies = rt.call_function('array_diff', [rt.get_property(this.registered.array_get(var_handle), 'deps'), rt.func_array_keys(this.registered)])
			}
			if !(this.registered.array_isset(var_handle)) {
				var_keep_going = rt.new_bool(rt.new_bool(false))
				// unsupported statement: Stmt_Nop
			} else if var_missing_dependencies.dup().array_count() > 0 {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_handle.dup(), this.dependencies_with_missing_dependencies, rt.new_bool(true)]))))) {
					rt.call_function('_doing_it_wrong', [(rt.call_function('get_class', [rt.new_object('WP_Dependencies', []string{}, &this)])).str() + '::add', this.get_dependency_warning_message(var_handle.dup(), var_missing_dependencies.dup()), rt.new_string('6.9.1')])
					this.dependencies_with_missing_dependencies.array_push(var_handle.dup())
				}
				var_keep_going = rt.new_bool(rt.new_bool(false))
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(this.registered.array_get(var_handle), 'deps')) && !(this.all_deps(rt.get_property(this.registered.array_get(var_handle), 'deps'), true, (var_new_group).to_bool())))) {
				var_keep_going = rt.new_bool(rt.new_bool(false))
				// unsupported statement: Stmt_Nop
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_keep_going)))) {
				if var_recursion {
					return false
					// unsupported statement: Stmt_Nop
				} else {
					continue
					// unsupported statement: Stmt_Nop
				}
			}
			if rt.is_true(var_queued) {
				continue
			}
			if var_handle_parts.array_isset(rt.new_int(1)) {
				this.args.array_set(var_handle, var_handle_parts.array_get(1))
			}
			this.to_do.array_push(var_handle.dup())
		}
	}
	return true
}

fn (mut this Class_WP_Dependencies) add(var_handle rt.PhpVal, var_src rt.PhpVal, var_deps rt.PhpVal, ver bool, var_args rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_deps_mutated := var_deps
	mut ver_mutated := ver
	if this.registered.array_isset(var_handle_mutated) {
		return false
	}
	this.registered.array_set(var_handle_mutated, create__wp_dependency(var_handle_mutated.dup(), var_src.dup(), var_deps_mutated.dup(), rt.new_bool(ver_mutated).dup(), var_args.dup()))
	if rt.is_true(rt.new_bool(this.queued_before_register.array_isset(var_handle_mutated.dup()))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.queued_before_register.array_get(var_handle_mutated).is_null()))))) {
			this.enqueue(rt.new_string((var_handle_mutated).str() + '?' + (this.queued_before_register.array_get(var_handle_mutated)).str()))
		} else {
			this.enqueue(var_handle_mutated.dup())
		}
		this.queued_before_register.array_unset(var_handle_mutated)
	}
	return true
}

fn (mut this Class_WP_Dependencies) add_data(var_handle rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_key_mutated := var_key
	if !(this.registered.array_isset(var_handle_mutated)) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('conditional'), var_key_mutated)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_Dependencies->add_data()'), rt.new_string('6.9.0'), rt.call_function('__', [rt.new_string('IE conditional comments are ignored by all supported browsers.')])])
	}
	return (rt.call_method(this.registered.array_get(var_handle_mutated), 'add_data', [var_key_mutated.dup(), var_value.dup()])).to_bool()
}

fn (mut this Class_WP_Dependencies) get_data(var_handle rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_key_mutated := var_key
	if !(this.registered.array_isset(var_handle_mutated)) {
		return false
	}
	if !(rt.get_property(this.registered.array_get(var_handle_mutated), 'extra').array_isset(var_key_mutated)) {
		return false
	}
	return (rt.get_property(this.registered.array_get(var_handle_mutated), 'extra').array_get(var_key_mutated)).to_bool()
}

fn (mut this Class_WP_Dependencies) remove(var_handles rt.PhpVal)  {
	mut var_handles_mutated := var_handles
	{
		mut iter_1 := rt.cast_array(var_handles_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			this.registered.array_unset(var_handle)
		}
	}
}

fn (mut this Class_WP_Dependencies) enqueue(var_handles rt.PhpVal)  {
	mut var_handles_mutated := var_handles
	{
		mut iter_1 := rt.cast_array(var_handles_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			var_handle = rt.call_function('explode', [rt.new_string('?'), var_handle.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_handle.array_get(0), this.queue, rt.new_bool(true)]))))) && this.registered.array_isset(var_handle.array_get(0)))) {
				this.queue.array_push(var_handle.array_get(0))
				this.all_queued_deps = rt.new_null()
				if var_handle.array_isset(rt.new_int(1)) {
					this.args.array_set(var_handle.array_get(0), var_handle.array_get(1))
				}
			} else if !(this.registered.array_isset(var_handle.array_get(0))) {
				this.queued_before_register.array_set(var_handle.array_get(0), rt.new_null())
				if var_handle.array_isset(rt.new_int(1)) {
					this.queued_before_register.array_set(var_handle.array_get(0), var_handle.array_get(1))
				}
			}
		}
	}
}

fn (mut this Class_WP_Dependencies) dequeue(var_handles rt.PhpVal)  {
	mut var_handles_mutated := var_handles
	{
		mut iter_1 := rt.cast_array(var_handles_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			var_handle = rt.call_function('explode', [rt.new_string('?'), var_handle.dup()])
			mut var_key := rt.call_function('array_search', [var_handle.array_get(0), this.queue, rt.new_bool(true)])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				this.all_queued_deps = rt.new_null()
				this.queue.array_unset(var_key)
				this.args.array_unset(var_handle.array_get(0))
			} else if rt.is_true(rt.new_bool(this.queued_before_register.array_isset(var_handle.array_get(0)))) {
				this.queued_before_register.array_unset(var_handle.array_get(0))
			}
		}
	}
}

fn (mut this Class_WP_Dependencies) recurse_deps(var_queue rt.PhpVal, var_handle rt.PhpVal) rt.PhpVal {
	mut var_queue_mutated := var_queue
	mut var_handle_mutated := var_handle
	if !(this.all_queued_deps).is_null() {
		return rt.new_bool(this.all_queued_deps.array_isset(var_handle_mutated))
	}
	mut var_all_deps := rt.call_function('array_fill_keys', [var_queue_mutated.dup(), rt.new_bool(true)])
	mut var_queues := rt.new_array()
	mut var_done := rt.new_array()
	for rt.is_true(var_queue_mutated) {
		{
			mut iter_1 := var_queue_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_queued := item_1.val
				if !(var_done.array_isset(var_queued)) && this.registered.array_isset(var_queued) {
					mut var_deps := rt.get_property(this.registered.array_get(var_queued), 'deps')
					if rt.is_true(var_deps) {
						// unsupported expression: Expr_AssignOp_Plus
						var_queues.dup().array_push(var_deps.dup())
					}
					var_done.array_set(var_queued, true)
				}
			}
		}
		var_queue_mutated = rt.call_function('array_pop', [var_queues.dup()])
	}
	this.all_queued_deps = var_all_deps.dup()
	return rt.new_bool(this.all_queued_deps.array_isset(var_handle_mutated))
}

fn (mut this Class_WP_Dependencies) query(var_handle rt.PhpVal, status string) bool {
	mut var_handle_mutated := var_handle
	mut switch_val_1 := rt.new_string(status)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('registered'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('scripts'))) {
		return (if !(this.registered.array_get(var_handle_mutated)).is_null() { this.registered.array_get(var_handle_mutated) } else { rt.new_bool(false) }).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enqueued'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('queue'))) {
		if rt.is_true(rt.call_function('in_array', [var_handle_mutated.dup(), this.queue, rt.new_bool(true)])) {
			return true
		}
		return (this.recurse_deps(this.queue, var_handle_mutated.dup())).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('to_do'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('to_print'))) {
		return (rt.call_function('in_array', [var_handle_mutated.dup(), this.to_do, rt.new_bool(true)])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('done'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('printed'))) {
		return (rt.call_function('in_array', [var_handle_mutated.dup(), this.done, rt.new_bool(true)])).to_bool()
	}
	return false
}

fn (mut this Class_WP_Dependencies) set_group(var_handle rt.PhpVal, var_recursion rt.PhpVal, var_group rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_group_mutated := var_group
	var_group_mutated = // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(this.groups.array_isset(var_handle_mutated) && rt.is_true(rt.less_equal(this.groups.array_get(var_handle_mutated), var_group_mutated)))) {
		return false
	}
	this.groups.array_set(var_handle_mutated, var_group_mutated.dup())
	return true
}

fn (mut this Class_WP_Dependencies) get_etag(var_load rt.PhpVal) string {
	mut var_wp_version := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_etag := rt.new_string(rt.new_string("WP:${var_wp_version.to_string()};"))
	{
		mut iter_1 := var_load.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.registered.array_isset(var_handle.dup())))))) {
				continue
			}
			mut var_ver := if !(rt.get_property(this.registered.array_get(var_handle), 'ver')).is_null() { rt.get_property(this.registered.array_get(var_handle), 'ver') } else { var_wp_version }
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return 'W/"' + md5.hexhash(var_etag.dup().to_string()) + '"'
}

fn (mut this Class_WP_Dependencies) get_dependency_warning_message(var_handle rt.PhpVal, var_missing_dependency_handles rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The handle "%1$s" was enqueued with dependencies that are not registered: %2$s.')]), var_handle_mutated.dup(), rt.call_function('implode', [rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}), var_missing_dependency_handles.dup()])])
}

struct Class__WP_Dependency {
	rt.PhpObjectBase
}

fn create_wp_dependencies() &Class_WP_Dependencies {
	mut obj := &Class_WP_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
		registered: rt.new_array()
		queue: rt.new_array()
		to_do: rt.new_array()
		done: rt.new_array()
		args: rt.new_array()
		groups: rt.new_array()
		group: rt.new_int(0)
		all_queued_deps: rt.new_null()
		queued_before_register: rt.new_array()
		dependencies_with_missing_dependencies: rt.new_array()
	}
	return obj
}

fn create__wp_dependency() &Class__WP_Dependency {
	mut obj := &Class__WP_Dependency{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'do_items' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.do_items(dispatch_arg_0, dispatch_arg_1)
		}
		'do_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.do_item(dispatch_arg_0, dispatch_arg_1)
		}
		'all_deps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.all_deps(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'add_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.add_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.get_data(dispatch_arg_0, dispatch_arg_1))
		}
		'remove' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.enqueue(dispatch_arg_0)
			return rt.new_null()
		}
		'dequeue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.dequeue(dispatch_arg_0)
			return rt.new_null()
		}
		'recurse_deps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.recurse_deps(dispatch_arg_0, dispatch_arg_1)
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.query(dispatch_arg_0, dispatch_arg_1))
		}
		'set_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.set_group(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_etag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_etag(dispatch_arg_0))
		}
		'get_dependency_warning_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_dependency_warning_message(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered' { return this.registered }
		'queue' { return this.queue }
		'to_do' { return this.to_do }
		'done' { return this.done }
		'args' { return this.args }
		'groups' { return this.groups }
		'group' { return this.group }
		'all_queued_deps' { return this.all_queued_deps }
		'queued_before_register' { return this.queued_before_register }
		'dependencies_with_missing_dependencies' { return this.dependencies_with_missing_dependencies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered' { this.registered = val; return true }
		'queue' { this.queue = val; return true }
		'to_do' { this.to_do = val; return true }
		'done' { this.done = val; return true }
		'args' { this.args = val; return true }
		'groups' { this.groups = val; return true }
		'group' { this.group = val; return true }
		'all_queued_deps' { this.all_queued_deps = val; return true }
		'queued_before_register' { this.queued_before_register = val; return true }
		'dependencies_with_missing_dependencies' { this.dependencies_with_missing_dependencies = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class__WP_Dependency) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class__WP_Dependency) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class__WP_Dependency) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_dependencies_php() {
}
