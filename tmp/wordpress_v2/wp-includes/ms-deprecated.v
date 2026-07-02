import rt

fn get_dashboard_blog() rt.PhpVal {
	mut var_blog := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.1.0'), rt.new_string('get_site()')])
	var_blog = rt.call_function('get_site_option', [rt.new_string('dashboard_blog')])
	if rt.is_true(var_blog) {
		return rt.call_function('get_site', [var_blog.clone()])
	}
	return rt.call_function('get_site', [
		rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_id'),
	])
}

fn generate_random_password(len i64) rt.PhpVal {
	mut var_len := len
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('wp_generate_password()')])
	return rt.call_function('wp_generate_password', [rt.new_int(len)])
}

fn is_site_admin(user_login string) bool {
	mut var_user_login := user_login
	mut var_user_id := rt.new_null()
	mut var_user := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('is_super_admin()')])
	if user_login == '' {
		var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
			return false
		}
	} else {
		var_user = rt.call_function('get_user_by', [rt.new_string('login'),
			rt.new_string(user_login)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
			return false
		}
		var_user_id = rt.get_property(var_user, 'ID')
	}
	return (rt.call_function('is_super_admin', [var_user_id.clone()])).to_bool()
}

fn graceful_fail(var_message_arg rt.PhpVal) {
	mut var_message := var_message_arg
	mut var_message_template := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('wp_die()')])
	var_message = rt.call_function('apply_filters', [rt.new_string('graceful_fail'),
		var_message.clone()])
	var_message_template = rt.call_function('apply_filters', [
		rt.new_string('graceful_fail_template'),
		rt.new_string('<!DOCTYPE html>\n<html><head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />\n<title>Error!</title>\n<style>\nimg {\n\tborder: 0;\n}\nbody {\nline-height: 1.6em; font-family: Georgia, serif; width: 390px; margin: auto;\ntext-align: center;\n}\n.message {\n\tfont-size: 22px;\n\twidth: 350px;\n\tmargin: auto;\n}\n</style>\n</head>\n<body>\n<p class="message">%s</p>\n</body>\n</html>'),
	])
	fn () {
		print((rt.call_function('sprintf', [var_message_template.clone(),
			var_message.clone()])).str())
		exit(0)
	}()
}

fn get_user_details(var_username rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('get_user_by()')])
	return rt.call_function('get_user_by', [rt.new_string('login'),
		var_username.clone()])
}

fn clear_global_post_cache(var_post_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('clean_post_cache()')])
}

fn is_main_blog() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('is_main_site()')])
	return rt.call_function('is_main_site', []rt.PhpVal{})
}

fn validate_email(var_email rt.PhpVal, check_domain bool) rt.PhpVal {
	mut var_check_domain := check_domain
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('is_email()')])
	return rt.call_function('is_email', [var_email.clone(), rt.new_bool(check_domain)])
}

fn get_blog_list(start i64, num i64, deprecated string) rt.PhpVal {
	mut var_start := start
	mut var_num := num
	mut var_deprecated := deprecated
	mut var_wpdb := rt.new_null()
	mut var_blogs := rt.new_null()
	mut var_blog_list := rt.new_null()
	mut var_details := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('wp_get_sites()')])
	var_blogs = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT blog_id, domain, path FROM '), rt.get_property(var_wpdb,
				'blogs')),
				rt.new_string(" WHERE site_id = %d AND public = '1' AND archived = '0' AND mature = '0' AND spam = '0' AND deleted = '0' ORDER BY registered DESC")),
			rt.call_function('get_current_network_id', []rt.PhpVal{}),
		]),
		rt.get_constant('ARRAY_A'),
	])
	var_blog_list = rt.new_array()
	mut iter_1 := rt.cast_array(var_blogs).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_details_shadow := item_1.val
		var_blog_list.array_set(var_details_shadow['blog_id'], var_details_shadow.clone())
		var_blog_list.array_get_mut(var_details_shadow['blog_id']).array_set('postcount', rt.call_method(var_wpdb,
			'get_var', [
			rt.new_string('SELECT COUNT(ID) FROM ' +
				(rt.call_method(var_wpdb, 'get_blog_prefix', [var_details_shadow['blog_id']])).str() +
				"posts WHERE post_status='publish' AND post_type='post'"),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blog_list)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.identical(rt.new_string('all'), rt.new_int(num))) {
		return rt.call_function('array_slice', [var_blog_list.clone(),
			rt.new_int(start), rt.new_int(var_blog_list.clone().array_count())])
	} else {
		return rt.call_function('array_slice', [var_blog_list.clone(),
			rt.new_int(start), rt.new_int(num)])
	}
	return rt.new_null()
}

