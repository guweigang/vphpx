import rt

struct Class_Theme_Installer_Skin {
	rt.PhpObjectBase
pub mut:
		api rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		url rt.PhpVal = rt.new_null()
		overwrite rt.PhpVal = rt.new_null()
		is_downgrading rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Theme_Installer_Skin) construct(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	mut var_defaults := { 'type': 'web', 'url': '', 'theme': '', 'nonce': '', 'title': '', 'overwrite': '' }
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_defaults.dup()])
	this.prop_type = var_args_mutated.array_get('type')
	this.url = var_args_mutated.array_get('url')
	this.api = if !(var_args_mutated.array_get('api')).is_null() { var_args_mutated.array_get('api') } else { rt.new_array() }
	this.overwrite = var_args_mutated.array_get('overwrite')
	this.Class_WP_Upgrader_Skin.construct(var_args_mutated.dup())
}

fn (mut this Class_Theme_Installer_Skin) before()  {
	if !(!rt.is_true(this.api)) {
		rt.get_property(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'strings').array_set('process_success', rt.call_function('sprintf', [rt.get_property(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'strings').array_get('process_success_specific'), rt.get_property(this.api, 'name'), rt.get_property(this.api, 'version')]))
	}
}

fn (mut this Class_Theme_Installer_Skin) hide_process_failed(var_wp_error rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('upload'), this.prop_type)) && rt.is_true(rt.identical(rt.new_string(''), this.overwrite)))) && rt.is_true(rt.identical(rt.call_method(var_wp_error, 'get_error_code', []rt.PhpVal{}), rt.new_string('folder_exists'))))) {
		return true
	}
	return false
}

fn (mut this Class_Theme_Installer_Skin) after()  {
	if this.do_overwrite() {
		return rt.new_null()
	}
	if !rt.is_true(rt.get_property(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'result').array_get('destination_name')) {
		return rt.new_null()
	}
	mut var_theme_info := rt.call_method(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'theme_info', []rt.PhpVal{})
	if !rt.is_true(var_theme_info) {
		return rt.new_null()
	}
	mut var_name := rt.call_method(var_theme_info, 'display', [rt.new_string('Name')])
	mut var_stylesheet := rt.get_property(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'result').array_get('destination_name')
	mut var_template := rt.call_method(var_theme_info, 'get_template', []rt.PhpVal{})
	mut var_activate_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'activate' }, rt.ArrayItem{ key: 'template', val: rt.call_function('urlencode', [var_template.dup()]) }, rt.ArrayItem{ key: 'stylesheet', val: rt.call_function('urlencode', [var_stylesheet.dup()]) }]), rt.call_function('admin_url', [rt.new_string('themes.php')])])
	var_activate_link = rt.call_function('wp_nonce_url', [var_activate_link.dup(), 'switch-theme_' + (var_stylesheet).str()])
	mut var_install_actions := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) && rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_theme_info, 'is_block_theme', []rt.PhpVal{})) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])))))) {
		if rt.is_true(rt.call_method(var_theme_info, 'is_block_theme', []rt.PhpVal{})) {
			mut var_customize_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'wp_theme_preview', val: rt.call_function('urlencode', [var_stylesheet.dup()]) }, rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [rt.call_function('admin_url', [if rt.is_true(rt.identical(rt.new_string('web'), this.prop_type)) { rt.new_string('theme-install.php') } else { rt.new_string('themes.php') }])]) }]), rt.call_function('admin_url', [rt.new_string('site-editor.php')])])
		} else {
			var_customize_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'theme', val: rt.call_function('urlencode', [var_stylesheet.dup()]) }, rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [rt.call_function('admin_url', [if rt.is_true(rt.identical(rt.new_string('web'), this.prop_type)) { rt.new_string('theme-install.php') } else { rt.new_string('themes.php') }])]) }]), rt.call_function('admin_url', [rt.new_string('customize.php')])])
		}
		var_install_actions.array_set('preview', rt.call_function('sprintf', ['<a href="%s" class="hide-if-no-customize load-customize">' + '<span aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>', rt.call_function('esc_url', [var_customize_url.dup()]), rt.call_function('__', [rt.new_string('Live Preview')]), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Live Preview &#8220;%s&#8221;')]), var_name.dup()])]))
	}
	var_install_actions.array_set('activate', rt.call_function('sprintf', ['<a href="%s" class="activatelink">' + '<span aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>', rt.call_function('esc_url', [var_activate_link.dup()]), rt.call_function('_x', [rt.new_string('Activate'), rt.new_string('theme')]), rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('Activate &#8220;%s&#8221;'), rt.new_string('theme')]), var_name.dup()])]))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])))) {
		var_install_actions.array_set('network_enable', rt.call_function('sprintf', [rt.new_string('<a href="%s" target="_parent">%s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', ['themes.php?action=enable&amp;theme=' + (rt.call_function('urlencode', [var_stylesheet.dup()])).str(), 'enable-theme_' + (var_stylesheet).str()])]), rt.call_function('__', [rt.new_string('Network Enable')])]))
	}
	if rt.is_true(rt.identical(rt.new_string('web'), this.prop_type)) {
		var_install_actions.array_set('themes_page', rt.call_function('sprintf', [rt.new_string('<a href="%s" target="_parent">%s</a>'), rt.call_function('self_admin_url', [rt.new_string('theme-install.php')]), rt.call_function('__', [rt.new_string('Go to Theme Installer')])]))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])))) {
		var_install_actions.array_set('themes_page', rt.call_function('sprintf', [rt.new_string('<a href="%s" target="_parent">%s</a>'), rt.call_function('self_admin_url', [rt.new_string('themes.php')]), rt.call_function('__', [rt.new_string('Go to Themes page')])]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result'))))) || rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result')])))) || rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))))))) {
		var_install_actions.array_unset(rt.new_string('activate'))
		var_install_actions.array_unset(rt.new_string('preview'))
	} else if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('template')]), var_stylesheet)) {
		var_install_actions.array_unset(rt.new_string('activate'))
	}
	var_install_actions = rt.call_function('apply_filters', [rt.new_string('install_theme_complete_actions'), var_install_actions.dup(), this.api, var_stylesheet.dup(), var_theme_info.dup()])
	if !(!rt.is_true(var_install_actions)) {
		this.feedback(rt.call_function('implode', [rt.new_string(' | '), rt.cast_array(var_install_actions)]))
	}
}

