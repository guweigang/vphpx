import rt
import crypto.md5

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
pub mut:
		request string
		meta_query rt.PhpVal = rt.new_bool(false)
		meta_query_clauses rt.PhpVal = rt.new_null()
		sql_clauses rt.PhpVal = rt.new_array()
		filtered_where_clause rt.PhpVal = rt.new_null()
		date_query rt.PhpVal = rt.new_bool(false)
		query_vars rt.PhpVal = rt.new_null()
		query_var_defaults rt.PhpVal = rt.new_null()
		comments rt.PhpVal = rt.new_null()
		found_comments rt.PhpVal = rt.new_int(0)
		max_num_pages rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Comment_Query) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('get_search_sql'), var_name)) {
		return this.get_search_sql(var_arguments.clone(), rt.new_null())
	}
	return false
}

fn (mut this Class_WP_Comment_Query) construct(query string) {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([rt.ArrayItem{ key: 'author_email', val: '' }, rt.ArrayItem{ key: 'author_url', val: '' }, rt.ArrayItem{ key: 'author__in', val: '' }, rt.ArrayItem{ key: 'author__not_in', val: '' }, rt.ArrayItem{ key: 'include_unapproved', val: '' }, rt.ArrayItem{ key: 'fields', val: '' }, rt.ArrayItem{ key: 'ID', val: '' }, rt.ArrayItem{ key: 'comment__in', val: '' }, rt.ArrayItem{ key: 'comment__not_in', val: '' }, rt.ArrayItem{ key: 'karma', val: '' }, rt.ArrayItem{ key: 'number', val: '' }, rt.ArrayItem{ key: 'offset', val: '' }, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'orderby', val: '' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'paged', val: 1 }, rt.ArrayItem{ key: 'parent', val: '' }, rt.ArrayItem{ key: 'parent__in', val: '' }, rt.ArrayItem{ key: 'parent__not_in', val: '' }, rt.ArrayItem{ key: 'post_author__in', val: '' }, rt.ArrayItem{ key: 'post_author__not_in', val: '' }, rt.ArrayItem{ key: 'post_ID', val: '' }, rt.ArrayItem{ key: 'post_id', val: 0 }, rt.ArrayItem{ key: 'post__in', val: '' }, rt.ArrayItem{ key: 'post__not_in', val: '' }, rt.ArrayItem{ key: 'post_author', val: '' }, rt.ArrayItem{ key: 'post_name', val: '' }, rt.ArrayItem{ key: 'post_parent', val: '' }, rt.ArrayItem{ key: 'post_status', val: '' }, rt.ArrayItem{ key: 'post_type', val: '' }, rt.ArrayItem{ key: 'status', val: 'all' }, rt.ArrayItem{ key: 'type', val: '' }, rt.ArrayItem{ key: 'type__in', val: '' }, rt.ArrayItem{ key: 'type__not_in', val: '' }, rt.ArrayItem{ key: 'user_id', val: '' }, rt.ArrayItem{ key: 'search', val: '' }, rt.ArrayItem{ key: 'count', val: false }, rt.ArrayItem{ key: 'meta_key', val: '' }, rt.ArrayItem{ key: 'meta_value', val: '' }, rt.ArrayItem{ key: 'meta_query', val: '' }, rt.ArrayItem{ key: 'date_query', val: rt.new_null() }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'cache_domain', val: 'core' }, rt.ArrayItem{ key: 'update_comment_meta_cache', val: true }, rt.ArrayItem{ key: 'update_comment_post_cache', val: false }])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Comment_Query) parse_query(query string) {
	mut query_mutated := query
	if query_mutated == '' {
	query_mutated = (this.query_vars).str()
	}
	this.query_vars = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).clone(), this.query_var_defaults])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_comment_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Comment_Query', []string{}, &this) }])])
}

fn (mut this Class_WP_Comment_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.clone()])
	return rt.new_int(this.get_comments())
}

