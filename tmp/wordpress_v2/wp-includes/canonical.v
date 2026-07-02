import rt

fn redirect_canonical(var_requested_url_arg rt.PhpVal, do_redirect bool) string {
	mut var_do_redirect := do_redirect
	mut var_requested_url := var_requested_url_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_is_IIS := rt.new_null()
	mut var_wp_query := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_wp := rt.new_null()
	mut var_query_vars := rt.new_null()
	mut var__parsed_redirect_query := map[string]rt.PhpVal{}
	mut var_original := rt.new_null()
	mut var_redirect := rt.new_null()
	mut var_redirect_url := rt.new_null()
	mut var_redirect_obj := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_vars := rt.new_null()
	mut var_redirect_post := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	mut var_year := rt.new_null()
	mut var_month := rt.new_null()
	mut var_day := rt.new_null()
	mut var_date := rt.new_null()
	mut var_m := rt.new_null()
	mut var_author := rt.new_null()
	mut var_term_count := i64(0)
	mut var_tax_query := map[string]rt.PhpVal{}
	mut var_obj := rt.new_null()
	mut var_tax_url := rt.new_null()
	mut var_qv_remove := []rt.PhpVal{}
	mut var_tax_obj := rt.new_null()
	mut var_rewrite_vars := rt.new_null()
	mut var__qv := rt.new_null()
	mut var_category_name := rt.new_null()
	mut var_category := rt.new_null()
	mut var_page := rt.new_null()
	mut var_paged := rt.new_null()
	mut var_feed := rt.new_null()
	mut var_cpage := rt.new_null()
	mut var_addl_path := rt.new_null()
	mut var_default_feed := rt.new_null()
	mut var_format := rt.new_null()
	mut var_old_feed_files := rt.new_null()
	mut var_default_comments_page := rt.new_null()
	mut var_is_attachment_redirect := false
	mut var_attachment_id := rt.new_null()
	mut var_attachment_post := rt.new_null()
	mut var_attachment_parent_id := rt.new_null()
	mut var_attachment_url := rt.new_null()
	mut var__parsed_query := rt.new_null()
	mut var_user_home := rt.new_null()
	mut var_punctuation_pattern := rt.new_null()
	mut var_user_ts_type := rt.new_null()
	mut var_type := rt.new_null()
	mut var_func := rt.new_null()
	mut var_original_host_low := ''
	mut var_redirect_host_low := ''
	mut var_compare_original := []rt.PhpVal{}
	mut var_compare_redirect := []rt.PhpVal{}
	mut var_post_status_obj := rt.new_null()
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_METHOD')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')).to_string().to_upper()), rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }, rt.ArrayItem{ key: none, val: 'HEAD' }]), rt.new_bool(true)]))))) {
		return ''
	}
	if rt.is_true(rt.call_function('is_preview', []rt.PhpVal{})) && rt.is_true(rt.call_function('get_query_var', [rt.new_string('p')])) && rt.is_true(rt.identical(rt.new_string('publish'), rt.call_function('get_post_status', [rt.call_function('get_query_var', [rt.new_string('p')])]))) {
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('preview_id'))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('preview_nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_GET').array_get(rt.new_string('preview_nonce')), rt.new_string('post_preview_' + rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('preview_id'))).to_i64()).str())]))))) {
			rt.set_property(var_wp_query, 'is_preview', rt.new_bool(false))
		}
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_preview', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_trackback', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_favicon', []rt.PhpVal{})) || (rt.is_true(var_is_IIS) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('iis7_supports_permalinks', []rt.PhpVal{})))))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_requested_url)))) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_HOST')) {
		var_requested_url = rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https://' } else { 'http://' }).str())
		var_requested_url = rt.concat(var_requested_url, rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST')))
		var_requested_url = rt.concat(var_requested_url, rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')))
	}
	var_original = rt.call_function('parse_url', [var_requested_url.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_original)) {
		return ''
	}
	var_original = rt.add(var_original, rt.create_array([rt.ArrayItem{ key: 'host', val: '' }, rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'query', val: '' }, rt.ArrayItem{ key: 'scheme', val: '' }]))
	var_redirect = var_original.clone()
	var_redirect_url = rt.new_bool(false)
	var_redirect_obj = rt.new_bool(false)
	var_redirect.array_set('path', rt.call_function('preg_replace', [rt.new_string('|(%C2%A0)+$|i'), rt.new_string(''), var_redirect.array_get(rt.new_string('path'))]))
	if rt.is_true(rt.call_function('get_query_var', [rt.new_string('preview')])) {
		var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('preview'), var_redirect.array_get(rt.new_string('query'))]))
	}
	var_post_id = rt.call_function('get_query_var', [rt.new_string('p')])
	if rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) && rt.is_true(var_post_id) {
		var_redirect_url = rt.call_function('get_post_comments_feed_link', [var_post_id.clone(), rt.call_function('get_query_var', [rt.new_string('feed')])])
		var_redirect_obj = rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(var_redirect_url) {
			var_redirect.array_set('query', _remove_qs_args_if_not_in_url(var_redirect.array_get(rt.new_string('query')), rt.create_array([rt.ArrayItem{ key: none, val: 'p' }, rt.ArrayItem{ key: none, val: 'page_id' }, rt.ArrayItem{ key: none, val: 'attachment_id' }, rt.ArrayItem{ key: none, val: 'pagename' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'feed' }]), var_redirect_url.clone()))
			var_redirect.array_set('path', rt.call_function('parse_url', [var_redirect_url.clone(), rt.get_constant('PHP_URL_PATH')]))
		}
	}
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) && rt.is_true(rt.less(rt.get_property(var_wp_query, 'post_count'), rt.new_int(1))) && rt.is_true(var_post_id) {
		var_vars = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_type, post_parent FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID = %d')), var_post_id.clone()])])
		if !(!rt.is_true(var_vars.array_get(rt.new_int(0)))) {
			var_vars = var_vars.array_get(rt.new_int(0))
			if rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_vars, 'post_type'))) && rt.is_true(rt.greater(rt.get_property(var_vars, 'post_parent'), rt.new_int(0))) {
			var_post_id = rt.get_property(var_vars, 'post_parent')
			}
			var_redirect_url = rt.call_function('get_permalink', [var_post_id.clone()])
			var_redirect_obj = rt.call_function('get_post', [var_post_id.clone()])
			if rt.is_true(var_redirect_url) {
				var_redirect.array_set('query', _remove_qs_args_if_not_in_url(var_redirect.array_get(rt.new_string('query')), rt.create_array([rt.ArrayItem{ key: none, val: 'p' }, rt.ArrayItem{ key: none, val: 'page_id' }, rt.ArrayItem{ key: none, val: 'attachment_id' }, rt.ArrayItem{ key: none, val: 'pagename' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'post_type' }]), var_redirect_url.clone()))
			}
		}
	}
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		var_post_id = rt.call_function('max', [rt.call_function('get_query_var', [rt.new_string('p')]), rt.call_function('get_query_var', [rt.new_string('page_id')]), rt.call_function('get_query_var', [rt.new_string('attachment_id')])])
		var_redirect_post = if rt.is_true(var_post_id) { rt.call_function('get_post', [var_post_id.clone()]) } else { rt.new_bool(false) }
		if rt.is_true(var_redirect_post) {
			var_post_type_obj = rt.call_function('get_post_type_object', [rt.get_property(var_redirect_post, 'post_type')])
			if rt.is_true(var_post_type_obj) && rt.is_true(rt.get_property(var_post_type_obj, 'public')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_redirect_post, 'post_status'))))) {
				var_redirect_url = rt.call_function('get_permalink', [var_redirect_post.clone()])
				var_redirect_obj = rt.call_function('get_post', [var_redirect_post.clone()])
				var_redirect.array_set('query', _remove_qs_args_if_not_in_url(var_redirect.array_get(rt.new_string('query')), rt.create_array([rt.ArrayItem{ key: none, val: 'p' }, rt.ArrayItem{ key: none, val: 'page_id' }, rt.ArrayItem{ key: none, val: 'attachment_id' }, rt.ArrayItem{ key: none, val: 'pagename' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'post_type' }]), var_redirect_url.clone()))
			}
		}
		var_year = rt.call_function('get_query_var', [rt.new_string('year')])
		var_month = rt.call_function('get_query_var', [rt.new_string('monthnum')])
		var_day = rt.call_function('get_query_var', [rt.new_string('day')])
		if rt.is_true(var_year) && rt.is_true(var_month) && rt.is_true(var_day) {
			var_date = rt.call_function('sprintf', [rt.new_string('%04d-%02d-%02d'), var_year.clone(), var_month.clone(), var_day.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_checkdate', [var_month.clone(), var_day.clone(), var_year.clone(), var_date.clone()]))))) {
				var_redirect_url = rt.call_function('get_month_link', [var_year.clone(), var_month.clone()])
				var_redirect.array_set('query', _remove_qs_args_if_not_in_url(var_redirect.array_get(rt.new_string('query')), rt.create_array([rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'monthnum' }, rt.ArrayItem{ key: none, val: 'day' }]), var_redirect_url.clone()))
			}
		} else if rt.is_true(var_year) && rt.is_true(var_month) && rt.is_true(rt.greater(var_month, rt.new_int(12))) {
			var_redirect_url = rt.call_function('get_year_link', [var_year.clone()])
			var_redirect.array_set('query', _remove_qs_args_if_not_in_url(var_redirect.array_get(rt.new_string('query')), rt.create_array([rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'monthnum' }]), var_redirect_url.clone()))
		}
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('page')])) {
			var_post_id = rt.new_int(0)
			if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_wp_query, 'queried_object'), 'WP_Post'))) {
			var_post_id = rt.get_property(rt.get_property(var_wp_query, 'queried_object'), 'ID')
			} else if rt.is_true(rt.get_property(var_wp_query, 'post')) {
			var_post_id = rt.get_property(rt.get_property(var_wp_query, 'post'), 'ID')
			}
			if rt.is_true(var_post_id) {
				var_redirect_url = rt.call_function('get_permalink', [var_post_id.clone()])
				var_redirect_obj = rt.call_function('get_post', [var_post_id.clone()])
				var_redirect.array_set('path', var_redirect.array_get(rt.new_string('path')).to_string().trim_right(' \t\n\r'))
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('page'), var_redirect.array_get(rt.new_string('query'))]))
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) {
			var_redirect_url = redirect_guess_404_permalink()
			if rt.is_true(var_redirect_url) {
				var_redirect.array_set('query', _remove_qs_args_if_not_in_url(var_redirect.array_get(rt.new_string('query')), rt.create_array([rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'feed' }, rt.ArrayItem{ key: none, val: 'p' }, rt.ArrayItem{ key: none, val: 'page_id' }, rt.ArrayItem{ key: none, val: 'attachment_id' }, rt.ArrayItem{ key: none, val: 'pagename' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'post_type' }]), var_redirect_url.clone()))
			}
		}
	} else if var_wp_rewrite.clone().is_object() && rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_diff', [rt.func_array_keys(rt.get_property(var_wp, 'query_vars')), rt.create_array([rt.ArrayItem{ key: none, val: 'attachment' }, rt.ArrayItem{ key: none, val: 'attachment_id' }])]))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) {
			if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('attachment_id')))) {
				var_redirect_url = rt.call_function('get_attachment_link', [rt.call_function('get_query_var', [rt.new_string('attachment_id')])])
				var_redirect_obj = rt.call_function('get_post', [rt.call_function('get_query_var', [rt.new_string('attachment_id')])])
				if rt.is_true(var_redirect_url) {
					var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('attachment_id'), var_redirect.array_get(rt.new_string('query'))]))
				}
			} else {
			var_redirect_url = rt.call_function('get_attachment_link', []rt.PhpVal{})
			var_redirect_obj = rt.call_function('get_post', []rt.PhpVal{})
			}
		} else if rt.is_true(rt.call_function('is_single', []rt.PhpVal{})) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('p')))) && rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) {
			var_redirect_url = rt.call_function('get_permalink', [rt.call_function('get_query_var', [rt.new_string('p')])])
			var_redirect_obj = rt.call_function('get_post', [rt.call_function('get_query_var', [rt.new_string('p')])])
			if rt.is_true(var_redirect_url) {
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'p' }, rt.ArrayItem{ key: none, val: 'post_type' }]), var_redirect.array_get(rt.new_string('query'))]))
			}
		} else if rt.is_true(rt.call_function('is_single', []rt.PhpVal{})) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('name')))) && rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) {
			var_redirect_url = rt.call_function('get_permalink', [rt.call_method(var_wp_query, 'get_queried_object_id', []rt.PhpVal{})])
			var_redirect_obj = rt.call_function('get_post', [rt.call_method(var_wp_query, 'get_queried_object_id', []rt.PhpVal{})])
			if rt.is_true(var_redirect_url) {
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('name'), var_redirect.array_get(rt.new_string('query'))]))
			}
		} else if rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page_id')))) && rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) {
			var_redirect_url = rt.call_function('get_permalink', [rt.call_function('get_query_var', [rt.new_string('page_id')])])
			var_redirect_obj = rt.call_function('get_post', [rt.call_function('get_query_var', [rt.new_string('page_id')])])
			if rt.is_true(var_redirect_url) {
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('page_id'), var_redirect.array_get(rt.new_string('query'))]))
			}
		} else if rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_feed', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) && rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()))) {
		var_redirect_url = rt.call_function('home_url', [rt.new_string('/')])
		} else if rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page_id')))) && rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) && rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.identical(rt.call_function('get_query_var', [rt.new_string('page_id')]), rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()))) {
			var_redirect_url = rt.call_function('get_permalink', [rt.call_function('get_option', [rt.new_string('page_for_posts')])])
			var_redirect_obj = rt.call_function('get_post', [rt.call_function('get_option', [rt.new_string('page_for_posts')])])
			if rt.is_true(var_redirect_url) {
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('page_id'), var_redirect.array_get(rt.new_string('query'))]))
			}
		} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('m')))) && rt.is_true(rt.call_function('is_year', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_month', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_day', []rt.PhpVal{})) {
			var_m = rt.call_function('get_query_var', [rt.new_string('m')])
			match var_m.clone().to_string().len {
				4 {
				var_redirect_url = rt.call_function('get_year_link', [var_m.clone()])
				}
				6 {
				var_redirect_url = rt.call_function('get_month_link', [rt.call_function('substr', [var_m.clone(), rt.new_int(0), rt.new_int(4)]), rt.call_function('substr', [var_m.clone(), rt.new_int(4), rt.new_int(2)])])
				}
				8 {
				var_redirect_url = rt.call_function('get_day_link', [rt.call_function('substr', [var_m.clone(), rt.new_int(0), rt.new_int(4)]), rt.call_function('substr', [var_m.clone(), rt.new_int(4), rt.new_int(2)]), rt.call_function('substr', [var_m.clone(), rt.new_int(6), rt.new_int(2)])])
				}
			}
			if rt.is_true(var_redirect_url) {
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('m'), var_redirect.array_get(rt.new_string('query'))]))
			}
		} else if rt.is_true(rt.call_function('is_date', []rt.PhpVal{})) {
			var_year = rt.call_function('get_query_var', [rt.new_string('year')])
			var_month = rt.call_function('get_query_var', [rt.new_string('monthnum')])
			var_day = rt.call_function('get_query_var', [rt.new_string('day')])
			if rt.is_true(rt.call_function('is_day', []rt.PhpVal{})) && rt.is_true(var_year) && rt.is_true(var_month) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('day')))) {
				var_redirect_url = rt.call_function('get_day_link', [var_year.clone(), var_month.clone(), var_day.clone()])
				if rt.is_true(var_redirect_url) {
					var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'monthnum' }, rt.ArrayItem{ key: none, val: 'day' }]), var_redirect.array_get(rt.new_string('query'))]))
				}
			} else if rt.is_true(rt.call_function('is_month', []rt.PhpVal{})) && rt.is_true(var_year) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('monthnum')))) {
				var_redirect_url = rt.call_function('get_month_link', [var_year.clone(), var_month.clone()])
				if rt.is_true(var_redirect_url) {
					var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'monthnum' }]), var_redirect.array_get(rt.new_string('query'))]))
				}
			} else if rt.is_true(rt.call_function('is_year', []rt.PhpVal{})) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('year')))) {
				var_redirect_url = rt.call_function('get_year_link', [var_year.clone()])
				if rt.is_true(var_redirect_url) {
					var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('year'), var_redirect.array_get(rt.new_string('query'))]))
				}
			}
		} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('author')))) && rt.get_superglobal('_GET').array_get(rt.new_string('author')).is_string() && rt.is_true(rt.call_function('preg_match', [rt.new_string('|^[0-9]+$|'), rt.get_superglobal('_GET').array_get(rt.new_string('author'))])) {
			var_author = rt.call_function('get_userdata', [rt.call_function('get_query_var', [rt.new_string('author')])])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_author)))) && rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author = %d AND ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'publish\' LIMIT 1')), rt.get_property(var_author, 'ID')])])) {
				var_redirect_url = rt.call_function('get_author_posts_url', [rt.get_property(var_author, 'ID'), rt.get_property(var_author, 'user_nicename')])
				var_redirect_obj = var_author.clone()
				if rt.is_true(var_redirect_url) {
					var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('author'), var_redirect.array_get(rt.new_string('query'))]))
				}
			}
		} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
			var_term_count = 0
			mut iter_1 := rt.get_property(rt.get_property(var_wp_query, 'tax_query'), 'queried_terms').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax_query_shadow := item_1.val
				if var_tax_query_shadow.array_isset(rt.new_string('terms')) && rt.call_function('is_countable', [var_tax_query_shadow['terms']]) {
					var_term_count = var_term_count + var_tax_query_shadow['terms'].array_count()
				}
			}
			var_obj = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
			if var_term_count <= 1 && !(!rt.is_true(rt.get_property(var_obj, 'term_id'))) {
				var_tax_url = rt.call_function('get_term_link', [rt.new_int((rt.get_property(var_obj, 'term_id')).to_i64()), rt.get_property(var_obj, 'taxonomy')])
				if rt.is_true(var_tax_url) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_tax_url.clone()]))))) {
					if !(!rt.is_true(var_redirect.array_get(rt.new_string('query')))) {
						var_qv_remove = [rt.new_string('term'), rt.new_string('taxonomy')]
						if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
							var_qv_remove << rt.new_string('category_name')
							var_qv_remove << rt.new_string('cat')
						} else if rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
							var_qv_remove << rt.new_string('tag')
							var_qv_remove << rt.new_string('tag_id')
						} else {
							var_tax_obj = rt.call_function('get_taxonomy', [rt.get_property(var_obj, 'taxonomy')])
							if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(var_tax_obj, 'query_var'))))) {
								var_qv_remove << rt.get_property(var_tax_obj, 'query_var')
							}
						}
						var_rewrite_vars = rt.call_function('array_diff', [rt.func_array_keys(rt.get_property(var_wp_query, 'query')), rt.func_array_keys(rt.get_superglobal('_GET').clone())])
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_diff', [var_rewrite_vars.clone(), rt.func_array_keys(rt.get_superglobal('_GET').clone())]))))) {
							var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.create_array_from_list(var_qv_remove), var_redirect.array_get(rt.new_string('query'))]))
							var_tax_url = rt.call_function('parse_url', [var_tax_url.clone()])
							if !(!rt.is_true(var_tax_url.array_get(rt.new_string('query')))) {
								rt.call_function('parse_str', [var_tax_url.array_get(rt.new_string('query')), var_query_vars.clone()])
								var_redirect.array_set('query', rt.call_function('add_query_arg', [var_query_vars.clone(), var_redirect.array_get(rt.new_string('query'))]))
							} else {
								var_redirect.array_set('path', var_tax_url.array_get(rt.new_string('path')))
							}
						} else {
							for var__qv_shadow in var_qv_remove {
								if var_rewrite_vars.array_isset(var__qv_shadow) {
									var_redirect.array_set('query', rt.call_function('remove_query_arg', [var__qv_shadow.clone(), var_redirect.array_get(rt.new_string('query'))]))
								}
							}
						}
					}
				}
			}
		} else if rt.is_true(rt.call_function('is_single', []rt.PhpVal{})) && rt.is_true(rt.call_function('str_contains', [rt.get_property(var_wp_rewrite, 'permalink_structure'), rt.new_string('%category%')])) {
			var_category_name = rt.call_function('get_query_var', [rt.new_string('category_name')])
			if rt.is_true(var_category_name) {
				var_category = rt.call_function('get_category_by_path', [var_category_name.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_category)))) || rt.is_true(rt.call_function('is_wp_error', [var_category.clone()])) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_term', [rt.get_property(var_category, 'term_id'), rt.new_string('category'), rt.call_method(var_wp_query, 'get_queried_object_id', []rt.PhpVal{})]))))) {
				var_redirect_url = rt.call_function('get_permalink', [rt.call_method(var_wp_query, 'get_queried_object_id', []rt.PhpVal{})])
				var_redirect_obj = rt.call_function('get_post', [rt.call_method(var_wp_query, 'get_queried_object_id', []rt.PhpVal{})])
				}
			}
		}
		if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) && rt.is_true(rt.call_function('get_query_var', [rt.new_string('page')])) {
			var_page = rt.call_function('get_query_var', [rt.new_string('page')])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) {
			var_redirect_url = rt.call_function('get_permalink', [rt.call_function('get_queried_object_id', []rt.PhpVal{})])
			var_redirect_obj = rt.call_function('get_post', [rt.call_function('get_queried_object_id', []rt.PhpVal{})])
			}
			if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
				var_redirect_url = rt.call_function('trailingslashit', [var_redirect_url.clone()])
				if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
					var_redirect_url = rt.concat(var_redirect_url, rt.call_function('user_trailingslashit', [rt.concat(rt.concat(rt.get_property(var_wp_rewrite, 'pagination_base'), rt.new_string('/')), var_page), rt.new_string('paged')]))
				} else {
					var_redirect_url = rt.concat(var_redirect_url, rt.call_function('user_trailingslashit', [var_page.clone(), rt.new_string('single_paged')]))
				}
			}
			var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('page'), var_redirect.array_get(rt.new_string('query'))]))
		}
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('sitemap')])) {
			var_redirect_url = rt.call_function('get_sitemap_url', [rt.call_function('get_query_var', [rt.new_string('sitemap')]), rt.call_function('get_query_var', [rt.new_string('sitemap-subtype')]), rt.call_function('get_query_var', [rt.new_string('paged')])])
			var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'sitemap' }, rt.ArrayItem{ key: none, val: 'sitemap-subtype' }, rt.ArrayItem{ key: none, val: 'paged' }]), var_redirect.array_get(rt.new_string('query'))]))
		} else if rt.is_true(rt.call_function('get_query_var', [rt.new_string('paged')])) || rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) || rt.is_true(rt.call_function('get_query_var', [rt.new_string('cpage')])) {
			var_paged = rt.call_function('get_query_var', [rt.new_string('paged')])
			var_feed = rt.call_function('get_query_var', [rt.new_string('feed')])
			var_cpage = rt.call_function('get_query_var', [rt.new_string('cpage')])
			for rt.is_true(rt.call_function('preg_match', [rt.concat(rt.concat(rt.new_string('#/'), rt.get_property(var_wp_rewrite, 'pagination_base')), rt.new_string('/?[0-9]+?(/+)?$#')), var_redirect.array_get(rt.new_string('path'))])) || rt.is_true(rt.call_function('preg_match', [rt.new_string('#/(comments/?)?(feed|rss2?|rdf|atom)(/+)?$#'), var_redirect.array_get(rt.new_string('path'))])) || rt.is_true(rt.call_function('preg_match', [rt.concat(rt.concat(rt.new_string('#/'), rt.get_property(var_wp_rewrite, 'comments_pagination_base')), rt.new_string('-[0-9]+(/+)?$#')), var_redirect.array_get(rt.new_string('path'))])) {
				var_redirect.array_set('path', rt.call_function('preg_replace', [rt.concat(rt.concat(rt.new_string('#/'), rt.get_property(var_wp_rewrite, 'pagination_base')), rt.new_string('/?[0-9]+?(/+)?$#')), rt.new_string('/'), var_redirect.array_get(rt.new_string('path'))]))
				var_redirect.array_set('path', rt.call_function('preg_replace', [rt.new_string('#/(comments/?)?(feed|rss2?|rdf|atom)(/+|$)#'), rt.new_string('/'), var_redirect.array_get(rt.new_string('path'))]))
				var_redirect.array_set('path', rt.call_function('preg_replace', [rt.concat(rt.concat(rt.new_string('#/'), rt.get_property(var_wp_rewrite, 'comments_pagination_base')), rt.new_string('-[0-9]+?(/+)?$#')), rt.new_string('/'), var_redirect.array_get(rt.new_string('path'))]))
			}
			var_addl_path = rt.new_string('')
			var_default_feed = rt.call_function('get_default_feed', []rt.PhpVal{})
			if rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) && rt.is_true(rt.call_function('in_array', [var_feed.clone(), rt.get_property(var_wp_rewrite, 'feeds'), rt.new_bool(true)])) {
				var_addl_path = if !(!rt.is_true(var_addl_path)) { rt.call_function('trailingslashit', [var_addl_path.clone()]) } else { rt.new_string('') }
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('get_query_var', [rt.new_string('withcomments')])) {
					var_addl_path = rt.concat(var_addl_path, rt.new_string('comments/'))
				}
				if (rt.is_true(rt.identical(rt.new_string('rss'), var_default_feed)) && rt.is_true(rt.identical(rt.new_string('feed'), var_feed))) || rt.is_true(rt.identical(rt.new_string('rss'), var_feed)) {
				var_format = rt.new_string((if rt.is_true(rt.identical(rt.new_string('rss2'), var_default_feed)) { '' } else { 'rss2' }).str())
				} else {
				var_format = if rt.is_true(rt.identical(var_default_feed, var_feed)) || rt.is_true(rt.identical(rt.new_string('feed'), var_feed)) { rt.new_string('') } else { var_feed }
				}
				var_addl_path = rt.concat(var_addl_path, rt.call_function('user_trailingslashit', [rt.new_string('feed/' + (var_format).str()), rt.new_string('feed')]))
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('feed'), var_redirect.array_get(rt.new_string('query'))]))
			} else if rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('old'), var_feed)) {
				var_old_feed_files = rt.create_array([rt.ArrayItem{ key: 'wp-atom.php', val: 'atom' }, rt.ArrayItem{ key: 'wp-commentsrss2.php', val: 'comments_rss2' }, rt.ArrayItem{ key: 'wp-feed.php', val: var_default_feed }, rt.ArrayItem{ key: 'wp-rdf.php', val: 'rdf' }, rt.ArrayItem{ key: 'wp-rss.php', val: 'rss2' }, rt.ArrayItem{ key: 'wp-rss2.php', val: 'rss2' }])
				if var_old_feed_files.array_isset(rt.call_function('basename', [var_redirect.array_get(rt.new_string('path'))])) {
					var_redirect_url = rt.call_function('get_feed_link', [var_old_feed_files.array_get(rt.call_function('basename', [var_redirect.array_get(rt.new_string('path'))]))])
					rt.call_function('wp_redirect', [var_redirect_url.clone(), rt.new_int(301)])
					exit(0)
				}
			}
			if rt.is_true(rt.greater(var_paged, rt.new_int(0))) {
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('paged'), var_redirect.array_get(rt.new_string('query'))]))
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_feed', []rt.PhpVal{}))))) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{}))))) {
						var_addl_path = if !(!rt.is_true(var_addl_path)) { rt.call_function('trailingslashit', [var_addl_path.clone()]) } else { rt.new_string('') }
						if rt.is_true(rt.greater(var_paged, rt.new_int(1))) {
							var_addl_path = rt.concat(var_addl_path, rt.call_function('user_trailingslashit', [rt.concat(rt.concat(rt.get_property(var_wp_rewrite, 'pagination_base'), rt.new_string('/')), var_paged), rt.new_string('paged')]))
						}
					}
				} else if rt.is_true(rt.greater(var_paged, rt.new_int(1))) {
					var_redirect.array_set('query', rt.call_function('add_query_arg', [rt.new_string('paged'), var_paged.clone(), var_redirect.array_get(rt.new_string('query'))]))
				}
			}
			var_default_comments_page = rt.call_function('get_option', [rt.new_string('default_comments_page')])
			if rt.is_true(rt.call_function('get_option', [rt.new_string('page_comments')])) && (rt.is_true(rt.identical(rt.new_string('newest'), var_default_comments_page)) && rt.is_true(rt.greater(var_cpage, rt.new_int(0)))) || (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('newest'), var_default_comments_page)))) && rt.is_true(rt.greater(var_cpage, rt.new_int(1)))) {
				var_addl_path = if !(!rt.is_true(var_addl_path)) { rt.call_function('trailingslashit', [var_addl_path.clone()]) } else { rt.new_string('') }
				var_addl_path = rt.concat(var_addl_path, rt.call_function('user_trailingslashit', [rt.new_string((rt.get_property(var_wp_rewrite, 'comments_pagination_base')).str() + '-' + (var_cpage).str()), rt.new_string('commentpaged')]))
				var_redirect.array_set('query', rt.call_function('remove_query_arg', [rt.new_string('cpage'), var_redirect.array_get(rt.new_string('query'))]))
			}
			var_redirect.array_set('path', rt.call_function('preg_replace', [rt.new_string('|/' + (rt.call_function('preg_quote', [rt.get_property(var_wp_rewrite, 'index'), rt.new_string('|')])).str() + '/?$|'), rt.new_string('/'), var_redirect.array_get(rt.new_string('path'))]))
			var_redirect.array_set('path', rt.call_function('user_trailingslashit', [var_redirect.array_get(rt.new_string('path'))]))
			if !(!rt.is_true(var_addl_path)) && rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_redirect.array_get(rt.new_string('path')), rt.new_string('/' + (rt.get_property(var_wp_rewrite, 'index')).str() + '/')]))))) {
				var_redirect.array_set('path', (rt.call_function('trailingslashit', [var_redirect.array_get(rt.new_string('path'))])).str() + (rt.get_property(var_wp_rewrite, 'index')).str() + '/')
			}
			if !(!rt.is_true(var_addl_path)) {
				var_redirect.array_set('path', (rt.call_function('trailingslashit', [var_redirect.array_get(rt.new_string('path'))])).str() + (var_addl_path).str())
			}
		var_redirect_url = rt.new_string((var_redirect.array_get(rt.new_string('scheme'))).str() + '://' + (var_redirect.array_get(rt.new_string('host'))).str() + (var_redirect.array_get(rt.new_string('path'))).str())
		}
		if rt.is_true(rt.identical(rt.new_string('wp-register.php'), rt.call_function('basename', [var_redirect.array_get(rt.new_string('path'))]))) {
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_redirect_url = rt.call_function('apply_filters', [rt.new_string('wp_signup_location'), rt.call_function('network_site_url', [rt.new_string('wp-signup.php')])])
			} else {
			var_redirect_url = rt.call_function('wp_registration_url', []rt.PhpVal{})
			}
			rt.call_function('wp_redirect', [var_redirect_url.clone(), rt.new_int(301)])
			exit(0)
		}
	}
	var_is_attachment_redirect = false
	if rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('wp_attachment_pages_enabled')]))))) {
		var_attachment_id = rt.call_function('get_query_var', [rt.new_string('attachment_id')])
		var_attachment_post = rt.call_function('get_post', [var_attachment_id.clone()])
		var_attachment_parent_id = if rt.is_true(var_attachment_post) { rt.get_property(var_attachment_post, 'post_parent') } else { rt.new_int(0) }
		var_attachment_url = rt.call_function('wp_get_attachment_url', [var_attachment_id.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_attachment_url, var_redirect_url)))) {
			if rt.is_true(var_attachment_parent_id) {
			var_redirect_obj = rt.call_function('get_post', [var_attachment_parent_id.clone()])
			}
		var_redirect_url = var_attachment_url.clone()
		}
	var_is_attachment_redirect = true
	}
	var_redirect.array_set('query', rt.call_function('preg_replace', [rt.new_string('#^\\??&*?#'), rt.new_string(''), var_redirect.array_get(rt.new_string('query'))]))
	if rt.is_true(var_redirect_url) && !(!rt.is_true(var_redirect.array_get(rt.new_string('query')))) {
		rt.call_function('parse_str', [var_redirect.array_get(rt.new_string('query')), var__parsed_query.clone()])
		var_redirect = rt.call_function('parse_url', [var_redirect_url.clone()])
		if !(!rt.is_true(var__parsed_query.array_get(rt.new_string('name')))) && !(!rt.is_true(var_redirect.array_get(rt.new_string('query')))) {
			rt.call_function('parse_str', [var_redirect.array_get(rt.new_string('query')), rt.create_array_from_native_map(var__parsed_redirect_query)])
			if !rt.is_true(var__parsed_redirect_query['name']) {
				var__parsed_query.array_unset(rt.new_string('name'))
			}
		}
	var__parsed_query = rt.call_function('array_combine', [rt.call_function('rawurlencode_deep', [rt.func_array_keys(var__parsed_query.clone())]), rt.call_function('rawurlencode_deep', [rt.call_function('array_values', [var__parsed_query.clone()])])])
	var_redirect_url = rt.call_function('add_query_arg', [var__parsed_query.clone(), var_redirect_url.clone()])
	}
	if rt.is_true(var_redirect_url) {
	var_redirect = rt.call_function('parse_url', [var_redirect_url.clone()])
	}
	var_user_home = rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	if !(!rt.is_true(var_user_home.array_get(rt.new_string('host')))) {
		var_redirect.array_set('host', var_user_home.array_get(rt.new_string('host')))
	}
	if !rt.is_true(var_user_home.array_get(rt.new_string('path'))) {
		var_user_home.array_set('path', '/')
	}
	if !(!rt.is_true(var_user_home.array_get(rt.new_string('port')))) {
		var_redirect.array_set('port', var_user_home.array_get(rt.new_string('port')))
	} else {
		var_redirect.array_unset(rt.new_string('port'))
	}
	var_redirect = rt.add(var_redirect, rt.create_array([rt.ArrayItem{ key: 'host', val: '' }, rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'query', val: '' }, rt.ArrayItem{ key: 'scheme', val: '' }]))
	var_redirect.array_set('path', rt.call_function('preg_replace', [rt.new_string('|/' + (rt.call_function('preg_quote', [rt.get_property(var_wp_rewrite, 'index'), rt.new_string('|')])).str() + '/*?$|'), rt.new_string('/'), var_redirect.array_get(rt.new_string('path'))]))
	var_punctuation_pattern = rt.call_function('implode', [rt.new_string('|'), rt.call_function('array_map', [rt.new_string('preg_quote'), rt.create_array([rt.ArrayItem{ key: none, val: ' ' }, rt.ArrayItem{ key: none, val: '%20' }, rt.ArrayItem{ key: none, val: '!' }, rt.ArrayItem{ key: none, val: '%21' }, rt.ArrayItem{ key: none, val: '"' }, rt.ArrayItem{ key: none, val: '%22' }, rt.ArrayItem{ key: none, val: '\'' }, rt.ArrayItem{ key: none, val: '%27' }, rt.ArrayItem{ key: none, val: '(' }, rt.ArrayItem{ key: none, val: '%28' }, rt.ArrayItem{ key: none, val: ')' }, rt.ArrayItem{ key: none, val: '%29' }, rt.ArrayItem{ key: none, val: ',' }, rt.ArrayItem{ key: none, val: '%2C' }, rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: '%2E' }, rt.ArrayItem{ key: none, val: ';' }, rt.ArrayItem{ key: none, val: '%3B' }, rt.ArrayItem{ key: none, val: '{' }, rt.ArrayItem{ key: none, val: '%7B' }, rt.ArrayItem{ key: none, val: '}' }, rt.ArrayItem{ key: none, val: '%7D' }, rt.ArrayItem{ key: none, val: '%E2%80%9C' }, rt.ArrayItem{ key: none, val: '%E2%80%9D' }])])])
	var_redirect.array_set('path', rt.call_function('preg_replace', [rt.concat(rt.concat(rt.new_string('#('), var_punctuation_pattern), rt.new_string(')+$#')), rt.new_string(''), var_redirect.array_get(rt.new_string('path'))]))
	if !(!rt.is_true(var_redirect.array_get(rt.new_string('query')))) {
		var_redirect.array_set('query', rt.call_function('preg_replace', [rt.concat(rt.concat(rt.new_string('#((^|&)(p|page_id|cat|tag)=[^&]*?)('), var_punctuation_pattern), rt.new_string(')+$#')), rt.new_string('$1'), var_redirect.array_get(rt.new_string('query'))]))
		var_redirect.array_set('query', rt.call_function('preg_replace', [rt.new_string('#(^|&)(p|page_id|cat|tag)=?(&|$)#'), rt.new_string('&'), var_redirect.array_get(rt.new_string('query'))]).to_string().trim_space())
		var_redirect.array_set('query', rt.call_function('preg_replace', [rt.new_string('#(^|&)feed=rss(&|$)#'), rt.new_string('$1feed=rss2$2'), var_redirect.array_get(rt.new_string('query'))]))
		var_redirect.array_set('query', rt.call_function('preg_replace', [rt.new_string('#^\\??&*?#'), rt.new_string(''), var_redirect.array_get(rt.new_string('query'))]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{}))))) {
		var_redirect.array_set('path', rt.call_function('str_replace', [rt.new_string('/' + (rt.get_property(var_wp_rewrite, 'index')).str() + '/'), rt.new_string('/'), var_redirect.array_get(rt.new_string('path'))]))
	}
	if var_wp_rewrite.clone().is_object() && rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) && !(var_is_attachment_redirect) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{}))))) || (rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) && rt.is_true(rt.greater(rt.call_function('get_query_var', [rt.new_string('paged')]), rt.new_int(1)))) {
		var_user_ts_type = rt.new_string('')
		if rt.is_true(rt.greater(rt.call_function('get_query_var', [rt.new_string('paged')]), rt.new_int(0))) {
		var_user_ts_type = rt.new_string('paged')
		} else {
			mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'single' }, rt.ArrayItem{ key: none, val: 'category' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'day' }, rt.ArrayItem{ key: none, val: 'month' }, rt.ArrayItem{ key: none, val: 'year' }, rt.ArrayItem{ key: none, val: 'home' }]).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_type_shadow := item_2.val
				var_func = rt.new_string('is_' + (var_type_shadow).str())
				if rt.is_true(rt.call_function('call_user_func', [var_func.clone()])) {
					var_user_ts_type = var_type_shadow
					break
				}
			}
		}
		var_redirect.array_set('path', rt.call_function('user_trailingslashit', [var_redirect.array_get(rt.new_string('path')), var_user_ts_type.clone()]))
	} else if rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
		var_redirect.array_set('path', rt.call_function('trailingslashit', [var_redirect.array_get(rt.new_string('path'))]))
	}
	if rt.is_true(rt.call_function('is_robots', []rt.PhpVal{})) || !(!rt.is_true(rt.call_function('get_query_var', [rt.new_string('sitemap')]))) || !(!rt.is_true(rt.call_function('get_query_var', [rt.new_string('sitemap-stylesheet')]))) {
		var_redirect.array_set('path', rt.call_function('untrailingslashit', [var_redirect.array_get(rt.new_string('path'))]))
	}
	if rt.is_true(rt.call_function('str_contains', [var_redirect.array_get(rt.new_string('path')), rt.new_string('//')])) {
		var_redirect.array_set('path', rt.call_function('preg_replace', [rt.new_string('|/+|'), rt.new_string('/'), var_redirect.array_get(rt.new_string('path'))]))
	}
	if rt.is_true(rt.identical(rt.call_function('trailingslashit', [var_redirect.array_get(rt.new_string('path'))]), rt.call_function('trailingslashit', [var_user_home.array_get(rt.new_string('path'))]))) {
		var_redirect.array_set('path', rt.call_function('trailingslashit', [var_redirect.array_get(rt.new_string('path'))]))
	}
	var_original_host_low = var_original.array_get(rt.new_string('host')).to_string().to_lower()
	var_redirect_host_low = var_redirect.array_get(rt.new_string('host')).to_string().to_lower()
	if rt.is_true(rt.identical(rt.new_string((var_original_host_low).str()), rt.new_string((var_redirect_host_low).str()))) || (rt.is_true(rt.new_bool('www.' + var_original_host_low != var_redirect_host_low)) && rt.is_true(rt.new_bool('www.' + var_redirect_host_low != var_original_host_low))) {
		var_redirect.array_set('host', var_original.array_get(rt.new_string('host')))
	}
	var_compare_original = [var_original.array_get(rt.new_string('host')), var_original.array_get(rt.new_string('path'))]
	if !(!rt.is_true(var_original.array_get(rt.new_string('port')))) {
		var_compare_original << var_original.array_get(rt.new_string('port'))
	}
	if !(!rt.is_true(var_original.array_get(rt.new_string('query')))) {
		var_compare_original << var_original.array_get(rt.new_string('query'))
	}
	var_compare_redirect = [var_redirect.array_get(rt.new_string('host')), var_redirect.array_get(rt.new_string('path'))]
	if !(!rt.is_true(var_redirect.array_get(rt.new_string('port')))) {
		var_compare_redirect << var_redirect.array_get(rt.new_string('port'))
	}
	if !(!rt.is_true(var_redirect.array_get(rt.new_string('query')))) {
		var_compare_redirect << var_redirect.array_get(rt.new_string('query'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_compare_original, var_compare_redirect)))) {
		var_redirect_url = rt.new_string((var_redirect.array_get(rt.new_string('scheme'))).str() + '://' + (var_redirect.array_get(rt.new_string('host'))).str())
		if !(!rt.is_true(var_redirect.array_get(rt.new_string('port')))) {
			var_redirect_url = rt.concat(var_redirect_url, rt.new_string(':' + (var_redirect.array_get(rt.new_string('port'))).str()))
		}
		var_redirect_url = rt.concat(var_redirect_url, var_redirect.array_get(rt.new_string('path')))
		if !(!rt.is_true(var_redirect.array_get(rt.new_string('query')))) {
			var_redirect_url = rt.concat(var_redirect_url, rt.new_string('?' + (var_redirect.array_get(rt.new_string('query'))).str()))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) || rt.is_true(rt.identical(var_redirect_url, var_requested_url)) {
		return ''
	}
	if rt.is_true(rt.call_function('str_contains', [var_requested_url.clone(), rt.new_string('%')])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('lowercase_octets')]))))) {
fn lowercase_octets(var_matches rt.PhpVal) string {
	return var_matches.array_get(rt.new_int(0)).to_string().to_lower()
}

fn _remove_qs_args_if_not_in_url(var_query_string_arg rt.PhpVal, var_args_to_check rt.PhpVal, var_url rt.PhpVal) rt.PhpVal {
	mut var_query_string := var_query_string_arg
	mut var_parsed_query := rt.new_null()
	mut var_parsed_url := rt.new_null()
	mut var_qv := rt.new_null()
	var_parsed_url = rt.call_function('parse_url', [var_url.clone()])
	if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('query')))) {
		rt.call_function('parse_str', [var_parsed_url.array_get(rt.new_string('query')), var_parsed_query.clone()])
		mut iter_3 := var_args_to_check.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_qv_shadow := item_3.val
			if !(var_parsed_query.array_isset(var_qv_shadow)) {
			var_query_string = rt.call_function('remove_query_arg', [var_qv_shadow.clone(), var_query_string.clone()])
			}
		}
	} else {
	var_query_string = rt.call_function('remove_query_arg', [var_args_to_check.clone(), var_query_string.clone()])
	}
	return var_query_string.clone()
}

