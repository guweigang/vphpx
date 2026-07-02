import rt

struct Class_WP_Hook {
	rt.PhpObjectBase
pub mut:
	callbacks        rt.PhpVal = rt.new_array()
	priorities       rt.PhpVal = rt.new_array()
	iterations       rt.PhpVal = rt.new_array()
	current_priority rt.PhpVal = rt.new_array()
	nesting_level    rt.PhpVal = rt.new_int(0)
	doing_action     bool
}

fn (mut this Class_WP_Hook) add_filter(var_hook_name rt.PhpVal, var_callback rt.PhpVal, var_priority rt.PhpVal, var_accepted_args rt.PhpVal) {
	mut var_priority_mutated := var_priority
	if rt.is_true(rt.identical(rt.new_null(), var_priority_mutated)) {
		var_priority_mutated = rt.new_int(0)
	}
	mut var_idx := rt.call_function('_wp_filter_build_unique_id', [
		var_hook_name.clone(), var_callback.clone(), var_priority_mutated.clone()])
	mut var_priority_existed := rt.new_bool(this.callbacks.array_isset(var_priority_mutated))
	this.callbacks.array_get_mut(var_priority_mutated).array_set(var_idx, rt.create_array([
		rt.ArrayItem{ key: 'function', val: var_callback },
		rt.ArrayItem{ key: 'accepted_args', val: rt.new_int(var_accepted_args.to_i64()) },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_priority_existed))))
		&& this.callbacks.array_count() > 1 {
		rt.call_function('ksort', [this.callbacks, rt.get_constant('SORT_NUMERIC')])
	}
	this.priorities = rt.func_array_keys(this.callbacks)
	if rt.is_true(rt.greater(this.nesting_level, rt.new_int(0))) {
		this.resort_active_iterations(var_priority_mutated.to_bool(),
			var_priority_existed.to_bool())
	}
}

fn (mut this Class_WP_Hook) resort_active_iterations(new_priority bool, priority_existed bool) {
	mut priority_existed_mutated := priority_existed
	mut var_new_priorities := this.priorities
	if rt.is_true(rt.new_bool(!(rt.is_true(var_new_priorities)))) {
		mut iter_1 := this.iterations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_iteration := item_1.val
			mut var_index := item_1.key
			this.iterations.array_set(var_index, var_new_priorities.clone())
		}
		return
	}
	mut var_min := rt.call_function('min', [var_new_priorities.clone()])
	mut iter_2 := this.iterations.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_iteration := item_2.val
		mut var_index := item_2.key
		mut var_current := rt.call_function('current', [var_iteration.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_current)) {
			continue
		}
		var_iteration = var_new_priorities.clone()
		if rt.is_true(rt.less(var_current, var_min)) {
			rt.call_function('array_unshift', [var_iteration.clone(),
				var_current.clone()])
			continue
		}
		for rt.is_true(rt.less(rt.call_function('current', [var_iteration.clone()]), var_current)) {
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('next', [
				var_iteration.clone(),
			])))
			{
				break
			}
		}
		if rt.is_true(rt.identical(rt.new_bool(new_priority), this.current_priority.array_get(var_index)))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(priority_existed_mutated))))) {
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('current', [
				var_iteration.clone(),
			])))
			{
				mut var_prev := rt.call_function('end', [var_iteration.clone()])
			} else {
				var_prev = rt.call_function('prev', [var_iteration.clone()])
			}
			if rt.is_true(rt.identical(rt.new_bool(false), var_prev)) {
				rt.call_function('reset', [var_iteration.clone()])
			} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(new_priority),
				var_prev))))
			{
				rt.call_function('next', [var_iteration.clone()])
			}
		}
	}
	var_iteration = rt.new_null()
}

fn (mut this Class_WP_Hook) remove_filter(var_hook_name rt.PhpVal, var_callback rt.PhpVal, var_priority rt.PhpVal) rt.PhpVal {
	mut var_priority_mutated := var_priority
	if rt.is_true(rt.identical(rt.new_null(), var_priority_mutated)) {
		var_priority_mutated = rt.new_int(0)
	}
	mut var_function_key := rt.call_function('_wp_filter_build_unique_id', [
		var_hook_name.clone(), var_callback.clone(), var_priority_mutated.clone()])
	mut var_exists := rt.new_bool(!var_function_key.is_null()
		&& this.callbacks.array_get(var_priority_mutated).array_isset(var_function_key))
	if rt.is_true(var_exists) {
		this.callbacks.array_get(var_priority_mutated).array_unset(var_function_key)
		if rt.is_true(rt.new_bool(!(rt.is_true(this.callbacks.array_get(var_priority_mutated))))) {
			this.callbacks.array_unset(var_priority_mutated)
			this.priorities = rt.func_array_keys(this.callbacks)
			if rt.is_true(rt.greater(this.nesting_level, rt.new_int(0))) {
				this.resort_active_iterations(false, false)
			}
		}
	}
	return var_exists.clone()
}

