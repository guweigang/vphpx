import rt

const global_const_iframe_request = true

fn wp_load_press_this() {
	mut var_plugin_slug := 'press-this'
	mut var_plugin_file := 'press-this/press-this-plugin.php'
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('post')]), 'cap'), 'create_posts')])))))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to create posts as this user.'),
			]),
			rt.call_function('__', [
				rt.new_string('You need a higher level of permission.'),
			]),
			rt.new_int(403),
		])
	} else if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string(var_plugin_file).dup()]))
	{
		rt.include_file(
			(rt.get_constant('WP_PLUGIN_DIR')).str() + '/press-this/class-wp-press-this-plugin.php',
			'1')
		mut var_wp_press_this := create_wp_press_this_plugin()
		var_wp_press_this.html()
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('activate_plugins'),
	]))
	{
		if rt.is_true(rt.call_function('file_exists', [
			(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_file]))
		{
			mut var_url := rt.call_function('wp_nonce_url', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'action', val: 'activate' },
						rt.ArrayItem{ key: 'plugin', val: var_plugin_file },
						rt.ArrayItem{ key: 'from', val: 'press-this' }]),
					rt.call_function('admin_url', [rt.new_string('plugins.php')]),
				]),
				'activate-plugin_' + var_plugin_file,
			])
			mut var_action := rt.call_function('sprintf', [
				rt.new_string('<a href="%1$s" aria-label="%2$s">%2$s</a>'),
				rt.call_function('esc_url', [var_url.dup()]),
				rt.call_function('__', [rt.new_string('Activate Press This')]),
			])
		} else {
			if rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})) {
				var_url = rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'action', val: 'install-plugin' },
							rt.ArrayItem{ key: 'plugin', val: var_plugin_slug },
							rt.ArrayItem{ key: 'from', val: 'press-this' },
						]),
						rt.call_function('self_admin_url', [
							rt.new_string('update.php'),
						]),
					]),
					'install-plugin_' + var_plugin_slug,
				])
				var_action = rt.call_function('sprintf', [
					rt.new_string('<a href="%1$s" class="install-now" data-slug="%2$s" data-name="%2$s" aria-label="%3$s">%3$s</a>'),
					rt.call_function('esc_url', [var_url.dup()]),
					rt.call_function('esc_attr', [rt.new_string(var_plugin_slug).dup()]),
					rt.call_function('_x', [rt.new_string('Install Now'),
						rt.new_string('plugin')]),
				])
			} else {
				var_action = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Press This is not installed. Please install Press This from <a href="%s">the main site</a>.'),
					]),
					rt.call_function('get_admin_url', [
						rt.call_function('get_current_network_id', []rt.PhpVal{}),
						rt.new_string('press-this.php'),
					]),
				])
			}
		}
		rt.call_function('wp_die', [
			(rt.call_function('__', [rt.new_string('The Press This plugin is required.')])).str() +
			'<br />' + var_action.str(),
			rt.call_function('__', [
				rt.new_string('Installation Required'),
			]),
			rt.new_int(200)])
	} else {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Press This is not available. Please contact your site administrator.'),
			]),
			rt.call_function('__', [
				rt.new_string('Installation Required'),
			]),
			rt.new_int(200),
		])
	}
}

struct Class_WP_Press_This_Plugin {
	rt.PhpObjectBase
}

fn create_wp_press_this_plugin() &Class_WP_Press_This_Plugin {
	mut obj := &Class_WP_Press_This_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Press_This_Plugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Press_This_Plugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Press_This_Plugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	wp_load_press_this()
}
