import rt

interface Proxy {
	register(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_requests_src_proxy_php() {
	mut var_hooks := rt.new_null()
}
