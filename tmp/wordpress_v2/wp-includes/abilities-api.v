import rt

fn wp_register_ability(name string, var_args rt.PhpVal) rt.PhpVal {
	mut var_name := name
	mut var_registry := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [
		rt.new_string('wp_abilities_api_init'),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Abilities must be registered on the %1$s action. The ability %2$s was not registered.'),
				]),
				rt.new_string('<code>wp_abilities_api_init</code>'),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [rt.new_string(name)])).str() + '</code>'),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	mut iife_temp_0 := Class_WP_Abilities_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_registry = iife_result_0
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'register', [rt.new_string(name),
		var_args.clone()])
}

fn wp_unregister_ability(name string) rt.PhpVal {
	mut var_name := name
	mut var_registry := rt.new_null()
	mut iife_temp_1 := Class_WP_Abilities_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	var_registry = iife_result_1
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'unregister', [rt.new_string(name)])
}

fn wp_has_ability(name string) bool {
	mut var_name := name
	mut var_registry := rt.new_null()
	mut iife_temp_2 := Class_WP_Abilities_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	var_registry = iife_result_2
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return false
	}
	return (rt.call_method(var_registry, 'is_registered', [rt.new_string(name)])).to_bool()
}

fn wp_get_ability(name string) rt.PhpVal {
	mut var_name := name
	mut var_registry := rt.new_null()
	mut iife_temp_3 := Class_WP_Abilities_Registry{}
	mut iife_result_3 := iife_temp_3.get_instance()
	var_registry = iife_result_3
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'get_registered', [rt.new_string(name)])
}

fn wp_get_abilities() rt.PhpVal {
	mut var_registry := rt.new_null()
	mut iife_temp_4 := Class_WP_Abilities_Registry{}
	mut iife_result_4 := iife_temp_4.get_instance()
	var_registry = iife_result_4
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_array()
	}
	return rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
}

fn wp_register_ability_category(slug string, var_args rt.PhpVal) rt.PhpVal {
	mut var_slug := slug
	mut var_registry := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [
		rt.new_string('wp_abilities_api_categories_init'),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Ability categories must be registered on the %1$s action. The ability category %2$s was not registered.'),
				]),
				rt.new_string('<code>wp_abilities_api_categories_init</code>'),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [rt.new_string(slug)])).str() + '</code>'),
			]),
			rt.new_string('6.9.0')])
		return rt.new_null()
	}
	mut iife_temp_5 := Class_WP_Ability_Categories_Registry{}
	mut iife_result_5 := iife_temp_5.get_instance()
	var_registry = iife_result_5
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'register', [rt.new_string(slug),
		var_args.clone()])
}

fn wp_unregister_ability_category(slug string) rt.PhpVal {
	mut var_slug := slug
	mut var_registry := rt.new_null()
	mut iife_temp_6 := Class_WP_Ability_Categories_Registry{}
	mut iife_result_6 := iife_temp_6.get_instance()
	var_registry = iife_result_6
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'unregister', [rt.new_string(slug)])
}

fn wp_has_ability_category(slug string) bool {
	mut var_slug := slug
	mut var_registry := rt.new_null()
	mut iife_temp_7 := Class_WP_Ability_Categories_Registry{}
	mut iife_result_7 := iife_temp_7.get_instance()
	var_registry = iife_result_7
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return false
	}
	return (rt.call_method(var_registry, 'is_registered', [rt.new_string(slug)])).to_bool()
}

fn wp_get_ability_category(slug string) rt.PhpVal {
	mut var_slug := slug
	mut var_registry := rt.new_null()
	mut iife_temp_8 := Class_WP_Ability_Categories_Registry{}
	mut iife_result_8 := iife_temp_8.get_instance()
	var_registry = iife_result_8
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_null()
	}
	return rt.call_method(var_registry, 'get_registered', [rt.new_string(slug)])
}

fn wp_get_ability_categories() rt.PhpVal {
	mut var_registry := rt.new_null()
	mut iife_temp_9 := Class_WP_Ability_Categories_Registry{}
	mut iife_result_9 := iife_temp_9.get_instance()
	var_registry = iife_result_9
	if rt.is_true(rt.identical(rt.new_null(), var_registry)) {
		return rt.new_array()
	}
	return rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
}

struct Class_WP_Abilities_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Ability_Categories_Registry {
	rt.PhpObjectBase
}

fn create_wp_abilities_registry(_args ...rt.PhpVal) &Class_WP_Abilities_Registry {
	mut obj := &Class_WP_Abilities_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ability_categories_registry(_args ...rt.PhpVal) &Class_WP_Ability_Categories_Registry {
	mut obj := &Class_WP_Ability_Categories_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Abilities_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Abilities_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Abilities_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
