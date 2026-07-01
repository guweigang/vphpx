import rt

struct Class_WP_User_Query {
	rt.PhpObjectBase
pub mut:
		query_vars rt.PhpVal = rt.new_array()
		results rt.PhpVal = rt.new_null()
		total_users rt.PhpVal = rt.new_int(0)
		meta_query rt.PhpVal = rt.new_bool(false)
		request string
		compat_fields rt.PhpVal = rt.new_array()
		query_fields rt.PhpVal = rt.new_null()
		query_from string
		query_where string
		query_orderby rt.PhpVal = rt.new_null()
		query_limit rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_User_Query) construct(var_query rt.PhpVal)  {
	if !(!rt.is_true(var_query)) {
		this.prepare_query(var_query.dup())
		this.query()
	}
}

fn Class_WP_User_Query.fill_query_vars(var_args rt.PhpVal) rt.PhpVal {
	mut var_defaults := { 'blog_id': rt.call_function('get_current_blog_id', []rt.PhpVal{}), 'role': rt.new_string(''), 'role__in': map[string]rt.PhpVal{}, 'role__not_in': map[string]rt.PhpVal{}, 'capability': rt.new_string(''), 'capability__in': map[string]rt.PhpVal{}, 'capability__not_in': map[string]rt.PhpVal{}, 'meta_key': rt.new_string(''), 'meta_value': rt.new_string(''), 'meta_compare': rt.new_string(''), 'include': map[string]rt.PhpVal{}, 'exclude': map[string]rt.PhpVal{}, 'search': rt.new_string(''), 'search_columns': map[string]rt.PhpVal{}, 'orderby': rt.new_string('login'), 'order': rt.new_string('ASC'), 'offset': rt.new_string(''), 'number': rt.new_string(''), 'paged': rt.new_int(1), 'count_total': rt.new_bool(true), 'fields': rt.new_string('all'), 'who': rt.new_string(''), 'has_published_posts': rt.new_null(), 'nicename': rt.new_string(''), 'nicename__in': map[string]rt.PhpVal{}, 'nicename__not_in': map[string]rt.PhpVal{}, 'login': rt.new_string(''), 'login__in': map[string]rt.PhpVal{}, 'login__not_in': map[string]rt.PhpVal{}, 'cache_results': rt.new_bool(true) }
	return rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
}

