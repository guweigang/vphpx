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
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Multisite support is not enabled.')])])
	}
	mut var_redirect_network_admin_request := rt.new_bool(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	var_redirect_network_admin_request = rt.call_function('apply_filters', [rt.new_string('redirect_network_admin_request'), var_redirect_network_admin_request.dup()])
	if rt.is_true(var_redirect_network_admin_request) {
		rt.call_function('wp_redirect', [rt.call_function('network_admin_url', []rt.PhpVal{})])
		// unsupported expression: Expr_Exit
	}
	var_redirect_network_admin_request = rt.new_null()
}
