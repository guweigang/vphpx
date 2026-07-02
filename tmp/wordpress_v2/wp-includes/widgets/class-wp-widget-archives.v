import rt

struct Class_WP_Widget_Archives {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Archives) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_archive')
		'description':                 rt.call_function('__', [
			rt.new_string('A monthly archive of your site&#8217;s Posts.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	this.Class_WP_Widget.construct(rt.new_string('archives'), rt.call_function('__', [
		rt.new_string('Archives'),
	]), var_widget_ops.clone())
}

fn (mut this Class_WP_Widget_Archives) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_default_title := rt.call_function('__', [rt.new_string('Archives')])
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('title')))) {
		var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		var_default_title
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_title.clone(), var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WP_Widget_Archives', [
			'WP_Widget',
		], &this), 'id_base')])
	mut var_count := rt.new_string((if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('count')))) {
		'1'
	} else {
		'0'
	}).str())
	mut var_dropdown := rt.new_string((if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('dropdown')))) {
		'1'
	} else {
		'0'
	}).str())
	rt.echo_val(var_args.array_get(rt.new_string('before_widget')))
	if rt.is_true(var_title) {
		print((var_args.array_get(rt.new_string('before_title'))).str() + var_title.str() +
			(var_args.array_get(rt.new_string('after_title'))).str())
	}
	if rt.is_true(var_dropdown) {
		mut var_dropdown_id := rt.new_string((rt.concat(rt.concat(rt.get_property(rt.new_object('WP_Widget_Archives', [
			'WP_Widget',
		], &this), 'id_base'), rt.new_string('-dropdown-')), rt.get_property(rt.new_object('WP_Widget_Archives', [
			'WP_Widget',
		], &this), 'number'))).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_dropdown_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_title)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_dropdown_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		mut var_dropdown_args := rt.call_function('apply_filters', [
			rt.new_string('widget_archives_dropdown_args'),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'monthly' },
				rt.ArrayItem{ key: 'format', val: 'option' },
				rt.ArrayItem{ key: 'show_post_count', val: var_count }]),
			var_instance_mutated.clone(),
		])
		mut switch_val_1 := var_dropdown_args.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('yearly'))) {
			mut var_label := rt.call_function('__', [rt.new_string('Select Year')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('monthly'))) {
			var_label = rt.call_function('__', [rt.new_string('Select Month')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('daily'))) {
			var_label = rt.call_function('__', [rt.new_string('Select Day')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('weekly'))) {
			var_label = rt.call_function('__', [rt.new_string('Select Week')])
		} else {
			var_label = rt.call_function('__', [rt.new_string('Select Post')])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_get_archives', [var_dropdown_args.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_json_encode', [var_dropdown_id.clone(),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_print_inline_script_tag', [
			rt.new_string(
				(rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])).str() +
				'\n//# sourceURL=' +
				(rt.call_function('rawurlencode', [rt.new_string(@METHOD)])).str()),
		])
	} else {
		mut var_format := rt.new_string((if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('html5'),
			rt.new_string('navigation-widgets'),
		]))
		{ 'html5' } else { 'xhtml' }).str())
		var_format = rt.call_function('apply_filters', [
			rt.new_string('navigation_widgets_format'),
			var_format.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
			var_title = rt.new_string(rt.call_function('strip_tags', [
				var_title.clone()]).to_string().trim_space())
			mut var_aria_label := if rt.is_true(var_title) { var_title } else { var_default_title }
			print('<nav aria-label="' +
				(rt.call_function('esc_attr', [var_aria_label.clone()])).str() + '">')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_get_archives', [
			rt.call_function('apply_filters', [rt.new_string('widget_archives_args'),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'monthly' },
					rt.ArrayItem{ key: 'show_post_count', val: var_count }]),
				var_instance_mutated.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
			print('</nav>')
		}
	}
	rt.echo_val(var_args.array_get(rt.new_string('after_widget')))
}

fn (mut this Class_WP_Widget_Archives) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_new_instance_mutated := var_new_instance
	mut var_instance := var_old_instance
	var_new_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_new_instance_mutated),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'count', val: 0 }, rt.ArrayItem{ key: 'dropdown', val: '' }]),
	])
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [
		var_new_instance_mutated.array_get(rt.new_string('title')),
	]))
	var_instance.array_set('count', if rt.is_true(var_new_instance_mutated.array_get(rt.new_string('count'))) {
		1
	} else {
		0
	})
	var_instance.array_set('dropdown', if rt.is_true(var_new_instance_mutated.array_get(rt.new_string('dropdown'))) {
		1
	} else {
		0
	})
	return var_instance.clone()
}

fn (mut this Class_WP_Widget_Archives) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_instance_mutated),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'count', val: 0 }, rt.ArrayItem{ key: 'dropdown', val: '' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_instance_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_instance_mutated.array_get(rt.new_string('dropdown'))])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('dropdown')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('dropdown')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('dropdown')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Display as dropdown')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_instance_mutated.array_get(rt.new_string('count'))])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('count')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('count')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('count')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show post counts')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_archives() &Class_WP_Widget_Archives {
	mut obj := &Class_WP_Widget_Archives{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_widget(_args ...rt.PhpVal) &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Archives) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Archives) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Archives) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
