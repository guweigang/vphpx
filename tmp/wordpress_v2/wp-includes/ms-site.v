import rt
import crypto.md5

fn wp_insert_site(var_data rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_now := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_prepared_data := rt.new_null()
	mut var_site_id := rt.new_null()
	mut var_new_site := rt.new_null()
	mut var_args := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_allowed_data_fields := []rt.PhpVal{}
	var_now = rt.call_function('current_time', [rt.new_string('mysql'),
		rt.new_bool(true)])
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'domain', val: '' },
		rt.ArrayItem{ key: 'path', val: '/' }, rt.ArrayItem{ key: 'network_id', val: rt.call_function('get_current_network_id',
			[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'registered', val: var_now },
		rt.ArrayItem{ key: 'last_updated', val: var_now }, rt.ArrayItem{ key: 'public', val: 1 },
		rt.ArrayItem{ key: 'archived', val: 0 }, rt.ArrayItem{ key: 'mature', val: 0 },
		rt.ArrayItem{ key: 'spam', val: 0 }, rt.ArrayItem{ key: 'deleted', val: 0 },
		rt.ArrayItem{ key: 'lang_id', val: 0 }])
	var_prepared_data = wp_prepare_site_data(var_data.clone(), var_defaults.clone(), rt.new_null())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_data.clone()])) {
		return var_prepared_data.to_i64()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'insert', [
		rt.get_property(var_wpdb, 'blogs'),
		var_prepared_data.clone(),
	])))
	{
		return (create_wp_error(rt.new_string('db_insert_error'), rt.call_function('__', [
			rt.new_string('Could not insert site into the database.'),
		]), rt.get_property(var_wpdb, 'last_error'))).to_i64()
	}
	var_site_id = rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	clean_blog_cache(var_site_id.clone())
	var_new_site = get_site(var_site_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_new_site)))) {
		return (create_wp_error(rt.new_string('get_site_error'), rt.call_function('__', [
			rt.new_string('Could not retrieve site data.'),
		]))).to_i64()
	}
	rt.call_function('do_action', [rt.new_string('wp_insert_site'),
		var_new_site.clone()])
	var_args = rt.call_function('array_diff_key', [var_data.clone(),
		var_defaults.clone()])
	if var_args.array_isset(rt.new_string('site_id')) {
		var_args.array_unset(rt.new_string('site_id'))
	}
	rt.call_function('do_action', [rt.new_string('wp_initialize_site'),
		var_new_site.clone(), var_args.clone()])
	if rt.is_true(rt.call_function('has_action', [rt.new_string('wpmu_new_blog')])) {
		var_user_id = if !(!rt.is_true(var_args.array_get(rt.new_string('user_id')))) {
			var_args.array_get(rt.new_string('user_id'))
		} else {
			rt.new_int(0)
		}
		var_meta = if !(!rt.is_true(var_args.array_get(rt.new_string('options')))) {
			var_args.array_get(rt.new_string('options'))
		} else {
			rt.new_array()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_meta.clone().array_isset(rt.new_string('WPLANG'))))))) {
			var_meta.array_set('WPLANG', rt.call_function('get_network_option', [
				rt.get_property(var_new_site, 'network_id'),
				rt.new_string('WPLANG'),
			]))
		}
		var_allowed_data_fields = ['public', 'archived', 'mature', 'spam', 'deleted', 'lang_id']
		var_meta = rt.call_function('array_merge', [
			rt.call_function('array_intersect_key', [var_data.clone(),
				rt.call_function('array_flip', [
					rt.create_array_from_list(var_allowed_data_fields),
				])]),
			var_meta.clone(),
		])
		rt.call_function('do_action_deprecated', [rt.new_string('wpmu_new_blog'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'id') },
				rt.ArrayItem{ key: none, val: var_user_id },
				rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'domain') },
				rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'path') },
				rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'network_id') },
				rt.ArrayItem{ key: none, val: var_meta },
			]),
			rt.new_string('5.1.0'), rt.new_string('wp_initialize_site')])
	}
	return rt.new_int((rt.get_property(var_new_site, 'id')).to_i64())
}

