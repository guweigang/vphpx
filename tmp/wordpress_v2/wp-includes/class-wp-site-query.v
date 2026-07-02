import rt
import crypto.md5

struct Class_WP_Site_Query {
	rt.PhpObjectBase
pub mut:
	request            string
	sql_clauses        rt.PhpVal = rt.new_array()
	meta_query         rt.PhpVal = rt.new_bool(false)
	meta_query_clauses rt.PhpVal = rt.new_null()
	date_query         rt.PhpVal = rt.new_bool(false)
	query_vars         rt.PhpVal = rt.new_null()
	query_var_defaults rt.PhpVal = rt.new_null()
	sites              rt.PhpVal = rt.new_null()
	found_sites        rt.PhpVal = rt.new_int(0)
	max_num_pages      rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Site_Query) construct(query string) {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([rt.ArrayItem{ key: 'fields', val: '' },
		rt.ArrayItem{ key: 'ID', val: '' }, rt.ArrayItem{ key: 'site__in', val: '' },
		rt.ArrayItem{ key: 'site__not_in', val: '' }, rt.ArrayItem{ key: 'number', val: 100 },
		rt.ArrayItem{ key: 'offset', val: '' }, rt.ArrayItem{ key: 'no_found_rows', val: true },
		rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'order', val: 'ASC' },
		rt.ArrayItem{ key: 'network_id', val: 0 }, rt.ArrayItem{ key: 'network__in', val: '' },
		rt.ArrayItem{ key: 'network__not_in', val: '' }, rt.ArrayItem{ key: 'domain', val: '' },
		rt.ArrayItem{ key: 'domain__in', val: '' }, rt.ArrayItem{ key: 'domain__not_in', val: '' },
		rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'path__in', val: '' },
		rt.ArrayItem{ key: 'path__not_in', val: '' }, rt.ArrayItem{
			key: 'public'
			val: rt.new_null()
		}, rt.ArrayItem{ key: 'archived', val: rt.new_null() },
		rt.ArrayItem{ key: 'mature', val: rt.new_null() }, rt.ArrayItem{
			key: 'spam'
			val: rt.new_null()
		}, rt.ArrayItem{ key: 'deleted', val: rt.new_null() },
		rt.ArrayItem{ key: 'lang_id', val: rt.new_null() }, rt.ArrayItem{ key: 'lang__in', val: '' },
		rt.ArrayItem{ key: 'lang__not_in', val: '' }, rt.ArrayItem{ key: 'search', val: '' },
		rt.ArrayItem{ key: 'search_columns', val: rt.new_array() },
		rt.ArrayItem{ key: 'count', val: false }, rt.ArrayItem{
			key: 'date_query'
			val: rt.new_null()
		}, rt.ArrayItem{ key: 'update_site_cache', val: true },
		rt.ArrayItem{ key: 'update_site_meta_cache', val: true },
		rt.ArrayItem{ key: 'meta_query', val: '' }, rt.ArrayItem{ key: 'meta_key', val: '' },
		rt.ArrayItem{ key: 'meta_value', val: '' }, rt.ArrayItem{ key: 'meta_type', val: '' },
		rt.ArrayItem{ key: 'meta_compare', val: '' }])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Site_Query) parse_query(query string) {
	mut query_mutated := query
	if query_mutated == '' {
		query_mutated = (this.query_vars).str()
	}
	this.query_vars = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).clone(),
		this.query_var_defaults])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_site_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) },
		])])
}

fn (mut this Class_WP_Site_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.clone()])
	return rt.new_int(this.get_sites())
}

