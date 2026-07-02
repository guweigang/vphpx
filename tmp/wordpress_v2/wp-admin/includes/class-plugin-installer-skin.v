import rt

struct Class_Plugin_Installer_Skin {
	rt.PhpObjectBase
pub mut:
	api            rt.PhpVal = rt.new_null()
	prop_type      rt.PhpVal = rt.new_null()
	url            rt.PhpVal = rt.new_null()
	overwrite      rt.PhpVal = rt.new_null()
	is_downgrading rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Plugin_Installer_Skin) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_defaults := {
		'type':      'web'
		'url':       ''
		'plugin':    ''
		'nonce':     ''
		'title':     ''
		'overwrite': ''
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array_from_native_map(var_defaults)])
	this.prop_type = var_args_mutated.array_get(rt.new_string('type'))
	this.url = var_args_mutated.array_get(rt.new_string('url'))
	this.api = if !(var_args_mutated.array_get(rt.new_string('api'))).is_null() {
		var_args_mutated.array_get(rt.new_string('api'))
	} else {
		rt.new_array()
	}
	this.overwrite = var_args_mutated.array_get(rt.new_string('overwrite'))
	this.Class_WP_Upgrader_Skin.construct(var_args_mutated.clone())
}

fn (mut this Class_Plugin_Installer_Skin) before() {
	if !(!rt.is_true(this.api)) {
		rt.get_property(rt.get_property(rt.new_object('Plugin_Installer_Skin', [
			'WP_Upgrader_Skin',
		], &this), 'upgrader'), 'strings').array_set('process_success', rt.call_function('sprintf', [
			rt.get_property(rt.get_property(rt.new_object('Plugin_Installer_Skin', [
				'WP_Upgrader_Skin',
			], &this), 'upgrader'), 'strings').array_get(rt.new_string('process_success_specific')),
			rt.get_property(this.api, 'name'),
			rt.get_property(this.api, 'version'),
		]))
	}
}

fn (mut this Class_Plugin_Installer_Skin) hide_process_failed(var_wp_error rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('upload'), this.prop_type))
		&& rt.is_true(rt.identical(rt.new_string(''), this.overwrite))
		&& rt.is_true(rt.identical(rt.call_method(var_wp_error, 'get_error_code', []rt.PhpVal{}), rt.new_string('folder_exists'))) {
		return true
	}
	return false
}

