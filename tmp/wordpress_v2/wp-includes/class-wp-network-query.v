import rt
import crypto.md5

struct Class_WP_Network_Query {
	rt.PhpObjectBase
pub mut:
	request            string
	sql_clauses        rt.PhpVal = rt.new_array()
	query_vars         rt.PhpVal = rt.new_null()
	query_var_defaults rt.PhpVal = rt.new_null()
	networks           rt.PhpVal = rt.new_null()
	found_networks     rt.PhpVal = rt.new_int(0)
	max_num_pages      rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Network_Query) construct(query string) {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([
		rt.ArrayItem{ key: 'network__in', val: '' },
		rt.ArrayItem{ key: 'network__not_in', val: '' },
		rt.ArrayItem{ key: 'count', val: false },
		rt.ArrayItem{ key: 'fields', val: '' },
		rt.ArrayItem{ key: 'number', val: '' },
		rt.ArrayItem{ key: 'offset', val: '' },
		rt.ArrayItem{ key: 'no_found_rows', val: true },
		rt.ArrayItem{ key: 'orderby', val: 'id' },
		rt.ArrayItem{ key: 'order', val: 'ASC' },
		rt.ArrayItem{ key: 'domain', val: '' },
		rt.ArrayItem{ key: 'domain__in', val: '' },
		rt.ArrayItem{ key: 'domain__not_in', val: '' },
		rt.ArrayItem{ key: 'path', val: '' },
		rt.ArrayItem{ key: 'path__in', val: '' },
		rt.ArrayItem{ key: 'path__not_in', val: '' },
		rt.ArrayItem{ key: 'search', val: '' },
		rt.ArrayItem{ key: 'update_network_cache', val: true },
	])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Network_Query) parse_query(query string) {
	mut query_mutated := query
	if query_mutated == '' {
		query_mutated = (this.query_vars).str()
	}
	this.query_vars = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).clone(),
		this.query_var_defaults])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_network_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) },
		])])
}

fn (mut this Class_WP_Network_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.clone()])
	return rt.new_int(this.get_networks())
}

fn (mut this Class_WP_Network_Query) get_networks() i64 {
	this.parse_query('')
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_networks'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) },
		])])
	mut var_network_data := rt.new_null()
	var_network_data = rt.call_function('apply_filters_ref_array', [
		rt.new_string('networks_pre_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_network_data },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) }]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_network_data)))) {
		if var_network_data.clone().is_array()
			&& rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('count')))))) {
			this.networks = var_network_data.clone()
		}
		return var_network_data.to_i64()
	}
	mut var__args := rt.call_function('wp_array_slice_assoc', [this.query_vars,
		rt.func_array_keys(this.query_var_defaults)])
	var__args.array_unset(rt.new_string('fields'))
	var__args.array_unset(rt.new_string('update_network_cache'))
	mut var_key := rt.new_string(md5.hexhash(rt.call_function('serialize', [
		var__args.clone()]).to_string()))
	mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [
		rt.new_string('networks'),
	])
	mut var_cache_key := rt.new_string('get_network_ids:${var_key.to_string()}')
	mut var_cache_value := rt.call_function('wp_cache_get_salted', [
		var_cache_key.clone(), rt.new_string('network-queries'),
		var_last_changed.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)) {
		mut var_network_ids := rt.new_int(this.get_network_ids())
		if rt.is_true(var_network_ids) {
			this.set_found_networks()
		}
		var_cache_value = rt.create_array([
			rt.ArrayItem{ key: 'network_ids', val: var_network_ids },
			rt.ArrayItem{ key: 'found_networks', val: this.found_networks },
		])
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(),
			var_cache_value.clone(), rt.new_string('network-queries'),
			var_last_changed.clone()])
	} else {
		var_network_ids = var_cache_value.array_get(rt.new_string('network_ids'))
		this.found_networks = var_cache_value.array_get(rt.new_string('found_networks'))
	}
	if rt.is_true(this.found_networks)
		&& rt.is_true(this.query_vars.array_get(rt.new_string('number'))) {
		this.max_num_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(this.found_networks, this.query_vars.array_get(rt.new_string('number'))),
		])).to_i64())
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('count'))) {
		return rt.new_int(var_network_ids.to_i64())
	}
	var_network_ids = rt.call_function('array_map', [rt.new_string('intval'),
		var_network_ids.clone()])
	if rt.is_true(rt.identical(rt.new_string('ids'),
		this.query_vars.array_get(rt.new_string('fields'))))
	{
		this.networks = var_network_ids.clone()
		return (this.networks).to_i64()
	}
	if rt.is_true(this.query_vars.array_get(rt.new_string('update_network_cache'))) {
		rt.call_function('_prime_network_caches', [var_network_ids.clone()])
	}
	mut var__networks := rt.new_array()
	mut iter_1 := var_network_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_network_id := item_1.val
		mut var__network := rt.call_function('get_network', [
			var_network_id.clone()])
		if rt.is_true(var__network) {
			var__networks.array_push(var__network.clone())
		}
	}
	var__networks = rt.call_function('apply_filters_ref_array', [
		rt.new_string('the_networks'),
		rt.create_array([rt.ArrayItem{ key: none, val: var__networks },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) }]),
	])
	this.networks = rt.call_function('array_map', [rt.new_string('get_network'),
		var__networks.clone()])
	return (this.networks).to_i64()
}