fn (mut this Class_WP_Comment_Query) get_comments() i64 {
	mut var_wpdb := rt.new_null()
	this.parse_query('')
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [this.query_vars])
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_comments'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Comment_Query', []string{}, &this) }])])
	rt.call_method(this.meta_query, 'parse_query_vars', [this.query_vars])
	if !(!rt.is_true(rt.get_property(this.meta_query, 'queries'))) {
		this.meta_query_clauses = rt.call_method(this.meta_query, 'get_sql', [rt.new_string('comment'), rt.get_property(var_wpdb, 'comments'), rt.new_string('comment_ID'), rt.new_object('WP_Comment_Query', []string{}, &this)])
	}
	mut var_comment_data := rt.new_null()
	var_comment_data = rt.call_function('apply_filters_ref_array', [rt.new_string('comments_pre_query'), rt.create_array([rt.ArrayItem{ key: none, val: var_comment_data }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Comment_Query', []string{}, &this) }])])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_comment_data)))) {
		if var_comment_data.clone().is_array() && rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('count')))))) {
			this.comments = var_comment_data.clone()
		}
		return (var_comment_data).to_i64()
	}
	mut var__args := rt.call_function('wp_array_slice_assoc', [this.query_vars, rt.func_array_keys(this.query_var_defaults)])
	var__args.array_unset(rt.new_string('fields'))
	var__args.array_unset(rt.new_string('update_comment_meta_cache'))
	var__args.array_unset(rt.new_string('update_comment_post_cache'))
	mut var_key := rt.new_string(md5.hexhash(rt.call_function('serialize', [var__args.clone()]).to_string()))
	mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [rt.new_string('comment')])
	mut var_cache_key := rt.new_string("get_comments:${var_key.to_string()}")
	mut var_cache_value := rt.call_function('wp_cache_get_salted', [var_cache_key.clone(), rt.new_string('comment-queries'), var_last_changed.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)) {
		mut var_comment_ids := rt.new_int(this.get_comment_ids())
		if rt.is_true(var_comment_ids) {
			this.set_found_comments()
		}
		var_cache_value = rt.create_array([rt.ArrayItem{ key: 'comment_ids', val: var_comment_ids }, rt.ArrayItem{ key: 'found_comments', val: this.found_comments }])
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), var_cache_value.clone(), rt.new_string('comment-queries'), var_last_changed.clone()])
	} else {
		var_comment_ids = var_cache_value.array_get(rt.new_string('comment_ids'))
		this.found_comments = var_cache_value.array_get(rt.new_string('found_comments'))
	}
	if rt.is_true(this.found_comments) && rt.is_true(this.query_vars.array_get(rt.new_string('number'))) {
		this.max_num_pages = rt.new_int((rt.call_function('ceil', [rt.div(this.found_comments, this.query_vars.array_get(rt.new_string('number')))])).to_i64())
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('count'))) {
		return rt.new_int((var_comment_ids).to_i64())
	}
	var_comment_ids = rt.call_function('array_map', [rt.new_string('intval'), var_comment_ids.clone()])
	if rt.is_true(this.query_vars.array_get(rt.new_string('update_comment_meta_cache'))) {
		rt.call_function('wp_lazyload_comment_meta', [var_comment_ids.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('ids'), this.query_vars.array_get(rt.new_string('fields')))) {
		this.comments = var_comment_ids.clone()
		return (this.comments).to_i64()
	}
	rt.call_function('_prime_comment_caches', [var_comment_ids.clone(), rt.new_bool(false)])
	mut var__comments := rt.new_array()
	mut iter_1 := var_comment_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_comment_id := item_1.val
		mut var__comment := rt.call_function('get_comment', [var_comment_id.clone()])
		if rt.is_true(var__comment) {
			var__comments.array_push(var__comment.clone())
		}
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('update_comment_post_cache'))) {
		mut var_comment_post_ids := rt.new_array()
		mut iter_2 := var__comments.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var__comment := item_2.val
			var_comment_post_ids << rt.get_property(var__comment, 'comment_post_ID')
		}
		rt.call_function('_prime_post_caches', [rt.create_array_from_list(var_comment_post_ids), rt.new_bool(false), rt.new_bool(false)])
	}
	var__comments = rt.call_function('apply_filters_ref_array', [rt.new_string('the_comments'), rt.create_array([rt.ArrayItem{ key: none, val: var__comments }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Comment_Query', []string{}, &this) }])])
	mut var_comments := rt.call_function('array_map', [rt.new_string('get_comment'), var__comments.clone()])
	if rt.is_true(this.query_vars.array_get(rt.new_string('hierarchical'))) {
	var_comments = this.fill_descendants(var_comments.clone())
	}
	this.comments = var_comments.clone()
	return (this.comments).to_i64()
}

fn (mut this Class_WP_Comment_Query) get_comment_ids() i64 {
	mut var_wpdb := rt.new_null()
	mut var_match := []rt.PhpVal{}
	mut var_approved_clauses := rt.new_array()
	mut var_status_clauses := rt.new_array()
	mut var_statuses := rt.call_function('wp_parse_list', [this.query_vars.array_get(rt.new_string('status'))])
	if !rt.is_true(var_statuses) {
	var_statuses = rt.create_array([rt.ArrayItem{ key: none, val: 'all' }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('any'), var_statuses.clone(), rt.new_bool(true)]))))) {
		mut iter_3 := var_statuses.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_status := item_3.val
			mut switch_val_1 := var_status
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('hold'))) {
				var_status_clauses.array_push('comment_approved = \'0\'')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('approve'))) {
				var_status_clauses.array_push('comment_approved = \'1\'')
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('all'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string(''))) {
				var_status_clauses.array_push('( comment_approved = \'0\' OR comment_approved = \'1\' )')
			} else {
				var_status_clauses.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string('comment_approved = %s'), var_status.clone()]))
			}
		}
		var_approved_clauses << '( ' + (rt.call_function('implode', [rt.new_string(' OR '), var_status_clauses.clone()])).str() + ' )'
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('include_unapproved')))) {
		mut var_include_unapproved := rt.call_function('wp_parse_list', [this.query_vars.array_get(rt.new_string('include_unapproved'))])
		mut iter_4 := var_include_unapproved.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_unapproved_identifier := item_4.val
			if rt.is_true(rt.new_bool(var_unapproved_identifier.clone().is_long() || var_unapproved_identifier.clone().is_double())) {
				var_approved_clauses << rt.call_method(var_wpdb, 'prepare', [rt.new_string('( user_id = %d AND comment_approved = \'0\' )'), var_unapproved_identifier.clone()])
			} else {
				if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('unapproved')))) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('moderation-hash')))) {
					var_approved_clauses << rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('( comment_author_email = %s AND comment_approved = \'0\' AND '), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_ID = %d )')), var_unapproved_identifier.clone(), rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('unapproved'))).to_i64())])
				} else {
					var_approved_clauses << rt.call_method(var_wpdb, 'prepare', [rt.new_string('( comment_author_email = %s AND comment_approved = \'0\' )'), var_unapproved_identifier.clone()])
				}
			}
		}
	}
	if !(!rt.is_true(var_approved_clauses)) {
		if 1 == var_approved_clauses.len {
			this.sql_clauses.array_get_mut('where').array_set('approved', var_approved_clauses[0])
		} else {
			this.sql_clauses.array_get_mut('where').array_set('approved', '( ' + (rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_approved_clauses)])).str() + ' )')
		}
	}
	mut var_order := rt.new_string((if rt.is_true(rt.identical(rt.new_string('ASC'), rt.new_string(this.query_vars.array_get(rt.new_string('order')).to_string().to_upper()))) { 'ASC' } else { 'DESC' }).str())
	if rt.is_true(rt.call_function('in_array', [this.query_vars.array_get(rt.new_string('orderby')), rt.create_array([rt.ArrayItem{ key: none, val: 'none' }, rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: false }]), rt.new_bool(true)])) {
	mut var_orderby := rt.new_string('')
	} else if !(!rt.is_true(this.query_vars.array_get(rt.new_string('orderby')))) {
		mut var_ordersby := if this.query_vars.array_get(rt.new_string('orderby')).is_array() { this.query_vars.array_get(rt.new_string('orderby')) } else { rt.call_function('preg_split', [rt.new_string('/[,\\s]/'), this.query_vars.array_get(rt.new_string('orderby'))]) }
		mut var_orderby_array := rt.new_array()
		mut var_found_orderby_comment_id := rt.new_bool(false)
		mut iter_5 := var_ordersby.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var__value := item_5.val
			mut var__key := item_5.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var__value)))) {
				continue
			}
			if rt.is_true(rt.new_bool(var__key.clone().is_long())) {
			mut var__orderby := var__value
			mut var__order := var_order.clone()
			} else {
			var__orderby = var__key
			var__order = var__value
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found_orderby_comment_id)))) && rt.is_true(rt.call_function('in_array', [var__orderby.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'comment_ID' }, rt.ArrayItem{ key: none, val: 'comment__in' }]), rt.new_bool(true)])) {
			var_found_orderby_comment_id = rt.new_bool(true)
			}
			mut var_parsed := this.parse_orderby(var__orderby.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('comment__in'), var__orderby)) {
				var_orderby_array << var_parsed.clone()
				continue
			}
			var_orderby_array << (var_parsed).str() + ' ' + this.parse_order(var__order.clone())
		}
		if !rt.is_true(var_orderby_array) {
			var_orderby_array << rt.concat(rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_date_gmt ')), var_order)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found_orderby_comment_id)))) {
			mut var_comment_id_order := rt.new_string('')
			for var_orderby_clause in var_orderby_array {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/comment_date(?:_gmt)*\\ (ASC|DESC)/'), var_orderby_clause.clone(), rt.create_array_from_list(var_match)])) {
					var_comment_id_order = var_match.array_get(rt.new_int(1))
					break
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id_order)))) {
				for var_orderby_clause in var_orderby_array {
					if rt.is_true(rt.call_function('str_contains', [rt.new_string('ASC'), var_orderby_clause.clone()])) {
					var_comment_id_order = rt.new_string('ASC')
					} else {
					var_comment_id_order = rt.new_string('DESC')
					}
					break
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id_order)))) {
			var_comment_id_order = rt.new_string('DESC')
			}
			var_orderby_array << rt.concat(rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_ID ')), var_comment_id_order)
		}
	var_orderby = rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_orderby_array)])
	} else {
	var_orderby = rt.new_string((rt.concat(rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_date_gmt ')), var_order)).str())
	}
	mut var_number := rt.call_function('absint', [this.query_vars.array_get(rt.new_string('number'))])
	mut var_offset := rt.call_function('absint', [this.query_vars.array_get(rt.new_string('offset'))])
	mut var_paged := rt.call_function('absint', [this.query_vars.array_get(rt.new_string('paged'))])
	mut var_limits := rt.new_string('')
	if !(!rt.is_true(var_number)) {
		if rt.is_true(var_offset) {
		var_limits = rt.new_string('LIMIT ' + (var_offset).str() + ',' + (var_number).str())
		} else {
		var_limits = rt.new_string('LIMIT ' + (rt.mul(var_number, rt.sub(var_paged, rt.new_int(1)))).str() + ',' + (var_number).str())
		}
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('count'))) {
	mut var_fields := rt.new_string('COUNT(*)')
	} else {
	var_fields = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_ID'))).str())
	}
	mut var_post_id := rt.call_function('absint', [this.query_vars.array_get(rt.new_string('post_id'))])
	if !(!rt.is_true(var_post_id)) {
		this.sql_clauses.array_get_mut('where').array_set('post_id', rt.call_method(var_wpdb, 'prepare', [rt.new_string('comment_post_ID = %d'), var_post_id.clone()]))
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('comment__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('comment__in', rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_ID IN ( ')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('comment__in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('comment__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('comment__not_in', rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_ID NOT IN ( ')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('comment__not_in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('parent__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('parent__in', 'comment_parent IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('parent__in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('parent__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('parent__not_in', 'comment_parent NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('parent__not_in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('post__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('post__in', 'comment_post_ID IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('post__in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('post__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('post__not_in', 'comment_post_ID NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('post__not_in'))])])).str() + ' )')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.query_vars.array_get(rt.new_string('author_email')))))) {
		this.sql_clauses.array_get_mut('where').array_set('author_email', rt.call_method(var_wpdb, 'prepare', [rt.new_string('comment_author_email = %s'), this.query_vars.array_get(rt.new_string('author_email'))]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.query_vars.array_get(rt.new_string('author_url')))))) {
		this.sql_clauses.array_get_mut('where').array_set('author_url', rt.call_method(var_wpdb, 'prepare', [rt.new_string('comment_author_url = %s'), this.query_vars.array_get(rt.new_string('author_url'))]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.query_vars.array_get(rt.new_string('karma')))))) {
		this.sql_clauses.array_get_mut('where').array_set('karma', rt.call_method(var_wpdb, 'prepare', [rt.new_string('comment_karma = %d'), this.query_vars.array_get(rt.new_string('karma'))]))
	}
	mut var_raw_types := { 'IN': rt.call_function('array_merge', [rt.cast_array(this.query_vars.array_get(rt.new_string('type'))), rt.cast_array(this.query_vars.array_get(rt.new_string('type__in')))]), 'NOT IN': rt.cast_array(this.query_vars.array_get(rt.new_string('type__not_in'))) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('all'), var_raw_types['IN'], rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('note'), var_raw_types['IN'], rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('note'), var_raw_types['NOT IN'], rt.new_bool(true)]))))) {
		var_raw_types.array_get_mut('NOT IN').array_push('note')
	}
	mut var_comment_types := rt.new_array()
	for var_operator, var__raw_types in var_raw_types {
		var__raw_types = rt.call_function('array_unique', [var__raw_types.clone()])
		mut iter_6 := var__raw_types.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_type := item_6.val
			mut switch_val_2 := var_type
			if rt.is_true(rt.equal(switch_val_2, rt.new_string(''))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('all'))) {
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('comment'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('comments'))) {
				var_comment_types.array_get_mut(operator).array_push('\'\'')
				var_comment_types.array_get_mut(operator).array_push('\'comment\'')
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('pings'))) {
				var_comment_types.array_get_mut(operator).array_push('\'pingback\'')
				var_comment_types.array_get_mut(operator).array_push('\'trackback\'')
			} else {
				var_comment_types.array_get_mut(operator).array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'), var_type.clone()]))
			}
		}
		if !(!rt.is_true(var_comment_types.array_get(rt.new_string(operator)))) {
			mut var_types_sql := rt.call_function('implode', [rt.new_string(', '), var_comment_types.array_get(rt.new_string(operator))])
			this.sql_clauses.array_get_mut('where').array_set('comment_type__' + rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('_'), rt.new_string(operator)]).to_string().to_lower(), "comment_type ${var_operator} (${var_types_sql.to_string()})")
		}
	}
	mut var_parent := this.query_vars.array_get(rt.new_string('parent'))
	if rt.is_true(this.query_vars.array_get(rt.new_string('hierarchical'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
	var_parent = rt.new_int(0)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_parent)))) {
		this.sql_clauses.array_get_mut('where').array_set('parent', rt.call_method(var_wpdb, 'prepare', [rt.new_string('comment_parent = %d'), var_parent.clone()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('user_id')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('user_id', 'user_id IN (' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), this.query_vars.array_get(rt.new_string('user_id'))])])).str() + ')')
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.query_vars.array_get(rt.new_string('user_id')))))) {
		this.sql_clauses.array_get_mut('where').array_set('user_id', rt.call_method(var_wpdb, 'prepare', [rt.new_string('user_id = %d'), this.query_vars.array_get(rt.new_string('user_id'))]))
	}
	if this.query_vars.array_isset(rt.new_string('search')) && rt.is_true(rt.new_int(this.query_vars.array_get(rt.new_string('search')).to_string().len)) {
		mut var_search_sql := rt.new_string(this.get_search_sql(this.query_vars.array_get(rt.new_string('search')), rt.create_array([rt.ArrayItem{ key: none, val: 'comment_author' }, rt.ArrayItem{ key: none, val: 'comment_author_email' }, rt.ArrayItem{ key: none, val: 'comment_author_url' }, rt.ArrayItem{ key: none, val: 'comment_author_IP' }, rt.ArrayItem{ key: none, val: 'comment_content' }])))
		this.sql_clauses.array_get_mut('where').array_set('search', rt.call_function('preg_replace', [rt.new_string('/^\\s*AND\\s*/'), rt.new_string(''), var_search_sql.clone()]))
	}
	mut var_join_posts_table := rt.new_bool(false)
	mut var_plucked := rt.call_function('wp_array_slice_assoc', [this.query_vars, rt.create_array([rt.ArrayItem{ key: none, val: 'post_author' }, rt.ArrayItem{ key: none, val: 'post_name' }, rt.ArrayItem{ key: none, val: 'post_parent' }])])
	mut var_post_fields := rt.call_function('array_filter', [var_plucked.clone()])
	if !(!rt.is_true(var_post_fields)) {
		var_join_posts_table = rt.new_bool(true)
		mut iter_7 := var_post_fields.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_field_value := item_7.val
			mut var_field_name := item_7.key
			mut var_esses := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(rt.cast_array(var_field_value).array_count()), rt.new_string('%s')])
			this.sql_clauses.array_get_mut('where').array_set(var_field_name, rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.')), var_field_name), rt.new_string(' IN (')) + (rt.call_function('implode', [rt.new_string(','), var_esses.clone()])).str() + ')').str()), var_field_value.clone()]))
		}
	}
	mut iter_8 := rt.create_array([rt.ArrayItem{ key: none, val: 'post_status' }, rt.ArrayItem{ key: none, val: 'post_type' }]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_field_name := item_8.val
		mut var_q_values := rt.new_array()
		if !(!rt.is_true(this.query_vars.array_get(var_field_name))) {
			var_q_values = this.query_vars.array_get(var_field_name)
			if !(var_q_values.clone().is_array()) {
			var_q_values = rt.call_function('explode', [rt.new_string(','), var_q_values.clone()])
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string('any'), var_q_values.clone(), rt.new_bool(true)])) || !rt.is_true(var_q_values) {
				continue
			}
			var_join_posts_table = rt.new_bool(true)
			mut var_esses := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_q_values.clone().array_count()), rt.new_string('%s')])
			this.sql_clauses.array_get_mut('where').array_set(var_field_name, rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.')), var_field_name), rt.new_string(' IN (')) + (rt.call_function('implode', [rt.new_string(','), var_esses.clone()])).str() + ')').str()), var_q_values.clone()]))
		}
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('author__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('author__in', 'user_id IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('author__in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('author__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('author__not_in', 'user_id NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('author__not_in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('post_author__in')))) {
		var_join_posts_table = rt.new_bool(true)
		this.sql_clauses.array_get_mut('where').array_set('post_author__in', 'post_author IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('post_author__in'))])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('post_author__not_in')))) {
		var_join_posts_table = rt.new_bool(true)
		this.sql_clauses.array_get_mut('where').array_set('post_author__not_in', 'post_author NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('post_author__not_in'))])])).str() + ' )')
	}
	mut var_join := rt.new_string('')
	mut var_groupby := rt.new_string('')
	if rt.is_true(var_join_posts_table) {
		var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_post_ID')))
	}
	if !(!rt.is_true(this.meta_query_clauses)) {
		var_join = rt.concat(var_join, this.meta_query_clauses.array_get(rt.new_string('join')))
		this.sql_clauses.array_get_mut('where').array_set('meta_query', rt.call_function('preg_replace', [rt.new_string('/^\\s*AND\\s*/'), rt.new_string(''), this.meta_query_clauses.array_get(rt.new_string('where'))]))
		if rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('count')))))) {
		var_groupby = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_ID'))).str())
		}
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('date_query')))) && this.query_vars.array_get(rt.new_string('date_query')).is_array() {
		this.date_query = create_wp_date_query(this.query_vars.array_get(rt.new_string('date_query')), rt.new_string('comment_date'))
		this.sql_clauses.array_get_mut('where').array_set('date_query', rt.call_function('preg_replace', [rt.new_string('/^\\s*AND\\s*/'), rt.new_string(''), rt.call_method(this.date_query, 'get_sql', []rt.PhpVal{})]))
	}
	mut var_where := rt.call_function('implode', [rt.new_string(' AND '), this.sql_clauses.array_get(rt.new_string('where'))])
	mut var_pieces := ['fields', 'join', 'where', 'orderby', 'limits', 'groupby']
	mut var_clauses := rt.call_function('apply_filters_ref_array', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('compact', [rt.create_array_from_list(var_pieces)]) }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Comment_Query', []string{}, &this) }])])
	var_fields = if !(var_clauses.array_get(rt.new_string('fields'))).is_null() { var_clauses.array_get(rt.new_string('fields')) } else { rt.new_string('') }
	var_join = if !(var_clauses.array_get(rt.new_string('join'))).is_null() { var_clauses.array_get(rt.new_string('join')) } else { rt.new_string('') }
	var_where = if !(var_clauses.array_get(rt.new_string('where'))).is_null() { var_clauses.array_get(rt.new_string('where')) } else { rt.new_string('') }
	var_orderby = if !(var_clauses.array_get(rt.new_string('orderby'))).is_null() { var_clauses.array_get(rt.new_string('orderby')) } else { rt.new_string('') }
	var_limits = if !(var_clauses.array_get(rt.new_string('limits'))).is_null() { var_clauses.array_get(rt.new_string('limits')) } else { rt.new_string('') }
	var_groupby = if !(var_clauses.array_get(rt.new_string('groupby'))).is_null() { var_clauses.array_get(rt.new_string('groupby')) } else { rt.new_string('') }
	this.filtered_where_clause = var_where.clone()
	if rt.is_true(var_where) {
	var_where = rt.new_string('WHERE ' + (var_where).str())
	}
	if rt.is_true(var_groupby) {
	var_groupby = rt.new_string('GROUP BY ' + (var_groupby).str())
	}
	if rt.is_true(var_orderby) {
	var_orderby = rt.new_string("ORDER BY ${var_orderby.to_string()}")
	}
	mut var_found_rows := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('no_found_rows')))))) {
	var_found_rows = rt.new_string('SQL_CALC_FOUND_ROWS')
	}
	this.sql_clauses.array_set('select', "SELECT ${var_found_rows.to_string()} ${var_fields.to_string()}")
	this.sql_clauses.array_set('from', rt.concat(rt.concat(rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ')), var_join))
	this.sql_clauses.array_set('groupby', var_groupby.clone())
	this.sql_clauses.array_set('orderby', var_orderby.clone())
	this.sql_clauses.array_set('limits', var_limits.clone())
	this.request = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.sql_clauses.array_get(rt.new_string('select')), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get(rt.new_string('from'))), rt.new_string('\n\t\t\t ')), var_where), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get(rt.new_string('groupby'))), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get(rt.new_string('orderby'))), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get(rt.new_string('limits')))
	if rt.is_true(this.query_vars.array_get(rt.new_string('count'))) {
		return rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.new_string(this.request)])).to_i64())
	} else {
		mut var_comment_ids := rt.call_method(var_wpdb, 'get_col', [rt.new_string(this.request)])
		return (rt.call_function('array_map', [rt.new_string('intval'), var_comment_ids.clone()])).to_i64()
	}
	return i64(0)
}

