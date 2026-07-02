import rt
import crypto.md5

fn get_sitestats() rt.PhpVal {
	mut var_stats := map[string]rt.PhpVal{}
	var_stats = {
		'blogs': get_blog_count(rt.new_null())
		'users': rt.call_function('get_user_count', []rt.PhpVal{})
	}
	return var_stats.clone()
}

fn get_active_blog_for_user(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_blogs := rt.new_null()
	mut var_primary_blog := rt.new_null()
	mut var_first_blog := rt.new_null()
	mut var_primary := rt.new_null()
	mut var_result := rt.new_null()
	mut var_ret := rt.new_null()
	mut var_current_network_id := rt.new_null()
	mut var_blog := rt.new_null()
	mut var_blog_id := rt.new_null()
	mut var_details := rt.new_null()
	var_blogs = rt.call_function('get_blogs_of_user', [var_user_id.clone()])
	if !rt.is_true(var_blogs) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return var_blogs.array_get(rt.call_function('get_current_blog_id', []rt.PhpVal{}))
	}
	var_primary_blog = rt.call_function('get_user_meta', [var_user_id.clone(),
		rt.new_string('primary_blog'), rt.new_bool(true)])
	var_first_blog = rt.call_function('current', [var_blogs.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_primary_blog)))) {
		if !(var_blogs.array_isset(var_primary_blog)) {
			rt.call_function('update_user_meta', [var_user_id.clone(),
				rt.new_string('primary_blog'), rt.get_property(var_first_blog, 'userblog_id')])
			var_primary = rt.call_function('get_site', [
				rt.get_property(var_first_blog, 'userblog_id'),
			])
		} else {
			var_primary = rt.call_function('get_site', [var_primary_blog.clone()])
		}
	} else {
		var_result = rt.new_bool(add_user_to_blog(rt.get_property(var_first_blog, 'userblog_id'),
			var_user_id.clone(), rt.new_string('subscriber')))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_result.clone(),
		])))))
		{
			rt.call_function('update_user_meta', [var_user_id.clone(),
				rt.new_string('primary_blog'), rt.get_property(var_first_blog, 'userblog_id')])
			var_primary = var_first_blog.clone()
		}
	}
	if !(var_primary.clone().is_object())
		|| rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_primary, 'archived')))
		|| rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_primary, 'spam')))
		|| rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_primary, 'deleted'))) {
		var_blogs = rt.call_function('get_blogs_of_user', [var_user_id.clone(),
			rt.new_bool(true)])
		var_ret = rt.new_bool(false)
		if var_blogs.clone().is_array() && var_blogs.clone().array_count() > 0 {
			var_current_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
			mut iter_1 := rt.cast_array(var_blogs).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_blog_shadow := item_1.val
				mut var_blog_id_shadow := item_1.key
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_blog_shadow,
					'site_id'), var_current_network_id))))
				{
					continue
				}
				var_details = rt.call_function('get_site', [var_blog_id_shadow.clone()])
				if var_details.clone().is_object()
					&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_details, 'archived')))
					&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_details, 'spam')))
					&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_details, 'deleted'))) {
					var_ret = var_details.clone()
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_user_meta', [
						var_user_id.clone(),
						rt.new_string('primary_blog'),
						rt.new_bool(true),
					])).to_i64()), var_blog_id_shadow))))
					{
						rt.call_function('update_user_meta', [
							var_user_id.clone(), rt.new_string('primary_blog'),
							var_blog_id_shadow.clone()])
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_meta', [
						var_user_id.clone(),
						rt.new_string('source_domain'),
						rt.new_bool(true),
					])))))
					{
						rt.call_function('update_user_meta', [
							var_user_id.clone(), rt.new_string('source_domain'),
							rt.get_property(var_details, 'domain')])
					}
					break
				}
			}
		} else {
			return rt.new_null()
		}
		return var_ret.clone()
	} else {
		return var_primary.clone()
	}
	return rt.new_null()
}

fn get_blog_count(var_network_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('get_network_option', [var_network_id.clone(),
		rt.new_string('blog_count')])
}

fn get_blog_post(var_blog_id rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	rt.call_function('switch_to_blog', [var_blog_id.clone()])
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return var_post.clone()
}

fn add_user_to_blog(var_blog_id rt.PhpVal, var_user_id rt.PhpVal, var_role rt.PhpVal) bool {
	mut var_user := rt.new_null()
	mut var_can_add_user := rt.new_null()
	mut var_site := rt.new_null()
	rt.call_function('switch_to_blog', [var_blog_id.clone()])
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		return (create_wp_error(rt.new_string('user_does_not_exist'), rt.call_function('__', [
			rt.new_string('The requested user does not exist.'),
		]))).to_bool()
	}
	var_can_add_user = rt.call_function('apply_filters', [
		rt.new_string('can_add_user_to_blog'),
		rt.new_bool(true),
		var_user_id.clone(),
		var_role.clone(),
		var_blog_id.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_can_add_user)))) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_can_add_user.clone()])) {
			return var_can_add_user.to_bool()
		}
		return (create_wp_error(rt.new_string('user_cannot_be_added'), rt.call_function('__', [
			rt.new_string('User cannot be added to this site.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_meta', [
		var_user_id.clone(), rt.new_string('primary_blog'), rt.new_bool(true)])))))
	{
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('primary_blog'), var_blog_id.clone()])
		var_site = rt.call_function('get_site', [var_blog_id.clone()])
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('source_domain'), rt.get_property(var_site, 'domain')])
	}
	rt.call_method(var_user, 'set_role', [var_role.clone()])
	rt.call_function('do_action', [rt.new_string('add_user_to_blog'),
		var_user_id.clone(), var_role.clone(), var_blog_id.clone()])
	rt.call_function('clean_user_cache', [var_user_id.clone()])
	rt.call_function('wp_cache_delete', [
		rt.new_string(var_blog_id.str() + '_user_count'),
		rt.new_string('blog-details'),
	])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return true
}

fn remove_user_from_blog(var_user_id_arg rt.PhpVal, blog_id i64, reassign i64) bool {
	mut var_blog_id := blog_id
	mut var_reassign := reassign
	mut var_user_id := var_user_id_arg
	mut var_wpdb := rt.new_null()
	mut var_primary_blog := rt.new_null()
	mut var_new_id := rt.new_null()
	mut var_new_domain := rt.new_null()
	mut var_blogs := rt.new_null()
	mut var_blog := rt.new_null()
	mut var_user := rt.new_null()
	mut var_post_ids := rt.new_null()
	mut var_link_ids := rt.new_null()
	var_user_id = rt.new_int(var_user_id.to_i64())
	var_blog_id = var_blog_id
	rt.call_function('switch_to_blog', [rt.new_int(var_blog_id)])
	rt.call_function('do_action', [rt.new_string('remove_user_from_blog'),
		var_user_id.clone(), rt.new_int(var_blog_id), rt.new_int(var_reassign)])
	var_primary_blog = rt.new_int((rt.call_function('get_user_meta', [
		var_user_id.clone(), rt.new_string('primary_blog'), rt.new_bool(true)])).to_i64())
	if rt.is_true(rt.identical(var_primary_blog, rt.new_int(var_blog_id))) {
		var_new_id = rt.new_string('')
		var_new_domain = rt.new_string('')
		var_blogs = rt.call_function('get_blogs_of_user', [var_user_id.clone()])
		mut iter_2 := rt.cast_array(var_blogs).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_blog_shadow := item_2.val
			if rt.is_true(rt.identical(rt.get_property(var_blog_shadow, 'userblog_id'),
				rt.new_int(var_blog_id)))
			{
				continue
			}
			var_new_id = rt.get_property(var_blog_shadow, 'userblog_id')
			var_new_domain = rt.get_property(var_blog_shadow, 'domain')
			break
		}
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('primary_blog'), var_new_id.clone()])
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('source_domain'), var_new_domain.clone()])
	}
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		return (create_wp_error(rt.new_string('user_does_not_exist'), rt.call_function('__', [
			rt.new_string('That user does not exist.'),
		]))).to_bool()
	}
	rt.call_method(var_user, 'remove_all_caps', []rt.PhpVal{})
	var_blogs = rt.call_function('get_blogs_of_user', [var_user_id.clone()])
	if var_blogs.clone().array_count() == 0 {
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('primary_blog'), rt.new_string('')])
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('source_domain'), rt.new_string('')])
	}
	if var_reassign != 0 {
		var_reassign = var_reassign
		var_post_ids = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')), rt.new_string(' WHERE post_author = %d')),
				var_user_id.clone(),
			]),
		])
		var_link_ids = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb,
					'links')), rt.new_string(' WHERE link_owner = %d')),
				var_user_id.clone(),
			]),
		])
		if !(!rt.is_true(var_post_ids)) {
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('UPDATE '),
						rt.get_property(var_wpdb, 'posts')),
						rt.new_string(' SET post_author = %d WHERE post_author = %d')),
					rt.new_int(var_reassign),
					var_user_id.clone(),
				]),
			])
			rt.call_function('array_walk', [var_post_ids.clone(),
				rt.new_string('clean_post_cache')])
		}
		if !(!rt.is_true(var_link_ids)) {
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('UPDATE '),
						rt.get_property(var_wpdb, 'links')),
						rt.new_string(' SET link_owner = %d WHERE link_owner = %d')),
					rt.new_int(var_reassign),
					var_user_id.clone(),
				]),
			])
			rt.call_function('array_walk', [var_link_ids.clone(),
				rt.new_string('clean_bookmark_cache')])
		}
	}
	rt.call_function('clean_user_cache', [var_user_id.clone()])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return true
}

fn get_blog_permalink(var_blog_id rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_link := rt.new_null()
	rt.call_function('switch_to_blog', [var_blog_id.clone()])
	var_link = rt.call_function('get_permalink', [var_post_id.clone()])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return var_link.clone()
}

