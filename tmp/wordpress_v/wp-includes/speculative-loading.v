import rt

fn wp_get_speculation_rules_configuration() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])))) {
		mut var_config := rt.create_array([rt.ArrayItem{ key: 'mode', val: 'auto' }, rt.ArrayItem{ key: 'eagerness', val: 'auto' }])
	} else {
		var_config = rt.new_null()
	}
	var_config = rt.call_function('apply_filters', [rt.new_string('wp_speculation_rules_configuration'), var_config.dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_config)) {
		return rt.new_null()
	}
	mut var_default_mode := 'prefetch'
	mut var_default_eagerness := 'conservative'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_config.dup().is_array()))))) {
		return rt.create_array([rt.ArrayItem{ key: 'mode', val: var_default_mode }, rt.ArrayItem{ key: 'eagerness', val: var_default_eagerness }])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_config.array_isset(rt.new_string('mode'))) || rt.is_true(rt.identical(rt.new_string('auto'), var_config.array_get('mode'))))) || rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Speculation_Rules{}; return temp.is_valid_mode(arg_0) }(var_config.array_get('mode')))))))) {
		var_config.array_set('mode', var_default_mode)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_config.array_isset(rt.new_string('eagerness'))) || rt.is_true(rt.identical(rt.new_string('auto'), var_config.array_get('eagerness'))))) || rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Speculation_Rules{}; return temp.is_valid_eagerness(arg_0) }(var_config.array_get('eagerness')))))))) || rt.is_true(rt.identical(rt.new_string('immediate'), var_config.array_get('eagerness'))))) {
		var_config.array_set('eagerness', var_default_eagerness)
	}
	return rt.create_array([rt.ArrayItem{ key: 'mode', val: var_config.array_get('mode') }, rt.ArrayItem{ key: 'eagerness', val: var_config.array_get('eagerness') }])
}

fn wp_get_speculation_rules() rt.PhpVal {
	mut var_configuration := wp_get_speculation_rules_configuration()
	if rt.is_true(rt.identical(rt.new_null(), var_configuration)) {
		return rt.new_null()
	}
	mut var_mode := var_configuration.array_get('mode')
	mut var_eagerness := var_configuration.array_get('eagerness')
	mut var_prefixer := create_wp_url_pattern_prefixer()
	mut var_base_href_exclude_paths := [var_prefixer.prefix_path_pattern(rt.new_string('/wp-*.php'), rt.new_string('site')), var_prefixer.prefix_path_pattern(rt.new_string('/wp-admin/*'), rt.new_string('site')), var_prefixer.prefix_path_pattern(rt.new_string('/*'), rt.new_string('uploads')), var_prefixer.prefix_path_pattern(rt.new_string('/*'), rt.new_string('content')), var_prefixer.prefix_path_pattern(rt.new_string('/*'), rt.new_string('plugins')), var_prefixer.prefix_path_pattern(rt.new_string('/*'), rt.new_string('template')), var_prefixer.prefix_path_pattern(rt.new_string('/*'), rt.new_string('stylesheet'))]
	if rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		var_base_href_exclude_paths << var_prefixer.prefix_path_pattern(rt.new_string('/*\\?(.+)'), rt.new_string('home'))
	} else {
		var_base_href_exclude_paths << var_prefixer.prefix_path_pattern(rt.new_string('/*\\?*(^|&)*nonce*=*'), rt.new_string('home'))
	}
	mut var_href_exclude_paths := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('wp_speculation_rules_href_exclude_paths'), rt.new_array(), var_mode.dup()]))
	closure_8_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_prefixer] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	mut var_href_exclude_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_prefixer.prefix_path_pattern(var_href_exclude_path.dup())
	}
	var_href_exclude_paths = rt.call_function('array_values', [rt.call_function('array_unique', [rt.call_function('array_merge', [var_base_href_exclude_paths.dup(), rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_href_exclude_paths.dup()])])])])
	mut var_speculation_rules := create_wp_speculation_rules()
	mut var_main_rule_conditions := [[var_prefixer.prefix_path_pattern(rt.new_string('/*'))], [[var_href_exclude_paths]], [[rt.new_string('a[rel~="nofollow"]')]], [[rt.new_string(".no-${var_mode.to_string()}, .no-${var_mode.to_string()} a")]]]
	if rt.is_true(rt.identical(rt.new_string('prerender'), var_mode)) {
		var_main_rule_conditions << rt.create_array([rt.ArrayItem{ key: 'not', val: rt.create_array([rt.ArrayItem{ key: 'selector_matches', val: '.no-prefetch, .no-prefetch a' }]) }])
	}
	rt.call_method(var_speculation_rules, 'add_rule', [var_mode.dup(), rt.new_string('main'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'document' }, rt.ArrayItem{ key: 'where', val: rt.create_array([rt.ArrayItem{ key: 'and', val: var_main_rule_conditions }]) }, rt.ArrayItem{ key: 'eagerness', val: var_eagerness }])])
	rt.call_function('do_action', [rt.new_string('wp_load_speculation_rules'), var_speculation_rules.dup()])
	return var_speculation_rules.dup()
}

fn wp_print_speculation_rules() {
	mut var_speculation_rules := wp_get_speculation_rules()
	if rt.is_true(rt.identical(rt.new_null(), var_speculation_rules)) {
		return rt.new_null()
	}
	rt.call_function('wp_print_inline_script_tag', [// unsupported expression: Expr_Cast_String, rt.create_array([rt.ArrayItem{ key: 'type', val: 'speculationrules' }])])
}

struct Class_WP_Speculation_Rules {
	rt.PhpObjectBase
}

struct Class_WP_URL_Pattern_Prefixer {
	rt.PhpObjectBase
}

fn create_wp_speculation_rules() &Class_WP_Speculation_Rules {
	mut obj := &Class_WP_Speculation_Rules{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_url_pattern_prefixer() &Class_WP_URL_Pattern_Prefixer {
	mut obj := &Class_WP_URL_Pattern_Prefixer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Speculation_Rules) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Speculation_Rules) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Speculation_Rules) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_URL_Pattern_Prefixer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_URL_Pattern_Prefixer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_URL_Pattern_Prefixer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_speculative_loading_php() {
}