fn (mut this Class_WP_Network_Query) get_network_ids() i64 {
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
			if rt.is_true(rt.identical(rt.new_string('network__in'), var__orderby)) {
				var_orderby_array << var_parsed.clone()
				continue
			}
			var_orderby_array << var_parsed.str() + ' ' + this.parse_order(var__order.clone())
		}
		var_orderby = rt.call_function('implode', [rt.new_string(', '),
			rt.create_array_from_list(var_orderby_array)])
	} else {
		var_orderby = rt.new_string((rt.concat(rt.concat(rt.get_property(var_wpdb, 'site'),
			rt.new_string('.id ')), var_order)).str())
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
		var_fields = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'site'),
			rt.new_string('.id'))).str())
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('network__in')))) {
		this.sql_clauses.array_get_mut('where').array_set('network__in',
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.id IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('network__in'))])])).str() +
			' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('network__not_in')))) {
		this.sql_clauses.array_get_mut('where').array_set('network__not_in',
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.id NOT IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get(rt.new_string('network__not_in'))])])).str() +
			' )')
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('domain')))) {
		this.sql_clauses.array_get_mut('where').array_set('domain', rt.call_method(var_wpdb,
			'prepare', [
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.domain = %s')),
			this.query_vars.array_get(rt.new_string('domain')),
		]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('domain__in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__in',
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string(".domain IN ( '")) +
			(rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('domain__in'))])])).str() +
			"' )")
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('domain__not_in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__not_in',
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string(".domain NOT IN ( '")) +
			(rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('domain__not_in'))])])).str() +
			"' )")
	}
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('path')))) {
		this.sql_clauses.array_get_mut('where').array_set('path', rt.call_method(var_wpdb,
			'prepare', [
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.path = %s')),
			this.query_vars.array_get(rt.new_string('path')),
		]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('path__in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__in',
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string(".path IN ( '")) +
			(rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('path__in'))])])).str() +
			"' )")
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get(rt.new_string('path__not_in')).is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__not_in',
			rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string(".path NOT IN ( '")) +
			(rt.call_function('implode', [rt.new_string("', '"), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get(rt.new_string('path__not_in'))])])).str() +
			"' )")
	}
	if rt.is_true(rt.new_int(this.query_vars.array_get(rt.new_string('search')).to_string().len)) {
		this.sql_clauses.array_get_mut('where').array_set('search', this.get_search_sql(this.query_vars.array_get(rt.new_string('search')), rt.create_array([
			rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'site'),
				rt.new_string('.domain')) },
			rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'site'),
				rt.new_string('.path')) },
		])))
	}
	mut var_join := rt.new_string('')
	mut var_where := rt.call_function('implode', [rt.new_string(' AND '),
		this.sql_clauses.array_get(rt.new_string('where'))])
	mut var_groupby := rt.new_string('')
	mut var_pieces := ['fields', 'join', 'where', 'orderby', 'limits', 'groupby']
	mut var_clauses := rt.call_function('apply_filters_ref_array', [
		rt.new_string('networks_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('compact', [
				rt.create_array_from_list(var_pieces),
			]) },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) },
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
		'site')), rt.new_string(' ')), var_join))
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
	mut var_network_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.new_string(this.request),
	])
	return (rt.call_function('array_map', [rt.new_string('intval'),
		var_network_ids.clone()])).to_i64()
}

