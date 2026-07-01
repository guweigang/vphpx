import rt

struct Class_WP_Customize_Theme_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('theme')
	theme     rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Customize_Theme_Control) to_json() {
	this.Class_WP_Customize_Control.to_json()
	rt.get_property(rt.new_object('WP_Customize_Theme_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('theme', this.theme)
}

fn (mut this Class_WP_Customize_Theme_Control) render_content() {
}

fn (mut this Class_WP_Customize_Theme_Control) content_template() {
	mut var_details_label := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Details for theme: %s')]),
		rt.new_string('{{ data.theme.name }}'),
	])
	mut var_customize_label := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Customize theme: %s')]),
		rt.new_string('{{ data.theme.name }}'),
	])
	mut var_preview_label := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Live preview theme: %s')]),
		rt.new_string('{{ data.theme.name }}'),
	])
	mut var_install_label := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Install and preview theme: %s')]),
		rt.new_string('{{ data.theme.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_details_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Theme Details')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_x', [rt.new_string('By %s'), rt.new_string('theme author')]),
		rt.new_string('{{ data.theme.author }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('_e', [rt.new_string('New version available.')])
	} else {
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('New version available. %s')]),
			'<button class="button-link update-theme" type="button">' +
				(rt.call_function('__', [rt.new_string('Update now')])).str() + '</button>',
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There is a new version of %s available, but it does not work with your versions of WordPress and PHP.'),
		]),
		rt.new_string('{{{ data.theme.name }}}'),
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')]))))
	{
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str(),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_core'),
	]))
	{
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str(),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_php'),
	]))
	{
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str(),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There is a new version of %s available, but it does not work with your version of WordPress.'),
		]),
		rt.new_string('{{{ data.theme.name }}}'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str(),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There is a new version of %s available, but it does not work with your version of PHP.'),
		]),
		rt.new_string('{{{ data.theme.name }}}'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str(),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This theme does not work with your versions of WordPress and PHP.'),
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')]))))
	{
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%1$s">Please update WordPress</a>, and then <a href="%2$s">learn more about updating PHP</a>.')])).str(),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_core'),
	]))
	{
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str(),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_php'),
	]))
	{
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str(),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This theme does not work with your version of WordPress.'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Please update WordPress</a>.')])).str(),
			rt.call_function('self_admin_url', [
				rt.new_string('update-core.php'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This theme does not work with your version of PHP.'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		rt.call_function('printf', [
			' ' +(rt.call_function('__', [rt.new_string('<a href="%s">Learn more about updating PHP</a>.')])).str(),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_update_php_annotation', [rt.new_string('</p><p><em>'),
			rt.new_string('</em>')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Previewing:'), rt.new_string('theme')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_customize_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Customize')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [
		rt.call_function('_x', [rt.new_string('Installed'), rt.new_string('theme')]),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
			]) }]),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_aria_label := rt.call_function('sprintf', [
		rt.call_function('_x', [rt.new_string('Activate %s'),
			rt.new_string('theme')]),
		rt.new_string('{{ data.name }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_aria_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Activate')])
	// unsupported statement: Stmt_InlineHTML
	mut var_customizer_not_supported_message := rt.call_function('__', [
		rt.new_string("This theme doesn't support Customizer."),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [var_customizer_not_supported_message.dup(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
			]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_preview_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_preview_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Live Preview')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [
		rt.call_function('_x', [rt.new_string('Installed'), rt.new_string('theme')]),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
			]) }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_install_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Install &amp; Preview')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_install_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Install &amp; Preview')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_theme_control() &Class_WP_Customize_Theme_Control {
	mut obj := &Class_WP_Customize_Theme_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('theme')
		theme:         rt.new_null()
	}
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Theme_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'to_json' {
			this.to_json()
			return rt.new_null()
		}
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

fn (this &Class_WP_Customize_Theme_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'theme' { return this.theme }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Theme_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'theme' {
			this.theme = val
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

pub fn init_wp_includes_customize_class_wp_customize_theme_control_php() {
}
