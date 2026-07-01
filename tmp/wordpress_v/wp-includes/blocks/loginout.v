import rt

fn render_block_core_loginout(var_attributes rt.PhpVal) string {
	mut var_current_url := rt.new_string(
		if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https://' } else { 'http://' } +
		(rt.get_superglobal('_SERVER').array_get('HTTP_HOST')).str() +
		(rt.get_superglobal('_SERVER').array_get('REQUEST_URI')).str())
	mut var_user_logged_in := rt.call_function('is_user_logged_in', []rt.PhpVal{})
	mut var_classes := if rt.is_true(var_user_logged_in) { 'logged-in' } else { 'logged-out' }
	mut var_contents := rt.call_function('wp_loginout', [if rt.is_true(rt.new_bool(
		var_attributes.array_isset(rt.new_string('redirectToCurrent'))
		&& rt.is_true(var_attributes.array_get('redirectToCurrent'))))
	{
		var_current_url
	} else {
		rt.new_string('')
	}, rt.new_bool(false)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user_logged_in))))
		&& !(!rt.is_true(var_attributes.array_get('displayLoginAsForm')))))
	{
		// unsupported expression: Expr_AssignOp_Concat
		var_contents = rt.call_function('wp_login_form', [
			rt.create_array([rt.ArrayItem{ key: 'echo', val: false }]),
		])
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }]),
	])
	return '<div ' + var_wrapper_attributes.str() + '>' + var_contents.str() + '</div>'
}

fn register_block_core_loginout() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/loginout',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_loginout' },
		])])
}

pub fn init_wp_includes_blocks_loginout_php() {
	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_loginout')])
}
