import rt
import crypto.sha1

pub fn Class_WC_Download_Handler.track_download_callback() string {
	return 'track_partial_download'
}

struct Class_WC_Download_Handler {
	rt.PhpObjectBase
}

fn Class_WC_Download_Handler.init() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('download_file'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('order'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('email'))
		|| rt.get_superglobal('_GET').array_isset(rt.new_string('uid')) {
		rt.call_function('add_action', [rt.new_string('init'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'download_product' }])])
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_download_file_redirect'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'download_file_redirect' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_download_file_xsendfile'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'download_file_xsendfile' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_download_file_force'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'download_file_force' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [
		rt.new_string(Class_WC_Download_Handler.track_download_callback()),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'track_download' }]),
		rt.new_int(10),
		rt.new_int(3),
	])
}

fn Class_WC_Download_Handler.download_product() {
	mut var_product_id := rt.call_function('absint', [
		rt.get_superglobal('_GET').array_get(rt.new_string('download_file')),
	])
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	mut var_downloads := if rt.is_true(var_product) {
		rt.call_method(var_product, 'get_downloads', []rt.PhpVal{})
	} else {
		rt.new_array()
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('customer-download'))
	mut var_data_store := iife_result_0
	mut var_key := if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('key'))) { rt.new_string('') } else { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('key'))]),
		]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || !rt.is_true(var_key)
		|| !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('order')))
		|| !(var_downloads.array_isset(var_key))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_downloads.array_get(var_key), 'get_enabled', []rt.PhpVal{}))))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [
			rt.new_string('Invalid download link.'),
			rt.new_string('woocommerce'),
		])).str())
	}
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('email')))
		&& !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('uid'))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [
			rt.new_string('Invalid download link.'),
			rt.new_string('woocommerce'),
		])).str())
	}
	mut var_order_id := rt.call_function('wc_get_order_id_by_order_key', [
		rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('order'))]),
		]),
	])
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('email')) {
		mut var_email_address := rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('email')),
		])
	} else {
		var_email_address = if rt.is_true(rt.call_function('is_a', [
			var_order.clone(), rt.new_string('WC_Order')]))
		{ rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}) } else { rt.new_null() }
		mut var_email_hash := if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('hash'),
		]))
		{
			rt.call_function('hash', [rt.new_string('sha256'),
				var_email_address.clone()])
		} else {
			rt.new_string(sha1.hexhash(var_email_address.clone().to_string()))
		}
		if var_email_address.clone().is_null()
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('uid'))]), var_email_hash.clone()]))))) {
			Class_WC_Download_Handler.download_error((rt.call_function('__', [
				rt.new_string('Invalid download link.'),
				rt.new_string('woocommerce'),
			])).str())
		}
	}
	mut var_download_ids := rt.call_method(var_data_store, 'get_downloads', [
		rt.create_array([
			rt.ArrayItem{ key: 'user_email', val: rt.call_function('sanitize_email', [
				rt.call_function('str_replace', [rt.new_string(' '),
					rt.new_string('+'), var_email_address.clone()]),
			]) },
			rt.ArrayItem{ key: 'order_key', val: rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('order'))]),
			]) },
			rt.ArrayItem{ key: 'product_id', val: var_product_id },
			rt.ArrayItem{ key: 'download_id', val: rt.call_function('wc_clean', [
				rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
					rt.new_string(' '),
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_GET').array_get(rt.new_string('key')),
					])]),
			]) },
			rt.ArrayItem{ key: 'orderby', val: 'downloads_remaining' },
			rt.ArrayItem{ key: 'order', val: 'DESC' },
			rt.ArrayItem{ key: 'limit', val: 1 },
			rt.ArrayItem{ key: 'return', val: 'ids' },
		]),
	])
	if !rt.is_true(var_download_ids) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [
			rt.new_string('Invalid download link.'),
			rt.new_string('woocommerce'),
		])).str())
	}
	mut var_download := create_wc_customer_download(rt.call_function('current', [
		var_download_ids.clone(),
	]))
	mut var_file_path := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_download_product_filepath'),
		rt.call_method(var_product, 'get_file_download_path', [
			var_download.get_download_id()]),
		var_email_address.clone(),
		var_order.clone(),
		var_product.clone(),
		var_download,
	])
	mut var_parsed_file_path := Class_WC_Download_Handler.parse_file_path(var_file_path.clone())
	mut var_download_range := Class_WC_Download_Handler.get_download_range(rt.call_function('filesize', [
		var_parsed_file_path.array_get(rt.new_string('file_path')),
	]))
	Class_WC_Download_Handler.check_order_is_valid(rt.new_object('WC_Customer_Download',
		[]string{}, var_download))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_download_range.array_get(rt.new_string('is_range_request')))))) {
		Class_WC_Download_Handler.check_downloads_remaining(rt.new_object('WC_Customer_Download',
			[]string{}, var_download))
	}
	Class_WC_Download_Handler.check_download_expiry(rt.new_object('WC_Customer_Download',
		[]string{}, var_download))
	Class_WC_Download_Handler.check_download_login_required(rt.new_object('WC_Customer_Download',
		[]string{}, var_download))
	rt.call_function('do_action', [rt.new_string('woocommerce_download_product'),
		var_download.get_user_email(), var_download.get_order_key(),
		var_download.get_product_id(), var_download.get_user_id(),
		var_download.get_download_id(), var_download.get_order_id()])
	var_download.save()
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut iife_temp_1 := Class_WC_Geolocation{}
	mut iife_result_1 := iife_temp_1.get_ip_address()
	mut var_ip_address := iife_result_1
	Class_WC_Download_Handler.track_download(rt.new_object('WC_Customer_Download', []string{},
		var_download), if rt.is_true(rt.greater(var_current_user_id, rt.new_int(0))) {
		var_current_user_id
	} else {
		rt.new_null()
	}, (if !(!rt.is_true(var_ip_address)) { var_ip_address } else { rt.new_null() }).to_bool(),
		var_download_range.array_get(rt.new_string('is_range_request')))
	Class_WC_Download_Handler.download(var_file_path.clone(), var_download.get_product_id())
}

