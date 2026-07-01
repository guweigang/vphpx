import rt

struct Class_WP_Customize_Nav_Menus_Panel {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('nav_menus')
}

fn (mut this Class_WP_Customize_Nav_Menus_Panel) render_screen_options() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/nav-menu.php', '4')
	rt.call_function('add_filter', [rt.new_string('manage_nav-menus_columns'),
		rt.new_string('wp_nav_menu_manage_columns')])
	mut var_screen := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Screen{}
		return temp.get(arg_0)
	}(rt.new_string('nav-menus.php'))
	rt.call_method(var_screen, 'render_screen_options', [
		rt.create_array([rt.ArrayItem{ key: 'wrap', val: false }]),
	])
}

fn (mut this Class_WP_Customize_Nav_Menus_Panel) wp_nav_menu_manage_columns() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.5.0'), rt.new_string('wp_nav_menu_manage_columns')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/nav-menu.php', '4')
	return rt.call_function('wp_nav_menu_manage_columns', []rt.PhpVal{})
}

fn (mut this Class_WP_Customize_Nav_Menus_Panel) content_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Back')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('You are customizing %s')]),
		rt.new_string('<strong class="panel-title">{{ data.title }}</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Help')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Menu Options')])
	// unsupported statement: Stmt_InlineHTML
	this.render_screen_options()
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Menus')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Panel {
	rt.PhpObjectBase
}

struct Class_WP_Screen {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menus_panel() &Class_WP_Customize_Nav_Menus_Panel {
	mut obj := &Class_WP_Customize_Nav_Menus_Panel{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('nav_menus')
	}
	return obj
}

fn create_wp_customize_panel() &Class_WP_Customize_Panel {
	mut obj := &Class_WP_Customize_Panel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_screen() &Class_WP_Screen {
	mut obj := &Class_WP_Screen{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menus_Panel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_screen_options' {
			this.render_screen_options()
			return rt.new_null()
		}
		'wp_nav_menu_manage_columns' {
			return this.wp_nav_menu_manage_columns()
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

fn (this &Class_WP_Customize_Nav_Menus_Panel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menus_Panel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Customize_Panel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Panel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Panel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Screen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Screen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Screen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_customize_class_wp_customize_nav_menus_panel_php() {
}
