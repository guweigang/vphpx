import rt

struct Class_WP_Speculation_Rules {
	rt.PhpObjectBase
pub mut:
		rules_by_mode rt.PhpVal = rt.new_array()
		mode_allowlist rt.PhpVal = rt.new_array()
		eagerness_allowlist rt.PhpVal = rt.new_array()
		source_allowlist rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Speculation_Rules) add_rule(mode string, id string, mut var_rule Class_array) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Speculation_Rules.is_valid_mode(mode))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The value "%s" is not a valid speculation rules mode.')]), rt.call_function('esc_html', [rt.new_string(mode)])]), rt.new_string('6.8.0')])
		return false
	}
	if !(this.is_valid_id(id)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The value "%s" is not a valid ID for a speculation rule.')]), rt.call_function('esc_html', [rt.new_string(id)])]), rt.new_string('6.8.0')])
		return false
	}
	if this.has_rule(mode, id) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A speculation rule with ID "%s" already exists.')]), rt.call_function('esc_html', [rt.new_string(id)])]), rt.new_string('6.8.0')])
		return false
	}
	if !(var_rule.array_isset(rt.new_string('where'))) && !(var_rule.array_isset(rt.new_string('urls'))) || var_rule.array_isset(rt.new_string('where')) && var_rule.array_isset(rt.new_string('urls')) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A speculation rule must include either a "%1$s" key or a "%2$s" key, but not both.')]), rt.new_string('where'), rt.new_string('urls')]), rt.new_string('6.8.0')])
		return false
	}
	if var_rule.array_isset(rt.new_string('source')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Speculation_Rules.is_valid_source((var_rule.array_get('source')).str()))))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The value "%s" is not a valid source for a speculation rule.')]), rt.call_function('esc_html', [var_rule.array_get('source')])]), rt.new_string('6.8.0')])
			return false
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('list'), var_rule.array_get('source'))) && var_rule.array_isset(rt.new_string('where')))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A speculation rule of source "%1$s" must not include a "%2$s" key.')]), rt.new_string('list'), rt.new_string('where')]), rt.new_string('6.8.0')])
			return false
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('document'), var_rule.array_get('source'))) && var_rule.array_isset(rt.new_string('urls')))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A speculation rule of source "%1$s" must not include a "%2$s" key.')]), rt.new_string('document'), rt.new_string('urls')]), rt.new_string('6.8.0')])
			return false
		}
	}
	if var_rule.array_isset(rt.new_string('eagerness')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Speculation_Rules.is_valid_eagerness((var_rule.array_get('eagerness')).str()))))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The value "%s" is not a valid eagerness for a speculation rule.')]), rt.call_function('esc_html', [var_rule.array_get('eagerness')])]), rt.new_string('6.8.0')])
			return false
		}
		if rt.is_true(rt.new_bool(var_rule.array_isset(rt.new_string('where')) && rt.is_true(rt.identical(rt.new_string('immediate'), var_rule.array_get('eagerness'))))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The eagerness value "%s" is forbidden for document-level speculation rules.')]), rt.new_string('immediate')]), rt.new_string('6.8.0')])
			return false
		}
	}
	if !(this.rules_by_mode.array_isset(rt.new_string(mode))) {
		this.rules_by_mode.array_set(mode, rt.new_array())
	}
	this.rules_by_mode.array_get_mut(mode).array_set(id, var_rule.dup())
	return true
}

fn (mut this Class_WP_Speculation_Rules) has_rule(mode string, id string) bool {
	return (rt.new_bool(this.rules_by_mode.array_get(mode).array_isset(rt.new_string(id)))).to_bool()
}

fn (mut this Class_WP_Speculation_Rules) jsonserialize() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_rules := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('array_values', [var_rules.dup()])
	}
	mut var_rules := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('array_values', [var_rules.dup()])
	}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.call_function('array_filter', [this.rules_by_mode])])
}

fn (mut this Class_WP_Speculation_Rules) is_valid_id(id string) bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn Class_WP_Speculation_Rules.is_valid_mode(mode string) bool {
	return (rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(mode)))).to_bool()
}

fn Class_WP_Speculation_Rules.is_valid_eagerness(eagerness string) bool {
	return (rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(eagerness)))).to_bool()
}

fn Class_WP_Speculation_Rules.is_valid_source(source string) bool {
	return (rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(source)))).to_bool()
}

fn create_wp_speculation_rules() &Class_WP_Speculation_Rules {
	mut obj := &Class_WP_Speculation_Rules{
		PhpObjectBase: rt.PhpObjectBase{}
		rules_by_mode: rt.new_array()
		mode_allowlist: rt.new_array()
		eagerness_allowlist: rt.new_array()
		source_allowlist: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Speculation_Rules) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_rule' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.add_rule(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'has_rule' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_rule(dispatch_arg_0, dispatch_arg_1))
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		'is_valid_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_valid_id(dispatch_arg_0))
		}
		'is_valid_mode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_Speculation_Rules.is_valid_mode(dispatch_arg_0))
		}
		'is_valid_eagerness' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_Speculation_Rules.is_valid_eagerness(dispatch_arg_0))
		}
		'is_valid_source' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_Speculation_Rules.is_valid_source(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Speculation_Rules) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rules_by_mode' { return this.rules_by_mode }
		'mode_allowlist' { return this.mode_allowlist }
		'eagerness_allowlist' { return this.eagerness_allowlist }
		'source_allowlist' { return this.source_allowlist }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Speculation_Rules) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rules_by_mode' { this.rules_by_mode = val; return true }
		'mode_allowlist' { this.mode_allowlist = val; return true }
		'eagerness_allowlist' { this.eagerness_allowlist = val; return true }
		'source_allowlist' { this.source_allowlist = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_speculation_rules_php() {
}