fn (mut this Class_WP_Network_Query) set_found_networks() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(this.query_vars.array_get(rt.new_string('number')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get(rt.new_string('no_found_rows')))))) {
		mut var_found_networks_query := rt.call_function('apply_filters', [
			rt.new_string('found_networks_query'),
			rt.new_string('SELECT FOUND_ROWS()'),
			rt.new_object('WP_Network_Query', []string{}, &this),
		])
		this.found_networks = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			var_found_networks_query.clone(),
		])).to_i64())
	}
}

fn (mut this Class_WP_Network_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_like := rt.new_string('%' +
		(rt.call_method(var_wpdb, 'esc_like', [var_search.clone()])).str() + '%')
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

fn (mut this Class_WP_Network_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_orderby_mutated := var_orderby
	mut var_allowed_keys := ['id', 'domain', 'path']
	mut var_parsed := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('network__in'), var_orderby_mutated)) {
		mut var_network__in := rt.call_function('implode', [rt.new_string(','),
			rt.call_function('array_map', [rt.new_string('absint'),
				this.query_vars.array_get(rt.new_string('network__in'))])])
		var_parsed = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('FIELD( '), rt.get_property(var_wpdb,
			'site')), rt.new_string('.id, ')), var_network__in), rt.new_string(' )'))).str())
	} else if rt.is_true(rt.identical(rt.new_string('domain_length'), var_orderby_mutated))
		|| rt.is_true(rt.identical(rt.new_string('path_length'), var_orderby_mutated)) {
		mut var_field := rt.call_function('substr', [var_orderby_mutated.clone(),
			rt.new_int(0), rt.new_int(-7)])
		var_parsed = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CHAR_LENGTH('), rt.get_property(var_wpdb,
			'site')), rt.new_string('.')), var_field), rt.new_string(')'))).str())
	} else if rt.is_true(rt.call_function('in_array', [var_orderby_mutated.clone(),
		rt.create_array_from_list(var_allowed_keys), rt.new_bool(true)]))
	{
		var_parsed = rt.new_string((rt.concat(rt.concat(rt.get_property(var_wpdb, 'site'),
			rt.new_string('.')), var_orderby_mutated)).str())
	}
	return var_parsed.clone()
}

fn (mut this Class_WP_Network_Query) parse_order(var_order rt.PhpVal) string {
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

fn create_wp_network_query(query string) &Class_WP_Network_Query {
	mut obj := &Class_WP_Network_Query{
		PhpObjectBase:      rt.PhpObjectBase{}
		request:            ''
		sql_clauses:        rt.new_array()
		query_vars:         rt.new_null()
		query_var_defaults: rt.new_null()
		networks:           rt.new_null()
		found_networks:     rt.new_int(0)
		max_num_pages:      rt.new_int(0)
	}
	obj.construct(query)
	return obj
}

fn (mut this Class_WP_Network_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_networks' {
			return rt.new_int(this.get_networks())
		}
		'get_network_ids' {
			return rt.new_int(this.get_network_ids())
		}
		'set_found_networks' {
			this.set_found_networks()
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

fn (this &Class_WP_Network_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request' { return rt.new_string(this.request) }
		'sql_clauses' { return this.sql_clauses }
		'query_vars' { return this.query_vars }
		'query_var_defaults' { return this.query_var_defaults }
		'networks' { return this.networks }
		'found_networks' { return this.found_networks }
		'max_num_pages' { return this.max_num_pages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Network_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'request' {
			this.request = val.str()
			return true
		}
		'sql_clauses' {
			this.sql_clauses = val
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
		'networks' {
			this.networks = val
			return true
		}
		'found_networks' {
			this.found_networks = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
