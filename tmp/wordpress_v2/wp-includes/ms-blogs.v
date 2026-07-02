import rt
import crypto.md5

fn wpmu_update_blogs_date() {
	mut var_site_id := rt.new_null()
	var_site_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	rt.new_bool(update_blog_details(var_site_id.clone(), rt.create_array([
		rt.ArrayItem{ key: 'last_updated', val: rt.call_function('current_time', [
			rt.new_string('mysql'),
			rt.new_bool(true),
		]) },
	])))
	rt.call_function('do_action', [rt.new_string('wpmu_blog_updated'),
		var_site_id.clone()])
}

fn get_blogaddress_by_id(var_blog_id rt.PhpVal) string {
	mut var_bloginfo := rt.new_null()
	mut var_scheme := rt.new_null()
	var_bloginfo = rt.call_function('get_site', [rt.new_int(var_blog_id.to_i64())])
	if !rt.is_true(var_bloginfo) {
		return ''
	}
	var_scheme = rt.call_function('parse_url', [rt.get_property(var_bloginfo, 'home'),
		rt.get_constant('PHP_URL_SCHEME')])
	var_scheme = if !rt.is_true(var_scheme) { rt.new_string('http') } else { var_scheme }
	return (rt.call_function('esc_url', [
		rt.new_string(var_scheme.str() + '://' + (rt.get_property(var_bloginfo, 'domain')).str() +
			(rt.get_property(var_bloginfo, 'path')).str()),
	])).str()
}

fn get_blogaddress_by_name(var_blogname_arg rt.PhpVal) rt.PhpVal {
	mut var_blogname := var_blogname_arg
	mut var_url := rt.new_null()
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		if rt.is_true(rt.identical(rt.new_string('main'), rt.new_string(var_blogname.str()))) {
			var_blogname = 'www'
		}
		var_url =
			rt.new_string(rt.call_function('network_home_url', []rt.PhpVal{}).to_string().trim_right(' \t\n\r'))
		if !(var_blogname == '') {
			var_url = rt.call_function('preg_replace', [rt.new_string('|^([^\\.]+://)|'),
				rt.new_string('${1}' + var_blogname + '.'), var_url.clone()])
		}
	} else {
		var_url = rt.call_function('network_home_url', [rt.new_string(var_blogname.str()).clone()])
	}
	return rt.call_function('esc_url', [rt.new_string(var_url.str() + '/')])
}

fn get_id_from_blogname(var_slug_arg rt.PhpVal) rt.PhpVal {
	mut var_slug := var_slug_arg
	mut var_current_network := rt.new_null()
	mut var_domain := rt.new_null()
	mut var_path := rt.new_null()
	mut var_site_ids := rt.new_null()
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	var_slug = var_slug.trim_space()
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		var_domain =
			rt.new_string((var_slug + '.' +(rt.call_function('preg_replace', [rt.new_string('|^www\\.|'), rt.new_string(''), rt.get_property(var_current_network, 'domain')])).str()).str())
		var_path = rt.get_property(var_current_network, 'path')
	} else {
		var_domain = rt.get_property(var_current_network, 'domain')
		var_path = rt.new_string((rt.get_property(var_current_network, 'path')).str() + var_slug +
			'/')
	}
	var_site_ids = rt.call_function('get_sites', [
		rt.create_array([rt.ArrayItem{ key: 'number', val: 1 },
			rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'domain', val: var_domain },
			rt.ArrayItem{ key: 'path', val: var_path }, rt.ArrayItem{
				key: 'update_site_meta_cache'
				val: false
			}]),
	])
	if !rt.is_true(var_site_ids) {
		return rt.new_null()
	}
	return rt.call_function('array_shift', [var_site_ids.clone()])
}

