import rt
import crypto.md5

struct Class_WP_User_Query {
	rt.PhpObjectBase
pub mut:
	query_vars    rt.PhpVal = rt.new_array()
	results       rt.PhpVal = rt.new_null()
	total_users   rt.PhpVal = rt.new_int(0)
	meta_query    rt.PhpVal = rt.new_bool(false)
	request       string
	compat_fields rt.PhpVal = rt.new_array()
	query_fields  rt.PhpVal = rt.new_null()
	query_from    string
	query_where   string
	query_orderby rt.PhpVal = rt.new_null()
	query_limit   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_User_Query) construct(var_query rt.PhpVal) {
	if !(!rt.is_true(var_query)) {
		this.prepare_query(var_query.clone())
		this.query()
	}
}

fn Class_WP_User_Query.fill_query_vars(var_args rt.PhpVal) rt.PhpVal {
	mut var_defaults := {
		'blog_id':             rt.call_function('get_current_blog_id', []rt.PhpVal{})
		'role':                rt.new_string('')
		'role__in':            map[string]rt.PhpVal{}
		'role__not_in':        map[string]rt.PhpVal{}
		'capability':          rt.new_string('')
		'capability__in':      map[string]rt.PhpVal{}
		'capability__not_in':  map[string]rt.PhpVal{}
		'meta_key':            rt.new_string('')
		'meta_value':          rt.new_string('')
		'meta_compare':        rt.new_string('')
		'include':             map[string]rt.PhpVal{}
		'exclude':             map[string]rt.PhpVal{}
		'search':              rt.new_string('')
		'search_columns':      map[string]rt.PhpVal{}
		'orderby':             rt.new_string('login')
		'order':               rt.new_string('ASC')
		'offset':              rt.new_string('')
		'number':              rt.new_string('')
		'paged':               rt.new_int(1)
		'count_total':         rt.new_bool(true)
		'fields':              rt.new_string('all')
		'who':                 rt.new_string('')
		'has_published_posts': rt.new_null()
		'nicename':            rt.new_string('')
		'nicename__in':        map[string]rt.PhpVal{}
		'nicename__not_in':    map[string]rt.PhpVal{}
		'login':               rt.new_string('')
		'login__in':           map[string]rt.PhpVal{}
		'login__not_in':       map[string]rt.PhpVal{}
		'cache_results':       rt.new_bool(true)
	}
	return rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
}

