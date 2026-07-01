import rt
import crypto.md5

struct Class_WP_Site_Query {
	rt.PhpObjectBase
pub mut:
		request string
		sql_clauses rt.PhpVal = rt.new_array()
		meta_query rt.PhpVal = rt.new_bool(false)
		meta_query_clauses rt.PhpVal = rt.new_null()
		date_query rt.PhpVal = rt.new_bool(false)
		query_vars rt.PhpVal = rt.new_null()
		query_var_defaults rt.PhpVal = rt.new_null()
		sites rt.PhpVal = rt.new_null()
		found_sites rt.PhpVal = rt.new_int(0)
		max_num_pages rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Site_Query) construct(query string)  {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([rt.ArrayItem{ key: 'fields', val: '' }, rt.ArrayItem{ key: 'ID', val: '' }, rt.ArrayItem{ key: 'site__in', val: '' }, rt.ArrayItem{ key: 'site__not_in', val: '' }, rt.ArrayItem{ key: 'number', val: 100 }, rt.ArrayItem{ key: 'offset', val: '' }, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'network_id', val: 0 }, rt.ArrayItem{ key: 'network__in', val: '' }, rt.ArrayItem{ key: 'network__not_in', val: '' }, rt.ArrayItem{ key: 'domain', val: '' }, rt.ArrayItem{ key: 'domain__in', val: '' }, rt.ArrayItem{ key: 'domain__not_in', val: '' }, rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'path__in', val: '' }, rt.ArrayItem{ key: 'path__not_in', val: '' }, rt.ArrayItem{ key: 'public', val: rt.new_null() }, rt.ArrayItem{ key: 'archived', val: rt.new_null() }, rt.ArrayItem{ key: 'mature', val: rt.new_null() }, rt.ArrayItem{ key: 'spam', val: rt.new_null() }, rt.ArrayItem{ key: 'deleted', val: rt.new_null() }, rt.ArrayItem{ key: 'lang_id', val: rt.new_null() }, rt.ArrayItem{ key: 'lang__in', val: '' }, rt.ArrayItem{ key: 'lang__not_in', val: '' }, rt.ArrayItem{ key: 'search', val: '' }, rt.ArrayItem{ key: 'search_columns', val: rt.new_array() }, rt.ArrayItem{ key: 'count', val: false }, rt.ArrayItem{ key: 'date_query', val: rt.new_null() }, rt.ArrayItem{ key: 'update_site_cache', val: true }, rt.ArrayItem{ key: 'update_site_meta_cache', val: true }, rt.ArrayItem{ key: 'meta_query', val: '' }, rt.ArrayItem{ key: 'meta_key', val: '' }, rt.ArrayItem{ key: 'meta_value', val: '' }, rt.ArrayItem{ key: 'meta_type', val: '' }, rt.ArrayItem{ key: 'meta_compare', val: '' }])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Site_Query) parse_query(query string)  {
	mut query_mutated := query
	if query_mutated == '' {
		query_mutated = (this.query_vars).str()
	}
	this.query_vars = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).dup(), this.query_var_defaults])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_site_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) }])])
}

fn (mut this Class_WP_Site_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.dup()])
	return this.get_sites()
}

