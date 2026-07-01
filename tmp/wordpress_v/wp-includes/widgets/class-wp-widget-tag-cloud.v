import rt

struct Class_WP_Widget_Tag_Cloud {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Tag_Cloud) construct()  {
	mut var_widget_ops := { 'description': rt.call_function('__', [rt.new_string('A cloud of your most used tags.')]), 'customize_selective_refresh': rt.new_bool(true), 'show_instance_in_rest': rt.new_bool(true) }
	this.Class_WP_Widget.construct(rt.new_string('tag_cloud'), rt.call_function('__', [rt.new_string('Tag Cloud')]), var_widget_ops.dup())
}

fn (mut this Class_WP_Widget_Tag_Cloud) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	mut var_current_taxonomy := rt.new_string(this._get_current_taxonomy(var_instance_mutated.dup()))
	if !(!rt.is_true(var_instance_mutated.array_get('title'))) {
		mut var_title := var_instance_mutated.array_get('title')
	} else {
		if rt.is_true(rt.identical(rt.new_string('post_tag'), var_current_taxonomy)) {
			var_title = rt.call_function('__', [rt.new_string('Tags')])
		} else {
			mut var_tax := rt.call_function('get_taxonomy', [var_current_taxonomy.dup()])
			var_title = rt.get_property(rt.get_property(var_tax, 'labels'), 'name')
		}
	}
	mut var_default_title := var_title.dup()
	mut var_show_count := rt.new_bool(rt.new_bool(!(!rt.is_true(var_instance_mutated.array_get('count')))))
	mut var_tag_cloud := rt.call_function('wp_tag_cloud', [rt.call_function('apply_filters', [rt.new_string('widget_tag_cloud_args'), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_current_taxonomy }, rt.ArrayItem{ key: 'echo', val: false }, rt.ArrayItem{ key: 'show_count', val: var_show_count }]), var_instance_mutated.dup()])])
	if !rt.is_true(var_tag_cloud) {
		return rt.new_null()
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'), var_title.dup(), var_instance_mutated.dup(), rt.get_property(rt.new_object('WP_Widget_Tag_Cloud', ['WP_Widget'], &this), 'id_base')])
	rt.echo_val(var_args.array_get('before_widget'))
	if rt.is_true(var_title) {
		print((var_args.array_get('before_title')).str() + (var_title).str() + (var_args.array_get('after_title')).str())
	}
	mut var_format := rt.new_string(if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('html5'), rt.new_string('navigation-widgets')])) { rt.new_string('html5') } else { rt.new_string('xhtml') })
	var_format = rt.call_function('apply_filters', [rt.new_string('navigation_widgets_format'), var_format.dup()])
	if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		var_title = rt.new_string(rt.new_string(rt.call_function('strip_tags', [var_title.dup()]).to_string().trim_space()))
		mut var_aria_label := if rt.is_true(var_title) { var_title } else { var_default_title }
		print('<nav aria-label="' + (rt.call_function('esc_attr', [var_aria_label.dup()])).str() + '">')
	}
	print('<div class="tagcloud">')
	rt.echo_val(var_tag_cloud)
	print('</div>\n')
	if rt.is_true(rt.identical(rt.new_string('html5'), var_format)) {
		print('</nav>')
	}
	rt.echo_val(var_args.array_get('after_widget'))
}

fn (mut this Class_WP_Widget_Tag_Cloud) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := map[string]rt.PhpVal{}
	var_instance['title'] = rt.call_function('sanitize_text_field', [var_new_instance.array_get('title')])
	var_instance['count'] = if !(!rt.is_true(var_new_instance.array_get('count'))) { rt.new_int(1) } else { rt.new_int(0) }
	var_instance['taxonomy'] = rt.call_function('stripslashes', [var_new_instance.array_get('taxonomy')])
	return var_instance.dup()
}

fn (mut this Class_WP_Widget_Tag_Cloud) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get('title'))) { var_instance_mutated.array_get('title') } else { rt.new_string('') }
	mut var_count := if var_instance_mutated.array_isset(rt.new_string('count')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_taxonomies := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_tagcloud', val: true }]), rt.new_string('object')])
	mut var_current_taxonomy := rt.new_string(this._get_current_taxonomy(var_instance_mutated.dup()))
	match var_taxonomies.dup().array_count() {
		0 {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.get_field_id(rt.new_string('taxonomy')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.get_field_name(rt.new_string('taxonomy')))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('The tag cloud will not be displayed since there are no taxonomies that support the tag cloud widget.')])
			// unsupported statement: Stmt_InlineHTML
		}
		1 {
			mut var_keys := rt.func_array_keys(var_taxonomies.dup())
			mut var_taxonomy := rt.call_function('reset', [var_keys.dup()])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.get_field_id(rt.new_string('taxonomy')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.get_field_name(rt.new_string('taxonomy')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_taxonomy.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
		else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.get_field_id(rt.new_string('taxonomy')))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Taxonomy:')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.get_field_id(rt.new_string('taxonomy')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.get_field_name(rt.new_string('taxonomy')))
			// unsupported statement: Stmt_InlineHTML
			{
				mut iter_1 := var_taxonomies.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_tax := item_1.val
					mut var_taxonomy_shadow := item_1.key
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [var_taxonomy_shadow.dup()]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('selected', [var_taxonomy_shadow.dup(), var_current_taxonomy.dup()])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_tax, 'labels'), 'name')]))
					// unsupported statement: Stmt_InlineHTML
				}
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	if var_taxonomies.dup().array_count() > 0 {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('count')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('count')))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_count.dup(), rt.new_bool(true)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('count')))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Show tag counts')])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Widget_Tag_Cloud) _get_current_taxonomy(var_instance rt.PhpVal) string {
	mut var_instance_mutated := var_instance
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_instance_mutated.array_get('taxonomy'))) && rt.is_true(rt.call_function('taxonomy_exists', [var_instance_mutated.array_get('taxonomy')])))) {
		return (var_instance_mutated.array_get('taxonomy')).str()
	}
	return 'post_tag'
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_tag_cloud() &Class_WP_Widget_Tag_Cloud {
	mut obj := &Class_WP_Widget_Tag_Cloud{
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

fn (mut this Class_WP_Widget_Tag_Cloud) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'_get_current_taxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this._get_current_taxonomy(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Widget_Tag_Cloud) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Tag_Cloud) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_widgets_class_wp_widget_tag_cloud_php() {
}