fn wp_update_site(var_site_id rt.PhpVal, var_data_arg rt.PhpVal) i64 {
	mut var_data := var_data_arg
	mut var_wpdb := rt.new_null()
	mut var_old_site := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_new_site := rt.new_null()
	if !rt.is_true(var_site_id) {
		return (create_wp_error(rt.new_string('site_empty_id'), rt.call_function('__', [
			rt.new_string('Site ID must not be empty.'),
		]))).to_i64()
	}
	var_old_site = get_site(var_site_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_old_site)))) {
		return (create_wp_error(rt.new_string('site_not_exist'), rt.call_function('__', [
			rt.new_string('Site does not exist.'),
		]))).to_i64()
	}
	var_defaults = rt.call_method(var_old_site, 'to_array', []rt.PhpVal{})
	var_defaults.array_set('network_id',
		rt.new_int((var_defaults.array_get(rt.new_string('site_id'))).to_i64()))
	var_defaults.array_set('last_updated', rt.call_function('current_time', [
		rt.new_string('mysql'),
		rt.new_bool(true),
	]))
	var_defaults.array_unset(rt.new_string('blog_id'))
	var_defaults.array_unset(rt.new_string('site_id'))
	var_data = wp_prepare_site_data(var_data.clone(), var_defaults.clone(), var_old_site.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_data.clone()])) {
		return var_data.to_i64()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'update', [
		rt.get_property(var_wpdb, 'blogs'),
		var_data.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'blog_id', val: rt.get_property(var_old_site, 'id') },
		]),
	])))
	{
		return (create_wp_error(rt.new_string('db_update_error'), rt.call_function('__', [
			rt.new_string('Could not update site in the database.'),
		]), rt.get_property(var_wpdb, 'last_error'))).to_i64()
	}
	clean_blog_cache(var_old_site.clone())
	var_new_site = get_site(rt.get_property(var_old_site, 'id'))
	rt.call_function('do_action', [rt.new_string('wp_update_site'),
		var_new_site.clone(), var_old_site.clone()])
	return rt.new_int((rt.get_property(var_new_site, 'id')).to_i64())
}

fn wp_delete_site(var_site_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_old_site := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_blog_meta_ids := rt.new_null()
	mut var_mid := rt.new_null()
	if !rt.is_true(var_site_id) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('site_empty_id'), rt.call_function('__', [
			rt.new_string('Site ID must not be empty.'),
		])))
	}
	var_old_site = get_site(var_site_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_old_site)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('site_not_exist'), rt.call_function('__', [
			rt.new_string('Site does not exist.'),
		])))
	}
	var_errors = create_wp_error()
	rt.call_function('do_action', [rt.new_string('wp_validate_site_deletion'), var_errors,
		var_old_site.clone()])
	if !(!rt.is_true(rt.get_property(var_errors, 'errors'))) {
		return mut var_errors
	}
	rt.call_function('do_action_deprecated', [rt.new_string('delete_blog'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_old_site, 'id') },
			rt.ArrayItem{ key: none, val: true },
		]),
		rt.new_string('5.1.0')])
	rt.call_function('do_action', [rt.new_string('wp_uninitialize_site'),
		var_old_site.clone()])
	if rt.is_true(rt.call_function('is_site_meta_supported', []rt.PhpVal{})) {
		var_blog_meta_ids = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb,
					'blogmeta')), rt.new_string(' WHERE blog_id = %d ')),
				rt.get_property(var_old_site, 'id'),
			]),
		])
		mut iter_1 := var_blog_meta_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_mid_shadow := item_1.val
			rt.call_function('delete_metadata_by_mid', [rt.new_string('blog'),
				var_mid_shadow.clone()])
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'delete', [
		rt.get_property(var_wpdb, 'blogs'),
		rt.create_array([
			rt.ArrayItem{ key: 'blog_id', val: rt.get_property(var_old_site, 'id') },
		]),
	])))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('db_delete_error'), rt.call_function('__', [
			rt.new_string('Could not delete site from the database.'),
		]), rt.get_property(var_wpdb, 'last_error')))
	}
	clean_blog_cache(var_old_site.clone())
	rt.call_function('do_action', [rt.new_string('wp_delete_site'),
		var_old_site.clone()])
	rt.call_function('do_action_deprecated', [rt.new_string('deleted_blog'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_old_site, 'id') },
			rt.ArrayItem{ key: none, val: true },
		]),
		rt.new_string('5.1.0')])
	return mut rt.cast_object_ptr[Class_WP_Error](var_old_site)
}

fn get_site(var_site_arg rt.PhpVal) rt.PhpVal {
	mut var_site := var_site_arg
	mut var__site := rt.new_null()
	if !rt.is_true(var_site) {
		var_site = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_site, 'WP_Site'))) {
		var__site = var_site.clone()
	} else if rt.is_true(rt.new_bool(var_site.clone().is_object())) {
		var__site = create_wp_site(var_site.clone())
	} else {
		mut iife_temp_0 := Class_WP_Site{}
		mut iife_result_0 := iife_temp_0.get_instance(var_site.clone())
		var__site = iife_result_0
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__site)))) {
		return rt.new_null()
	}
	var__site = rt.call_function('apply_filters', [rt.new_string('get_site'),
		var__site.clone()])
	return var__site.clone()
}

fn _prime_site_caches(var_ids rt.PhpVal, update_meta_cache bool) {
	mut var_update_meta_cache := update_meta_cache
	mut var_wpdb := rt.new_null()
	mut var_non_cached_ids := rt.new_null()
	mut var_fresh_sites := rt.new_null()
	var_non_cached_ids = rt.call_function('_get_non_cached_ids', [
		var_ids.clone(), rt.new_string('sites')])
	if !(!rt.is_true(var_non_cached_ids)) {
		var_fresh_sites = rt.call_method(var_wpdb, 'get_results', [
			rt.call_function('sprintf', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
					'blogs')), rt.new_string(' WHERE blog_id IN (%s)')),
				rt.call_function('implode', [rt.new_string(','),
					rt.call_function('array_map', [rt.new_string('intval'),
						var_non_cached_ids.clone()])]),
			]),
		])
		update_site_cache(var_fresh_sites.clone(), false)
	}
	if var_update_meta_cache {
		wp_lazyload_site_meta(var_ids.clone())
	}
}