fn (mut this Class_WP_Site_Query) get_sites() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.parse_query('')
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [this.query_vars])
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_sites'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) }])])
	rt.call_method(this.meta_query, 'parse_query_vars', [this.query_vars])
	if !(!rt.is_true(rt.get_property(this.meta_query, 'queries'))) {
		this.meta_query_clauses = rt.call_method(this.meta_query, 'get_sql', [rt.new_string('blog'), rt.get_property(var_wpdb, 'blogs'), rt.new_string('blog_id'), rt.new_object('WP_Site_Query', []string{}, &this)])
	}
	mut var_site_data := rt.new_null()
	var_site_data = rt.call_function('apply_filters_ref_array', [rt.new_string('sites_pre_query'), rt.create_array([rt.ArrayItem{ key: none, val: var_site_data }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) }])])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_site_data.dup().is_array())) && rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get('count'))))))) {
			this.sites = var_site_data.dup()
		}
		return var_site_data.dup()
	}
	mut var__args := rt.call_function('wp_array_slice_assoc', [this.query_vars, rt.func_array_keys(this.query_var_defaults)])
	var__args.array_unset(rt.new_string('fields'))
	var__args.array_unset(rt.new_string('update_site_cache'))
	var__args.array_unset(rt.new_string('update_site_meta_cache'))
	mut var_key := rt.new_string(rt.new_string(md5.hexhash(rt.call_function('serialize', [var__args.dup()]).to_string())))
	mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [rt.new_string('sites')])
	mut var_cache_key := rt.new_string(rt.new_string("get_sites:${var_key.to_string()}"))
	mut var_cache_value := rt.call_function('wp_cache_get_salted', [var_cache_key.dup(), rt.new_string('site-queries'), var_last_changed.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)) {
		mut var_site_ids := this.get_site_ids()
		if rt.is_true(var_site_ids) {
			this.set_found_sites()
		}
		var_cache_value = rt.create_array([rt.ArrayItem{ key: 'site_ids', val: var_site_ids }, rt.ArrayItem{ key: 'found_sites', val: this.found_sites }])
		rt.call_function('wp_cache_set_salted', [var_cache_key.dup(), var_cache_value.dup(), rt.new_string('site-queries'), var_last_changed.dup()])
	} else {
		var_site_ids = var_cache_value.array_get('site_ids')
		this.found_sites = var_cache_value.array_get('found_sites')
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.found_sites) && rt.is_true(this.query_vars.array_get('number')))) {
		this.max_num_pages = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(this.query_vars.array_get('count')) {
		return // unsupported expression: Expr_Cast_Int
	}
	var_site_ids = rt.call_function('array_map', [rt.new_string('intval'), var_site_ids.dup()])
	if rt.is_true(this.query_vars.array_get('update_site_meta_cache')) {
		rt.call_function('wp_lazyload_site_meta', [var_site_ids.dup()])
	}
	if rt.is_true(rt.identical(rt.new_string('ids'), this.query_vars.array_get('fields'))) {
		this.sites = var_site_ids.dup()
		return this.sites
	}
	if rt.is_true(this.query_vars.array_get('update_site_cache')) {
		rt.call_function('_prime_site_caches', [var_site_ids.dup(), rt.new_bool(false)])
	}
	mut var__sites := rt.new_array()
	{
		mut iter_1 := var_site_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_site_id := item_1.val
			mut var__site := rt.call_function('get_site', [var_site_id.dup()])
			if rt.is_true(var__site) {
				var__sites.array_push(var__site.dup())
			}
		}
	}
	var__sites = rt.call_function('apply_filters_ref_array', [rt.new_string('the_sites'), rt.create_array([rt.ArrayItem{ key: none, val: var__sites }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) }])])
	this.sites = rt.call_function('array_map', [rt.new_string('get_site'), var__sites.dup()])
	return this.sites
}

