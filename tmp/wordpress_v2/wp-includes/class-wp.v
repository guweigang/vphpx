import rt
import crypto.md5

struct Class_WP {
	rt.PhpObjectBase
pub mut:
		public_query_vars rt.PhpVal = rt.new_array()
		private_query_vars rt.PhpVal = rt.new_array()
		extra_query_vars rt.PhpVal = rt.new_array()
		query_vars rt.PhpVal = rt.new_array()
		query_string rt.PhpVal = rt.new_string('')
		request rt.PhpVal = rt.new_string('')
		matched_rule rt.PhpVal = rt.new_string('')
		matched_query rt.PhpVal = rt.new_string('')
		did_permalink bool
}

fn (mut this Class_WP) add_query_var(var_qv rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_qv.clone(), this.public_query_vars, rt.new_bool(true)]))))) {
		this.public_query_vars.array_push(var_qv.clone())
	}
}

fn (mut this Class_WP) remove_query_var(var_name rt.PhpVal) {
	this.public_query_vars = rt.call_function('array_diff', [this.public_query_vars, rt.create_array([rt.ArrayItem{ key: none, val: var_name }])])
}

fn (mut this Class_WP) set_query_var(var_key rt.PhpVal, var_value rt.PhpVal) {
	this.query_vars.array_set(var_key, var_value.clone())
}

