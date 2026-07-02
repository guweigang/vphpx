import rt

struct Class_WP_Widget_Categories {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Categories) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_categories')
		'description':                 rt.call_function('__', [
			rt.new_string('A list or dropdown of categories.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	this.Class_WP_Widget.construct(rt.new_string('categories'), rt.call_function('__', [
		rt.new_string('Categories'),
	]), var_widget_ops.clone())
}

fn (mut this Class_WP_Widget_Categories) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_first_dropdown := true
	mut var_default_title := rt.call_function('__', [rt.new_string('Categories')])
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('title')))) {
		var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		var_default_title
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_title.clone(), var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WP_Widget_Categories', [
			'WP_Widget',
		], &this), 'id_base')])
	mut var_count := rt.new_string((if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('count')))) {
		'1'
	} else {
		'0'
	}).str())
	mut var_hierarchical := rt.new_string((if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('hierarchical')))) {
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
	mut var_cat_args := {
		'orderby':      rt.new_string('name')
		'show_count':   var_count
		'hierarchical': var_hierarchical
	}
	if rt.is_true(var_dropdown) {
		rt.call_function('printf', [rt.new_string('<form action="%s" method="get">'),
			rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})])])
		mut var_dropdown_id := rt.new_string((if rt.is_true(var_first_dropdown) { 'cat' } else { rt.concat(rt.concat(rt.get_property(rt.new_object('WP_Widget_Categories', [
				'WP_Widget',
			], &this), 'id_base'), rt.new_string('-dropdown-')), rt.get_property(rt.new_object('WP_Widget_Categories', [
				'WP_Widget',
			], &this), 'number')) }).str())
		var_first_dropdown = rt.new_bool(false)
		print('<label class="screen-reader-text" for="' +
			(rt.call_function('esc_attr', [var_dropdown_id.clone()])).str() + '">' +
			var_title.str() + '</label>')
		var_cat_args['show_option_none'] = rt.call_function('__', [
			rt.new_string('Select Category'),
		])
		var_cat_args['id'] = var_dropdown_id.clone()
		rt.call_function('wp_dropdown_categories', [
			rt.call_function('apply_filters', [
				rt.new_string('widget_categories_dropdown_args'),
				rt.create_array_from_native_map(var_cat_args),
				var_instance_mutated.clone(),
			]),
		])
		print('</form>')
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
		var_cat_args['title_li'] = rt.new_string('')
		rt.call_function('wp_list_categories', [
			rt.call_function('apply_filters', [rt.new_string('widget_categories_args'),
				rt.create_array_from_native_map(var_cat_args),
				var_instance_mutated.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
			print('</nav>')
		}
	}
	rt.echo_val(var_args.array_get(rt.new_string('after_widget')))
}

fn (mut this Class_WP_Widget_Categories) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := var_old_instance
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [
		var_new_instance.array_get(rt.new_string('title')),
	]))
	var_instance.array_set('count', if !(!rt.is_true(var_new_instance.array_get(rt.new_string('count')))) {
		1
	} else {
		0
	})
	var_instance.array_set('hierarchical', if !(!rt.is_true(var_new_instance.array_get(rt.new_string('hierarchical')))) {
		1
	} else {
		0
	})
	var_instance.array_set('dropdown', if !(!rt.is_true(var_new_instance.array_get(rt.new_string('dropdown')))) {
		1
	} else {
		0
	})
	return var_instance.clone()
}

fn (mut this Class_WP_Widget_Categories) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_instance_mutated),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' }]),
	])
	mut var_count := rt.new_bool(if var_instance_mutated.array_isset(rt.new_string('count')) {
		(var_instance_mutated.array_get(rt.new_string('count'))).to_bool()
	} else {
		false
	})
	mut var_hierarchical := rt.new_bool(if var_instance_mutated.array_isset(rt.new_string('hierarchical')) {
		(var_instance_mutated.array_get(rt.new_string('hierarchical'))).to_bool()
	} else {
		false
	})
	mut var_dropdown := rt.new_bool(if var_instance_mutated.array_isset(rt.new_string('dropdown')) {
		(var_instance_mutated.array_get(rt.new_string('dropdown'))).to_bool()
	} else {
		false
	})
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
	rt.echo_val(this.get_field_id(rt.new_string('dropdown')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('dropdown')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_dropdown.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('dropdown')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Display as dropdown')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('count')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('count')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_count.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('count')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show post counts')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('hierarchical')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('hierarchical')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_hierarchical.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('hierarchical')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show hierarchy')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_categories() &Class_WP_Widget_Categories {
	mut obj := &Class_WP_Widget_Categories{
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

fn (mut this Class_WP_Widget_Categories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Widget_Categories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Categories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
