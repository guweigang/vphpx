import rt

struct Class_WP_Widget_Recent_Comments {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Recent_Comments) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_recent_comments')
		'description':                 rt.call_function('__', [
			rt.new_string('Your site&#8217;s most recent comments.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	this.Class_WP_Widget.construct(rt.new_string('recent-comments'), rt.call_function('__', [
		rt.new_string('Recent Comments'),
	]), var_widget_ops.clone())
	this.dispatch_set_prop('alt_option_name', rt.new_string('widget_recent_comments'))
	if rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.get_property(rt.new_object('WP_Widget_Recent_Comments', ['WP_Widget'], &this), 'id_base')]))
		|| rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('wp_head'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Recent_Comments', [
					'WP_Widget',
				], &this) },
				rt.ArrayItem{ key: none, val: 'recent_comments_style' },
			])])
	}
}

fn (mut this Class_WP_Widget_Recent_Comments) recent_comments_style() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('show_recent_comments_widget_style'), rt.new_bool(true), rt.get_property(rt.new_object('WP_Widget_Recent_Comments', ['WP_Widget'], &this), 'id_base')]))))) {
		return
	}
	print('<style>.recentcomments a{display:inline !important;padding:0 !important;margin:0 !important;}</style>')
}

fn (mut this Class_WP_Widget_Recent_Comments) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_instance_mutated := var_instance
	mut var_first_instance := true
	if !(var_args_mutated.array_isset(rt.new_string('widget_id'))) {
		var_args_mutated.array_set('widget_id', rt.get_property(rt.new_object('WP_Widget_Recent_Comments', [
			'WP_Widget',
		], &this), 'id'))
	}
	mut var_output := rt.new_string('')
	mut var_default_title := rt.call_function('__', [rt.new_string('Recent Comments')])
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('title')))) {
		var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		var_default_title
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_title.clone(), var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WP_Widget_Recent_Comments', [
			'WP_Widget',
		], &this), 'id_base')])
	mut var_number := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('number')))) { rt.call_function('absint', [
			var_instance_mutated.array_get(rt.new_string('number')),
		]) } else { rt.new_int(5) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_number)))) {
		var_number = rt.new_int(5)
	}
	mut var_comments := rt.call_function('get_comments', [
		rt.call_function('apply_filters', [rt.new_string('widget_comments_args'),
			rt.create_array([rt.ArrayItem{ key: 'number', val: var_number },
				rt.ArrayItem{ key: 'status', val: 'approve' },
				rt.ArrayItem{ key: 'post_status', val: 'publish' }]),
			var_instance_mutated.clone()]),
	])
	var_output = rt.concat(var_output, var_args_mutated.array_get(rt.new_string('before_widget')))
	if rt.is_true(var_title) {
		var_output = rt.concat(var_output, rt.new_string(
			(var_args_mutated.array_get(rt.new_string('before_title'))).str() + var_title.str() +
			(var_args_mutated.array_get(rt.new_string('after_title'))).str()))
	}
	mut var_recent_comments_id := rt.new_string((if rt.is_true(var_first_instance) { 'recentcomments' } else { rt.concat(rt.new_string('recentcomments-'), rt.get_property(rt.new_object('WP_Widget_Recent_Comments', [
			'WP_Widget',
		], &this), 'number')) }).str())
	var_first_instance = rt.new_bool(false)
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
		var_output = rt.concat(var_output, rt.new_string('<nav aria-label="' +
			(rt.call_function('esc_attr', [var_aria_label.clone()])).str() + '">'))
	}
	var_output = rt.concat(var_output, rt.new_string('<ul id="' +
		(rt.call_function('esc_attr', [var_recent_comments_id.clone()])).str() + '">'))
	if var_comments.clone().is_array() && rt.is_true(var_comments) {
		mut var_post_ids := rt.call_function('array_unique', [
			rt.call_function('wp_list_pluck', [var_comments.clone(),
				rt.new_string('comment_post_ID')]),
		])
		rt.call_function('_prime_post_caches', [var_post_ids.clone(),
			rt.call_function('strpos', [
				rt.call_function('get_option', [rt.new_string('permalink_structure')]),
				rt.new_string('%category%'),
			]),
			rt.new_bool(false)])
		mut iter_1 := rt.cast_array(var_comments).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment := item_1.val
			var_output = rt.concat(var_output, rt.new_string('<li class="recentcomments">'))
			var_output = rt.concat(var_output, rt.call_function('sprintf', [
				rt.call_function('_x', [rt.new_string('%1$s on %2$s'),
					rt.new_string('widgets')]),
				rt.new_string('<span class="comment-author-link">' +
					(rt.call_function('get_comment_author_link', [var_comment.clone()])).str() +
					'</span>'),
				rt.new_string('<a href="' +
					(rt.call_function('esc_url', [rt.call_function('get_comment_link', [var_comment.clone()])])).str() +
					'">' +
					(rt.call_function('get_the_title', [rt.get_property(var_comment, 'comment_post_ID')])).str() +
					'</a>'),
			]))
			var_output = rt.concat(var_output, rt.new_string('</li>'))
		}
	}
	var_output = rt.concat(var_output, rt.new_string('</ul>'))
	if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		var_output = rt.concat(var_output, rt.new_string('</nav>'))
	}
	var_output = rt.concat(var_output, var_args_mutated.array_get(rt.new_string('after_widget')))
	rt.echo_val(var_output)
}

fn (mut this Class_WP_Widget_Recent_Comments) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := var_old_instance
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [
		var_new_instance.array_get(rt.new_string('title')),
	]))
	var_instance.array_set('number', rt.call_function('absint', [
		var_new_instance.array_get(rt.new_string('number')),
	]))
	return var_instance.clone()
}

fn (mut this Class_WP_Widget_Recent_Comments) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_title := if !(var_instance_mutated.array_get(rt.new_string('title'))).is_null() {
		var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		rt.new_string('')
	}
	mut var_number := if var_instance_mutated.array_isset(rt.new_string('number')) { rt.call_function('absint', [
			var_instance_mutated.array_get(rt.new_string('number')),
		]) } else { rt.new_int(5) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('number')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Number of comments to show:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('number')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('number')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_number)
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Widget_Recent_Comments) flush_widget_cache() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.4.0')])
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_recent_comments() &Class_WP_Widget_Recent_Comments {
	mut obj := &Class_WP_Widget_Recent_Comments{
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

fn (mut this Class_WP_Widget_Recent_Comments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'recent_comments_style' {
			this.recent_comments_style()
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
		'flush_widget_cache' {
			this.flush_widget_cache()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Recent_Comments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Recent_Comments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