fn (mut this Class_WP_User_Query) prepare_query(var_query rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_wp_roles := rt.new_null()
	if !rt.is_true(this.query_vars) || !(!rt.is_true(var_query)) {
		this.query_limit = rt.new_null()
		this.query_vars = this.fill_query_vars(var_query.clone())
	}
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_users'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_User_Query', []string{}, &this) },
		])])
	mut var_qv := this.query_vars
	var_qv = this.fill_query_vars(var_qv.clone())
	mut var_allowed_fields := ['id', 'user_login', 'user_pass', 'user_nicename', 'user_email',
		'user_url', 'user_registered', 'user_activation_key', 'user_status', 'display_name']
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_allowed_fields << 'spam'
		var_allowed_fields << 'deleted'
	}
	if rt.is_true(rt.new_bool(var_qv.array_get(rt.new_string('fields')).is_array())) {
		var_qv.array_set('fields', rt.call_function('array_map', [
			rt.new_string('strtolower'),
			var_qv.array_get(rt.new_string('fields')),
		]))
		var_qv.array_set('fields', rt.call_function('array_intersect', [
			rt.call_function('array_unique', [var_qv.array_get(rt.new_string('fields'))]),
			rt.create_array_from_list(var_allowed_fields),
		]))
		if !rt.is_true(var_qv.array_get(rt.new_string('fields'))) {
			var_qv.array_set('fields', rt.create_array([
				rt.ArrayItem{ key: none, val: 'id' },
			]))
		}
		this.query_fields = map[string]rt.PhpVal{}
		mut iter_1 := var_qv.array_get(rt.new_string('fields')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			var_field = if rt.is_true(rt.identical(rt.new_string('id'), var_field)) { rt.new_string('ID') } else { rt.call_function('sanitize_key', [
					var_field.clone(),
				]) }
			this.query_fields.array_push(rt.concat(rt.concat(rt.get_property(var_wpdb, 'users'),
				rt.new_string('.')), var_field))
		}
		this.query_fields = rt.call_function('implode', [rt.new_string(','), this.query_fields])
	} else if
		rt.is_true(rt.identical(rt.new_string('all_with_meta'), var_qv.array_get(rt.new_string('fields'))))
		|| rt.is_true(rt.identical(rt.new_string('all'), var_qv.array_get(rt.new_string('fields'))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_qv.array_get(rt.new_string('fields')), rt.create_array_from_list(var_allowed_fields), rt.new_bool(true)]))))) {
		this.query_fields = rt.concat(rt.get_property(var_wpdb, 'users'), rt.new_string('.ID'))
	} else {
		mut var_field := if rt.is_true(rt.identical(rt.new_string('id'), rt.new_string(var_qv.array_get(rt.new_string('fields')).to_string().to_lower()))) { rt.new_string('ID') } else { rt.call_function('sanitize_key', [
				var_qv.array_get(rt.new_string('fields')),
			]) }
		this.query_fields = rt.concat(rt.concat(rt.get_property(var_wpdb, 'users'),
			rt.new_string('.')), var_field)
	}
	if var_qv.array_isset(rt.new_string('count_total'))
		&& rt.is_true(var_qv.array_get(rt.new_string('count_total'))) {
		this.query_fields = 'SQL_CALC_FOUND_ROWS ' + (this.query_fields).str()
	}
	this.query_from = rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb, 'users'))
	this.query_where = 'WHERE 1=1'
	if !(!rt.is_true(var_qv.array_get(rt.new_string('include')))) {
		mut var_include := rt.call_function('wp_parse_id_list', [
			var_qv.array_get(rt.new_string('include')),
		])
	} else {
		var_include = rt.new_bool(false)
	}
	mut var_blog_id := rt.new_int(0)
	if var_qv.array_isset(rt.new_string('blog_id')) {
		var_blog_id = rt.call_function('absint', [var_qv.array_get(rt.new_string('blog_id'))])
	}
	if rt.is_true(var_qv.array_get(rt.new_string('has_published_posts'))) && rt.is_true(var_blog_id) {
		if rt.is_true(rt.identical(rt.new_bool(true),
			var_qv.array_get(rt.new_string('has_published_posts'))))
		{
			mut var_post_types := rt.call_function('get_post_types', [
				rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
			])
		} else {
			var_post_types = rt.cast_array(var_qv.array_get(rt.new_string('has_published_posts')))
		}
		mut iter_2 := var_post_types.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_post_type := item_2.val
			var_post_type = rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('%s'), var_post_type.clone()])
		}
		mut var_posts_table := rt.new_string(
			(rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() + 'posts')
		this.query_where = rt.concat(this.query_where, rt.new_string(
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'users')), rt.new_string('.ID IN ( SELECT DISTINCT ')), var_posts_table), rt.new_string('.post_author FROM ')), var_posts_table), rt.new_string(' WHERE ')), var_posts_table), rt.new_string(".post_status = 'publish' AND ")), var_posts_table), rt.new_string('.post_type IN ( ')) +
			(rt.call_function('implode', [rt.new_string(', '), var_post_types.clone()])).str() +
			' ) )'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_qv.array_get(rt.new_string('nicename'))))))
	{
		this.query_where = rt.concat(this.query_where, rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND user_nicename = %s'),
			var_qv.array_get(rt.new_string('nicename')),
		]))
	}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('nicename__in')))) {
		mut var_sanitized_nicename__in := rt.call_function('array_map', [
			rt.new_string('esc_sql'),
			var_qv.array_get(rt.new_string('nicename__in')),
		])
		mut var_nicename__in := rt.call_function('implode', [
			rt.new_string("','"), var_sanitized_nicename__in.clone()])
		this.query_where = rt.concat(this.query_where,
			rt.new_string(" AND user_nicename IN ( '${var_nicename__in.to_string()}' )"))
	}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('nicename__not_in')))) {
		mut var_sanitized_nicename__not_in := rt.call_function('array_map', [
			rt.new_string('esc_sql'),
			var_qv.array_get(rt.new_string('nicename__not_in')),
		])
		mut var_nicename__not_in := rt.call_function('implode', [
			rt.new_string("','"), var_sanitized_nicename__not_in.clone()])
		this.query_where = rt.concat(this.query_where,
			rt.new_string(" AND user_nicename NOT IN ( '${var_nicename__not_in.to_string()}' )"))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_qv.array_get(rt.new_string('login'))))))
	{
		this.query_where = rt.concat(this.query_where, rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND user_login = %s'),
			var_qv.array_get(rt.new_string('login')),
		]))
	}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('login__in')))) {
		mut var_sanitized_login__in := rt.call_function('array_map', [
			rt.new_string('esc_sql'),
			var_qv.array_get(rt.new_string('login__in')),
		])
		mut var_login__in := rt.call_function('implode', [rt.new_string("','"),
			var_sanitized_login__in.clone()])
		this.query_where = rt.concat(this.query_where,
			rt.new_string(" AND user_login IN ( '${var_login__in.to_string()}' )"))
	}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('login__not_in')))) {
		mut var_sanitized_login__not_in := rt.call_function('array_map', [
			rt.new_string('esc_sql'),
			var_qv.array_get(rt.new_string('login__not_in')),
		])
		mut var_login__not_in := rt.call_function('implode', [
			rt.new_string("','"), var_sanitized_login__not_in.clone()])
		this.query_where = rt.concat(this.query_where,
			rt.new_string(" AND user_login NOT IN ( '${var_login__not_in.to_string()}' )"))
	}
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [var_qv.clone()])
	if var_qv.array_isset(rt.new_string('who'))
		&& rt.is_true(rt.identical(rt.new_string('authors'), var_qv.array_get(rt.new_string('who'))))
		&& rt.is_true(var_blog_id) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_User_Query'),
			rt.new_string('5.9.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s is deprecated. Use %2$s instead.'),
				]),
				rt.new_string('<code>who</code>'),
				rt.new_string('<code>capability</code>'),
			])])
		mut var_who_query := {
			'key':     (rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() +
				'user_level'
			'value':   rt.new_int(0)
			'compare': rt.new_string('!=')
		}
		var_qv.array_set('blog_id', 0)
		var_blog_id = rt.new_int(0)
		if !rt.is_true(rt.get_property(this.meta_query, 'queries')) {
			rt.set_property(this.meta_query, 'queries', rt.create_array([
				rt.ArrayItem{ key: none, val: var_who_query },
			]))
		} else {
			rt.set_property(this.meta_query, 'queries', rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'AND' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(this.meta_query, 'queries') },
					rt.ArrayItem{ key: none, val: var_who_query },
				]) },
			]))
		}
		rt.call_method(this.meta_query, 'parse_query_vars', [
			rt.get_property(this.meta_query, 'queries'),
		])
	}
	mut var_roles := map[string]rt.PhpVal{}
	if var_qv.array_isset(rt.new_string('role')) {
		if rt.is_true(rt.new_bool(var_qv.array_get(rt.new_string('role')).is_array())) {
			var_roles = var_qv.array_get(rt.new_string('role'))
		} else if var_qv.array_get(rt.new_string('role')).is_string()
			&& !(!rt.is_true(var_qv.array_get(rt.new_string('role')))) {
			var_roles = rt.call_function('array_map', [rt.new_string('trim'),
				rt.call_function('explode', [rt.new_string(','),
					var_qv.array_get(rt.new_string('role'))])])
		}
	}
	mut var_role__in := map[string]rt.PhpVal{}
	if var_qv.array_isset(rt.new_string('role__in')) {
		var_role__in = rt.cast_array(var_qv.array_get(rt.new_string('role__in')))
	}
	mut var_role__not_in := map[string]rt.PhpVal{}
	if var_qv.array_isset(rt.new_string('role__not_in')) {
		var_role__not_in = rt.cast_array(var_qv.array_get(rt.new_string('role__not_in')))
	}
	mut var_available_roles := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('capability'))))
		|| !(!rt.is_true(var_qv.array_get(rt.new_string('capability__in'))))
		|| !(!rt.is_true(var_qv.array_get(rt.new_string('capability__not_in')))) {
		rt.call_method(var_wp_roles, 'for_site', [var_blog_id.clone()])
		var_available_roles = rt.get_property(var_wp_roles, 'roles')
	}
	mut var_capabilities := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('capability')))) {
		if rt.is_true(rt.new_bool(var_qv.array_get(rt.new_string('capability')).is_array())) {
			var_capabilities = var_qv.array_get(rt.new_string('capability'))
		} else if rt.is_true(rt.new_bool(var_qv.array_get(rt.new_string('capability')).is_string())) {
			var_capabilities = rt.call_function('array_map', [
				rt.new_string('trim'),
				rt.call_function('explode', [
					rt.new_string(','), var_qv.array_get(rt.new_string('capability'))])])
		}
	}
	mut var_capability__in := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('capability__in')))) {
		var_capability__in = rt.cast_array(var_qv.array_get(rt.new_string('capability__in')))
	}
	mut var_capability__not_in := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('capability__not_in')))) {
		var_capability__not_in =
			rt.cast_array(var_qv.array_get(rt.new_string('capability__not_in')))
	}
	mut var_caps_with_roles := map[string]rt.PhpVal{}
	mut iter_3 := var_available_roles.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_role_data := item_3.val
		mut var_role := item_3.key
		mut var_role_caps := rt.func_array_keys(rt.call_function('array_filter', [
			var_role_data.array_get(rt.new_string('capabilities')),
		]))
		mut iter_4 := var_capabilities.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_cap := item_4.val
			if rt.is_true(rt.call_function('in_array', [var_cap.clone(),
				var_role_caps.clone(), rt.new_bool(true)]))
			{
				var_caps_with_roles.array_get_mut(var_cap).array_push(var_role.clone())
				break
			}
		}
		mut iter_5 := var_capability__in.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_cap := item_5.val
			if rt.is_true(rt.call_function('in_array', [var_cap.clone(),
				var_role_caps.clone(), rt.new_bool(true)]))
			{
				var_role__in.array_push(var_role.clone())
				break
			}
		}
		mut iter_6 := var_capability__not_in.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_cap := item_6.val
			if rt.is_true(rt.call_function('in_array', [var_cap.clone(),
				var_role_caps.clone(), rt.new_bool(true)]))
			{
				var_role__not_in.array_push(var_role.clone())
				break
			}
		}
	}
	var_role__in = rt.call_function('array_merge', [var_role__in.clone(),
		var_capability__in.clone()])
	var_role__not_in = rt.call_function('array_merge', [var_role__not_in.clone(),
		var_capability__not_in.clone()])
	var_roles = rt.call_function('array_unique', [var_roles.clone()])
	var_role__in = rt.call_function('array_unique', [var_role__in.clone()])
	var_role__not_in = rt.call_function('array_unique', [var_role__not_in.clone()])
	if rt.is_true(var_blog_id) && !(!rt.is_true(var_capabilities)) {
		mut var_capabilities_clauses := rt.create_array([
			rt.ArrayItem{ key: 'relation', val: 'AND' },
		])
		mut iter_7 := var_capabilities.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_cap := item_7.val
			mut var_clause := rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'OR' },
			])
			var_clause.array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val:
					(rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() +
					'capabilities' },
				rt.ArrayItem{ key: 'value', val: '"' + var_cap.str() + '"' },
				rt.ArrayItem{ key: 'compare', val: 'LIKE' },
			]))
			if !(!rt.is_true(var_caps_with_roles.array_get(var_cap))) {
				mut iter_8 := var_caps_with_roles.array_get(var_cap).iterator()
				for {
					item_8 := iter_8.next() or { break }
					mut var_role := item_8.val
					var_clause.array_push(rt.create_array([
						rt.ArrayItem{ key: 'key', val:
							(rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() +
							'capabilities' },
						rt.ArrayItem{ key: 'value', val: '"' + var_role.str() + '"' },
						rt.ArrayItem{ key: 'compare', val: 'LIKE' },
					]))
				}
			}
			var_capabilities_clauses.array_push(var_clause.clone())
		}
		var_role_queries.array_push(var_capabilities_clauses.clone())
		if !rt.is_true(rt.get_property(this.meta_query, 'queries')) {
			rt.get_property(this.meta_query, 'queries').array_push(var_capabilities_clauses.clone())
		} else {
			rt.set_property(this.meta_query, 'queries', rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'AND' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(this.meta_query, 'queries') },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_capabilities_clauses },
					]) },
				]) },
			]))
		}
		rt.call_method(this.meta_query, 'parse_query_vars', [
			rt.get_property(this.meta_query, 'queries'),
		])
	}
	if rt.is_true(var_blog_id) && !(!rt.is_true(var_roles))
		|| !(!rt.is_true(var_role__in)) || !(!rt.is_true(var_role__not_in))
		|| rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_role_queries := map[string]rt.PhpVal{}
		mut var_roles_clauses := rt.create_array([
			rt.ArrayItem{ key: 'relation', val: 'AND' },
		])
		if !(!rt.is_true(var_roles)) {
			mut iter_9 := var_roles.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_role := item_9.val
				var_roles_clauses.array_push(rt.create_array([
					rt.ArrayItem{ key: 'key', val:
						(rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() +
						'capabilities' },
					rt.ArrayItem{ key: 'value', val: '"' + var_role.str() + '"' },
					rt.ArrayItem{ key: 'compare', val: 'LIKE' },
				]))
			}
			var_role_queries.array_push(var_roles_clauses.clone())
		}
		mut var_role__in_clauses := rt.create_array([
			rt.ArrayItem{ key: 'relation', val: 'OR' },
		])
		if !(!rt.is_true(var_role__in)) {
			mut iter_10 := var_role__in.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_role := item_10.val
				var_role__in_clauses.array_push(rt.create_array([
					rt.ArrayItem{ key: 'key', val:
						(rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() +
						'capabilities' },
					rt.ArrayItem{ key: 'value', val: '"' + var_role.str() + '"' },
					rt.ArrayItem{ key: 'compare', val: 'LIKE' },
				]))
			}
			var_role_queries.array_push(var_role__in_clauses.clone())
		}
		mut var_role__not_in_clauses := rt.create_array([
			rt.ArrayItem{ key: 'relation', val: 'AND' },
		])
		if !(!rt.is_true(var_role__not_in)) {
			mut iter_11 := var_role__not_in.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_role := item_11.val
				var_role__not_in_clauses.array_push(rt.create_array([
					rt.ArrayItem{ key: 'key', val:
						(rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() +
						'capabilities' },
					rt.ArrayItem{ key: 'value', val: '"' + var_role.str() + '"' },
					rt.ArrayItem{ key: 'compare', val: 'NOT LIKE' },
				]))
			}
			var_role_queries.array_push(var_role__not_in_clauses.clone())
		}
		if !rt.is_true(var_role_queries) {
			var_role_queries.array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val:
					(rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.clone()])).str() +
					'capabilities' },
				rt.ArrayItem{ key: 'compare', val: 'EXISTS' },
			]))
		}
		var_role_queries.array_set('relation', 'AND')
		if !rt.is_true(rt.get_property(this.meta_query, 'queries')) {
			rt.set_property(this.meta_query, 'queries', var_role_queries.clone())
		} else {
			rt.set_property(this.meta_query, 'queries', rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'AND' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(this.meta_query, 'queries') },
					rt.ArrayItem{ key: none, val: var_role_queries },
				]) },
			]))
		}
		rt.call_method(this.meta_query, 'parse_query_vars', [
			rt.get_property(this.meta_query, 'queries'),
		])
	}
	if !(!rt.is_true(rt.get_property(this.meta_query, 'queries'))) {
		mut var_clauses := rt.call_method(this.meta_query, 'get_sql', [
			rt.new_string('user'),
			rt.get_property(var_wpdb, 'users'),
			rt.new_string('ID'),
			rt.new_object('WP_User_Query', []string{}, &this),
		])
		this.query_from = rt.concat(this.query_from, var_clauses.array_get(rt.new_string('join')))
		this.query_where = rt.concat(this.query_where,
			var_clauses.array_get(rt.new_string('where')))
		if rt.is_true(rt.call_method(this.meta_query, 'has_or_relation', []rt.PhpVal{})) {
			this.query_fields = 'DISTINCT ' + (this.query_fields).str()
		}
	}
	var_qv.array_set('order', if var_qv.array_isset(rt.new_string('order')) {
		var_qv.array_get(rt.new_string('order')).to_string().to_upper()
	} else {
		''
	})
	mut var_order := rt.new_string(this.parse_order(var_qv.array_get(rt.new_string('order'))))
	if !rt.is_true(var_qv.array_get(rt.new_string('orderby'))) {
		mut var_ordersby := rt.create_array([
			rt.ArrayItem{ key: 'user_login', val: var_order },
		])
	} else if rt.is_true(rt.new_bool(var_qv.array_get(rt.new_string('orderby')).is_array())) {
		var_ordersby = var_qv.array_get(rt.new_string('orderby'))
	} else {
		var_ordersby = rt.call_function('preg_split', [rt.new_string('/[,\\s]+/'),
			var_qv.array_get(rt.new_string('orderby'))])
	}
	mut var_orderby_array := map[string]rt.PhpVal{}
	mut iter_12 := var_ordersby.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var__value := item_12.val
		mut var__key := item_12.key
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
		mut var_parsed := this.parse_orderby(var__orderby.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('nicename__in'), var__orderby))
			|| rt.is_true(rt.identical(rt.new_string('login__in'), var__orderby)) {
			var_orderby_array << var_parsed.clone()
		} else {
			var_orderby_array << var_parsed.str() + ' ' + this.parse_order(var__order.clone())
		}
	}
	if !rt.is_true(var_orderby_array) {
		var_orderby_array << rt.new_string('user_login ${var_order.to_string()}')
	}
	this.query_orderby = 'ORDER BY ' +(rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_orderby_array)])).str()
	if var_qv.array_isset(rt.new_string('number'))
		&& rt.is_true(rt.greater(var_qv.array_get(rt.new_string('number')), rt.new_int(0))) {
		if rt.is_true(var_qv.array_get(rt.new_string('offset'))) {
			this.query_limit = rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('LIMIT %d, %d'),
				var_qv.array_get(rt.new_string('offset')),
				var_qv.array_get(rt.new_string('number')),
			])
		} else {
			this.query_limit = rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('LIMIT %d, %d'),
				rt.mul(var_qv.array_get(rt.new_string('number')), rt.sub(var_qv.array_get(rt.new_string('paged')),
					rt.new_int(1))),
				var_qv.array_get(rt.new_string('number')),
			])
		}
	}
	mut var_search := rt.new_string('')
	if var_qv.array_isset(rt.new_string('search')) {
		var_search =
			rt.new_string(var_qv.array_get(rt.new_string('search')).to_string().trim_space())
	}
	if rt.is_true(var_search) {
		mut var_leading_wild := rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_search.clone().to_string().trim_left(' \t\n\r')),
			var_search)))
		mut var_trailing_wild := rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_search.clone().to_string().trim_right(' \t\n\r')),
			var_search)))
		if rt.is_true(var_leading_wild) && rt.is_true(var_trailing_wild) {
			mut var_wild := rt.new_string('both')
		} else if rt.is_true(var_leading_wild) {
			var_wild = rt.new_string('leading')
		} else if rt.is_true(var_trailing_wild) {
			var_wild = rt.new_string('trailing')
		} else {
			var_wild = rt.new_bool(false)
		}
		if rt.is_true(var_wild) {
			var_search = rt.new_string(var_search.clone().to_string().trim_space())
		}
		mut var_search_columns := map[string]rt.PhpVal{}
		if rt.is_true(var_qv.array_get(rt.new_string('search_columns'))) {
			var_search_columns = rt.call_function('array_intersect', [
				var_qv.array_get(rt.new_string('search_columns')),
				rt.create_array([rt.ArrayItem{ key: none, val: 'ID' },
					rt.ArrayItem{ key: none, val: 'user_login' },
					rt.ArrayItem{ key: none, val: 'user_email' },
					rt.ArrayItem{ key: none, val: 'user_url' },
					rt.ArrayItem{ key: none, val: 'user_nicename' },
					rt.ArrayItem{ key: none, val: 'display_name' }]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_search_columns)))) {
			if rt.is_true(rt.call_function('str_contains', [var_search.clone(),
				rt.new_string('@')]))
			{
				var_search_columns = rt.create_array([
					rt.ArrayItem{ key: none, val: 'user_email' },
				])
			} else if rt.is_true(rt.new_bool(var_search.clone().is_long()
				|| var_search.clone().is_double()))
			{
				var_search_columns = rt.create_array([
					rt.ArrayItem{ key: none, val: 'user_login' },
					rt.ArrayItem{ key: none, val: 'ID' },
				])
			} else if
				rt.is_true(rt.call_function('preg_match', [rt.new_string('|^https?://|'), var_search.clone()]))
				&& !(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.call_function('wp_is_large_network', [rt.new_string('users')]))) {
				var_search_columns = rt.create_array([
					rt.ArrayItem{ key: none, val: 'user_url' },
				])
			} else {
				var_search_columns = rt.create_array([
					rt.ArrayItem{ key: none, val: 'user_login' },
					rt.ArrayItem{ key: none, val: 'user_url' },
					rt.ArrayItem{ key: none, val: 'user_email' },
					rt.ArrayItem{ key: none, val: 'user_nicename' },
					rt.ArrayItem{ key: none, val: 'display_name' },
				])
			}
		}
		var_search_columns = rt.call_function('apply_filters', [
			rt.new_string('user_search_columns'),
			var_search_columns.clone(),
			var_search.clone(),
			rt.new_object('WP_User_Query', []string{}, &this),
		])
		this.query_where = rt.concat(this.query_where, this.get_search_sql(var_search.clone(),
			var_search_columns.clone(), var_wild.to_bool()))
	}
	if !(!rt.is_true(var_include)) {
		mut var_ids := rt.call_function('implode', [rt.new_string(','),
			var_include.clone()])
		this.query_where = rt.concat(this.query_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
			'users')), rt.new_string('.ID IN (')), var_ids), rt.new_string(')')))
	} else if !(!rt.is_true(var_qv.array_get(rt.new_string('exclude')))) {
		var_ids = rt.call_function('implode', [rt.new_string(','),
			rt.call_function('wp_parse_id_list', [var_qv.array_get(rt.new_string('exclude'))])])
		this.query_where = rt.concat(this.query_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
			'users')), rt.new_string('.ID NOT IN (')), var_ids), rt.new_string(')')))
	}
	if !(!rt.is_true(var_qv.array_get(rt.new_string('date_query'))))
		&& var_qv.array_get(rt.new_string('date_query')).is_array() {
		mut var_date_query := create_wp_date_query(var_qv.array_get(rt.new_string('date_query')),
			rt.new_string('user_registered'))
		this.query_where = rt.concat(this.query_where, var_date_query.get_sql())
	}
	rt.call_function('do_action_ref_array', [rt.new_string('pre_user_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_User_Query', []string{}, &this) },
		])])
}