fn wp_lazyload_site_meta(var_site_ids rt.PhpVal) {
	mut var_lazyloader := rt.new_null()
	if !rt.is_true(var_site_ids) {
		return
	}
	var_lazyloader = rt.call_function('wp_metadata_lazyloader', []rt.PhpVal{})
	rt.call_method(var_lazyloader, 'queue_objects', [rt.new_string('blog'),
		rt.create_array_from_list(var_site_ids)])
}

fn update_site_cache(var_sites rt.PhpVal, update_meta_cache bool) {
	mut var_update_meta_cache := update_meta_cache
	mut var_site_ids := []rt.PhpVal{}
	mut var_site_data := rt.new_null()
	mut var_blog_details_data := map[string]rt.PhpVal{}
	mut var_site := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sites)))) {
		return
	}
	var_site_ids = rt.new_array()
	var_site_data = rt.new_array()
	var_blog_details_data = rt.new_array()
	mut iter_2 := var_sites.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_site_shadow := item_2.val
		var_site_ids << rt.get_property(var_site_shadow, 'blog_id')
		var_site_data.array_set(rt.get_property(var_site_shadow, 'blog_id'),
			var_site_shadow.clone())
		var_blog_details_data[(rt.get_property(var_site_shadow, 'blog_id')).str() + 'short'] =
			var_site_shadow.clone()
	}
	rt.call_function('wp_cache_add_multiple', [var_site_data.clone(),
		rt.new_string('sites')])
	rt.call_function('wp_cache_add_multiple', [
		rt.create_array_from_native_map(var_blog_details_data),
		rt.new_string('blog-details'),
	])
	if var_update_meta_cache {
		update_sitemeta_cache(rt.create_array_from_list(var_site_ids))
	}
}

fn update_sitemeta_cache(var_site_ids rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_filter', [
		rt.new_string('update_blog_metadata_cache'),
		rt.new_string('wp_check_site_meta_support_prefilter'),
	])))))
	{
		rt.call_function('add_filter', [rt.new_string('update_blog_metadata_cache'),
			rt.new_string('wp_check_site_meta_support_prefilter')])
	}
	return rt.call_function('update_meta_cache', [rt.new_string('blog'),
		rt.create_array_from_list(var_site_ids)])
}

fn get_sites(var_args rt.PhpVal) rt.PhpVal {
	mut var_query := rt.new_null()
	var_query = create_wp_site_query()
	return var_query.query(var_args.clone())
}

fn wp_prepare_site_data(var_data_arg rt.PhpVal, var_defaults rt.PhpVal, var_old_site rt.PhpVal) rt.PhpVal {
	mut var_data := var_data_arg
	mut var_allowed_data_fields := []rt.PhpVal{}
	mut var_errors := rt.new_null()
	if var_data.array_isset(rt.new_string('site_id')) {
		if !(!rt.is_true(var_data.array_get(rt.new_string('site_id'))))
			&& !rt.is_true(var_data.array_get(rt.new_string('network_id'))) {
			var_data.array_set('network_id', var_data.array_get(rt.new_string('site_id')))
		}
		var_data.array_unset(rt.new_string('site_id'))
	}
	var_data = rt.call_function('apply_filters', [
		rt.new_string('wp_normalize_site_data'),
		var_data.clone(),
	])
	var_allowed_data_fields = ['domain', 'path', 'network_id', 'registered', 'last_updated', 'public',
		'archived', 'mature', 'spam', 'deleted', 'lang_id']
	var_data = rt.call_function('array_intersect_key', [
		rt.call_function('wp_parse_args', [var_data.clone(), var_defaults.clone()]),
		rt.call_function('array_flip', [rt.create_array_from_list(var_allowed_data_fields)]),
	])
	var_errors = create_wp_error()
	rt.call_function('do_action', [rt.new_string('wp_validate_site_data'), var_errors,
		var_data.clone(), var_old_site.clone()])
	if !(!rt.is_true(rt.get_property(var_errors, 'errors'))) {
		return mut var_errors
	}
	var_data.array_set('site_id', var_data.array_get(rt.new_string('network_id')))
	var_data.array_unset(rt.new_string('network_id'))
	return mut rt.cast_object_ptr[Class_WP_Error](var_data)
}