fn get_blog_id_from_url(var_domain_arg rt.PhpVal, path string) i64 {
	mut var_path := path
	mut var_domain := var_domain_arg
	mut var_id := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	mut var_result := rt.new_null()
	var_domain = var_domain.to_lower()
	var_path = var_path.to_lower()
	var_id = rt.call_function('wp_cache_get', [
		rt.new_string(md5.hexhash(var_domain + var_path)),
		rt.new_string('blog-id-cache'),
	])
	if rt.is_true(rt.identical(-1, var_id)) {
		return 0
	} else if rt.is_true(var_id) {
		return rt.new_int(var_id.to_i64())
	}
	var_args = {
		'domain':                 rt.new_string(var_domain.str())
		'path':                   rt.new_string(var_path.str())
		'fields':                 rt.new_string('ids')
		'number':                 rt.new_int(1)
		'update_site_meta_cache': rt.new_bool(false)
	}
	var_result = rt.call_function('get_sites', [
		rt.create_array_from_native_map(var_args),
	])
	var_id = rt.call_function('array_shift', [var_result.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		rt.call_function('wp_cache_set', [
			rt.new_string(md5.hexhash(var_domain + var_path)),
			rt.new_int(-1),
			rt.new_string('blog-id-cache'),
		])
		return 0
	}
	rt.call_function('wp_cache_set', [rt.new_string(md5.hexhash(var_domain + var_path)),
		var_id.clone(), rt.new_string('blog-id-cache')])
	return var_id.to_i64()
}

fn is_email_address_unsafe(var_user_email rt.PhpVal) rt.PhpVal {
	mut var_email_local_part := rt.new_null()
	mut var_email_domain := rt.new_null()
	mut var_banned_names := rt.new_null()
	mut var_is_email_address_unsafe := false
	mut var_normalized_email := ''
	mut var_banned_domain := rt.new_null()
	var_banned_names = rt.call_function('get_site_option', [
		rt.new_string('banned_email_domains'),
	])
	if rt.is_true(var_banned_names) && !(var_banned_names.clone().is_array()) {
		var_banned_names = rt.call_function('explode', [rt.new_string('\n'),
			var_banned_names.clone()])
	}
	var_is_email_address_unsafe = false
	if rt.is_true(var_banned_names) && var_banned_names.clone().is_array()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_user_email.clone(), rt.new_string('@'), rt.new_int(1)]))))) {
		var_banned_names = rt.call_function('array_map', [rt.new_string('strtolower'),
			var_banned_names.clone()])
		var_normalized_email = var_user_email.clone().to_string().to_lower()
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('@'),
			rt.new_string(var_normalized_email.str()).clone()])
		var_email_local_part = list_tmp_1.array_get(0)
		var_email_domain = list_tmp_1.array_get(1)
		mut iter_3 := var_banned_names.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_banned_domain_shadow := item_3.val
			if rt.is_true(rt.new_bool(!(rt.is_true(var_banned_domain_shadow)))) {
				continue
			}
			if rt.is_true(rt.identical(var_email_domain, var_banned_domain_shadow)) {
				var_is_email_address_unsafe = true
				break
			}
			if rt.is_true(rt.call_function('str_ends_with', [
				rt.new_string(var_normalized_email.str()).clone(),
				rt.new_string('.${var_banned_domain.to_string()}')]))
			{
				var_is_email_address_unsafe = true
				break
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('is_email_address_unsafe'),
		rt.new_bool(var_is_email_address_unsafe).clone(), var_user_email.clone()])
}

fn wpmu_validate_user_signup(var_user_name_arg rt.PhpVal, var_user_email_arg rt.PhpVal) rt.PhpVal {
	mut var_user_name := var_user_name_arg
	mut var_user_email := var_user_email_arg
	mut var_wpdb := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_orig_username := rt.new_null()
	mut var_illegal_names := rt.new_null()
	mut var_illegal_logins := rt.new_null()
	mut var_limited_email_domains := rt.new_null()
	mut var_email_domain := ''
	mut var_signup := rt.new_null()
	mut var_registered_at := rt.new_null()
	mut var_now := rt.new_null()
	mut var_diff := rt.new_null()
	mut var_result := rt.new_null()
	var_errors = create_wp_error()
	var_orig_username = var_user_name.clone()
	var_user_name = rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
		rt.new_string(''), rt.call_function('sanitize_user', [
			var_user_name.clone(), rt.new_bool(true)])])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_user_name, var_orig_username))))
		|| rt.is_true(rt.call_function('preg_match', [rt.new_string('/[^a-z0-9]/'), var_user_name.clone()])) {
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Usernames can only contain lowercase letters (a-z) and numbers.'),
		]))
		var_user_name = var_orig_username.clone()
	}
	var_user_email = rt.call_function('sanitize_email', [var_user_email.clone()])
	if !rt.is_true(var_user_name) {
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Please enter a username.'),
		]))
	}
	var_illegal_names = rt.call_function('get_site_option', [
		rt.new_string('illegal_names'),
	])
	if !(var_illegal_names.clone().is_array()) {
		var_illegal_names = rt.create_array([rt.ArrayItem{ key: none, val: 'www' },
			rt.ArrayItem{ key: none, val: 'web' }, rt.ArrayItem{ key: none, val: 'root' },
			rt.ArrayItem{ key: none, val: 'admin' }, rt.ArrayItem{ key: none, val: 'main' },
			rt.ArrayItem{ key: none, val: 'invite' }, rt.ArrayItem{ key: none, val: 'administrator' }])
		rt.call_function('add_site_option', [rt.new_string('illegal_names'),
			var_illegal_names.clone()])
	}
	if rt.is_true(rt.call_function('in_array', [var_user_name.clone(),
		var_illegal_names.clone(), rt.new_bool(true)]))
	{
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Sorry, that username is not allowed.'),
		]))
	}
	var_illegal_logins = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('illegal_user_logins'),
		rt.new_array(),
	]))
	if rt.is_true(rt.call_function('in_array', [
		rt.new_string(var_user_name.clone().to_string().to_lower()),
		rt.call_function('array_map', [rt.new_string('strtolower'),
			var_illegal_logins.clone()]),
		rt.new_bool(true),
	]))
	{
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Sorry, that username is not allowed.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_user_email.clone()])))))
	{
		var_errors.add(rt.new_string('user_email'), rt.call_function('__', [
			rt.new_string('Please enter a valid email address.'),
		]))
	} else if rt.is_true(is_email_address_unsafe(var_user_email.clone())) {
		var_errors.add(rt.new_string('user_email'), rt.call_function('__', [
			rt.new_string('You cannot use that email address to signup. There are problems with them blocking some emails from WordPress. Please use another email provider.'),
		]))
	}
	if var_user_name.clone().to_string().len < 4 {
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Username must be at least 4 characters.'),
		]))
	}
	if var_user_name.clone().to_string().len > 60 {
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Username may not be longer than 60 characters.'),
		]))
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]*$/'),
		var_user_name.clone()]))
	{
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Sorry, usernames must have letters too!'),
		]))
	}
	var_limited_email_domains = rt.call_function('get_site_option', [
		rt.new_string('limited_email_domains'),
	])
	if var_limited_email_domains.clone().is_array() && !(!rt.is_true(var_limited_email_domains)) {
		var_limited_email_domains = rt.call_function('array_map', [
			rt.new_string('strtolower'),
			var_limited_email_domains.clone(),
		])
		var_email_domain = rt.call_function('substr', [var_user_email.clone(),
			rt.add(rt.new_int(1), rt.call_function('strpos', [
				var_user_email.clone(), rt.new_string('@')]))]).to_string().to_lower()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string(var_email_domain.str()).clone(), var_limited_email_domains.clone(),
			rt.new_bool(true)])))))
		{
			var_errors.add(rt.new_string('user_email'), rt.call_function('__', [
				rt.new_string('Sorry, that email address is not allowed!'),
			]))
		}
	}
	if rt.is_true(rt.call_function('username_exists', [var_user_name.clone()])) {
		var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
			rt.new_string('Sorry, that username already exists!'),
		]))
	}
	if rt.is_true(rt.call_function('email_exists', [var_user_email.clone()])) {
		var_errors.add(rt.new_string('user_email'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('<strong>Error:</strong> This email address is already registered. <a href="%s">Log in</a> with this address or choose another one.'),
			]),
			rt.call_function('wp_login_url', []rt.PhpVal{}),
		]))
	}
	var_signup = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'signups')), rt.new_string(' WHERE user_login = %s')),
			var_user_name.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(rt.instance_of(var_signup, 'stdClass'))) {
		var_registered_at = rt.call_function('mysql2date', [rt.new_string('U'),
			rt.get_property(var_signup, 'registered')])
		var_now = rt.call_function('time', []rt.PhpVal{})
		var_diff = rt.sub(var_now, var_registered_at)
		if rt.is_true(rt.greater(var_diff, rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS')))) {
			rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'signups'),
				rt.create_array([rt.ArrayItem{ key: 'user_login', val: var_user_name }])])
		} else {
			var_errors.add(rt.new_string('user_name'), rt.call_function('__', [
				rt.new_string('That username is currently reserved but may be available in a couple of days.'),
			]))
		}
	}
	var_signup = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'signups')), rt.new_string(' WHERE user_email = %s')),
			var_user_email.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(rt.instance_of(var_signup, 'stdClass'))) {
		var_diff = rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_function('mysql2date', [
			rt.new_string('U'),
			rt.get_property(var_signup, 'registered'),
		]))
		if rt.is_true(rt.greater(var_diff, rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS')))) {
			rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'signups'),
				rt.create_array([rt.ArrayItem{ key: 'user_email', val: var_user_email }])])
		} else {
			var_errors.add(rt.new_string('user_email'), rt.call_function('__', [
				rt.new_string('That email address is pending activation and is not available for new registration. If you made a previous attempt with this email address, please check your inbox for an activation email. If left unconfirmed, it will become available in a couple of days.'),
			]))
		}
	}
	var_result = rt.create_array([rt.ArrayItem{ key: 'user_name', val: var_user_name },
		rt.ArrayItem{ key: 'orig_username', val: var_orig_username },
		rt.ArrayItem{ key: 'user_email', val: var_user_email },
		rt.ArrayItem{ key: 'errors', val: var_errors }])
	return rt.call_function('apply_filters', [rt.new_string('wpmu_validate_user_signup'),
		var_result.clone()])
}

