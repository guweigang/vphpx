import rt

fn wp_enqueue_view_transitions_admin_css() {
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-view-transitions-admin')])
}

fn wp_get_view_transitions_admin_css() string {
	mut var_affix := if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
	mut var_path := rt.new_string(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/css/view-transitions${var_affix}.css')
	return (rt.call_function('file_get_contents', [var_path.dup()])).str()
}

pub fn init_wp_includes_view_transitions_php() {
}
