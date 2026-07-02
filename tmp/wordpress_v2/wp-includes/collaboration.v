import rt

fn wp_is_collaboration_enabled() bool {
	return rt.is_true(wp_is_collaboration_allowed())
		&& rt.is_true((rt.call_function('get_option', [rt.new_string('wp_collaboration_enabled')])).to_bool())
}

fn wp_is_collaboration_allowed() rt.PhpVal {
	mut var_env_value := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_ALLOW_COLLABORATION'),
	])))))
	{
		var_env_value = rt.call_function('getenv', [
			rt.new_string('WP_ALLOW_COLLABORATION'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_env_value)) {
			rt.call_function('define', [rt.new_string('WP_ALLOW_COLLABORATION'),
				rt.new_bool(true)])
		} else {
			rt.call_function('define', [rt.new_string('WP_ALLOW_COLLABORATION'),
				rt.identical(rt.new_string('true'), var_env_value)])
		}
	}
	return rt.get_constant('WP_ALLOW_COLLABORATION')
}

fn wp_collaboration_inject_setting() {
	mut var_pagenow := rt.new_null()
	mut var_enabled := false
	if !(wp_is_collaboration_enabled()) {
		return
	}
	var_enabled = true
	if rt.is_true(rt.identical(rt.new_string('site-editor.php'), var_pagenow)) {
		var_enabled = false
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-core-data'),
		rt.new_string('window._wpCollaborationEnabled = ' +
			(rt.call_function('wp_json_encode', [rt.new_bool(var_enabled).clone()])).str() + ';'),
		rt.new_string('after')])
}

fn main() {
	defer {
		rt.shutdown()
	}
}