fn wpmu_validate_blog_signup(var_blogname_arg rt.PhpVal, var_blog_title_arg rt.PhpVal, user string) rt.PhpVal {
	mut var_user := user
	mut var_blogname := var_blogname_arg
	mut var_blog_title := var_blog_title_arg
	mut var_wpdb := rt.new_null()
	mut var_domain := rt.new_null()
	mut var_current_network := rt.new_null()
	mut var_base := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_illegal_names := rt.new_null()
	mut var_minimum_site_name_length := rt.new_null()
	mut var_mydomain := rt.new_null()
	mut var_path := rt.new_null()
	mut var_signup := rt.new_null()
	mut var_diff := rt.new_null()
	mut var_result := rt.new_null()
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	var_base = rt.get_property(var_current_network, 'path')
	var_blog_title = rt.call_function('strip_tags', [var_blog_title.clone()])
	var_errors = create_wp_error()
	var_illegal_names = rt.call_function('get_site_option', [
		rt.new_string('illegal_names'),
	])
	if !(var_illegal_names.clone().is_array()) {
		var_illegal_names = rt.create_array([rt.ArrayItem{ key: none, val: 'www' },
			rt.ArrayItem{ key: none, val: 'web' }, rt.ArrayItem{ key: none, val: 'root' },
			rt.ArrayItem{ key: none, val: 'admin' }, rt.ArrayItem{ key: none, val: 'main' },
			rt.ArrayItem{ key: none, val: 'invite' }, rt.ArrayItem{ key: none, val: 'administrator' }])
		rt.call_function('add_site_option', [rt.new_string('illegal_names'),
			var_illegal_names.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) {
		var_illegal_names = rt.call_function('array_merge', [
			var_illegal_names.clone(), get_subdirectory_reserved_names()])
	}
	if !rt.is_true(var_blogname) {
		var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
			rt.new_string('Please enter a site name.'),
		]))
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[^a-z0-9]+/'),
		var_blogname.clone()]))
	{
		var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
			rt.new_string('Site names can only contain lowercase letters (a-z) and numbers.'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [var_blogname.clone(),
		var_illegal_names.clone(), rt.new_bool(true)]))
	{
		var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
			rt.new_string('That name is not allowed.'),
		]))
	}
	var_minimum_site_name_length = rt.call_function('apply_filters', [
		rt.new_string('minimum_site_name_length'),
		rt.new_int(4),
	])
	if rt.is_true(rt.less(rt.new_int(var_blogname.clone().to_string().len),
		var_minimum_site_name_length))
	{
		var_errors.add(rt.new_string('blogname'), rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('Site name must be at least %s character.'),
				rt.new_string('Site name must be at least %s characters.'),
				var_minimum_site_name_length.clone(),
			]),
			rt.call_function('number_format_i18n', [
				var_minimum_site_name_length.clone(),
			]),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT post_name FROM ' + (rt.call_method(var_wpdb, 'get_blog_prefix', [rt.get_property(var_current_network, 'site_id')])).str() + "posts WHERE post_type = 'page' AND post_name = %s"), var_blogname.clone()])])) {
		var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
			rt.new_string('Sorry, you may not use that site name.'),
		]))
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]*$/'),
		var_blogname.clone()]))
	{
		var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
			rt.new_string('Sorry, site names must have letters too!'),
		]))
	}
	var_blogname = rt.call_function('apply_filters', [rt.new_string('newblogname'),
		var_blogname.clone()])
	var_blog_title = rt.call_function('wp_unslash', [var_blog_title.clone()])
	if !rt.is_true(var_blog_title) {
		var_errors.add(rt.new_string('blog_title'), rt.call_function('__', [
			rt.new_string('Please enter a site title.'),
		]))
	}
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		var_mydomain =
			rt.new_string(var_blogname.str() + '.' +(rt.call_function('preg_replace', [rt.new_string('|^www\\.|'), rt.new_string(''), var_domain.clone()])).str())
		var_path = var_base.clone()
	} else {
		var_mydomain = var_domain.clone()
		var_path = rt.new_string(var_base.str() + var_blogname.str() + '/')
	}
	if rt.is_true(domain_exists(var_mydomain.clone(), var_path.clone(), rt.get_property(var_current_network,
		'id')))
	{
		var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
			rt.new_string('Sorry, that site already exists!'),
		]))
	}
	if rt.is_true(rt.call_function('username_exists', [var_blogname.clone()])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(user), 'WP_User'))))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(rt.new_string(user), 'user_login'), var_blogname)))) {
			var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
				rt.new_string('Sorry, that site is reserved!'),
			]))
		}
	}
	var_signup = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'signups')), rt.new_string(' WHERE domain = %s AND path = %s')),
			var_mydomain.clone(),
			var_path.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(rt.instance_of(var_signup, 'stdClass'))) {
		var_diff = rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_function('mysql2date', [
			rt.new_string('U'),
			rt.get_property(var_signup, 'registered'),
		]))
		if rt.is_true(rt.greater(var_diff, rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS')))) {
			rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'signups'),
				rt.create_array([rt.ArrayItem{ key: 'domain', val: var_mydomain },
					rt.ArrayItem{ key: 'path', val: var_path }])])
		} else {
			var_errors.add(rt.new_string('blogname'), rt.call_function('__', [
				rt.new_string('That site is currently reserved but may be available in a couple days.'),
			]))
		}
	}
	var_result = rt.create_array([rt.ArrayItem{ key: 'domain', val: var_mydomain },
		rt.ArrayItem{ key: 'path', val: var_path }, rt.ArrayItem{ key: 'blogname', val: var_blogname },
		rt.ArrayItem{ key: 'blog_title', val: var_blog_title },
		rt.ArrayItem{ key: 'user', val: user }, rt.ArrayItem{ key: 'errors', val: var_errors }])
	return rt.call_function('apply_filters', [rt.new_string('wpmu_validate_blog_signup'),
		var_result.clone()])
}

fn wpmu_signup_blog(var_domain rt.PhpVal, var_path rt.PhpVal, var_title rt.PhpVal, var_user rt.PhpVal, var_user_email rt.PhpVal, var_meta_arg rt.PhpVal) {
	mut var_meta := var_meta_arg
	mut var_wpdb := rt.new_null()
	mut var_key := rt.new_null()
	var_key = rt.call_function('substr', [
		rt.new_string(md5.hexhash((rt.call_function('time', []rt.PhpVal{})).str() +
			(rt.call_function('wp_rand', []rt.PhpVal{})).str() + var_domain.str())),
		rt.new_int(0),
		rt.new_int(16),
	])
	var_meta = rt.call_function('apply_filters', [rt.new_string('signup_site_meta'),
		var_meta.clone(), var_domain.clone(), var_path.clone(),
		var_title.clone(), var_user.clone(), var_user_email.clone(),
		var_key.clone()])
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'signups'),
		rt.create_array([rt.ArrayItem{ key: 'domain', val: var_domain },
			rt.ArrayItem{ key: 'path', val: var_path }, rt.ArrayItem{ key: 'title', val: var_title },
			rt.ArrayItem{ key: 'user_login', val: var_user },
			rt.ArrayItem{ key: 'user_email', val: var_user_email },
			rt.ArrayItem{ key: 'registered', val: rt.call_function('current_time', [
				rt.new_string('mysql'),
				rt.new_bool(true),
			]) }, rt.ArrayItem{ key: 'activation_key', val: var_key },
			rt.ArrayItem{ key: 'meta', val: rt.call_function('serialize', [
				var_meta.clone(),
			]) }])])
	rt.call_function('do_action', [rt.new_string('after_signup_site'),
		var_domain.clone(), var_path.clone(), var_title.clone(),
		var_user.clone(), var_user_email.clone(), var_key.clone(),
		var_meta.clone()])
}

fn wpmu_signup_user(var_user_arg rt.PhpVal, var_user_email_arg rt.PhpVal, var_meta_arg rt.PhpVal) {
	mut var_user := var_user_arg
	mut var_user_email := var_user_email_arg
	mut var_meta := var_meta_arg
	mut var_wpdb := rt.new_null()
	mut var_key := rt.new_null()
	var_user = rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
		rt.new_string(''), rt.call_function('sanitize_user', [
			var_user.clone(), rt.new_bool(true)])])
	var_user_email = rt.call_function('sanitize_email', [var_user_email.clone()])
	var_key = rt.call_function('substr', [
		rt.new_string(md5.hexhash((rt.call_function('time', []rt.PhpVal{})).str() +
			(rt.call_function('wp_rand', []rt.PhpVal{})).str() + var_user_email.str())),
		rt.new_int(0),
		rt.new_int(16),
	])
	var_meta = rt.call_function('apply_filters', [rt.new_string('signup_user_meta'),
		var_meta.clone(), var_user.clone(), var_user_email.clone(),
		var_key.clone()])
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'signups'),
		rt.create_array([rt.ArrayItem{ key: 'domain', val: '' },
			rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'user_login', val: var_user },
			rt.ArrayItem{ key: 'user_email', val: var_user_email },
			rt.ArrayItem{ key: 'registered', val: rt.call_function('current_time', [
				rt.new_string('mysql'),
				rt.new_bool(true),
			]) }, rt.ArrayItem{ key: 'activation_key', val: var_key },
			rt.ArrayItem{ key: 'meta', val: rt.call_function('serialize', [
				var_meta.clone(),
			]) }])])
	rt.call_function('do_action', [rt.new_string('after_signup_user'),
		var_user.clone(), var_user_email.clone(), var_key.clone(),
		var_meta.clone()])
}