fn (mut this Class_WP_Site_Query) get_sites() i64 {
	mut var_wpdb := rt.new_null()
	this.parse_query('')
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [this.query_vars])
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_sites'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) },
		])])
	rt.call_method(this.meta_query, 'parse_query_vars', [this.query_vars])
	if !(!rt.is_true(rt.get_property(this.meta_query, 'queries'))) {
		this.meta_query_clauses = rt.call_method(this.meta_query, 'get_sql', [
			rt.new_string('blog'),
			rt.get_property(var_wpdb, 'blogs'),
			rt.new_string('blog_id'),
			rt.new_object('WP_Site_Query', []string{}, &this),
		])
	}
	mut var_site_data := rt.new_null()
	var_site_data = rt.call_function('apply_filters_ref_array', [
		rt.new_string('sites_pre_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_site_data },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) }]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_site_data)))) {
		if var_site_data.clone().is_array()
			&& rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('count')))))) {
			this.sites = var_site_data.clone()
		}
		return var_site_data.to_i64()
	}
	mut var__args := rt.call_function('wp_array_slice_assoc', [this.query_vars,
		rt.func_array_keys(this.query_var_defaults)])
	var__args.array_unset(rt.new_string('fields'))
	var__args.array_unset(rt.new_string('update_site_cache'))
	var__args.array_unset(rt.new_string('update_site_meta_cache'))
	mut var_key := rt.new_string(md5.hexhash(rt.call_function('serialize', [
		var__args.clone()]).to_string()))
	mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [
		rt.new_string('sites'),
	])
	mut var_cache_key := rt.new_string('get_sites:${var_key.to_string()}')
	mut var_cache_value := rt.call_function('wp_cache_get_salted', [
		var_cache_key.clone(), rt.new_string('site-queries'),
		var_last_changed.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)) {
		mut var_site_ids := rt.new_int(this.get_site_ids())
		if rt.is_true(var_site_ids) {
			this.set_found_sites()
		}
		var_cache_value = rt.create_array([
			rt.ArrayItem{ key: 'site_ids', val: var_site_ids },
			rt.ArrayItem{ key: 'found_sites', val: this.found_sites },
		])
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(),
			var_cache_value.clone(), rt.new_string('site-queries'),
			var_last_changed.clone()])
	} else {
		var_site_ids = var_cache_value.array_get(rt.new_string('site_ids'))
		this.found_sites = var_cache_value.array_get(rt.new_string('found_sites'))
	}
	if rt.is_true(this.found_sites)
		&& rt.is_true(this.query_vars.array_get(rt.new_string('number'))) {
		this.max_num_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(this.found_sites, this.query_vars.array_get(rt.new_string('number'))),
		])).to_i64())
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('count'))) {
		return rt.new_int(var_site_ids.to_i64())
	}
	var_site_ids = rt.call_function('array_map', [rt.new_string('intval'),
		var_site_ids.clone()])
	if rt.is_true(this.query_vars.array_get(rt.new_string('update_site_meta_cache'))) {
		rt.call_function('wp_lazyload_site_meta', [var_site_ids.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('ids'),
		this.query_vars.array_get(rt.new_string('fields'))))
	{
		this.sites = var_site_ids.clone()
		return (this.sites).to_i64()
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('update_site_cache'))) {
		rt.call_function('_prime_site_caches', [var_site_ids.clone(),
			rt.new_bool(false)])
	}
	mut var__sites := rt.new_array()
	mut iter_1 := var_site_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_site_id := item_1.val
		mut var__site := rt.call_function('get_site', [var_site_id.clone()])
		if rt.is_true(var__site) {
			var__sites.array_push(var__site.clone())
		}
	}
	var__sites = rt.call_function('apply_filters_ref_array', [
		rt.new_string('the_sites'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: var__sites },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) },
		])])
	this.sites = rt.call_function('array_map', [rt.new_string('get_site'),
		var__sites.clone()])
	return (this.sites).to_i64()
}

