import rt

fn get_dashboard_blog() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.1.0'), rt.new_string('get_site()')])
	if rt.is_true(mut var_blog := rt.call_function('get_site_option', [rt.new_string('dashboard_blog')])) {
		return rt.call_function('get_site', [var_blog.dup()])
	}
	return rt.call_function('get_site', [rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_id')])
}

fn generate_random_password(len i64) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('wp_generate_password()')])
	return rt.call_function('wp_generate_password', [rt.new_int(len)])
}

fn is_site_admin(user_login string) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('is_super_admin()')])
	if user_login == '' {
		mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
			return false
		}
	} else {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('login'), rt.new_string(user_login)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
			return false
		}
		var_user_id = rt.get_property(var_user, 'ID')
	}
	return (rt.call_function('is_super_admin', [var_user_id.dup()])).to_bool()
}

fn graceful_fail(var_message rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('wp_die()')])
	var_message = rt.call_function('apply_filters', [rt.new_string('graceful_fail'), var_message.dup()])
	mut var_message_template := rt.call_function('apply_filters', [rt.new_string('graceful_fail_template'), rt.new_string('<!DOCTYPE html>\n<html><head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />\n<title>Error!</title>\n<style>\nimg {\n\tborder: 0;\n}\nbody {\nline-height: 1.6em; font-family: Georgia, serif; width: 390px; margin: auto;\ntext-align: center;\n}\n.message {\n\tfont-size: 22px;\n\twidth: 350px;\n\tmargin: auto;\n}\n</style>\n</head>\n<body>\n<p class="message">%s</p>\n</body>\n</html>')])
	// unsupported expression: Expr_Exit
}

fn get_user_details(var_username rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('get_user_by()')])
	return rt.call_function('get_user_by', [rt.new_string('login'), var_username.dup()])
}

fn clear_global_post_cache(var_post_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('clean_post_cache()')])
}

fn is_main_blog() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('is_main_site()')])
	return rt.call_function('is_main_site', []rt.PhpVal{})
}

fn validate_email(var_email rt.PhpVal, check_domain bool) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('is_email()')])
	return rt.call_function('is_email', [var_email.dup(), rt.new_bool(check_domain)])
}

fn get_blog_list(start i64, num i64, deprecated string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0'), rt.new_string('wp_get_sites()')])
	// unsupported statement: Stmt_Global
	mut var_blogs := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT blog_id, domain, path FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE site_id = %d AND public = \'1\' AND archived = \'0\' AND mature = \'0\' AND spam = \'0\' AND deleted = \'0\' ORDER BY registered DESC')), rt.call_function('get_current_network_id', []rt.PhpVal{})]), rt.get_constant('ARRAY_A')])
	mut var_blog_list := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_blogs).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_details := item_1.val
			var_blog_list.array_set(var_details.array_get('blog_id'), var_details.dup())
			var_blog_list.array_get_mut(var_details.array_get('blog_id')).array_set('postcount', rt.call_method(var_wpdb, 'get_var', ['SELECT COUNT(ID) FROM ' + (rt.call_method(var_wpdb, 'get_blog_prefix', [var_details.array_get('blog_id')])).str() + 'posts WHERE post_status=\'publish\' AND post_type=\'post\'']))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blog_list)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.identical(rt.new_string('all'), rt.new_int(num))) {
		return rt.call_function('array_slice', [var_blog_list.dup(), rt.new_int(start), rt.new_int(var_blog_list.dup().array_count())])
	} else {
		return rt.call_function('array_slice', [var_blog_list.dup(), rt.new_int(start), rt.new_int(num)])
	}
	return rt.new_null()
}