fn wp_normalize_site_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_status_fields := []rt.PhpVal{}
	mut var_status_field := rt.new_null()
	mut var_date_fields := []rt.PhpVal{}
	mut var_date_field := rt.new_null()
	if rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string('domain')))) {
		var_data.array_set('domain', rt.call_function('preg_replace', [
			rt.new_string('/[^a-z0-9\\-.:]+/i'),
			rt.new_string(''),
			var_data.array_get(rt.new_string('domain')),
		]))
	}
	if rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string('path')))) {
		var_data.array_set('path', rt.call_function('trailingslashit', [
			rt.new_string('/' + var_data.array_get(rt.new_string('path')).to_string().trim_space()),
		]))
	}
	if rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string('network_id')))) {
		var_data.array_set('network_id',
			rt.new_int((var_data.array_get(rt.new_string('network_id'))).to_i64()))
	}
	var_status_fields = ['public', 'archived', 'mature', 'spam', 'deleted']
	for var_status_field_shadow in var_status_fields {
		if rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string(var_status_field_shadow.str()).clone()))) {
			var_data.array_set(rt.new_string(var_status_field_shadow.str()),
				rt.new_int((var_data.array_get(rt.new_string(var_status_field_shadow.str()))).to_i64()))
		}
	}
	var_date_fields = ['registered', 'last_updated']
	for var_date_field_shadow in var_date_fields {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string(var_date_field_shadow.str()).clone())))))) {
			continue
		}
		if !rt.is_true(var_data.array_get(rt.new_string(var_date_field_shadow.str())))
			|| rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_data.array_get(rt.new_string(var_date_field_shadow.str())))) {
			var_data.array_unset(rt.new_string(var_date_field_shadow.str()))
		}
	}
	return var_data.clone()
}

fn wp_validate_site_data(var_errors rt.PhpVal, var_data rt.PhpVal, var_old_site rt.PhpVal) {
	mut var_date_fields := []rt.PhpVal{}
	mut var_date_field := rt.new_null()
	mut var_month := rt.new_null()
	mut var_day := rt.new_null()
	mut var_year := rt.new_null()
	mut var_valid_date := rt.new_null()
	if !rt.is_true(var_data.array_get(rt.new_string('domain'))) {
		var_errors.add(rt.new_string('site_empty_domain'), rt.call_function('__', [
			rt.new_string('Site domain must not be empty.'),
		]))
	}
	if !rt.is_true(var_data.array_get(rt.new_string('path'))) {
		var_errors.add(rt.new_string('site_empty_path'), rt.call_function('__', [
			rt.new_string('Site path must not be empty.'),
		]))
	}
	if !rt.is_true(var_data.array_get(rt.new_string('network_id'))) {
		var_errors.add(rt.new_string('site_empty_network_id'), rt.call_function('__', [
			rt.new_string('Site network ID must be provided.'),
		]))
	}
	var_date_fields = ['registered', 'last_updated']
	for var_date_field_shadow in var_date_fields {
		if !rt.is_true(var_data.array_get(rt.new_string(var_date_field_shadow.str()))) {
			var_errors.add(rt.new_string('site_empty_' +
				(rt.new_string(var_date_field_shadow.str())).str()), rt.call_function('__', [
				rt.new_string('Both registration and last updated dates must be provided.'),
			]))
			break
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'),
			var_data.array_get(rt.new_string(var_date_field_shadow.str()))))))
		{
			var_month = rt.call_function('substr', [
				var_data.array_get(rt.new_string(var_date_field_shadow.str())),
				rt.new_int(5),
				rt.new_int(2),
			])
			var_day = rt.call_function('substr', [
				var_data.array_get(rt.new_string(var_date_field_shadow.str())),
				rt.new_int(8),
				rt.new_int(2),
			])
			var_year = rt.call_function('substr', [
				var_data.array_get(rt.new_string(var_date_field_shadow.str())),
				rt.new_int(0),
				rt.new_int(4),
			])
			var_valid_date = rt.call_function('wp_checkdate', [
				var_month.clone(), var_day.clone(), var_year.clone(),
				var_data.array_get(rt.new_string(var_date_field_shadow.str()))])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_valid_date)))) {
				var_errors.add(rt.new_string('site_invalid_' +
					(rt.new_string(var_date_field_shadow.str())).str()), rt.call_function('__', [
					rt.new_string('Both registration and last updated dates must be valid dates.'),
				]))
				break
			}
		}
	}
	if !(!rt.is_true(rt.get_property(var_errors, 'errors'))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_old_site))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data.array_get(rt.new_string('domain')), rt.get_property(var_old_site, 'domain')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data.array_get(rt.new_string('path')), rt.get_property(var_old_site, 'path')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data.array_get(rt.new_string('network_id')), rt.get_property(var_old_site, 'network_id'))))) {
		if rt.is_true(rt.call_function('domain_exists', [
			var_data.array_get(rt.new_string('domain')),
			var_data.array_get(rt.new_string('path')),
			var_data.array_get(rt.new_string('network_id')),
		]))
		{
			var_errors.add(rt.new_string('site_taken'), rt.call_function('__', [
				rt.new_string('Sorry, that site already exists!'),
			]))
		}
	}
}

