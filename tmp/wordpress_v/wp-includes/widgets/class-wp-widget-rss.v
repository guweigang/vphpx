import rt

struct Class_WP_Widget_RSS {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_RSS) construct()  {
	mut var_widget_ops := { 'description': rt.call_function('__', [rt.new_string('Entries from any RSS or Atom feed.')]), 'customize_selective_refresh': rt.new_bool(true), 'show_instance_in_rest': rt.new_bool(true) }
	mut var_control_ops := { 'width': 400, 'height': 200 }
	this.Class_WP_Widget.construct(rt.new_string('rss'), rt.call_function('__', [rt.new_string('RSS')]), var_widget_ops.dup(), var_control_ops.dup())
}

fn (mut this Class_WP_Widget_RSS) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	if rt.is_true(rt.new_bool(var_instance_mutated.array_isset(rt.new_string('error')) && rt.is_true(var_instance_mutated.array_get('error')))) {
		return rt.new_null()
	}
	mut var_url := if !(!rt.is_true(var_instance_mutated.array_get('url'))) { var_instance_mutated.array_get('url') } else { rt.new_string('') }
	for rt.is_true(rt.new_bool(!(!rt.is_true(var_url)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_url = rt.call_function('substr', [var_url.dup(), rt.new_int(1)])
	}
	if !rt.is_true(var_url) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('in_array', [rt.call_function('untrailingslashit', [var_url.dup()]), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('site_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_function('home_url', []rt.PhpVal{}) }]), rt.new_bool(true)])) {
		return rt.new_null()
	}
	mut var_rss := rt.call_function('fetch_feed', [var_url.dup()])
	mut var_title := var_instance_mutated.array_get('title')
	mut var_desc := rt.new_string(rt.new_string(''))
	mut var_link := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_rss.dup()]))))) {
		var_desc = rt.call_function('esc_attr', [rt.call_function('strip_tags', [rt.call_function('html_entity_decode', [rt.call_method(var_rss, 'get_description', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES'), rt.call_function('get_option', [rt.new_string('blog_charset')])])])])
		if !rt.is_true(var_title) {
			var_title = rt.call_function('strip_tags', [rt.call_method(var_rss, 'get_title', []rt.PhpVal{})])
		}
		var_link = rt.call_function('strip_tags', [rt.call_method(var_rss, 'get_permalink', []rt.PhpVal{})])
		for rt.is_true(rt.new_bool(!(!rt.is_true(var_link)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_link = rt.call_function('substr', [var_link.dup(), rt.new_int(1)])
		}
	}
	if !rt.is_true(var_title) {
		var_title = if !(!rt.is_true(var_desc)) { var_desc } else { rt.call_function('__', [rt.new_string('Unknown Feed')]) }
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'), var_title.dup(), var_instance_mutated.dup(), rt.get_property(rt.new_object('WP_Widget_RSS', ['WP_Widget'], &this), 'id_base')])
	if rt.is_true(var_title) {
		mut var_feed_link := rt.new_string(rt.new_string(''))
		mut var_feed_url := rt.call_function('strip_tags', [var_url.dup()])
		mut var_feed_icon := rt.call_function('includes_url', [rt.new_string('images/rss.png')])
		var_feed_link = rt.call_function('sprintf', [rt.new_string('<a class="rsswidget rss-widget-feed" href="%1$s"><img class="rss-widget-icon" style="border:0" width="14" height="14" src="%2$s" alt="%3$s"%4$s /></a> '), rt.call_function('esc_url', [var_feed_url.dup()]), rt.call_function('esc_url', [var_feed_icon.dup()]), rt.call_function('esc_attr__', [rt.new_string('RSS')]), if rt.is_true(rt.call_function('wp_lazy_loading_enabled', [rt.new_string('img'), rt.new_string('rss_widget_feed_icon')])) { rt.new_string(' loading="lazy"') } else { rt.new_string('') }])
		var_feed_link = rt.call_function('apply_filters', [rt.new_string('rss_widget_feed_link'), var_feed_link.dup(), var_instance_mutated.dup()])
		var_title = rt.new_string((var_feed_link).str() + '<a class="rsswidget rss-widget-title" href="' + (rt.call_function('esc_url', [var_link.dup()])).str() + '">' + (rt.call_function('esc_html', [var_title.dup()])).str() + '</a>')
	}
	rt.echo_val(var_args.array_get('before_widget'))
	if rt.is_true(var_title) {
		print((var_args.array_get('before_title')).str() + (var_title).str() + (var_args.array_get('after_title')).str())
	}
	mut var_format := rt.new_string(if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('html5'), rt.new_string('navigation-widgets')])) { rt.new_string('html5') } else { rt.new_string('xhtml') })
	var_format = rt.call_function('apply_filters', [rt.new_string('navigation_widgets_format'), var_format.dup()])
	if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		var_title = rt.new_string(rt.new_string(rt.call_function('strip_tags', [var_title.dup()]).to_string().trim_space()))
		mut var_aria_label := if rt.is_true(var_title) { var_title } else { rt.call_function('__', [rt.new_string('RSS Feed')]) }
		print('<nav aria-label="' + (rt.call_function('esc_attr', [var_aria_label.dup()])).str() + '">')
	}
	rt.call_function('wp_widget_rss_output', [var_rss.dup(), var_instance_mutated.dup()])
	if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		print('</nav>')
	}
	rt.echo_val(var_args.array_get('after_widget'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_rss.dup()]))))) {
		rt.call_method(var_rss, '__destruct', []rt.PhpVal{})
	}
	var_rss = rt.new_null()
}

fn (mut this Class_WP_Widget_RSS) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_testurl := rt.new_bool(rt.new_bool(var_new_instance.array_isset(rt.new_string('url')) && rt.is_true(rt.new_bool(!(var_old_instance.array_isset(rt.new_string('url'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))))
	return rt.call_function('wp_widget_rss_process', [var_new_instance.dup(), var_testurl.dup()])
}

fn (mut this Class_WP_Widget_RSS) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	if !rt.is_true(var_instance_mutated) {
		var_instance_mutated = rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'url', val: '' }, rt.ArrayItem{ key: 'items', val: 10 }, rt.ArrayItem{ key: 'error', val: false }, rt.ArrayItem{ key: 'show_summary', val: 0 }, rt.ArrayItem{ key: 'show_author', val: 0 }, rt.ArrayItem{ key: 'show_date', val: 0 }])
	}
	var_instance_mutated.array_set('number', rt.get_property(rt.new_object('WP_Widget_RSS', ['WP_Widget'], &this), 'number'))
	rt.call_function('wp_widget_rss_form', [var_instance_mutated.dup()])
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_rss() &Class_WP_Widget_RSS {
	mut obj := &Class_WP_Widget_RSS{
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

fn (mut this Class_WP_Widget_RSS) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Widget_RSS) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_RSS) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_widgets_class_wp_widget_rss_php() {
}