fn get_most_active_blogs(num i64, display bool) rt.PhpVal {
	mut var_num := num
	mut var_display := display
	mut var_blogs := rt.new_null()
	mut var_most_active := rt.new_null()
	mut var_blog_list := rt.new_null()
	mut var_details := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_t := rt.new_null()
	mut var_url := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0')])
	var_blogs = get_blog_list(0, 'all', false)
	if rt.is_true(rt.new_bool(var_blogs.clone().is_array())) {
		rt.call_function('reset', [var_blogs.clone()])
		var_most_active = rt.new_array()
		var_blog_list = rt.new_array()
		mut iter_2 := rt.cast_array(var_blogs).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_details_shadow := item_2.val
			mut var_key_shadow := item_2.key
			var_most_active.array_set(var_details_shadow['blog_id'],
				var_details_shadow['postcount'])
			var_blog_list.array_set(var_details_shadow['blog_id'], var_details_shadow.clone())
		}
		rt.call_function('arsort', [var_most_active.clone()])
		rt.call_function('reset', [var_most_active.clone()])
		var_t = rt.new_array()
		mut iter_3 := rt.cast_array(var_most_active).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_details_shadow := item_3.val
			mut var_key_shadow := item_3.key
			var_t.array_set(var_key_shadow, var_blog_list.array_get(var_key_shadow))
		}
		var_most_active = rt.new_null()
		var_most_active = var_t.clone()
	}
	if var_display {
		if rt.is_true(rt.new_bool(var_most_active.clone().is_array())) {
			rt.call_function('reset', [var_most_active.clone()])
			mut iter_4 := rt.cast_array(var_most_active).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_details_shadow := item_4.val
				mut var_key_shadow := item_4.key
				var_url = rt.call_function('esc_url', [
					rt.new_string('http://' +
						(var_details_shadow['domain']).str() + (var_details_shadow['path']).str()),
				])
				print('<li>' +
					(var_details_shadow['postcount']).str() + " <a href='${var_url.to_string()}'>${var_url.to_string()}</a></li>")
			}
		}
	}
	return rt.call_function('array_slice', [var_most_active.clone(),
		rt.new_int(0), rt.new_int(num)])
}

fn wpmu_admin_do_redirect(url string) {
	mut var_url := url
	mut var_ref := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('wp_redirect()')])
	var_ref = rt.new_string('')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('ref'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('ref'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get(rt.new_string('ref')), rt.get_superglobal('_POST').array_get(rt.new_string('ref')))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('A variable mismatch has been detected.'),
			]),
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to view this item.'),
			]),
			rt.new_int(400),
		])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('ref')) {
		var_ref = rt.get_superglobal('_POST').array_get(rt.new_string('ref'))
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('ref')) {
		var_ref = rt.get_superglobal('_GET').array_get(rt.new_string('ref'))
	}
	if rt.is_true(var_ref) {
		var_ref = rt.new_string(wpmu_admin_redirect_add_updated_param(var_ref.clone()))
		rt.call_function('wp_redirect', [var_ref.clone()])
		exit(0)
	}
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')))) {
		rt.call_function('wp_redirect',
			[rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER'))])
		exit(0)
	}
	var_url = wpmu_admin_redirect_add_updated_param(var_url)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('redirect'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get(rt.new_string('redirect')), rt.get_superglobal('_POST').array_get(rt.new_string('redirect')))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('A variable mismatch has been detected.'),
			]),
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to view this item.'),
			]),
			rt.new_int(400),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect')) {
		if rt.is_true(rt.call_function('str_starts_with', [
			rt.get_superglobal('_GET').array_get(rt.new_string('redirect')),
			rt.new_string('s_'),
		]))
		{
			var_url = var_url + '&action=blogs&s=' +(rt.call_function('esc_html', [rt.call_function('substr', [rt.get_superglobal('_GET').array_get(rt.new_string('redirect')), rt.new_int(2)])])).str()
		}
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('redirect')) {
		var_url =
			wpmu_admin_redirect_add_updated_param(rt.get_superglobal('_POST').array_get(rt.new_string('redirect')))
	}
	rt.call_function('wp_redirect', [rt.new_string(var_url.str())])
	exit(0)
}

