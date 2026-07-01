import rt
import crypto.sha1

pub fn Class_WC_Download_Handler.track_download_callback() string {
	return 'track_partial_download'
}
struct Class_WC_Download_Handler {
	rt.PhpObjectBase
}

fn Class_WC_Download_Handler.init()  {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('download_file')) && rt.get_superglobal('_GET').array_isset(rt.new_string('order')) && rt.get_superglobal('_GET').array_isset(rt.new_string('email')) || rt.get_superglobal('_GET').array_isset(rt.new_string('uid')) {
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'download_product' }])])
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_download_file_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'download_file_redirect' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_download_file_xsendfile'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'download_file_xsendfile' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_download_file_force'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'download_file_force' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [Class_WC_Download_Handler.track_download_callback(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'track_download' }]), rt.new_int(10), rt.new_int(3)])
}

fn Class_WC_Download_Handler.download_product()  {
	mut var_product_id := rt.call_function('absint', [rt.get_superglobal('_GET').array_get('download_file')])
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	mut var_downloads := if rt.is_true(var_product) { rt.call_method(var_product, 'get_downloads', []rt.PhpVal{}) } else { rt.new_array() }
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download'))
	mut var_key := if !rt.is_true(rt.get_superglobal('_GET').array_get('key')) { rt.new_string('') } else { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('key')])]) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || !rt.is_true(var_key))) || !rt.is_true(rt.get_superglobal('_GET').array_get('order')))) || !(var_downloads.array_isset(var_key)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_downloads.array_get(var_key), 'get_enabled', []rt.PhpVal{}))))))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('Invalid download link.'), rt.new_string('woocommerce')])).str())
	}
	if !rt.is_true(rt.get_superglobal('_GET').array_get('email')) && !rt.is_true(rt.get_superglobal('_GET').array_get('uid')) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('Invalid download link.'), rt.new_string('woocommerce')])).str())
	}
	mut var_order_id := rt.call_function('wc_get_order_id_by_order_key', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('order')])])])
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('email')) {
		mut var_email_address := rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('email')])
		// unsupported statement: Stmt_Nop
	} else {
		var_email_address = if rt.is_true(rt.call_function('is_a', [var_order.dup(), rt.new_string('WC_Order')])) { rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}) } else { rt.new_null() }
		mut var_email_hash := if rt.is_true(rt.call_function('function_exists', [rt.new_string('hash')])) { rt.call_function('hash', [rt.new_string('sha256'), var_email_address.dup()]) } else { rt.new_string(sha1.hexhash(var_email_address.dup().to_string())) }
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_email_address.dup().is_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('uid')]), var_email_hash.dup()]))))))) {
			Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('Invalid download link.'), rt.new_string('woocommerce')])).str())
		}
	}
	mut var_download_ids := rt.call_method(var_data_store, 'get_downloads', [rt.create_array([rt.ArrayItem{ key: 'user_email', val: rt.call_function('sanitize_email', [rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('+'), var_email_address.dup()])]) }, rt.ArrayItem{ key: 'order_key', val: rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('order')])]) }, rt.ArrayItem{ key: 'product_id', val: var_product_id }, rt.ArrayItem{ key: 'download_id', val: rt.call_function('wc_clean', [rt.call_function('preg_replace', [rt.new_string('/\\s+/'), rt.new_string(' '), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('key')])])]) }, rt.ArrayItem{ key: 'orderby', val: 'downloads_remaining' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'limit', val: 1 }, rt.ArrayItem{ key: 'return', val: 'ids' }])])
	if !rt.is_true(var_download_ids) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('Invalid download link.'), rt.new_string('woocommerce')])).str())
	}
	mut var_download := create_wc_customer_download(rt.call_function('current', [var_download_ids.dup()]))
	mut var_file_path := rt.call_function('apply_filters', [rt.new_string('woocommerce_download_product_filepath'), rt.call_method(var_product, 'get_file_download_path', [var_download.get_download_id()]), var_email_address.dup(), var_order.dup(), var_product.dup(), var_download])
	mut var_parsed_file_path := Class_WC_Download_Handler.parse_file_path(var_file_path.dup())
	mut var_download_range := Class_WC_Download_Handler.get_download_range(rt.call_function('filesize', [var_parsed_file_path.array_get('file_path')]))
	Class_WC_Download_Handler.check_order_is_valid(rt.new_object('WC_Customer_Download', []string{}, var_download))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_download_range.array_get('is_range_request'))))) {
		Class_WC_Download_Handler.check_downloads_remaining(rt.new_object('WC_Customer_Download', []string{}, var_download))
	}
	Class_WC_Download_Handler.check_download_expiry(rt.new_object('WC_Customer_Download', []string{}, var_download))
	Class_WC_Download_Handler.check_download_login_required(rt.new_object('WC_Customer_Download', []string{}, var_download))
	rt.call_function('do_action', [rt.new_string('woocommerce_download_product'), var_download.get_user_email(), var_download.get_order_key(), var_download.get_product_id(), var_download.get_user_id(), var_download.get_download_id(), var_download.get_order_id()])
	var_download.save()
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_ip_address := fn () rt.PhpVal { mut temp := Class_WC_Geolocation{}; return temp.get_ip_address() }()
	Class_WC_Download_Handler.track_download(rt.new_object('WC_Customer_Download', []string{}, var_download), if rt.is_true(rt.greater(var_current_user_id, rt.new_int(0))) { var_current_user_id } else { rt.new_null() }, (if !(!rt.is_true(var_ip_address)) { var_ip_address } else { rt.new_null() }).to_bool(), var_download_range.array_get('is_range_request'))
	Class_WC_Download_Handler.download(var_file_path.dup(), var_download.get_product_id())
}

