import rt

struct Class_WP_Style_Engine_CSS_Rule {
	rt.PhpObjectBase
pub mut:
	selector     rt.PhpVal = rt.new_null()
	declarations rt.PhpVal = rt.new_null()
	rules_group  rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) construct(selector string, var_declarations rt.PhpVal, rules_group string) {
	mut selector_mutated := selector
	mut rules_group_mutated := rules_group
	this.set_selector(rt.new_string(selector_mutated))
	this.add_declarations(var_declarations.clone())
	this.set_rules_group(rt.new_string(rules_group_mutated))
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) set_selector(var_selector rt.PhpVal) rt.PhpVal {
	mut var_selector_mutated := var_selector
	this.selector = var_selector_mutated.clone()
	return rt.new_object('WP_Style_Engine_CSS_Rule', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) add_declarations(var_declarations rt.PhpVal) rt.PhpVal {
	mut var_is_declarations_object := rt.new_bool(!(var_declarations.clone().is_array()))
	mut var_declarations_array := if rt.is_true(var_is_declarations_object) {
		rt.call_method(var_declarations, 'get_declarations', []rt.PhpVal{})
	} else {
		var_declarations
	}
	if rt.is_true(rt.identical(rt.new_null(), this.declarations)) {
		if rt.is_true(var_is_declarations_object) {
			this.declarations = var_declarations.clone()
			return rt.new_object('WP_Style_Engine_CSS_Rule', []string{}, this)
		}
		this.declarations = create_wp_style_engine_css_declarations(var_declarations_array.clone())
	}
	rt.call_method(this.declarations, 'add_declarations', [var_declarations_array.clone()])
	return rt.new_object('WP_Style_Engine_CSS_Rule', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) set_rules_group(var_rules_group rt.PhpVal) rt.PhpVal {
	mut var_rules_group_mutated := var_rules_group
	this.rules_group = var_rules_group_mutated.clone()
	return rt.new_object('WP_Style_Engine_CSS_Rule', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) get_rules_group() rt.PhpVal {
	return this.rules_group
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) get_declarations() rt.PhpVal {
	return this.declarations
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) get_selector() rt.PhpVal {
	return this.selector
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) get_css(should_prettify bool, indent_count i64) string {
	mut var_rule_indent := if var_should_prettify { rt.call_function('str_repeat', [
			rt.new_string('\t'),
			rt.new_int(indent_count),
		]) } else { rt.new_string('') }
	mut var_nested_rule_indent := if var_should_prettify { rt.call_function('str_repeat', [
			rt.new_string('\t'),
			rt.new_int(indent_count + 1),
		]) } else { rt.new_string('') }
	mut var_declarations_indent :=
		rt.new_int(if var_should_prettify { indent_count + 1 } else { 0 })
	mut var_nested_declarations_indent := rt.new_int(if var_should_prettify {
		indent_count + 2
	} else {
		0
	})
	mut var_suffix := rt.new_string((if var_should_prettify { '\n' } else { '' }).str())
	mut var_spacer := rt.new_string((if var_should_prettify { ' ' } else { '' }).str())
	mut var_selector := if var_should_prettify { rt.call_function('implode', [
			rt.new_string(','),
			rt.call_function('array_map', [rt.new_string('trim'),
				rt.call_function('explode', [rt.new_string(','),
					this.get_selector()])]),
		]) } else { this.get_selector() }
	var_selector = if var_should_prettify { rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: ',' }]),
			rt.new_string(',\n'),
			var_selector.clone(),
		]) } else { var_selector }
	mut var_rules_group := this.get_rules_group()
	mut var_has_rules_group := rt.new_bool(!(!rt.is_true(var_rules_group)))
	mut var_css_declarations := rt.call_method(this.declarations, 'get_declarations_string', [
		rt.new_bool(should_prettify),
		if rt.is_true(var_has_rules_group) {
			var_nested_declarations_indent
		} else {
			var_declarations_indent
		},
	])
	if !rt.is_true(var_css_declarations) {
		return ''
	}
	if rt.is_true(var_has_rules_group) {
		var_selector =
			rt.new_string('${var_rule_indent.to_string()}${var_rules_group.to_string()}${var_spacer.to_string()}{${var_suffix.to_string()}${var_nested_rule_indent.to_string()}${var_selector.to_string()}${var_spacer.to_string()}{${var_suffix.to_string()}${var_css_declarations.to_string()}${var_suffix.to_string()}${var_nested_rule_indent.to_string()}}${var_suffix.to_string()}${var_rule_indent.to_string()}}')
		return var_selector.str()
	}
	return '${var_rule_indent.to_string()}${var_selector.to_string()}${var_spacer.to_string()}{${var_suffix.to_string()}${var_css_declarations.to_string()}${var_suffix.to_string()}${var_rule_indent.to_string()}}'
}

struct Class_WP_Style_Engine_CSS_Declarations {
	rt.PhpObjectBase
}

fn create_wp_style_engine_css_rule(selector string, arg_1 rt.PhpVal, rules_group string) &Class_WP_Style_Engine_CSS_Rule {
	mut obj := &Class_WP_Style_Engine_CSS_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
		selector:      rt.new_null()
		declarations:  rt.new_null()
		rules_group:   rt.new_null()
	}
	obj.construct(selector, arg_1, rules_group)
	return obj
}

fn create_wp_style_engine_css_declarations(_args ...rt.PhpVal) &Class_WP_Style_Engine_CSS_Declarations {
	mut obj := &Class_WP_Style_Engine_CSS_Declarations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_selector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_selector(dispatch_arg_0)
		}
		'add_declarations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_declarations(dispatch_arg_0)
		}
		'set_rules_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_rules_group(dispatch_arg_0)
		}
		'get_rules_group' {
			return this.get_rules_group()
		}
		'get_declarations' {
			return this.get_declarations()
		}
		'get_selector' {
			return this.get_selector()
		}
		'get_css' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_css(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Style_Engine_CSS_Rule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'selector' { return this.selector }
		'declarations' { return this.declarations }
		'rules_group' { return this.rules_group }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Style_Engine_CSS_Rule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'selector' {
			this.selector = val
			return true
		}
		'declarations' {
			this.declarations = val
			return true
		}
		'rules_group' {
			this.rules_group = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine_CSS_Declarations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