fn wpmu_signup_blog_notification(var_domain rt.PhpVal, var_path rt.PhpVal, var_title rt.PhpVal, var_user_login rt.PhpVal, var_user_email rt.PhpVal, var_key rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_activate_url := rt.new_null()
	mut var_admin_email := rt.new_null()
	mut var_from_name := rt.new_null()
	mut var_message_headers := rt.new_null()
	mut var_user := rt.new_null()
	mut var_switched_locale := false
	mut var_message := rt.new_null()
	mut var_subject := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wpmu_signup_blog_notification'),
		var_domain.clone(),
		var_path.clone(),
		var_title.clone(),
		var_user_login.clone(),
		var_user_email.clone(),
		var_key.clone(),
		var_meta.clone(),
	])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_network_id', []rt.PhpVal{}), rt.new_int(1))))) {
		var_activate_url = rt.call_function('network_site_url', [
			rt.new_string('wp-activate.php?key=${var_key.to_string()}'),
		])
	} else {
		var_activate_url =
			rt.new_string('http://${var_domain.to_string()}${var_path.to_string()}wp-activate.php?key=${var_key.to_string()}')
	}
	var_activate_url = rt.call_function('esc_url', [var_activate_url.clone()])
	var_admin_email = rt.call_function('get_site_option', [rt.new_string('admin_email')])
	if rt.is_true(rt.identical(rt.new_string(''), var_admin_email)) {
		var_admin_email =
			rt.new_string('support@' +(rt.call_function('wp_parse_url', [rt.call_function('network_home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])).str())
	}
	var_from_name = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_site_option', [
		rt.new_string('site_name'),
	])))))
	{ rt.call_function('esc_html', [
			rt.call_function('get_site_option', [rt.new_string('site_name')]),
		]) } else { rt.new_string('WordPress') }
	var_message_headers = rt.new_string(
		"From: \"${var_from_name.to_string()}\" <${var_admin_email.to_string()}>\n" +
		'Content-Type: text/plain; charset="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"\n')
	var_user = rt.call_function('get_user_by', [rt.new_string('login'),
		var_user_login.clone()])
	var_switched_locale = rt.is_true(var_user)
		&& rt.is_true(rt.call_function('switch_to_user_locale', [rt.get_property(var_user, 'ID')]))
	var_message = rt.call_function('sprintf', [
		rt.call_function('apply_filters', [
			rt.new_string('wpmu_signup_blog_notification_email'),
			rt.call_function('__', [
				rt.new_string('To activate your site, please click the following link:\n\n%1$s\n\nAfter you activate, you will receive *another email* with your login.\n\nAfter you activate, you can visit your site here:\n\n%2$s'),
			]),
			var_domain.clone(),
			var_path.clone(),
			var_title.clone(),
			var_user_login.clone(),
			var_user_email.clone(),
			var_key.clone(),
			var_meta.clone(),
		]),
		var_activate_url.clone(),
		rt.call_function('esc_url', [
			rt.new_string('http://${var_domain.to_string()}${var_path.to_string()}'),
		]),
		var_key.clone(),
	])
	var_subject = rt.call_function('sprintf', [
		rt.call_function('apply_filters', [
			rt.new_string('wpmu_signup_blog_notification_subject'),
			rt.call_function('_x', [rt.new_string('[%1$s] Activate %2$s'),
				rt.new_string('New site notification email subject')]),
			var_domain.clone(),
			var_path.clone(),
			var_title.clone(),
			var_user_login.clone(),
			var_user_email.clone(),
			var_key.clone(),
			var_meta.clone(),
		]),
		var_from_name.clone(),
		rt.call_function('esc_url', [
			rt.new_string('http://' + var_domain.str() + var_path.str()),
		]),
	])
	rt.call_function('wp_mail', [var_user_email.clone(),
		rt.call_function('wp_specialchars_decode', [var_subject.clone()]),
		var_message.clone(), var_message_headers.clone()])
	if var_switched_locale {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	return true
}

fn wpmu_signup_user_notification(var_user_login rt.PhpVal, var_user_email rt.PhpVal, var_key rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_user := rt.new_null()
	mut var_switched_locale := false
	mut var_admin_email := rt.new_null()
	mut var_from_name := rt.new_null()
	mut var_message_headers := rt.new_null()
	mut var_message := rt.new_null()
	mut var_subject := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wpmu_signup_user_notification'),
		var_user_login.clone(),
		var_user_email.clone(),
		var_key.clone(),
		var_meta.clone(),
	])))))
	{
		return false
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('login'),
		var_user_login.clone()])
	var_switched_locale = rt.is_true(var_user)
		&& rt.is_true(rt.call_function('switch_to_user_locale', [rt.get_property(var_user, 'ID')]))
	var_admin_email = rt.call_function('get_site_option', [rt.new_string('admin_email')])
	if rt.is_true(rt.identical(rt.new_string(''), var_admin_email)) {
		var_admin_email =
			rt.new_string('support@' +(rt.call_function('wp_parse_url', [rt.call_function('network_home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])).str())
	}
	var_from_name = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_site_option', [
		rt.new_string('site_name'),
	])))))
	{ rt.call_function('esc_html', [
			rt.call_function('get_site_option', [rt.new_string('site_name')]),
		]) } else { rt.new_string('WordPress') }
	var_message_headers = rt.new_string(
		"From: \"${var_from_name.to_string()}\" <${var_admin_email.to_string()}>\n" +
		'Content-Type: text/plain; charset="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"\n')
	var_message = rt.call_function('sprintf', [
		rt.call_function('apply_filters', [
			rt.new_string('wpmu_signup_user_notification_email'),
			rt.call_function('__', [
				rt.new_string('To activate your user, please click the following link:\n\n%s\n\nAfter you activate, you will receive *another email* with your login.'),
			]),
			var_user_login.clone(),
			var_user_email.clone(),
			var_key.clone(),
			var_meta.clone(),
		]),
		rt.call_function('site_url', [
			rt.new_string('wp-activate.php?key=${var_key.to_string()}'),
		]),
	])
	var_subject = rt.call_function('sprintf', [
		rt.call_function('apply_filters', [
			rt.new_string('wpmu_signup_user_notification_subject'),
			rt.call_function('_x', [rt.new_string('[%1$s] Activate %2$s'),
				rt.new_string('New user notification email subject')]),
			var_user_login.clone(),
			var_user_email.clone(),
			var_key.clone(),
			var_meta.clone(),
		]),
		var_from_name.clone(),
		var_user_login.clone(),
	])
	rt.call_function('wp_mail', [var_user_email.clone(),
		rt.call_function('wp_specialchars_decode', [var_subject.clone()]),
		var_message.clone(), var_message_headers.clone()])
	if var_switched_locale {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	return true
}

fn wpmu_activate_signup(var_key rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_signup := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_password := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_user_already_exists := false
	mut var_now := rt.new_null()
	mut var_blog_id := rt.new_null()
	var_signup = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'signups')), rt.new_string(' WHERE activation_key = %s')),
			var_key.clone(),
		]),
	])
	if !rt.is_true(var_signup) {
		return create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [
			rt.new_string('Invalid activation key.'),
		]))
	}
	if rt.is_true(rt.get_property(var_signup, 'active')) {
		if !rt.is_true(rt.get_property(var_signup, 'domain')) {
			return create_wp_error(rt.new_string('already_active'), rt.call_function('__', [
				rt.new_string('The user is already active.'),
			]), var_signup.clone())
		} else {
			return create_wp_error(rt.new_string('already_active'), rt.call_function('__', [
				rt.new_string('The site is already active.'),
			]), var_signup.clone())
		}
	}
	var_meta = rt.call_function('maybe_unserialize', [
		rt.get_property(var_signup, 'meta'),
	])
	var_password = rt.call_function('wp_generate_password', [
		rt.new_int(12), rt.new_bool(false)])
	var_user_id = rt.call_function('username_exists', [
		rt.get_property(var_signup, 'user_login'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		var_user_id = rt.new_bool(wpmu_create_user(rt.get_property(var_signup, 'user_login'),
			var_password.clone(), rt.get_property(var_signup, 'user_email')))
	} else {
		var_user_already_exists = true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return create_wp_error(rt.new_string('create_user'), rt.call_function('__', [
			rt.new_string('Could not create user'),
		]), var_signup.clone())
	}
	var_now = rt.call_function('current_time', [rt.new_string('mysql'),
		rt.new_bool(true)])
	if !rt.is_true(rt.get_property(var_signup, 'domain')) {
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'signups'),
			rt.create_array([rt.ArrayItem{ key: 'active', val: 1 },
				rt.ArrayItem{ key: 'activated', val: var_now }]),
			rt.create_array([rt.ArrayItem{ key: 'activation_key', val: var_key }])])
		if !(rt.new_bool(var_user_already_exists)).is_null() {
			return create_wp_error(rt.new_string('user_already_exists'), rt.call_function('__', [
				rt.new_string('That username is already activated.'),
			]), var_signup.clone())
		}
		rt.call_function('do_action', [rt.new_string('wpmu_activate_user'),
			var_user_id.clone(), var_password.clone(), var_meta.clone()])
		return rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id },
			rt.ArrayItem{ key: 'password', val: var_password },
			rt.ArrayItem{ key: 'meta', val: var_meta }])
	}
	var_blog_id = wpmu_create_blog(rt.get_property(var_signup, 'domain'), rt.get_property(var_signup,
		'path'), rt.get_property(var_signup, 'title'), var_user_id.clone(), var_meta.clone(), rt.call_function('get_current_network_id',
		[]rt.PhpVal{}))
	if rt.is_true(rt.call_function('is_wp_error', [var_blog_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('blog_taken'), rt.call_method(var_blog_id,
			'get_error_code', []rt.PhpVal{})))
		{
			rt.call_method(var_blog_id, 'add_data', [var_signup.clone()])
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'signups'),
				rt.create_array([rt.ArrayItem{ key: 'active', val: 1 },
					rt.ArrayItem{ key: 'activated', val: var_now }]),
				rt.create_array([rt.ArrayItem{ key: 'activation_key', val: var_key }])])
		}
		return var_blog_id.clone()
	}
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'signups'),
		rt.create_array([rt.ArrayItem{ key: 'active', val: 1 },
			rt.ArrayItem{ key: 'activated', val: var_now }]),
		rt.create_array([rt.ArrayItem{ key: 'activation_key', val: var_key }])])
	rt.call_function('do_action', [rt.new_string('wpmu_activate_blog'),
		var_blog_id.clone(), var_user_id.clone(), var_password.clone(),
		rt.get_property(var_signup, 'title'), var_meta.clone()])
	return rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_blog_id },
		rt.ArrayItem{ key: 'user_id', val: var_user_id }, rt.ArrayItem{
			key: 'password'
			val: var_password
		}, rt.ArrayItem{ key: 'title', val: rt.get_property(var_signup, 'title') },
		rt.ArrayItem{ key: 'meta', val: var_meta }])
}

fn wp_delete_signup_on_user_delete(var_id rt.PhpVal, var_reassign rt.PhpVal, var_user rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'signups'),
		rt.create_array([
			rt.ArrayItem{ key: 'user_login', val: rt.get_property(var_user, 'user_login') },
		])])
}

fn wpmu_create_user(var_user_name_arg rt.PhpVal, var_password rt.PhpVal, var_email rt.PhpVal) bool {
	mut var_user_name := var_user_name_arg
	mut var_user_id := rt.new_null()
	var_user_name = rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
		rt.new_string(''), rt.call_function('sanitize_user', [
			var_user_name.clone(), rt.new_bool(true)])])
	var_user_id = rt.call_function('wp_create_user', [var_user_name.clone(),
		var_password.clone(), var_email.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
		return false
	}
	rt.call_function('delete_user_option', [var_user_id.clone(),
		rt.new_string('capabilities')])
	rt.call_function('delete_user_option', [var_user_id.clone(),
		rt.new_string('user_level')])
	rt.call_function('do_action', [rt.new_string('wpmu_new_user'),
		var_user_id.clone()])
	return var_user_id.to_bool()
}

