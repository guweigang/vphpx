import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))
		&& rt.is_true(rt.identical(rt.new_string('plugin-information'), rt.get_superglobal('_GET').array_get('tab')))))
	{
		rt.call_function('define', [rt.new_string('IFRAME_REQUEST'),
			rt.new_bool(true)])
	}
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/plugin-install.php', '3')
}