fn get_blog_details(var_fields rt.PhpVal, get_all bool) bool {
	mut var_get_all := get_all
	mut var_wpdb := rt.new_null()
	mut var_blog_id := rt.new_null()
	mut var_key := ''
	mut var_blog := rt.new_null()
	mut var_nowww := rt.new_null()
	mut var_all := ''
	mut var_details := rt.new_null()
	mut var_switched_blog := false
	if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_fields).is_array())) {
		if var_fields.array_isset(rt.new_string('blog_id')) {
			var_blog_id = var_fields.array_get(rt.new_string('blog_id'))
		} else if var_fields.array_isset(rt.new_string('domain'))
			&& var_fields.array_isset(rt.new_string('path')) {
			var_key = md5.hexhash((var_fields.array_get(rt.new_string('domain'))).str() +
				(var_fields.array_get(rt.new_string('path'))).str())
			var_blog = rt.call_function('wp_cache_get', [rt.new_string(var_key.str()).clone(),
				rt.new_string('blog-lookup')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_blog)))) {
				return var_blog.to_bool()
			}
			if rt.is_true(rt.call_function('str_starts_with', [
				var_fields.array_get(rt.new_string('domain')),
				rt.new_string('www.'),
			]))
			{
				var_nowww = rt.call_function('substr', [
					var_fields.array_get(rt.new_string('domain')),
					rt.new_int(4),
				])
				var_blog = rt.call_method(var_wpdb, 'get_row', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
							'blogs')),
							rt.new_string(' WHERE domain IN (%s,%s) AND path = %s ORDER BY CHAR_LENGTH(domain) DESC')),
						var_nowww.clone(),
						var_fields.array_get(rt.new_string('domain')),
						var_fields.array_get(rt.new_string('path')),
					]),
				])
			} else {
				var_blog = rt.call_method(var_wpdb, 'get_row', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
							'blogs')), rt.new_string(' WHERE domain = %s AND path = %s')),
						var_fields.array_get(rt.new_string('domain')),
						var_fields.array_get(rt.new_string('path')),
					]),
				])
			}
			if rt.is_true(var_blog) {
				rt.call_function('wp_cache_set', [
					rt.new_string((rt.get_property(var_blog, 'blog_id')).str() + 'short'),
					var_blog.clone(),
					rt.new_string('blog-details'),
				])
				var_blog_id = rt.get_property(var_blog, 'blog_id')
			} else {
				return false
			}
		} else if var_fields.array_isset(rt.new_string('domain'))
			&& rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
			var_key = md5.hexhash(var_fields.array_get(rt.new_string('domain')).to_string())
			var_blog = rt.call_function('wp_cache_get', [rt.new_string(var_key.str()).clone(),
				rt.new_string('blog-lookup')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_blog)))) {
				return var_blog.to_bool()
			}
			if rt.is_true(rt.call_function('str_starts_with', [
				var_fields.array_get(rt.new_string('domain')),
				rt.new_string('www.'),
			]))
			{
				var_nowww = rt.call_function('substr', [
					var_fields.array_get(rt.new_string('domain')),
					rt.new_int(4),
				])
				var_blog = rt.call_method(var_wpdb, 'get_row', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
							'blogs')),
							rt.new_string(' WHERE domain IN (%s,%s) ORDER BY CHAR_LENGTH(domain) DESC')),
						var_nowww.clone(),
						var_fields.array_get(rt.new_string('domain')),
					]),
				])
			} else {
				var_blog = rt.call_method(var_wpdb, 'get_row', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
							'blogs')), rt.new_string(' WHERE domain = %s')),
						var_fields.array_get(rt.new_string('domain')),
					]),
				])
			}
			if rt.is_true(var_blog) {
				rt.call_function('wp_cache_set', [
					rt.new_string((rt.get_property(var_blog, 'blog_id')).str() + 'short'),
					var_blog.clone(),
					rt.new_string('blog-details'),
				])
				var_blog_id = rt.get_property(var_blog, 'blog_id')
			} else {
				return false
			}
		} else {
			return false
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_fields)))) {
			var_blog_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
		} else if !(rt.create_array_from_native_map(var_fields).is_long()
			|| rt.create_array_from_native_map(var_fields).is_double()) {
			var_blog_id = get_id_from_blogname(rt.create_array_from_native_map(var_fields))
		} else {
			var_blog_id = var_fields
		}
	}
	var_blog_id = rt.new_int(var_blog_id.to_i64())
	var_all = if var_get_all { '' } else { 'short' }
	var_details = rt.call_function('wp_cache_get', [
		rt.new_string(var_blog_id.str() + var_all),
		rt.new_string('blog-details'),
	])
	if rt.is_true(var_details) {
		if !(var_details.clone().is_object()) {
			if rt.is_true(rt.identical(-1, var_details)) {
				return false
			} else {
				rt.call_function('wp_cache_delete', [
					rt.new_string(var_blog_id.str() + var_all),
					rt.new_string('blog-details'),
				])
				var_details = rt.new_null()
			}
		} else {
			return var_details.to_bool()
		}
	}
	if var_get_all {
		var_details = rt.call_function('wp_cache_get', [
			rt.new_string(var_blog_id.str() + 'short'),
			rt.new_string('blog-details'),
		])
	} else {
		var_details = rt.call_function('wp_cache_get', [var_blog_id.clone(),
			rt.new_string('blog-details')])
		if rt.is_true(var_details) {
			if !(var_details.clone().is_object()) {
				if rt.is_true(rt.identical(-1, var_details)) {
					return false
				} else {
					rt.call_function('wp_cache_delete', [var_blog_id.clone(),
						rt.new_string('blog-details')])
					var_details = rt.new_null()
				}
			} else {
				return var_details.to_bool()
			}
		}
	}
	if !rt.is_true(var_details) {
		mut iife_temp_0 := Class_WP_Site{}
		mut iife_result_0 := iife_temp_0.get_instance(var_blog_id.clone())
		var_details = iife_result_0
		if rt.is_true(rt.new_bool(!(rt.is_true(var_details)))) {
			rt.call_function('wp_cache_set', [var_blog_id.clone(),
				rt.new_int(-1), rt.new_string('blog-details')])
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_details, 'WP_Site')))))) {
		var_details = create_wp_site(var_details.clone())
	}
	if !var_get_all {
		rt.call_function('wp_cache_set', [rt.new_string(var_blog_id.str() + var_all),
			var_details.clone(), rt.new_string('blog-details')])
		return var_details.to_bool()
	}
	var_switched_blog = false
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id',
		[]rt.PhpVal{}), var_blog_id))))
	{
		rt.new_bool(switch_to_blog(var_blog_id.clone(), rt.new_null()))
		var_switched_blog = true
	}
	rt.set_property(var_details, 'blogname', rt.call_function('get_option', [
		rt.new_string('blogname'),
	]))
	rt.set_property(var_details, 'siteurl', rt.call_function('get_option', [
		rt.new_string('siteurl'),
	]))
	rt.set_property(var_details, 'post_count', rt.call_function('get_option', [
		rt.new_string('post_count'),
	]))
	rt.set_property(var_details, 'home', rt.call_function('get_option', [
		rt.new_string('home'),
	]))
	if var_switched_blog {
		rt.new_bool(restore_current_blog())
	}
	var_details = rt.call_function('apply_filters_deprecated', [
		rt.new_string('blog_details'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_details }]),
		rt.new_string('4.7.0'),
		rt.new_string('site_details'),
	])
	rt.call_function('wp_cache_set', [rt.new_string(var_blog_id.str() + var_all),
		var_details.clone(), rt.new_string('blog-details')])
	var_key = md5.hexhash((rt.get_property(var_details, 'domain')).str() +
		(rt.get_property(var_details, 'path')).str())
	rt.call_function('wp_cache_set', [rt.new_string(var_key.str()).clone(),
		var_details.clone(), rt.new_string('blog-lookup')])
	return var_details.to_bool()
}