fn wpmu_create_blog(var_domain rt.PhpVal, var_path rt.PhpVal, var_title_arg rt.PhpVal, var_user_id_arg rt.PhpVal, var_options_arg rt.PhpVal, network_id i64) rt.PhpVal {
	mut var_network_id := network_id
	mut var_title := var_title_arg
	mut var_user_id := var_user_id_arg
	mut var_options := var_options_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_allowed_data_fields := []rt.PhpVal{}
	mut var_site_data := rt.new_null()
	mut var_site_initialization_data := map[string]rt.PhpVal{}
	mut var_blog_id := rt.new_null()
	var_defaults = {
		'public': 0
	}
	var_options = rt.call_function('wp_parse_args', [var_options.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_title = rt.call_function('strip_tags', [var_title.clone()])
	var_user_id = rt.new_int(var_user_id.to_i64())
	if rt.is_true(domain_exists(var_domain.clone(), var_path.clone(), network_id)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('blog_taken'), rt.call_function('__', [
			rt.new_string('Sorry, that site already exists!'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_installing', [rt.new_bool(true)])
	}
	var_allowed_data_fields = ['public', 'archived', 'mature', 'spam', 'deleted', 'lang_id']
	var_site_data = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'domain', val: var_domain },
			rt.ArrayItem{ key: 'path', val: var_path }, rt.ArrayItem{
				key: 'network_id'
				val: network_id
			}]),
		rt.call_function('array_intersect_key', [var_options.clone(),
			rt.call_function('array_flip', [
				rt.create_array_from_list(var_allowed_data_fields),
			])]),
	])
	var_site_initialization_data = {
		'title':   var_title
		'user_id': var_user_id
		'options': rt.call_function('array_diff_key', [var_options.clone(),
			rt.call_function('array_flip', [
				rt.create_array_from_list(var_allowed_data_fields),
			])])
	}
	var_blog_id = rt.call_function('wp_insert_site', [
		rt.call_function('array_merge', [var_site_data.clone(),
			rt.create_array_from_native_map(var_site_initialization_data)]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_blog_id.clone()])) {
		return var_blog_id.clone()
	}
	rt.call_function('wp_cache_set_sites_last_changed', []rt.PhpVal{})
	return var_blog_id.clone()
}

fn newblog_notify_siteadmin(var_blog_id_arg rt.PhpVal, deprecated string) bool {
	mut var_deprecated := deprecated
	mut var_blog_id := var_blog_id_arg
	mut var_email := rt.new_null()
	mut var_options_site_url := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_siteurl := rt.new_null()
	mut var_msg := rt.new_null()
	if rt.is_true(rt.new_bool(var_blog_id.clone().is_object())) {
		var_blog_id = rt.get_property(var_blog_id, 'blog_id')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_site_option', [
		rt.new_string('registrationnotification'),
	])))))
	{
		return false
	}
	var_email = rt.call_function('get_site_option', [rt.new_string('admin_email')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_email.clone()])))))
	{
		return false
	}
	var_options_site_url = rt.call_function('esc_url', [
		rt.call_function('network_admin_url', [rt.new_string('settings.php')]),
	])
	rt.call_function('switch_to_blog', [var_blog_id.clone()])
	var_blogname = rt.call_function('get_option', [rt.new_string('blogname')])
	var_siteurl = rt.call_function('site_url', []rt.PhpVal{})
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	var_msg = rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('New Site: %1$s\nURL: %2$s\nRemote IP address: %3$s\n\nDisable these notifications: %4$s'),
		]),
		var_blogname.clone(),
		var_siteurl.clone(),
		rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')),
		]),
		var_options_site_url.clone(),
	])
	var_msg = rt.call_function('apply_filters', [
		rt.new_string('newblog_notify_siteadmin'),
		var_msg.clone(),
		var_blog_id.clone(),
	])
	rt.call_function('wp_mail', [var_email.clone(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('New Site Registration: %s')]),
			var_siteurl.clone(),
		]),
		var_msg.clone()])
	return true
}

fn newuser_notify_siteadmin(var_user_id rt.PhpVal) bool {
	mut var_email := rt.new_null()
	mut var_user := rt.new_null()
	mut var_options_site_url := rt.new_null()
	mut var_msg := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_site_option', [
		rt.new_string('registrationnotification'),
	])))))
	{
		return false
	}
	var_email = rt.call_function('get_site_option', [rt.new_string('admin_email')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_email.clone()])))))
	{
		return false
	}
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	var_options_site_url = rt.call_function('esc_url', [
		rt.call_function('network_admin_url', [rt.new_string('settings.php')]),
	])
	var_msg = rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('New User: %1$s\nRemote IP address: %2$s\n\nDisable these notifications: %3$s'),
		]),
		rt.get_property(var_user, 'user_login'),
		rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')),
		]),
		var_options_site_url.clone(),
	])
	var_msg = rt.call_function('apply_filters', [
		rt.new_string('newuser_notify_siteadmin'),
		var_msg.clone(),
		var_user.clone(),
	])
	rt.call_function('wp_mail', [var_email.clone(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('New User Registration: %s')]),
			rt.get_property(var_user, 'user_login'),
		]),
		var_msg.clone()])
	return true
}

fn domain_exists(var_domain rt.PhpVal, var_path_arg rt.PhpVal, network_id i64) rt.PhpVal {
	mut var_network_id := network_id
	mut var_path := var_path_arg
	mut var_args := map[string]rt.PhpVal{}
	mut var_result := rt.new_null()
	var_path = rt.call_function('trailingslashit', [var_path.clone()])
	var_args = {
		'network_id':             rt.new_int(network_id)
		'domain':                 var_domain
		'path':                   var_path
		'fields':                 rt.new_string('ids')
		'number':                 rt.new_int(1)
		'update_site_meta_cache': rt.new_bool(false)
	}
	var_result = rt.call_function('get_sites', [
		rt.create_array_from_native_map(var_args),
	])
	var_result = rt.call_function('array_shift', [var_result.clone()])
	return rt.call_function('apply_filters', [rt.new_string('domain_exists'),
		var_result.clone(), var_domain.clone(), var_path.clone(),
		rt.new_int(network_id)])
}

fn wpmu_welcome_notification(var_blog_id rt.PhpVal, var_user_id rt.PhpVal, var_password rt.PhpVal, var_title rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_current_network := rt.new_null()
	mut var_user := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_welcome_email := rt.new_null()
	mut var_url := rt.new_null()
	mut var_admin_email := rt.new_null()
	mut var_from_name := rt.new_null()
	mut var_message_headers := rt.new_null()
	mut var_message := rt.new_null()
	mut var_subject := rt.new_null()
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wpmu_welcome_notification'),
		var_blog_id.clone(),
		var_user_id.clone(),
		var_password.clone(),
		var_title.clone(),
		var_meta.clone(),
	])))))
	{
		return false
	}
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	var_switched_locale = rt.call_function('switch_to_user_locale', [
		var_user_id.clone()])
	var_welcome_email = rt.call_function('get_site_option', [
		rt.new_string('welcome_email'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_welcome_email)))) {
		var_welcome_email = rt.call_function('__', [
			rt.new_string('Howdy USERNAME,\n\nYour new SITE_NAME site has been successfully set up at:\nBLOG_URL\n\nYou can log in to the administrator account with the following information:\n\nUsername: USERNAME\nPassword: PASSWORD\nLog in here: BLOG_URLwp-login.php\n\nWe hope you enjoy your new site. Thanks!\n\n--The Team @ SITE_NAME'),
		])
	}
	var_url = rt.call_function('get_blogaddress_by_id', [var_blog_id.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('SITE_NAME'),
		rt.get_property(var_current_network, 'site_name'), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('BLOG_TITLE'),
		var_title.clone(), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('BLOG_URL'),
		var_url.clone(), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('USERNAME'),
		rt.get_property(var_user, 'user_login'), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('PASSWORD'),
		var_password.clone(), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('apply_filters', [
		rt.new_string('update_welcome_email'),
		var_welcome_email.clone(),
		var_blog_id.clone(),
		var_user_id.clone(),
		var_password.clone(),
		var_title.clone(),
		var_meta.clone(),
	])
	var_admin_email = rt.call_function('get_site_option', [rt.new_string('admin_email')])
	if rt.is_true(rt.identical(rt.new_string(''), var_admin_email)) {
		var_admin_email =
			rt.new_string('support@' +(rt.call_function('wp_parse_url', [rt.call_function('network_home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])).str())
	}
	var_from_name = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_site_option', [
		rt.new_string('site_name'),
	])))))
	{ rt.call_function('esc_html', [
			rt.call_function('get_site_option', [rt.new_string('site_name')]),
		]) } else { rt.new_string('WordPress') }
	var_message_headers = rt.new_string(
		"From: \"${var_from_name.to_string()}\" <${var_admin_email.to_string()}>\n" +
		'Content-Type: text/plain; charset="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"\n')
	var_message = var_welcome_email.clone()
	if !rt.is_true(rt.get_property(var_current_network, 'site_name')) {
		rt.set_property(var_current_network, 'site_name', rt.new_string('WordPress'))
	}
	var_subject = rt.call_function('__', [rt.new_string('New %1$s Site: %2$s')])
	var_subject = rt.call_function('apply_filters', [
		rt.new_string('update_welcome_subject'),
		rt.call_function('sprintf', [var_subject.clone(),
			rt.get_property(var_current_network, 'site_name'),
			rt.call_function('wp_unslash', [var_title.clone()])]),
	])
	rt.call_function('wp_mail', [rt.get_property(var_user, 'user_email'),
		rt.call_function('wp_specialchars_decode', [var_subject.clone()]),
		var_message.clone(), var_message_headers.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	return true
}

fn wpmu_new_site_admin_notification(var_site_id rt.PhpVal, var_user_id rt.PhpVal) bool {
	mut var_site := rt.new_null()
	mut var_user := rt.new_null()
	mut var_email := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_network_admin := rt.new_null()
	mut var_subject := rt.new_null()
	mut var_message := rt.new_null()
	mut var_header := rt.new_null()
	mut var_new_site_email := rt.new_null()
	var_site = rt.call_function('get_site', [var_site_id.clone()])
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	var_email = rt.call_function('get_site_option', [rt.new_string('admin_email')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_user))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_email)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('send_new_site_email'),
		rt.new_bool(true),
		var_site.clone(),
		var_user.clone(),
	])))))
	{
		return false
	}
	var_switched_locale = rt.new_bool(false)
	var_network_admin = rt.call_function('get_user_by', [rt.new_string('email'),
		var_email.clone()])
	if rt.is_true(var_network_admin) {
		var_switched_locale = rt.call_function('switch_to_user_locale', [
			rt.get_property(var_network_admin, 'ID'),
		])
	} else {
		var_switched_locale = rt.call_function('switch_to_locale', [
			rt.call_function('get_locale', []rt.PhpVal{}),
		])
	}
	var_subject = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('[%s] New Site Created')]),
		rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
	])
	var_message = rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('New site created by %1$s\n\nAddress: %2$s\nName: %3$s'),
		]),
		rt.get_property(var_user, 'user_login'),
		rt.call_function('get_site_url', [
			rt.get_property(var_site, 'id'),
		]),
		rt.call_function('get_blog_option', [
			rt.get_property(var_site, 'id'),
			rt.new_string('blogname'),
		]),
	])
	var_header = rt.call_function('sprintf', [rt.new_string('From: "%1$s" <%2$s>'),
		rt.call_function('_x', [rt.new_string('Site Admin'), rt.new_string('email "From" field')]),
		var_email.clone()])
	var_new_site_email = rt.create_array([rt.ArrayItem{ key: 'to', val: var_email },
		rt.ArrayItem{ key: 'subject', val: var_subject }, rt.ArrayItem{
			key: 'message'
			val: var_message
		}, rt.ArrayItem{ key: 'headers', val: var_header }])
	var_new_site_email = rt.call_function('apply_filters', [
		rt.new_string('new_site_email'),
		var_new_site_email.clone(),
		var_site.clone(),
		var_user.clone(),
	])
	rt.call_function('wp_mail', [var_new_site_email.array_get(rt.new_string('to')),
		rt.call_function('wp_specialchars_decode', [
			var_new_site_email.array_get(rt.new_string('subject')),
		]),
		var_new_site_email.array_get(rt.new_string('message')),
		var_new_site_email.array_get(rt.new_string('headers'))])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	return true
}