fn (mut this Class_WP_User_Query) prepare_query(var_query rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_wp_roles := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(this.query_vars) || !(!rt.is_true(var_query)) {
		this.query_limit = rt.new_null()
		this.query_vars = this.fill_query_vars(var_query.dup())
	}
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_users'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_User_Query', []string{}, &this) }])])
	// unsupported expression: Expr_AssignRef
	mut var_qv := this.fill_query_vars(var_qv.dup())
	mut var_allowed_fields := ['id', 'user_login', 'user_pass', 'user_nicename', 'user_email', 'user_url', 'user_registered', 'user_activation_key', 'user_status', 'display_name']
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_allowed_fields << 'spam'
		var_allowed_fields << 'deleted'
	}
	if rt.is_true(rt.new_bool(var_qv.array_get('fields').is_array())) {
		var_qv.array_set('fields', rt.call_function('array_map', [rt.new_string('strtolower'), var_qv.array_get('fields')]))
		var_qv.array_set('fields', rt.call_function('array_intersect', [rt.call_function('array_unique', [var_qv.array_get('fields')]), var_allowed_fields.dup()]))
		if !rt.is_true(var_qv.array_get('fields')) {
			var_qv.array_set('fields', rt.create_array([rt.ArrayItem{ key: none, val: 'id' }]))
		}
		this.query_fields = map[string]rt.PhpVal{}
		{
			mut iter_1 := var_qv.array_get('fields').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				var_field = if rt.is_true(rt.identical(rt.new_string('id'), var_field)) { rt.new_string('ID') } else { rt.call_function('sanitize_key', [var_field.dup()]) }
				this.query_fields.array_push(rt.concat(rt.concat(rt.get_property(var_wpdb, 'users'), rt.new_string('.')), var_field))
			}
		}
		this.query_fields = rt.call_function('implode', [rt.new_string(','), this.query_fields])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('all_with_meta'), var_qv.array_get('fields'))) || rt.is_true(rt.identical(rt.new_string('all'), var_qv.array_get('fields'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_qv.array_get('fields'), var_allowed_fields.dup(), rt.new_bool(true)]))))))) {
		this.query_fields = rt.concat(rt.get_property(var_wpdb, 'users'), rt.new_string('.ID'))
	} else {
		mut var_field := if rt.is_true(rt.identical(rt.new_string('id'), rt.new_string(var_qv.array_get('fields').to_string().to_lower()))) { rt.new_string('ID') } else { rt.call_function('sanitize_key', [var_qv.array_get('fields')]) }
		this.query_fields = rt.concat(rt.concat(rt.get_property(var_wpdb, 'users'), rt.new_string('.')), var_field)
	}
	if rt.is_true(rt.new_bool(var_qv.array_isset(rt.new_string('count_total')) && rt.is_true(var_qv.array_get('count_total')))) {
		this.query_fields = 'SQL_CALC_FOUND_ROWS ' + (this.query_fields).str()
	}
	this.query_from = rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb, 'users'))
	this.query_where = 'WHERE 1=1'
	if !(!rt.is_true(var_qv.array_get('include'))) {
		mut var_include := rt.call_function('wp_parse_id_list', [var_qv.array_get('include')])
	} else {
		var_include = rt.new_bool(rt.new_bool(false))
	}
	mut var_blog_id := rt.new_int(rt.new_int(0))
	if var_qv.array_isset(rt.new_string('blog_id')) {
		var_blog_id = rt.call_function('absint', [var_qv.array_get('blog_id')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_qv.array_get('has_published_posts')) && rt.is_true(var_blog_id))) {
		if rt.is_true(rt.identical(rt.new_bool(true), var_qv.array_get('has_published_posts'))) {
			mut var_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'public', val: true }])])
		} else {
			var_post_types = rt.cast_array(var_qv.array_get('has_published_posts'))
		}
		{
			mut iter_1 := var_post_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_post_type := item_1.val
				var_post_type = rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'), var_post_type.dup()])
			}
		}
		mut var_posts_table := rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.dup()])).str() + 'posts')
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_qv.array_get('nicename__in'))) {
		mut var_sanitized_nicename__in := rt.call_function('array_map', [rt.new_string('esc_sql'), var_qv.array_get('nicename__in')])
		mut var_nicename__in := rt.call_function('implode', [rt.new_string('\',\''), var_sanitized_nicename__in.dup()])
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_qv.array_get('nicename__not_in'))) {
		mut var_sanitized_nicename__not_in := rt.call_function('array_map', [rt.new_string('esc_sql'), var_qv.array_get('nicename__not_in')])
		mut var_nicename__not_in := rt.call_function('implode', [rt.new_string('\',\''), var_sanitized_nicename__not_in.dup()])
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_qv.array_get('login__in'))) {
		mut var_sanitized_login__in := rt.call_function('array_map', [rt.new_string('esc_sql'), var_qv.array_get('login__in')])
		mut var_login__in := rt.call_function('implode', [rt.new_string('\',\''), var_sanitized_login__in.dup()])
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_qv.array_get('login__not_in'))) {
		mut var_sanitized_login__not_in := rt.call_function('array_map', [rt.new_string('esc_sql'), var_qv.array_get('login__not_in')])
		mut var_login__not_in := rt.call_function('implode', [rt.new_string('\',\''), var_sanitized_login__not_in.dup()])
		// unsupported expression: Expr_AssignOp_Concat
	}
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [var_qv.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_qv.array_isset(rt.new_string('who')) && rt.is_true(rt.identical(rt.new_string('authors'), var_qv.array_get('who'))))) && rt.is_true(var_blog_id))) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_User_Query'), rt.new_string('5.9.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is deprecated. Use %2$s instead.')]), rt.new_string('<code>who</code>'), rt.new_string('<code>capability</code>')])])
		mut var_who_query := { 'key': (rt.call_method(var_wpdb, 'get_blog_prefix', [var_blog_id.dup()])).str() + 'user_level', 'value': rt.new_int(0), 'compare': rt.new_string('!=') }
		var_qv.array_set('blog_id', 0)
		var_blog_id = rt.new_int(rt.new_int(0))
		if !rt.is_true(rt.get_property(this.meta_query, 'queries')) {
			rt.set_property(this.meta_query, 'queries', rt.create_array([rt.ArrayItem{ key: none, val: var_who_query }]))
		} else {
			rt.set_property(this.meta_query, 'queries', rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(this.meta_query, 'queries') }, rt.ArrayItem{ key: none, val: var_who_query }]) }]))
		}
		rt.call_method(this.meta_query, 'parse_query_vars', [rt.get_property(this.meta_query, 'queries')])
	}
	mut var_roles := map[string]rt.PhpVal{}
	if var_qv.array_isset(rt.new_string('role')) {
		if rt.is_true(rt.new_bool(var_qv.array_get('role').is_array())) {
			var_roles = var_qv.array_get('role')
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_qv.array_get('role').is_string())) && !(!rt.is_true(var_qv.array_get('role'))))) {
			var_roles = rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_qv.array_get('role')])])
		}
	}
	mut var_role__in := map[string]rt.PhpVal{}
	if var_qv.array_isset(rt.new_string('role__in')) {
		var_role__in = rt.cast_array(var_qv.array_get('role__in'))
	}
	mut var_role__not_in := map[string]rt.PhpVal{}
	if var_qv.array_isset(rt.new_string('role__not_in')) {
		var_role__not_in = rt.cast_array(var_qv.array_get('role__not_in'))
	}
	mut var_available_roles := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get('capability'))) || !(!rt.is_true(var_qv.array_get('capability__in'))) || !(!rt.is_true(var_qv.array_get('capability__not_in'))) {
		rt.call_method(var_wp_roles, 'for_site', [var_blog_id.dup()])
		var_available_roles = rt.get_property(var_wp_roles, 'roles')
	}
	mut var_capabilities := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get('capability'))) {
		if rt.is_true(rt.new_bool(var_qv.array_get('capability').is_array())) {
			var_capabilities = var_qv.array_get('capability')
		} else if rt.is_true(rt.new_bool(var_qv.array_get('capability').is_string())) {
			var_capabilities = rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_qv.array_get('capability')])])
		}
	}
	mut var_capability__in := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get('capability__in'))) {
		var_capability__in = rt.cast_array(var_qv.array_get('capability__in'))
	}
	mut var_capability__not_in := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_qv.array_get('capability__not_in'))) {
		var_capability__not_in = rt.cast_array(var_qv.array_get('capability__not_in'))
	}
	mut var_caps_with_roles := map[string]rt.PhpVal{}
	{
		mut iter_1 := var_available_roles.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_role_data := item_1.val
			mut var_role := item_1.key
			mut var_role_caps := rt.func_array_keys(rt.call_function('array_filter', [var_role_data.array_get('capabilities')]))
			{
				mut iter_2 := var_capabilities.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_cap := item_2.val
					if rt.is_true(rt.call_function('in_array', [var_cap.dup(), var_role_caps.dup(), rt.new_bool(true)])) {
						var_caps_with_roles.array_get_mut(var_cap).array_push(var_role.dup())
						break
					}
				}
			}
			{
				mut iter_2 := var_capability__in.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_cap := item_2.val
					if rt.is_true(rt.call_function('in_array', [var_cap.dup(), var_role_caps.dup(), rt.new_bool(true)])) {
						var_role__in.array_push(var_role.dup())
						break
					}
				}
			}
			{
				mut iter_2 := var_capability__not_in.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_cap := item_2.val
					if rt.is_true(rt.call_function('in_array', [var_cap.dup(), var_role_caps.dup(), rt.new_bool(true)])) {
						var_role__not_in.array_push(var_role.dup())
						break
					}
				}
			}
		}
	}
	var_role__in = rt.call_function('array_merge', [var_role__in.dup(), var_capability__in.dup()])
	var_role__not_in = rt.call_function('array_merge', [var_role__not_in.dup(), var_capability__not_in.dup()])
	var_roles = rt.call_function('array_unique', [var_roles.dup()])
	var_role__in = rt.call_function('array_unique', [var_role__in.dup()])
	var_role__not_in = rt.call_function('array_unique', [var_role__not_in.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_blog_id) && !(!rt.is_true(var_capabilities)))) {
		mut var_capabilities_clauses := rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }])
		{
			mut iter_1 := var_capabilities.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cap := item_1.val
				mut var_clause := 
				
			}
		}
	}
	if rt.is_true() {
	}
	if !(!rt.is_true()) {
	}
	
}