fn (mut this Class_WP) parse_request(extra_query_vars string) bool {
	mut var_wp_rewrite := rt.new_null()
	mut var_varmatch := []rt.PhpVal{}
	mut var_perma_query_vars := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('do_parse_request'), rt.new_bool(true), rt.new_object('WP', []string{}, &this), rt.new_string(extra_query_vars)]))))) {
		return false
	}
	this.query_vars = rt.new_array()
	mut var_post_type_query_vars := rt.new_array()
	if rt.is_true(rt.new_bool(rt.new_string(extra_query_vars).is_array())) {
		this.extra_query_vars = rt.new_string(extra_query_vars)
	} else if !(extra_query_vars == '') {
		rt.call_function('parse_str', [rt.new_string(extra_query_vars), this.extra_query_vars])
	}
	mut var_rewrite := rt.call_method(var_wp_rewrite, 'wp_rewrite_rules', []rt.PhpVal{})
	if !(!rt.is_true(var_rewrite)) {
		mut var_error := rt.new_string('404')
		this.did_permalink = true
		mut var_pathinfo := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO')) } else { rt.new_string('') }
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('?'), var_pathinfo.clone()])
		var_pathinfo = (list_tmp_1).array_get(0)
		var_pathinfo = rt.call_function('str_replace', [rt.new_string('%'), rt.new_string('%25'), var_pathinfo.clone()])
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string('?'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])
		mut var_req_uri := (list_tmp_2).array_get(0)
		mut var_self := rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF'))
		mut var_home_path := rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_PATH')])
		mut var_home_path_regex := rt.new_string('')
		if var_home_path.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_home_path)))) {
		var_home_path = rt.new_string(var_home_path.clone().to_string().trim_space())
		var_home_path_regex = rt.call_function('sprintf', [rt.new_string('|^%s|i'), rt.call_function('preg_quote', [var_home_path.clone(), rt.new_string('|')])])
		}
		var_req_uri = rt.call_function('str_replace', [var_pathinfo.clone(), rt.new_string(''), var_req_uri.clone()])
		var_req_uri = rt.new_string(var_req_uri.clone().to_string().trim_space())
		var_pathinfo = rt.new_string(var_pathinfo.clone().to_string().trim_space())
		var_self = rt.new_string(var_self.clone().to_string().trim_space())
		if !(!rt.is_true(var_home_path_regex)) {
		var_req_uri = rt.call_function('preg_replace', [var_home_path_regex.clone(), rt.new_string(''), var_req_uri.clone()])
		var_req_uri = rt.new_string(var_req_uri.clone().to_string().trim_space())
		var_pathinfo = rt.call_function('preg_replace', [var_home_path_regex.clone(), rt.new_string(''), var_pathinfo.clone()])
		var_pathinfo = rt.new_string(var_pathinfo.clone().to_string().trim_space())
		var_self = rt.call_function('preg_replace', [var_home_path_regex.clone(), rt.new_string(''), var_self.clone()])
		var_self = rt.new_string(var_self.clone().to_string().trim_space())
		}
		if !(!rt.is_true(var_pathinfo)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^.*' + (rt.get_property(var_wp_rewrite, 'index')).str() + '$|'), var_pathinfo.clone()]))))) {
		mut var_requested_path := var_pathinfo.clone()
		} else {
			if rt.is_true(rt.identical(var_req_uri, rt.get_property(var_wp_rewrite, 'index'))) {
			var_req_uri = rt.new_string('')
			}
		var_requested_path = var_req_uri.clone()
		}
		mut var_requested_file := var_req_uri.clone()
		this.request = var_requested_path.clone()
		mut var_request_match := var_requested_path.clone()
		if !rt.is_true(var_request_match) {
			if var_rewrite.array_isset(rt.new_string('$')) {
				this.matched_rule = rt.new_string('$')
			mut var_query := var_rewrite.array_get(rt.new_string('$'))
			mut var_matches := rt.create_array([rt.ArrayItem{ key: none, val: '' }])
			}
		} else {
			mut iter_1 := rt.cast_array(var_rewrite).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_query_shadow := item_1.val
				mut var_match := item_1.key
				if !(!rt.is_true(var_requested_file)) && rt.is_true(rt.call_function('str_starts_with', [var_match.clone(), var_requested_file.clone()])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_requested_file, var_requested_path)))) {
				var_request_match = rt.new_string((var_requested_file).str() + '/' + (var_requested_path).str())
				}
				if rt.is_true(rt.call_function('preg_match', [rt.new_string("#^${var_match.to_string()}#"), var_request_match.clone(), var_matches.clone()])) || rt.is_true(rt.call_function('preg_match', [rt.new_string("#^${var_match.to_string()}#"), rt.call_function('urldecode', [var_request_match.clone()]), var_matches.clone()])) {
					if rt.is_true(rt.get_property(var_wp_rewrite, 'use_verbose_page_rules')) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/pagename=\\$matches\\[([0-9]+)\\]/'), var_query_shadow.clone(), rt.create_array_from_list(var_varmatch)])) {
						mut var_page := rt.call_function('get_page_by_path', [var_matches.array_get(var_varmatch.array_get(rt.new_int(1)))])
						if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
							continue
						}
						mut var_post_status_obj := rt.call_function('get_post_status_object', [rt.get_property(var_page, 'post_status')])
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'public'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'protected'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'private'))))) && rt.is_true(rt.get_property(var_post_status_obj, 'exclude_from_search')) {
							continue
						}
					}
					this.matched_rule = var_match.clone()
					break
				}
			}
		}
		if !(!rt.is_true(this.matched_rule)) {
			var_query = rt.call_function('preg_replace', [rt.new_string('!^.+\\?!'), rt.new_string(''), var_query.clone()])
			mut iife_temp_0 := Class_WP_MatchesMapRegex{}
			mut iife_result_0 := iife_temp_0.apply(var_query.clone(), var_matches.clone())
			mut iife_temp_1 := Class_WP_MatchesMapRegex{}
			mut iife_result_1 := iife_temp_1.apply(var_query.clone(), var_matches.clone())
			var_query = rt.call_function('addslashes', [iife_result_0])
			this.matched_query = var_query.clone()
			rt.call_function('parse_str', [var_query.clone(), var_perma_query_vars.clone()])
			if rt.is_true(rt.identical(rt.new_string('404'), var_error)) {
				var_error = rt.new_null()
				rt.get_superglobal('_GET').array_unset(rt.new_string('error'))
			}
		}
		if !rt.is_true(var_requested_path) || rt.is_true(rt.identical(var_requested_file, var_self)) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')), rt.new_string('wp-admin/')])) {
			var_error = rt.new_null()
			rt.get_superglobal('_GET').array_unset(rt.new_string('error'))
			if !(var_perma_query_vars).is_null() && rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')), rt.new_string('wp-admin/')])) {
				var_perma_query_vars = rt.new_null()
			}
			this.did_permalink = false
		}
	}
	this.public_query_vars = rt.call_function('apply_filters', [rt.new_string('query_vars'), this.public_query_vars])
	mut iter_2 := rt.call_function('get_post_types', [rt.new_array(), rt.new_string('objects')]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_t := item_2.val
		mut var_post_type := item_2.key
		if rt.is_true(rt.call_function('is_post_type_viewable', [var_t.clone()])) && rt.is_true(rt.get_property(var_t, 'query_var')) {
			var_post_type_query_vars.array_set(rt.get_property(var_t, 'query_var'), var_post_type.clone())
		}
	}
	mut iter_3 := this.public_query_vars.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_wpvar := item_3.val
		if this.extra_query_vars.array_isset(var_wpvar) {
			this.query_vars.array_set(var_wpvar, this.extra_query_vars.array_get(var_wpvar))
		} else if rt.get_superglobal('_GET').array_isset(var_wpvar) && rt.get_superglobal('_POST').array_isset(var_wpvar) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get(var_wpvar), rt.get_superglobal('_POST').array_get(var_wpvar))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('A variable mismatch has been detected.')]), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view this item.')]), rt.new_int(400)])
		} else if rt.get_superglobal('_POST').array_isset(var_wpvar) {
			this.query_vars.array_set(var_wpvar, rt.get_superglobal('_POST').array_get(var_wpvar))
		} else if rt.get_superglobal('_GET').array_isset(var_wpvar) {
			this.query_vars.array_set(var_wpvar, rt.get_superglobal('_GET').array_get(var_wpvar))
		} else if var_perma_query_vars.array_isset(var_wpvar) {
			this.query_vars.array_set(var_wpvar, var_perma_query_vars.array_get(var_wpvar))
		}
		if !(!rt.is_true(this.query_vars.array_get(var_wpvar))) {
			if !(this.query_vars.array_get(var_wpvar).is_array()) {
				this.query_vars.array_set(var_wpvar, (this.query_vars.array_get(var_wpvar)).str())
			} else {
				mut iter_4 := this.query_vars.array_get(var_wpvar).iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_v := item_4.val
					mut var_vkey := item_4.key
					if rt.is_true(rt.call_function('is_scalar', [var_v.clone()])) {
						this.query_vars.array_get_mut(var_wpvar).array_set(var_vkey, (var_v).str())
					}
				}
			}
			if var_post_type_query_vars.array_isset(var_wpvar) {
				this.query_vars.array_set('post_type', var_post_type_query_vars.array_get(var_wpvar))
				this.query_vars.array_set('name', this.query_vars.array_get(var_wpvar))
			}
		}
	}
	mut iter_5 := rt.call_function('get_taxonomies', [rt.new_array(), rt.new_string('objects')]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_t := item_5.val
		mut var_taxonomy := item_5.key
		if rt.is_true(rt.get_property(var_t, 'query_var')) && this.query_vars.array_isset(rt.get_property(var_t, 'query_var')) {
			this.query_vars.array_set(rt.get_property(var_t, 'query_var'), rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('+'), this.query_vars.array_get(rt.get_property(var_t, 'query_var'))]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		mut iter_6 := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'publicly_queryable', val: false }]), rt.new_string('objects')]).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_t := item_6.val
			mut var_taxonomy := item_6.key
			if this.query_vars.array_isset(rt.new_string('taxonomy')) && rt.is_true(rt.identical(var_taxonomy, this.query_vars.array_get(rt.new_string('taxonomy')))) {
				this.query_vars.array_unset(rt.new_string('taxonomy'))
				this.query_vars.array_unset(rt.new_string('term'))
			}
		}
	}
	if this.query_vars.array_isset(rt.new_string('post_type')) {
		mut var_queryable_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'publicly_queryable', val: true }])])
		if !(this.query_vars.array_get(rt.new_string('post_type')).is_array()) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.query_vars.array_get(rt.new_string('post_type')), var_queryable_post_types.clone(), rt.new_bool(true)]))))) {
				this.query_vars.array_unset(rt.new_string('post_type'))
			}
		} else {
			this.query_vars.array_set('post_type', rt.call_function('array_intersect', [this.query_vars.array_get(rt.new_string('post_type')), var_queryable_post_types.clone()]))
		}
	}
	this.query_vars = rt.call_function('wp_resolve_numeric_slug_conflicts', [this.query_vars])
	mut iter_7 := rt.cast_array(this.private_query_vars).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_var := item_7.val
		if this.extra_query_vars.array_isset(var_var) {
			this.query_vars.array_set(var_var, this.extra_query_vars.array_get(var_var))
		}
	}
	if !(var_error).is_null() {
		this.query_vars.array_set('error', var_error.clone())
	}
	this.query_vars = rt.call_function('apply_filters', [rt.new_string('request'), this.query_vars])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_request'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP', []string{}, &this) }])])
	return true
}

