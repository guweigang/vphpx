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
		return this.get_search_sql(var_arguments.dup(), rt.new_null())
	}
	return false
}

fn (mut this Class_WP_Comment_Query) construct(query string)  {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([rt.ArrayItem{ key: 'author_email', val: '' }, rt.ArrayItem{ key: 'author_url', val: '' }, rt.ArrayItem{ key: 'author__in', val: '' }, rt.ArrayItem{ key: 'author__not_in', val: '' }, rt.ArrayItem{ key: 'include_unapproved', val: '' }, rt.ArrayItem{ key: 'fields', val: '' }, rt.ArrayItem{ key: 'ID', val: '' }, rt.ArrayItem{ key: 'comment__in', val: '' }, rt.ArrayItem{ key: 'comment__not_in', val: '' }, rt.ArrayItem{ key: 'karma', val: '' }, rt.ArrayItem{ key: 'number', val: '' }, rt.ArrayItem{ key: 'offset', val: '' }, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'orderby', val: '' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'paged', val: 1 }, rt.ArrayItem{ key: 'parent', val: '' }, rt.ArrayItem{ key: 'parent__in', val: '' }, rt.ArrayItem{ key: 'parent__not_in', val: '' }, rt.ArrayItem{ key: 'post_author__in', val: '' }, rt.ArrayItem{ key: 'post_author__not_in', val: '' }, rt.ArrayItem{ key: 'post_ID', val: '' }, rt.ArrayItem{ key: 'post_id', val: 0 }, rt.ArrayItem{ key: 'post__in', val: '' }, rt.ArrayItem{ key: 'post__not_in', val: '' }, rt.ArrayItem{ key: 'post_author', val: '' }, rt.ArrayItem{ key: 'post_name', val: '' }, rt.ArrayItem{ key: 'post_parent', val: '' }, rt.ArrayItem{ key: 'post_status', val: '' }, rt.ArrayItem{ key: 'post_type', val: '' }, rt.ArrayItem{ key: 'status', val: 'all' }, rt.ArrayItem{ key: 'type', val: '' }, rt.ArrayItem{ key: 'type__in', val: '' }, rt.ArrayItem{ key: 'type__not_in', val: '' }, rt.ArrayItem{ key: 'user_id', val: '' }, rt.ArrayItem{ key: 'search', val: '' }, rt.ArrayItem{ key: 'count', val: false }, rt.ArrayItem{ key: 'meta_key', val: '' }, rt.ArrayItem{ key: 'meta_value', val: '' }, rt.ArrayItem{ key: 'meta_query', val: '' }, rt.ArrayItem{ key: 'date_query', val: rt.new_null() }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'cache_domain', val: 'core' }, rt.ArrayItem{ key: 'update_comment_meta_cache', val: true }, rt.ArrayItem{ key: 'update_comment_post_cache', val: false }])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Comment_Query) parse_query(query string)  {
	mut query_mutated := query
	if query_mutated == '' {
		query_mutated = (this.query_vars).str()
	}
	this.query_vars = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).dup(), this.query_var_defaults])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_comment_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Comment_Query', []string{}, &this) }])])
}

fn (mut this Class_WP_Comment_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.dup()])
	return this.get_comments()
}

