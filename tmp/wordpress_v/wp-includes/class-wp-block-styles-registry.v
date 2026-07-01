import rt

struct Class_WP_Block_Styles_Registry {
	rt.PhpObjectBase
pub mut:
		registered_block_styles rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Styles_Registry) register(var_block_name rt.PhpVal, var_style_properties rt.PhpVal) bool {
	mut var_style_properties_mutated := var_style_properties
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_block_name.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_block_name.dup().is_array()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block name must be a string or array.')]), rt.new_string('6.6.0')])
		return false
	}
	if rt.is_true(rt.new_bool(!(var_style_properties_mutated.array_isset(rt.new_string('name'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_style_properties_mutated.array_get('name').is_string()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block style name must be a string.')]), rt.new_string('5.3.0')])
		return false
	}
	if rt.is_true(rt.call_function('str_contains', [var_style_properties_mutated.array_get('name'), rt.new_string(' ')])) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block style name must not contain any spaces.')]), rt.new_string('5.9.0')])
		return false
	}
	mut var_block_style_name := var_style_properties_mutated.array_get('name')
	mut var_block_names := if rt.is_true(rt.new_bool(var_block_name.dup().is_string())) { rt.create_array([rt.ArrayItem{ key: none, val: var_block_name }]) } else { var_block_name }
	if !rt.is_true(var_style_properties_mutated.array_get('label')) {
		var_style_properties_mutated.array_set('label', var_block_style_name.dup())
	}
	{
		mut iter_1 := var_block_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name := item_1.val
			if !(this.registered_block_styles.array_isset(var_name)) {
				this.registered_block_styles.array_set(var_name, rt.new_array())
			}
			this.registered_block_styles.array_get_mut(var_name).array_set(var_block_style_name, var_style_properties_mutated.dup())
		}
	}
	return true
}

fn (mut this Class_WP_Block_Styles_Registry) unregister(var_block_name rt.PhpVal, var_block_style_name rt.PhpVal) bool {
	mut var_block_style_name_mutated := var_block_style_name
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_block_name.dup(), var_block_style_name_mutated.dup()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Block "%1$s" does not contain a style named "%2$s".')]), var_block_name.dup(), var_block_style_name_mutated.dup()]), rt.new_string('5.3.0')])
		return false
	}
	this.registered_block_styles.array_get(var_block_name).array_unset(var_block_style_name_mutated)
	return true
}

fn (mut this Class_WP_Block_Styles_Registry) get_registered(var_block_name rt.PhpVal, var_block_style_name rt.PhpVal) rt.PhpVal {
	mut var_block_style_name_mutated := var_block_style_name
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_block_name.dup(), var_block_style_name_mutated.dup()))))) {
		return rt.new_null()
	}
	return this.registered_block_styles.array_get(var_block_name).array_get(var_block_style_name_mutated)
}

fn (mut this Class_WP_Block_Styles_Registry) get_all_registered() rt.PhpVal {
	return this.registered_block_styles
}

fn (mut this Class_WP_Block_Styles_Registry) get_registered_styles_for_block(var_block_name rt.PhpVal) rt.PhpVal {
	return if !(this.registered_block_styles.array_get(var_block_name)).is_null() { this.registered_block_styles.array_get(var_block_name) } else { rt.new_array() }
}

fn (mut this Class_WP_Block_Styles_Registry) is_registered(var_block_name rt.PhpVal, var_block_style_name rt.PhpVal) rt.PhpVal {
	mut var_block_style_name_mutated := var_block_style_name
	return rt.new_bool(!(var_block_name).is_null() && !(var_block_style_name_mutated).is_null() && this.registered_block_styles.array_get(var_block_name).array_isset(var_block_style_name_mutated))
}

fn Class_WP_Block_Styles_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn create_wp_block_styles_registry() &Class_WP_Block_Styles_Registry {
	mut obj := &Class_WP_Block_Styles_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		registered_block_styles: rt.new_array()
		instance: rt.new_null()
	}
	return obj
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.register(dispatch_arg_0, dispatch_arg_1))
		}
		'unregister' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.unregister(dispatch_arg_0, dispatch_arg_1))
		}
		'get_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_registered(dispatch_arg_0, dispatch_arg_1)
		}
		'get_all_registered' {
			return this.get_all_registered()
		}
		'get_registered_styles_for_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_registered_styles_for_block(dispatch_arg_0)
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.is_registered(dispatch_arg_0, dispatch_arg_1)
		}
		'get_instance' {
			return Class_WP_Block_Styles_Registry.get_instance()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Styles_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_block_styles' { return this.registered_block_styles }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_block_styles' { this.registered_block_styles = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_block_styles_registry_php() {
}