fn (mut this Class_WP_Hook) has_filter(hook_name string, callback bool, priority bool) bool {
	mut priority_mutated := priority
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(callback))) {
		return this.has_filters()
	}
	mut var_function_key := rt.call_function('_wp_filter_build_unique_id', [
		rt.new_string(hook_name),
		rt.new_bool(callback),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_function_key)))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.new_bool(priority_mutated).clone().is_long())) {
		return (rt.new_bool(this.callbacks.array_get(rt.new_bool(priority_mutated)).array_isset(var_function_key))).to_bool()
	}
	mut iter_3 := this.callbacks.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_callbacks := item_3.val
		mut var_callback_priority := item_3.key
		if var_callbacks.array_isset(var_function_key) {
			return var_callback_priority.to_bool()
		}
	}
	return false
}

fn (mut this Class_WP_Hook) has_filters() bool {
	mut iter_4 := this.callbacks.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_callbacks := item_4.val
		if rt.is_true(var_callbacks) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Hook) remove_all_filters(priority bool) {
	mut priority_mutated := priority
	if rt.is_true(rt.new_bool(!(rt.is_true(this.callbacks)))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(priority_mutated))) {
		this.callbacks = rt.new_array()
		this.priorities = rt.new_array()
	} else if this.callbacks.array_isset(rt.new_bool(priority_mutated)) {
		this.callbacks.array_unset(rt.new_bool(priority_mutated))
		this.priorities = rt.func_array_keys(this.callbacks)
	}
	if rt.is_true(rt.greater(this.nesting_level, rt.new_int(0))) {
		this.resort_active_iterations(false, false)
	}
}

fn (mut this Class_WP_Hook) apply_filters(var_value rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(this.callbacks)))) {
		return var_value_mutated.clone()
	}
	mut var_nesting_level := rt.post_inc(this.nesting_level)
	this.iterations.array_set(var_nesting_level, this.priorities)
	mut var_num_args := rt.new_int(var_args_mutated.clone().array_count())
	for {
		this.current_priority.array_set(var_nesting_level, rt.call_function('current', [
			this.iterations.array_get(var_nesting_level),
		]))
		mut var_priority := this.current_priority.array_get(var_nesting_level)
		mut iter_5 := this.callbacks.array_get(var_priority).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_the_ := item_5.val
			if !(this.doing_action) {
				var_args_mutated.array_set(0, var_value_mutated.clone())
			}
			if rt.is_true(rt.identical(rt.new_int(0),
				var_the_.array_get(rt.new_string('accepted_args'))))
			{
				var_value_mutated = rt.call_function('call_user_func', [
					var_the_.array_get(rt.new_string('function')),
				])
			} else if rt.is_true(rt.greater_equal(var_the_.array_get(rt.new_string('accepted_args')),
				var_num_args))
			{
				var_value_mutated = rt.call_function('call_user_func_array', [
					var_the_.array_get(rt.new_string('function')),
					var_args_mutated.clone(),
				])
			} else {
				var_value_mutated = rt.call_function('call_user_func_array', [
					var_the_.array_get(rt.new_string('function')),
					rt.call_function('array_slice', [var_args_mutated.clone(),
						rt.new_int(0), var_the_.array_get(rt.new_string('accepted_args'))]),
				])
			}
		}
		if !(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('next', [
			this.iterations.array_get(var_nesting_level),
		])))))) {
			break
		}
	}
	this.iterations.array_unset(var_nesting_level)
	this.current_priority.array_unset(var_nesting_level)
	rt.pre_dec(this.nesting_level)
	return var_value_mutated.clone()
}

fn (mut this Class_WP_Hook) do_action(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.doing_action = true
	this.apply_filters(rt.new_string(''), var_args_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(this.nesting_level)))) {
		this.doing_action = false
	}
}

fn (mut this Class_WP_Hook) do_all_hook(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_nesting_level := rt.post_inc(this.nesting_level)
	this.iterations.array_set(var_nesting_level, this.priorities)
	for {
		mut var_priority := rt.call_function('current',
			[this.iterations.array_get(var_nesting_level)])
		mut iter_6 := this.callbacks.array_get(var_priority).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_the_ := item_6.val
			rt.call_function('call_user_func_array', [
				var_the_.array_get(rt.new_string('function')),
				var_args_mutated.clone(),
			])
		}
		if !(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('next', [
			this.iterations.array_get(var_nesting_level),
		])))))) {
			break
		}
	}
	this.iterations.array_unset(var_nesting_level)
	rt.pre_dec(this.nesting_level)
}

