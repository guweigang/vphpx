import rt

interface Auth {
	register(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_requests_src_auth_php() {
	mut var_hooks := rt.new_null()
}