fn wpmu_admin_redirect_add_updated_param(url string) string {
	mut var_url := url
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('add_query_arg()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		rt.new_string(var_url.str()),
		rt.new_string('updated=true'),
	])))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			rt.new_string(var_url.str()),
			rt.new_string('?'),
		])))))
		{
			return var_url + '?updated=true'
		} else {
			return var_url + '&updated=true'
		}
	}
	return var_url
}

fn get_user_id_from_string(var_email_or_login rt.PhpVal) i64 {
	mut var_user := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.6.0'), rt.new_string('get_user_by()')])
	if rt.is_true(rt.call_function('is_email', [var_email_or_login.clone()])) {
		var_user = rt.call_function('get_user_by', [rt.new_string('email'),
			var_email_or_login.clone()])
	} else if rt.is_true(rt.new_bool(var_email_or_login.clone().is_long()
		|| var_email_or_login.clone().is_double()))
	{
		return var_email_or_login.to_i64()
	} else {
		var_user = rt.call_function('get_user_by', [rt.new_string('login'),
			var_email_or_login.clone()])
	}
	if rt.is_true(var_user) {
		return (rt.get_property(var_user, 'ID')).to_i64()
	}
	return 0
}

fn get_blogaddress_by_domain(var_domain rt.PhpVal, var_path rt.PhpVal) rt.PhpVal {
	mut var_url := rt.new_null()
	mut var_blogname := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.7.0')])
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		var_url = rt.new_string('http://' + var_domain.str() + var_path.str())
	} else {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_domain,
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))))))
		{
			var_blogname = rt.call_function('substr', [var_domain.clone(),
				rt.new_int(0), rt.call_function('strpos', [var_domain.clone(),
					rt.new_string('.')])])
			var_url = rt.new_string('http://' +
				(rt.call_function('substr', [var_domain.clone(), rt.add(rt.call_function('strpos', [var_domain.clone(), rt.new_string('.')]), rt.new_int(1))])).str() +
				var_path.str())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('www.'), var_blogname)))) {
				var_url = rt.concat(var_url, rt.new_string(var_blogname.str() + '/'))
			}
		} else {
			var_url = rt.new_string('http://' + var_domain.str() + var_path.str())
		}
	}
	return rt.call_function('sanitize_url', [var_url.clone()])
}

fn create_empty_blog(var_domain rt.PhpVal, var_path_arg rt.PhpVal, var_weblog_title rt.PhpVal, site_id i64) rt.PhpVal {
	mut var_site_id := site_id
	mut var_path := var_path_arg
	mut var_blog_id := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.4.0')])
	if var_path == '' {
		var_path = '/'
	}
	if rt.is_true(rt.call_function('domain_exists', [var_domain.clone(),
		rt.new_string(var_path.str()).clone(), rt.new_int(site_id)]))
	{
		return rt.call_function('__', [
			rt.new_string('<strong>Error:</strong> Site URL you&#8217;ve entered is already taken.'),
		])
	}
	var_blog_id = rt.new_bool(insert_blog(var_domain.clone(),
		rt.new_string(var_path.str()).clone(), rt.new_int(site_id)))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blog_id)))) {
		return rt.call_function('__', [
			rt.new_string('<strong>Error:</strong> There was a problem creating site entry.'),
		])
	}
	rt.call_function('switch_to_blog', [var_blog_id.clone()])
	install_blog(var_blog_id.clone(), '')
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return var_blog_id.clone()
}