fn wpmu_welcome_user_notification(var_user_id rt.PhpVal, var_password rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_current_network := rt.new_null()
	mut var_welcome_email := rt.new_null()
	mut var_user := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_admin_email := rt.new_null()
	mut var_from_name := rt.new_null()
	mut var_message_headers := rt.new_null()
	mut var_message := rt.new_null()
	mut var_subject := rt.new_null()
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wpmu_welcome_user_notification'),
		var_user_id.clone(),
		var_password.clone(),
		var_meta.clone(),
	])))))
	{
		return false
	}
	var_welcome_email = rt.call_function('get_site_option', [
		rt.new_string('welcome_user_email'),
	])
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	var_switched_locale = rt.call_function('switch_to_user_locale', [
		var_user_id.clone()])
	var_welcome_email = rt.call_function('apply_filters', [
		rt.new_string('update_welcome_user_email'),
		var_welcome_email.clone(),
		var_user_id.clone(),
		var_password.clone(),
		var_meta.clone(),
	])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('SITE_NAME'),
		rt.get_property(var_current_network, 'site_name'), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('USERNAME'),
		rt.get_property(var_user, 'user_login'), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('PASSWORD'),
		var_password.clone(), var_welcome_email.clone()])
	var_welcome_email = rt.call_function('str_replace', [rt.new_string('LOGINLINK'),
		rt.call_function('wp_login_url', []rt.PhpVal{}), var_welcome_email.clone()])
	var_admin_email = rt.call_function('get_site_option', [rt.new_string('admin_email')])
	if rt.is_true(rt.identical(rt.new_string(''), var_admin_email)) {
		var_admin_email =
			rt.new_string('support@' +(rt.call_function('wp_parse_url', [rt.call_function('network_home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])).str())
	}
	var_from_name = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_site_option', [
		rt.new_string('site_name'),
	])))))
	{ rt.call_function('esc_html', [
			rt.call_function('get_site_option', [rt.new_string('site_name')]),
		]) } else { rt.new_string('WordPress') }
	var_message_headers = rt.new_string(
		"From: \"${var_from_name.to_string()}\" <${var_admin_email.to_string()}>\n" +
		'Content-Type: text/plain; charset="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"\n')
	var_message = var_welcome_email.clone()
	if !rt.is_true(rt.get_property(var_current_network, 'site_name')) {
		rt.set_property(var_current_network, 'site_name', rt.new_string('WordPress'))
	}
	var_subject = rt.call_function('__', [rt.new_string('New %1$s User: %2$s')])
	var_subject = rt.call_function('apply_filters', [
		rt.new_string('update_welcome_user_subject'),
		rt.call_function('sprintf', [var_subject.clone(),
			rt.get_property(var_current_network, 'site_name'),
			rt.get_property(var_user, 'user_login')]),
	])
	rt.call_function('wp_mail', [rt.get_property(var_user, 'user_email'),
		rt.call_function('wp_specialchars_decode', [var_subject.clone()]),
		var_message.clone(), var_message_headers.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	return true
}

fn get_current_site() rt.PhpVal {
	mut var_current_site := rt.new_null()
	return var_current_site.clone()
}

fn get_most_recent_post_of_user(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_user_blogs := rt.new_null()
	mut var_most_recent_post := map[string]rt.PhpVal{}
	mut var_blog := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_recent_post := rt.new_null()
	mut var_post_gmt_ts := rt.new_null()
	var_user_blogs = rt.call_function('get_blogs_of_user', [
		rt.new_int(var_user_id.to_i64()),
	])
	var_most_recent_post = rt.new_array()
	mut iter_4 := rt.cast_array(var_user_blogs).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_blog_shadow := item_4.val
		var_prefix = rt.call_method(var_wpdb, 'get_blog_prefix', [
			rt.get_property(var_blog_shadow, 'userblog_id'),
		])
		var_recent_post = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string("SELECT ID, post_date_gmt FROM ${var_prefix.to_string()}posts WHERE post_author = %d AND post_type = 'post' AND post_status = 'publish' ORDER BY post_date_gmt DESC LIMIT 1"),
				var_user_id.clone(),
			]),
			rt.get_constant('ARRAY_A'),
		])
		if var_recent_post.array_isset(rt.new_string('ID')) {
			var_post_gmt_ts = rt.call_function('strtotime', [
				var_recent_post.array_get(rt.new_string('post_date_gmt')),
			])
			if !(var_most_recent_post.array_isset(rt.new_string('post_gmt_ts')))
				|| rt.is_true(rt.greater(var_post_gmt_ts, var_most_recent_post['post_gmt_ts'])) {
				var_most_recent_post = {
					'blog_id':       rt.get_property(var_blog_shadow, 'userblog_id')
					'post_id':       var_recent_post.array_get(rt.new_string('ID'))
					'post_date_gmt': var_recent_post.array_get(rt.new_string('post_date_gmt'))
					'post_gmt_ts':   var_post_gmt_ts
				}
			}
		}
	}
	return var_most_recent_post.clone()
}

fn check_upload_mimes(var_mimes rt.PhpVal) rt.PhpVal {
	mut var_site_exts := rt.new_null()
	mut var_site_mimes := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_mime := rt.new_null()
	mut var_ext_pattern := rt.new_null()
	var_site_exts = rt.call_function('explode', [rt.new_string(' '),
		rt.call_function('get_site_option', [rt.new_string('upload_filetypes'),
			rt.new_string('jpg jpeg png gif')])])
	var_site_mimes = rt.new_array()
	mut iter_5 := var_site_exts.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_ext_shadow := item_5.val
		mut iter_6 := var_mimes.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_mime_shadow := item_6.val
			mut var_ext_pattern_shadow := item_6.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_ext_shadow))))
				&& rt.is_true(rt.call_function('str_contains', [var_ext_pattern_shadow.clone(), var_ext_shadow.clone()])) {
				var_site_mimes.array_set(var_ext_pattern_shadow, var_mime_shadow.clone())
			}
		}
	}
	return var_site_mimes.clone()
}

fn update_posts_count(deprecated string) {
	mut var_deprecated := deprecated
	mut var_wpdb := rt.new_null()
	rt.call_function('update_option', [rt.new_string('post_count'),
		rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(ID) FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(" WHERE post_status = 'publish' and post_type = 'post'")),
		])).to_i64()),
		rt.new_bool(true)])
}

fn wpmu_log_new_registrations(var_blog_id_arg rt.PhpVal, var_user_id_arg rt.PhpVal) {
	mut var_blog_id := var_blog_id_arg
	mut var_user_id := var_user_id_arg
	mut var_wpdb := rt.new_null()
	mut var_user := rt.new_null()
	if rt.is_true(rt.new_bool(var_blog_id.clone().is_object())) {
		var_blog_id = rt.get_property(var_blog_id, 'blog_id')
	}
	if rt.is_true(rt.new_bool(var_user_id.clone().is_array())) {
		var_user_id = if !(!rt.is_true(var_user_id.array_get(rt.new_string('user_id')))) {
			var_user_id.array_get(rt.new_string('user_id'))
		} else {
			rt.new_int(0)
		}
	}
	var_user = rt.call_function('get_userdata', [rt.new_int(var_user_id.to_i64())])
	if rt.is_true(var_user) {
		rt.call_method(var_wpdb, 'insert', [
			rt.get_property(var_wpdb, 'registration_log'),
			rt.create_array([
				rt.ArrayItem{ key: 'email', val: rt.get_property(var_user, 'user_email') },
				rt.ArrayItem{ key: 'IP', val: rt.call_function('preg_replace', [
					rt.new_string('/[^0-9., ]/'),
					rt.new_string(''),
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')),
					]),
				]) },
				rt.ArrayItem{ key: 'blog_id', val: var_blog_id },
				rt.ArrayItem{ key: 'date_registered', val: rt.call_function('current_time', [
					rt.new_string('mysql'),
				]) },
			]),
		])
	}
}

fn redirect_this_site(deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('get_network', []rt.PhpVal{}),
			'domain') },
	])
}