fn wp_initialize_site(var_site_id rt.PhpVal, var_args_arg rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_site := rt.new_null()
	mut var_network := rt.new_null()
	mut var_orig_installing := rt.new_null()
	mut var_switch := false
	mut var_home_scheme := ''
	mut var_siteurl_scheme := ''
	mut var_wp_roles := rt.new_null()
	mut var_table_prefix := rt.new_null()
	if !rt.is_true(var_site_id) {
		return (create_wp_error(rt.new_string('site_empty_id'), rt.call_function('__', [
			rt.new_string('Site ID must not be empty.'),
		]))).to_bool()
	}
	var_site = get_site(var_site_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site)))) {
		return (create_wp_error(rt.new_string('site_invalid_id'), rt.call_function('__', [
			rt.new_string('Site with the ID does not exist.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(wp_is_site_initialized(var_site.clone()))) {
		return (create_wp_error(rt.new_string('site_already_initialized'), rt.call_function('__', [
			rt.new_string('The site appears to be already initialized.'),
		]))).to_bool()
	}
	var_network = rt.call_function('get_network', [
		rt.get_property(var_site, 'network_id'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network)))) {
		var_network = rt.call_function('get_network', []rt.PhpVal{})
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'user_id', val: 0 },
			rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Site %d')]),
				rt.get_property(var_site, 'id'),
			]) }, rt.ArrayItem{ key: 'options', val: rt.new_array() },
			rt.ArrayItem{ key: 'meta', val: rt.new_array() }])])
	var_args = rt.call_function('apply_filters', [
		rt.new_string('wp_initialize_site_args'),
		var_args.clone(),
		var_site.clone(),
		var_network.clone(),
	])
	var_orig_installing = rt.call_function('wp_installing', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_orig_installing)))) {
		rt.call_function('wp_installing', [rt.new_bool(true)])
	}
	var_switch = false
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id',
		[]rt.PhpVal{}), rt.get_property(var_site, 'id')))))
	{
		var_switch = true
		rt.call_function('switch_to_blog', [rt.get_property(var_site, 'id')])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	rt.call_function('make_db_current_silent', [rt.new_string('blog')])
	var_home_scheme = 'http'
	var_siteurl_scheme = 'http'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) {
		if rt.is_true(rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
			rt.call_function('get_home_url', [rt.get_property(var_network, 'site_id')]),
			rt.get_constant('PHP_URL_SCHEME'),
		])))
		{
			var_home_scheme = 'https'
		}
		if rt.is_true(rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
			rt.call_function('get_network_option', [rt.get_property(var_network, 'id'),
				rt.new_string('siteurl')]),
			rt.get_constant('PHP_URL_SCHEME'),
		])))
		{
			var_siteurl_scheme = 'https'
		}
	}
	rt.call_function('populate_options', [
		rt.call_function('array_merge', [
			rt.create_array([
				rt.ArrayItem{ key: 'home', val: rt.call_function('untrailingslashit', [
					rt.new_string(var_home_scheme + '://' +
						(rt.get_property(var_site, 'domain')).str() +
						(rt.get_property(var_site, 'path')).str()),
				]) },
				rt.ArrayItem{ key: 'siteurl', val: rt.call_function('untrailingslashit', [
					rt.new_string(var_siteurl_scheme + '://' +
						(rt.get_property(var_site, 'domain')).str() +
						(rt.get_property(var_site, 'path')).str()),
				]) },
				rt.ArrayItem{ key: 'blogname', val: rt.call_function('wp_unslash', [
					var_args.array_get(rt.new_string('title')),
				]) },
				rt.ArrayItem{ key: 'admin_email', val: '' },
				rt.ArrayItem{
					key: 'upload_path'
					val: if rt.is_true(rt.call_function('get_network_option', [
						rt.get_property(var_network, 'id'),
						rt.new_string('ms_files_rewriting'),
					]))
					{ (rt.get_constant('UPLOADBLOGSDIR')).str() + rt.concat(rt.concat(rt.new_string('/'), rt.get_property(var_site, 'id')), rt.new_string('/files')) } else { rt.call_function('get_blog_option', [
							rt.get_property(var_network, 'site_id'),
							rt.new_string('upload_path'),
						]) }
				},
				rt.ArrayItem{ key: 'blog_public', val: rt.new_int((rt.get_property(var_site,
					'public')).to_i64()) },
				rt.ArrayItem{ key: 'WPLANG', val: rt.call_function('get_network_option', [
					rt.get_property(var_network, 'id'),
					rt.new_string('WPLANG'),
				]) },
			]),
			var_args.array_get(rt.new_string('options')),
		]),
	])
	clean_blog_cache(var_site.clone())
	rt.call_function('populate_roles', []rt.PhpVal{})
	var_wp_roles = create_wp_roles()
	rt.call_function('populate_site_meta', [rt.get_property(var_site, 'id'),
		var_args.array_get(rt.new_string('meta'))])
	var_table_prefix = rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})
	rt.call_function('delete_metadata', [rt.new_string('user'),
		rt.new_int(0), rt.new_string(var_table_prefix.str() + 'user_level'),
		rt.new_null(), rt.new_bool(true)])
	rt.call_function('delete_metadata', [rt.new_string('user'),
		rt.new_int(0), rt.new_string(var_table_prefix.str() + 'capabilities'),
		rt.new_null(), rt.new_bool(true)])
	rt.call_function('wp_install_defaults', [var_args.array_get(rt.new_string('user_id'))])
	rt.call_function('add_user_to_blog', [rt.get_property(var_site, 'id'),
		var_args.array_get(rt.new_string('user_id')), rt.new_string('administrator')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('user_can', [var_args.array_get(rt.new_string('user_id')), rt.new_string('manage_network')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_meta', [var_args.array_get(rt.new_string('user_id')), rt.new_string('primary_blog'), rt.new_bool(true)]))))) {
		rt.call_function('update_user_meta', [var_args.array_get(rt.new_string('user_id')),
			rt.new_string('primary_blog'), rt.get_property(var_site, 'id')])
	}
	if var_switch {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	rt.call_function('wp_installing', [var_orig_installing.clone()])
	return true
}

fn wp_uninitialize_site(var_site_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_site := rt.new_null()
	mut var_users := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_switch := false
	mut var_uploads := rt.new_null()
	mut var_tables := rt.new_null()
	mut var_drop_tables := rt.new_null()
	mut var_table := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_top_dir := rt.new_null()
	mut var_stack := rt.new_null()
	mut var_index := i64(0)
	mut var_dh := rt.new_null()
	mut var_file := rt.new_null()
	if !rt.is_true(var_site_id) {
		return (create_wp_error(rt.new_string('site_empty_id'), rt.call_function('__', [
			rt.new_string('Site ID must not be empty.'),
		]))).to_bool()
	}
	var_site = get_site(var_site_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site)))) {
		return (create_wp_error(rt.new_string('site_invalid_id'), rt.call_function('__', [
			rt.new_string('Site with the ID does not exist.'),
		]))).to_bool()
	}
	if !(wp_is_site_initialized(var_site.clone())) {
		return (create_wp_error(rt.new_string('site_already_uninitialized'), rt.call_function('__', [
			rt.new_string('The site appears to be already uninitialized.'),
		]))).to_bool()
	}
	var_users = rt.call_function('get_users', [
		rt.create_array([
			rt.ArrayItem{ key: 'blog_id', val: rt.get_property(var_site, 'id') },
			rt.ArrayItem{ key: 'fields', val: 'ids' },
		]),
	])
	if !(!rt.is_true(var_users)) {
		mut iter_3 := var_users.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_user_id_shadow := item_3.val
			rt.call_function('remove_user_from_blog', [var_user_id_shadow.clone(),
				rt.get_property(var_site, 'id')])
		}
	}
	var_switch = false
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id',
		[]rt.PhpVal{}), rt.get_property(var_site, 'id')))))
	{
		var_switch = true
		rt.call_function('switch_to_blog', [rt.get_property(var_site, 'id')])
	}
	var_uploads = rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	var_tables = rt.call_method(var_wpdb, 'tables', [rt.new_string('blog')])
	var_drop_tables = rt.call_function('apply_filters', [
		rt.new_string('wpmu_drop_tables'),
		var_tables.clone(),
		rt.get_property(var_site, 'id'),
	])
	mut iter_4 := rt.cast_array(var_drop_tables).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_table_shadow := item_4.val
		rt.call_method(var_wpdb, 'query', [
			rt.new_string('DROP TABLE IF EXISTS `${var_table.to_string()}`'),
		])
	}
	var_dir = rt.call_function('apply_filters', [
		rt.new_string('wpmu_delete_blog_upload_dir'),
		var_uploads.array_get(rt.new_string('basedir')),
		rt.get_property(var_site, 'id'),
	])
	var_dir = rt.new_string(var_dir.clone().to_string().trim_right(' \t\n\r'))
	var_top_dir = var_dir.clone()
	var_stack = rt.create_array([rt.ArrayItem{ key: none, val: var_dir }])
	var_index = 0
	for var_index < var_stack.clone().array_count() {
		var_dir = var_stack.array_get(rt.new_int(var_index))
		var_dh = rt.call_function('opendir', [var_dir.clone()])
		if rt.is_true(var_dh) {
			var_file = rt.call_function('readdir', [var_dh.clone()])
			for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_file)))) {
				if rt.is_true(rt.identical(rt.new_string('.'), var_file))
					|| rt.is_true(rt.identical(rt.new_string('..'), var_file)) {
					var_file = rt.call_function('readdir', [var_dh.clone()])
					continue
				}
				if rt.is_true(rt.call_function('is_dir', [
					rt.new_string(var_dir.str() +
						(rt.get_constant('DIRECTORY_SEPARATOR')).str() + var_file.str()),
				]))
				{
					var_stack.array_push(var_dir.str() +
						(rt.get_constant('DIRECTORY_SEPARATOR')).str() + var_file.str())
				} else if rt.is_true(rt.call_function('is_file', [
					rt.new_string(var_dir.str() +
						(rt.get_constant('DIRECTORY_SEPARATOR')).str() + var_file.str()),
				]))
				{
					rt.call_function('unlink', [
						rt.new_string(var_dir.str() +
							(rt.get_constant('DIRECTORY_SEPARATOR')).str() + var_file.str()),
					])
				}
				var_file = rt.call_function('readdir', [var_dh.clone()])
			}
			rt.call_function('closedir', [var_dh.clone()])
		}
		var_index += 1
	}
	var_stack = rt.call_function('array_reverse', [var_stack.clone()])
	mut iter_5 := rt.cast_array(var_stack).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_dir_shadow := item_5.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_dir_shadow, var_top_dir)))) {
			rt.call_function('rmdir', [var_dir_shadow.clone()])
		}
	}
	if var_switch {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return true
}

