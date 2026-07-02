import rt

struct Class_WC_HTTPS {
	rt.PhpObjectBase
}

fn Class_WC_HTTPS.init() {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_force_ssl_checkout')])))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		mut var_filters := ['post_thumbnail_html', 'wp_get_attachment_image_attributes',
			'wp_get_attachment_url', 'option_stylesheet_url', 'option_template_url',
			'script_loader_src', 'style_loader_src', 'template_directory_uri',
			'stylesheet_directory_uri', 'site_url']
		for var_filter in var_filters {
			rt.call_function('add_filter', [rt.new_string(filter),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'force_https_url' }]),
				rt.new_int(999)])
		}
		rt.call_function('add_filter', [rt.new_string('page_link'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'force_https_page_link' }]),
			rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_action', [rt.new_string('template_redirect'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'force_https_template_redirect' }])])
		if rt.is_true(rt.equal(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_unforce_ssl_checkout'),
		])))
		{
			rt.call_function('add_action', [rt.new_string('template_redirect'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'unforce_https_template_redirect' }])])
		}
	}
	rt.call_function('add_action', [rt.new_string('http_api_curl'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'http_api_curl' }]),
		rt.new_int(10), rt.new_int(3)])
}

fn Class_WC_HTTPS.force_https_url(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(var_content_mutated.clone().is_array())) {
			var_content_mutated = rt.call_function('array_map', [
				rt.new_string('WC_HTTPS::force_https_url'),
				var_content_mutated.clone(),
			])
		} else {
			var_content_mutated = rt.call_function('str_replace', [
				rt.new_string('http:'),
				rt.new_string('https:'),
				rt.new_string(var_content_mutated.str()),
			])
		}
	}
	return var_content_mutated.clone()
}

fn Class_WC_HTTPS.force_https_page_link(var_link rt.PhpVal, var_page_id rt.PhpVal) rt.PhpVal {
	mut var_link_mutated := var_link
	if rt.is_true(rt.call_function('in_array', [var_page_id.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('get_option', [
				rt.new_string('woocommerce_checkout_page_id'),
			]) },
			rt.ArrayItem{ key: none, val: rt.call_function('get_option', [
				rt.new_string('woocommerce_myaccount_page_id'),
			]) },
		])]))
	{
		var_link_mutated = rt.call_function('str_replace', [rt.new_string('http:'),
			rt.new_string('https:'), var_link_mutated.clone()])
	} else if
		rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_unforce_ssl_checkout')])))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_site_is_https', []rt.PhpVal{}))))) {
		var_link_mutated = rt.call_function('str_replace', [rt.new_string('https:'),
			rt.new_string('http:'), var_link_mutated.clone()])
	}
	return var_link_mutated.clone()
}

fn Class_WC_HTTPS.force_https_template_redirect() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_force_ssl_checkout'), rt.new_bool(false)])) {
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
			rt.new_string('http'),
		])))
		{
			rt.call_function('wp_safe_redirect', [
				rt.call_function('preg_replace', [rt.new_string('|^http://|'),
					rt.new_string('https://'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
			])
			exit(0)
		} else {
			rt.call_function('wp_safe_redirect', [
				rt.new_string('https://' +
					(if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_FORWARDED_HOST')))) { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_FORWARDED_HOST')) } else { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST')) }).str() +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
			])
			exit(0)
		}
	}
}

fn Class_WC_HTTPS.unforce_https_template_redirect() {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_customize_preview')]))
		&& rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_site_is_https', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
		&& rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_unforce_ssl_checkout'), rt.new_bool(true)])) {
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
			rt.new_string('http'),
		])))
		{
			rt.call_function('wp_safe_redirect', [
				rt.call_function('preg_replace', [rt.new_string('|^https://|'),
					rt.new_string('http://'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
			])
			exit(0)
		} else {
			rt.call_function('wp_safe_redirect', [
				rt.new_string('http://' +
					(if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_FORWARDED_HOST')))) { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_FORWARDED_HOST')) } else { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST')) }).str() +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
			])
			exit(0)
		}
	}
}

fn Class_WC_HTTPS.http_api_curl(var_handle rt.PhpVal, var_r rt.PhpVal, var_url rt.PhpVal) {
	if rt.is_true(rt.call_function('strstr', [var_url.clone(), rt.new_string('https://')]))
		&& rt.is_true(rt.call_function('strstr', [var_url.clone(), rt.new_string('.paypal.com/nvp')]))
		|| rt.is_true(rt.call_function('strstr', [var_url.clone(), rt.new_string('.paypal.com/cgi-bin/webscr')])) {
		rt.call_function('curl_setopt', [var_handle.clone(), rt.get_constant('CURLOPT_SSLVERSION'),
			rt.new_int(6)])
	}
}

fn create_wc_https(_args ...rt.PhpVal) &Class_WC_HTTPS {
	mut obj := &Class_WC_HTTPS{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_HTTPS) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_HTTPS.init()
			return rt.new_null()
		}
		'force_https_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_HTTPS.force_https_url(dispatch_arg_0)
		}
		'force_https_page_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_HTTPS.force_https_page_link(dispatch_arg_0, dispatch_arg_1)
		}
		'force_https_template_redirect' {
			Class_WC_HTTPS.force_https_template_redirect()
			return rt.new_null()
		}
		'unforce_https_template_redirect' {
			Class_WC_HTTPS.unforce_https_template_redirect()
			return rt.new_null()
		}
		'http_api_curl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_HTTPS.http_api_curl(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_HTTPS) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_HTTPS) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	Class_WC_HTTPS.init()
}