fn (mut this Class_WP_Site_Query) get_site_ids() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order := rt.new_string(this.parse_order(this.query_vars.array_get('order')))
	if rt.is_true(rt.call_function('in_array', [this.query_vars.array_get('orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'none' }, rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: false }]), rt.new_bool(true)])) {
		mut var_orderby := rt.new_string(rt.new_string(''))
	} else if !(!rt.is_true(this.query_vars.array_get('orderby'))) {
		mut var_ordersby := if rt.is_true(rt.new_bool(this.query_vars.array_get('orderby').is_array())) { this.query_vars.array_get('orderby') } else { rt.call_function('preg_split', [rt.new_string('/[,\\s]/'), this.query_vars.array_get('orderby')]) }
		mut var_orderby_array := rt.new_array()
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
				mut var_parsed := this.parse_orderby(var__orderby.dup())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
					continue
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('site__in'), var__orderby)) || rt.is_true(rt.identical(rt.new_string('network__in'), var__orderby)))) {
					var_orderby_array << var_parsed.dup()
					continue
				}
				var_orderby_array << (var_parsed).str() + ' ' + this.parse_order(var__order.dup())
			}
		}
		var_orderby = rt.call_function('implode', [rt.new_string(', '), var_orderby_array.dup()])
	} else {
		var_orderby = rt.new_string(rt.concat(rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id ')), var_order))
	}
	mut var_number := rt.call_function('absint', [this.query_vars.array_get('number')])
	mut var_offset := rt.call_function('absint', [this.query_vars.array_get('offset')])
	mut var_limits := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(var_number)) {
		if rt.is_true(var_offset) {
			var_limits = rt.new_string('LIMIT ' + (var_offset).str() + ',' + (var_number).str())
		} else {
			var_limits = rt.new_string('LIMIT ' + (var_number).str())
		}
	}
	if rt.is_true(this.query_vars.array_get('count')) {
		mut var_fields := rt.new_string(rt.new_string('COUNT(*)'))
	} else {
		var_fields = rt.new_string(rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id')))
	}
	mut var_site_id := rt.call_function('absint', [this.query_vars.array_get('ID')])
	if !(!rt.is_true(var_site_id)) {
		this.sql_clauses.array_get_mut('where').array_set('ID', rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id = %d')), var_site_id.dup()]))
	}
	if !(!rt.is_true(this.query_vars.array_get('site__in'))) {
		this.sql_clauses.array_get_mut('where').array_set('site__in', rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id IN ( ')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get('site__in')])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get('site__not_in'))) {
		this.sql_clauses.array_get_mut('where').array_set('site__not_in', rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id NOT IN ( ')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get('site__not_in')])])).str() + ' )')
	}
	mut var_network_id := rt.call_function('absint', [this.query_vars.array_get('network_id')])
	if !(!rt.is_true(var_network_id)) {
		this.sql_clauses.array_get_mut('where').array_set('network_id', rt.call_method(var_wpdb, 'prepare', [rt.new_string('site_id = %d'), var_network_id.dup()]))
	}
	if !(!rt.is_true(this.query_vars.array_get('network__in'))) {
		this.sql_clauses.array_get_mut('where').array_set('network__in', 'site_id IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get('network__in')])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get('network__not_in'))) {
		this.sql_clauses.array_get_mut('where').array_set('network__not_in', 'site_id NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get('network__not_in')])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get('domain'))) {
		this.sql_clauses.array_get_mut('where').array_set('domain', rt.call_method(var_wpdb, 'prepare', [rt.new_string('domain = %s'), this.query_vars.array_get('domain')]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('domain__in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__in', 'domain IN ( \'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('domain__in')])])).str() + '\' )')
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('domain__not_in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__not_in', 'domain NOT IN ( \'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('domain__not_in')])])).str() + '\' )')
	}
	if !(!rt.is_true(this.query_vars.array_get('path'))) {
		this.sql_clauses.array_get_mut('where').array_set('path', rt.call_method(var_wpdb, 'prepare', [rt.new_string('path = %s'), this.query_vars.array_get('path')]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('path__in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__in', 'path IN ( \'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('path__in')])])).str() + '\' )')
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('path__not_in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__not_in', 'path NOT IN ( \'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('path__not_in')])])).str() + '\' )')
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('archived').is_long() || this.query_vars.array_get('archived').is_double())) {
		mut var_archived := rt.call_function('absint', [this.query_vars.array_get('archived')])
		this.sql_clauses.array_get_mut('where').array_set('archived', rt.call_method(var_wpdb, 'prepare', [rt.new_string('archived = %s '), rt.call_function('absint', [var_archived.dup()])]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('mature').is_long() || this.query_vars.array_get('mature').is_double())) {
		mut var_mature := rt.call_function('absint', [this.query_vars.array_get('mature')])
		this.sql_clauses.array_get_mut('where').array_set('mature', rt.call_method(var_wpdb, 'prepare', [rt.new_string('mature = %d '), var_mature.dup()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('spam').is_long() || this.query_vars.array_get('spam').is_double())) {
		mut var_spam := rt.call_function('absint', [this.query_vars.array_get('spam')])
		this.sql_clauses.array_get_mut('where').array_set('spam', rt.call_method(var_wpdb, 'prepare', [rt.new_string('spam = %d '), var_spam.dup()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('deleted').is_long() || this.query_vars.array_get('deleted').is_double())) {
		mut var_deleted := rt.call_function('absint', [this.query_vars.array_get('deleted')])
		this.sql_clauses.array_get_mut('where').array_set('deleted', rt.call_method(var_wpdb, 'prepare', [rt.new_string('deleted = %d '), var_deleted.dup()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('public').is_long() || this.query_vars.array_get('public').is_double())) {
		mut var_public := rt.call_function('absint', [this.query_vars.array_get('public')])
		this.sql_clauses.array_get_mut('where').array_set('public', rt.call_method(var_wpdb, 'prepare', [rt.new_string('public = %d '), var_public.dup()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('lang_id').is_long() || this.query_vars.array_get('lang_id').is_double())) {
		mut var_lang_id := rt.call_function('absint', [this.query_vars.array_get('lang_id')])
		this.sql_clauses.array_get_mut('where').array_set('lang_id', rt.call_method(var_wpdb, 'prepare', [rt.new_string('lang_id = %d '), var_lang_id.dup()]))
	}
	if !(!rt.is_true(this.query_vars.array_get('lang__in'))) {
		this.sql_clauses.array_get_mut('where').array_set('lang__in',  + )
	}
	if !(!rt.is_true(this.query_vars.array_get('lang__not_in'))) {
		.array_get_mut().array_set(, )
	}
	if rt.is_true(rt.new_int(.to_string().len)) {
		
	}
	
}

fn (mut this Class_WP_Site_Query) set_found_sites()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_Site_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_Site_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_orderby_mutated := var_orderby
}

fn (mut this Class_WP_Site_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	return ''
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

fn create_wp_site_query(query string) &Class_WP_Site_Query {
	mut obj := &Class_WP_Site_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		request: ''
		sql_clauses: rt.new_array()
		meta_query: rt.new_bool(false)
		meta_query_clauses: rt.new_null()
		date_query: rt.new_bool(false)
		query_vars: rt.new_null()
		query_var_defaults: rt.new_null()
		sites: rt.new_null()
		found_sites: rt.new_int(0)
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

fn (mut this Class_WP_Site_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'get_sites' {
			return this.get_sites()
		}
		'get_site_ids' {
			return this.get_site_ids()
		}
		'set_found_sites' {
			this.set_found_sites()
			return rt.new_null()
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

fn (this &Class_WP_Site_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request' { return rt.new_string(this.request) }
		'sql_clauses' { return this.sql_clauses }
		'meta_query' { return this.meta_query }
		'meta_query_clauses' { return this.meta_query_clauses }
		'date_query' { return this.date_query }
		'query_vars' { return this.query_vars }
		'query_var_defaults' { return this.query_var_defaults }
		'sites' { return this.sites }
		'found_sites' { return this.found_sites }
		'max_num_pages' { return this.max_num_pages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Site_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'request' { this.request = (val).str(); return true }
		'sql_clauses' { this.sql_clauses = val; return true }
		'meta_query' { this.meta_query = val; return true }
		'meta_query_clauses' { this.meta_query_clauses = val; return true }
		'date_query' { this.date_query = val; return true }
		'query_vars' { this.query_vars = val; return true }
		'query_var_defaults' { this.query_var_defaults = val; return true }
		'sites' { this.sites = val; return true }
		'found_sites' { this.found_sites = val; return true }
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




pub fn init_wp_includes_class_wp_site_query_php() {
}