fn (mut this Class_WP) send_headers() {
	mut var_wp_query := rt.new_null()
	mut var_headers := rt.new_array()
	mut var_status := rt.new_null()
	mut var_exit_required := rt.new_bool(false)
	mut var_date_format := rt.new_string('D, d M Y H:i:s')
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
	var_headers = rt.call_function('array_merge', [var_headers.clone(), rt.call_function('wp_get_nocache_headers', []rt.PhpVal{})])
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('unapproved')))) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('moderation-hash')))) {
		mut var_expires := rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS'))
		var_headers.array_set('Expires', rt.call_function('gmdate', [var_date_format.clone(), rt.add(rt.call_function('time', []rt.PhpVal{}), var_expires)]))
		var_headers.array_set('Cache-Control', rt.call_function('sprintf', [rt.new_string('max-age=%d, must-revalidate'), var_expires.clone()]))
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('error')))) {
		var_status = rt.new_int((this.query_vars.array_get(rt.new_string('error'))).to_i64())
		if rt.is_true(rt.identical(rt.new_int(404), var_status)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			var_headers = rt.call_function('array_merge', [var_headers.clone(), rt.call_function('wp_get_nocache_headers', []rt.PhpVal{})])
			}
			var_headers.array_set('Content-Type', (rt.call_function('get_option', [rt.new_string('html_type')])).str() + '; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str())
		} else if rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 403 }, rt.ArrayItem{ key: none, val: 500 }, rt.ArrayItem{ key: none, val: 502 }, rt.ArrayItem{ key: none, val: 503 }]), rt.new_bool(true)])) {
		var_exit_required = rt.new_bool(true)
		}
	} else if !rt.is_true(this.query_vars.array_get(rt.new_string('feed'))) {
		var_headers.array_set('Content-Type', (rt.call_function('get_option', [rt.new_string('html_type')])).str() + '; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str())
	} else {
		mut var_type := this.query_vars.array_get(rt.new_string('feed'))
		if rt.is_true(rt.identical(rt.new_string('feed'), this.query_vars.array_get(rt.new_string('feed')))) {
		var_type = rt.call_function('get_default_feed', []rt.PhpVal{})
		}
		var_headers.array_set('Content-Type', (rt.call_function('feed_content_type', [var_type.clone()])).str() + '; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str())
		if !(!rt.is_true(this.query_vars.array_get(rt.new_string('withcomments')))) || rt.is_true(rt.call_function('str_contains', [this.query_vars.array_get(rt.new_string('feed')), rt.new_string('comments-')])) || (!rt.is_true(this.query_vars.array_get(rt.new_string('withoutcomments'))) && !(!rt.is_true(this.query_vars.array_get(rt.new_string('p')))) || !(!rt.is_true(this.query_vars.array_get(rt.new_string('name')))) || !(!rt.is_true(this.query_vars.array_get(rt.new_string('page_id')))) || !(!rt.is_true(this.query_vars.array_get(rt.new_string('pagename')))) || !(!rt.is_true(this.query_vars.array_get(rt.new_string('attachment')))) || !(!rt.is_true(this.query_vars.array_get(rt.new_string('attachment_id'))))) {
			mut var_wp_last_modified_post := rt.call_function('mysql2date', [var_date_format.clone(), rt.call_function('get_lastpostmodified', [rt.new_string('GMT')]), rt.new_bool(false)])
			mut var_wp_last_modified_comment := rt.call_function('mysql2date', [var_date_format.clone(), rt.call_function('get_lastcommentmodified', [rt.new_string('GMT')]), rt.new_bool(false)])
			if rt.is_true(rt.greater(rt.call_function('strtotime', [var_wp_last_modified_post.clone()]), rt.call_function('strtotime', [var_wp_last_modified_comment.clone()]))) {
			mut var_wp_last_modified := var_wp_last_modified_post.clone()
			} else {
			var_wp_last_modified = var_wp_last_modified_comment.clone()
			}
		} else {
		var_wp_last_modified = rt.call_function('mysql2date', [var_date_format.clone(), rt.call_function('get_lastpostmodified', [rt.new_string('GMT')]), rt.new_bool(false)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_last_modified)))) {
		var_wp_last_modified = rt.call_function('gmdate', [var_date_format.clone()])
		}
		var_wp_last_modified = rt.concat(var_wp_last_modified, rt.new_string(' GMT'))
		mut var_wp_etag := rt.new_string('"' + md5.hexhash(var_wp_last_modified.clone().to_string()) + '"')
		var_headers.array_set('Last-Modified', var_wp_last_modified.clone())
		var_headers.array_set('ETag', var_wp_etag.clone())
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_IF_NONE_MATCH')) {
		mut var_client_etag := rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_IF_NONE_MATCH'))])
		} else {
		var_client_etag = rt.new_string('')
		}
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_IF_MODIFIED_SINCE')) {
		mut var_client_last_modified := rt.new_string(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_IF_MODIFIED_SINCE')).to_string().trim_space())
		} else {
		var_client_last_modified = rt.new_string('')
		}
		mut var_client_modified_timestamp := if rt.is_true(var_client_last_modified) { rt.call_function('strtotime', [var_client_last_modified.clone()]) } else { rt.new_int(0) }
		mut var_wp_modified_timestamp := rt.call_function('strtotime', [var_wp_last_modified.clone()])
		if rt.is_true(if rt.is_true(var_client_last_modified) && rt.is_true(var_client_etag) { rt.is_true(rt.greater_equal(var_client_modified_timestamp, var_wp_modified_timestamp)) && rt.is_true(rt.identical(var_client_etag, var_wp_etag)) } else { rt.is_true(rt.greater_equal(var_client_modified_timestamp, var_wp_modified_timestamp)) || rt.is_true(rt.identical(var_client_etag, var_wp_etag)) }) {
		var_status = rt.new_int(304)
		var_exit_required = rt.new_bool(true)
		}
	}
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
		mut var_post := if !(rt.get_property(var_wp_query, 'post')).is_null() { rt.get_property(var_wp_query, 'post') } else { rt.new_null() }
		if rt.is_true(var_post) && rt.is_true(rt.call_function('pings_open', [var_post.clone()])) {
			var_headers.array_set('X-Pingback', rt.call_function('get_bloginfo', [rt.new_string('pingback_url'), rt.new_string('display')]))
		}
		if !(!rt.is_true(rt.get_property(var_post, 'post_password'))) {
		var_headers = rt.call_function('array_merge', [var_headers.clone(), rt.call_function('wp_get_nocache_headers', []rt.PhpVal{})])
		}
	}
	var_headers = rt.call_function('apply_filters', [rt.new_string('wp_headers'), var_headers.clone(), rt.new_object('WP', []string{}, &this)])
	if !(!rt.is_true(var_status)) {
		rt.call_function('status_header', [var_status.clone()])
	}
	if var_headers.array_isset(rt.new_string('Last-Modified')) && rt.is_true(rt.identical(rt.new_bool(false), var_headers.array_get(rt.new_string('Last-Modified')))) {
		var_headers.array_unset(rt.new_string('Last-Modified'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
			rt.call_function('header_remove', [rt.new_string('Last-Modified')])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		mut iter_8 := rt.cast_array(var_headers).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_field_value := item_8.val
			mut var_name := item_8.key
			rt.call_function('header', [rt.new_string("${var_name.to_string()}: ${var_field_value.to_string()}")])
		}
	}
	if rt.is_true(var_exit_required) {
		exit(0)
	}
	rt.call_function('do_action_ref_array', [rt.new_string('send_headers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP', []string{}, &this) }])])
}