fn refresh_blog_details(blog_id i64) {
	mut var_blog_id := blog_id
	var_blog_id = var_blog_id
	if !(var_blog_id != 0) {
		var_blog_id = (rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64()
	}
	rt.call_function('clean_blog_cache', [rt.new_int(var_blog_id)])
}

fn update_blog_details(var_blog_id rt.PhpVal, var_details_arg rt.PhpVal) bool {
	mut var_details := var_details_arg
	mut var_site := rt.new_null()
	if !rt.is_true(var_details) {
		return false
	}
	if rt.is_true(rt.new_bool(var_details.clone().is_object())) {
		var_details = rt.call_function('get_object_vars', [var_details.clone()])
	}
	var_site = rt.call_function('wp_update_site', [var_blog_id.clone(),
		var_details.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_site.clone()])) {
		return false
	}
	return true
}

fn clean_site_details_cache(site_id i64) {
	mut var_site_id := site_id
	var_site_id = var_site_id
	if !(var_site_id != 0) {
		var_site_id = (rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64()
	}
	rt.call_function('wp_cache_delete', [rt.new_int(var_site_id),
		rt.new_string('site-details')])
	rt.call_function('wp_cache_delete', [rt.new_int(var_site_id),
		rt.new_string('blog-details')])
}

fn get_blog_option(var_id_arg rt.PhpVal, var_option rt.PhpVal, default_value bool) rt.PhpVal {
	mut var_default_value := default_value
	mut var_id := var_id_arg
	mut var_value := rt.new_null()
	var_id = rt.new_int(var_id.to_i64())
	if !rt.is_true(var_id) {
		var_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_id)) {
		return rt.call_function('get_option', [var_option.clone(),
			rt.new_bool(default_value)])
	}
	rt.new_bool(switch_to_blog(var_id.clone(), rt.new_null()))
	var_value = rt.call_function('get_option', [var_option.clone(),
		rt.new_bool(default_value)])
	rt.new_bool(restore_current_blog())
	return rt.call_function('apply_filters', [
		rt.new_string('blog_option_${var_option.to_string()}'),
		var_value.clone(),
		var_id.clone(),
	])
}