fn Class_WC_Download_Handler.check_order_is_valid(var_download rt.PhpVal) {
	mut var_download_mutated := var_download
	if rt.is_true(var_download_mutated.get_order_id()) {
		mut var_order := rt.call_function('wc_get_order', [var_download_mutated.get_order_id()])
		if rt.is_true(var_order)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{}))))) {
			Class_WC_Download_Handler.download_error((rt.call_function('__', [
				rt.new_string('Invalid order.'),
				rt.new_string('woocommerce'),
			])).str(), '', rt.new_int(403))
		}
	}
}

fn Class_WC_Download_Handler.check_downloads_remaining(var_download rt.PhpVal) {
	mut var_download_mutated := var_download
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_download_mutated.get_downloads_remaining()))))
		&& rt.is_true(rt.greater_equal(rt.new_int(0), var_download_mutated.get_downloads_remaining())) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [
			rt.new_string('Sorry, you have reached your download limit for this file'),
			rt.new_string('woocommerce'),
		])).str(), '', rt.new_int(403))
	}
}

fn Class_WC_Download_Handler.check_download_expiry(var_download rt.PhpVal) {
	mut var_download_mutated := var_download
	if !(var_download_mutated.get_access_expires().is_null())
		&& rt.is_true(rt.less(rt.call_method(var_download_mutated.get_access_expires(), 'getTimestamp', []rt.PhpVal{}), rt.call_function('strtotime', [rt.new_string('midnight'), rt.call_function('time', []rt.PhpVal{})]))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [
			rt.new_string('Sorry, this download has expired'),
			rt.new_string('woocommerce'),
		])).str(), '', rt.new_int(403))
	}
}

fn Class_WC_Download_Handler.check_download_login_required(var_download rt.PhpVal) {
	mut var_download_mutated := var_download
	if rt.is_true(var_download_mutated.get_user_id())
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_downloads_require_login')]))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			if rt.is_true(rt.call_function('wc_get_page_id', [
				rt.new_string('myaccount')]))
			{
				rt.call_function('wp_safe_redirect', [
					rt.call_function('add_query_arg', [rt.new_string('wc_error'),
						rt.call_function('rawurlencode', [
							rt.call_function('__', [
								rt.new_string('You must be logged in to download files.'),
								rt.new_string('woocommerce'),
							]),
						]),
						rt.call_function('wc_get_page_permalink', [
							rt.new_string('myaccount'),
						])]),
				])
				exit(0)
			} else {
				Class_WC_Download_Handler.download_error(
					(rt.call_function('__', [rt.new_string('You must be logged in to download files.'), rt.new_string('woocommerce')])).str() +
					' <a href="' +
					(rt.call_function('esc_url', [rt.call_function('wp_login_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])])).str() +
					'" class="wc-forward">' +
					(rt.call_function('__', [rt.new_string('Login'), rt.new_string('woocommerce')])).str() +
					'</a>', (rt.call_function('__', [
					rt.new_string('Log in to Download Files'),
					rt.new_string('woocommerce'),
				])).to_i64(), rt.new_int(403))
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('download_file'),
			var_download_mutated.clone(),
		])))))
		{
			Class_WC_Download_Handler.download_error((rt.call_function('__', [
				rt.new_string('This is not your download link.'),
				rt.new_string('woocommerce'),
			])).str(), '', rt.new_int(403))
		}
	}
}

