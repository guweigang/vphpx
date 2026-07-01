import rt

fn wp_insert_site(var_data rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_now := rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)])
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'domain', val: '' }, rt.ArrayItem{ key: 'path', val: '/' }, rt.ArrayItem{ key: 'network_id', val: rt.call_function('get_current_network_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'registered', val: var_now }, rt.ArrayItem{ key: 'last_updated', val: var_now }, rt.ArrayItem{ key: 'public', val: 1 }, rt.ArrayItem{ key: 'archived', val: 0 }, rt.ArrayItem{ key: 'mature', val: 0 }, rt.ArrayItem{ key: 'spam', val: 0 }, rt.ArrayItem{ key: 'deleted', val: 0 }, rt.ArrayItem{ key: 'lang_id', val: 0 }])
	mut var_prepared_data := wp_prepare_site_data(var_data.dup(), var_defaults.dup(), rt.new_null())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_data.dup()])) {
		return var_prepared_data.dup()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'blogs'), var_prepared_data.dup()]))) {
		return create_wp_error(rt.new_string('db_insert_error'), rt.call_function('__', [rt.new_string('Could not insert site into the database.')]), rt.get_property(var_wpdb, 'last_error'))
	}
	mut var_site_id := // unsupported expression: Expr_Cast_Int
	clean_blog_cache(var_site_id.dup())
	mut var_new_site := get_site(var_site_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_new_site)))) {
		return create_wp_error(rt.new_string('get_site_error'), rt.call_function('__', [rt.new_string('Could not retrieve site data.')]))
	}
	rt.call_function('do_action', [rt.new_string('wp_insert_site'), var_new_site.dup()])
	mut var_args := rt.call_function('array_diff_key', [var_data.dup(), var_defaults.dup()])
	if var_args.array_isset(rt.new_string('site_id')) {
		var_args.array_unset(rt.new_string('site_id'))
	}
	rt.call_function('do_action', [rt.new_string('wp_initialize_site'), var_new_site.dup(), var_args.dup()])
	if rt.is_true(rt.call_function('has_action', [rt.new_string('wpmu_new_blog')])) {
		mut var_user_id := if !(!rt.is_true(var_args.array_get('user_id'))) { var_args.array_get('user_id') } else { rt.new_int(0) }
		mut var_meta := if !(!rt.is_true(var_args.array_get('options'))) { var_args.array_get('options') } else { rt.new_array() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_meta.dup().array_isset(rt.new_string('WPLANG'))))))) {
			var_meta.array_set('WPLANG', rt.call_function('get_network_option', [rt.get_property(var_new_site, 'network_id'), rt.new_string('WPLANG')]))
		}
		mut var_allowed_data_fields := ['public', 'archived', 'mature', 'spam', 'deleted', 'lang_id']
		var_meta = rt.call_function('array_merge', [rt.call_function('array_intersect_key', [var_data.dup(), rt.call_function('array_flip', [var_allowed_data_fields.dup()])]), var_meta.dup()])
		rt.call_function('do_action_deprecated', [rt.new_string('wpmu_new_blog'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'id') }, rt.ArrayItem{ key: none, val: var_user_id }, rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'domain') }, rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'path') }, rt.ArrayItem{ key: none, val: rt.get_property(var_new_site, 'network_id') }, rt.ArrayItem{ key: none, val: var_meta }]), rt.new_string('5.1.0'), rt.new_string('wp_initialize_site')])
	}
	return // unsupported expression: Expr_Cast_Int
}

fn wp_update_site(var_site_id rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_site_id) {
		return create_wp_error(rt.new_string('site_empty_id'), rt.call_function('__', [rt.new_string('Site ID must not be empty.')]))
	}
	mut var_old_site := get_site(var_site_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_old_site)))) {
		return create_wp_error(rt.new_string('site_not_exist'), rt.call_function('__', [rt.new_string('Site does not exist.')]))
	}
	mut var_defaults := rt.call_method(var_old_site, 'to_array', []rt.PhpVal{})
	var_defaults.array_set('network_id', // unsupported expression: Expr_Cast_Int)
	var_defaults.array_set('last_updated', rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]))
	var_defaults.array_unset(rt.new_string('blog_id'))
	var_defaults.array_unset(rt.new_string('site_id'))
	var_data = wp_prepare_site_data(var_data.dup(), var_defaults.dup(), var_old_site.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
		return var_data.dup()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'blogs'), var_data.dup(), rt.create_array([rt.ArrayItem{ key: 'blog_id', val: rt.get_property(var_old_site, 'id') }])]))) {
		return create_wp_error(rt.new_string('db_update_error'), rt.call_function('__', [rt.new_string('Could not update site in the database.')]), rt.get_property(var_wpdb, 'last_error'))
	}
	clean_blog_cache(var_old_site.dup())
	mut var_new_site := get_site(rt.get_property(var_old_site, 'id'))
	rt.call_function('do_action', [rt.new_string('wp_update_site'), var_new_site.dup(), var_old_site.dup()])
	return // unsupported expression: Expr_Cast_Int
}

