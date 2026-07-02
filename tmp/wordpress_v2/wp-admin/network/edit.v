import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	mut var_action := if !(rt.get_superglobal('_GET').array_get(rt.new_string('action'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('action'))
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_action) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', []rt.PhpVal{}),
		])
		exit(0)
	}
	rt.call_function('do_action', [rt.new_string('wpmuadminedit')])
	rt.call_function('do_action', [
		rt.new_string('network_admin_edit_${var_action.to_string()}'),
	])
	rt.call_function('wp_redirect', [
		rt.call_function('network_admin_url', []rt.PhpVal{}),
	])
	exit(0)
}