fn Class_WC_Download_Handler.count_download(var_download_data rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Download_Handler::count_download'),
		rt.new_string('4.4.0'),
		rt.new_string(''),
	])
}

fn Class_WC_Download_Handler.download(var_file_path rt.PhpVal, var_product_id rt.PhpVal) {
	mut var_file_path_mutated := var_file_path
	mut var_product_id_mutated := var_product_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file_path_mutated)))) {
		Class_WC_Download_Handler.download_error((rt.call_function('__', [
			rt.new_string('No file defined'),
			rt.new_string('woocommerce'),
		])).str())
	}
	mut var_filename := rt.call_function('basename', [var_file_path_mutated.clone()])
	if rt.is_true(rt.call_function('strstr', [var_filename.clone(),
		rt.new_string('?')]))
	{
		var_filename = rt.call_function('current', [
			rt.call_function('explode', [rt.new_string('?'), var_filename.clone()]),
		])
	}
	var_filename = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_file_download_filename'),
		var_filename.clone(),
		var_product_id_mutated.clone(),
	])
	mut var_file_download_method := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_file_download_method'),
		rt.call_function('get_option', [
			rt.new_string('woocommerce_file_download_method'),
			rt.new_string('force'),
		]),
		var_product_id_mutated.clone(),
		var_file_path_mutated.clone(),
	])
	rt.call_function('add_action', [rt.new_string('nocache_headers'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'ie_nocache_headers_fix' }])])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_download_file_' + var_file_download_method.str()),
		var_file_path_mutated.clone(),
		var_filename.clone(),
	])
}

fn Class_WC_Download_Handler.download_file_redirect(var_file_path rt.PhpVal, filename string) {
	mut var_file_path_mutated := var_file_path
	mut filename_mutated := filename
	rt.call_function('header', [
		rt.new_string('Location: ' + var_file_path_mutated.str()),
	])
	exit(0)
}

