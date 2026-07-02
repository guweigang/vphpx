import rt

const global_const_wp_network_admin = true

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_current_blog := rt.new_null()
	mut var_current_site := rt.new_null()
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Multisite support is not enabled.')]),
		])
	}
	mut var_redirect_network_admin_request := rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_blog, 'domain'), rt.get_property(var_current_site, 'domain')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_blog, 'path'), rt.get_property(var_current_site, 'path')]))))))
	var_redirect_network_admin_request = rt.call_function('apply_filters', [
		rt.new_string('redirect_network_admin_request'),
		var_redirect_network_admin_request.clone(),
	])
	if rt.is_true(var_redirect_network_admin_request) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', []rt.PhpVal{}),
		])
		exit(0)
	}
	var_redirect_network_admin_request = rt.new_null()
}