fn (mut this Class_WP_Comment_Query) get_comments() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
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
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_comment_data.dup().is_array())) && rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get('count'))))))) {
			this.comments = var_comment_data.dup()
		}
		return var_comment_data.dup()
	}
	mut var__args := rt.call_function('wp_array_slice_assoc', [this.query_vars, rt.func_array_keys(this.query_var_defaults)])
	var__args.array_unset(rt.new_string('fields'))
	var__args.array_unset(rt.new_string('update_comment_meta_cache'))
	var__args.array_unset(rt.new_string('update_comment_post_cache'))
	mut var_key := rt.new_string(rt.new_string(md5.hexhash(rt.call_function('serialize', [var__args.dup()]).to_string())))
	mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [rt.new_string('comment')])
	mut var_cache_key := rt.new_string(rt.new_string("get_comments:${var_key.to_string()}"))
	mut var_cache_value := rt.call_function('wp_cache_get_salted', [var_cache_key.dup(), rt.new_string('comment-queries'), var_last_changed.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)) {
		mut var_comment_ids := this.get_comment_ids()
		if rt.is_true(var_comment_ids) {
			this.set_found_comments()
		}
		var_cache_value = rt.create_array([rt.ArrayItem{ key: 'comment_ids', val: var_comment_ids }, rt.ArrayItem{ key: 'found_comments', val: this.found_comments }])
		rt.call_function('wp_cache_set_salted', [var_cache_key.dup(), var_cache_value.dup(), rt.new_string('comment-queries'), var_last_changed.dup()])
	} else {
		var_comment_ids = var_cache_value.array_get('comment_ids')
		this.found_comments = var_cache_value.array_get('found_comments')
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.found_comments) && rt.is_true(this.query_vars.array_get('number')))) {
		this.max_num_pages = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(this.query_vars.array_get('count')) {
		return // unsupported expression: Expr_Cast_Int
	}
	var_comment_ids = rt.call_function('array_map', [rt.new_string('intval'), var_comment_ids.dup()])
	if rt.is_true(this.query_vars.array_get('update_comment_meta_cache')) {
		rt.call_function('wp_lazyload_comment_meta', [var_comment_ids.dup()])
	}
	if rt.is_true(rt.identical(rt.new_string('ids'), this.query_vars.array_get('fields'))) {
		this.comments = var_comment_ids.dup()
		return this.comments
	}
	rt.call_function('_prime_comment_caches', [var_comment_ids.dup(), rt.new_bool(false)])
	mut var__comments := rt.new_array()
	{
		mut iter_1 := var_comment_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment_id := item_1.val
			mut var__comment := rt.call_function('get_comment', [var_comment_id.dup()])
			if rt.is_true(var__comment) {
				var__comments.array_push(var__comment.dup())
			}
		}
	}
	if rt.is_true(this.query_vars.array_get('update_comment_post_cache')) {
		mut var_comment_post_ids := rt.new_array()
		{
			mut iter_1 := var__comments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__comment := item_1.val
				var_comment_post_ids << rt.get_property(var__comment, 'comment_post_ID')
			}
		}
		rt.call_function('_prime_post_caches', [var_comment_post_ids.dup(), rt.new_bool(false), rt.new_bool(false)])
	}
	var__comments = rt.call_function('apply_filters_ref_array', [rt.new_string('the_comments'), rt.create_array([rt.ArrayItem{ key: none, val: var__comments }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Comment_Query', []string{}, &this) }])])
	mut var_comments := rt.call_function('array_map', [rt.new_string('get_comment'), var__comments.dup()])
	if rt.is_true(this.query_vars.array_get('hierarchical')) {
		var_comments = this.fill_descendants(var_comments.dup())
	}
	this.comments = var_comments.dup()
	return this.comments
}

fn (mut this Class_WP_Comment_Query) get_comment_ids() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_match := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	mut var_approved_clauses := rt.new_array()
	mut var_status_clauses := rt.new_array()
	mut var_statuses := rt.call_function('wp_parse_list', [this.query_vars.array_get('status')])
	if !rt.is_true(var_statuses) {
		var_statuses = rt.create_array([rt.ArrayItem{ key: none, val: 'all' }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('any'), var_statuses.dup(), rt.new_bool(true)]))))) {
		{
			mut iter_1 := var_statuses.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_status := item_1.val
				mut switch_val_1 := var_status
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('hold'))) {
					var_status_clauses.array_push('comment_approved = \'0\'')
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('approve'))) {
					var_status_clauses.array_push('comment_approved = \'1\'')
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('all'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string(''))) {
					var_status_clauses.array_push('( comment_approved = \'0\' OR comment_approved = \'1\' )')
				} else {
					var_status_clauses.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string('comment_approved = %s'), var_status.dup()]))
				}
			}
		}
		var_approved_clauses << '( ' + (rt.call_function('implode', [rt.new_string(' OR '), var_status_clauses.dup()])).str() + ' )'
	}
	if !(!rt.is_true(this.query_vars.array_get('include_unapproved'))) {
		mut var_include_unapproved := rt.call_function('wp_parse_list', [this.query_vars.array_get('include_unapproved')])
		{
			mut iter_1 := var_include_unapproved.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_unapproved_identifier := item_1.val
				if rt.is_true(rt.new_bool(var_unapproved_identifier.dup().is_long() || var_unapproved_identifier.dup().is_double())) {
					var_approved_clauses << rt.call_method(var_wpdb, 'prepare', [rt.new_string('( user_id = %d AND comment_approved = \'0\' )'), var_unapproved_identifier.dup()])
				} else {
					if !(!rt.is_true(rt.get_superglobal('_GET').array_get('unapproved'))) && !(!rt.is_true(rt.get_superglobal('_GET').array_get('moderation-hash'))) {
						var_approved_clauses << rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('( comment_author_email = %s AND comment_approved = \'0\' AND '), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_ID = %d )')), var_unapproved_identifier.dup(), // unsupported expression: Expr_Cast_Int])
					} else {
						var_approved_clauses << rt.call_method(var_wpdb, 'prepare', [rt.new_string('( comment_author_email = %s AND comment_approved = \'0\' )'), var_unapproved_identifier.dup()])
					}
				}
			}
		}
	}
	if !(!rt.is_true(var_approved_clauses)) {
		if 1 == var_approved_clauses.len {
			this.sql_clauses.array_get_mut('where').array_set('approved', var_approved_clauses.array_get(0))
		} else {
			this.sql_clauses.array_get_mut('where').array_set('approved', '( ' + (rt.call_function('implode', [rt.new_string(' OR '), var_approved_clauses.dup()])).str() + ' )')
		}
	}
	mut var_order := rt.new_string(if rt.is_true(rt.identical(rt.new_string('ASC'), rt.new_string(this.query_vars.array_get('order').to_string().to_upper()))) { rt.new_string('ASC') } else { rt.new_string('DESC') })
	if rt.is_true(rt.call_function('in_array', [this.query_vars.array_get('orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'none' }, rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: false }]), rt.new_bool(true)])) {
		mut var_orderby := rt.new_string(rt.new_string(''))
	} else if !(!rt.is_true(this.query_vars.array_get('orderby'))) {
		mut var_ordersby := if rt.is_true(rt.new_bool(this.query_vars.array_get('orderby').is_array())) { this.query_vars.array_get('orderby') } else { rt.call_function('preg_split', [rt.new_string('/[,\\s]/'), this.query_vars.array_get('orderby')]) }
		mut var_orderby_array := rt.new_array()
		mut var_found_orderby_comment_id := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := var_ordersby.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__value := item_1.val
				mut var__key := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(var__value)))) {
					continue
				}
				if rt.is_true(rt.new_bool(var__key.dup().is_long())) {
					mut var__orderby := var__value
					mut var__order := var_order.dup()
				} else {
					var__orderby = var__key
					var__order = var__value
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_found_orderby_comment_id)))) && rt.is_true(rt.call_function('in_array', [var__orderby.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'comment_ID' }, rt.ArrayItem{ key: none, val: 'comment__in' }]), rt.new_bool(true)])))) {
					var_found_orderby_comment_id = rt.new_bool(rt.new_bool(true))
				}
				mut var_parsed := this.parse_orderby(var__orderby.dup())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
					continue
				}
				if rt.is_true(rt.identical(rt.new_string('comment__in'), var__orderby)) {
					var_orderby_array << var_parsed.dup()
					continue
				}
				var_orderby_array << (var_parsed).str() + ' ' + this.parse_order(var__order.dup())
			}
		}
		if !rt.is_true(var_orderby_array) {
			var_orderby_array << rt.concat(rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_date_gmt ')), var_order)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found_orderby_comment_id)))) {
			mut var_comment_id_order := rt.new_string(rt.new_string(''))
			for var_orderby_clause in var_orderby_array {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/comment_date(?:_gmt)*\\ (ASC|DESC)/'), var_orderby_clause.dup(), var_match.dup()])) {
					var_comment_id_order = var_match.array_get(1)
					break
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id_order)))) {
				for var_orderby_clause in var_orderby_array {
					if rt.is_true(rt.call_function('str_contains', [, .dup()])) {
						
					} else {
					}
					break
				}
			}
			if rt.is_true() {
			}
			
		}
		
	} else {
	}
	
	return rt.new_null()
}

fn (mut this Class_WP_Comment_Query) set_found_comments()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_Comment_Query) fill_descendants(var_comments rt.PhpVal) rt.PhpVal {
	mut var_comments_mutated := var_comments
}

fn (mut this Class_WP_Comment_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_Comment_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_orderby_mutated := var_orderby
}

fn (mut this Class_WP_Comment_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	return ''
}

struct Class_WP_Meta_Query {
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

fn create_wp_meta_query() &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
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
			return this.get_comments()
		}
		'get_comment_ids' {
			return this.get_comment_ids()
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




pub fn init_wp_includes_class_wp_comment_query_php() {
}