fn Class_WC_Download_Handler.parse_file_path(var_file_path rt.PhpVal) rt.PhpVal {
	mut var_file_path_mutated := var_file_path
	mut var_wp_uploads := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	mut var_wp_uploads_dir := var_wp_uploads.array_get(rt.new_string('basedir'))
	mut var_wp_uploads_url := var_wp_uploads.array_get(rt.new_string('baseurl'))
	mut var_replacements := rt.create_array([
		rt.ArrayItem{ key: var_wp_uploads_url, val: var_wp_uploads_dir },
		rt.ArrayItem{ key: rt.call_function('network_site_url', [
			rt.new_string('/'), rt.new_string('https')]), val: rt.get_constant('ABSPATH') },
		rt.ArrayItem{
			key: rt.call_function('str_replace', [rt.new_string('https:'),
				rt.new_string('http:'),
				rt.call_function('network_site_url', [
					rt.new_string('/'),
					rt.new_string('http'),
				])])
			val: rt.get_constant('ABSPATH')
		},
		rt.ArrayItem{ key: rt.call_function('site_url', [rt.new_string('/'),
			rt.new_string('https')]), val: rt.get_constant('ABSPATH') },
		rt.ArrayItem{
			key: rt.call_function('str_replace', [rt.new_string('https:'),
				rt.new_string('http:'),
				rt.call_function('site_url', [
					rt.new_string('/'),
					rt.new_string('http'),
				])])
			val: rt.get_constant('ABSPATH')
		},
	])
	mut var_count := rt.new_int(0)
	var_file_path_mutated = rt.call_function('str_replace', [
		rt.func_array_keys(var_replacements.clone()),
		rt.call_function('array_values', [var_replacements.clone()]),
		var_file_path_mutated.clone(),
		var_count.clone(),
	])
	mut var_parsed_file_path := rt.call_function('wp_parse_url', [
		var_file_path_mutated.clone()])
	mut var_remote_file := rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_count))
		|| rt.is_true(rt.identical(rt.new_int(0), var_count)))
	if rt.is_true(rt.identical(rt.new_string('//'), rt.call_function('substr', [
		var_file_path_mutated.clone(),
		rt.new_int(0),
		rt.new_int(2),
	])))
	{
		var_file_path_mutated = rt.new_string((
			if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https:' } else { 'http:' } +
			var_file_path_mutated.str()).str())
		return rt.create_array([rt.ArrayItem{ key: 'remote_file', val: true },
			rt.ArrayItem{ key: 'file_path', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_download_parse_remote_file_path'),
				var_file_path_mutated.clone(),
			]) }])
	}
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_path_mutated.str()),
	]))
	{
		var_remote_file = rt.new_bool(false)
		var_file_path_mutated = rt.new_string(
			(rt.get_constant('ABSPATH')).str() + var_file_path_mutated.str())
	} else if rt.is_true(rt.identical(rt.new_string('/wp-content'), rt.call_function('substr', [
		var_file_path_mutated.clone(),
		rt.new_int(0),
		rt.new_int(11),
	])))
	{
		var_remote_file = rt.new_bool(false)
		var_file_path_mutated = rt.call_function('realpath', [
			rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() +
				(rt.call_function('substr', [var_file_path_mutated.clone(), rt.new_int(11)])).str()),
		])
	} else if !(var_parsed_file_path.array_isset(rt.new_string('scheme')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_parsed_file_path.array_get(rt.new_string('scheme')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'http'
	}, rt.ArrayItem{ key: none, val: 'https' }, rt.ArrayItem{ key: none, val: 'ftp' }]), rt.new_bool(true)])))))
		&& var_parsed_file_path.array_isset(rt.new_string('path')) {
		var_remote_file = rt.new_bool(false)
		var_file_path_mutated = var_parsed_file_path.array_get(rt.new_string('path'))
	}
	return rt.create_array([rt.ArrayItem{ key: 'remote_file', val: var_remote_file },
		rt.ArrayItem{ key: 'file_path', val: rt.call_function('apply_filters', [
			rt.new_string('woocommerce_download_parse_file_path'),
			var_file_path_mutated.clone(),
			var_remote_file.clone(),
		]) }])
}

fn Class_WC_Download_Handler.download_file_xsendfile(var_file_path rt.PhpVal, var_filename rt.PhpVal) {
	mut var_file_path_mutated := var_file_path
	mut var_filename_mutated := var_filename
	mut var_parsed_file_path :=
		Class_WC_Download_Handler.parse_file_path(var_file_path_mutated.clone())
	if rt.is_true(var_parsed_file_path.array_get(rt.new_string('remote_file')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_use_xsendfile_for_remote'), rt.new_bool(false)]))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_download_file_force'),
			var_file_path_mutated.clone(), var_filename_mutated.clone()])
		return
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apache_get_modules')]))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('mod_xsendfile'), rt.call_function('apache_get_modules', []rt.PhpVal{}), rt.new_bool(true)])) {
		Class_WC_Download_Handler.download_headers(var_parsed_file_path.array_get(rt.new_string('file_path')),
			var_filename_mutated.clone())
		mut var_filepath := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_download_file_xsendfile_file_path'),
			var_parsed_file_path.array_get(rt.new_string('file_path')),
			var_file_path_mutated.clone(),
			var_filename_mutated.clone(),
			var_parsed_file_path.clone(),
		])
		rt.call_function('header', [rt.new_string('X-Sendfile: ' + var_filepath.str())])
		exit(0)
	} else if rt.is_true(rt.call_function('stristr', [
		rt.call_function('getenv', [rt.new_string('SERVER_SOFTWARE')]),
		rt.new_string('lighttpd'),
	]))
	{
		Class_WC_Download_Handler.download_headers(var_parsed_file_path.array_get(rt.new_string('file_path')),
			var_filename_mutated.clone())
		var_filepath = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_download_file_xsendfile_lighttpd_file_path'),
			var_parsed_file_path.array_get(rt.new_string('file_path')),
			var_file_path_mutated.clone(),
			var_filename_mutated.clone(),
			var_parsed_file_path.clone(),
		])
		rt.call_function('header', [
			rt.new_string('X-Lighttpd-Sendfile: ' + var_filepath.str()),
		])
		exit(0)
	} else if
		rt.is_true(rt.call_function('stristr', [rt.call_function('getenv', [rt.new_string('SERVER_SOFTWARE')]), rt.new_string('nginx')]))
		|| rt.is_true(rt.call_function('stristr', [rt.call_function('getenv', [rt.new_string('SERVER_SOFTWARE')]), rt.new_string('cherokee')])) {
		Class_WC_Download_Handler.download_headers(var_parsed_file_path.array_get(rt.new_string('file_path')),
			var_filename_mutated.clone())
		mut var_xsendfile_path := rt.new_string(rt.call_function('preg_replace', [
			rt.new_string('`^' +
				(rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('getcwd', []rt.PhpVal{})])).str() +
				'`'),
			rt.new_string(''),
			var_parsed_file_path.array_get(rt.new_string('file_path')),
		]).to_string().trim_space())
		var_xsendfile_path = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_download_file_xsendfile_x_accel_redirect_file_path'),
			var_xsendfile_path.clone(),
			var_file_path_mutated.clone(),
			var_filename_mutated.clone(),
			var_parsed_file_path.clone(),
		])
		rt.call_function('header', [
			rt.new_string('X-Accel-Redirect: /${var_xsendfile_path.to_string()}'),
		])
		exit(0)
	}
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('%1$s could not be served using the X-Accel-Redirect/X-Sendfile method. A Force Download will be used instead.'),
				rt.new_string('woocommerce'),
			]),
			var_file_path_mutated.clone(),
		]),
	])
	Class_WC_Download_Handler.download_file_force(var_file_path_mutated.clone(),
		var_filename_mutated.clone())
}

