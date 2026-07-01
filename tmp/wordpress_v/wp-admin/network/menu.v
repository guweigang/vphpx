import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_menu := []rt.PhpVal{}
	mut var_submenu := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	var_menu[2] = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Dashboard')]) },
		rt.ArrayItem{ key: none, val: 'manage_network' },
		rt.ArrayItem{ key: none, val: 'index.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-top-first menu-icon-dashboard' },
		rt.ArrayItem{ key: none, val: 'menu-dashboard' },
		rt.ArrayItem{ key: none, val: 'dashicons-dashboard' },
	])
	var_submenu.array_get_mut('index.php').array_set(0, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Home')]) },
		rt.ArrayItem{ key: none, val: 'read' },
		rt.ArrayItem{ key: none, val: 'index.php' },
	]))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		mut var_cap := 'update_core'
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_plugins'),
	]))
	{
		var_cap = 'update_plugins'
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_themes'),
	]))
	{
		var_cap = 'update_themes'
	} else {
		var_cap = 'update_languages'
	}
	mut var_update_data := rt.call_function('wp_get_update_data', []rt.PhpVal{})
	if rt.is_true(var_update_data.array_get('counts').array_get('total')) {
		var_submenu.array_get_mut('index.php').array_set(10, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Updates %s'),
				]),
				rt.call_function('sprintf', [
					rt.new_string('<span class="update-plugins count-%s"><span class="update-count">%s</span></span>'),
					var_update_data.array_get('counts').array_get('total'),
					rt.call_function('number_format_i18n',
						[var_update_data.array_get('counts').array_get('total')]),
				]),
			]) },
			rt.ArrayItem{ key: none, val: var_cap },
			rt.ArrayItem{ key: none, val: 'update-core.php' },
		]))
	} else {
		var_submenu.array_get_mut('index.php').array_set(10, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Updates'),
			]) },
			rt.ArrayItem{ key: none, val: var_cap },
			rt.ArrayItem{ key: none, val: 'update-core.php' },
		]))
	}
	var_cap = ''
	var_submenu.array_get_mut('index.php').array_set(15, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Upgrade Network'),
		]) },
		rt.ArrayItem{ key: none, val: 'upgrade_network' },
		rt.ArrayItem{ key: none, val: 'upgrade.php' },
	]))
	var_menu[4] = rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{ key: none, val: 'separator1' },
		rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'wp-menu-separator' }])
	var_menu[5] = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Sites')]) },
		rt.ArrayItem{ key: none, val: 'manage_sites' },
		rt.ArrayItem{ key: none, val: 'sites.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-site' },
		rt.ArrayItem{ key: none, val: 'menu-site' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-multisite' },
	])
	var_submenu.array_get_mut('sites.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('All Sites')]) },
		rt.ArrayItem{ key: none, val: 'manage_sites' },
		rt.ArrayItem{ key: none, val: 'sites.php' },
	]))
	var_submenu.array_get_mut('sites.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Add Site')]) },
		rt.ArrayItem{ key: none, val: 'create_sites' },
		rt.ArrayItem{ key: none, val: 'site-new.php' },
	]))
	var_menu[10] = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Users')]) },
		rt.ArrayItem{ key: none, val: 'manage_network_users' },
		rt.ArrayItem{ key: none, val: 'users.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-users' },
		rt.ArrayItem{ key: none, val: 'menu-users' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-users' },
	])
	var_submenu.array_get_mut('users.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('All Users')]) },
		rt.ArrayItem{ key: none, val: 'manage_network_users' },
		rt.ArrayItem{ key: none, val: 'users.php' },
	]))
	var_submenu.array_get_mut('users.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Add User')]) },
		rt.ArrayItem{ key: none, val: 'create_users' },
		rt.ArrayItem{ key: none, val: 'user-new.php' },
	]))
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')]))
		&& rt.is_true(var_update_data.array_get('counts').array_get('themes'))))
	{
		var_menu[15] = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Themes %s'),
				]),
				rt.call_function('sprintf', [
					rt.new_string('<span class="update-plugins count-%s"><span class="theme-count">%s</span></span>'),
					var_update_data.array_get('counts').array_get('themes'),
					rt.call_function('number_format_i18n',
						[var_update_data.array_get('counts').array_get('themes')]),
				]),
			]) },
			rt.ArrayItem{ key: none, val: 'manage_network_themes' },
			rt.ArrayItem{ key: none, val: 'themes.php' },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'menu-top menu-icon-appearance' },
			rt.ArrayItem{ key: none, val: 'menu-appearance' },
			rt.ArrayItem{ key: none, val: 'dashicons-admin-appearance' },
		])
	} else {
		var_menu[15] = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Themes'),
			]) },
			rt.ArrayItem{ key: none, val: 'manage_network_themes' },
			rt.ArrayItem{ key: none, val: 'themes.php' },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'menu-top menu-icon-appearance' },
			rt.ArrayItem{ key: none, val: 'menu-appearance' },
			rt.ArrayItem{ key: none, val: 'dashicons-admin-appearance' },
		])
	}
	var_submenu.array_get_mut('themes.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Installed Themes'),
		]) },
		rt.ArrayItem{ key: none, val: 'manage_network_themes' },
		rt.ArrayItem{ key: none, val: 'themes.php' },
	]))
	var_submenu.array_get_mut('themes.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Add Theme')]) },
		rt.ArrayItem{ key: none, val: 'install_themes' },
		rt.ArrayItem{ key: none, val: 'theme-install.php' },
	]))
	var_submenu.array_get_mut('themes.php').array_set(15, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Theme File Editor'),
		]) },
		rt.ArrayItem{ key: none, val: 'edit_themes' },
		rt.ArrayItem{ key: none, val: 'theme-editor.php' },
	]))
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')]))
		&& rt.is_true(var_update_data.array_get('counts').array_get('plugins'))))
	{
		var_menu[20] = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Plugins %s'),
				]),
				rt.call_function('sprintf', [
					rt.new_string('<span class="update-plugins count-%s"><span class="plugin-count">%s</span></span>'),
					var_update_data.array_get('counts').array_get('plugins'),
					rt.call_function('number_format_i18n',
						[var_update_data.array_get('counts').array_get('plugins')]),
				]),
			]) },
			rt.ArrayItem{ key: none, val: 'manage_network_plugins' },
			rt.ArrayItem{ key: none, val: 'plugins.php' },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'menu-top menu-icon-plugins' },
			rt.ArrayItem{ key: none, val: 'menu-plugins' },
			rt.ArrayItem{ key: none, val: 'dashicons-admin-plugins' },
		])
	} else {
		var_menu[20] = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Plugins'),
			]) },
			rt.ArrayItem{ key: none, val: 'manage_network_plugins' },
			rt.ArrayItem{ key: none, val: 'plugins.php' },
			rt.ArrayItem{ key: none, val: '' },
			rt.ArrayItem{ key: none, val: 'menu-top menu-icon-plugins' },
			rt.ArrayItem{ key: none, val: 'menu-plugins' },
			rt.ArrayItem{ key: none, val: 'dashicons-admin-plugins' },
		])
	}
	var_submenu.array_get_mut('plugins.php').array_set(5, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Installed Plugins'),
		]) },
		rt.ArrayItem{ key: none, val: 'manage_network_plugins' },
		rt.ArrayItem{ key: none, val: 'plugins.php' },
	]))
	var_submenu.array_get_mut('plugins.php').array_set(10, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Add Plugin'),
		]) },
		rt.ArrayItem{ key: none, val: 'install_plugins' },
		rt.ArrayItem{ key: none, val: 'plugin-install.php' },
	]))
	var_submenu.array_get_mut('plugins.php').array_set(15, rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Plugin File Editor'),
		]) },
		rt.ArrayItem{ key: none, val: 'edit_plugins' },
		rt.ArrayItem{ key: none, val: 'plugin-editor.php' },
	]))
	var_menu[25] = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Settings')]) },
		rt.ArrayItem{ key: none, val: 'manage_network_options' },
		rt.ArrayItem{ key: none, val: 'settings.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-settings' },
		rt.ArrayItem{ key: none, val: 'menu-settings' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-settings' },
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('WP_ALLOW_MULTISITE')]))))
		&& rt.is_true(rt.get_constant('WP_ALLOW_MULTISITE'))))
	{
		var_submenu.array_get_mut('settings.php').array_set(5, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Network Settings'),
			]) },
			rt.ArrayItem{ key: none, val: 'manage_network_options' },
			rt.ArrayItem{ key: none, val: 'settings.php' },
		]))
		var_submenu.array_get_mut('settings.php').array_set(10, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Network Setup'),
			]) },
			rt.ArrayItem{ key: none, val: 'setup_network' },
			rt.ArrayItem{ key: none, val: 'setup.php' },
		]))
	}
	var_update_data = rt.new_null()
	var_menu[99] = rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'exist' }, rt.ArrayItem{ key: none, val: 'separator-last' },
		rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'wp-menu-separator' }])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/menu.php', '4')
}