fn (mut this Class_WP_User_Query) query() {
	mut var_wpdb := rt.new_null()
	mut var_qv := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('plugins_loaded'),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string('WP_User_Query::query'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('User queries should not be run before the %s hook.'),
				]),
				rt.new_string('<code>plugins_loaded</code>'),
			]),
			rt.new_string('6.1.1')])
	}
	var_qv = this.query_vars
	if var_qv.array_get(rt.new_string('fields')).is_array()
		&& var_qv.array_get(rt.new_string('fields')).array_count() > 3 {
		var_qv.array_set('cache_results', false)
	}
	this.results = rt.call_function('apply_filters_ref_array', [
		rt.new_string('users_pre_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_User_Query', []string{}, &this) }]),
	])
	if rt.is_true(rt.identical(rt.new_null(), this.results)) {
		this.request = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
			this.query_fields), rt.new_string('\n\t\t\t\t ')), this.query_from),
			rt.new_string('\n\t\t\t\t ')), this.query_where), rt.new_string('\n\t\t\t\t ')),
			this.query_orderby), rt.new_string('\n\t\t\t\t ')), this.query_limit)
		mut var_cache_value := rt.new_bool(false)
		mut var_cache_key := rt.new_string(this.generate_cache_key(mut rt.cast_object_ptr[Class_array](var_qv),
			rt.new_string(this.request)))
		mut var_cache_group := rt.new_string('user-queries')
		mut var_last_changed :=
			this.get_cache_last_changed(mut rt.cast_object_ptr[Class_array](var_qv))
		if rt.is_true(var_qv.array_get(rt.new_string('cache_results'))) {
			var_cache_value = rt.call_function('wp_cache_get_salted', [
				var_cache_key.clone(), var_cache_group.clone(),
				var_last_changed.clone()])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)))) {
			this.results = var_cache_value.array_get(rt.new_string('user_data'))
			this.total_users = var_cache_value.array_get(rt.new_string('total_users'))
		} else {
			if rt.is_true(rt.new_bool(var_qv.array_get(rt.new_string('fields')).is_array())) {
				this.results = rt.call_method(var_wpdb, 'get_results', [
					rt.new_string(this.request),
				])
			} else {
				this.results = rt.call_method(var_wpdb, 'get_col', [
					rt.new_string(this.request),
				])
			}
			if var_qv.array_isset(rt.new_string('count_total'))
				&& rt.is_true(var_qv.array_get(rt.new_string('count_total'))) {
				mut var_found_users_query := rt.call_function('apply_filters', [
					rt.new_string('found_users_query'),
					rt.new_string('SELECT FOUND_ROWS()'),
					rt.new_object('WP_User_Query', []string{}, &this),
				])
				this.total_users = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
					var_found_users_query.clone(),
				])).to_i64())
			}
			if rt.is_true(var_qv.array_get(rt.new_string('cache_results'))) {
				var_cache_value = rt.create_array([
					rt.ArrayItem{ key: 'user_data', val: this.results },
					rt.ArrayItem{ key: 'total_users', val: this.total_users },
				])
				rt.call_function('wp_cache_set_salted', [var_cache_key.clone(),
					var_cache_value.clone(), var_cache_group.clone(),
					var_last_changed.clone()])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.results)))) {
		return
	}
	if var_qv.array_get(rt.new_string('fields')).is_array()
		&& !(rt.get_property(this.results.array_get(rt.new_int(0)), 'ID')).is_null() {
		mut iter_13 := this.results.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_result := item_13.val
			rt.set_property(var_result, 'id', rt.get_property(var_result, 'ID'))
		}
	} else if
		rt.is_true(rt.identical(rt.new_string('all_with_meta'), var_qv.array_get(rt.new_string('fields'))))
		|| rt.is_true(rt.identical(rt.new_string('all'), var_qv.array_get(rt.new_string('fields')))) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('cache_users')])) {
			rt.call_function('cache_users', [this.results])
		}
		mut var_r := map[string]rt.PhpVal{}
		mut iter_14 := this.results.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_userid := item_14.val
			if rt.is_true(rt.identical(rt.new_string('all_with_meta'),
				var_qv.array_get(rt.new_string('fields'))))
			{
				var_r.array_set(var_userid, create_wp_user(var_userid.clone(), rt.new_string(''),
					var_qv.array_get(rt.new_string('blog_id'))))
			} else {
				var_r.array_push(create_wp_user(var_userid.clone(), rt.new_string(''),
					var_qv.array_get(rt.new_string('blog_id'))))
			}
		}
		this.results = var_r.clone()
	}
}