fn Class_WC_Download_Handler.get_download_range(var_file_size rt.PhpVal) rt.PhpVal {
	mut var_file_size_mutated := var_file_size
	mut var_start := rt.new_int(0)
	mut var_download_range := rt.create_array([
		rt.ArrayItem{ key: 'start', val: var_start },
		rt.ArrayItem{ key: 'is_range_valid', val: false },
		rt.ArrayItem{ key: 'is_range_request', val: false },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file_size_mutated)))) {
		return var_download_range.clone()
	}
	mut var_end := rt.sub(var_file_size_mutated, rt.new_int(1))
	var_download_range.array_set('length', var_file_size_mutated.clone())
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_RANGE')) {
		mut var_http_range := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_RANGE'))]),
		])
		var_download_range.array_set('is_range_request', true)
		mut var_c_start := var_start.clone()
		mut var_c_end := var_end.clone()
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('='),
			var_http_range.clone(), rt.new_int(2)])
		mut var_range := list_tmp_1.array_get(1)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			var_range.clone(),
			rt.new_string(','),
		]), rt.new_bool(false)))))
		{
			return var_download_range.clone()
		}
		if rt.is_true(rt.identical(rt.new_string('-'), var_range.array_get(rt.new_int(0)))) {
			var_c_start = rt.sub(var_file_size_mutated, rt.call_function('substr', [
				var_range.clone(),
				rt.new_int(1),
			]))
		} else {
			var_range = rt.call_function('explode', [rt.new_string('-'),
				var_range.clone()])
			var_c_start = rt.new_int(if var_range.array_isset(rt.new_int(0))
				&& var_range.array_get(rt.new_int(0)).is_long()
				|| var_range.array_get(rt.new_int(0)).is_double() {
				rt.new_int((var_range.array_get(rt.new_int(0))).to_i64())
			} else {
				0
			})
			var_c_end = if var_range.array_isset(rt.new_int(1))
				&& var_range.array_get(rt.new_int(1)).is_long()
				|| var_range.array_get(rt.new_int(1)).is_double() {
				rt.new_int((var_range.array_get(rt.new_int(1))).to_i64())
			} else {
				var_file_size_mutated
			}
		}
		var_c_end = if rt.is_true(rt.greater(var_c_end, var_end)) { var_end } else { var_c_end }
		if rt.is_true(rt.greater(var_c_start, var_c_end))
			|| rt.is_true(rt.greater(var_c_start, rt.sub(var_file_size_mutated, rt.new_int(1))))
			|| rt.is_true(rt.greater_equal(var_c_end, var_file_size_mutated)) {
			return var_download_range.clone()
		}
		var_start = var_c_start.clone()
		var_end = var_c_end.clone()
		mut var_length := rt.add(rt.sub(var_end, var_start), rt.new_int(1))
		var_download_range.array_set('start', var_start.clone())
		var_download_range.array_set('length', var_length.clone())
		var_download_range.array_set('is_range_valid', true)
	}
	return var_download_range.clone()
}