fn get_admin_users_for_domain(domain string, path string) bool {
	mut var_domain := domain
	mut var_path := path
	mut var_wpdb := rt.new_null()
	mut var_network_id := rt.new_null()
	mut var__networks := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.4.0')])
	if !(var_domain.len > 0 && var_domain != '0') {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	} else {
		var__networks = rt.call_function('get_networks', [
			rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' },
				rt.ArrayItem{ key: 'number', val: 1 }, rt.ArrayItem{ key: 'domain', val: domain },
				rt.ArrayItem{ key: 'path', val: path }]),
		])
		var_network_id = if !(!rt.is_true(var__networks)) { rt.call_function('array_shift', [
				var__networks.clone(),
			]) } else { rt.new_int(0) }
	}
	if rt.is_true(var_network_id) {
		return (rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT u.ID, u.user_login, u.user_pass FROM '), rt.get_property(var_wpdb,
					'users')), rt.new_string(' AS u, ')), rt.get_property(var_wpdb, 'sitemeta')),
					rt.new_string(" AS sm WHERE sm.meta_key = 'admin_user_id' AND u.ID = sm.meta_value AND sm.site_id = %d")),
				var_network_id.clone(),
			]),
			rt.get_constant('ARRAY_A'),
		])).to_bool()
	}
	return false
}

fn wp_get_sites(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var__sites := rt.new_null()
	mut var_results := []rt.PhpVal{}
	mut var__site := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.6.0'), rt.new_string('get_sites()')])
	if rt.is_true(rt.call_function('wp_is_large_network', []rt.PhpVal{})) {
		return rt.new_array()
	}
	var_defaults = {
		'network_id': rt.call_function('get_current_network_id', []rt.PhpVal{})
		'public':     rt.new_null()
		'archived':   rt.new_null()
		'mature':     rt.new_null()
		'spam':       rt.new_null()
		'deleted':    rt.new_null()
		'limit':      rt.new_int(100)
		'offset':     rt.new_int(0)
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('network_id')).is_array())) {
		var_args.array_set('network__in', var_args.array_get(rt.new_string('network_id')))
		var_args.array_set('network_id', rt.new_null())
	}
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('limit')).is_long()
		|| var_args.array_get(rt.new_string('limit')).is_double()))
	{
		var_args.array_set('number', var_args.array_get(rt.new_string('limit')))
		var_args.array_set('limit', rt.new_null())
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('limit')))))) {
		var_args.array_set('number', 0)
		var_args.array_set('limit', rt.new_null())
	}
	var_args.array_set('count', false)
	var__sites = rt.call_function('get_sites', [var_args.clone()])
	var_results = rt.new_array()
	mut iter_5 := var__sites.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var__site_shadow := item_5.val
		var__site_shadow = rt.call_function('get_site', [var__site_shadow.clone()])
		var_results << rt.call_method(var__site_shadow, 'to_array', []rt.PhpVal{})
	}
	return var_results.clone()
}

fn is_user_option_local(var_key rt.PhpVal, user_id i64, blog_id i64) rt.PhpVal {
	mut var_user_id := user_id
	mut var_blog_id := blog_id
	mut var_wpdb := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_local_key := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.9.0')])
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if var_blog_id == 0 {
		var_blog_id = (rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64()
	}
	var_local_key = rt.new_string(
		(rt.call_method(var_wpdb, 'get_blog_prefix', [rt.new_int(var_blog_id)])).str() +
		var_key.str())
	return rt.new_bool(!(rt.get_property(var_current_user,
		'{"nodeType":"Expr_Variable","line":554,"name":"local_key"}')).is_null())
}

fn insert_blog(var_domain rt.PhpVal, var_path rt.PhpVal, var_site_id_arg rt.PhpVal) bool {
	mut var_site_id := var_site_id_arg
	mut var_data := map[string]rt.PhpVal{}
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.1.0'), rt.new_string('wp_insert_site()')])
	var_data = {
		'domain':  var_domain
		'path':    var_path
		'site_id': var_site_id
	}
	var_site_id = rt.call_function('wp_insert_site', [
		rt.create_array_from_native_map(var_data),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_site_id.clone()])) {
		return false
	}
	rt.call_function('clean_blog_cache', [var_site_id.clone()])
	return var_site_id.to_bool()
}