fn (mut this Class_WP_User_Query) get(var_query_var rt.PhpVal) rt.PhpVal {
	return if !(this.query_vars.array_get(var_query_var)).is_null() {
		this.query_vars.array_get(var_query_var)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WP_User_Query) set(var_query_var rt.PhpVal, var_value rt.PhpVal) {
	this.query_vars.array_set(var_query_var, var_value.clone())
}

fn (mut this Class_WP_User_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal, wild bool) string {
	mut var_wpdb := rt.new_null()
	mut var_search_mutated := var_search
	mut wild_mutated := wild
	mut var_searches := map[string]rt.PhpVal{}
	mut var_leading_wild := rt.new_string((if
		rt.is_true(rt.identical(rt.new_string('leading'), rt.new_bool(wild_mutated)))
		|| rt.is_true(rt.identical(rt.new_string('both'), rt.new_bool(wild_mutated))) {
		'%'
	} else {
		''
	}).str())
	mut var_trailing_wild := rt.new_string((if
		rt.is_true(rt.identical(rt.new_string('trailing'), rt.new_bool(wild_mutated)))
		|| rt.is_true(rt.identical(rt.new_string('both'), rt.new_bool(wild_mutated))) {
		'%'
	} else {
		''
	}).str())
	mut var_like := rt.new_string(var_leading_wild.str() +
		(rt.call_method(var_wpdb, 'esc_like', [var_search_mutated.clone()])).str() +
		var_trailing_wild.str())
	mut iter_15 := var_columns.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_column := item_15.val
		if rt.is_true(rt.identical(rt.new_string('ID'), var_column)) {
			var_searches << rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('${var_column.to_string()} = %s'),
				var_search_mutated.clone(),
			])
		} else {
			var_searches << rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('${var_column.to_string()} LIKE %s'),
				var_like.clone(),
			])
		}
	}
	return
		' AND (' + (rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_searches)])).str() +
		')'
}