fn Class_WC_Download_Handler.download_file_force(var_file_path rt.PhpVal, var_filename rt.PhpVal) {
	mut var_file_path_mutated := var_file_path
	mut var_filename_mutated := var_filename
	mut var_parsed_file_path :=
		Class_WC_Download_Handler.parse_file_path(var_file_path_mutated.clone())
	mut var_download_range := Class_WC_Download_Handler.get_download_range(rt.call_function('filesize', [
		var_parsed_file_path.array_get(rt.new_string('file_path')),
	]))
	Class_WC_Download_Handler.download_headers(var_parsed_file_path.array_get(rt.new_string('file_path')),
		var_filename_mutated.clone(), var_download_range.clone())
	mut var_start := if var_download_range.array_isset(rt.new_string('start')) {
		var_download_range.array_get(rt.new_string('start'))
	} else {
		rt.new_int(0)
	}
	mut var_length := if var_download_range.array_isset(rt.new_string('length')) {
		var_download_range.array_get(rt.new_string('length'))
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Download_Handler.readfile_chunked((var_parsed_file_path.array_get(rt.new_string('file_path'))).to_i64(),
		var_start.to_i64(), var_length.clone())))))
	{
		if rt.is_true(var_parsed_file_path.array_get(rt.new_string('remote_file')))
			&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_downloads_redirect_fallback_allowed')]))) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('%1$s could not be served using the Force Download method. A redirect will be used instead.'),
						rt.new_string('woocommerce'),
					]),
					var_file_path_mutated.clone(),
				]),
			])
			Class_WC_Download_Handler.download_file_redirect(var_file_path_mutated.str())
		} else {
			Class_WC_Download_Handler.download_error((rt.call_function('__', [
				rt.new_string('File not found'),
				rt.new_string('woocommerce'),
			])).str())
		}
	}
	exit(0)
}

fn Class_WC_Download_Handler.get_download_content_type(var_file_path rt.PhpVal) rt.PhpVal {
	mut var_file_path_mutated := var_file_path
	mut var_file_extension := rt.new_string(rt.call_function('substr', [
		rt.call_function('strrchr', [var_file_path_mutated.clone(),
			rt.new_string('.')]),
		rt.new_int(1),
	]).to_string().to_lower())
	mut var_ctype := rt.new_string('application/force-download')
	mut iter_1 := rt.call_function('get_allowed_mime_types', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_type := item_1.val
		mut var_mime := item_1.key
		mut var_mimes := rt.call_function('explode', [rt.new_string('|'),
			var_mime.clone()])
		if rt.is_true(rt.call_function('in_array', [var_file_extension.clone(),
			var_mimes.clone(), rt.new_bool(true)]))
		{
			var_ctype = var_type
			break
		}
	}
	return var_ctype.clone()
}

fn Class_WC_Download_Handler.download_headers(var_file_path rt.PhpVal, var_filename rt.PhpVal, var_download_range rt.PhpVal) {
	mut var_file_path_mutated := var_file_path
	mut var_filename_mutated := var_filename
	mut var_download_range_mutated := var_download_range
	Class_WC_Download_Handler.check_server_config()
	Class_WC_Download_Handler.clean_buffers()
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex, nofollow'),
		rt.new_bool(true)])
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +(Class_WC_Download_Handler.get_download_content_type(var_file_path_mutated.clone())).str()),
	])
	rt.call_function('header', [rt.new_string('Content-Description: File Transfer')])
	rt.call_function('header', [
		rt.new_string('Content-Disposition: ' +
			(Class_WC_Download_Handler.get_content_disposition()).str() + '; filename="' + var_filename_mutated.str() +
			'";'),
	])
	rt.call_function('header', [rt.new_string('Content-Transfer-Encoding: binary')])
	mut var_file_size := rt.call_function('filesize', [var_file_path_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file_size)))) {
		return
	}
	if var_download_range_mutated.array_isset(rt.new_string('is_range_request'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_download_range_mutated.array_get(rt.new_string('is_range_request')))) {
		if rt.is_true(rt.identical(rt.new_bool(false),
			var_download_range_mutated.array_get(rt.new_string('is_range_valid'))))
		{
			rt.call_function('header', [
				rt.new_string('HTTP/1.1 416 Requested Range Not Satisfiable'),
			])
			rt.call_function('header', [
				rt.new_string('Content-Range: bytes 0-' +
					(rt.sub(var_file_size, rt.new_int(1))).str() + '/' + var_file_size.str()),
			])
			exit(0)
		}
		mut var_start := var_download_range_mutated.array_get(rt.new_string('start'))
		mut var_end := rt.sub(rt.add(var_download_range_mutated.array_get(rt.new_string('start')),
			var_download_range_mutated.array_get(rt.new_string('length'))), rt.new_int(1))
		mut var_length := var_download_range_mutated.array_get(rt.new_string('length'))
		rt.call_function('header', [rt.new_string('HTTP/1.1 206 Partial Content')])
		rt.call_function('header', [
			rt.new_string('Accept-Ranges: 0-${var_file_size.to_string()}'),
		])
		rt.call_function('header', [
			rt.new_string('Content-Range: bytes ${var_start.to_string()}-${var_end.to_string()}/${var_file_size.to_string()}'),
		])
		rt.call_function('header', [
			rt.new_string('Content-Length: ${var_length.to_string()}'),
		])
	} else {
		rt.call_function('header', [
			rt.new_string('Content-Length: ' + var_file_size.str()),
		])
	}
}