fn (mut this Class_Theme_Installer_Skin) do_overwrite() bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result')]))))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	mut var_folder := rt.call_method(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result'), 'get_error_data', [rt.new_string('folder_exists')])
	var_folder = rt.new_string(rt.new_string(var_folder.dup().to_string().trim_right(' \t\n\r')))
	mut var_current_theme_data := rt.new_bool(rt.new_bool(false))
	mut var_all_themes := rt.call_function('wp_get_themes', [rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.new_null() }])])
	{
		mut iter_1 := var_all_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme := item_1.val
			mut var_stylesheet_dir := rt.call_function('wp_normalize_path', [rt.call_method(var_theme, 'get_stylesheet_directory', []rt.PhpVal{})])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			var_current_theme_data = var_theme
		}
	}
	mut var_new_theme_data := rt.get_property(rt.get_property(rt.new_object('Theme_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'new_theme_data')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_current_theme_data)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_new_theme_data)))))) {
		return false
	}
	print('<h2 class="update-from-upload-heading">' + (rt.call_function('esc_html__', [rt.new_string('This theme is already installed.')])).str() + '</h2>')
	if rt.is_true(rt.call_function('is_wp_error', [rt.call_method(var_current_theme_data, 'errors', []rt.PhpVal{})])) {
		this.feedback(rt.new_string('current_theme_has_errors'), rt.call_method(rt.call_method(var_current_theme_data, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{}))
	}
	this.is_downgrading = rt.call_function('version_compare', [var_current_theme_data.array_get('Version'), var_new_theme_data.array_get('Version'), rt.new_string('>')])
	mut var_is_invalid_parent := rt.new_bool(rt.new_bool(false))
	if !(!rt.is_true(var_new_theme_data.array_get('Template'))) {
		var_is_invalid_parent = rt.new_bool(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_new_theme_data.array_get('Template'), rt.func_array_keys(var_all_themes.dup()), rt.new_bool(true)])))))
	}
	mut var_rows := { 'Name': rt.call_function('__', [rt.new_string('Theme name')]), 'Version': rt.call_function('__', [rt.new_string('Version')]), 'Author': rt.call_function('__', [rt.new_string('Author')]), 'RequiresWP': rt.call_function('__', [rt.new_string('Required WordPress version')]), 'RequiresPHP': rt.call_function('__', [rt.new_string('Required PHP version')]), 'Template': rt.call_function('__', [rt.new_string('Parent theme')]) }
	mut var_table := rt.new_string(rt.new_string('<table class="update-from-upload-comparison"><tbody>'))
	// unsupported expression: Expr_AssignOp_Concat
	mut var_is_same_theme := rt.new_bool(rt.new_bool(true))
	for var_field, var_label in var_rows {
		mut var_old_value := rt.call_method(var_current_theme_data, 'display', [rt.new_string(field), rt.new_bool(false)])
		var_old_value = if rt.is_true(var_old_value) { // unsupported expression: Expr_Cast_String } else { rt.new_string('-') }
		mut var_new_value := if !(!rt.is_true(var_new_theme_data.array_get(field))) { // unsupported expression: Expr_Cast_String } else { rt.new_string('-') }
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_old_value, var_new_value)) && rt.is_true(rt.identical(rt.new_string('-'), var_new_value)))) && rt.is_true(rt.identical(rt.new_string('Template'), rt.new_string(field))))) {
			continue
		}
		var_is_same_theme = rt.new_bool(rt.new_bool(rt.is_true(var_is_same_theme) && rt.is_true(rt.identical(var_old_value, var_new_value))))
		mut var_diff_field := rt.new_bool(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
		mut var_diff_version := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string('Version'), rt.new_string(field))) && rt.is_true(this.is_downgrading)))
		mut var_invalid_parent := rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('Template'), rt.new_string(field))) && rt.is_true(var_is_invalid_parent))) {
			var_invalid_parent = rt.new_bool(rt.new_bool(true))
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('install_theme_overwrite_comparison'), var_table.dup(), var_current_theme_data.dup(), var_new_theme_data.dup()]))
	mut var_install_actions := rt.new_array()
	mut var_can_update := rt.new_bool(rt.new_bool(true))
	mut var_blocked_message := rt.new_string('<p>' + (rt.call_function('esc_html__', [rt.new_string('The theme cannot be updated due to the following:')])).str() + '</p>')
	// unsupported expression: Expr_AssignOp_Concat
	mut var_requires_php := if !(var_new_theme_data.array_get('RequiresPHP')).is_null() { var_new_theme_data.array_get('RequiresPHP') } else { rt.new_null() }
	mut var_requires_wp := if !(var_new_theme_data.array_get('RequiresWP')).is_null() { var_new_theme_data.array_get('RequiresWP') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_php_version_compatible', [var_requires_php.dup()]))))) {
		mut var_error := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The PHP version on your server is %1$s, however the uploaded theme requires %2$s.')]), rt.get_constant('PHP_VERSION'), var_requires_php.dup()])
		// unsupported expression: Expr_AssignOp_Concat
		var_can_update = rt.new_bool(rt.new_bool(false))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_version_compatible', [var_requires_wp.dup()]))))) {
		var_error = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your WordPress version is %1$s, however the uploaded theme requires %2$s.')]), rt.call_function('esc_html', [rt.call_function('wp_get_wp_version', []rt.PhpVal{})]), var_requires_wp.dup()])
		// unsupported expression: Expr_AssignOp_Concat
		var_can_update = rt.new_bool(rt.new_bool(false))
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(var_can_update) {
		if rt.is_true(this.is_downgrading) {
			mut var_warning := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You are uploading an older version of the installed theme. You can continue to install the older version, but be sure to <a href="%s">back up your database and files</a> first.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/security/backup/')])])
		} else {
			var_warning = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You are updating a theme. Be sure to <a href="%s">back up your database and files</a> first.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/security/backup/')])])
		}
		print('<p class="update-from-upload-notice">' + (var_warning).str() + '</p>')
		mut var_overwrite := rt.new_string(if rt.is_true(this.is_downgrading) { rt.new_string('downgrade-theme') } else { rt.new_string('update-theme') })
		var_install_actions.array_set('overwrite_theme', rt.call_function('sprintf', [rt.new_string('<a class="button button-primary update-from-upload-overwrite" href="%s" target="_parent">%s</a>'), rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('overwrite'), var_overwrite.dup(), this.url]), rt.new_string('theme-upload')]), rt.call_function('_x', [rt.new_string('Replace installed with uploaded'), rt.new_string('theme')])]))
	} else {
		rt.echo_val(var_blocked_message)
	}
	mut var_cancel_url := rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('upload-theme-cancel-overwrite'), this.url])
	var_install_actions.array_set('themes_page', rt.call_function('sprintf', [rt.new_string('<a class="button" href="%s" target="_parent">%s</a>'), rt.call_function('wp_nonce_url', [var_cancel_url.dup(), rt.new_string('theme-upload-cancel-overwrite')]), rt.call_function('__', [rt.new_string('Cancel and go back')])]))
	var_install_actions = rt.call_function('apply_filters', [rt.new_string('install_theme_overwrite_actions'), var_install_actions.dup(), this.api, var_new_theme_data.dup()])
	if !(!rt.is_true(var_install_actions)) {
		rt.call_function('printf', [rt.new_string('<p class="update-from-upload-expired hidden">%s</p>'), rt.call_function('__', [rt.new_string('The uploaded file has expired. Please go back and upload it again.')])])
		print('<p class="update-from-upload-actions">' + (rt.call_function('implode', [rt.new_string(' '), rt.cast_array(var_install_actions)])).str() + '</p>')
	}
	return true
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_theme_installer_skin(arg_0 rt.PhpVal) &Class_Theme_Installer_Skin {
	mut obj := &Class_Theme_Installer_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
		api: rt.new_null()
		prop_type: rt.new_null()
		url: rt.new_null()
		overwrite: rt.new_null()
		is_downgrading: rt.new_bool(false)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin() &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Theme_Installer_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'before' {
			this.before()
			return rt.new_null()
		}
		'hide_process_failed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.hide_process_failed(dispatch_arg_0))
		}
		'after' {
			this.after()
			return rt.new_null()
		}
		'do_overwrite' {
			return rt.new_bool(this.do_overwrite())
		}
		else { return none }
	}
}

fn (this &Class_Theme_Installer_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'api' { return this.api }
		'type' { return this.prop_type }
		'url' { return this.url }
		'overwrite' { return this.overwrite }
		'is_downgrading' { return this.is_downgrading }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Theme_Installer_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'api' { this.api = val; return true }
		'type' { this.prop_type = val; return true }
		'url' { this.url = val; return true }
		'overwrite' { this.overwrite = val; return true }
		'is_downgrading' { this.is_downgrading = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_class_theme_installer_skin_php() {
}
