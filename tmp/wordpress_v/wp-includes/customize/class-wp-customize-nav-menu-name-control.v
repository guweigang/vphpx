import rt

struct Class_WP_Customize_Nav_Menu_Name_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('nav_menu_name')
}

fn (mut this Class_WP_Customize_Nav_Menu_Name_Control) render_content() {
}

fn (mut this Class_WP_Customize_Nav_Menu_Name_Control) content_template() {
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_name_control() &Class_WP_Customize_Nav_Menu_Name_Control {
	mut obj := &Class_WP_Customize_Nav_Menu_Name_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('nav_menu_name')
	}
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Name_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Customize_Nav_Menu_Name_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Name_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_includes_customize_class_wp_customize_nav_menu_name_control_php() {
}
