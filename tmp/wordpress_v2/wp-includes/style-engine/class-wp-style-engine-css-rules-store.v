import rt

struct Class_WP_Style_Engine_CSS_Rules_Store {
	rt.PhpObjectBase
pub mut:
	name  rt.PhpVal = rt.new_string('')
	rules rt.PhpVal = rt.new_array()
}

fn init_static_wp_style_engine_css_rules_store() {
	rt.init_static_prop('WP_Style_Engine_CSS_Rules_Store', 'stores', rt.new_array())
}

fn Class_WP_Style_Engine_CSS_Rules_Store.get_store(store_name string) rt.PhpVal {
	if !(rt.new_string(store_name).is_string()) || store_name == '' {
		return rt.new_null()
	}
	if !(rt.get_static_prop('WP_Style_Engine_CSS_Rules_Store', 'stores').array_isset(rt.new_string(store_name))) {
		rt.get_static_prop('WP_Style_Engine_CSS_Rules_Store', 'stores').array_set(store_name,
			create_wp_style_engine_css_rules_store())
		rt.call_method(rt.get_static_prop('WP_Style_Engine_CSS_Rules_Store', 'stores').array_get(rt.new_string(store_name)),
			'set_name', [rt.new_string(store_name)])
	}
	return rt.get_static_prop('WP_Style_Engine_CSS_Rules_Store', 'stores').array_get(rt.new_string(store_name))
}

fn Class_WP_Style_Engine_CSS_Rules_Store.get_stores() rt.PhpVal {
	return rt.get_static_prop('WP_Style_Engine_CSS_Rules_Store', 'stores')
}

fn Class_WP_Style_Engine_CSS_Rules_Store.remove_all_stores() {
	rt.set_static_prop('WP_Style_Engine_CSS_Rules_Store', 'stores', rt.new_array())
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) set_name(var_name rt.PhpVal) {
	this.name = var_name.clone()
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) get_name() rt.PhpVal {
	return this.name
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) get_all_rules() rt.PhpVal {
	return this.rules
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) add_rule(var_selector rt.PhpVal, rules_group string) rt.PhpVal {
	mut var_selector_mutated := var_selector
	mut rules_group_mutated := rules_group
	var_selector_mutated = rt.new_string((if rt.is_true(var_selector_mutated) {
		var_selector_mutated.clone().to_string().trim_space()
	} else {
		''
	}).str())
	rules_group_mutated = if rt.is_true(rt.new_string(rules_group_mutated)) {
		rules_group_mutated.trim_space()
	} else {
		''
	}
	if !rt.is_true(var_selector_mutated) {
		return rt.new_null()
	}
	if !(rules_group_mutated == '') {
		if !rt.is_true(this.rules.array_get(rt.new_string('${var_rules_group.to_string()} ${var_selector.to_string()}'))) {
			this.rules.array_set('${var_rules_group.to_string()} ${var_selector.to_string()}', create_wp_style_engine_css_rule(var_selector_mutated.clone(),
				rt.new_array(), rt.new_string(rules_group_mutated).clone()))
		}
		return this.rules.array_get(rt.new_string('${var_rules_group.to_string()} ${var_selector.to_string()}'))
	}
	if !rt.is_true(this.rules.array_get(var_selector_mutated)) {
		this.rules.array_set(var_selector_mutated,
			create_wp_style_engine_css_rule(var_selector_mutated.clone()))
	}
	return this.rules.array_get(var_selector_mutated)
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) remove_rule(var_selector rt.PhpVal) {
	mut var_selector_mutated := var_selector
	this.rules.array_unset(var_selector_mutated)
}

struct Class_WP_Style_Engine_CSS_Rule {
	rt.PhpObjectBase
}

fn create_wp_style_engine_css_rules_store(_args ...rt.PhpVal) &Class_WP_Style_Engine_CSS_Rules_Store {
	mut obj := &Class_WP_Style_Engine_CSS_Rules_Store{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_string('')
		rules:         rt.new_array()
	}
	return obj
}

fn create_wp_style_engine_css_rule(_args ...rt.PhpVal) &Class_WP_Style_Engine_CSS_Rule {
	mut obj := &Class_WP_Style_Engine_CSS_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_store' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WP_Style_Engine_CSS_Rules_Store.get_store(dispatch_arg_0)
		}
		'get_stores' {
			return Class_WP_Style_Engine_CSS_Rules_Store.get_stores()
		}
		'remove_all_stores' {
			Class_WP_Style_Engine_CSS_Rules_Store.remove_all_stores()
			return rt.new_null()
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'get_name' {
			return this.get_name()
		}
		'get_all_rules' {
			return this.get_all_rules()
		}
		'add_rule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.add_rule(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_rule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_rule(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Style_Engine_CSS_Rules_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'rules' { return this.rules }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'rules' {
			this.rules = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine_CSS_Rule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
