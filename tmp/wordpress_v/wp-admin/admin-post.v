import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_ADMIN'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_ADMIN'),
			rt.new_bool(true)])
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'4')
	rt.call_function('send_origin_headers', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('admin_init')])
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get('action'),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [
		var_action.dup()])))))
	{
		rt.call_function('wp_die', [rt.new_string(''), rt.new_int(400)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		if !rt.is_true(var_action) {
			rt.call_function('do_action', [rt.new_string('admin_post_nopriv')])
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
				rt.new_string('admin_post_nopriv_${var_action.to_string()}'),
			])))))
			{
				rt.call_function('wp_die', [rt.new_string(''),
					rt.new_int(400)])
			}
			rt.call_function('do_action', [
				rt.new_string('admin_post_nopriv_${var_action.to_string()}'),
			])
		}
	} else {
		if !rt.is_true(var_action) {
			rt.call_function('do_action', [rt.new_string('admin_post')])
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
				rt.new_string('admin_post_${var_action.to_string()}'),
			])))))
			{
				rt.call_function('wp_die', [rt.new_string(''),
					rt.new_int(400)])
			}
			rt.call_function('do_action', [
				rt.new_string('admin_post_${var_action.to_string()}'),
			])
		}
	}
}