fn (mut this Class_WP_User_Query) get_results() rt.PhpVal {
	return this.results
}

fn (mut this Class_WP_User_Query) get_total() rt.PhpVal {
	return this.total_users
}

fn (mut this Class_WP_User_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_meta_query_clauses := rt.call_method(this.meta_query, 'get_clauses', []rt.PhpVal{})
	mut var__orderby := rt.new_string('')
	if rt.is_true(rt.call_function('in_array', [var_orderby.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'login' },
			rt.ArrayItem{ key: none, val: 'nicename' }, rt.ArrayItem{ key: none, val: 'email' },
			rt.ArrayItem{ key: none, val: 'url' }, rt.ArrayItem{ key: none, val: 'registered' }]),
		rt.new_bool(true)]))
	{
		var__orderby = rt.new_string('user_' + var_orderby.str())
	} else if rt.is_true(rt.call_function('in_array', [var_orderby.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'user_login' },
			rt.ArrayItem{ key: none, val: 'user_nicename' }, rt.ArrayItem{
				key: none
				val: 'user_email'
			}, rt.ArrayItem{ key: none, val: 'user_url' }, rt.ArrayItem{
				key: none
				val: 'user_registered'
			}]),
		rt.new_bool(true)]))
	{
		var__orderby = var_orderby
	} else if rt.is_true(rt.identical(rt.new_string('name'), var_orderby))
		|| rt.is_true(rt.identical(rt.new_string('display_name'), var_orderby)) {
		var__orderby = rt.new_string('display_name')
	} else if rt.is_true(rt.identical(rt.new_string('post_count'), var_orderby)) {
		mut var_where := rt.call_function('get_posts_by_author_sql', [
			rt.new_string('post'),
		])
		this.query_from = rt.concat(this.query_from, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT OUTER JOIN (\n\t\t\t\tSELECT post_author, COUNT(*) as post_count\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string('\n\t\t\t\t')), var_where),
			rt.new_string('\n\t\t\t\tGROUP BY post_author\n\t\t\t) p ON (')), rt.get_property(var_wpdb,
			'users')), rt.new_string('.ID = p.post_author)')))
		var__orderby = rt.new_string('post_count')
	} else if rt.is_true(rt.identical(rt.new_string('ID'), var_orderby))
		|| rt.is_true(rt.identical(rt.new_string('id'), var_orderby)) {
		var__orderby = rt.new_string('ID')
	} else if rt.is_true(rt.identical(rt.new_string('meta_value'), var_orderby))
		|| rt.is_true(rt.identical(this.get(rt.new_string('meta_key')), var_orderby)) {
		var__orderby = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'usermeta'),
			rt.new_string('.meta_value'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('meta_value_num'), var_orderby)) {
		var__orderby = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'usermeta'),
			rt.new_string('.meta_value+0'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('include'), var_orderby))
		&& !(!rt.is_true(this.query_vars.array_get(rt.new_string('include')))) {
		mut var_include := rt.call_function('wp_parse_id_list', [
			this.query_vars.array_get(rt.new_string('include')),
		])
		mut var_include_sql := rt.call_function('implode', [rt.new_string(','),
			var_include.clone()])
		var__orderby = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('FIELD( '), rt.get_property(var_wpdb,
			'users')), rt.new_string('.ID, ')), var_include_sql), rt.new_string(' )'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('nicename__in'), var_orderby)) {
		mut var_sanitized_nicename__in := rt.call_function('array_map', [
			rt.new_string('esc_sql'),
			this.query_vars.array_get(rt.new_string('nicename__in')),
		])
		mut var_nicename__in := rt.call_function('implode', [
			rt.new_string("','"), var_sanitized_nicename__in.clone()])
		var__orderby = rt.new_string("FIELD( user_nicename, '${var_nicename__in.to_string()}' )")
	} else if rt.is_true(rt.identical(rt.new_string('login__in'), var_orderby)) {
		mut var_sanitized_login__in := rt.call_function('array_map', [
			rt.new_string('esc_sql'),
			this.query_vars.array_get(rt.new_string('login__in')),
		])
		mut var_login__in := rt.call_function('implode', [rt.new_string("','"),
			var_sanitized_login__in.clone()])
		var__orderby = rt.new_string("FIELD( user_login, '${var_login__in.to_string()}' )")
	} else if var_meta_query_clauses.array_isset(var_orderby) {
		mut var_meta_clause := var_meta_query_clauses.array_get(var_orderby)
		var__orderby = rt.call_function('sprintf', [
			rt.new_string('CAST(%s.meta_value AS %s)'),
			rt.call_function('esc_sql', [var_meta_clause.array_get(rt.new_string('alias'))]),
			rt.call_function('esc_sql', [var_meta_clause.array_get(rt.new_string('cast'))]),
		])
	}
	return var__orderby.clone()
}

