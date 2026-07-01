import rt

fn wp_style_engine_get_styles(var_block_styles rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	var_options = rt.call_function('wp_parse_args', [var_options.dup(),
		rt.create_array([rt.ArrayItem{ key: 'selector', val: rt.new_null() },
			rt.ArrayItem{ key: 'context', val: rt.new_null() },
			rt.ArrayItem{ key: 'convert_vars_to_classnames', val: false }])])
	mut var_parsed_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Style_Engine{}
		return temp.parse_block_styles(arg_0, arg_1)
	}(var_block_styles.dup(), var_options.dup())
	mut var_styles_output := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_parsed_styles.array_get('declarations'))) {
		var_styles_output['css'] = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WP_Style_Engine{}
			return temp.compile_css(arg_0, arg_1)
		}(var_parsed_styles.array_get('declarations'), var_options.array_get('selector'))
		var_styles_output['declarations'] = var_parsed_styles.array_get('declarations')
		if !(!rt.is_true(var_options.array_get('context'))) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
				mut temp := Class_WP_Style_Engine{}
				return temp.store_css_rule(arg_0, arg_1, arg_2)
			}(var_options.array_get('context'), var_options.array_get('selector'),
				var_parsed_styles.array_get('declarations'))
		}
	}
	if !(!rt.is_true(var_parsed_styles.array_get('classnames'))) {
		var_styles_output['classnames'] = rt.call_function('implode', [
			rt.new_string(' '),
			rt.call_function('array_unique', [var_parsed_styles.array_get('classnames')]),
		])
	}
	return rt.call_function('array_filter', [var_styles_output.dup()])
}

fn wp_style_engine_get_stylesheet_from_css_rules(var_css_rules rt.PhpVal, var_options rt.PhpVal) string {
	if !rt.is_true(var_css_rules) {
		return ''
	}
	var_options = rt.call_function('wp_parse_args', [var_options.dup(),
		rt.create_array([rt.ArrayItem{ key: 'context', val: rt.new_null() }])])
	mut var_css_rule_objects := map[string]rt.PhpVal{}
	{
		mut iter_1 := var_css_rules.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_css_rule := item_1.val
			if rt.is_true(rt.new_bool(!rt.is_true(var_css_rule.array_get('selector'))
				|| !rt.is_true(var_css_rule.array_get('declarations'))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_css_rule.array_get('declarations').is_array())))))))
			{
				continue
			}
			mut var_rules_group := if !(var_css_rule.array_get('rules_group')).is_null() {
				var_css_rule.array_get('rules_group')
			} else {
				rt.new_null()
			}
			if !(!rt.is_true(var_options.array_get('context'))) {
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
					mut temp := Class_WP_Style_Engine{}
					return temp.store_css_rule(arg_0, arg_1, arg_2, arg_3)
				}(var_options.array_get('context'), var_css_rule.array_get('selector'),
					var_css_rule.array_get('declarations'), var_rules_group.dup())
			}
			var_css_rule_objects << create_wp_style_engine_css_rule(var_css_rule.array_get('selector'),
				var_css_rule.array_get('declarations'), var_rules_group.dup())
		}
	}
	if !rt.is_true(var_css_rule_objects) {
		return ''
	}
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Style_Engine{}
		return temp.compile_stylesheet_from_css_rules(arg_0, arg_1)
	}(var_css_rule_objects.dup(), var_options.dup())).str()
}

fn wp_style_engine_get_stylesheet_from_context(var_context rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Style_Engine{}
		return temp.compile_stylesheet_from_css_rules(arg_0, arg_1)
	}(rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Style_Engine{}
		return temp.get_store(arg_0)
	}(var_context.dup()), 'get_all_rules', []rt.PhpVal{}), var_options.dup())
}

struct Class_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_WP_Style_Engine_CSS_Rule {
	rt.PhpObjectBase
}

fn create_wp_style_engine() &Class_WP_Style_Engine {
	mut obj := &Class_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine_css_rule() &Class_WP_Style_Engine_CSS_Rule {
	mut obj := &Class_WP_Style_Engine_CSS_Rule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_includes_style_engine_php() {
}