fn upload_is_file_too_big(var_upload rt.PhpVal) rt.PhpVal {
	if !(rt.create_array_from_native_map(var_upload).is_array())
		|| rt.is_true(rt.call_function('defined', [rt.new_string('WP_IMPORTING')]))
		|| rt.is_true(rt.call_function('get_site_option', [rt.new_string('upload_space_check_disabled')])) {
		return var_upload.clone()
	}
	if rt.is_true(rt.greater(rt.new_int(var_upload.array_get(rt.new_string('bits')).to_string().len), rt.mul(rt.get_constant('KB_IN_BYTES'), rt.call_function('get_site_option', [
		rt.new_string('fileupload_maxk'),
		rt.new_int(1500),
	]))))
	{
		return rt.call_function('sprintf', [
			rt.new_string(
				(rt.call_function('__', [rt.new_string('This file is too big. Files must be less than %s KB in size.')])).str() +
				'<br />'),
			rt.call_function('get_site_option', [
				rt.new_string('fileupload_maxk'),
				rt.new_int(1500),
			]),
		])
	}
	return var_upload.clone()
}

fn signup_nonce_fields() {
	mut var_id := rt.new_null()
	var_id = rt.call_function('mt_rand', []rt.PhpVal{})
	print("<input type='hidden' name='signup_form_id' value='${var_id.to_string()}' />")
	rt.call_function('wp_nonce_field', [rt.new_string('signup_form_' + var_id.str()),
		rt.new_string('_signup_form'), rt.new_bool(false)])
}

fn signup_nonce_check(var_result rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [
		rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')),
		rt.new_string('wp-signup.php'),
	])))))
	{
		return var_result.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
		rt.get_superglobal('_POST').array_get(rt.new_string('_signup_form')),
		rt.new_string('signup_form_' +
			(rt.get_superglobal('_POST').array_get(rt.new_string('signup_form_id'))).str()),
	])))))
	{
		rt.call_method(var_result.array_get(rt.new_string('errors')), 'add', [
			rt.new_string('invalid_nonce'),
			rt.call_function('__', [
				rt.new_string('Unable to submit this form, please try again.'),
			]),
		])
	}
	return var_result.clone()
}

fn maybe_redirect_404() {
	mut var_destination := rt.new_null()
	if rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('NOBLOGREDIRECT')])) {
		var_destination = rt.call_function('apply_filters', [
			rt.new_string('blog_redirect_404'),
			rt.get_constant('NOBLOGREDIRECT'),
		])
		if rt.is_true(var_destination) {
			if rt.is_true(rt.identical(rt.new_string('%siteurl%'), var_destination)) {
				var_destination = rt.call_function('network_home_url', []rt.PhpVal{})
			}
			rt.call_function('wp_redirect', [var_destination.clone()])
			exit(0)
		}
	}
}

fn maybe_add_existing_user_to_blog() {
	mut var_parts := rt.new_null()
	mut var_key := rt.new_null()
	mut var_details := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		rt.new_string('/newbloguser/'),
	])))))
	{
		return
	}
	var_parts = rt.call_function('explode', [rt.new_string('/'),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])
	var_key = rt.call_function('array_pop', [var_parts.clone()])
	if rt.is_true(rt.identical(rt.new_string(''), var_key)) {
		var_key = rt.call_function('array_pop', [var_parts.clone()])
	}
	var_details = rt.call_function('get_option', [
		rt.new_string('new_user_' + var_key.str()),
	])
	if !(!rt.is_true(var_details)) {
		rt.call_function('delete_option', [rt.new_string('new_user_' + var_key.str())])
	}
	if !rt.is_true(var_details)
		|| rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(add_existing_user_to_blog(var_details.clone()))])) {
		rt.call_function('wp_die', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('An error occurred adding you to this site. Go to the <a href="%s">homepage</a>.'),
				]),
				rt.call_function('home_url', []rt.PhpVal{}),
			]),
		])
	}
	rt.call_function('wp_die', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('You have been added to this site. Please visit the <a href="%1$s">homepage</a> or <a href="%2$s">log in</a> using your username and password.'),
			]),
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.call_function('admin_url', []rt.PhpVal{}),
		]),
		rt.call_function('__', [
			rt.new_string('WordPress &rsaquo; Success'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'response', val: 200 },
		]),
	])
}

fn add_existing_user_to_blog(details bool) bool {
	mut var_details := details
	mut var_blog_id := rt.new_null()
	mut var_result := false
	if rt.is_true(rt.new_bool(rt.new_bool(details).is_array())) {
		var_blog_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
		var_result = add_user_to_blog(var_blog_id.clone(),
			rt.new_bool(details).array_get(rt.new_string('user_id')),
			rt.new_bool(details).array_get(rt.new_string('role')))
		rt.call_function('do_action', [rt.new_string('added_existing_user'),
			rt.new_bool(details).array_get(rt.new_string('user_id')),
			rt.new_bool(var_result).clone()])
		return var_result
	}
	return false
}

fn add_new_user_to_blog(var_user_id rt.PhpVal, var_password rt.PhpVal, var_meta rt.PhpVal) {
	mut var_blog_id := rt.new_null()
	mut var_role := rt.new_null()
	mut var_result := false
	if !(!rt.is_true(var_meta.array_get(rt.new_string('add_to_blog')))) {
		var_blog_id = var_meta.array_get(rt.new_string('add_to_blog'))
		var_role = var_meta.array_get(rt.new_string('new_role'))
		rt.new_bool(remove_user_from_blog(var_user_id.clone(), rt.get_property(rt.call_function('get_network',
			[]rt.PhpVal{}), 'site_id'), 0))
		var_result = add_user_to_blog(var_blog_id.clone(), var_user_id.clone(), var_role.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			rt.new_bool(var_result).clone(),
		])))))
		{
			rt.call_function('update_user_meta', [var_user_id.clone(),
				rt.new_string('primary_blog'), var_blog_id.clone()])
		}
	}
}

fn fix_phpmailer_messageid(var_phpmailer rt.PhpVal) {
	rt.set_property(var_phpmailer, 'Hostname', rt.get_property(rt.call_function('get_network',
		[]rt.PhpVal{}), 'domain'))
}

fn is_user_spammy(var_user_arg rt.PhpVal) bool {
	mut var_user := var_user_arg
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
		if rt.is_true(var_user) {
			var_user = rt.call_function('get_user_by', [rt.new_string('login'),
				var_user.clone()])
		} else {
			var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
		}
	}
	return rt.is_true(var_user) && !(rt.get_property(var_user, 'spam')).is_null()
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_user, 'spam')))
}

fn update_blog_public(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	rt.call_function('update_blog_status', [
		rt.call_function('get_current_blog_id', []rt.PhpVal{}),
		rt.new_string('public'),
		rt.new_int(var_value.to_i64()),
	])
}

fn users_can_register_signup_filter() bool {
	mut var_registration := rt.new_null()
	var_registration = rt.call_function('get_site_option', [
		rt.new_string('registration'),
	])
	return rt.is_true(rt.identical(rt.new_string('all'), var_registration))
		|| rt.is_true(rt.identical(rt.new_string('user'), var_registration))
}

fn welcome_user_msg_filter(var_text_arg rt.PhpVal) rt.PhpVal {
	mut var_text := var_text_arg
	if rt.is_true(rt.new_bool(!(rt.is_true(var_text)))) {
		rt.call_function('remove_filter', [
			rt.new_string('site_option_welcome_user_email'),
			rt.new_string('welcome_user_msg_filter'),
		])
		var_text = rt.call_function('__', [
			rt.new_string('Howdy USERNAME,\n\nYour new account is set up.\n\nYou can log in with the following information:\nUsername: USERNAME\nPassword: PASSWORD\nLOGINLINK\n\nThanks!\n\n--The Team @ SITE_NAME'),
		])
		rt.call_function('update_site_option', [rt.new_string('welcome_user_email'),
			var_text.clone()])
	}
	return var_text.clone()
}

fn force_ssl_content(var_force rt.PhpVal) rt.PhpVal {
	mut var_old_forced := rt.new_null()
	mut var_forced_content := rt.new_null()
	if !(var_force.clone().is_null()) {
		var_old_forced = var_forced_content.clone()
		var_forced_content = rt.new_bool(var_force.to_bool())
		return var_old_forced.clone()
	}
	return var_forced_content.clone()
}

fn filter_ssl(var_url_arg rt.PhpVal) rt.PhpVal {
	mut var_url := var_url_arg
	if !(var_url.clone().is_string()) {
		return rt.call_function('get_bloginfo', [rt.new_string('url')])
	}
	if rt.is_true(force_ssl_content(rt.new_null()))
		&& rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
		var_url = rt.call_function('set_url_scheme', [var_url.clone(),
			rt.new_string('https')])
	}
	return var_url.clone()
}

fn wp_schedule_update_network_counts() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('update_network_counts')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('twicedaily'), rt.new_string('update_network_counts')])
	}
}

fn wp_update_network_counts(var_network_id rt.PhpVal) {
	wp_update_network_user_counts(var_network_id.clone())
	wp_update_network_site_counts(var_network_id.clone())
}

fn wp_maybe_update_network_site_counts(var_network_id rt.PhpVal) {
	mut var_is_small_network := false
	var_is_small_network = !(rt.is_true(wp_is_large_network('sites', var_network_id.clone())))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_live_network_counts'),
		rt.new_bool(var_is_small_network).clone(),
		rt.new_string('sites'),
	])))))
	{
		return
	}
	wp_update_network_site_counts(var_network_id.clone())
}

fn wp_maybe_update_network_user_counts(var_network_id rt.PhpVal) {
	mut var_is_small_network := false
	var_is_small_network = !(rt.is_true(wp_is_large_network('users', var_network_id.clone())))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_live_network_counts'),
		rt.new_bool(var_is_small_network).clone(),
		rt.new_string('users'),
	])))))
	{
		return
	}
	wp_update_network_user_counts(var_network_id.clone())
}

fn wp_update_network_site_counts(var_network_id_arg rt.PhpVal) {
	mut var_network_id := var_network_id_arg
	mut var_count := rt.new_null()
	var_network_id = rt.new_int(var_network_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id)))) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	var_count = rt.call_function('get_sites', [
		rt.create_array([rt.ArrayItem{ key: 'network_id', val: var_network_id },
			rt.ArrayItem{ key: 'spam', val: 0 }, rt.ArrayItem{ key: 'deleted', val: 0 },
			rt.ArrayItem{ key: 'archived', val: 0 }, rt.ArrayItem{ key: 'count', val: true },
			rt.ArrayItem{ key: 'update_site_meta_cache', val: false }]),
	])
	rt.call_function('update_network_option', [var_network_id.clone(),
		rt.new_string('blog_count'), var_count.clone()])
}