fn wp_delete_site(var_site_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_site_id) {
		return mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('site_empty_id'), rt.call_function('__', [rt.new_string('Site ID must not be empty.')])))
	}
	mut var_old_site := get_site(var_site_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_old_site)))) {
		return mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('site_not_exist'), rt.call_function('__', [rt.new_string('Site does not exist.')])))
	}
	mut var_errors := create_wp_error()
	rt.call_function('do_action', [rt.new_string('wp_validate_site_deletion'), var_errors, var_old_site.dup()])
	if !(!rt.is_true(rt.get_property(var_errors, 'errors'))) {
		return mut var_errors
	}
	rt.call_function('do_action_deprecated', [rt.new_string('delete_blog'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_old_site, 'id') }, rt.ArrayItem{ key: none, val: true }]), rt.new_string('5.1.0')])
	rt.call_function('do_action', [rt.new_string('wp_uninitialize_site'), var_old_site.dup()])
	if rt.is_true(rt.call_function('is_site_meta_supported', []rt.PhpVal{})) {
		mut var_blog_meta_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb, 'blogmeta')), rt.new_string(' WHERE blog_id = %d ')), rt.get_property(var_old_site, 'id')])])
		{
			mut iter_1 := var_blog_meta_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_mid := item_1.val
				rt.call_function('delete_metadata_by_mid', [rt.new_string('blog'), var_mid.dup()])
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'blogs'), rt.create_array([rt.ArrayItem{ key: 'blog_id', val: rt.get_property(var_old_site, 'id') }])]))) {
		return mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('db_delete_error'), rt.call_function('__', [rt.new_string('Could not delete site from the database.')]), rt.get_property(var_wpdb, 'last_error')))
	}
	clean_blog_cache(var_old_site.dup())
	rt.call_function('do_action', [rt.new_string('wp_delete_site'), var_old_site.dup()])
	rt.call_function('do_action_deprecated', [rt.new_string('deleted_blog'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_old_site, 'id') }, rt.ArrayItem{ key: none, val: true }]), rt.new_string('5.1.0')])
	return mut rt.cast_object_ptr[Class_WP_Error](var_old_site)
}

fn get_site(var_site rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_site) {
		var_site = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_site, 'WP_Site'))) {
		mut var__site := var_site.dup()
	} else if rt.is_true(rt.new_bool(var_site.dup().is_object())) {
		var__site = create_wp_site(var_site.dup())
	} else {
		var__site = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Site{}; return temp.get_instance(arg_0) }(var_site.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__site)))) {
		return rt.new_null()
	}
	var__site = rt.call_function('apply_filters', [rt.new_string('get_site'), var__site.dup()])
	return var__site.dup()
}

fn _prime_site_caches(var_ids rt.PhpVal, update_meta_cache bool) {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_non_cached_ids := rt.call_function('_get_non_cached_ids', [var_ids.dup(), rt.new_string('sites')])
	if !(!rt.is_true(var_non_cached_ids)) {
		mut var_fresh_sites := rt.call_method(var_wpdb, 'get_results', [rt.call_function('sprintf', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE blog_id IN (%s)')), rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('intval'), var_non_cached_ids.dup()])])])])
		update_site_cache(var_fresh_sites.dup(), false)
	}
	if var_update_meta_cache {
		wp_lazyload_site_meta(var_ids.dup())
	}
}

fn wp_lazyload_site_meta(var_site_ids rt.PhpVal) {
	if !rt.is_true(var_site_ids) {
		return rt.new_null()
	}
	mut var_lazyloader := rt.call_function('wp_metadata_lazyloader', []rt.PhpVal{})
	rt.call_method(var_lazyloader, 'queue_objects', [rt.new_string('blog'), var_site_ids.dup()])
}

fn update_site_cache(var_sites rt.PhpVal, update_meta_cache bool) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sites)))) {
		return rt.new_null()
	}
	mut var_site_ids := rt.new_array()
	mut var_site_data := rt.new_array()
	mut var_blog_details_data := rt.new_array()
	{
		mut iter_1 := var_sites.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_site := item_1.val
			var_site_ids << rt.get_property(var_site, 'blog_id')
			var_site_data.array_set(rt.get_property(var_site, 'blog_id'), var_site.dup())
			var_blog_details_data[(rt.get_property(var_site, 'blog_id')).str() + 'short'] = var_site.dup()
		}
	}
	rt.call_function('wp_cache_add_multiple', [var_site_data.dup(), rt.new_string('sites')])
	rt.call_function('wp_cache_add_multiple', [var_blog_details_data.dup(), rt.new_string('blog-details')])
	if var_update_meta_cache {
		update_sitemeta_cache(var_site_ids.dup())
	}
}

fn update_sitemeta_cache(var_site_ids rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_filter', [rt.new_string('update_blog_metadata_cache'), rt.new_string('wp_check_site_meta_support_prefilter')]))))) {
		rt.call_function('add_filter', [rt.new_string('update_blog_metadata_cache'), rt.new_string('wp_check_site_meta_support_prefilter')])
	}
	return rt.call_function('update_meta_cache', [rt.new_string('blog'), var_site_ids.dup()])
}

fn get_sites(var_args rt.PhpVal) rt.PhpVal {
	mut var_query := create_wp_site_query()
	return var_query.query(var_args.dup())
}

fn wp_prepare_site_data(var_data rt.PhpVal, var_defaults rt.PhpVal, var_old_site rt.PhpVal) rt.PhpVal {
	if var_data.array_isset(rt.new_string('site_id')) {
		if !(!rt.is_true(var_data.array_get('site_id'))) && !rt.is_true(var_data.array_get('network_id')) {
			var_data.array_set('network_id', var_data.array_get('site_id'))
		}
		var_data.array_unset(rt.new_string('site_id'))
	}
	var_data = rt.call_function('apply_filters', [rt.new_string('wp_normalize_site_data'), var_data.dup()])
	mut var_allowed_data_fields := ['domain', 'path', 'network_id', 'registered', 'last_updated', 'public', 'archived', 'mature', 'spam', 'deleted', 'lang_id']
	var_data = rt.call_function('array_intersect_key', [, ])
	mut var_errors := 
	
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

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site() &Class_WP_Site {
	mut obj := &Class_WP_Site{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_query() &Class_WP_Site_Query {
	mut obj := &Class_WP_Site_Query{
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




pub fn init_wp_includes_ms_site_php() {
}