fn wp_is_site_initialized(var_site_id_arg rt.PhpVal) bool {
	mut var_site_id := var_site_id_arg
	mut var_wpdb := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_switch := false
	mut var_suppress := rt.new_null()
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(var_site_id.clone().is_object())) {
		var_site_id = rt.get_property(var_site_id, 'blog_id')
	}
	var_site_id = rt.new_int(var_site_id.to_i64())
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_wp_is_site_initialized'),
		rt.new_null(),
		var_site_id.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return var_pre.to_bool()
	}
	var_switch = false
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id',
		[]rt.PhpVal{}), var_site_id))))
	{
		var_switch = true
		rt.call_function('remove_action', [rt.new_string('switch_blog'),
			rt.new_string('wp_switch_roles_and_user'), rt.new_int(1)])
		rt.call_function('switch_to_blog', [var_site_id.clone()])
	}
	var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
	var_result = rt.new_bool((rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('DESCRIBE '), rt.get_property(var_wpdb, 'posts')),
	])).to_bool())
	rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
	if var_switch {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		rt.call_function('add_action', [rt.new_string('switch_blog'),
			rt.new_string('wp_switch_roles_and_user'), rt.new_int(1),
			rt.new_int(2)])
	}
	return var_result.to_bool()
}

fn clean_blog_cache(var_blog_arg rt.PhpVal) {
	mut var_blog := var_blog_arg
	mut var__wp_suspend_cache_invalidation := rt.new_null()
	mut var_blog_id := rt.new_null()
	mut var_domain_path_key := ''
	if !(!rt.is_true(var__wp_suspend_cache_invalidation)) {
		return
	}
	if !rt.is_true(var_blog) {
		return
	}
	var_blog_id = var_blog.clone()
	var_blog = get_site(var_blog_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blog)))) {
		if !(var_blog_id.clone().is_long() || var_blog_id.clone().is_double()) {
			return
		}
		var_blog = create_wp_site(rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'blog_id', val: var_blog_id },
			rt.ArrayItem{ key: 'domain', val: rt.new_null() },
			rt.ArrayItem{ key: 'path', val: rt.new_null() },
		])))
	}
	var_blog_id = rt.get_property(var_blog, 'blog_id')
	var_domain_path_key = md5.hexhash((rt.get_property(var_blog, 'domain')).str() +
		(rt.get_property(var_blog, 'path')).str())
	rt.call_function('wp_cache_delete', [var_blog_id.clone(),
		rt.new_string('sites')])
	rt.call_function('wp_cache_delete', [var_blog_id.clone(),
		rt.new_string('site-details')])
	rt.call_function('wp_cache_delete', [var_blog_id.clone(),
		rt.new_string('blog-details')])
	rt.call_function('wp_cache_delete', [rt.new_string(var_blog_id.str() + 'short'),
		rt.new_string('blog-details')])
	rt.call_function('wp_cache_delete', [rt.new_string(var_domain_path_key.str()).clone(),
		rt.new_string('blog-lookup')])
	rt.call_function('wp_cache_delete', [rt.new_string(var_domain_path_key.str()).clone(),
		rt.new_string('blog-id-cache')])
	rt.call_function('wp_cache_delete', [var_blog_id.clone(),
		rt.new_string('blog_meta')])
	rt.call_function('do_action', [rt.new_string('clean_site_cache'),
		var_blog_id.clone(), var_blog.clone(), rt.new_string(var_domain_path_key.str()).clone()])
	wp_cache_set_sites_last_changed()
	rt.call_function('do_action_deprecated', [rt.new_string('refresh_blog_details'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_blog_id }]),
		rt.new_string('4.9.0'), rt.new_string('clean_site_cache')])
}

