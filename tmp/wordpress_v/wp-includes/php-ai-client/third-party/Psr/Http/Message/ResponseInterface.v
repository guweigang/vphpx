import rt

interface ResponseInterface {
	getstatuscode() rt.PhpVal
	withstatus(rt.PhpVal, rt.PhpVal) rt.PhpVal
	getreasonphrase() rt.PhpVal
}

pub fn init_wp_includes_php_ai_client_third_party_psr_http_message_responseinterface_php() {
	mut var_code := rt.new_null()
	mut var_reasonPhrase := rt.new_null()
}