fn (mut this Class_Plugin_Installer_Skin) after() {
	if this.do_overwrite() {
		return
	}
	mut var_plugin_file := rt.call_method(rt.get_property(rt.new_object('Plugin_Installer_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'plugin_info', []rt.PhpVal{})
	mut var_install_actions := rt.new_array()
	mut var_from := if rt.get_superglobal('_GET').array_isset(rt.new_string('from')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('from')),
		]) } else { rt.new_string('plugins') }
	if rt.is_true(rt.identical(rt.new_string('import'), var_from)) {
		var_install_actions.array_set('activate_plugin', rt.call_function('sprintf', [
			rt.new_string('<a class="button button-primary" href="%s" target="_parent">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.new_string('plugins.php?action=activate&amp;from=import&amp;plugin=' +
					(rt.call_function('urlencode', [var_plugin_file.clone()])).str()),
				rt.new_string('activate-plugin_' + var_plugin_file.str()),
			]),
			rt.call_function('__', [
				rt.new_string('Activate Plugin &amp; Run Importer'),
			]),
		]))
	} else if rt.is_true(rt.identical(rt.new_string('press-this'), var_from)) {
		var_install_actions.array_set('activate_plugin', rt.call_function('sprintf', [
			rt.new_string('<a class="button button-primary" href="%s" target="_parent">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.new_string('plugins.php?action=activate&amp;from=press-this&amp;plugin=' +
					(rt.call_function('urlencode', [var_plugin_file.clone()])).str()),
				rt.new_string('activate-plugin_' + var_plugin_file.str()),
			]),
			rt.call_function('__', [
				rt.new_string('Activate Plugin &amp; Go to Press This'),
			]),
		]))
	} else {
		var_install_actions.array_set('activate_plugin', rt.call_function('sprintf', [
			rt.new_string('<a class="button button-primary" href="%s" target="_parent">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.new_string('plugins.php?action=activate&amp;plugin=' +
					(rt.call_function('urlencode', [var_plugin_file.clone()])).str()),
				rt.new_string('activate-plugin_' + var_plugin_file.str()),
			]),
			rt.call_function('__', [
				rt.new_string('Activate Plugin'),
			]),
		]))
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])) {
		var_install_actions.array_set('network_activate', rt.call_function('sprintf', [
			rt.new_string('<a class="button button-primary" href="%s" target="_parent">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.new_string('plugins.php?action=activate&amp;networkwide=1&amp;plugin=' +
					(rt.call_function('urlencode', [var_plugin_file.clone()])).str()),
				rt.new_string('activate-plugin_' + var_plugin_file.str()),
			]),
			rt.call_function('_x', [
				rt.new_string('Network Activate'),
				rt.new_string('plugin'),
			]),
		]))
		var_install_actions.array_unset(rt.new_string('activate_plugin'))
	}
	if rt.is_true(rt.identical(rt.new_string('import'), var_from)) {
		var_install_actions.array_set('importers_page', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('admin_url', [rt.new_string('import.php')]),
			rt.call_function('__', [rt.new_string('Go to Importers')]),
		]))
	} else if rt.is_true(rt.identical(rt.new_string('web'), this.prop_type)) {
		var_install_actions.array_set('plugins_page', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('self_admin_url', [rt.new_string('plugin-install.php')]),
			rt.call_function('__', [rt.new_string('Go to Plugin Installer')]),
		]))
	} else if rt.is_true(rt.identical(rt.new_string('upload'), this.prop_type))
		&& rt.is_true(rt.identical(rt.new_string('plugins'), var_from)) {
		var_install_actions.array_set('plugins_page', rt.call_function('sprintf', [
			rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('self_admin_url', [rt.new_string('plugin-install.php')]),
			rt.call_function('__', [rt.new_string('Go to Plugin Installer')]),
		]))
	} else {
		var_install_actions.array_set('plugins_page', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('self_admin_url', [rt.new_string('plugins.php')]),
			rt.call_function('__', [rt.new_string('Go to Plugins page')]),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('Plugin_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result')))))
		|| rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Plugin_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result')])) {
		var_install_actions.array_unset(rt.new_string('activate_plugin'))
		var_install_actions.array_unset(rt.new_string('network_activate'))
	} else if
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugin'), var_plugin_file.clone()])))))
		|| rt.is_true(rt.call_function('is_plugin_active', [var_plugin_file.clone()])) {
		var_install_actions.array_unset(rt.new_string('activate_plugin'))
	}
	var_install_actions = rt.call_function('apply_filters', [
		rt.new_string('install_plugin_complete_actions'),
		var_install_actions.clone(),
		this.api,
		var_plugin_file.clone(),
	])
	if !(!rt.is_true(var_install_actions)) {
		this.feedback(rt.call_function('implode', [rt.new_string(' '),
			rt.cast_array(var_install_actions)]))
	}
}

