import rt

interface UploadedFileInterface {
	getstream() rt.PhpVal
	moveto(rt.PhpVal) rt.PhpVal
	getsize() rt.PhpVal
	geterror() rt.PhpVal
	getclientfilename() rt.PhpVal
	getclientmediatype() rt.PhpVal
}

pub fn init_wp_includes_php_ai_client_third_party_psr_http_message_uploadedfileinterface_php() {
	mut var_targetPath := rt.new_null()
}
