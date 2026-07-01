import rt

interface StreamFactoryInterface {
	createstream(rt.PhpVal) rt.PhpVal
	createstreamfromfile(rt.PhpVal, rt.PhpVal) rt.PhpVal
	createstreamfromresource(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_php_ai_client_third_party_psr_http_message_streamfactoryinterface_php() {
	mut var_content := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_mode := rt.new_null()
	mut var_resource := rt.new_null()
}