fn Class_WC_Download_Handler.check_server_config() {
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apache_setenv')])) {
		rt.call_function('apache_setenv', [rt.new_string('no-gzip'),
			rt.new_int(1)])
	}
	rt.call_function('ini_set', [rt.new_string('zlib.output_compression'),
		rt.new_string('Off')])
	rt.call_function('session_write_close', []rt.PhpVal{})
}

fn Class_WC_Download_Handler.clean_buffers() {
	if rt.is_true(rt.call_function('ob_get_level', []rt.PhpVal{})) {
		mut var_levels := rt.call_function('ob_get_level', []rt.PhpVal{})
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_levels))) { break
			 }
			rt.call_function('ob_end_clean', []rt.PhpVal{})
			rt.post_inc(var_i)
		}
	} else {
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	}
}

fn Class_WC_Download_Handler.get_content_disposition() string {
	mut var_disposition := rt.new_string('attachment')
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_downloads_deliver_inline'),
	])))
	{
		var_disposition = rt.new_string('inline')
	}
	return var_disposition.str()
}

fn Class_WC_Download_Handler.readfile_chunked(var_file rt.PhpVal, start i64, length i64) bool {
	mut start_mutated := start
	mut length_mutated := length
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WC_CHUNK_SIZE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WC_CHUNK_SIZE'),
			rt.new_int(1024 * 1024)])
	}
	mut var_handle := rt.call_function('fopen', [var_file.clone(),
		rt.new_string('r')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_handle)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(length_mutated))))) {
		length_mutated = (rt.call_function('filesize', [var_file.clone()])).to_i64()
	}
	mut var_read_length := rt.new_int((rt.get_constant('WC_CHUNK_SIZE')).to_i64())
	if rt.is_true(rt.new_int(length_mutated)) {
		mut var_end := rt.new_int(start_mutated + length_mutated - 1)
		rt.call_function('fseek', [var_handle.clone(), rt.new_int(start_mutated).clone()])
		mut var_p := rt.call_function('ftell', [var_handle.clone()])
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_handle.clone()])))))
			&& rt.is_true(rt.less_equal(var_p, var_end)) {
			if rt.is_true(rt.greater(rt.add(var_p, var_read_length), var_end)) {
				var_read_length = rt.add(rt.sub(var_end, var_p), rt.new_int(1))
			}
			rt.echo_val(rt.call_function('fread', [var_handle.clone(),
				var_read_length.clone()]))
			var_p = rt.call_function('ftell', [var_handle.clone()])
			if rt.is_true(rt.call_function('ob_get_length', []rt.PhpVal{})) {
				rt.call_function('ob_flush', []rt.PhpVal{})
				rt.call_function('flush', []rt.PhpVal{})
			}
		}
	} else {
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
			var_handle.clone()]))))) {
			rt.echo_val(rt.call_function('fread', [var_handle.clone(),
				var_read_length.clone()]))
			if rt.is_true(rt.call_function('ob_get_length', []rt.PhpVal{})) {
				rt.call_function('ob_flush', []rt.PhpVal{})
				rt.call_function('flush', []rt.PhpVal{})
			}
		}
	}
	return (rt.call_function('fclose', [var_handle.clone()])).to_bool()
	return false
}

