import rt

struct Class_WP_Nav_Menu_Widget {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Nav_Menu_Widget) construct() {
	mut var_widget_ops := {
		'description':                 rt.call_function('__', [
			rt.new_string('Add a navigation menu to your sidebar.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	this.Class_WP_Widget.construct(rt.new_string('nav_menu'), rt.call_function('__', [
		rt.new_string('Navigation Menu'),
	]), var_widget_ops.clone())
}

fn (mut this Class_WP_Nav_Menu_Widget) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_nav_menu := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('nav_menu')))) { rt.call_function('wp_get_nav_menu_object', [
			var_instance_mutated.array_get(rt.new_string('nav_menu')),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_nav_menu)))) {
		return
	}
	mut var_default_title := rt.call_function('__', [rt.new_string('Menu')])
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('title')))) {
		var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		rt.new_string('')
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_title.clone(), var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WP_Nav_Menu_Widget', [
			'WP_Widget',
		], &this), 'id_base')])
	rt.echo_val(var_args.array_get(rt.new_string('before_widget')))
	if rt.is_true(var_title) {
		print((var_args.array_get(rt.new_string('before_title'))).str() + var_title.str() +
			(var_args.array_get(rt.new_string('after_title'))).str())
	}
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
		mut var_nav_menu_args := {
			'fallback_cb':          rt.new_string('')
			'menu':                 var_nav_menu
			'container':            rt.new_string('nav')
			'container_aria_label': var_aria_label
			'items_wrap':           rt.new_string('<ul id="%1$s" class="%2$s">%3$s</ul>')
		}
	} else {
		var_nav_menu_args = {
			'fallback_cb': rt.new_string('')
			'menu':        var_nav_menu
		}
	}
	rt.call_function('wp_nav_menu', [
		rt.call_function('apply_filters', [rt.new_string('widget_nav_menu_args'),
			rt.create_array_from_native_map(var_nav_menu_args),
			var_nav_menu.clone(), var_args.clone(), var_instance_mutated.clone()]),
	])
	rt.echo_val(var_args.array_get(rt.new_string('after_widget')))
}

fn (mut this Class_WP_Nav_Menu_Widget) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_new_instance.array_get(rt.new_string('title')))) {
		var_instance['title'] = rt.call_function('sanitize_text_field', [
			var_new_instance.array_get(rt.new_string('title')),
		])
	}
	if !(!rt.is_true(var_new_instance.array_get(rt.new_string('nav_menu')))) {
		var_instance['nav_menu'] =
			rt.new_int((var_new_instance.array_get(rt.new_string('nav_menu'))).to_i64())
	}
	return var_instance.clone()
}

fn (mut this Class_WP_Nav_Menu_Widget) form(var_instance rt.PhpVal) {
	mut var_wp_customize := rt.new_null()
	mut var_instance_mutated := var_instance
	mut var_title := if !(var_instance_mutated.array_get(rt.new_string('title'))).is_null() {
		var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		rt.new_string('')
	}
	mut var_nav_menu := if !(var_instance_mutated.array_get(rt.new_string('nav_menu'))).is_null() {
		var_instance_mutated.array_get(rt.new_string('nav_menu'))
	} else {
		rt.new_string('')
	}
	mut var_menus := rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
	mut var_empty_menus_style := rt.new_string('')
	mut var_not_empty_menus_style := rt.new_string('')
	if !rt.is_true(var_menus) {
		var_empty_menus_style = rt.new_string(' style="display:none" ')
	} else {
		var_not_empty_menus_style = rt.new_string(' style="display:none" ')
	}
	mut var_nav_menu_style := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_nav_menu)))) {
		var_nav_menu_style = rt.new_string('display: none;')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_not_empty_menus_style)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_customize, 'WP_Customize_Manager'))) {
		mut var_url := rt.new_string('javascript: wp.customize.panel( "nav_menus" ).focus();')
	} else {
		var_url = rt.call_function('admin_url', [rt.new_string('nav-menus.php')])
	}
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('No menus have been created yet. <a href="%s">Create some</a>.'),
		]),
		rt.call_function('esc_attr', [
			var_url.clone(),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_empty_menus_style)
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
	rt.echo_val(this.get_field_id(rt.new_string('nav_menu')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select Menu:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('nav_menu')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('nav_menu')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_menus.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_menu := item_1.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_menu, 'term_id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_nav_menu.clone(), rt.get_property(var_menu, 'term_id')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_menu, 'name')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_customize, 'WP_Customize_Manager'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_nav_menu_style)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit Menu')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_nav_menu_widget() &Class_WP_Nav_Menu_Widget {
	mut obj := &Class_WP_Nav_Menu_Widget{
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

fn (mut this Class_WP_Nav_Menu_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Nav_Menu_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Nav_Menu_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