fn Class_WC_Download_Handler.check_order_is_valid(var_download rt.PhpVal)  {
	mut var_download_mutated := var_download
	if rt.is_true(var_download_mutated.get_order_id()) {
		mut var_order := rt.call_function('wc_get_order', [var_download_mutated.get_order_id()])
		if rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{}))))))) {
			Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('Invalid order.'), rt.new_string('woocommerce')])).str(), '', rt.new_int(403))
		}
	}
}

fn Class_WC_Download_Handler.check_downloads_remaining(var_download rt.PhpVal)  {
	mut var_download_mutated := var_download
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.greater_equal(rt.new_int(0), var_download_mutated.get_downloads_remaining())))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('Sorry, you have reached your download limit for this file'), rt.new_string('woocommerce')])).str(), '', rt.new_int(403))
	}
}

fn Class_WC_Download_Handler.check_download_expiry(var_download rt.PhpVal)  {
	mut var_download_mutated := var_download
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_download_mutated.get_access_expires().is_null()))))) && rt.is_true(rt.less(rt.call_method(var_download_mutated.get_access_expires(), 'getTimestamp', []rt.PhpVal{}), rt.call_function('strtotime', [rt.new_string('midnight'), rt.call_function('time', []rt.PhpVal{})]))))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('Sorry, this download has expired'), rt.new_string('woocommerce')])).str(), '', rt.new_int(403))
	}
}

fn Class_WC_Download_Handler.check_download_login_required(var_download rt.PhpVal)  {
	mut var_download_mutated := var_download
	if rt.is_true(rt.new_bool(rt.is_true(var_download_mutated.get_user_id()) && rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_downloads_require_login')]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			if rt.is_true(rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])) {
				rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('wc_error'), rt.call_function('rawurlencode', [rt.call_function('__', [rt.new_string('You must be logged in to download files.'), rt.new_string('woocommerce')])]), rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])])
				// unsupported expression: Expr_Exit
			} else {
				Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('You must be logged in to download files.'), rt.new_string('woocommerce')])).str() + ' <a href="' + (rt.call_function('esc_url', [rt.call_function('wp_login_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])])).str() + '" class="wc-forward">' + (rt.call_function('__', [rt.new_string('Login'), rt.new_string('woocommerce')])).str() + '</a>', (rt.call_function('__', [rt.new_string('Log in to Download Files'), rt.new_string('woocommerce')])).to_i64(), rt.new_int(403))
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('download_file'), var_download_mutated]))))) {
			Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('This is not your download link.'), rt.new_string('woocommerce')])).str(), '', rt.new_int(403))
		}
	}
}

fn Class_WC_Download_Handler.count_download(var_download_data rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Download_Handler::count_download'), rt.new_string('4.4.0'), rt.new_string('')])
}