fn (mut this Class_WP_Comment_Query) set_found_comments() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(this.query_vars.array_get(rt.new_string('number'))) && rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('no_found_rows')))))) {
		mut var_found_comments_query := rt.call_function('apply_filters', [rt.new_string('found_comments_query'), rt.new_string('SELECT FOUND_ROWS()'), rt.new_object('WP_Comment_Query', []string{}, &this)])
		this.found_comments = rt.new_int((rt.call_method(var_wpdb, 'get_var', [var_found_comments_query.clone()])).to_i64())
	}
}

fn (mut this Class_WP_Comment_Query) fill_descendants(var_comments rt.PhpVal) rt.PhpVal {
	mut var_comments_mutated := var_comments
	mut var_levels := rt.create_array([rt.ArrayItem{ key: 0, val: rt.call_function('wp_list_pluck', [var_comments_mutated.clone(), rt.new_string('comment_ID')]) }])
	mut var_key := rt.new_string(md5.hexhash(rt.call_function('serialize', [rt.call_function('wp_array_slice_assoc', [this.query_vars, rt.func_array_keys(this.query_var_defaults)])]).to_string()))
	mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [rt.new_string('comment')])
	mut var_level := rt.new_int(0)
	mut var_exclude_keys := ['parent', 'parent__in', 'parent__not_in']
	for {
		mut var_child_ids := rt.new_array()
		mut var_uncached_parent_ids := rt.new_array()
		mut var__parent_ids := var_levels.array_get(var_level)
		if rt.is_true(var__parent_ids) {
			mut var_cache_keys := rt.new_array()
			mut iter_9 := var__parent_ids.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_parent_id := item_9.val
				var_cache_keys.array_set(var_parent_id, "get_comment_child_ids:${var_parent_id.to_string()}:${var_key.to_string()}")
			}
			mut var_cache_data := rt.call_function('wp_cache_get_multiple_salted', [rt.call_function('array_values', [var_cache_keys.clone()]), rt.new_string('comment-queries'), var_last_changed.clone()])
			mut iter_10 := var__parent_ids.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_parent_id := item_10.val
				mut var_parent_child_ids := var_cache_data.array_get(var_cache_keys.array_get(var_parent_id))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_parent_child_ids)))) {
				var_child_ids = rt.call_function('array_merge', [var_child_ids.clone(), var_parent_child_ids.clone()])
				} else {
					var_uncached_parent_ids << var_parent_id.clone()
				}
			}
		}
		if rt.is_true(var_uncached_parent_ids) {
			mut var_parent_query_args := this.query_vars
			for var_exclude_key in var_exclude_keys {
				var_parent_query_args.array_set(exclude_key, '')
			}
			var_parent_query_args.array_set('parent__in', var_uncached_parent_ids.clone())
			var_parent_query_args.array_set('no_found_rows', true)
			var_parent_query_args.array_set('hierarchical', false)
			var_parent_query_args.array_set('offset', 0)
			var_parent_query_args.array_set('number', 0)
			mut var_level_comments := rt.call_function('get_comments', [var_parent_query_args.clone()])
			mut var_parent_map := rt.call_function('array_fill_keys', [rt.create_array_from_list(var_uncached_parent_ids), rt.new_array()])
			mut iter_11 := var_level_comments.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_level_comment := item_11.val
				var_parent_map.array_get_mut(rt.get_property(var_level_comment, 'comment_parent')).array_push(rt.get_property(var_level_comment, 'comment_ID'))
				var_child_ids.array_push(rt.get_property(var_level_comment, 'comment_ID'))
			}
			mut var_data := rt.new_array()
			mut iter_12 := var_parent_map.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_children := item_12.val
				mut var_parent_id := item_12.key
				mut var_cache_key := rt.new_string("get_comment_child_ids:${var_parent_id.to_string()}:${var_key.to_string()}")
				var_data.array_set(var_cache_key, var_children.clone())
			}
			rt.call_function('wp_cache_set_multiple_salted', [var_data.clone(), rt.new_string('comment-queries'), var_last_changed.clone()])
		}
		rt.pre_inc(var_level)
		var_levels.array_set(var_level, var_child_ids.clone())
		if !(rt.is_true(var_child_ids)) {
			break
		}
	}
	mut var_descendant_ids := rt.new_array()
	mut var_i := rt.new_int(1)
	mut var_c := rt.new_int(var_levels.clone().array_count())
	for {
		if !(rt.is_true(rt.less(var_i, var_c))) { break }
		var_descendant_ids = rt.call_function('array_merge', [var_descendant_ids.clone(), var_levels.array_get(var_i)])
		rt.post_inc(var_i)
	}
	rt.call_function('_prime_comment_caches', [var_descendant_ids.clone(), this.query_vars.array_get(rt.new_string('update_comment_meta_cache'))])
	mut var_all_comments := var_comments_mutated.clone()
	mut iter_13 := var_descendant_ids.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_descendant_id := item_13.val
		var_all_comments.array_push(rt.call_function('get_comment', [var_descendant_id.clone()]))
	}
	if rt.is_true(rt.identical(rt.new_string('threaded'), this.query_vars.array_get(rt.new_string('hierarchical')))) {
		mut var_threaded_comments := rt.new_array()
		mut var_ref := rt.new_array()
		mut iter_14 := var_all_comments.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_c := item_14.val
			mut var_k := item_14.key
			mut var__c := rt.call_function('get_comment', [rt.get_property(var_c, 'comment_ID')])
			if !(var_ref.array_isset(rt.get_property(var_c, 'comment_parent'))) {
				var_threaded_comments.array_set(rt.get_property(var__c, 'comment_ID'), var__c.clone())
				var_ref.array_set(rt.get_property(var__c, 'comment_ID'), var_threaded_comments.array_get(rt.get_property(var__c, 'comment_ID')))
			} else {
				rt.call_method(var_ref.array_get(rt.get_property(var__c, 'comment_parent')), 'add_child', [var__c.clone()])
				var_ref.array_set(rt.get_property(var__c, 'comment_ID'), rt.call_method(var_ref.array_get(rt.get_property(var__c, 'comment_parent')), 'get_child', [rt.get_property(var__c, 'comment_ID')]))
			}
		}
		mut iter_15 := var_ref.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var__ref := item_15.val
			rt.call_method(var__ref, 'populated_children', [rt.new_bool(true)])
		}
	mut var_comments_mutated := var_threaded_comments.clone()
	} else {
	var_comments_mutated = var_all_comments.clone()
	}
	return var_comments_mutated.clone()
}