fn (mut this Class_Plugin_Installer_Skin) do_overwrite() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('upload'), this.prop_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Plugin_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('folder_exists'), rt.call_method(rt.get_property(rt.new_object('Plugin_Installer_Skin', ['WP_Upgrader_Skin'], &this), 'result'), 'get_error_code', []rt.PhpVal{}))))) {
		return false
	}
	mut var_folder := rt.call_method(rt.get_property(rt.new_object('Plugin_Installer_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'result'), 'get_error_data', [rt.new_string('folder_exists')])
	var_folder = rt.new_string(rt.call_function('substr', [var_folder.clone(),
		rt.new_int(rt.get_constant('WP_PLUGIN_DIR').to_string().len)]).to_string().trim_left(' \t\n\r'))
	mut var_current_plugin_data := rt.new_bool(false)
	mut var_all_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut iter_1 := var_all_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin_data := item_1.val
		mut var_plugin := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strrpos', [
			var_plugin.clone(),
			var_folder.clone(),
		]), rt.new_int(0)))))
		{
			continue
		}
		var_current_plugin_data = var_plugin_data
	}
	mut var_new_plugin_data := rt.get_property(rt.get_property(rt.new_object('Plugin_Installer_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'new_plugin_data')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_plugin_data))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_new_plugin_data)))) {
		return false
	}
	print('<h2 class="update-from-upload-heading">' +
		(rt.call_function('esc_html__', [rt.new_string('This plugin is already installed.')])).str() +
		'</h2>')
	this.is_downgrading = rt.call_function('version_compare', [
		var_current_plugin_data.array_get(rt.new_string('Version')),
		var_new_plugin_data.array_get(rt.new_string('Version')),
		rt.new_string('>'),
	])
	mut var_rows := {
		'Name':        rt.call_function('__', [rt.new_string('Plugin name')])
		'Version':     rt.call_function('__', [rt.new_string('Version')])
		'Author':      rt.call_function('__', [rt.new_string('Author')])
		'RequiresWP':  rt.call_function('__', [
			rt.new_string('Required WordPress version'),
		])
		'RequiresPHP': rt.call_function('__', [rt.new_string('Required PHP version')])
	}
	mut var_table := rt.new_string('<table class="update-from-upload-comparison"><tbody>')
	var_table = rt.concat(var_table, rt.new_string('<tr><th></th><th>' +
		(rt.call_function('esc_html_x', [rt.new_string('Current'), rt.new_string('plugin')])).str() +
		'</th>'))
	var_table = rt.concat(var_table, rt.new_string('<th>' +
		(rt.call_function('esc_html_x', [rt.new_string('Uploaded'), rt.new_string('plugin')])).str() +
		'</th></tr>'))
	mut var_is_same_plugin := rt.new_bool(true)
	for var_field, var_label in var_rows {
		mut var_old_value := rt.new_string((if !(!rt.is_true(var_current_plugin_data.array_get(rt.new_string(field)))) {
			(var_current_plugin_data.array_get(rt.new_string(field))).str()
		} else {
			'-'
		}).str())
		mut var_new_value := rt.new_string((if !(!rt.is_true(var_new_plugin_data.array_get(rt.new_string(field)))) {
			(var_new_plugin_data.array_get(rt.new_string(field))).str()
		} else {
			'-'
		}).str())
		var_is_same_plugin = rt.new_bool(rt.is_true(var_is_same_plugin)
			&& rt.is_true(rt.identical(var_old_value, var_new_value)))
		mut var_diff_field := rt.new_bool(rt.is_true(rt.new_bool('Version' != field))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_value, var_old_value)))))
		mut var_diff_version := rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('Version'), rt.new_string(field)))
			&& rt.is_true(this.is_downgrading))
		var_table = rt.concat(var_table, rt.new_string('<tr><td class="name-label">' +
			var_label.str() + '</td><td>' +
			(rt.call_function('wp_strip_all_tags', [var_old_value.clone()])).str() + '</td>'))
		var_table = rt.concat(var_table, if rt.is_true(var_diff_field)
			|| rt.is_true(var_diff_version) {
			'<td class="warning">'
		} else {
			'<td>'
		})
		var_table = rt.concat(var_table, rt.new_string(
			(rt.call_function('wp_strip_all_tags', [var_new_value.clone()])).str() + '</td></tr>'))
	}
	var_table = rt.concat(var_table, rt.new_string('</tbody></table>'))
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('install_plugin_overwrite_comparison'),
		var_table.clone(),
		var_current_plugin_data.clone(),
		var_new_plugin_data.clone(),
	]))
	mut var_install_actions := rt.new_array()
	mut var_can_update := rt.new_bool(true)
	mut var_blocked_message := rt.new_string('<p>' +
		(rt.call_function('esc_html__', [rt.new_string('The plugin cannot be updated due to the following:')])).str() +
		'</p>')
	var_blocked_message = rt.concat(var_blocked_message, rt.new_string('<ul class="ul-disc">'))
	mut var_requires_php := if !(var_new_plugin_data.array_get(rt.new_string('RequiresPHP'))).is_null() {
		var_new_plugin_data.array_get(rt.new_string('RequiresPHP'))
	} else {
		rt.new_null()
	}
	mut var_requires_wp := if !(var_new_plugin_data.array_get(rt.new_string('RequiresWP'))).is_null() {
		var_new_plugin_data.array_get(rt.new_string('RequiresWP'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_php_version_compatible', [
		var_requires_php.clone(),
	])))))
	{
		mut var_error := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The PHP version on your server is %1$s, however the uploaded plugin requires %2$s.'),
			]),
			rt.get_constant('PHP_VERSION'),
			var_requires_php.clone(),
		])
		var_blocked_message = rt.concat(var_blocked_message, rt.new_string('<li>' +
			(rt.call_function('esc_html', [var_error.clone()])).str() + '</li>'))
		var_can_update = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_version_compatible', [
		var_requires_wp.clone(),
	])))))
	{
		var_error = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your WordPress version is %1$s, however the uploaded plugin requires %2$s.'),
			]),
			rt.call_function('esc_html', [
				rt.call_function('wp_get_wp_version', []rt.PhpVal{}),
			]),
			var_requires_wp.clone(),
		])
		var_blocked_message = rt.concat(var_blocked_message, rt.new_string('<li>' +
			(rt.call_function('esc_html', [var_error.clone()])).str() + '</li>'))
		var_can_update = rt.new_bool(false)
	}
	var_blocked_message = rt.concat(var_blocked_message, rt.new_string('</ul>'))
	if rt.is_true(var_can_update) {
		if rt.is_true(this.is_downgrading) {
			mut var_warning := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You are uploading an older version of a current plugin. You can continue to install the older version, but be sure to <a href="%s">back up your database and files</a> first.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://developer.wordpress.org/advanced-administration/security/backup/'),
				]),
			])
		} else {
			var_warning = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You are updating a plugin. Be sure to <a href="%s">back up your database and files</a> first.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://developer.wordpress.org/advanced-administration/security/backup/'),
				]),
			])
		}
		print('<p class="update-from-upload-notice">' + var_warning.str() + '</p>')
		mut var_overwrite := rt.new_string((if rt.is_true(this.is_downgrading) {
			'downgrade-plugin'
		} else {
			'update-plugin'
		}).str())
		var_install_actions.array_set('overwrite_plugin', rt.call_function('sprintf', [
			rt.new_string('<a class="button button-primary update-from-upload-overwrite" href="%s" target="_parent">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.call_function('add_query_arg', [rt.new_string('overwrite'),
					var_overwrite.clone(), this.url]),
				rt.new_string('plugin-upload'),
			]),
			rt.call_function('_x', [
				rt.new_string('Replace current with uploaded'),
				rt.new_string('plugin'),
			]),
		]))
	} else {
		rt.echo_val(var_blocked_message)
	}
	mut var_cancel_url := rt.call_function('add_query_arg', [
		rt.new_string('action'), rt.new_string('upload-plugin-cancel-overwrite'), this.url])
	var_install_actions.array_set('plugins_page', rt.call_function('sprintf', [
		rt.new_string('<a class="button" href="%s">%s</a>'),
		rt.call_function('wp_nonce_url', [var_cancel_url.clone(),
			rt.new_string('plugin-upload-cancel-overwrite')]),
		rt.call_function('__', [rt.new_string('Cancel and go back')]),
	]))
	var_install_actions = rt.call_function('apply_filters', [
		rt.new_string('install_plugin_overwrite_actions'),
		var_install_actions.clone(),
		this.api,
		var_new_plugin_data.clone(),
	])
	if !(!rt.is_true(var_install_actions)) {
		rt.call_function('printf', [
			rt.new_string('<p class="update-from-upload-expired hidden">%s</p>'),
			rt.call_function('__', [
				rt.new_string('The uploaded file has expired. Please go back and upload it again.'),
			]),
		])
		print('<p class="update-from-upload-actions">' +
			(rt.call_function('implode', [rt.new_string(' '), rt.cast_array(var_install_actions)])).str() +
			'</p>')
	}
	return true
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_plugin_installer_skin(arg_0 rt.PhpVal) &Class_Plugin_Installer_Skin {
	mut obj := &Class_Plugin_Installer_Skin{
		PhpObjectBase:  rt.PhpObjectBase{}
		api:            rt.new_null()
		prop_type:      rt.new_null()
		url:            rt.new_null()
		overwrite:      rt.new_null()
		is_downgrading: rt.new_bool(false)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin(_args ...rt.PhpVal) &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Plugin_Installer_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Plugin_Installer_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'api' { return this.api }
		'type' { return this.prop_type }
		'url' { return this.url }
		'overwrite' { return this.overwrite }
		'is_downgrading' { return this.is_downgrading }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Plugin_Installer_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'api' {
			this.api = val
			return true
		}
		'type' {
			this.prop_type = val
			return true
		}
		'url' {
			this.url = val
			return true
		}
		'overwrite' {
			this.overwrite = val
			return true
		}
		'is_downgrading' {
			this.is_downgrading = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