fn (mut this Class_WP_User_Query) generate_cache_key(mut var_deprecated Class_array, var_sql rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_sql_mutated := var_sql
	var_sql_mutated = rt.call_method(var_wpdb, 'remove_placeholder_escape', [
		var_sql_mutated.clone()])
	mut var_key := rt.new_string(md5.hexhash(var_sql_mutated.clone().to_string()))
	return 'get_users:${var_key.to_string()}'
}

fn (mut this Class_WP_User_Query) get_cache_last_changed(mut var_args Class_array) rt.PhpVal {
	mut var_last_changed := rt.cast_array(rt.call_function('wp_cache_get_last_changed', [
		rt.new_string('users'),
	]))
	if !rt.is_true(var_args.array_get(rt.new_string('orderby'))) {
		mut var_ordersby := rt.create_array([rt.ArrayItem{ key: 'user_login', val: '' }])
	} else if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('orderby')).is_array())) {
		var_ordersby = var_args.array_get(rt.new_string('orderby'))
	} else {
		var_ordersby = rt.call_function('preg_split', [rt.new_string('/[,\\s]+/'),
			var_args.array_get(rt.new_string('orderby'))])
	}
	mut var_blog_id := rt.new_int(0)
	if var_args.array_isset(rt.new_string('blog_id')) {
		var_blog_id = rt.call_function('absint', [var_args.array_get(rt.new_string('blog_id'))])
	}
	if rt.is_true(var_args.array_get(rt.new_string('has_published_posts')))
		|| rt.is_true(rt.call_function('in_array', [rt.new_string('post_count'), var_ordersby.clone(), rt.new_bool(true)])) {
		mut var_switch := rt.new_bool(rt.is_true(var_blog_id)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_blog_id)))))
		if rt.is_true(var_switch) {
			rt.call_function('switch_to_blog', [var_blog_id.clone()])
		}
		var_last_changed.array_push(rt.call_function('wp_cache_get_last_changed', [
			rt.new_string('posts'),
		]))
		if rt.is_true(var_switch) {
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		}
	}
	return var_last_changed.clone()
}

