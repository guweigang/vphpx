import rt

struct Class_WP_Abilities_Registry {
	rt.PhpObjectBase
pub mut:
	registered_abilities rt.PhpVal = rt.new_array()
}

fn init_static_wp_abilities_registry() {
	rt.init_static_prop('WP_Abilities_Registry', 'instance', rt.new_null())
}

fn (mut this Class_WP_Abilities_Registry) register(name string, mut var_args Class_array) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^[a-z0-9-]+\\/[a-z0-9-]+$/'),
		rt.new_string(name),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('Ability name must be a string containing a namespace prefix, i.e. "my-plugin/my-ability". It can only contain lowercase alphanumeric characters, dashes and the forward slash.'),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	if this.is_registered(name) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Ability "%s" is already registered.'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(name),
				]),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	var_args_mutated = rt.call_function('apply_filters', [
		rt.new_string('wp_register_ability_args'),
		var_args_mutated,
		rt.new_string(name),
	])
	if var_args_mutated.array_isset(rt.new_string('category')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_has_ability_category', [
			var_args_mutated.array_get(rt.new_string('category')),
		])))))
		{
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Ability category "%1$s" is not registered. Please register the ability category before assigning it to ability "%2$s".'),
					]),
					rt.call_function('esc_html', [
						var_args_mutated.array_get(rt.new_string('category')),
					]),
					rt.call_function('esc_html', [
						rt.new_string(name),
					]),
				]),
				rt.new_string('6.9.0')])
			return rt.new_null()
		}
	}
	if var_args_mutated.array_isset(rt.new_string('ability_class'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_args_mutated.array_get(rt.new_string('ability_class')), Class_WP_Ability.class(), rt.new_bool(true)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('The ability args should provide a valid `ability_class` that extends WP_Ability.'),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	mut var_ability_class := if !(var_args_mutated.array_get(rt.new_string('ability_class'))).is_null() {
		var_args_mutated.array_get(rt.new_string('ability_class'))
	} else {
		Class_WP_Ability.class()
	}
	var_args_mutated.array_unset(rt.new_string('ability_class'))
	mut var_ability := rt.create_object_dynamically(var_ability_class, [
		rt.new_string(name),
		var_args_mutated,
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'InvalidArgumentException') {
		mut var_e := var_e_1.clone()
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			rt.new_string('6.9.0')])
		return rt.new_null()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	this.registered_abilities.array_set(name, var_ability.clone())
	return var_ability.clone()
}

fn (mut this Class_WP_Abilities_Registry) unregister(name string) rt.PhpVal {
	if !(this.is_registered(name)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Ability "%s" not found.')]),
				rt.call_function('esc_html', [rt.new_string(name)]),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	mut var_unregistered_ability := this.registered_abilities.array_get(rt.new_string(name))
	this.registered_abilities.array_unset(rt.new_string(name))
	return var_unregistered_ability.clone()
}

fn (mut this Class_WP_Abilities_Registry) get_all_registered() rt.PhpVal {
	return this.registered_abilities
}

fn (mut this Class_WP_Abilities_Registry) is_registered(name string) bool {
	return (rt.new_bool(this.registered_abilities.array_isset(rt.new_string(name)))).to_bool()
}

fn (mut this Class_WP_Abilities_Registry) get_registered(name string) rt.PhpVal {
	if !(this.is_registered(name)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Ability "%s" not found.')]),
				rt.call_function('esc_html', [rt.new_string(name)]),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	return this.registered_abilities.array_get(rt.new_string(name))
}

fn Class_WP_Abilities_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('init'),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Ability API should not be initialized before the %s action has fired.'),
				]),
				rt.new_string('<code>init</code>'),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Abilities_Registry',
		'instance')))
	{
		rt.set_static_prop('WP_Abilities_Registry', 'instance', rt.new_object('WP_Abilities_Registry',
			[]string{}, create_wp_abilities_registry()))
		mut iife_temp_0 := Class_WP_Ability_Categories_Registry{}
		mut iife_result_0 := iife_temp_0.get_instance()
		rt.call_function('do_action', [rt.new_string('wp_abilities_api_init'),
			rt.get_static_prop('WP_Abilities_Registry', 'instance')])
	}
	return rt.get_static_prop('WP_Abilities_Registry', 'instance')
}

fn (mut this Class_WP_Abilities_Registry) magic_wakeup() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT +
		' should never be unserialized.')))
}

fn (mut this Class_WP_Abilities_Registry) magic_sleep() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT +
		' should never be serialized.')))
}

struct Class_WP_Ability_Categories_Registry {
	rt.PhpObjectBase
}

struct Class_LogicException {
	rt.PhpObjectBase
}

fn create_wp_abilities_registry(_args ...rt.PhpVal) &Class_WP_Abilities_Registry {
	mut obj := &Class_WP_Abilities_Registry{
		PhpObjectBase:        rt.PhpObjectBase{}
		registered_abilities: rt.new_array()
	}
	return obj
}

fn create_wp_ability_categories_registry(_args ...rt.PhpVal) &Class_WP_Ability_Categories_Registry {
	mut obj := &Class_WP_Ability_Categories_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_logicexception(_args ...rt.PhpVal) &Class_LogicException {
	mut obj := &Class_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Abilities_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.register(dispatch_arg_0, mut dispatch_arg_1)
		}
		'unregister' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.unregister(dispatch_arg_0)
		}
		'get_all_registered' {
			return this.get_all_registered()
		}
		'is_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_registered(dispatch_arg_0))
		}
		'get_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_registered(dispatch_arg_0)
		}
		'get_instance' {
			return Class_WP_Abilities_Registry.get_instance()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__sleep' {
			this.magic_sleep()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Abilities_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_abilities' { return this.registered_abilities }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Abilities_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_abilities' {
			this.registered_abilities = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Ability_Categories_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Ability_Categories_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Ability_Categories_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WP_Abilities_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_abilities_registry()
		return rt.new_object('WP_Abilities_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Ability_Categories_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_ability_categories_registry()
		return rt.new_object('WP_Ability_Categories_Registry', []string{}, obj)
	})
	rt.register_class_factory('LogicException', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_logicexception()
		return rt.new_object('LogicException', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