fn add_blog_option(var_id_arg rt.PhpVal, var_option rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_id := var_id_arg
	mut var_return := rt.new_null()
	var_id = rt.new_int(var_id.to_i64())
	if !rt.is_true(var_id) {
		var_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_id)) {
		return rt.call_function('add_option', [var_option.clone(),
			var_value.clone()])
	}
	rt.new_bool(switch_to_blog(var_id.clone(), rt.new_null()))
	var_return = rt.call_function('add_option', [var_option.clone(),
		var_value.clone()])
	rt.new_bool(restore_current_blog())
	return var_return.clone()
}

fn delete_blog_option(var_id_arg rt.PhpVal, var_option rt.PhpVal) rt.PhpVal {
	mut var_id := var_id_arg
	mut var_return := rt.new_null()
	var_id = rt.new_int(var_id.to_i64())
	if !rt.is_true(var_id) {
		var_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_id)) {
		return rt.call_function('delete_option', [var_option.clone()])
	}
	rt.new_bool(switch_to_blog(var_id.clone(), rt.new_null()))
	var_return = rt.call_function('delete_option', [var_option.clone()])
	rt.new_bool(restore_current_blog())
	return var_return.clone()
}

fn update_blog_option(var_id_arg rt.PhpVal, var_option rt.PhpVal, var_value rt.PhpVal, var_deprecated rt.PhpVal) rt.PhpVal {
	mut var_id := var_id_arg
	mut var_return := rt.new_null()
	var_id = rt.new_int(var_id.to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_deprecated)))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.1.0')])
	}
	if rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_id)) {
		return rt.call_function('update_option', [var_option.clone(),
			var_value.clone()])
	}
	rt.new_bool(switch_to_blog(var_id.clone(), rt.new_null()))
	var_return = rt.call_function('update_option', [var_option.clone(),
		var_value.clone()])
	rt.new_bool(restore_current_blog())
	return var_return.clone()
}

