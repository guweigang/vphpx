import rt

fn wp_is_collaboration_enabled() bool {
	return rt.is_true(wp_is_collaboration_allowed()) && rt.is_true(// unsupported expression: Expr_Cast_Bool)
}

fn wp_is_collaboration_allowed() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_ALLOW_COLLABORATION')]))))) {
		mut var_env_value := rt.call_function('getenv', [rt.new_string('WP_ALLOW_COLLABORATION')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_env_value)) {
			rt.call_function('define', [rt.new_string('WP_ALLOW_COLLABORATION'), rt.new_bool(true)])
		} else {
			rt.call_function('define', [rt.new_string('WP_ALLOW_COLLABORATION'), rt.identical(rt.new_string('true'), var_env_value)])
		}
	}
	return rt.get_constant('WP_ALLOW_COLLABORATION')
}

fn wp_collaboration_inject_setting() {
	mut var_pagenow := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(wp_is_collaboration_enabled()) {
		return rt.new_null()
	}
	mut var_enabled := true
	if rt.is_true(rt.identical(rt.new_string('site-editor.php'), var_pagenow)) {
		var_enabled = false
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-core-data'), 'window._wpCollaborationEnabled = ' + (rt.call_function('wp_json_encode', [rt.new_bool(var_enabled).dup()])).str() + ';', rt.new_string('after')])
}



pub fn init_wp_includes_collaboration_php() {
}