fn Class_WC_Download_Handler.download(var_file_path rt.PhpVal, var_product_id rt.PhpVal)  {
	mut var_file_path_mutated := var_file_path
	mut var_product_id_mutated := var_product_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file_path_mutated)))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [rt.new_string('No file defined'), rt.new_string('woocommerce')])).str())
	}
	mut var_filename := rt.call_function('basename', [var_file_path_mutated.dup()])
	if rt.is_true(rt.call_function('strstr', [var_filename.dup(), rt.new_string('?')])) {
		var_filename = rt.call_function('current', [rt.call_function('explode', [rt.new_string('?'), var_filename.dup()])])
	}
	var_filename = rt.call_function('apply_filters', [rt.new_string('woocommerce_file_download_filename'), var_filename.dup(), var_product_id_mutated.dup()])
	mut var_file_download_method := rt.call_function('apply_filters', [rt.new_string('woocommerce_file_download_method'), rt.call_function('get_option', [rt.new_string('woocommerce_file_download_method'), rt.new_string('force')]), var_product_id_mutated.dup(), var_file_path_mutated.dup()])
	rt.call_function('add_action', [rt.new_string('nocache_headers'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'ie_nocache_headers_fix' }])])
	rt.call_function('do_action', ['woocommerce_download_file_' + (var_file_download_method).str(), var_file_path_mutated.dup(), var_filename.dup()])
}

fn Class_WC_Download_Handler.download_file_redirect(var_file_path rt.PhpVal, filename string)  {
	mut var_file_path_mutated := var_file_path
	mut filename_mutated := filename
	rt.call_function('header', ['Location: ' + (var_file_path_mutated).str()])
	// unsupported expression: Expr_Exit
}

