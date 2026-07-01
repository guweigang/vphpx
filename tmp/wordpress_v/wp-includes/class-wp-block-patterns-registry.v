import rt

struct Class_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
pub mut:
		registered_patterns rt.PhpVal = rt.new_array()
		registered_patterns_outside_init rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Patterns_Registry) register(var_pattern_name rt.PhpVal, var_pattern_properties rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(!(var_pattern_name).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pattern_name.dup().is_string()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Pattern name must be a string.')]), rt.new_string('5.5.0')])
		return false
	}
	if rt.is_true(rt.new_bool(!(var_pattern_properties.array_isset(rt.new_string('title'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pattern_properties.array_get('title').is_string()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Pattern title must be a string.')]), rt.new_string('5.5.0')])
		return false
	}
	if !(var_pattern_properties.array_isset(rt.new_string('filePath'))) {
		if rt.is_true(rt.new_bool(!(var_pattern_properties.array_isset(rt.new_string('content'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pattern_properties.array_get('content').is_string()))))))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Pattern content must be a string.')]), rt.new_string('5.5.0')])
			return false
		}
	}
	mut var_pattern := rt.call_function('array_merge', [var_pattern_properties.dup(), rt.create_array([rt.ArrayItem{ key: 'name', val: var_pattern_name }])])
	this.registered_patterns.array_set(var_pattern_name, var_pattern.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_action', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.registered_patterns_outside_init.array_set(var_pattern_name, var_pattern.dup())
	}
	return true
}

fn (mut this Class_WP_Block_Patterns_Registry) unregister(var_pattern_name rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_pattern_name.dup()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Pattern "%s" not found.')]), var_pattern_name.dup()]), rt.new_string('5.5.0')])
		return false
	}
	this.registered_patterns.array_unset(var_pattern_name)
	this.registered_patterns_outside_init.array_unset(var_pattern_name)
	return true
}

fn (mut this Class_WP_Block_Patterns_Registry) get_content(var_pattern_name rt.PhpVal, outside_init_only bool) rt.PhpVal {
	mut var_patterns := rt.new_null()
	if var_outside_init_only {
		// unsupported expression: Expr_AssignRef
	} else {
		// unsupported expression: Expr_AssignRef
	}
	mut var_file_path := if !(var_patterns.array_get(var_pattern_name).array_get('filePath')).is_null() { var_patterns.array_get(var_pattern_name).array_get('filePath') } else { rt.new_string('') }
	mut var_is_stringy := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_file_path.dup().is_string())) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_file_path.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_file_path.dup(), rt.new_string('__toString')]))))))
	mut var_pattern_path := if rt.is_true(var_is_stringy) { rt.call_function('realpath', [// unsupported expression: Expr_Cast_String]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_patterns.array_get(var_pattern_name).array_isset(rt.new_string('content'))) && rt.is_true(rt.new_bool(var_pattern_path.dup().is_string())))) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_ends_with', [var_pattern_path.dup(), rt.new_string('.php')])) || rt.is_true(rt.call_function('str_ends_with', [var_pattern_path.dup(), rt.new_string('.html')])))))) && rt.is_true(rt.call_function('is_file', [var_pattern_path.dup()])))) && rt.is_true(rt.call_function('is_readable', [var_pattern_path.dup()])))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.include_file((var_patterns.array_get(var_pattern_name).array_get('filePath')).to_string(), '1')
		var_patterns.array_get_mut(var_pattern_name).array_set('content', rt.call_function('ob_get_clean', []rt.PhpVal{}))
		var_patterns.array_get(var_pattern_name).array_unset(rt.new_string('filePath'))
	}
	return var_patterns.array_get(var_pattern_name).array_get('content')
}

fn (mut this Class_WP_Block_Patterns_Registry) get_registered(var_pattern_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_pattern_name.dup()))))) {
		return rt.new_null()
	}
	mut var_pattern := this.registered_patterns.array_get(var_pattern_name)
	mut var_content := this.get_content(var_pattern_name.dup(), false)
	var_pattern.array_set('content', rt.call_function('apply_block_hooks_to_content', [var_content.dup(), var_pattern.dup(), rt.new_string('insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata')]))
	return var_pattern.dup()
}

fn (mut this Class_WP_Block_Patterns_Registry) get_all_registered(outside_init_only bool) rt.PhpVal {
	mut var_patterns := if var_outside_init_only { this.registered_patterns_outside_init } else { this.registered_patterns }
	mut var_hooked_blocks := rt.call_function('get_hooked_blocks', []rt.PhpVal{})
	{
		mut iter_1 := var_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			mut var_index := item_1.key
			mut var_content := this.get_content(var_pattern.array_get('name'), outside_init_only)
			var_patterns.array_get_mut(var_index).array_set('content', rt.call_function('apply_block_hooks_to_content', [var_content.dup(), var_pattern.dup(), rt.new_string('insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata')]))
		}
	}
	return rt.call_function('array_values', [var_patterns.dup()])
}

fn (mut this Class_WP_Block_Patterns_Registry) is_registered(var_pattern_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!(var_pattern_name).is_null() && this.registered_patterns.array_isset(var_pattern_name))
}

fn (mut this Class_WP_Block_Patterns_Registry) magic_wakeup()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.registered_patterns)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.registered_patterns.is_array()))))) {
		rt.throw_exception(rt.new_object('UnexpectedValueException', []string{}, create_unexpectedvalueexception()))
	}
	{
		mut iter_1 := this.registered_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
				rt.throw_exception(rt.new_object('UnexpectedValueException', []string{}, create_unexpectedvalueexception()))
			}
		}
	}
	this.registered_patterns_outside_init = rt.new_array()
}

fn Class_WP_Block_Patterns_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_UnexpectedValueException {
	rt.PhpObjectBase
}

fn create_wp_block_patterns_registry() &Class_WP_Block_Patterns_Registry {
	mut obj := &Class_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		registered_patterns: rt.new_array()
		registered_patterns_outside_init: rt.new_array()
		instance: rt.new_null()
	}
	return obj
}

fn create_unexpectedvalueexception() &Class_UnexpectedValueException {
	mut obj := &Class_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.register(dispatch_arg_0, dispatch_arg_1))
		}
		'unregister' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.unregister(dispatch_arg_0))
		}
		'get_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_content(dispatch_arg_0, dispatch_arg_1)
		}
		'get_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_registered(dispatch_arg_0)
		}
		'get_all_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_all_registered(dispatch_arg_0)
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_registered(dispatch_arg_0)
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'get_instance' {
			return Class_WP_Block_Patterns_Registry.get_instance()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Patterns_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_patterns' { return this.registered_patterns }
		'registered_patterns_outside_init' { return this.registered_patterns_outside_init }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_patterns' { this.registered_patterns = val; return true }
		'registered_patterns_outside_init' { this.registered_patterns_outside_init = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_block_patterns_registry_php() {
}