fn (mut this Class_WP) build_query_string() {
	this.query_string = rt.new_string('')
	mut iter_9 := rt.cast_array(rt.func_array_keys(this.query_vars)).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_wpvar := item_9.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.query_vars.array_get(var_wpvar))))) {
			this.query_string = rt.concat(this.query_string, if this.query_string.to_string().len < 1 { '' } else { '&' })
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [this.query_vars.array_get(var_wpvar)]))))) {
				continue
			}
			this.query_string = rt.concat(this.query_string, rt.new_string((var_wpvar).str() + '=' + (rt.call_function('rawurlencode', [this.query_vars.array_get(var_wpvar)])).str()))
		}
	}
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('query_string')])) {
		this.query_string = rt.call_function('apply_filters_deprecated', [rt.new_string('query_string'), rt.create_array([rt.ArrayItem{ key: none, val: this.query_string }]), rt.new_string('2.1.0'), rt.new_string('query_vars, request')])
		rt.call_function('parse_str', [this.query_string, this.query_vars])
	}
}

fn (mut this Class_WP) register_globals() {
	mut var_wp_query := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut iter_10 := rt.cast_array(rt.get_property(var_wp_query, 'query_vars')).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value := item_10.val
		mut var_key := item_10.key
		var_GLOBALS.array_set(var_key, var_value.clone())
	}
	var_GLOBALS.array_set('query_string', this.query_string)
	var_GLOBALS.array_get(rt.new_string('posts')) = rt.get_property(var_wp_query, 'posts')
	var_GLOBALS.array_set('post', if !(rt.get_property(var_wp_query, 'post')).is_null() { rt.get_property(var_wp_query, 'post') } else { rt.new_null() })
	var_GLOBALS.array_set('request', rt.get_property(var_wp_query, 'request'))
	if rt.is_true(rt.call_method(var_wp_query, 'is_single', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_wp_query, 'is_page', []rt.PhpVal{})) {
		var_GLOBALS.array_set('more', 1)
		var_GLOBALS.array_set('single', 1)
	}
	if rt.is_true(rt.call_method(var_wp_query, 'is_author', []rt.PhpVal{})) {
		var_GLOBALS.array_set('authordata', rt.call_function('get_userdata', [rt.call_function('get_queried_object_id', []rt.PhpVal{})]))
	}
}