fn Class_WC_Download_Handler.parse_file_path(var_file_path rt.PhpVal) rt.PhpVal {
	mut var_file_path_mutated := var_file_path
	mut var_wp_uploads := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	mut var_wp_uploads_dir := var_wp_uploads.array_get('basedir')
	mut var_wp_uploads_url := var_wp_uploads.array_get('baseurl')
	mut var_replacements := rt.create_array([rt.ArrayItem{ key: var_wp_uploads_url, val: var_wp_uploads_dir }, rt.ArrayItem{ key: rt.call_function('network_site_url', [rt.new_string('/'), rt.new_string('https')]), val: rt.get_constant('ABSPATH') }, rt.ArrayItem{ key: rt.call_function('str_replace', [rt.new_string('https:'), rt.new_string('http:'), rt.call_function('network_site_url', [rt.new_string('/'), rt.new_string('http')])]), val: rt.get_constant('ABSPATH') }, rt.ArrayItem{ key: rt.call_function('site_url', [rt.new_string('/'), rt.new_string('https')]), val: rt.get_constant('ABSPATH') }, rt.ArrayItem{ key: rt.call_function('str_replace', [rt.new_string('https:'), rt.new_string('http:'), rt.call_function('site_url', [rt.new_string('/'), rt.new_string('http')])]), val: rt.get_constant('ABSPATH') }])
	mut var_count := rt.new_int(rt.new_int(0))
	var_file_path_mutated = rt.call_function('str_replace', [rt.func_array_keys(var_replacements.dup()), rt.call_function('array_values', [var_replacements.dup()]), var_file_path_mutated.dup(), var_count.dup()])
	mut var_parsed_file_path := rt.call_function('wp_parse_url', [var_file_path_mutated.dup()])
	mut var_remote_file := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_count)) || rt.is_true(rt.identical(rt.new_int(0), var_count))))
	if rt.is_true(rt.identical(rt.new_string('//'), rt.call_function('substr', [var_file_path_mutated.dup(), rt.new_int(0), rt.new_int(2)]))) {
		var_file_path_mutated = rt.new_string(if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https:' } else { 'http:' } + (var_file_path_mutated).str())
		return rt.create_array([rt.ArrayItem{ key: 'remote_file', val: true }, rt.ArrayItem{ key: 'file_path', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_download_parse_remote_file_path'), var_file_path_mutated.dup()]) }])
	}
	if rt.is_true(rt.call_function('file_exists', [rt.concat(rt.get_constant('ABSPATH'), var_file_path_mutated)])) {
		var_remote_file = rt.new_bool(rt.new_bool(false))
		var_file_path_mutated = rt.new_string(rt.concat(rt.get_constant('ABSPATH'), var_file_path_mutated))
	} else if rt.is_true(rt.identical(rt.new_string('/wp-content'), rt.call_function('substr', [var_file_path_mutated.dup(), rt.new_int(0), rt.new_int(11)]))) {
		var_remote_file = rt.new_bool(rt.new_bool(false))
		var_file_path_mutated = rt.call_function('realpath', [rt.concat(rt.get_constant('WP_CONTENT_DIR'), rt.call_function('substr', [var_file_path_mutated.dup(), rt.new_int(11)]))])
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_parsed_file_path.array_isset(rt.new_string('scheme'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_parsed_file_path.array_get('scheme'), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }, rt.ArrayItem{ key: none, val: 'ftp' }]), rt.new_bool(true)]))))))) && var_parsed_file_path.array_isset(rt.new_string('path')))) {
		var_remote_file = rt.new_bool(rt.new_bool(false))
		var_file_path_mutated = var_parsed_file_path.array_get('path')
	}
	return rt.create_array([rt.ArrayItem{ key: 'remote_file', val: var_remote_file }, rt.ArrayItem{ key: 'file_path', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_download_parse_file_path'), var_file_path_mutated.dup(), var_remote_file.dup()]) }])
}

fn Class_WC_Download_Handler.download_file_xsendfile(var_file_path rt.PhpVal, var_filename rt.PhpVal)  {
	mut var_file_path_mutated := var_file_path
	mut var_filename_mutated := var_filename
	mut var_parsed_file_path := Class_WC_Download_Handler.parse_file_path(var_file_path_mutated.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_parsed_file_path.array_get('remote_file')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_use_xsendfile_for_remote'), rt.new_bool(false)]))))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_download_file_force'), var_file_path_mutated.dup(), var_filename_mutated.dup()])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('apache_get_modules')])) && rt.is_true(rt.call_function('in_array', [rt.new_string('mod_xsendfile'), rt.call_function('apache_get_modules', []rt.PhpVal{}), rt.new_bool(true)])))) {
		Class_WC_Download_Handler.download_headers(var_parsed_file_path.array_get('file_path'), var_filename_mutated.dup())
		mut var_filepath := rt.call_function('apply_filters', [rt.new_string('woocommerce_download_file_xsendfile_file_path'), var_parsed_file_path.array_get('file_path'), var_file_path_mutated.dup(), var_filename_mutated.dup(), var_parsed_file_path.dup()])
		rt.call_function('header', ['X-Sendfile: ' + (var_filepath).str()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.call_function('stristr', [rt.call_function('getenv', [rt.new_string('SERVER_SOFTWARE')]), rt.new_string('lighttpd')])) {
		Class_WC_Download_Handler.download_headers(var_parsed_file_path.array_get('file_path'), var_filename_mutated.dup())
		var_filepath = rt.call_function('apply_filters', [rt.new_string('woocommerce_download_file_xsendfile_lighttpd_file_path'), var_parsed_file_path.array_get('file_path'), var_file_path_mutated.dup(), var_filename_mutated.dup(), var_parsed_file_path.dup()])
		rt.call_function('header', ['X-Lighttpd-Sendfile: ' + (var_filepath).str()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('stristr', [rt.call_function('getenv', [rt.new_string('SERVER_SOFTWARE')]), rt.new_string('nginx')])) || rt.is_true(rt.call_function('stristr', [rt.call_function('getenv', [rt.new_string('SERVER_SOFTWARE')]), rt.new_string('cherokee')])))) {
		Class_WC_Download_Handler.download_headers(var_parsed_file_path.array_get('file_path'), var_filename_mutated.dup())
		mut var_xsendfile_path := rt.new_string(rt.new_string(rt.call_function('preg_replace', ['`^' + (rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('getcwd', []rt.PhpVal{})])).str() + '`', rt.new_string(''), var_parsed_file_path.array_get('file_path')]).to_string().trim_space()))
		var_xsendfile_path = rt.call_function('apply_filters', [rt.new_string('woocommerce_download_file_xsendfile_x_accel_redirect_file_path'), var_xsendfile_path.dup(), var_file_path_mutated.dup(), var_filename_mutated.dup(), var_parsed_file_path.dup()])
		rt.call_function('header', [rt.new_string("X-Accel-Redirect: /${var_xsendfile_path.to_string()}")])
		// unsupported expression: Expr_Exit
	}
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s could not be served using the X-Accel-Redirect/X-Sendfile method. A Force Download will be used instead.'), rt.new_string('woocommerce')]), var_file_path_mutated.dup()])])
	Class_WC_Download_Handler.download_file_force(var_file_path_mutated.dup(), var_filename_mutated.dup())
}