fn switch_to_blog(var_new_blog_id_arg rt.PhpVal, var_deprecated rt.PhpVal) bool {
	mut var_new_blog_id := var_new_blog_id_arg
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_prev_blog_id := rt.new_null()
	var_prev_blog_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	if !rt.is_true(var_new_blog_id) {
		var_new_blog_id = var_prev_blog_id.clone()
	}
	var_GLOBALS.array_get_mut('_wp_switched_stack').array_push(var_prev_blog_id.clone())
	if rt.is_true(rt.identical(var_new_blog_id, var_prev_blog_id)) {
		rt.call_function('do_action', [rt.new_string('switch_blog'),
			var_new_blog_id.clone(), var_prev_blog_id.clone(),
			rt.new_string('switch')])
		var_GLOBALS.array_set('switched', true)
		return true
	}
	rt.call_method(var_wpdb, 'set_blog_id', [var_new_blog_id.clone()])
	var_GLOBALS.array_set('table_prefix',
		rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{}))
	var_GLOBALS.array_set('blog_id', var_new_blog_id.clone())
	rt.call_function('wp_cache_switch_to_blog', [var_new_blog_id.clone()])
	rt.call_function('do_action', [rt.new_string('switch_blog'),
		var_new_blog_id.clone(), var_prev_blog_id.clone(), rt.new_string('switch')])
	var_GLOBALS.array_set('switched', true)
	return true
}

fn restore_current_blog() bool {
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_new_blog_id := rt.new_null()
	mut var_prev_blog_id := rt.new_null()
	if !rt.is_true(var_GLOBALS.array_get(rt.new_string('_wp_switched_stack'))) {
		return false
	}
	var_new_blog_id = rt.call_function('array_pop', [
		var_GLOBALS.array_get(rt.new_string('_wp_switched_stack')),
	])
	var_prev_blog_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_new_blog_id, var_prev_blog_id)) {
		rt.call_function('do_action', [rt.new_string('switch_blog'),
			var_new_blog_id.clone(), var_prev_blog_id.clone(),
			rt.new_string('restore')])
		var_GLOBALS.array_set('switched',
			!(!rt.is_true(var_GLOBALS.array_get(rt.new_string('_wp_switched_stack')))))
		return true
	}
	rt.call_method(var_wpdb, 'set_blog_id', [var_new_blog_id.clone()])
	var_GLOBALS.array_set('blog_id', var_new_blog_id.clone())
	var_GLOBALS.array_set('table_prefix',
		rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{}))
	rt.call_function('wp_cache_switch_to_blog', [var_new_blog_id.clone()])
	rt.call_function('do_action', [rt.new_string('switch_blog'),
		var_new_blog_id.clone(), var_prev_blog_id.clone(), rt.new_string('restore')])
	var_GLOBALS.array_set('switched',
		!(!rt.is_true(var_GLOBALS.array_get(rt.new_string('_wp_switched_stack')))))
	return true
}