fn (mut this Class_WP) init() {
	rt.call_function('wp_get_current_user', []rt.PhpVal{})
}

fn (mut this Class_WP) query_posts() {
	mut var_wp_the_query := rt.new_null()
	this.build_query_string()
	rt.call_method(var_wp_the_query, 'query', [this.query_vars])
}

fn (mut this Class_WP) handle_404() {
	mut var_wp_query := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('apply_filters', [rt.new_string('pre_handle_404'), rt.new_bool(false), var_wp_query.clone()]))))) {
		return
	}
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		return
	}
	mut var_set_404 := rt.new_bool(true)
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_robots', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_favicon', []rt.PhpVal{})) {
	var_set_404 = rt.new_bool(false)
	} else if rt.is_true(rt.get_property(var_wp_query, 'posts')) {
		mut var_content_found := rt.new_bool(true)
		if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
			mut var_post := if !(rt.get_property(var_wp_query, 'post')).is_null() { rt.get_property(var_wp_query, 'post') } else { rt.new_null() }
			mut var_next := rt.new_string('<!--nextpage-->')
			if rt.is_true(var_post) && !(!rt.is_true(this.query_vars.array_get(rt.new_string('page')))) {
				if rt.is_true(rt.call_function('str_contains', [rt.get_property(var_post, 'post_content'), var_next.clone()])) {
				mut var_page := rt.new_string(this.query_vars.array_get(rt.new_string('page')).to_string().trim_space())
				var_content_found = rt.less_equal(rt.new_int((var_page).to_i64()), rt.add(rt.call_function('substr_count', [rt.get_property(var_post, 'post_content'), var_next.clone()]), rt.new_int(1)))
				} else {
				var_content_found = rt.new_bool(false)
				}
			}
		}
		if rt.is_true(rt.get_property(var_wp_query, 'is_posts_page')) && !(!rt.is_true(this.query_vars.array_get(rt.new_string('page')))) {
		var_content_found = rt.new_bool(false)
		}
		if rt.is_true(var_content_found) {
		var_set_404 = rt.new_bool(false)
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{}))))) {
		mut var_author := rt.call_function('get_query_var', [rt.new_string('author')])
		if ((((rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) && var_author.clone().is_long() || var_author.clone().is_double() && rt.is_true(rt.greater(var_author, rt.new_int(0))) && rt.is_true(rt.call_function('is_user_member_of_blog', [var_author.clone()]))) || (rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) && rt.is_true(rt.call_function('get_queried_object', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_home', []rt.PhpVal{}))) || rt.is_true(rt.call_function('is_search', []rt.PhpVal{}))) || rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) {
		var_set_404 = rt.new_bool(false)
		}
	}
	if rt.is_true(var_set_404) {
		rt.call_method(var_wp_query, 'set_404', []rt.PhpVal{})
		rt.call_function('status_header', [rt.new_int(404)])
		rt.call_function('nocache_headers', []rt.PhpVal{})
	} else {
		rt.call_function('status_header', [rt.new_int(200)])
	}
}

fn (mut this Class_WP) main(query_args string) {
	this.init()
	mut var_parsed := rt.new_bool(this.parse_request(query_args))
	if rt.is_true(var_parsed) {
		this.query_posts()
		this.handle_404()
		this.register_globals()
	}
	this.send_headers()
	rt.call_function('do_action_ref_array', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP', []string{}, &this) }])])
}

struct Class_WP_MatchesMapRegex {
	rt.PhpObjectBase
}

fn create_wp(_args ...rt.PhpVal) &Class_WP {
	mut obj := &Class_WP{
		PhpObjectBase: rt.PhpObjectBase{}
		public_query_vars: rt.new_array()
		private_query_vars: rt.new_array()
		extra_query_vars: rt.new_array()
		query_vars: rt.new_array()
		query_string: rt.new_string('')
		request: rt.new_string('')
		matched_rule: rt.new_string('')
		matched_query: rt.new_string('')
		did_permalink: false
	}
	return obj
}

fn create_wp_matchesmapregex(_args ...rt.PhpVal) &Class_WP_MatchesMapRegex {
	mut obj := &Class_WP_MatchesMapRegex{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_query_var(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_query_var(dispatch_arg_0)
			return rt.new_null()
		}
		'set_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_query_var(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.parse_request(dispatch_arg_0))
		}
		'send_headers' {
			this.send_headers()
			return rt.new_null()
		}
		'build_query_string' {
			this.build_query_string()
			return rt.new_null()
		}
		'register_globals' {
			this.register_globals()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'query_posts' {
			this.query_posts()
			return rt.new_null()
		}
		'handle_404' {
			this.handle_404()
			return rt.new_null()
		}
		'main' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.main(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'public_query_vars' { return this.public_query_vars }
		'private_query_vars' { return this.private_query_vars }
		'extra_query_vars' { return this.extra_query_vars }
		'query_vars' { return this.query_vars }
		'query_string' { return this.query_string }
		'request' { return this.request }
		'matched_rule' { return this.matched_rule }
		'matched_query' { return this.matched_query }
		'did_permalink' { return rt.new_bool(this.did_permalink) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'public_query_vars' { this.public_query_vars = val; return true }
		'private_query_vars' { this.private_query_vars = val; return true }
		'extra_query_vars' { this.extra_query_vars = val; return true }
		'query_vars' { this.query_vars = val; return true }
		'query_string' { this.query_string = val; return true }
		'request' { this.request = val; return true }
		'matched_rule' { this.matched_rule = val; return true }
		'matched_query' { this.matched_query = val; return true }
		'did_permalink' { this.did_permalink = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_MatchesMapRegex) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_MatchesMapRegex) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_MatchesMapRegex) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