fn strip_fragment_from_url(var_url_arg rt.PhpVal) rt.PhpVal {
	mut var_url := var_url_arg
	mut var_parsed_url := rt.new_null()
	var_parsed_url = rt.call_function('wp_parse_url', [var_url.clone()])
	if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('host')))) {
		var_url = rt.new_string('')
		if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('scheme')))) {
		var_url = rt.new_string((var_parsed_url.array_get(rt.new_string('scheme'))).str() + ':')
		}
		var_url = rt.concat(var_url, rt.new_string('//' + (var_parsed_url.array_get(rt.new_string('host'))).str()))
		if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('port')))) {
			var_url = rt.concat(var_url, rt.new_string(':' + (var_parsed_url.array_get(rt.new_string('port'))).str()))
		}
		if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('path')))) {
			var_url = rt.concat(var_url, var_parsed_url.array_get(rt.new_string('path')))
		}
		if !(!rt.is_true(var_parsed_url.array_get(rt.new_string('query')))) {
			var_url = rt.concat(var_url, rt.new_string('?' + (var_parsed_url.array_get(rt.new_string('query'))).str()))
		}
	}
	return var_url.clone()
}

fn redirect_guess_404_permalink() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_publicly_viewable_statuses := rt.new_null()
	mut var_publicly_viewable_post_types := rt.new_null()
	mut var_strict_guess := rt.new_null()
	mut var_where := rt.new_null()
	mut var_post_types := rt.new_null()
	mut var_post_id := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('apply_filters', [rt.new_string('do_redirect_guess_404_permalink'), rt.new_bool(true)]))) {
		return rt.new_bool(false)
	}
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_redirect_guess_404_permalink'), rt.new_null()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return var_pre.clone()
	}
	if rt.is_true(rt.call_function('get_query_var', [rt.new_string('name')])) {
		var_publicly_viewable_statuses = rt.call_function('array_filter', [rt.call_function('get_post_stati', []rt.PhpVal{}), rt.new_string('is_post_status_viewable')])
		var_publicly_viewable_post_types = rt.call_function('array_filter', [rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'exclude_from_search', val: false }])]), rt.new_string('is_post_type_viewable')])
		var_strict_guess = rt.call_function('apply_filters', [rt.new_string('strict_redirect_guess_404_permalink'), rt.new_bool(false)])
		if rt.is_true(var_strict_guess) {
		var_where = rt.call_method(var_wpdb, 'prepare', [rt.new_string('post_name = %s'), rt.call_function('get_query_var', [rt.new_string('name')])])
		} else {
		var_where = rt.call_method(var_wpdb, 'prepare', [rt.new_string('post_name LIKE %s'), rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.call_function('get_query_var', [rt.new_string('name')])])).str() + '%')])
		}
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('post_type')])) {
			if rt.is_true(rt.new_bool(rt.call_function('get_query_var', [rt.new_string('post_type')]).is_array())) {
				var_post_types = rt.call_function('array_intersect', [rt.call_function('get_query_var', [rt.new_string('post_type')]), var_publicly_viewable_post_types.clone()])
				if !rt.is_true(var_post_types) {
					return rt.new_bool(false)
				}
				var_where = rt.concat(var_where, rt.new_string(' AND post_type IN (\'' + (rt.call_function('join', [rt.new_string('\', \''), rt.call_function('esc_sql', [rt.call_function('get_query_var', [rt.new_string('post_type')])])])).str() + '\')'))
			} else {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('get_query_var', [rt.new_string('post_type')]), var_publicly_viewable_post_types.clone(), rt.new_bool(true)]))))) {
					return rt.new_bool(false)
				}
				var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND post_type = %s'), rt.call_function('get_query_var', [rt.new_string('post_type')])]))
			}
		} else {
			var_where = rt.concat(var_where, rt.new_string(' AND post_type IN (\'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_function('esc_sql', [var_publicly_viewable_post_types.clone()])])).str() + '\')'))
		}
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('year')])) {
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND YEAR(post_date) = %d'), rt.call_function('get_query_var', [rt.new_string('year')])]))
		}
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('monthnum')])) {
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND MONTH(post_date) = %d'), rt.call_function('get_query_var', [rt.new_string('monthnum')])]))
		}
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('day')])) {
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND DAYOFMONTH(post_date) = %d'), rt.call_function('get_query_var', [rt.new_string('day')])]))
		}
		var_post_id = rt.call_method(var_wpdb, 'get_var', [rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ')), var_where), rt.new_string(' AND post_status IN (\'')) + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_function('esc_sql', [var_publicly_viewable_statuses.clone()])])).str() + '\')').str())])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
			return rt.new_bool(false)
		}
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('feed')])) {
			return rt.call_function('get_post_comments_feed_link', [var_post_id.clone(), rt.call_function('get_query_var', [rt.new_string('feed')])])
		} else if rt.is_true(rt.greater(rt.call_function('get_query_var', [rt.new_string('page')]), rt.new_int(1))) {
			return rt.new_string((rt.call_function('trailingslashit', [rt.call_function('get_permalink', [var_post_id.clone()])])).str() + (rt.call_function('user_trailingslashit', [rt.call_function('get_query_var', [rt.new_string('page')]), rt.new_string('single_paged')])).str())
		} else {
			return rt.call_function('get_permalink', [var_post_id.clone()])
		}
	}
	return rt.new_bool(false)
}