fn add_site_meta(var_site_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) rt.PhpVal {
	mut var_unique := unique
	return rt.call_function('add_metadata', [rt.new_string('blog'),
		var_site_id.clone(), var_meta_key.clone(), var_meta_value.clone(),
		rt.new_bool(unique)])
}

fn delete_site_meta(var_site_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string) rt.PhpVal {
	mut var_meta_value := meta_value
	return rt.call_function('delete_metadata', [rt.new_string('blog'),
		var_site_id.clone(), var_meta_key.clone(), rt.new_string(meta_value)])
}

fn get_site_meta(var_site_id rt.PhpVal, key string, single bool) rt.PhpVal {
	mut var_key := key
	mut var_single := single
	return rt.call_function('get_metadata', [rt.new_string('blog'),
		var_site_id.clone(), rt.new_string(key), rt.new_bool(single)])
}

fn update_site_meta(var_site_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	mut var_prev_value := prev_value
	return rt.call_function('update_metadata', [rt.new_string('blog'),
		var_site_id.clone(), var_meta_key.clone(), var_meta_value.clone(),
		rt.new_string(prev_value)])
}

fn delete_site_meta_by_key(var_meta_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('delete_metadata', [rt.new_string('blog'),
		rt.new_null(), var_meta_key.clone(), rt.new_string(''),
		rt.new_bool(true)])
}

