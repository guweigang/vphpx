import rt

struct Class_WP_Ability_Categories_Registry {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		registered_categories rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Ability_Categories_Registry) register(slug string, mut var_args Class_array) rt.PhpVal {
	mut var_args_mutated := var_args
	if this.is_registered(slug) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability category "%s" is already registered.')]), rt.call_function('esc_html', [rt.new_string(slug)])]), rt.new_string('6.9.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z0-9]+(?:-[a-z0-9]+)*$/'), rt.new_string(slug)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Ability category slug must contain only lowercase alphanumeric characters and dashes.')]), rt.new_string('6.9.0')])
		return rt.new_null()
	}
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('wp_register_ability_category_args'), var_args_mutated.dup(), rt.new_string(slug)])
	mut var_category := create_wp_ability_category(rt.new_string(slug).dup(), var_args_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'InvalidArgumentException') {
		mut var_e := var_e_1.dup()
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.new_string('6.9.0')])
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	this.registered_categories.array_set(slug, var_category.dup())
	return rt.new_object('WP_Ability_Category', []string{}, var_category)
}

fn (mut this Class_WP_Ability_Categories_Registry) unregister(slug string) rt.PhpVal {
	if !(this.is_registered(slug)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability category "%s" not found.')]), rt.call_function('esc_html', [rt.new_string(slug)])]), rt.new_string('6.9.0')])
		return rt.new_null()
	}
	mut var_unregistered_category := this.registered_categories.array_get(slug)
	this.registered_categories.array_unset(rt.new_string(slug))
	return var_unregistered_category.dup()
}

fn (mut this Class_WP_Ability_Categories_Registry) get_all_registered() rt.PhpVal {
	return this.registered_categories
}

fn (mut this Class_WP_Ability_Categories_Registry) is_registered(slug string) bool {
	return (rt.new_bool(this.registered_categories.array_isset(rt.new_string(slug)))).to_bool()
}

fn (mut this Class_WP_Ability_Categories_Registry) get_registered(slug string) rt.PhpVal {
	if !(this.is_registered(slug)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability category "%s" not found.')]), rt.call_function('esc_html', [rt.new_string(slug)])]), rt.new_string('6.9.0')])
		return rt.new_null()
	}
	return this.registered_categories.array_get(slug)
}

fn Class_WP_Ability_Categories_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability API should not be initialized before the %s action has fired.')]), rt.new_string('<code>init</code>')]), rt.new_string('6.9.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
		rt.call_function('do_action', [rt.new_string('wp_abilities_api_categories_init'), // unsupported expression: Expr_StaticPropertyFetch])
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WP_Ability_Categories_Registry) magic_wakeup()  {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT + ' should never be unserialized.')))
}

fn (mut this Class_WP_Ability_Categories_Registry) magic_sleep()  {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT + ' should never be serialized.')))
}

struct Class_WP_Ability_Category {
	rt.PhpObjectBase
}

struct Class_LogicException {
	rt.PhpObjectBase
}

fn create_wp_ability_categories_registry() &Class_WP_Ability_Categories_Registry {
	mut obj := &Class_WP_Ability_Categories_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		registered_categories: rt.new_array()
	}
	return obj
}

fn create_wp_ability_category() &Class_WP_Ability_Category {
	mut obj := &Class_WP_Ability_Category{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_logicexception() &Class_LogicException {
	mut obj := &Class_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Ability_Categories_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
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
			return Class_WP_Ability_Categories_Registry.get_instance()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__sleep' {
			this.magic_sleep()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Ability_Categories_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'registered_categories' { return this.registered_categories }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Ability_Categories_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'registered_categories' { this.registered_categories = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Ability_Category) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Ability_Category) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Ability_Category) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_abilities_api_class_wp_ability_categories_registry_php() {
	// unsupported statement: Stmt_Declare
}
