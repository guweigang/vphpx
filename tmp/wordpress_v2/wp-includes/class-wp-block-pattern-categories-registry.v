import rt

struct Class_WP_Block_Pattern_Categories_Registry {
	rt.PhpObjectBase
pub mut:
	registered_categories              rt.PhpVal = rt.new_array()
	registered_categories_outside_init rt.PhpVal = rt.new_array()
}

fn init_static_wp_block_pattern_categories_registry() {
	rt.init_static_prop('WP_Block_Pattern_Categories_Registry', 'instance', rt.new_null())
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) register(var_category_name rt.PhpVal, var_category_properties rt.PhpVal) bool {
	if !(!var_category_name.is_null()) || !(var_category_name.clone().is_string()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('Block pattern category name must be a string.'),
			]),
			rt.new_string('5.5.0')])
		return false
	}
	mut var_category := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_category_name }]),
		var_category_properties.clone(),
	])
	this.registered_categories.array_set(var_category_name, var_category.clone())
	if rt.is_true(rt.call_function('current_action', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('init'), rt.call_function('current_action', []rt.PhpVal{}))))) {
		this.registered_categories_outside_init.array_set(var_category_name, var_category.clone())
	}
	return true
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) unregister(var_category_name rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_category_name.clone()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Block pattern category "%s" not found.'),
				]),
				var_category_name.clone(),
			]),
			rt.new_string('5.5.0')])
		return false
	}
	this.registered_categories.array_unset(var_category_name)
	this.registered_categories_outside_init.array_unset(var_category_name)
	return true
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) get_registered(var_category_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_category_name.clone()))))) {
		return rt.new_null()
	}
	return this.registered_categories.array_get(var_category_name)
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) get_all_registered(outside_init_only bool) rt.PhpVal {
	return rt.call_function('array_values', [if var_outside_init_only {
		this.registered_categories_outside_init
	} else {
		this.registered_categories
	}])
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) is_registered(var_category_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!var_category_name.is_null()
		&& this.registered_categories.array_isset(var_category_name))
}

fn Class_WP_Block_Pattern_Categories_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Block_Pattern_Categories_Registry',
		'instance')))
	{
		rt.set_static_prop('WP_Block_Pattern_Categories_Registry', 'instance', rt.new_object('WP_Block_Pattern_Categories_Registry',
			[]string{}, create_wp_block_pattern_categories_registry()))
	}
	return rt.get_static_prop('WP_Block_Pattern_Categories_Registry', 'instance')
}

fn create_wp_block_pattern_categories_registry(_args ...rt.PhpVal) &Class_WP_Block_Pattern_Categories_Registry {
	mut obj := &Class_WP_Block_Pattern_Categories_Registry{
		PhpObjectBase:                      rt.PhpObjectBase{}
		registered_categories:              rt.new_array()
		registered_categories_outside_init: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_all_registered(dispatch_arg_0)
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_registered(dispatch_arg_0)
		}
		'get_instance' {
			return Class_WP_Block_Pattern_Categories_Registry.get_instance()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Block_Pattern_Categories_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_categories' { return this.registered_categories }
		'registered_categories_outside_init' { return this.registered_categories_outside_init }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_categories' {
			this.registered_categories = val
			return true
		}
		'registered_categories_outside_init' {
			this.registered_categories_outside_init = val
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
