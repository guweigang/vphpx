import rt

struct Class_WP_Customize_Themes_Panel {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('themes')
}

fn (mut this Class_WP_Customize_Themes_Panel) render_template() {
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_Customize_Themes_Panel', [
		'WP_Customize_Panel',
	], &this), 'manager'), 'is_theme_active', []rt.PhpVal{}))
	{
		print('<span class="customize-action">' +
			(rt.call_function('__', [rt.new_string('Active theme')])).str() +
			'</span> {{ data.title }}')
	} else {
		print('<span class="customize-action">' +
			(rt.call_function('__', [rt.new_string('Previewing theme')])).str() +
			'</span> {{ data.title }}')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Change theme')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Change'), rt.new_string('theme')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Themes_Panel) content_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Back')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('You are browsing %s')]),
		rt.new_string('<strong class="panel-title">' +
			(rt.call_function('__', [rt.new_string('Themes')])).str() + '</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Help')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Panel {
	rt.PhpObjectBase
}

fn create_wp_customize_themes_panel(_args ...rt.PhpVal) &Class_WP_Customize_Themes_Panel {
	mut obj := &Class_WP_Customize_Themes_Panel{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('themes')
	}
	return obj
}

fn create_wp_customize_panel(_args ...rt.PhpVal) &Class_WP_Customize_Panel {
	mut obj := &Class_WP_Customize_Panel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Themes_Panel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_template' {
			this.render_template()
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

fn (this &Class_WP_Customize_Themes_Panel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Themes_Panel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