fn install_blog(var_blog_id_arg rt.PhpVal, blog_title string) {
	mut var_blog_title := blog_title
	mut var_blog_id := var_blog_id_arg
	mut var_wpdb := rt.new_null()
	mut var_suppress := rt.new_null()
	mut var_url := rt.new_null()
	mut var_wp_roles := rt.new_null()
	mut var_siteurl := rt.new_null()
	mut var_home := rt.new_null()
	mut var_table_prefix := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.1.0')])
	var_blog_id = rt.new_int(var_blog_id.to_i64())
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('DESCRIBE '), rt.get_property(var_wpdb, 'posts')),
	]))
	{
		fn () {
			print(('<h1>' + (rt.call_function('__', [rt.new_string('Already Installed')])).str() +
				'</h1><p>' +
				(rt.call_function('__', [rt.new_string('You appear to have already installed WordPress. To reinstall please clear your old database tables first.')])).str() +
				'</p></body></html>').str())
			exit(0)
		}()
	}
	rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
	var_url = rt.call_function('get_blogaddress_by_id', [var_blog_id.clone()])
	rt.call_function('make_db_current_silent', [rt.new_string('blog')])
	rt.call_function('populate_options', []rt.PhpVal{})
	rt.call_function('populate_roles', []rt.PhpVal{})
	var_wp_roles = create_wp_roles()
	var_home = rt.call_function('untrailingslashit', [var_url.clone()])
	var_siteurl = var_home
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) {
		if rt.is_true(rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
			rt.call_function('get_site_option', [rt.new_string('siteurl')]),
			rt.get_constant('PHP_URL_SCHEME'),
		])))
		{
			var_siteurl = rt.call_function('set_url_scheme', [
				var_siteurl.clone(), rt.new_string('https')])
		}
		if rt.is_true(rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
			rt.call_function('get_home_url', [
				rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_id'),
			]),
			rt.get_constant('PHP_URL_SCHEME'),
		])))
		{
			var_home = rt.call_function('set_url_scheme', [var_home.clone(),
				rt.new_string('https')])
		}
	}
	rt.call_function('update_option', [rt.new_string('siteurl'),
		var_siteurl.clone()])
	rt.call_function('update_option', [rt.new_string('home'),
		var_home.clone()])
	if rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('ms_files_rewriting'),
	]))
	{
		rt.call_function('update_option', [rt.new_string('upload_path'),
			rt.new_string(
				(rt.get_constant('UPLOADBLOGSDIR')).str() + '/${var_blog_id.to_string()}/files')])
	} else {
		rt.call_function('update_option', [rt.new_string('upload_path'),
			rt.call_function('get_blog_option', [
				rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_id'),
				rt.new_string('upload_path'),
			])])
	}
	rt.call_function('update_option', [rt.new_string('blogname'),
		rt.call_function('wp_unslash', [rt.new_string(blog_title)])])
	rt.call_function('update_option', [rt.new_string('admin_email'),
		rt.new_string('')])
	var_table_prefix = rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})
	rt.call_function('delete_metadata', [rt.new_string('user'),
		rt.new_int(0), rt.new_string(var_table_prefix.str() + 'user_level'),
		rt.new_null(), rt.new_bool(true)])
	rt.call_function('delete_metadata', [rt.new_string('user'),
		rt.new_int(0), rt.new_string(var_table_prefix.str() + 'capabilities'),
		rt.new_null(), rt.new_bool(true)])
}

fn install_blog_defaults(var_blog_id rt.PhpVal, var_user_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_suppress := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('MU')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
	rt.call_function('wp_install_defaults', [var_user_id.clone()])
	rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
}

fn update_user_status(var_id rt.PhpVal, var_pref rt.PhpVal, var_value rt.PhpVal, var_deprecated rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_user := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.3.0'), rt.new_string('wp_update_user()')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_deprecated)))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.2')])
	}
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'users'),
		rt.create_array([
			rt.ArrayItem{ key: rt.call_function('sanitize_key', [
				var_pref.clone()]), val: var_value },
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'ID', val: var_id },
		])])
	var_user = create_wp_user(var_id.clone())
	rt.call_function('clean_user_cache', [var_user.clone()])
	if rt.is_true(rt.identical(rt.new_string('spam'), var_pref)) {
		if rt.is_true(rt.equal(var_value, rt.new_int(1))) {
			rt.call_function('do_action', [rt.new_string('make_spam_user'),
				var_id.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('make_ham_user'),
				var_id.clone()])
		}
	}
	return var_value.clone()
}

fn global_terms(var_term_id rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('6.1.0')])
	return var_term_id.clone()
}

struct Class_WP_Roles {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_wp_roles(_args ...rt.PhpVal) &Class_WP_Roles {
	mut obj := &Class_WP_Roles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Roles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Roles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Roles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('graceful_fail'),
	])))))
	{
	}
}