fn (mut this Class_WP_User_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	if !(var_order_mutated.clone().is_string()) || !rt.is_true(var_order_mutated) {
		return 'DESC'
	}
	if rt.is_true(rt.identical(rt.new_string('ASC'),
		rt.new_string(var_order_mutated.clone().to_string().to_upper())))
	{
		return 'ASC'
	} else {
		return 'DESC'
	}
	return ''
}

fn (mut this Class_WP_User_Query) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		return rt.get_property(rt.new_object('WP_User_Query', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":1136,"name":"name"}')
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'The property `${var_name.to_string()}` is not declared. Getting a dynamic property is ' +
			'deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
	return rt.new_null()
}

fn (mut this Class_WP_User_Query) magic_set(var_name rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1159,"name":"name"}',
			var_value.clone())
		return
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'The property `${var_name.to_string()}` is not declared. Setting a dynamic property is ' +
			'deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
}

fn (mut this Class_WP_User_Query) magic_isset(var_name rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		return (rt.new_bool(!(rt.get_property(rt.new_object('WP_User_Query', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":1182,"name":"name"}')).is_null())).to_bool()
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'The property `${var_name.to_string()}` is not declared. Checking `isset()` on a dynamic property ' +
			'is deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
	return false
}

fn (mut this Class_WP_User_Query) magic_unset(var_name rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		rt.get_property(rt.new_object('WP_User_Query', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":1204,"name":"name"}') = rt.new_null()
		return
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'A property `${var_name.to_string()}` is not declared. Unsetting a dynamic property is ' +
			'deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
}

fn (mut this Class_WP_User_Query) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('get_search_sql'), var_name)) {
		return this.get_search_sql(var_arguments.clone(), rt.new_null(), false)
	}
	return false
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_WP_Date_Query {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_wp_user_query(arg_0 rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		query_vars:    rt.new_array()
		results:       rt.new_null()
		total_users:   rt.new_int(0)
		meta_query:    rt.new_bool(false)
		request:       ''
		compat_fields: rt.new_array()
		query_fields:  rt.new_null()
		query_from:    ''
		query_where:   ''
		query_orderby: rt.new_null()
		query_limit:   rt.new_null()
	}
	obj.construct(arg_0)
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

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'fill_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_User_Query.fill_query_vars(dispatch_arg_0)
		}
		'prepare_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepare_query(dispatch_arg_0)
			return rt.new_null()
		}
		'query' {
			this.query()
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_search_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_search_sql(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_results' {
			return this.get_results()
		}
		'get_total' {
			return this.get_total()
		}
		'parse_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_orderby(dispatch_arg_0)
		}
		'generate_cache_key' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.generate_cache_key(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_cache_last_changed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_cache_last_changed(mut dispatch_arg_0)
		}
		'parse_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parse_order(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query_vars' { return this.query_vars }
		'results' { return this.results }
		'total_users' { return this.total_users }
		'meta_query' { return this.meta_query }
		'request' { return rt.new_string(this.request) }
		'compat_fields' { return this.compat_fields }
		'query_fields' { return this.query_fields }
		'query_from' { return rt.new_string(this.query_from) }
		'query_where' { return rt.new_string(this.query_where) }
		'query_orderby' { return this.query_orderby }
		'query_limit' { return this.query_limit }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query_vars' {
			this.query_vars = val
			return true
		}
		'results' {
			this.results = val
			return true
		}
		'total_users' {
			this.total_users = val
			return true
		}
		'meta_query' {
			this.meta_query = val
			return true
		}
		'request' {
			this.request = val.str()
			return true
		}
		'compat_fields' {
			this.compat_fields = val
			return true
		}
		'query_fields' {
			this.query_fields = val
			return true
		}
		'query_from' {
			this.query_from = val.str()
			return true
		}
		'query_where' {
			this.query_where = val.str()
			return true
		}
		'query_orderby' {
			this.query_orderby = val
			return true
		}
		'query_limit' {
			this.query_limit = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
}
