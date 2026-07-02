import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
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
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/update.php', '3')
}
