import rt

struct Class_WP_Widget_Calendar {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Widget_Calendar) construct()  {
	mut var_widget_ops := { 'classname': rt.new_string('widget_calendar'), 'description': rt.call_function('__', [rt.new_string('A calendar of your site’s posts.')]), 'customize_selective_refresh': rt.new_bool(true), 'show_instance_in_rest': rt.new_bool(true) }
	this.Class_WP_Widget.construct(rt.new_string('calendar'), rt.call_function('__', [rt.new_string('Calendar')]), var_widget_ops.dup())
}

fn (mut this Class_WP_Widget_Calendar) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get('title'))) { var_instance_mutated.array_get('title') } else { rt.new_string('') }
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'), var_title.dup(), var_instance_mutated.dup(), rt.get_property(rt.new_object('WP_Widget_Calendar', ['WP_Widget'], &this), 'id_base')])
	rt.echo_val(var_args.array_get('before_widget'))
	if rt.is_true(var_title) {
		print((var_args.array_get('before_title')).str() + (var_title).str() + (var_args.array_get('after_title')).str())
	}
	if rt.is_true(rt.identical(rt.new_int(0), // unsupported expression: Expr_StaticPropertyFetch)) {
		print('<div id="calendar_wrap" class="calendar_wrap">')
	} else {
		print('<div class="calendar_wrap">')
	}
	rt.call_function('get_calendar', []rt.PhpVal{})
	print('</div>')
	rt.echo_val(var_args.array_get('after_widget'))
	rt.pre_inc(// unsupported expression: Expr_StaticPropertyFetch)
}

fn (mut this Class_WP_Widget_Calendar) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := var_old_instance
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [var_new_instance.array_get('title')]))
	return var_instance.dup()
}

fn (mut this Class_WP_Widget_Calendar) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [rt.cast_array(var_instance_mutated), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_instance_mutated.array_get('title')]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_calendar() &Class_WP_Widget_Calendar {
	mut obj := &Class_WP_Widget_Calendar{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_int(0)
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

fn (mut this Class_WP_Widget_Calendar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Widget_Calendar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Calendar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_includes_widgets_class_wp_widget_calendar_php() {
}
