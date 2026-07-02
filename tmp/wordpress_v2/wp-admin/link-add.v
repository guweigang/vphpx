import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_links'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to add links to this site.'),
			]),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Add Link')])
	mut var_parent_file := 'link-manager.php'
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		]) } else { rt.new_string('') }
	mut var_cat_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('cat_id')))) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('cat_id')),
		]) } else { rt.new_int(0) }
	mut var_link_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('link_id')))) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('link_id')),
		]) } else { rt.new_int(0) }
	rt.call_function('wp_enqueue_script', [rt.new_string('link')])
	rt.call_function('wp_enqueue_script', [rt.new_string('xfn')])
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
	}
	mut var_link := rt.call_function('get_default_link_to_edit', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-link-form.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