fn wp_cache_switch_to_blog_fallback() {
	mut var_wp_object_cache := rt.new_null()
	mut var_global_groups := rt.new_null()
	mut var_non_persistent_groups := rt.new_null()
	mut var_group_names := rt.new_null()
	mut var_all_groups := rt.new_null()
	var_global_groups = rt.new_bool(false)
	var_non_persistent_groups = rt.new_bool(false)
	if var_wp_object_cache.clone().is_object()
		&& !(rt.get_property(var_wp_object_cache, 'global_groups')).is_null()
		&& rt.get_property(var_wp_object_cache, 'global_groups').is_array() {
		var_group_names = rt.get_property(var_wp_object_cache, 'global_groups')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_numeric_array', [
			var_group_names.clone(),
		])))))
		{
			var_group_names = rt.func_array_keys(var_group_names.clone())
		}
		var_global_groups = var_group_names.clone()
		if !(rt.get_property(var_wp_object_cache, 'no_mc_groups')).is_null()
			&& rt.get_property(var_wp_object_cache, 'no_mc_groups').is_array()
			&& !(!rt.is_true(rt.get_property(var_wp_object_cache, 'no_mc_groups'))) {
			var_non_persistent_groups = rt.get_property(var_wp_object_cache, 'no_mc_groups')
		} else if !(rt.get_property(var_wp_object_cache, 'cache')).is_null()
			&& rt.get_property(var_wp_object_cache, 'cache').is_array() {
			var_all_groups = rt.func_array_keys(rt.get_property(var_wp_object_cache, 'cache'))
			var_non_persistent_groups = rt.call_function('array_values', [
				rt.call_function('array_diff', [var_all_groups.clone(),
					var_global_groups.clone()]),
			])
		}
	}
	rt.call_function('wp_cache_init', []rt.PhpVal{})
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_add_global_groups'),
	]))
	{
		if !(var_global_groups.clone().is_array()) || !rt.is_true(var_global_groups) {
			var_global_groups = rt.create_array([
				rt.ArrayItem{ key: none, val: 'blog-details' },
				rt.ArrayItem{ key: none, val: 'blog-id-cache' },
				rt.ArrayItem{ key: none, val: 'blog-lookup' },
				rt.ArrayItem{ key: none, val: 'blog_meta' },
				rt.ArrayItem{ key: none, val: 'global-posts' },
				rt.ArrayItem{ key: none, val: 'image_editor' },
				rt.ArrayItem{ key: none, val: 'networks' },
				rt.ArrayItem{ key: none, val: 'network-queries' },
				rt.ArrayItem{ key: none, val: 'sites' },
				rt.ArrayItem{ key: none, val: 'site-details' },
				rt.ArrayItem{ key: none, val: 'site-options' },
				rt.ArrayItem{ key: none, val: 'site-queries' },
				rt.ArrayItem{ key: none, val: 'site-transient' },
				rt.ArrayItem{ key: none, val: 'theme_files' },
				rt.ArrayItem{ key: none, val: 'translation_files' },
				rt.ArrayItem{ key: none, val: 'rss' },
				rt.ArrayItem{ key: none, val: 'users' },
				rt.ArrayItem{ key: none, val: 'user-queries' },
				rt.ArrayItem{ key: none, val: 'user_meta' },
				rt.ArrayItem{ key: none, val: 'useremail' },
				rt.ArrayItem{ key: none, val: 'userlogins' },
				rt.ArrayItem{ key: none, val: 'userslugs' },
			])
		}
		rt.call_function('wp_cache_add_global_groups', [var_global_groups.clone()])
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_add_non_persistent_groups'),
	]))
	{
		if !(var_non_persistent_groups.clone().is_array()) || !rt.is_true(var_non_persistent_groups) {
			var_non_persistent_groups = rt.create_array([
				rt.ArrayItem{ key: none, val: 'counts' },
				rt.ArrayItem{ key: none, val: 'plugins' },
				rt.ArrayItem{ key: none, val: 'theme_json' },
			])
		}
		rt.call_function('wp_cache_add_non_persistent_groups', [
			var_non_persistent_groups.clone()])
	}
}

fn wp_switch_roles_and_user(var_new_site_id rt.PhpVal, var_old_site_id rt.PhpVal) {
	if rt.is_true(rt.identical(var_new_site_id, var_old_site_id)) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('init'),
	])))))
	{
		return
	}
	rt.call_method(rt.call_function('wp_roles', []rt.PhpVal{}), 'for_site', [
		var_new_site_id.clone()])
	rt.call_method(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'for_site', [
		var_new_site_id.clone(),
	])
}

fn ms_is_switched() bool {
	mut var_GLOBALS := rt.new_null()
	return !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('_wp_switched_stack'))))
}

fn is_archived(var_id rt.PhpVal) rt.PhpVal {
	return get_blog_status(var_id.clone(), 'archived')
}

fn update_archived(var_id rt.PhpVal, var_archived rt.PhpVal) rt.PhpVal {
	rt.new_bool(update_blog_status(var_id.clone(), 'archived', var_archived.clone(), rt.new_null()))
	return var_archived.clone()
}

