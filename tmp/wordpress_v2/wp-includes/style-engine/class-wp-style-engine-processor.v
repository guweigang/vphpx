import rt

struct Class_WP_Style_Engine_Processor {
	rt.PhpObjectBase
pub mut:
	stores    rt.PhpVal = rt.new_array()
	css_rules rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Style_Engine_Processor) add_store(var_store rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_store,
		'WP_Style_Engine_CSS_Rules_Store'))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('$store must be an instance of WP_Style_Engine_CSS_Rules_Store'),
			]),
			rt.new_string('6.1.0')])
		return rt.new_object('WP_Style_Engine_Processor', []string{}, this)
	}
	this.stores.array_set(rt.call_method(var_store, 'get_name', []rt.PhpVal{}), var_store.clone())
	return rt.new_object('WP_Style_Engine_Processor', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_Processor) add_rules(var_css_rules rt.PhpVal) rt.PhpVal {
	mut var_css_rules_mutated := var_css_rules
	if !(var_css_rules_mutated.clone().is_array()) {
		var_css_rules_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_css_rules_mutated },
		])
	}
	mut iter_1 := var_css_rules_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_rule := item_1.val
		mut var_selector := rt.call_method(var_rule, 'get_selector', []rt.PhpVal{})
		mut var_rules_group := rt.call_method(var_rule, 'get_rules_group', []rt.PhpVal{})
		if !(!rt.is_true(var_rules_group)) {
			if this.css_rules.array_isset(rt.new_string('${var_rules_group.to_string()} ${var_selector.to_string()}')) {
				rt.call_method(this.css_rules.array_get(rt.new_string('${var_rules_group.to_string()} ${var_selector.to_string()}')),
					'add_declarations', [
					rt.call_method(var_rule, 'get_declarations', []rt.PhpVal{}),
				])
				continue
			}
			this.css_rules.array_set('${var_rules_group.to_string()} ${var_selector.to_string()}',
				var_rule.clone())
			continue
		}
		if this.css_rules.array_isset(var_selector) {
			rt.call_method(this.css_rules.array_get(var_selector), 'add_declarations', [
				rt.call_method(var_rule, 'get_declarations', []rt.PhpVal{}),
			])
			continue
		}
		this.css_rules.array_set(rt.call_method(var_rule, 'get_selector', []rt.PhpVal{}),
			var_rule.clone())
	}
	return rt.new_object('WP_Style_Engine_Processor', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_Processor) get_css(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	mut var_defaults := {
		'optimize': false
		'prettify': rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
			&& rt.is_true(rt.get_constant('SCRIPT_DEBUG'))
	}
	var_options_mutated = rt.call_function('wp_parse_args', [
		var_options_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	mut iter_2 := this.stores.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_store := item_2.val
		this.add_rules(rt.call_method(var_store, 'get_all_rules', []rt.PhpVal{}))
	}
	if rt.is_true(rt.identical(rt.new_bool(true),
		var_options_mutated.array_get(rt.new_string('optimize'))))
	{
		this.combine_rules_selectors()
	}
	mut var_css := rt.new_string('')
	mut iter_3 := this.css_rules.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_rule := item_3.val
		var_css = rt.concat(var_css, rt.call_method(var_rule, 'get_css', [
			var_options_mutated.array_get(rt.new_string('prettify')),
		]))
		var_css = rt.concat(var_css, if rt.is_true(var_options_mutated.array_get(rt.new_string('prettify'))) {
			'\n'
		} else {
			''
		})
	}
	return var_css.clone()
}

fn (mut this Class_WP_Style_Engine_Processor) combine_rules_selectors() {
	mut var_selectors_json := rt.new_array()
	mut iter_4 := this.css_rules.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_rule := item_4.val
		mut var_declarations := rt.call_method(rt.call_method(var_rule, 'get_declarations',
			[]rt.PhpVal{}), 'get_declarations', []rt.PhpVal{})
		rt.call_function('ksort', [var_declarations.clone()])
		var_selectors_json.array_set(rt.call_method(var_rule, 'get_selector', []rt.PhpVal{}), rt.call_function('wp_json_encode', [
			var_declarations.clone(),
		]))
	}
	mut iter_5 := var_selectors_json.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_json := item_5.val
		mut var_selector := item_5.key
		mut var_duplicates := rt.func_array_keys(var_selectors_json.clone(), var_json.clone(),
			rt.new_bool(true))
		if 1 >= var_duplicates.clone().array_count() {
			continue
		}
		mut var_declarations := rt.call_method(this.css_rules.array_get(var_selector),
			'get_declarations', []rt.PhpVal{})
		mut iter_6 := var_duplicates.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_key := item_6.val
			var_selectors_json.array_unset(var_key)
			this.css_rules.array_unset(var_key)
		}
		mut var_duplicate_selectors := rt.call_function('implode', [
			rt.new_string(','), var_duplicates.clone()])
		this.css_rules.array_set(var_duplicate_selectors, create_wp_style_engine_css_rule(var_duplicate_selectors.clone(),
			var_declarations.clone()))
	}
}

struct Class_WP_Style_Engine_CSS_Rule {
	rt.PhpObjectBase
}

fn create_wp_style_engine_processor(_args ...rt.PhpVal) &Class_WP_Style_Engine_Processor {
	mut obj := &Class_WP_Style_Engine_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
		stores:        rt.new_array()
		css_rules:     rt.new_array()
	}
	return obj
}

fn create_wp_style_engine_css_rule(_args ...rt.PhpVal) &Class_WP_Style_Engine_CSS_Rule {
	mut obj := &Class_WP_Style_Engine_CSS_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Style_Engine_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_store' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_store(dispatch_arg_0)
		}
		'add_rules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_rules(dispatch_arg_0)
		}
		'get_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_css(dispatch_arg_0)
		}
		'combine_rules_selectors' {
			this.combine_rules_selectors()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Style_Engine_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stores' { return this.stores }
		'css_rules' { return this.css_rules }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Style_Engine_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stores' {
			this.stores = val
			return true
		}
		'css_rules' {
			this.css_rules = val
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
