import rt

interface UriInterface {
	getscheme() rt.PhpVal
	getauthority() rt.PhpVal
	getuserinfo() rt.PhpVal
	gethost() rt.PhpVal
	getport() rt.PhpVal
	getpath() rt.PhpVal
	getquery() rt.PhpVal
	getfragment() rt.PhpVal
	withscheme(rt.PhpVal) rt.PhpVal
	withuserinfo(rt.PhpVal, rt.PhpVal) rt.PhpVal
	withhost(rt.PhpVal) rt.PhpVal
	withport(rt.PhpVal) rt.PhpVal
	withpath(rt.PhpVal) rt.PhpVal
	withquery(rt.PhpVal) rt.PhpVal
	withfragment(rt.PhpVal) rt.PhpVal
	magic_tostring() rt.PhpVal
}

pub fn init_wp_includes_php_ai_client_third_party_psr_http_message_uriinterface_php() {
	mut var_scheme := rt.new_null()
	mut var_user := rt.new_null()
	mut var_password := rt.new_null()
	mut var_host := rt.new_null()
	mut var_port := rt.new_null()
	mut var_path := rt.new_null()
	mut var_query := rt.new_null()
	mut var_fragment := rt.new_null()
}