fn Class_WC_Download_Handler.ie_nocache_headers_fix(var_headers rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_headers_mutated := var_headers
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
		&& !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('is_IE')))) {
		var_headers_mutated.array_set('Cache-Control', 'private')
		var_headers_mutated.array_unset(rt.new_string('Pragma'))
	}
	return var_headers_mutated.clone()
}

fn Class_WC_Download_Handler.download_error(var_message rt.PhpVal, title string, status i64) {
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
			rt.new_string('warning'),
			rt.call_function('__', [
				rt.new_string('Headers already sent when generating download error message.'),
				rt.new_string('woocommerce'),
			]),
		])
	} else {
		rt.call_function('header', [
			rt.new_string('Content-Type: ' +
				(rt.call_function('get_option', [rt.new_string('html_type')])).str() +
				'; charset=' +
				(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
		])
		rt.call_function('header_remove', [rt.new_string('Content-Description;')])
		rt.call_function('header_remove', [rt.new_string('Content-Disposition')])
		rt.call_function('header_remove', [rt.new_string('Content-Transfer-Encoding')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [
		var_message.clone(), rt.new_string('<a ')])))))
	{
		var_message = rt.concat(var_message, rt.new_string(' <a href="' +
			(rt.call_function('esc_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])])).str() +
			'" class="wc-forward">' +
			(rt.call_function('esc_html__', [rt.new_string('Go to shop'), rt.new_string('woocommerce')])).str() +
			'</a>'))
	}
	rt.call_function('wp_die', [var_message.clone(), rt.new_string(title),
		rt.create_array([rt.ArrayItem{ key: 'response', val: status }])])
}

fn Class_WC_Download_Handler.track_download(var_download rt.PhpVal, var_user_id rt.PhpVal, var_user_ip_address rt.PhpVal, defer bool) {
	mut var_download_mutated := var_download
	var_download_mutated = create_wc_customer_download(var_download_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !var_defer {
		var_download_mutated.track_download(var_user_id.clone(), var_user_ip_address.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_downloads_count_partial'),
		rt.new_string('yes'),
	]), rt.new_string('yes')))))
	{
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_window := rt.call_function('absint', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_partial_download_tracking_window'),
			rt.mul(rt.new_int(30), rt.get_constant('MINUTE_IN_SECONDS')),
			var_download_mutated.get_id(),
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_2 := Class_ActionScheduler_Versions{}
	mut iife_result_2 := iife_temp_2.instance()
	mut iife_temp_3 := Class_ActionScheduler_Versions{}
	mut iife_result_3 := iife_temp_3.instance()
	if rt.is_true(rt.call_function('version_compare', [
		rt.call_method(iife_result_2, 'latest_version', []rt.PhpVal{}),
		rt.new_string('3.6.0'),
		rt.new_string('<'),
	]))
	{
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('Support for unique scheduled actions is not currently available.'))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('as_schedule_single_action', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), var_window),
		rt.new_string(Class_WC_Download_Handler.track_download_callback()),
		rt.create_array([rt.ArrayItem{ key: none, val: var_download_mutated.get_id() },
			rt.ArrayItem{ key: none, val: var_user_id }, rt.ArrayItem{
				key: none
				val: var_user_ip_address
			}]),
		rt.new_string('woocommerce'),
		rt.new_bool(true),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.new_string('There was a problem while tracking a product download.'),
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'id', val: var_download_mutated.get_id() },
				rt.ArrayItem{ key: 'user_id', val: var_user_id },
				rt.ArrayItem{ key: 'ip', val: var_user_ip_address },
				rt.ArrayItem{
					key: 'deferred'
					val: if var_defer { 'yes' } else { 'no' }
				},
			]),
		])
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
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

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_download_handler(_args ...rt.PhpVal) &Class_WC_Download_Handler {
	mut obj := &Class_WC_Download_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer_download(_args ...rt.PhpVal) &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_geolocation(_args ...rt.PhpVal) &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_versions(_args ...rt.PhpVal) &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
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
			Class_WC_Download_Handler.download_headers(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
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
			return rt.new_bool(Class_WC_Download_Handler.readfile_chunked(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
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
			Class_WC_Download_Handler.track_download(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
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

fn (mut this Class_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Download_Handler.init()
}
