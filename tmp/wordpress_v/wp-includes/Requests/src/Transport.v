import rt

interface Transport {
	request(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	request_multiple(rt.PhpVal, rt.PhpVal) rt.PhpVal
	test(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_requests_src_transport_php() {
	mut var_url := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_data := rt.new_null()
	mut var_options := rt.new_null()
	mut var_requests := rt.new_null()
	mut var_capabilities := rt.new_null()
}
