import rt

fn wp_style_engine_get_styles(var_block_styles rt.PhpVal, var_options_arg rt.PhpVal) rt.PhpVal {
	mut var_options := var_options_arg
	mut var_parsed_styles := rt.new_null()
	mut var_styles_output := map[string]rt.PhpVal{}
	var_options = rt.call_function('wp_parse_args', [var_options.clone(),
		rt.create_array([rt.ArrayItem{ key: 'selector', val: rt.new_null() },
			rt.ArrayItem{ key: 'context', val: rt.new_null() },
			rt.ArrayItem{ key: 'convert_vars_to_classnames', val: false }])])
	mut iife_temp_0 := Class_WP_Style_Engine{}
	mut iife_result_0 := iife_temp_0.parse_block_styles(var_block_styles.clone(),
		var_options.clone())
	var_parsed_styles = iife_result_0
	var_styles_output = map[string]rt.PhpVal{}
	if !(!rt.is_true(var_parsed_styles.array_get(rt.new_string('declarations')))) {
		mut iife_temp_1 := Class_WP_Style_Engine{}
		mut iife_result_1 := iife_temp_1.compile_css(var_parsed_styles.array_get(rt.new_string('declarations')),
			var_options.array_get(rt.new_string('selector')))
		var_styles_output['css'] = iife_result_1
		var_styles_output['declarations'] =
			var_parsed_styles.array_get(rt.new_string('declarations'))
		if !(!rt.is_true(var_options.array_get(rt.new_string('context')))) {
			mut iife_temp_2 := Class_WP_Style_Engine{}
			mut iife_result_2 := iife_temp_2.store_css_rule(var_options.array_get(rt.new_string('context')),
				var_options.array_get(rt.new_string('selector')),
				var_parsed_styles.array_get(rt.new_string('declarations')))
		}
	}
	if !(!rt.is_true(var_parsed_styles.array_get(rt.new_string('classnames')))) {
		var_styles_output['classnames'] = rt.call_function('implode', [
			rt.new_string(' '),
			rt.call_function('array_unique',
				[var_parsed_styles.array_get(rt.new_string('classnames'))]),
		])
	}
	return rt.call_function('array_filter', [
		rt.create_array_from_native_map(var_styles_output),
	])
}

fn wp_style_engine_get_stylesheet_from_css_rules(var_css_rules rt.PhpVal, var_options_arg rt.PhpVal) string {
	mut var_options := var_options_arg
	mut var_css_rule_objects := []rt.PhpVal{}
	mut var_css_rule := map[string]rt.PhpVal{}
	mut var_rules_group := rt.new_null()
	if !rt.is_true(var_css_rules) {
		return ''
	}
	var_options = rt.call_function('wp_parse_args', [var_options.clone(),
		rt.create_array([rt.ArrayItem{ key: 'context', val: rt.new_null() }])])
	var_css_rule_objects = map[string]rt.PhpVal{}
	mut iter_1 := var_css_rules.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_css_rule_shadow := item_1.val
		if !rt.is_true(var_css_rule_shadow['selector'])
			|| !rt.is_true(var_css_rule_shadow['declarations'])
			|| !(var_css_rule_shadow['declarations'].is_array()) {
			continue
		}
		var_rules_group = if !(var_css_rule_shadow['rules_group']).is_null() {
			var_css_rule_shadow['rules_group']
		} else {
			rt.new_null()
		}
		if !(!rt.is_true(var_options.array_get(rt.new_string('context')))) {
			mut iife_temp_3 := Class_WP_Style_Engine{}
			mut iife_result_3 := iife_temp_3.store_css_rule(var_options.array_get(rt.new_string('context')),
				var_css_rule_shadow['selector'], var_css_rule_shadow['declarations'],
				var_rules_group.clone())
		}
		var_css_rule_objects << create_wp_style_engine_css_rule(var_css_rule_shadow['selector'],
			var_css_rule_shadow['declarations'], var_rules_group.clone())
	}
	if !rt.is_true(var_css_rule_objects) {
		return ''
	}
	mut iife_temp_4 := Class_WP_Style_Engine{}
	mut iife_result_4 := iife_temp_4.compile_stylesheet_from_css_rules(var_css_rule_objects.clone(),
		var_options.clone())
	return iife_result_4.str()
}

fn wp_style_engine_get_stylesheet_from_context(var_context rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut iife_temp_5 := Class_WP_Style_Engine{}
	mut iife_result_5 := iife_temp_5.get_store(var_context.clone())
	mut iife_temp_6 := Class_WP_Style_Engine{}
	mut iife_result_6 := iife_temp_6.compile_stylesheet_from_css_rules(rt.call_method(iife_result_5,
		'get_all_rules', []rt.PhpVal{}), var_options.clone())
	return iife_result_6
}

struct Class_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_WP_Style_Engine_CSS_Rule {
	rt.PhpObjectBase
}

fn create_wp_style_engine(_args ...rt.PhpVal) &Class_WP_Style_Engine {
	mut obj := &Class_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine_css_rule(_args ...rt.PhpVal) &Class_WP_Style_Engine_CSS_Rule {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