fn wp_update_network_user_counts(var_network_id rt.PhpVal) {
	rt.call_function('wp_update_user_counts', [var_network_id.clone()])
}

fn get_space_used() rt.PhpVal {
	mut var_space_used := rt.new_null()
	mut var_upload_dir := rt.new_null()
	var_space_used = rt.call_function('apply_filters', [
		rt.new_string('pre_get_space_used'),
		rt.new_bool(false),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_space_used)) {
		var_upload_dir = rt.call_function('wp_upload_dir', []rt.PhpVal{})
		var_space_used = rt.div(rt.call_function('get_dirsize', [
			var_upload_dir.array_get(rt.new_string('basedir')),
		]), rt.get_constant('MB_IN_BYTES'))
	}
	return var_space_used.clone()
}

fn get_space_allowed() rt.PhpVal {
	mut var_space_allowed := rt.new_null()
	var_space_allowed = rt.call_function('get_option', [
		rt.new_string('blog_upload_space'),
	])
	if !(var_space_allowed.clone().is_long() || var_space_allowed.clone().is_double()) {
		var_space_allowed = rt.call_function('get_site_option', [
			rt.new_string('blog_upload_space'),
		])
	}
	if !(var_space_allowed.clone().is_long() || var_space_allowed.clone().is_double()) {
		var_space_allowed = rt.new_int(100)
	}
	return rt.call_function('apply_filters', [rt.new_string('get_space_allowed'),
		var_space_allowed.clone()])
}

fn get_upload_space_available() i64 {
	mut var_allowed := rt.new_null()
	mut var_space_allowed := rt.new_null()
	mut var_space_used := rt.new_null()
	var_allowed = get_space_allowed()
	if rt.is_true(rt.less(var_allowed, rt.new_int(0))) {
		var_allowed = rt.new_int(0)
	}
	var_space_allowed = rt.mul(var_allowed, rt.get_constant('MB_IN_BYTES'))
	if rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('upload_space_check_disabled'),
	]))
	{
		return var_space_allowed.to_i64()
	}
	var_space_used = rt.mul(get_space_used(), rt.get_constant('MB_IN_BYTES'))
	if rt.is_true(rt.less_equal(rt.sub(var_space_allowed, var_space_used), rt.new_int(0))) {
		return 0
	}
	return (rt.sub(var_space_allowed, var_space_used)).to_i64()
}

fn is_upload_space_available() bool {
	if rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('upload_space_check_disabled'),
	]))
	{
		return true
	}
	return (rt.new_int(get_upload_space_available())).to_bool()
}

fn upload_size_limit_filter(var_size rt.PhpVal) rt.PhpVal {
	mut var_fileupload_maxk := rt.new_null()
	mut var_max_fileupload_in_bytes := rt.new_null()
	var_fileupload_maxk = rt.new_int((rt.call_function('get_site_option', [
		rt.new_string('fileupload_maxk'),
		rt.new_int(1500),
	])).to_i64())
	var_max_fileupload_in_bytes = rt.mul(rt.get_constant('KB_IN_BYTES'), var_fileupload_maxk)
	if rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('upload_space_check_disabled'),
	]))
	{
		return rt.call_function('min', [var_size.clone(), var_max_fileupload_in_bytes.clone()])
	}
	return rt.call_function('min', [var_size.clone(), var_max_fileupload_in_bytes.clone(),
		rt.new_int(get_upload_space_available())])
}

fn wp_is_large_network(using string, var_network_id_arg rt.PhpVal) rt.PhpVal {
	mut var_using := using
	mut var_network_id := var_network_id_arg
	mut var_count := rt.new_null()
	mut var_is_large_network := rt.new_null()
	var_network_id = rt.new_int(var_network_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id)))) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string('users'), rt.new_string(using))) {
		var_count = rt.call_function('get_user_count', [var_network_id.clone()])
		var_is_large_network = rt.call_function('wp_is_large_user_count', [
			var_network_id.clone()])
		return rt.call_function('apply_filters', [rt.new_string('wp_is_large_network'),
			var_is_large_network.clone(), rt.new_string('users'),
			var_count.clone(), var_network_id.clone()])
	}
	var_count = get_blog_count(var_network_id.clone())
	return rt.call_function('apply_filters', [rt.new_string('wp_is_large_network'),
		rt.greater(var_count, rt.new_int(10000)), rt.new_string('sites'),
		var_count.clone(), var_network_id.clone()])
}

fn get_subdirectory_reserved_names() rt.PhpVal {
	mut var_names := []rt.PhpVal{}
	var_names = ['page', 'comments', 'blog', 'files', 'feed', 'wp-admin', 'wp-content', 'wp-includes',
		'wp-json', 'embed']
	return rt.call_function('apply_filters', [
		rt.new_string('subdirectory_reserved_names'),
		rt.create_array_from_list(var_names),
	])
}

fn update_network_option_new_admin_email(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	mut var_hash := ''
	mut var_new_admin_email := map[string]rt.PhpVal{}
	mut var_switched_locale := rt.new_null()
	mut var_email_text := rt.new_null()
	mut var_content := rt.new_null()
	mut var_current_user := rt.new_null()
	if rt.is_true(rt.identical(rt.call_function('get_site_option', [rt.new_string('admin_email')]), var_value))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value.clone()]))))) {
		return
	}
	var_hash = md5.hexhash(var_value.str() + (rt.call_function('time', []rt.PhpVal{})).str() +
		(rt.call_function('mt_rand', []rt.PhpVal{})).str())
	var_new_admin_email = {
		'hash':     rt.new_string(var_hash.str())
		'newemail': var_value
	}
	rt.call_function('update_site_option', [rt.new_string('network_admin_hash'),
		rt.create_array_from_native_map(var_new_admin_email)])
	var_switched_locale = rt.call_function('switch_to_user_locale', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	var_email_text = rt.call_function('__', [
		rt.new_string('Howdy ###USERNAME###,\n\nYou recently requested to have the network admin email address on\nyour network changed.\n\nIf this is correct, please click on the following link to change it:\n###ADMIN_URL###\n\nYou can safely ignore and delete this email if you do not want to\ntake this action.\n\nThis email has been sent to ###EMAIL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###'),
	])
	var_content = rt.call_function('apply_filters', [
		rt.new_string('new_network_admin_email_content'),
		var_email_text.clone(),
		rt.create_array_from_native_map(var_new_admin_email),
	])
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	var_content = rt.call_function('str_replace', [rt.new_string('###USERNAME###'),
		rt.get_property(var_current_user, 'user_login'), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###ADMIN_URL###'),
		rt.call_function('esc_url', [
			rt.call_function('network_admin_url', [
				rt.new_string('settings.php?network_admin_hash=' + var_hash),
			]),
		]),
		var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###EMAIL###'),
		var_value.clone(), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'),
		rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_site_option', [rt.new_string('site_name')]),
			rt.get_constant('ENT_QUOTES'),
		]),
		var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'),
		rt.call_function('network_home_url', []rt.PhpVal{}), var_content.clone()])
	rt.call_function('wp_mail', [var_value.clone(),
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('[%s] Network Admin Email Change Request'),
			]),
			rt.call_function('wp_specialchars_decode', [
				rt.call_function('get_site_option', [rt.new_string('site_name')]),
				rt.get_constant('ENT_QUOTES'),
			]),
		]),
		var_content.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
}

fn wp_network_admin_email_change_notification(var_option_name rt.PhpVal, var_new_email rt.PhpVal, var_old_email rt.PhpVal, var_network_id rt.PhpVal) {
	mut var_send := rt.new_null()
	mut var_email_change_text := rt.new_null()
	mut var_email_change_email := rt.new_null()
	mut var_network_name := rt.new_null()
	var_send = rt.new_bool(true)
	if !rt.is_true(var_old_email)
		|| rt.is_true(rt.identical(rt.new_string('you@example.com'), var_old_email)) {
		var_send = rt.new_bool(false)
	}
	var_send = rt.call_function('apply_filters', [
		rt.new_string('send_network_admin_email_change_email'),
		var_send.clone(),
		var_old_email.clone(),
		var_new_email.clone(),
		var_network_id.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_send)))) {
		return
	}
	var_email_change_text = rt.call_function('__', [
		rt.new_string('Hi,\n\nThis notice confirms that the network admin email address was changed on ###SITENAME###.\n\nThe new network admin email address is ###NEW_EMAIL###.\n\nThis email has been sent to ###OLD_EMAIL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###'),
	])
	var_email_change_email = rt.create_array([
		rt.ArrayItem{ key: 'to', val: var_old_email },
		rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [
			rt.new_string('[%s] Network Admin Email Changed'),
		]) },
		rt.ArrayItem{ key: 'message', val: var_email_change_text },
		rt.ArrayItem{ key: 'headers', val: '' },
	])
	var_network_name = rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_site_option', [rt.new_string('site_name')]),
		rt.get_constant('ENT_QUOTES'),
	])
	var_email_change_email = rt.call_function('apply_filters', [
		rt.new_string('network_admin_email_change_email'),
		var_email_change_email.clone(),
		var_old_email.clone(),
		var_new_email.clone(),
		var_network_id.clone(),
	])
	var_email_change_email.array_set('message', rt.call_function('str_replace', [
		rt.new_string('###OLD_EMAIL###'),
		var_old_email.clone(),
		var_email_change_email.array_get(rt.new_string('message')),
	]))
	var_email_change_email.array_set('message', rt.call_function('str_replace', [
		rt.new_string('###NEW_EMAIL###'),
		var_new_email.clone(),
		var_email_change_email.array_get(rt.new_string('message')),
	]))
	var_email_change_email.array_set('message', rt.call_function('str_replace', [
		rt.new_string('###SITENAME###'),
		var_network_name.clone(),
		var_email_change_email.array_get(rt.new_string('message')),
	]))
	var_email_change_email.array_set('message', rt.call_function('str_replace', [
		rt.new_string('###SITEURL###'),
		rt.call_function('home_url', []rt.PhpVal{}),
		var_email_change_email.array_get(rt.new_string('message')),
	]))
	rt.call_function('wp_mail', [var_email_change_email.array_get(rt.new_string('to')),
		rt.call_function('sprintf', [var_email_change_email.array_get(rt.new_string('subject')),
			var_network_name.clone()]),
		var_email_change_email.array_get(rt.new_string('message')),
		var_email_change_email.array_get(rt.new_string('headers'))])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
