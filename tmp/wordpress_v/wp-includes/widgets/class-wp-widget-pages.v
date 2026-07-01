import rt

struct Class_WP_Widget_Pages {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Pages) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_pages')
		'description':                 rt.call_function('__', [
			rt.new_string('A list of your site&#8217;s Pages.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	this.Class_WP_Widget.construct(rt.new_string('pages'), rt.call_function('__', [
		rt.new_string('Pages'),
	]), var_widget_ops.dup())
}

fn (mut this Class_WP_Widget_Pages) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_default_title := rt.call_function('__', [rt.new_string('Pages')])
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get('title'))) {
		var_instance_mutated.array_get('title')
	} else {
		var_default_title
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_title.dup(), var_instance_mutated.dup(),
		rt.get_property(rt.new_object('WP_Widget_Pages', [
			'WP_Widget',
		], &this), 'id_base')])
	mut var_sortby := if !rt.is_true(var_instance_mutated.array_get('sortby')) {
		rt.new_string('menu_order')
	} else {
		var_instance_mutated.array_get('sortby')
	}
	mut var_exclude := if !rt.is_true(var_instance_mutated.array_get('exclude')) {
		rt.new_string('')
	} else {
		var_instance_mutated.array_get('exclude')
	}
	if rt.is_true(rt.identical(rt.new_string('menu_order'), var_sortby)) {
		var_sortby = rt.new_string(rt.new_string('menu_order, post_title'))
	}
	mut var_output := rt.call_function('wp_list_pages', [
		rt.call_function('apply_filters', [rt.new_string('widget_pages_args'),
			rt.create_array([rt.ArrayItem{ key: 'title_li', val: '' },
				rt.ArrayItem{ key: 'echo', val: 0 }, rt.ArrayItem{
					key: 'sort_column'
					val: var_sortby
				}, rt.ArrayItem{ key: 'exclude', val: var_exclude }]),
			var_instance_mutated.dup()]),
	])
	if !(!rt.is_true(var_output)) {
		rt.echo_val(var_args.array_get('before_widget'))
		if rt.is_true(var_title) {
			print((var_args.array_get('before_title')).str() + var_title.str() +
				(var_args.array_get('after_title')).str())
		}
		mut var_format := rt.new_string(if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('html5'),
			rt.new_string('navigation-widgets'),
		]))
		{ rt.new_string('html5') } else { rt.new_string('xhtml') })
		var_format = rt.call_function('apply_filters', [
			rt.new_string('navigation_widgets_format'),
			var_format.dup(),
		])
		if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
			var_title = rt.new_string(rt.new_string(rt.call_function('strip_tags', [
				var_title.dup(),
			]).to_string().trim_space()))
			mut var_aria_label := if rt.is_true(var_title) { var_title } else { var_default_title }
			print('<nav aria-label="' +
				(rt.call_function('esc_attr', [var_aria_label.dup()])).str() + '">')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_output)
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
			print('</nav>')
		}
		rt.echo_val(var_args.array_get('after_widget'))
	}
}

fn (mut this Class_WP_Widget_Pages) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := var_old_instance
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [
		var_new_instance.array_get('title'),
	]))
	if rt.is_true(rt.call_function('in_array', [var_new_instance.array_get('sortby'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'post_title' },
			rt.ArrayItem{ key: none, val: 'menu_order' }, rt.ArrayItem{ key: none, val: 'ID' }]),
		rt.new_bool(true)]))
	{
		var_instance.array_set('sortby', var_new_instance.array_get('sortby'))
	} else {
		var_instance.array_set('sortby', 'menu_order')
	}
	var_instance.array_set('exclude', rt.call_function('sanitize_text_field', [
		var_new_instance.array_get('exclude'),
	]))
	return var_instance.dup()
}

fn (mut this Class_WP_Widget_Pages) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_instance_mutated),
		rt.create_array([rt.ArrayItem{ key: 'sortby', val: 'post_title' },
			rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'exclude', val: '' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_instance_mutated.array_get('title')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('sortby'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Sort by:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('sortby'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('sortby'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('sortby'),
		rt.new_string('post_title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Page title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('sortby'),
		rt.new_string('menu_order')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Page order')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('sortby'),
		rt.new_string('ID')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Page ID')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('exclude'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Exclude:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_instance_mutated.array_get('exclude')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		this.get_field_name(rt.new_string('exclude')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('exclude'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Page IDs, separated by commas.')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_pages() &Class_WP_Widget_Pages {
	mut obj := &Class_WP_Widget_Pages{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_widget() &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Pages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Widget_Pages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Pages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_widgets_class_wp_widget_pages_php() {
}