fn (mut this Class_WP_Site_Query) get_site_ids() i64 {
	mut var_wpdb := rt.new_null()
	mut var_order :=
		rt.new_string(this.parse_order(this.query_vars.array_get(rt.new_string('order'))))
	if rt.is_true(rt.call_function('in_array', [this.query_vars.array_get(rt.new_string('orderby')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'none' },
			rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: false }]),
		rt.new_bool(true)]))
	{
		mut var_orderby := rt.new_string('')
	} else if !(!rt.is_true(this.query_vars.array_get(rt.new_string('orderby')))) {
		mut var_ordersby := if this.query_vars.array_get(rt.new_string('orderby')).is_array() { this.query_vars.array_get(rt.new_string('orderby')) } else { rt.call_function('preg_split', [
				rt.new_string('/[,\\s]/'),
				this.query_vars.array_get(rt.new_string('orderby')),
			]) }
		mut var_orderby_array := rt.new_array()
		mut iter_2 := var_ordersby.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var__value := item_2.val
			mut var__key := item_2.key
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
			if rt.is_true(rt.identical(rt.new_string('site__in'), var__orderby))
				|| rt.is_true(rt.identical(rt.new_string('network__in'), var__orderby)) {
				var_orderby_array << var_parsed.clone()
				continue
			}
			var_orderby_array << var_parsed.str() + ' ' + this.parse_order(var__order.clone())
		}
		var_orderby = rt.call_function('implode', [rt.new_string(', '),
			rt.create_array_from_list(var_orderby_array)])
	} else {
		var_orderby = rt.new_string((rt.concat(rt.concat(rt.get_property(var_wpdb, 'blogs'),
			rt.new_string('.blog_id ')), var_order)).str())
	}
	mut var_number := rt.call_function('absint',
		[this.query_vars.array_get(rt.new_string('number'))])
	mut var_offset := rt.call_function('absint',
		[this.query_vars.array_get(rt.new_string('offset'))])
	mut var_limits := rt.new_string('')
	if !(!rt.is_true(var_number)) {
		if rt.is_true(var_offset) {
			var_limits = rt.new_string('LIMIT ' + var_offset.str() + ',' + var_number.str())
		} else {
			var_limits = rt.new_string('LIMIT ' + var_number.str())
		}
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('count'))) {
		mut var_fields := rt.new_string('COUNT(*)')
	} else {
		var_fields = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'blogs'),
			rt.new_string('.blog_id'))).str())
	}
	mut var_site_id := rt.call_function('absint', [this.query_vars.array_get(rt.new_string('ID'))])
	if !(!rt.is_true(var_site_id)) {
		this.sql_clauses.array_get_mut('where').array_set('ID', rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id = %d')),
			var_site_id.clone(),
		]))
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('site__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('site__in',
			rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('site__in'))])])).str() +
			' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('site__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('site__not_in',
			rt.concat(rt.get_property(var_wpdb, 'blogs'), rt.new_string('.blog_id NOT IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('site__not_in'))])])).str() +
			' )')
	}
	mut var_network_id := rt.call_function('absint', [
		this.query_vars.array_get(rt.new_string('network_id')),
	])
	if !(!rt.is_true(var_network_id)) {
		this.sql_clauses.array_get_mut('where').array_set('network_id', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('site_id = %d'), var_network_id.clone()]))
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('network__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('network__in',
			'site_id IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('network__in'))])])).str() +
			' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('network__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('network__not_in',
			'site_id NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('network__not_in'))])])).str() +
			' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('domain')))) {
		this.sql_clauses.array_get_mut('where').array_set('domain', rt.call_method(var_wpdb,
			'prepare',
			[rt.new_string('domain = %s'), this.query_vars.array_get(rt.new_string('domain'))]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('domain__in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__in',
			"domain IN ( '" + (rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('domain__in'))])])).str() +
			"' )")
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('domain__not_in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__not_in',
			"domain NOT IN ( '" + (rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('domain__not_in'))])])).str() +
			"' )")
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('path')))) {
		this.sql_clauses.array_get_mut('where').array_set('path', rt.call_method(var_wpdb,
			'prepare',
			[rt.new_string('path = %s'), this.query_vars.array_get(rt.new_string('path'))]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('path__in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__in',
			"path IN ( '" + (rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('path__in'))])])).str() +
			"' )")
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('path__not_in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__not_in',
			"path NOT IN ( '" + (rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('path__not_in'))])])).str() +
			"' )")
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('archived')).is_long()
		|| this.query_vars.array_get(rt.new_string('archived')).is_double()))
	{
		mut var_archived := rt.call_function('absint', [
			this.query_vars.array_get(rt.new_string('archived')),
		])
		this.sql_clauses.array_get_mut('where').array_set('archived', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('archived = %s '),
			rt.call_function('absint', [var_archived.clone()])]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('mature')).is_long()
		|| this.query_vars.array_get(rt.new_string('mature')).is_double()))
	{
		mut var_mature := rt.call_function('absint', [
			this.query_vars.array_get(rt.new_string('mature')),
		])
		this.sql_clauses.array_get_mut('where').array_set('mature', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('mature = %d '), var_mature.clone()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('spam')).is_long()
		|| this.query_vars.array_get(rt.new_string('spam')).is_double()))
	{
		mut var_spam := rt.call_function('absint',
			[this.query_vars.array_get(rt.new_string('spam'))])
		this.sql_clauses.array_get_mut('where').array_set('spam', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('spam = %d '), var_spam.clone()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('deleted')).is_long()
		|| this.query_vars.array_get(rt.new_string('deleted')).is_double()))
	{
		mut var_deleted := rt.call_function('absint', [
			this.query_vars.array_get(rt.new_string('deleted')),
		])
		this.sql_clauses.array_get_mut('where').array_set('deleted', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('deleted = %d '), var_deleted.clone()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('public')).is_long()
		|| this.query_vars.array_get(rt.new_string('public')).is_double()))
	{
		mut var_public := rt.call_function('absint', [
			this.query_vars.array_get(rt.new_string('public')),
		])
		this.sql_clauses.array_get_mut('where').array_set('public', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('public = %d '), var_public.clone()]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('lang_id')).is_long()
		|| this.query_vars.array_get(rt.new_string('lang_id')).is_double()))
	{
		mut var_lang_id := rt.call_function('absint', [
			this.query_vars.array_get(rt.new_string('lang_id')),
		])
		this.sql_clauses.array_get_mut('where').array_set('lang_id', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('lang_id = %d '), var_lang_id.clone()]))
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('lang__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('lang__in',
			'lang_id IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('lang__in'))])])).str() +
			' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('lang__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('lang__not_in',
			'lang_id NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('lang__not_in'))])])).str() +
			' )')
	}
	if rt.is_true(rt.new_int(this.query_vars.array_get(rt.new_string('search')).to_string().len)) {
		mut var_search_columns := rt.new_array()
		if rt.is_true(this.query_vars.array_get(rt.new_string('search_columns'))) {
			var_search_columns = rt.call_function('array_intersect', [
				this.query_vars.array_get(rt.new_string('search_columns')),
				rt.create_array([rt.ArrayItem{ key: none, val: 'domain' },
					rt.ArrayItem{ key: none, val: 'path' }]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_search_columns)))) {
			var_search_columns = rt.create_array([
				rt.ArrayItem{ key: none, val: 'domain' },
				rt.ArrayItem{ key: none, val: 'path' },
			])
		}
		var_search_columns = rt.call_function('apply_filters', [
			rt.new_string('site_search_columns'),
			var_search_columns.clone(),
			this.query_vars.array_get(rt.new_string('search')),
			rt.new_object('WP_Site_Query', []string{}, &this),
		])
		this.sql_clauses.array_get_mut('where').array_set('search', this.get_search_sql(this.query_vars.array_get(rt.new_string('search')),
			var_search_columns.clone()))
	}
	mut var_date_query := this.query_vars.array_get(rt.new_string('date_query'))
	if !(!rt.is_true(var_date_query)) && var_date_query.clone().is_array() {
		this.date_query = create_wp_date_query(var_date_query.clone(), rt.new_string('registered'))
		this.sql_clauses.array_get_mut('where').array_set('date_query', rt.call_function('preg_replace', [
			rt.new_string('/^\\s*AND\\s*/'),
			rt.new_string(''),
			rt.call_method(this.date_query, 'get_sql', []rt.PhpVal{}),
		]))
	}
	mut var_join := rt.new_string('')
	mut var_groupby := rt.new_string('')
	if !(!rt.is_true(this.meta_query_clauses)) {
		var_join = rt.concat(var_join, this.meta_query_clauses.array_get(rt.new_string('join')))
		this.sql_clauses.array_get_mut('where').array_set('meta_query', rt.call_function('preg_replace', [
			rt.new_string('/^\\s*AND\\s*/'),
			rt.new_string(''),
			this.meta_query_clauses.array_get(rt.new_string('where')),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('count')))))) {
			var_groupby = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'blogs'),
				rt.new_string('.blog_id'))).str())
		}
	}
	mut var_where := rt.call_function('implode', [rt.new_string(' AND '),
		this.sql_clauses.array_get(rt.new_string('where'))])
	mut var_pieces := ['fields', 'join', 'where', 'orderby', 'limits', 'groupby']
	mut var_clauses := rt.call_function('apply_filters_ref_array', [
		rt.new_string('sites_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('compact', [
				rt.create_array_from_list(var_pieces),
			]) },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Query', []string{}, &this) },
		]),
	])
	var_fields = if !(var_clauses.array_get(rt.new_string('fields'))).is_null() {
		var_clauses.array_get(rt.new_string('fields'))
	} else {
		rt.new_string('')
	}
	var_join = if !(var_clauses.array_get(rt.new_string('join'))).is_null() {
		var_clauses.array_get(rt.new_string('join'))
	} else {
		rt.new_string('')
	}
	var_where = if !(var_clauses.array_get(rt.new_string('where'))).is_null() {
		var_clauses.array_get(rt.new_string('where'))
	} else {
		rt.new_string('')
	}
	var_orderby = if !(var_clauses.array_get(rt.new_string('orderby'))).is_null() {
		var_clauses.array_get(rt.new_string('orderby'))
	} else {
		rt.new_string('')
	}
	var_limits = if !(var_clauses.array_get(rt.new_string('limits'))).is_null() {
		var_clauses.array_get(rt.new_string('limits'))
	} else {
		rt.new_string('')
	}
	var_groupby = if !(var_clauses.array_get(rt.new_string('groupby'))).is_null() {
		var_clauses.array_get(rt.new_string('groupby'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(var_where) {
		var_where = rt.new_string('WHERE ' + var_where.str())
	}
	if rt.is_true(var_groupby) {
		var_groupby = rt.new_string('GROUP BY ' + var_groupby.str())
	}
	if rt.is_true(var_orderby) {
		var_orderby = rt.new_string('ORDER BY ${var_orderby.to_string()}')
	}
	mut var_found_rows := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('no_found_rows')))))) {
		var_found_rows = rt.new_string('SQL_CALC_FOUND_ROWS')
	}
	this.sql_clauses.array_set('select',
		'SELECT ${var_found_rows.to_string()} ${var_fields.to_string()}')
	this.sql_clauses.array_set('from', rt.concat(rt.concat(rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb,
		'blogs')), rt.new_string(' ')), var_join))
	this.sql_clauses.array_set('groupby', var_groupby.clone())
	this.sql_clauses.array_set('orderby', var_orderby.clone())
	this.sql_clauses.array_set('limits', var_limits.clone())
	this.request = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.sql_clauses.array_get(rt.new_string('select')),
		rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get(rt.new_string('from'))),
		rt.new_string('\n\t\t\t ')), var_where), rt.new_string('\n\t\t\t ')),
		this.sql_clauses.array_get(rt.new_string('groupby'))), rt.new_string('\n\t\t\t ')),
		this.sql_clauses.array_get(rt.new_string('orderby'))), rt.new_string('\n\t\t\t ')),
		this.sql_clauses.array_get(rt.new_string('limits')))
	if rt.is_true(this.query_vars.array_get(rt.new_string('count'))) {
		return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.new_string(this.request),
		])).to_i64())
	}
	mut var_site_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.new_string(this.request)])
	return (rt.call_function('array_map', [rt.new_string('intval'),
		var_site_ids.clone()])).to_i64()
}