fn (mut this Class_WP_Hook) current_priority() bool {
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('current', [
		this.iterations,
	])))
	{
		return false
	}
	return (rt.call_function('current', [rt.call_function('current', [this.iterations])])).to_bool()
}

fn Class_WP_Hook.build_preinitialized_hooks(var_filters rt.PhpVal) rt.PhpVal {
	mut var_normalized := rt.new_array()
	mut iter_7 := var_filters.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_callback_groups := item_7.val
		mut var_hook_name := item_7.key
		if rt.is_true(rt.new_bool(rt.instance_of(var_callback_groups, 'WP_Hook'))) {
			var_normalized.array_set(var_hook_name, var_callback_groups.clone())
			continue
		}
		mut var_hook := create_wp_hook()
		mut iter_8 := var_callback_groups.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_callbacks := item_8.val
			mut var_priority := item_8.key
			mut iter_9 := var_callbacks.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_cb := item_9.val
				var_hook.add_filter(var_hook_name.clone(),
					var_cb.array_get(rt.new_string('function')), var_priority.clone(),
					var_cb.array_get(rt.new_string('accepted_args')))
			}
		}
		var_normalized.array_set(var_hook_name, var_hook)
	}
	return var_normalized.clone()
}

fn (mut this Class_WP_Hook) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.callbacks.array_isset(var_offset))
}

fn (mut this Class_WP_Hook) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	return if !(this.callbacks.array_get(var_offset)).is_null() {
		this.callbacks.array_get(var_offset)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WP_Hook) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_offset.clone().is_null())) {
		this.callbacks.array_push(var_value_mutated.clone())
	} else {
		this.callbacks.array_set(var_offset, var_value_mutated.clone())
	}
	this.priorities = rt.func_array_keys(this.callbacks)
}

fn (mut this Class_WP_Hook) offsetunset(var_offset rt.PhpVal) {
	this.callbacks.array_unset(var_offset)
	this.priorities = rt.func_array_keys(this.callbacks)
}

fn (mut this Class_WP_Hook) current() rt.PhpVal {
	return rt.call_function('current', [this.callbacks])
}

fn (mut this Class_WP_Hook) next() rt.PhpVal {
	return rt.call_function('next', [this.callbacks])
}

fn (mut this Class_WP_Hook) key() rt.PhpVal {
	return rt.call_function('key', [this.callbacks])
}

fn (mut this Class_WP_Hook) valid() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('key', [this.callbacks]),
		rt.new_null())))
}

fn (mut this Class_WP_Hook) rewind() {
	rt.call_function('reset', [this.callbacks])
}

fn create_wp_hook(_args ...rt.PhpVal) &Class_WP_Hook {
	mut obj := &Class_WP_Hook{
		PhpObjectBase:    rt.PhpObjectBase{}
		callbacks:        rt.new_array()
		priorities:       rt.new_array()
		iterations:       rt.new_array()
		current_priority: rt.new_array()
		nesting_level:    rt.new_int(0)
		doing_action:     false
	}
	return obj
}

fn (mut this Class_WP_Hook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.add_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'resort_active_iterations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.resort_active_iterations(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.remove_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'has_filter' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.has_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'has_filters' {
			return rt.new_bool(this.has_filters())
		}
		'remove_all_filters' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.remove_all_filters(dispatch_arg_0)
			return rt.new_null()
		}
		'apply_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.apply_filters(dispatch_arg_0, dispatch_arg_1)
		}
		'do_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.do_action(dispatch_arg_0)
			return rt.new_null()
		}
		'do_all_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.do_all_hook(dispatch_arg_0)
			return rt.new_null()
		}
		'current_priority' {
			return rt.new_bool(this.current_priority())
		}
		'build_preinitialized_hooks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Hook.build_preinitialized_hooks(dispatch_arg_0)
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'current' {
			return this.current()
		}
		'next' {
			return this.next()
		}
		'key' {
			return this.key()
		}
		'valid' {
			return rt.new_bool(this.valid())
		}
		'rewind' {
			this.rewind()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Hook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'callbacks' { return this.callbacks }
		'priorities' { return this.priorities }
		'iterations' { return this.iterations }
		'current_priority' { return this.current_priority }
		'nesting_level' { return this.nesting_level }
		'doing_action' { return rt.new_bool(this.doing_action) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Hook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'callbacks' {
			this.callbacks = val
			return true
		}
		'priorities' {
			this.priorities = val
			return true
		}
		'iterations' {
			this.iterations = val
			return true
		}
		'current_priority' {
			this.current_priority = val
			return true
		}
		'nesting_level' {
			this.nesting_level = val
			return true
		}
		'doing_action' {
			this.doing_action = val.to_bool()
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