fn (mut this Class_WP_User_Query) query()  {
	mut var_wpdb := rt.new_null()
	mut var_qv := rt.new_null()
}

fn (mut this Class_WP_User_Query) get(var_query_var rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_User_Query) set(var_query_var rt.PhpVal, var_value rt.PhpVal)  {
}

fn (mut this Class_WP_User_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal, wild bool) string {
	mut var_wpdb := rt.new_null()
	mut var_search_mutated := var_search
	mut wild_mutated := wild
}

fn (mut this Class_WP_User_Query) get_results() rt.PhpVal {
}

fn (mut this Class_WP_User_Query) get_total() rt.PhpVal {
}

fn (mut this Class_WP_User_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_User_Query) generate_cache_key(mut var_deprecated Class_array, var_sql rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_sql_mutated := var_sql
}

fn (mut this Class_WP_User_Query) get_cache_last_changed(mut var_args Class_array) rt.PhpVal {
}

fn (mut this Class_WP_User_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	return ''
}

fn (mut this Class_WP_User_Query) magic_get(var_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_User_Query) magic_set(var_name rt.PhpVal, var_value rt.PhpVal)  {
}

fn (mut this Class_WP_User_Query) magic_isset(var_name rt.PhpVal) bool {
}

fn (mut this Class_WP_User_Query) magic_unset(var_name rt.PhpVal)  {
}

fn (mut this Class_WP_User_Query) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

fn create_wp_user_query(arg_0 rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		query_vars: rt.new_array()
		results: rt.new_null()
		total_users: rt.new_int(0)
		meta_query: rt.new_bool(false)
		request: ''
		compat_fields: rt.new_array()
		query_fields: rt.new_null()
		query_from: ''
		query_where: ''
		query_orderby: rt.new_null()
		query_limit: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_meta_query() &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.generate_cache_key(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_cache_last_changed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'query_vars' { this.query_vars = val; return true }
		'results' { this.results = val; return true }
		'total_users' { this.total_users = val; return true }
		'meta_query' { this.meta_query = val; return true }
		'request' { this.request = (val).str(); return true }
		'compat_fields' { this.compat_fields = val; return true }
		'query_fields' { this.query_fields = val; return true }
		'query_from' { this.query_from = (val).str(); return true }
		'query_where' { this.query_where = (val).str(); return true }
		'query_orderby' { this.query_orderby = val; return true }
		'query_limit' { this.query_limit = val; return true }
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




pub fn init_wp_includes_class_wp_user_query_php() {
}