fn get_most_active_blogs(num i64, display bool) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.0.0')])
	mut var_blogs := get_blog_list(0, 'all', false)
	if rt.is_true(rt.new_bool(var_blogs.dup().is_array())) {
		rt.call_function('reset', [var_blogs.dup()])
		mut var_most_active := rt.new_array()
		mut var_blog_list := rt.new_array()
		{
			mut iter_1 := rt.cast_array(var_blogs).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_details := item_1.val
				mut var_key := item_1.key
				var_most_active.array_set(var_details.array_get('blog_id'), var_details.array_get('postcount'))
				var_blog_list.array_set(var_details.array_get('blog_id'), var_details.dup())
				// unsupported statement: Stmt_Nop
			}
		}
		rt.call_function('arsort', [var_most_active.dup()])
		rt.call_function('reset', [var_most_active.dup()])
		mut var_t := rt.new_array()
		{
			mut iter_1 := rt.cast_array(var_most_active).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_details := item_1.val
				mut var_key := item_1.key
				var_t.array_set(var_key, var_blog_list.array_get(var_key))
			}
		}
		var_most_active = rt.new_null()
		var_most_active = var_t.dup()
	}
	if var_display {
		if rt.is_true(rt.new_bool(var_most_active.dup().is_array())) {
			rt.call_function('reset', [var_most_active.dup()])
			{
				mut iter_1 := rt.cast_array(var_most_active).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_details := item_1.val
					mut var_key := item_1.key
					mut var_url := rt.call_function('esc_url', ['http://' + (var_details.array_get('domain')).str() + (var_details.array_get('path')).str()])
					print('<li>' + (var_details.array_get('postcount')).str() + " <a href='${var_url.to_string()}'>${var_url.to_string()}</a></li>")
				}
			}
		}
	}
	return rt.call_function('array_slice', [var_most_active.dup(), rt.new_int(0), rt.new_int(num)])
}

fn wpmu_admin_do_redirect(url string) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.3.0'), rt.new_string('wp_redirect()')])
	mut var_ref := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('ref')) && rt.get_superglobal('_POST').array_isset(rt.new_string('ref')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('A variable mismatch has been detected.')]), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view this item.')]), rt.new_int(400)])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('ref')) {
		var_ref = rt.get_superglobal('_POST').array_get('ref')
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('ref')) {
		var_ref = rt.get_superglobal('_GET').array_get('ref')
	}
	if rt.is_true(var_ref) {
		var_ref = rt.new_string(rt.new_string(wpmu_admin_redirect_add_updated_param(var_ref.dup())))
		rt.call_function('wp_redirect', [var_ref.dup()])
		// unsupported expression: Expr_Exit
	}
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('HTTP_REFERER'))) {
		rt.call_function('wp_redirect', [rt.get_superglobal('_SERVER').array_get('HTTP_REFERER')])
		// unsupported expression: Expr_Exit
	}
	url = wpmu_admin_redirect_add_updated_param(url)
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('redirect')) && rt.get_superglobal('_POST').array_isset(rt.new_string('redirect')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('A variable mismatch has been detected.')]), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view this item.')]), rt.new_int(400)])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect')) {
		if rt.is_true(rt.call_function('str_starts_with', [rt.get_superglobal('_GET').array_get('redirect'), rt.new_string('s_')])) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('redirect')) {
		url = wpmu_admin_redirect_add_updated_param(rt.get_superglobal('_POST').array_get('redirect'))
	}
	rt.call_function('wp_redirect', [rt.new_string(url)])
	// unsupported expression: Expr_Exit
}

fn wpmu_admin_redirect_add_updated_param(url string) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.3.0'), rt.new_string('add_query_arg()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(url), rt.new_string('updated=true')]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(url), rt.new_string('?')]))))) {
			return url + '?updated=true'
		} else {
			return url + '&updated=true'
		}
	}
	return url
}

fn get_user_id_from_string(var_email_or_login rt.PhpVal) i64 {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.6.0'), rt.new_string('get_user_by()')])
	if rt.is_true(rt.call_function('is_email', [var_email_or_login.dup()])) {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_or_login.dup()])
	} else if rt.is_true(rt.new_bool(var_email_or_login.dup().is_long() || var_email_or_login.dup().is_double())) {
		return (var_email_or_login).to_i64()
	} else {
		var_user = rt.call_function('get_user_by', [rt.new_string('login'), var_email_or_login.dup()])
	}
	if rt.is_true(var_user) {
		return (rt.get_property(var_user, 'ID')).to_i64()
	}
	return 0
}

fn get_blogaddress_by_domain(var_domain rt.PhpVal, var_path rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.7.0')])
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		mut var_url := rt.new_string( + ().str() + (var_path).str())
	} else {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
			mut var_blogname := 
			
		} else {
		}
	}
	return rt.call_function('sanitize_url', [.dup()])
}

fn create_empty_blog(var_domain rt.PhpVal, var_path rt.PhpVal, var_weblog_title rt.PhpVal, site_id i64) rt.PhpVal {
}



pub fn init_wp_includes_ms_deprecated_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('graceful_fail')]))))) {
	}
}