fn wp_redirect_admin_locations() {
	mut var_wp_rewrite := rt.new_null()
	mut var_admins := []rt.PhpVal{}
	mut var_logins := []rt.PhpVal{}
	if !(rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{}))) {
		return
	}
	var_admins = [rt.call_function('home_url', [rt.new_string('wp-admin'), rt.new_string('relative')]), rt.call_function('home_url', [rt.new_string('dashboard'), rt.new_string('relative')]), rt.call_function('home_url', [rt.new_string('admin'), rt.new_string('relative')]), rt.call_function('site_url', [rt.new_string('dashboard'), rt.new_string('relative')]), rt.call_function('site_url', [rt.new_string('admin'), rt.new_string('relative')])]
	if rt.is_true(rt.call_function('in_array', [rt.call_function('untrailingslashit', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]), rt.create_array_from_list(var_admins), rt.new_bool(true)])) {
		rt.call_function('wp_redirect', [rt.call_function('admin_url', []rt.PhpVal{})])
		exit(0)
	}
	var_logins = [rt.call_function('home_url', [rt.new_string('wp-login.php'), rt.new_string('relative')]), rt.call_function('home_url', [rt.new_string('login.php'), rt.new_string('relative')]), rt.call_function('home_url', [rt.new_string('login'), rt.new_string('relative')]), rt.call_function('site_url', [rt.new_string('login'), rt.new_string('relative')])]
	if rt.is_true(rt.call_function('in_array', [rt.call_function('untrailingslashit', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]), rt.create_array_from_list(var_logins), rt.new_bool(true)])) {
		rt.call_function('wp_redirect', [rt.call_function('wp_login_url', []rt.PhpVal{})])
		exit(0)
	}
}


