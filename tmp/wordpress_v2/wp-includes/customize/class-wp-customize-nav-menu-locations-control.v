import rt

struct Class_WP_Customize_Nav_Menu_Locations_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('nav_menu_locations')
}

fn (mut this Class_WP_Customize_Nav_Menu_Locations_Control) render_content() {
}

fn (mut this Class_WP_Customize_Nav_Menu_Locations_Control) content_template() {
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('menus')]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('_x', [
			rt.new_string('Where do you want this menu to appear?'),
			rt.new_string('menu locations'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('_x', [
				rt.new_string('(If you plan to use a menu <a href="%1$s" %2$s>widget%3$s</a>, skip this step.)'),
				rt.new_string('menu locations'),
			]),
			rt.call_function('__', [
				rt.new_string('https://wordpress.org/documentation/article/manage-wordpress-widgets/'),
			]),
			rt.new_string(' class="external-link" target="_blank"'),
			rt.call_function('sprintf', [
				rt.new_string('<span class="screen-reader-text"> %s</span>'),
				rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('_x', [
			rt.new_string('Here&#8217;s where this menu appears. If you would like to change that, pick another location.'),
			rt.new_string('menu locations'),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := rt.call_function('get_registered_nav_menus', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_description := item_1.val
			mut var_location := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_location.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('_x', [rt.new_string('(Current: %s)'),
					rt.new_string('menu location')]),
				rt.new_string('<span class="current-menu-location-name-' +
					(rt.call_function('esc_attr', [var_location.clone()])).str() + '"></span>'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_locations_control(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Locations_Control {
	mut obj := &Class_WP_Customize_Nav_Menu_Locations_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('nav_menu_locations')
	}
	return obj
}

fn create_wp_customize_control(_args ...rt.PhpVal) &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Locations_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'content_template' {
			this.content_template()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Nav_Menu_Locations_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Locations_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