fn update_blog_status(var_blog_id rt.PhpVal, pref string, var_value rt.PhpVal, var_deprecated rt.PhpVal) bool {
	mut var_pref := pref
	mut var_wpdb := rt.new_null()
	mut var_allowed_field_names := []rt.PhpVal{}
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_deprecated)))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.1.0')])
	}
	var_allowed_field_names = ['site_id', 'domain', 'path', 'registered', 'last_updated', 'public',
		'archived', 'mature', 'spam', 'deleted', 'lang_id']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(pref),
		rt.create_array_from_list(var_allowed_field_names),
		rt.new_bool(true),
	])))))
	{
		return var_value.to_bool()
	}
	var_result = rt.call_function('wp_update_site', [var_blog_id.clone(),
		rt.create_array([rt.ArrayItem{ key: pref, val: var_value }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return false
	}
	return var_value.to_bool()
}

fn get_blog_status(var_id rt.PhpVal, pref string) rt.PhpVal {
	mut var_pref := pref
	mut var_wpdb := rt.new_null()
	mut var_details := rt.new_null()
	var_details = rt.call_function('get_site', [var_id.clone()])
	if rt.is_true(var_details) {
		return rt.get_property(var_details, '{"nodeType":"Expr_Variable","line":804,"name":"pref"}')
	}
	return rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT %s FROM '),
				rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE blog_id = %d')),
			rt.new_string(pref),
			var_id.clone(),
		]),
	])
}

fn get_last_updated(deprecated string, start i64, quantity i64) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_start := start
	mut var_quantity := quantity
	mut var_wpdb := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('MU')])
	}
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT blog_id, domain, path FROM '), rt.get_property(var_wpdb,
				'blogs')),
				rt.new_string(" WHERE site_id = %d AND public = '1' AND archived = '0' AND mature = '0' AND spam = '0' AND deleted = '0' AND last_updated != '0000-00-00 00:00:00' ORDER BY last_updated DESC limit %d, %d")),
			rt.call_function('get_current_network_id', []rt.PhpVal{}),
			rt.new_int(start),
			rt.new_int(quantity),
		]),
		rt.get_constant('ARRAY_A'),
	])
}

fn _update_blog_date_on_post_publish(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	mut var_post_type_obj := rt.new_null()
	var_post_type_obj = rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_obj))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type_obj, 'public'))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_new_status))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_old_status)))) {
		return
	}
	wpmu_update_blogs_date()
}

fn _update_blog_date_on_post_delete(var_post_id rt.PhpVal) {
	mut var_post := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	var_post_type_obj = rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_obj))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type_obj, 'public'))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post,
		'post_status')))))
	{
		return
	}
	wpmu_update_blogs_date()
}

fn _update_posts_count_on_delete(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post, 'post_type'))))) {
		return
	}
	rt.call_function('update_posts_count', []rt.PhpVal{})
}

fn _update_posts_count_on_transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.identical(var_new_status, var_old_status)) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.call_function('get_post_type', [
		var_post.clone(),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_new_status))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_old_status)))) {
		return
	}
	rt.call_function('update_posts_count', []rt.PhpVal{})
}

fn wp_count_sites(var_network_id_arg rt.PhpVal) rt.PhpVal {
	mut var_network_id := var_network_id_arg
	mut var_counts := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	mut var_q := rt.new_null()
	mut var__args := rt.new_null()
	mut var_statuses := []rt.PhpVal{}
	mut var_status := rt.new_null()
	if !rt.is_true(var_network_id) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	var_counts = rt.new_array()
	var_args = {
		'network_id':    var_network_id
		'number':        rt.new_int(1)
		'fields':        rt.new_string('ids')
		'no_found_rows': rt.new_bool(false)
	}
	var_q = create_wp_site_query(var_args.clone())
	var_counts.array_set('all', rt.get_property(var_q, 'found_sites'))
	var__args = var_args.clone()
	var_statuses = ['public', 'archived', 'mature', 'spam', 'deleted']
	for var_status_shadow in var_statuses {
		var__args = var_args.clone()
		var__args.array_set(rt.new_string(var_status_shadow.str()), 1)
		var_q = create_wp_site_query(var__args.clone())
		var_counts.array_set(rt.new_string(var_status_shadow.str()), rt.get_property(var_q,
			'found_sites'))
	}
	return var_counts.clone()
}

struct Class_WP_Site {
	rt.PhpObjectBase
}

struct Class_WP_Site_Query {
	rt.PhpObjectBase
}

fn create_wp_site(_args ...rt.PhpVal) &Class_WP_Site {
	mut obj := &Class_WP_Site{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_query(_args ...rt.PhpVal) &Class_WP_Site_Query {
	mut obj := &Class_WP_Site_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Site_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/ms-site.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/ms-network.php',
		'4')
}
