import rt

struct Class_WP_Widget_Recent_Posts {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Recent_Posts) construct()  {
	mut var_widget_ops := { 'classname': rt.new_string('widget_recent_entries'), 'description': rt.call_function('__', [rt.new_string('Your site&#8217;s most recent Posts.')]), 'customize_selective_refresh': rt.new_bool(true), 'show_instance_in_rest': rt.new_bool(true) }
	this.Class_WP_Widget.construct(rt.new_string('recent-posts'), rt.call_function('__', [rt.new_string('Recent Posts')]), var_widget_ops.dup())
	this.dispatch_set_prop('alt_option_name', rt.new_string('widget_recent_entries'))
}

fn (mut this Class_WP_Widget_Recent_Posts) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_args_mutated := var_args
	mut var_instance_mutated := var_instance
	if !(var_args_mutated.array_isset(rt.new_string('widget_id'))) {
		var_args_mutated.array_set('widget_id', rt.get_property(rt.new_object('WP_Widget_Recent_Posts', ['WP_Widget'], &this), 'id'))
	}
	mut var_default_title := rt.call_function('__', [rt.new_string('Recent Posts')])
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get('title'))) { var_instance_mutated.array_get('title') } else { var_default_title }
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'), var_title.dup(), var_instance_mutated.dup(), rt.get_property(rt.new_object('WP_Widget_Recent_Posts', ['WP_Widget'], &this), 'id_base')])
	mut var_number := if !(!rt.is_true(var_instance_mutated.array_get('number'))) { rt.call_function('absint', [var_instance_mutated.array_get('number')]) } else { rt.new_int(5) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_number)))) {
		var_number = rt.new_int(rt.new_int(5))
	}
	mut var_show_date := if !(var_instance_mutated.array_get('show_date')).is_null() { var_instance_mutated.array_get('show_date') } else { rt.new_bool(false) }
	mut var_r := create_wp_query(rt.call_function('apply_filters', [rt.new_string('widget_posts_args'), rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: var_number }, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'ignore_sticky_posts', val: true }]), var_instance_mutated.dup()]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_r.have_posts())))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_args_mutated.array_get('before_widget'))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_title) {
		print((var_args_mutated.array_get('before_title')).str() + (var_title).str() + (var_args_mutated.array_get('after_title')).str())
	}
	mut var_format := rt.new_string(if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('html5'), rt.new_string('navigation-widgets')])) { rt.new_string('html5') } else { rt.new_string('xhtml') })
	var_format = rt.call_function('apply_filters', [rt.new_string('navigation_widgets_format'), var_format.dup()])
	if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		var_title = rt.new_string(rt.new_string(rt.call_function('strip_tags', [var_title.dup()]).to_string().trim_space()))
		mut var_aria_label := if rt.is_true(var_title) { var_title } else { var_default_title }
		print('<nav aria-label="' + (rt.call_function('esc_attr', [var_aria_label.dup()])).str() + '">')
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.get_property(var_r, 'posts').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_recent_post := item_1.val
			// unsupported statement: Stmt_InlineHTML
			mut var_post_title := rt.call_function('get_the_title', [rt.get_property(var_recent_post, 'ID')])
			var_title = if !(!rt.is_true(var_post_title)) { var_post_title } else { rt.call_function('__', [rt.new_string('(no title)')]) }
			mut var_aria_current := rt.new_string(rt.new_string(''))
			if rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.get_property(var_recent_post, 'ID'))) {
				var_aria_current = rt.new_string(rt.new_string(' aria-current="page"'))
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_permalink', [rt.get_property(var_recent_post, 'ID')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_aria_current)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_title)
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_show_date) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('get_the_date', [rt.new_string(''), rt.get_property(var_recent_post, 'ID')]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		print('</nav>')
	}
	rt.echo_val(var_args_mutated.array_get('after_widget'))
}

fn (mut this Class_WP_Widget_Recent_Posts) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := var_old_instance
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [var_new_instance.array_get('title')]))
	var_instance.array_set('number', // unsupported expression: Expr_Cast_Int)
	var_instance.array_set('show_date', if var_new_instance.array_isset(rt.new_string('show_date')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) })
	return var_instance.dup()
}

fn (mut this Class_WP_Widget_Recent_Posts) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	mut var_title := if var_instance_mutated.array_isset(rt.new_string('title')) { rt.call_function('esc_attr', [var_instance_mutated.array_get('title')]) } else { rt.new_string('') }
	mut var_number := if var_instance_mutated.array_isset(rt.new_string('number')) { rt.call_function('absint', [var_instance_mutated.array_get('number')]) } else { rt.new_int(5) }
	mut var_show_date := if var_instance_mutated.array_isset(rt.new_string('show_date')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('number')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Number of posts to show:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('number')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('number')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_number)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_show_date.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('show_date')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('show_date')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('show_date')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Display post date?')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_widget_recent_posts() &Class_WP_Widget_Recent_Posts {
	mut obj := &Class_WP_Widget_Recent_Posts{
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Recent_Posts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else { return none }
	}
}

fn (this &Class_WP_Widget_Recent_Posts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Recent_Posts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_widgets_class_wp_widget_recent_posts_php() {
}