fn (mut this Class_WP_Comment_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_like := rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_search.clone()])).str() + '%')
	mut var_searches := rt.new_array()
	mut iter_16 := var_columns.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_column := item_16.val
		var_searches << rt.call_method(var_wpdb, 'prepare', [rt.new_string("${var_column.to_string()} LIKE %s"), var_like.clone()])
	}
	return ' AND (' + (rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_searches)])).str() + ')'
}

fn (mut this Class_WP_Comment_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_orderby_mutated := var_orderby
	mut var_allowed_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'comment_agent' }, rt.ArrayItem{ key: none, val: 'comment_approved' }, rt.ArrayItem{ key: none, val: 'comment_author' }, rt.ArrayItem{ key: none, val: 'comment_author_email' }, rt.ArrayItem{ key: none, val: 'comment_author_IP' }, rt.ArrayItem{ key: none, val: 'comment_author_url' }, rt.ArrayItem{ key: none, val: 'comment_content' }, rt.ArrayItem{ key: none, val: 'comment_date' }, rt.ArrayItem{ key: none, val: 'comment_date_gmt' }, rt.ArrayItem{ key: none, val: 'comment_ID' }, rt.ArrayItem{ key: none, val: 'comment_karma' }, rt.ArrayItem{ key: none, val: 'comment_parent' }, rt.ArrayItem{ key: none, val: 'comment_post_ID' }, rt.ArrayItem{ key: none, val: 'comment_type' }, rt.ArrayItem{ key: none, val: 'user_id' }])
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('meta_key')))) {
		var_allowed_keys.array_push(this.query_vars.array_get(rt.new_string('meta_key')))
		var_allowed_keys.array_push('meta_value')
		var_allowed_keys.array_push('meta_value_num')
	}
	mut var_meta_query_clauses := rt.call_method(this.meta_query, 'get_clauses', []rt.PhpVal{})
	if rt.is_true(var_meta_query_clauses) {
	var_allowed_keys = rt.call_function('array_merge', [var_allowed_keys.clone(), rt.func_array_keys(var_meta_query_clauses.clone())])
	}
	mut var_parsed := rt.new_bool(false)
	if rt.is_true(rt.identical(this.query_vars.array_get(rt.new_string('meta_key')), var_orderby_mutated)) || rt.is_true(rt.identical(rt.new_string('meta_value'), var_orderby_mutated)) {
	var_parsed = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'commentmeta'), rt.new_string('.meta_value'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('meta_value_num'), var_orderby_mutated)) {
	var_parsed = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'commentmeta'), rt.new_string('.meta_value+0'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('comment__in'), var_orderby_mutated)) {
	mut var_comment__in := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), this.query_vars.array_get(rt.new_string('comment__in'))])])
	var_parsed = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('FIELD( '), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_ID, ')), var_comment__in), rt.new_string(' )'))).str())
	} else if rt.is_true(rt.call_function('in_array', [var_orderby_mutated.clone(), var_allowed_keys.clone(), rt.new_bool(true)])) {
		if var_meta_query_clauses.array_isset(var_orderby_mutated) {
		mut var_meta_clause := var_meta_query_clauses.array_get(var_orderby_mutated)
		var_parsed = rt.call_function('sprintf', [rt.new_string('CAST(%s.meta_value AS %s)'), rt.call_function('esc_sql', [var_meta_clause.array_get(rt.new_string('alias'))]), rt.call_function('esc_sql', [var_meta_clause.array_get(rt.new_string('cast'))])])
		} else {
		var_parsed = rt.new_string((rt.concat(rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.')), var_orderby_mutated)).str())
		}
	}
	return var_parsed.clone()
}

fn (mut this Class_WP_Comment_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	if !(var_order_mutated.clone().is_string()) || !rt.is_true(var_order_mutated) {
		return 'DESC'
	}
	if rt.is_true(rt.identical(rt.new_string('ASC'), rt.new_string(var_order_mutated.clone().to_string().to_upper()))) {
		return 'ASC'
	} else {
		return 'DESC'
	}
	return ''
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_WP_Date_Query {
	rt.PhpObjectBase
}

fn create_wp_comment_query(query string) &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		request: ''
		meta_query: rt.new_bool(false)
		meta_query_clauses: rt.new_null()
		sql_clauses: rt.new_array()
		filtered_where_clause: rt.new_null()
		date_query: rt.new_bool(false)
		query_vars: rt.new_null()
		query_var_defaults: rt.new_null()
		comments: rt.new_null()
		found_comments: rt.new_int(0)
		max_num_pages: rt.new_int(0)
	}
	obj.construct(query)
	return obj
}

fn create_wp_meta_query(_args ...rt.PhpVal) &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_date_query(_args ...rt.PhpVal) &Class_WP_Date_Query {
	mut obj := &Class_WP_Date_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parse_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.parse_query(dispatch_arg_0)
			return rt.new_null()
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query(dispatch_arg_0)
		}
		'get_comments' {
			return rt.new_int(this.get_comments())
		}
		'get_comment_ids' {
			return rt.new_int(this.get_comment_ids())
		}
		'set_found_comments' {
			this.set_found_comments()
			return rt.new_null()
		}
		'fill_descendants' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fill_descendants(dispatch_arg_0)
		}
		'get_search_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_search_sql(dispatch_arg_0, dispatch_arg_1))
		}
		'parse_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_orderby(dispatch_arg_0)
		}
		'parse_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parse_order(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request' { return rt.new_string(this.request) }
		'meta_query' { return this.meta_query }
		'meta_query_clauses' { return this.meta_query_clauses }
		'sql_clauses' { return this.sql_clauses }
		'filtered_where_clause' { return this.filtered_where_clause }
		'date_query' { return this.date_query }
		'query_vars' { return this.query_vars }
		'query_var_defaults' { return this.query_var_defaults }
		'comments' { return this.comments }
		'found_comments' { return this.found_comments }
		'max_num_pages' { return this.max_num_pages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'request' { this.request = (val).str(); return true }
		'meta_query' { this.meta_query = val; return true }
		'meta_query_clauses' { this.meta_query_clauses = val; return true }
		'sql_clauses' { this.sql_clauses = val; return true }
		'filtered_where_clause' { this.filtered_where_clause = val; return true }
		'date_query' { this.date_query = val; return true }
		'query_vars' { this.query_vars = val; return true }
		'query_var_defaults' { this.query_var_defaults = val; return true }
		'comments' { this.comments = val; return true }
		'found_comments' { this.found_comments = val; return true }
		'max_num_pages' { this.max_num_pages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Meta_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Meta_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Meta_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Date_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Date_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Date_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
