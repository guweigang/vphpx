import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_menu := []rt.PhpVal{}
	mut var__wp_real_parent_file := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	var_menu[2] = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Dashboard')]) },
		rt.ArrayItem{ key: none, val: 'exist' },
		rt.ArrayItem{ key: none, val: 'index.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-top-first menu-icon-dashboard' },
		rt.ArrayItem{ key: none, val: 'menu-dashboard' },
		rt.ArrayItem{ key: none, val: 'dashicons-dashboard' },
	])
	var_menu[4] = rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'exist' }, rt.ArrayItem{ key: none, val: 'separator1' },
		rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'wp-menu-separator' }])
	var_menu[70] = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('__', [
			rt.new_string('Profile')]) },
		rt.ArrayItem{ key: none, val: 'exist' },
		rt.ArrayItem{ key: none, val: 'profile.php' },
		rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'menu-top menu-icon-users' },
		rt.ArrayItem{ key: none, val: 'menu-users' },
		rt.ArrayItem{ key: none, val: 'dashicons-admin-users' },
	])
	var_menu[99] = rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'exist' }, rt.ArrayItem{ key: none, val: 'separator-last' },
		rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'wp-menu-separator' }])
	var__wp_real_parent_file['users.php'] = 'profile.php'
	mut var_compat := rt.new_array()
	mut var_submenu := rt.new_array()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/menu.php', '4')
}