fn main() {
	defer {
		rt.shutdown()
	}

		}
	var_requested_url = rt.call_function('preg_replace_callback', [rt.new_string('|%[a-fA-F0-9][a-fA-F0-9]|'), rt.new_string('lowercase_octets'), var_requested_url.clone()])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_redirect_obj, 'WP_Post'))) {
		var_post_status_obj = rt.call_function('get_post_status_object', [rt.call_function('get_post_status', [var_redirect_obj.clone()])])
		if !(rt.is_true(rt.get_property(var_post_status_obj, 'private')) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_redirect_obj, 'ID')]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_publicly_viewable', [var_redirect_obj.clone()]))))) {
		var_redirect_obj = rt.new_bool(false)
		var_redirect_url = rt.new_bool(false)
		}
	}
	var_redirect_url = rt.call_function('apply_filters', [rt.new_string('redirect_canonical'), var_redirect_url.clone(), var_requested_url.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_url)))) || rt.is_true(rt.identical(strip_fragment_from_url(var_redirect_url.clone()), strip_fragment_from_url(var_requested_url.clone()))) {
		return ''
	}
	if var_do_redirect {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(redirect_canonical(var_redirect_url.clone(), false)))))) {
			rt.call_function('wp_redirect', [var_redirect_url.clone(), rt.new_int(301)])
			exit(0)
		} else {
			return ''
		}
	} else {
		return (var_redirect_url).str()
	}
	return ''
}

}
