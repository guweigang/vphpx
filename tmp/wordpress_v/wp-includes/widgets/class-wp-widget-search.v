import rt

struct Class_WP_Widget_Search {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Search) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_search')
		'description':                 rt.call_function('__', [
			rt.new_string('A search form for your site.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	this.Class_WP_Widget.construct(rt.new_string('search'), rt.call_function('_x', [
		rt.new_string('Search'),
		rt.new_string('Search widget'),
	]), var_widget_ops.dup())
}

fn (mut this Class_WP_Widget_Search) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get('title'))) {
		var_instance_mutated.array_get('title')
	} else {
		rt.new_string('')
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_title.dup(), var_instance_mutated.dup(),
		rt.get_property(rt.new_object('WP_Widget_Search', [
			'WP_Widget',
		], &this), 'id_base')])
	rt.echo_val(var_args.array_get('before_widget'))
	if rt.is_true(var_title) {
		print((var_args.array_get('before_title')).str() + var_title.str() +
			(var_args.array_get('after_title')).str())
	}
	rt.call_function('get_search_form', []rt.PhpVal{})
	rt.echo_val(var_args.array_get('after_widget'))
}

fn (mut this Class_WP_Widget_Search) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_instance_mutated),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' }]),
	])
	mut var_title := var_instance_mutated.array_get('title')
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
}

fn (mut this Class_WP_Widget_Search) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_new_instance_mutated := var_new_instance
	mut var_instance := var_old_instance
	var_new_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_new_instance_mutated),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' }]),
	])
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [
		var_new_instance_mutated.array_get('title'),
	]))
	return var_instance.dup()
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_search() &Class_WP_Widget_Search {
	mut obj := &Class_WP_Widget_Search{
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

fn (mut this Class_WP_Widget_Search) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Search) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Search) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_widgets_class_wp_widget_search_php() {
}