fn wp_maybe_update_network_site_counts_on_update(var_new_site rt.PhpVal, var_old_site rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_null(), var_old_site)) {
		rt.call_function('wp_maybe_update_network_site_counts', [
			rt.get_property(var_new_site, 'network_id'),
		])
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_new_site, 'network_id'), rt.get_property(var_old_site,
		'network_id')))))
	{
		rt.call_function('wp_maybe_update_network_site_counts', [
			rt.get_property(var_new_site, 'network_id'),
		])
		rt.call_function('wp_maybe_update_network_site_counts', [
			rt.get_property(var_old_site, 'network_id'),
		])
	}
}

fn wp_maybe_transition_site_statuses_on_update(var_new_site rt.PhpVal, var_old_site_arg rt.PhpVal) {
	mut var_old_site := var_old_site_arg
	mut var_site_id := rt.new_null()
	var_site_id = rt.get_property(var_new_site, 'id')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_old_site)))) {
		var_old_site = create_wp_site(create_stdclass())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_new_site, 'spam'), rt.get_property(var_old_site,
		'spam')))))
	{
		if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_new_site, 'spam'))) {
			rt.call_function('do_action', [rt.new_string('make_spam_blog'),
				var_site_id.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('make_ham_blog'),
				var_site_id.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_new_site, 'mature'), rt.get_property(var_old_site,
		'mature')))))
	{
		if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_new_site, 'mature'))) {
			rt.call_function('do_action', [rt.new_string('mature_blog'),
				var_site_id.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('unmature_blog'),
				var_site_id.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_new_site, 'archived'), rt.get_property(var_old_site,
		'archived')))))
	{
		if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_new_site, 'archived'))) {
			rt.call_function('do_action', [rt.new_string('archive_blog'),
				var_site_id.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('unarchive_blog'),
				var_site_id.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_new_site, 'deleted'), rt.get_property(var_old_site,
		'deleted')))))
	{
		if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_new_site, 'deleted'))) {
			rt.call_function('do_action', [rt.new_string('make_delete_blog'),
				var_site_id.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('make_undelete_blog'),
				var_site_id.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_new_site, 'public'), rt.get_property(var_old_site,
		'public')))))
	{
		rt.call_function('do_action', [rt.new_string('update_blog_public'),
			var_site_id.clone(), rt.get_property(var_new_site, 'public')])
	}
}

fn wp_maybe_clean_new_site_cache_on_update(var_new_site rt.PhpVal, var_old_site rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_old_site, 'domain'), rt.get_property(var_new_site, 'domain')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_old_site, 'path'), rt.get_property(var_new_site, 'path'))))) {
		clean_blog_cache(var_new_site.clone())
	}
}

fn wp_update_blog_public_option_on_site_update(var_site_id rt.PhpVal, var_is_public rt.PhpVal) {
	if !(wp_is_site_initialized(var_site_id.clone())) {
		return
	}
	rt.call_function('update_blog_option', [var_site_id.clone(),
		rt.new_string('blog_public'), var_is_public.clone()])
}

fn wp_cache_set_sites_last_changed() {
	rt.call_function('wp_cache_set_last_changed', [rt.new_string('sites')])
}

fn wp_check_site_meta_support_prefilter(var_check rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_site_meta_supported', []rt.PhpVal{}))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %s table is not installed. Please run the network database upgrade.'),
				]),
				rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'blogmeta'),
			]),
			rt.new_string('5.1.0')])
		return false
	}
	return var_check.to_bool()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Site {
	rt.PhpObjectBase
}

struct Class_WP_Site_Query {
	rt.PhpObjectBase
}

struct Class_WP_Roles {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn create_wp_roles(_args ...rt.PhpVal) &Class_WP_Roles {
	mut obj := &Class_WP_Roles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn (mut this Class_WP_Roles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Roles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Roles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