fn (mut this Class_WP_Site_Query) set_found_sites() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(this.query_vars.array_get(rt.new_string('number')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('no_found_rows')))))) {
		mut var_found_sites_query := rt.call_function('apply_filters', [
			rt.new_string('found_sites_query'),
			rt.new_string('SELECT FOUND_ROWS()'),
			rt.new_object('WP_Site_Query', []string{}, &this),
		])
		this.found_sites = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			var_found_sites_query.clone()])).to_i64())
	}
}

fn (mut this Class_WP_Site_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_function('str_contains', [var_search.clone(),
		rt.new_string('*')]))
	{
		mut var_like := rt.new_string('%' +
			(rt.call_function('implode', [rt.new_string('%'), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_wpdb
		}, rt.ArrayItem{ key: none, val: 'esc_like' }]), rt.call_function('explode', [rt.new_string('*'), var_search.clone()])])])).str() +
			'%')
	} else {
		var_like = rt.new_string('%' +
			(rt.call_method(var_wpdb, 'esc_like', [var_search.clone()])).str() + '%')
	}
	mut var_searches := rt.new_array()
	mut iter_3 := var_columns.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_column := item_3.val
		var_searches << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('${var_column.to_string()} LIKE %s'),
			var_like.clone(),
		])
	}
	return '(' +
		(rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_searches)])).str() +
		')'
}

