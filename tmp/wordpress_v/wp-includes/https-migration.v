import rt

fn wp_should_replace_insecure_home_url() rt.PhpVal {
	mut var_should_replace_insecure_home_url := rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_using_https', []rt.PhpVal{})) && rt.is_true(rt.call_function('get_option', [rt.new_string('https_migration_required')])))) && rt.is_true(rt.identical(rt.call_function('wp_parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')]), rt.call_function('wp_parse_url', [rt.call_function('site_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])))
	return rt.call_function('apply_filters', [rt.new_string('wp_should_replace_insecure_home_url'), rt.new_bool(var_should_replace_insecure_home_url).dup()])
}

fn wp_replace_insecure_home_url(var_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_should_replace_insecure_home_url())))) {
		return var_content.dup()
	}
	mut var_https_url := rt.call_function('home_url', [rt.new_string(''), rt.new_string('https')])
	mut var_http_url := rt.call_function('str_replace', [rt.new_string('https://'), rt.new_string('http://'), var_https_url.dup()])
	mut var_escaped_https_url := rt.call_function('str_replace', [rt.new_string('/'), rt.new_string('\\/'), var_https_url.dup()])
	mut var_escaped_http_url := rt.call_function('str_replace', [rt.new_string('/'), rt.new_string('\\/'), var_http_url.dup()])
	return rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: var_http_url }, rt.ArrayItem{ key: none, val: var_escaped_http_url }]), rt.create_array([rt.ArrayItem{ key: none, val: var_https_url }, rt.ArrayItem{ key: none, val: var_escaped_https_url }]), var_content.dup()])
}

fn wp_update_urls_to_https() bool {
	mut var_orig_home := rt.call_function('get_option', [rt.new_string('home')])
	mut var_orig_siteurl := rt.call_function('get_option', [rt.new_string('siteurl')])
	mut var_home := rt.call_function('str_replace', [rt.new_string('http://'), rt.new_string('https://'), var_orig_home.dup()])
	mut var_siteurl := rt.call_function('str_replace', [rt.new_string('http://'), rt.new_string('https://'), var_orig_siteurl.dup()])
	rt.call_function('update_option', [rt.new_string('home'), var_home.dup()])
	rt.call_function('update_option', [rt.new_string('siteurl'), var_siteurl.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_using_https', []rt.PhpVal{}))))) {
		rt.call_function('update_option', [rt.new_string('home'), var_orig_home.dup()])
		rt.call_function('update_option', [rt.new_string('siteurl'), var_orig_siteurl.dup()])
		return false
	}
	return true
}

fn wp_update_https_migration_required(var_old_url rt.PhpVal, var_new_url rt.PhpVal) {
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('delete_option', [rt.new_string('https_migration_required')])
		return rt.new_null()
	}
	mut var_https_migration_required := if rt.is_true(rt.call_function('get_option', [rt.new_string('fresh_site')])) { false } else { true }
	rt.call_function('update_option', [rt.new_string('https_migration_required'), rt.new_bool(var_https_migration_required).dup()])
}



pub fn init_wp_includes_https_migration_php() {
}
