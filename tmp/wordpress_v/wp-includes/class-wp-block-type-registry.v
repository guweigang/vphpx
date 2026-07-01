import rt

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
pub mut:
		registered_block_types rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Type_Registry) register(var_name rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_block_type := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_name_mutated, 'WP_Block_Type'))) {
		var_block_type = var_name_mutated.dup()
		var_name_mutated = rt.get_property(var_block_type, 'name')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_name_mutated.dup().is_string()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block type names must be strings.')]), rt.new_string('5.0.0')])
		return false
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[A-Z]+/'), var_name_mutated.dup()])) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block type names must not contain uppercase characters.')]), rt.new_string('5.0.0')])
		return false
	}
	mut var_name_matcher := rt.new_string(rt.new_string('/^[a-z0-9-]+\\/[a-z0-9-]+$/'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [var_name_matcher.dup(), var_name_mutated.dup()]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block type names must contain a namespace prefix. Example: my-plugin/my-custom-block-type')]), rt.new_string('5.0.0')])
		return false
	}
	if rt.is_true(this.is_registered(var_name_mutated.dup())) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Block type "%s" is already registered.')]), var_name_mutated.dup()]), rt.new_string('5.0.0')])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_type)))) {
		var_block_type = create_wp_block_type(var_name_mutated.dup(), var_args.dup())
	}
	this.registered_block_types.array_set(var_name_mutated, var_block_type.dup())
	return (var_block_type).to_bool()
}

fn (mut this Class_WP_Block_Type_Registry) unregister(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(rt.instance_of(var_name_mutated, 'WP_Block_Type'))) {
		var_name_mutated = rt.get_property(var_name_mutated, 'name')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_name_mutated.dup()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Block type "%s" is not registered.')]), var_name_mutated.dup()]), rt.new_string('5.0.0')])
		return false
	}
	mut var_unregistered_block_type := this.registered_block_types.array_get(var_name_mutated)
	this.registered_block_types.array_unset(var_name_mutated)
	return (var_unregistered_block_type).to_bool()
}

fn (mut this Class_WP_Block_Type_Registry) get_registered(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_name_mutated.dup()))))) {
		return rt.new_null()
	}
	return this.registered_block_types.array_get(var_name_mutated)
}

fn (mut this Class_WP_Block_Type_Registry) get_all_registered() rt.PhpVal {
	return this.registered_block_types
}

fn (mut this Class_WP_Block_Type_Registry) is_registered(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	return rt.new_bool(!(var_name_mutated).is_null() && this.registered_block_types.array_isset(var_name_mutated))
}

fn (mut this Class_WP_Block_Type_Registry) magic_wakeup()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.registered_block_types)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.registered_block_types.is_array()))))) {
		rt.throw_exception(rt.new_object('UnexpectedValueException', []string{}, create_unexpectedvalueexception()))
	}
	{
		mut iter_1 := this.registered_block_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_value, 'WP_Block_Type')))))) {
				rt.throw_exception(rt.new_object('UnexpectedValueException', []string{}, create_unexpectedvalueexception()))
			}
		}
	}
}

fn Class_WP_Block_Type_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_WP_Block_Type {
	rt.PhpObjectBase
}

struct Class_UnexpectedValueException {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		registered_block_types: rt.new_array()
		instance: rt.new_null()
	}
	return obj
}

fn create_wp_block_type() &Class_WP_Block_Type {
	mut obj := &Class_WP_Block_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_unexpectedvalueexception() &Class_UnexpectedValueException {
	mut obj := &Class_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_registered(dispatch_arg_0)
		}
		'get_all_registered' {
			return this.get_all_registered()
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
			return Class_WP_Block_Type_Registry.get_instance()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_block_types' { return this.registered_block_types }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_block_types' { this.registered_block_types = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Block_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_includes_class_wp_block_type_registry_php() {
}