fn Class_WC_Download_Handler.get_download_range(var_file_size rt.PhpVal) rt.PhpVal {
	mut var_file_size_mutated := var_file_size
	mut var_start := rt.new_int(rt.new_int(0))
	mut var_download_range := rt.create_array([rt.ArrayItem{ key: 'start', val: var_start }, rt.ArrayItem{ key: 'is_range_valid', val: false }, rt.ArrayItem{ key: 'is_range_request', val: false }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file_size_mutated)))) {
		return var_download_range.dup()
	}
	mut var_end := rt.sub(var_file_size_mutated, rt.new_int(1))
	var_download_range.array_set('length', var_file_size_mutated.dup())
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_RANGE')) {
		mut var_http_range := rt.call_function('sanitize_text_field', [])
		.array_set(, )
		
	}
	return .dup()
}

fn Class_WC_Download_Handler.download_file_force(var_file_path rt.PhpVal, var_filename rt.PhpVal)  {
	mut var_file_path_mutated := var_file_path
	mut var_filename_mutated := var_filename
}

fn Class_WC_Download_Handler.get_download_content_type(var_file_path rt.PhpVal) rt.PhpVal {
	mut var_file_path_mutated := var_file_path
}

fn Class_WC_Download_Handler.download_headers(var_file_path rt.PhpVal, var_filename rt.PhpVal, var_download_range rt.PhpVal)  {
	mut var_file_path_mutated := var_file_path
	mut var_filename_mutated := var_filename
	mut var_download_range_mutated := var_download_range
}

fn Class_WC_Download_Handler.check_server_config()  {
}

fn Class_WC_Download_Handler.clean_buffers()  {
}

fn Class_WC_Download_Handler.get_content_disposition() string {
}

fn Class_WC_Download_Handler.readfile_chunked(var_file rt.PhpVal, start i64, length i64) bool {
	mut start_mutated := start
	mut length_mutated := length
	return false
}

fn Class_WC_Download_Handler.ie_nocache_headers_fix(var_headers rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_headers_mutated := var_headers
}

fn Class_WC_Download_Handler.download_error(var_message rt.PhpVal, title string, status i64)  {
}

fn Class_WC_Download_Handler.track_download(var_download rt.PhpVal, var_user_id rt.PhpVal, var_user_ip_address rt.PhpVal, defer bool)  {
	mut var_download_mutated := var_download
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Customer_Download {
	rt.PhpObjectBase
}

struct Class_WC_Geolocation {
	rt.PhpObjectBase
}

fn create_wc_download_handler() &Class_WC_Download_Handler {
	mut obj := &Class_WC_Download_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer_download() &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_geolocation() &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Download_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Download_Handler.init()
			return rt.new_null()
		}
		'download_product' {
			Class_WC_Download_Handler.download_product()
			return rt.new_null()
		}
		'check_order_is_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Download_Handler.check_order_is_valid(dispatch_arg_0)
			return rt.new_null()
		}
		'check_downloads_remaining' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Download_Handler.check_downloads_remaining(dispatch_arg_0)
			return rt.new_null()
		}
		'check_download_expiry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Download_Handler.check_download_expiry(dispatch_arg_0)
			return rt.new_null()
		}
		'check_download_login_required' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Download_Handler.check_download_login_required(dispatch_arg_0)
			return rt.new_null()
		}
		'count_download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Download_Handler.count_download(dispatch_arg_0)
			return rt.new_null()
		}
		'download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Download_Handler.download(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'download_file_redirect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_WC_Download_Handler.download_file_redirect(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse_file_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Download_Handler.parse_file_path(dispatch_arg_0)
		}
		'download_file_xsendfile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Download_Handler.download_file_xsendfile(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_download_range' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Download_Handler.get_download_range(dispatch_arg_0)
		}
		'download_file_force' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Download_Handler.download_file_force(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_download_content_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Download_Handler.get_download_content_type(dispatch_arg_0)
		}
		'download_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Download_Handler.download_headers(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'check_server_config' {
			Class_WC_Download_Handler.check_server_config()
			return rt.new_null()
		}
		'clean_buffers' {
			Class_WC_Download_Handler.clean_buffers()
			return rt.new_null()
		}
		'get_content_disposition' {
			return rt.new_string(Class_WC_Download_Handler.get_content_disposition())
		}
		'readfile_chunked' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Download_Handler.readfile_chunked(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'ie_nocache_headers_fix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Download_Handler.ie_nocache_headers_fix(dispatch_arg_0)
		}
		'download_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_WC_Download_Handler.download_error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'track_download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			Class_WC_Download_Handler.track_download(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Download_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Download_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Customer_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_download_handler_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