fn (mut this Class_WP_Site_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_orderby_mutated := var_orderby
	mut var_parsed := rt.new_bool(false)
	mut switch_val_1 := var_orderby_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('site__in'))) {
		mut var_site__in := rt.call_function('implode', [rt.new_string(','),
			rt.call_function('array_map', [rt.new_string('absint'),
				this.query_vars.array_get(rt.new_string('site__in'))])])
		var_parsed = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('FIELD( '), rt.get_property(var_wpdb,
			'blogs')), rt.new_string('.blog_id, ')), var_site__in), rt.new_string(' )'))).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('network__in'))) {
		mut var_network__in := rt.call_function('implode', [rt.new_string(','),
			rt.call_function('array_map', [rt.new_string('absint'),
				this.query_vars.array_get(rt.new_string('network__in'))])])
		var_parsed = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('FIELD( '), rt.get_property(var_wpdb,
			'blogs')), rt.new_string('.site_id, ')), var_network__in), rt.new_string(' )'))).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('domain')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('last_updated')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('path')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('registered')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('deleted')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('spam')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('mature')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('archived')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('public'))) {
		var_parsed = var_orderby_mutated.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('network_id'))) {
		var_parsed = rt.new_string('site_id')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('domain_length'))) {
		var_parsed = rt.new_string('CHAR_LENGTH(domain)')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('path_length'))) {
		var_parsed = rt.new_string('CHAR_LENGTH(path)')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		var_parsed = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'blogs'),
			rt.new_string('.blog_id'))).str())
	}
	if !(!rt.is_true(var_parsed)) || !rt.is_true(this.meta_query_clauses) {
		return var_parsed.clone()
	}
	mut var_meta_clauses := rt.call_method(this.meta_query, 'get_clauses', []rt.PhpVal{})
	if !rt.is_true(var_meta_clauses) {
		return var_parsed.clone()
	}
	mut var_primary_meta_query := rt.call_function('reset', [
		var_meta_clauses.clone()])
	if !(!rt.is_true(var_primary_meta_query.array_get(rt.new_string('key'))))
		&& rt.is_true(rt.identical(var_primary_meta_query.array_get(rt.new_string('key')), var_orderby_mutated)) {
		var_orderby_mutated = rt.new_string('meta_value')
	}
	mut switch_val_2 := var_orderby_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('meta_value'))) {
		if !(!rt.is_true(var_primary_meta_query.array_get(rt.new_string('type')))) {
			var_parsed = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST('),
				var_primary_meta_query.array_get(rt.new_string('alias'))),
				rt.new_string('.meta_value AS ')),
				var_primary_meta_query.array_get(rt.new_string('cast'))), rt.new_string(')'))).str())
		} else {
			var_parsed = rt.new_string((rt.concat(var_primary_meta_query.array_get(rt.new_string('alias')),
				rt.new_string('.meta_value'))).str())
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('meta_value_num'))) {
		var_parsed = rt.new_string((rt.concat(var_primary_meta_query.array_get(rt.new_string('alias')),
			rt.new_string('.meta_value+0'))).str())
	} else {
		if var_meta_clauses.array_isset(var_orderby_mutated) {
			mut var_meta_clause := var_meta_clauses.array_get(var_orderby_mutated)
			var_parsed = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST('),
				var_meta_clause.array_get(rt.new_string('alias'))),
				rt.new_string('.meta_value AS ')), var_meta_clause.array_get(rt.new_string('cast'))),
				rt.new_string(')'))).str())
		}
	}
	return var_parsed.clone()
}

