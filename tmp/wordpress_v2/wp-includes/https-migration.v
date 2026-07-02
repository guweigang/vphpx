import rt

fn wp_should_replace_insecure_home_url() rt.PhpVal {
	mut var_should_replace_insecure_home_url := false
	var_should_replace_insecure_home_url =
		rt.is_true(rt.call_function('wp_is_using_https', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('get_option', [rt.new_string('https_migration_required')]))
		&& rt.is_true(rt.identical(rt.call_function('wp_parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')]), rt.call_function('wp_parse_url', [rt.call_function('site_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])))
	return rt.call_function('apply_filters', [
		rt.new_string('wp_should_replace_insecure_home_url'),
		rt.new_bool(var_should_replace_insecure_home_url).clone(),
	])
}

fn wp_replace_insecure_home_url(var_content rt.PhpVal) rt.PhpVal {
	mut var_https_url := rt.new_null()
	mut var_http_url := rt.new_null()
	mut var_escaped_https_url := rt.new_null()
	mut var_escaped_http_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_should_replace_insecure_home_url())))) {
		return var_content.clone()
	}
	var_https_url = rt.call_function('home_url', [rt.new_string(''),
		rt.new_string('https')])
	var_http_url = rt.call_function('str_replace', [rt.new_string('https://'),
		rt.new_string('http://'), var_https_url.clone()])
	var_escaped_https_url = rt.call_function('str_replace', [
		rt.new_string('/'), rt.new_string('\\/'), var_https_url.clone()])
	var_escaped_http_url = rt.call_function('str_replace', [rt.new_string('/'),
		rt.new_string('\\/'), var_http_url.clone()])
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_http_url },
			rt.ArrayItem{ key: none, val: var_escaped_http_url }]),
		rt.create_array([rt.ArrayItem{ key: none, val: var_https_url },
			rt.ArrayItem{ key: none, val: var_escaped_https_url }]),
		var_content.clone(),
	])
}

fn wp_update_urls_to_https() bool {
	mut var_orig_home := rt.new_null()
	mut var_orig_siteurl := rt.new_null()
	mut var_home := rt.new_null()
	mut var_siteurl := rt.new_null()
	var_orig_home = rt.call_function('get_option', [rt.new_string('home')])
	var_orig_siteurl = rt.call_function('get_option', [rt.new_string('siteurl')])
	var_home = rt.call_function('str_replace', [rt.new_string('http://'),
		rt.new_string('https://'), var_orig_home.clone()])
	var_siteurl = rt.call_function('str_replace', [rt.new_string('http://'),
		rt.new_string('https://'), var_orig_siteurl.clone()])
	rt.call_function('update_option', [rt.new_string('home'),
		var_home.clone()])
	rt.call_function('update_option', [rt.new_string('siteurl'),
		var_siteurl.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_using_https', []rt.PhpVal{}))))) {
		rt.call_function('update_option', [rt.new_string('home'),
			var_orig_home.clone()])
		rt.call_function('update_option', [rt.new_string('siteurl'),
			var_orig_siteurl.clone()])
		return false
	}
	return true
}

fn wp_update_https_migration_required(var_old_url rt.PhpVal, var_new_url rt.PhpVal) {
	mut var_https_migration_required := false
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('untrailingslashit', [
		rt.new_string(var_old_url.str()),
	]), rt.call_function('str_replace', [rt.new_string('https://'),
		rt.new_string('http://'),
		rt.call_function('untrailingslashit', [
			rt.new_string(var_new_url.str()),
		])])))))
	{
		rt.call_function('delete_option', [rt.new_string('https_migration_required')])
		return
	}
	var_https_migration_required = if rt.is_true(rt.call_function('get_option', [
		rt.new_string('fresh_site'),
	]))
	{ false } else { true }
	rt.call_function('update_option', [rt.new_string('https_migration_required'),
		rt.new_bool(var_https_migration_required).clone()])
}

fn main() {
	defer {
		rt.shutdown()
	}
}
