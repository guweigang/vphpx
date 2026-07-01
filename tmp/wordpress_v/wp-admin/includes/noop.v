import rt

fn __() {
}

fn _x() {
}

fn add_filter() {
}

fn has_filter() bool {
	return false
}

fn esc_attr() {
}

fn apply_filters() {
}

fn get_option() {
}

fn is_lighttpd_before_150() {
}

fn add_action() {
}

fn did_action() {
}

fn do_action_ref_array() {
}

fn get_bloginfo() {
}

fn is_admin() bool {
	return true
}

fn site_url() {
}

fn admin_url() {
}

fn home_url() {
}

fn includes_url() {
}

fn wp_guess_url() {
}

fn get_file(var_path rt.PhpVal) string {
	var_path = rt.call_function('realpath', [var_path.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_path))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_path.dup()])))))))
	{
		return ''
	}
	return (rt.call_function('file_get_contents', [var_path.dup()])).str()
}

pub fn init_wp_admin_includes_noop_php() {
}