fn (mut this Class_WP_Site_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	if !(var_order_mutated.clone().is_string()) || !rt.is_true(var_order_mutated) {
		return 'ASC'
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

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_WP_Date_Query {
	rt.PhpObjectBase
}

fn create_wp_site_query(query string) &Class_WP_Site_Query {
	mut obj := &Class_WP_Site_Query{
		PhpObjectBase:      rt.PhpObjectBase{}
		request:            ''
		sql_clauses:        rt.new_array()
		meta_query:         rt.new_bool(false)
		meta_query_clauses: rt.new_null()
		date_query:         rt.new_bool(false)
		query_vars:         rt.new_null()
		query_var_defaults: rt.new_null()
		sites:              rt.new_null()
		found_sites:        rt.new_int(0)
		max_num_pages:      rt.new_int(0)
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
			return rt.new_int(this.get_sites())
		}
		'get_site_ids' {
			return rt.new_int(this.get_site_ids())
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
		else {
			return none
		}
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
		'request' {
			this.request = val.str()
			return true
		}
		'sql_clauses' {
			this.sql_clauses = val
			return true
		}
		'meta_query' {
			this.meta_query = val
			return true
		}
		'meta_query_clauses' {
			this.meta_query_clauses = val
			return true
		}
		'date_query' {
			this.date_query = val
			return true
		}
		'query_vars' {
			this.query_vars = val
			return true
		}
		'query_var_defaults' {
			this.query_var_defaults = val
			return true
		}
		'sites' {
			this.sites = val
			return true
		}
		'found_sites' {
			this.found_sites = val
			return true
		}
		'max_num_pages' {
			this.max_num_pages = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
