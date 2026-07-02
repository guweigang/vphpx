import rt

interface Response {
	get_permanent_uri() rt.PhpVal
	get_final_requested_uri() rt.PhpVal
	get_status_code() rt.PhpVal
	get_headers() rt.PhpVal
	has_header(rt.PhpVal) rt.PhpVal
	get_header(rt.PhpVal) rt.PhpVal
	with_header(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_header_line(rt.PhpVal) rt.PhpVal
	get_body_content() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
}
