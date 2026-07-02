import rt

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
}

struct Class_Bulk_Plugin_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Plugin_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Plugin_Installer_Skin {
	rt.PhpObjectBase
}

struct Class_File_Upload_Upgrader {
	rt.PhpObjectBase
}

struct Class_Theme_Upgrader {
	rt.PhpObjectBase
}

struct Class_Theme_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Bulk_Theme_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Theme_Installer_Skin {
	rt.PhpObjectBase
}

fn create_plugin_upgrader(_args ...rt.PhpVal) &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_bulk_plugin_upgrader_skin(_args ...rt.PhpVal) &Class_Bulk_Plugin_Upgrader_Skin {
	mut obj := &Class_Bulk_Plugin_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader_skin(_args ...rt.PhpVal) &Class_Plugin_Upgrader_Skin {
	mut obj := &Class_Plugin_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_installer_skin(_args ...rt.PhpVal) &Class_Plugin_Installer_Skin {
	mut obj := &Class_Plugin_Installer_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_file_upload_upgrader(_args ...rt.PhpVal) &Class_File_Upload_Upgrader {
	mut obj := &Class_File_Upload_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_theme_upgrader(_args ...rt.PhpVal) &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_theme_upgrader_skin(_args ...rt.PhpVal) &Class_Theme_Upgrader_Skin {
	mut obj := &Class_Theme_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_bulk_theme_upgrader_skin(_args ...rt.PhpVal) &Class_Bulk_Theme_Upgrader_Skin {
	mut obj := &Class_Bulk_Theme_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_theme_installer_skin(_args ...rt.PhpVal) &Class_Theme_Installer_Skin {
	mut obj := &Class_Theme_Installer_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Bulk_Plugin_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Bulk_Plugin_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Bulk_Plugin_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Plugin_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Plugin_Installer_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Installer_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Installer_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_File_Upload_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_File_Upload_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_File_Upload_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Theme_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Theme_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Theme_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Bulk_Theme_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Bulk_Theme_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Theme_Installer_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Theme_Installer_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Theme_Installer_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var__FILES := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IFRAME_REQUEST')])))))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get(rt.new_string('action')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'update-selected'
	}, rt.ArrayItem{ key: none, val: 'activate-plugin' }, rt.ArrayItem{
		key: none
		val: 'update-selected-themes'
	}]), rt.new_bool(true)])) {
		rt.call_function('define', [rt.new_string('IFRAME_REQUEST'),
			rt.new_bool(true)])
	}
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-a11y')])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) {
		mut var_plugin := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('plugin')) {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('plugin')).to_string().trim_space()
		} else {
			''
		}
		mut var_theme := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('theme')) { rt.call_function('urldecode', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme')),
			]) } else { rt.new_string('') }
		mut var_action := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))).is_null() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.identical(rt.new_string('update-selected'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to update plugins for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('bulk-update-plugins'),
			])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('plugins')) {
				mut var_plugins := rt.call_function('explode', [
					rt.new_string(','),
					rt.call_function('stripslashes', [
						rt.get_superglobal('_GET').array_get(rt.new_string('plugins')),
					])])
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				var_plugins =
					rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
			} else {
				var_plugins = rt.new_array()
			}
			var_plugins = rt.call_function('array_map', [rt.new_string('urldecode'),
				var_plugins.clone()])
			mut var_url :=
				rt.new_string('update.php?action=update-selected&amp;plugins=' +(rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), var_plugins.clone()])])).str())
			mut var_nonce := rt.new_string('bulk-update-plugins')
			rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
			rt.call_function('iframe_header', []rt.PhpVal{})
			mut var_upgrader := create_plugin_upgrader(create_bulk_plugin_upgrader_skin(rt.call_function('compact', [
				rt.new_string('nonce'),
				rt.new_string('url'),
			])))
			rt.call_method(var_upgrader, 'bulk_upgrade', [var_plugins.clone()])
			rt.call_function('iframe_footer', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_string('upgrade-plugin'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to update plugins for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('upgrade-plugin_' + var_plugin),
			])
			mut var_title := rt.call_function('__', [rt.new_string('Update Plugin')])
			mut var_parent_file := 'plugins.php'
			mut var_submenu_file := 'plugins.php'
			rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			var_nonce = rt.new_string('upgrade-plugin_' + var_plugin)
			var_url = rt.new_string('update.php?action=upgrade-plugin&plugin=' +
				(rt.call_function('urlencode', [rt.new_string(var_plugin.str()).clone()])).str())
			var_upgrader = create_plugin_upgrader(create_plugin_upgrader_skin(rt.call_function('compact', [
				rt.new_string('title'),
				rt.new_string('nonce'),
				rt.new_string('url'),
				rt.new_string('plugin'),
			])))
			rt.call_method(var_upgrader, 'upgrade', [rt.new_string(var_plugin.str()).clone()])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		} else if rt.is_true(rt.identical(rt.new_string('activate-plugin'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to update plugins for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('activate-plugin_' + var_plugin),
			])
			if !(rt.get_superglobal('_GET').array_isset(rt.new_string('failure')))
				&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('success'))) {
				rt.call_function('wp_redirect', [
					rt.call_function('admin_url', [
						rt.new_string('update.php?action=activate-plugin&failure=true&plugin=' +
							(rt.call_function('urlencode', [rt.new_string(var_plugin.str()).clone()])).str() +
							'&_wpnonce=' +
							(rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))).str()),
					]),
				])
				rt.call_function('activate_plugin', [rt.new_string(var_plugin.str()).clone(),
					rt.new_string(''),
					rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('networkwide'))))),
					rt.new_bool(true)])
				rt.call_function('wp_redirect', [
					rt.call_function('admin_url', [
						rt.new_string('update.php?action=activate-plugin&success=true&plugin=' +
							(rt.call_function('urlencode', [rt.new_string(var_plugin.str()).clone()])).str() +
							'&_wpnonce=' +
							(rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))).str()),
					]),
				])
				exit(0)
			}
			rt.call_function('iframe_header', [
				rt.call_function('__', [rt.new_string('Plugin Reactivation')]),
				rt.new_bool(true),
			])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('success')) {
				print('<p>' +
					(rt.call_function('__', [rt.new_string('Plugin reactivated successfully.')])).str() +
					'</p>')
			}
			if rt.get_superglobal('_GET').array_isset(rt.new_string('failure')) {
				print('<p>' +
					(rt.call_function('__', [rt.new_string('Plugin failed to reactivate due to a fatal error.')])).str() +
					'</p>')
				rt.call_function('error_reporting', [
					rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('E_CORE_ERROR'),
						rt.get_constant('E_CORE_WARNING')), rt.get_constant('E_COMPILE_ERROR')),
						rt.get_constant('E_ERROR')), rt.get_constant('E_WARNING')),
						rt.get_constant('E_PARSE')), rt.get_constant('E_USER_ERROR')),
						rt.get_constant('E_USER_WARNING')), rt.get_constant('E_RECOVERABLE_ERROR')),
				])
				rt.call_function('ini_set', [rt.new_string('display_errors'),
					rt.new_bool(true)])
				rt.call_function('wp_register_plugin_realpath', [
					rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin),
				])
				rt.include_file((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin, '1')
			}
			rt.call_function('iframe_footer', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_string('install-plugin'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('install_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to install plugins on this site.'),
					]),
				])
			}
			rt.include_file(
				(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php', '4')
			rt.call_function('check_admin_referer', [
				rt.new_string('install-plugin_' + var_plugin),
			])
			mut var_api := rt.call_function('plugins_api', [
				rt.new_string('plugin_information'),
				rt.create_array([rt.ArrayItem{ key: 'slug', val: var_plugin },
					rt.ArrayItem{ key: 'fields', val: rt.create_array([
						rt.ArrayItem{ key: 'sections', val: false },
					]) }]),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
				rt.call_function('wp_die', [var_api.clone()])
			}
			var_title = rt.call_function('__', [rt.new_string('Plugin Installation')])
			var_parent_file = 'plugins.php'
			var_submenu_file = 'plugin-install.php'
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Installing Plugin: %s')]),
				rt.new_string((rt.get_property(var_api, 'name')).str() + ' ' +
					(rt.get_property(var_api, 'version')).str()),
			])
			var_nonce = rt.new_string('install-plugin_' + var_plugin)
			var_url = rt.new_string('update.php?action=install-plugin&plugin=' +
				(rt.call_function('urlencode', [rt.new_string(var_plugin.str()).clone()])).str())
			if rt.get_superglobal('_GET').array_isset(rt.new_string('from')) {
				var_url = rt.concat(var_url,
					rt.new_string('&from=' +(rt.call_function('urlencode', [rt.call_function('stripslashes', [rt.get_superglobal('_GET').array_get(rt.new_string('from'))])])).str()))
			}
			mut var_type := 'web'
			var_upgrader = create_plugin_upgrader(create_plugin_installer_skin(rt.call_function('compact', [
				rt.new_string('title'),
				rt.new_string('url'),
				rt.new_string('nonce'),
				rt.new_string('plugin'),
				rt.new_string('api'),
			])))
			rt.call_method(var_upgrader, 'install', [
				rt.get_property(var_api, 'download_link'),
			])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		} else if rt.is_true(rt.identical(rt.new_string('upload-plugin'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('upload_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to install plugins on this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('plugin-upload')])
			if var__FILES.array_get(rt.new_string('pluginzip')).array_isset(rt.new_string('name'))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [rt.new_string(var__FILES.array_get(rt.new_string('pluginzip')).array_get(rt.new_string('name')).to_string().to_lower()), rt.new_string('.zip')]))))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Only .zip archives may be uploaded.'),
					]),
				])
			}
			mut var_file_upload := create_file_upload_upgrader(rt.new_string('pluginzip'),
				rt.new_string('package'))
			var_title = rt.call_function('__', [rt.new_string('Upload Plugin')])
			var_parent_file = 'plugins.php'
			var_submenu_file = 'plugin-install.php'
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Installing plugin from uploaded file: %s'),
				]),
				rt.call_function('esc_html', [
					rt.call_function('basename', [
						rt.get_property(var_file_upload, 'filename'),
					]),
				]),
			])
			var_nonce = rt.new_string('plugin-upload')
			var_url = rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'package', val: rt.get_property(var_file_upload, 'id') },
				]),
				rt.new_string('update.php?action=upload-plugin'),
			])
			var_type = 'upload'
			mut var_overwrite := if rt.get_superglobal('_GET').array_isset(rt.new_string('overwrite')) { rt.call_function('sanitize_text_field', [
					rt.get_superglobal('_GET').array_get(rt.new_string('overwrite')),
				]) } else { rt.new_string('') }
			var_overwrite = if rt.is_true(rt.call_function('in_array', [
				var_overwrite.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'update-plugin' },
					rt.ArrayItem{ key: none, val: 'downgrade-plugin' },
				]),
				rt.new_bool(true)]))
			{ var_overwrite } else { rt.new_string('') }
			var_upgrader = create_plugin_upgrader(create_plugin_installer_skin(rt.call_function('compact', [
				rt.new_string('type'),
				rt.new_string('title'),
				rt.new_string('nonce'),
				rt.new_string('url'),
				rt.new_string('overwrite'),
			])))
			mut var_result := rt.call_method(var_upgrader, 'install', [
				rt.get_property(var_file_upload, 'package'),
				rt.create_array([
					rt.ArrayItem{ key: 'overwrite_package', val: var_overwrite },
				]),
			])
			if rt.is_true(var_result)
				|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				var_file_upload.cleanup()
			}
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		} else if rt.is_true(rt.identical(rt.new_string('upload-plugin-cancel-overwrite'),
			var_action))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('upload_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to install plugins on this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('plugin-upload-cancel-overwrite'),
			])
			if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('package')))) {
				mut var_attachment_id :=
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('package'))).to_i64())
				if rt.is_true(rt.call_function('get_post', [var_attachment_id.clone()])) {
					var_file_upload = create_file_upload_upgrader(rt.new_string('pluginzip'),
						rt.new_string('package'))
					var_file_upload.cleanup()
				}
			}
			rt.call_function('wp_redirect', [
				rt.call_function('self_admin_url', [rt.new_string('plugin-install.php')]),
			])
			exit(0)
		} else if rt.is_true(rt.identical(rt.new_string('upgrade-theme'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_themes'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to update themes for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('upgrade-theme_' + var_theme.str()),
			])
			rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
			var_title = rt.call_function('__', [rt.new_string('Update Theme')])
			var_parent_file = 'themes.php'
			var_submenu_file = 'themes.php'
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			var_nonce = rt.new_string('upgrade-theme_' + var_theme.str())
			var_url = rt.new_string('update.php?action=upgrade-theme&theme=' +
				(rt.call_function('urlencode', [var_theme.clone()])).str())
			var_upgrader = create_theme_upgrader(create_theme_upgrader_skin(rt.call_function('compact', [
				rt.new_string('title'),
				rt.new_string('nonce'),
				rt.new_string('url'),
				rt.new_string('theme'),
			])))
			rt.call_method(var_upgrader, 'upgrade', [var_theme.clone()])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		} else if rt.is_true(rt.identical(rt.new_string('update-selected-themes'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_themes'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to update themes for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-update-themes')])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('themes')) {
				mut var_themes := rt.call_function('explode', [
					rt.new_string(','),
					rt.call_function('stripslashes', [
						rt.get_superglobal('_GET').array_get(rt.new_string('themes')),
					])])
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				var_themes =
					rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('checked')))
			} else {
				var_themes = rt.new_array()
			}
			var_themes = rt.call_function('array_map', [rt.new_string('urldecode'),
				var_themes.clone()])
			var_url =
				rt.new_string('update.php?action=update-selected-themes&amp;themes=' +(rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), var_themes.clone()])])).str())
			var_nonce = rt.new_string('bulk-update-themes')
			rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
			rt.call_function('iframe_header', []rt.PhpVal{})
			var_upgrader = create_theme_upgrader(create_bulk_theme_upgrader_skin(rt.call_function('compact', [
				rt.new_string('nonce'),
				rt.new_string('url'),
			])))
			rt.call_method(var_upgrader, 'bulk_upgrade', [var_themes.clone()])
			rt.call_function('iframe_footer', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_string('install-theme'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('install_themes'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to install themes on this site.'),
					]),
				])
			}
			rt.include_file(
				(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '4')
			rt.call_function('check_admin_referer', [
				rt.new_string('install-theme_' + var_theme.str()),
			])
			var_api = rt.call_function('themes_api', [rt.new_string('theme_information'),
				rt.create_array([rt.ArrayItem{ key: 'slug', val: var_theme },
					rt.ArrayItem{ key: 'fields', val: rt.create_array([
						rt.ArrayItem{ key: 'sections', val: false },
						rt.ArrayItem{ key: 'tags', val: false },
					]) }])])
			if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
				rt.call_function('wp_die', [var_api.clone()])
			}
			var_title = rt.call_function('__', [rt.new_string('Install Themes')])
			var_parent_file = 'themes.php'
			var_submenu_file = 'themes.php'
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Installing Theme: %s')]),
				rt.new_string((rt.get_property(var_api, 'name')).str() + ' ' +
					(rt.get_property(var_api, 'version')).str()),
			])
			var_nonce = rt.new_string('install-theme_' + var_theme.str())
			var_url = rt.new_string('update.php?action=install-theme&theme=' +
				(rt.call_function('urlencode', [var_theme.clone()])).str())
			var_type = 'web'
			var_upgrader = create_theme_upgrader(create_theme_installer_skin(rt.call_function('compact', [
				rt.new_string('title'),
				rt.new_string('url'),
				rt.new_string('nonce'),
				rt.new_string('plugin'),
				rt.new_string('api'),
			])))
			rt.call_method(var_upgrader, 'install', [
				rt.get_property(var_api, 'download_link'),
			])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		} else if rt.is_true(rt.identical(rt.new_string('upload-theme'), var_action)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('upload_themes'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to install themes on this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('theme-upload')])
			if var__FILES.array_get(rt.new_string('themezip')).array_isset(rt.new_string('name'))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [rt.new_string(var__FILES.array_get(rt.new_string('themezip')).array_get(rt.new_string('name')).to_string().to_lower()), rt.new_string('.zip')]))))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Only .zip archives may be uploaded.'),
					]),
				])
			}
			var_file_upload = create_file_upload_upgrader(rt.new_string('themezip'),
				rt.new_string('package'))
			var_title = rt.call_function('__', [rt.new_string('Upload Theme')])
			var_parent_file = 'themes.php'
			var_submenu_file = 'theme-install.php'
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Installing theme from uploaded file: %s'),
				]),
				rt.call_function('esc_html', [
					rt.call_function('basename', [
						rt.get_property(var_file_upload, 'filename'),
					]),
				]),
			])
			var_nonce = rt.new_string('theme-upload')
			var_url = rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'package', val: rt.get_property(var_file_upload, 'id') },
				]),
				rt.new_string('update.php?action=upload-theme'),
			])
			var_type = 'upload'
			var_overwrite = if rt.get_superglobal('_GET').array_isset(rt.new_string('overwrite')) { rt.call_function('sanitize_text_field', [
					rt.get_superglobal('_GET').array_get(rt.new_string('overwrite')),
				]) } else { rt.new_string('') }
			var_overwrite = if rt.is_true(rt.call_function('in_array', [
				var_overwrite.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'update-theme' },
					rt.ArrayItem{ key: none, val: 'downgrade-theme' },
				]),
				rt.new_bool(true)]))
			{ var_overwrite } else { rt.new_string('') }
			var_upgrader = create_theme_upgrader(create_theme_installer_skin(rt.call_function('compact', [
				rt.new_string('type'),
				rt.new_string('title'),
				rt.new_string('nonce'),
				rt.new_string('url'),
				rt.new_string('overwrite'),
			])))
			var_result = rt.call_method(var_upgrader, 'install', [
				rt.get_property(var_file_upload, 'package'),
				rt.create_array([
					rt.ArrayItem{ key: 'overwrite_package', val: var_overwrite },
				]),
			])
			if rt.is_true(var_result)
				|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				var_file_upload.cleanup()
			}
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		} else if rt.is_true(rt.identical(rt.new_string('upload-theme-cancel-overwrite'),
			var_action))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('upload_themes'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to install themes on this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('theme-upload-cancel-overwrite'),
			])
			if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('package')))) {
				var_attachment_id =
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('package'))).to_i64())
				if rt.is_true(rt.call_function('get_post', [var_attachment_id.clone()])) {
					var_file_upload = create_file_upload_upgrader(rt.new_string('themezip'),
						rt.new_string('package'))
					var_file_upload.cleanup()
				}
			}
			rt.call_function('wp_redirect', [
				rt.call_function('self_admin_url', [rt.new_string('theme-install.php')]),
			])
			exit(0)
		} else {
			rt.call_function('do_action', [
				rt.new_string('update-custom_${var_action.to_string()}'),
			])
		}
	}
}
