import rt
import crypto.md5

struct Class_WP_Network_Query {
	rt.PhpObjectBase
pub mut:
		request string
		sql_clauses rt.PhpVal = rt.new_array()
		query_vars rt.PhpVal = rt.new_null()
		query_var_defaults rt.PhpVal = rt.new_null()
		networks rt.PhpVal = rt.new_null()
		found_networks rt.PhpVal = rt.new_int(0)
		max_num_pages rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Network_Query) construct(query string)  {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([rt.ArrayItem{ key: 'network__in', val: '' }, rt.ArrayItem{ key: 'network__not_in', val: '' }, rt.ArrayItem{ key: 'count', val: false }, rt.ArrayItem{ key: 'fields', val: '' }, rt.ArrayItem{ key: 'number', val: '' }, rt.ArrayItem{ key: 'offset', val: '' }, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'domain', val: '' }, rt.ArrayItem{ key: 'domain__in', val: '' }, rt.ArrayItem{ key: 'domain__not_in', val: '' }, rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'path__in', val: '' }, rt.ArrayItem{ key: 'path__not_in', val: '' }, rt.ArrayItem{ key: 'search', val: '' }, rt.ArrayItem{ key: 'update_network_cache', val: true }])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Network_Query) parse_query(query string)  {
	mut query_mutated := query
	if query_mutated == '' {
		query_mutated = (this.query_vars).str()
	}
	this.query_vars = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).dup(), this.query_var_defaults])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_network_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) }])])
}

fn (mut this Class_WP_Network_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.dup()])
	return this.get_networks()
}

fn (mut this Class_WP_Network_Query) get_networks() rt.PhpVal {
	this.parse_query('')
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_networks'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) }])])
	mut var_network_data := rt.new_null()
	var_network_data = rt.call_function('apply_filters_ref_array', [rt.new_string('networks_pre_query'), rt.create_array([rt.ArrayItem{ key: none, val: var_network_data }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) }])])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_network_data.dup().is_array())) && rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get('count'))))))) {
			this.networks = var_network_data.dup()
		}
		return var_network_data.dup()
	}
	mut var__args := rt.call_function('wp_array_slice_assoc', [this.query_vars, rt.func_array_keys(this.query_var_defaults)])
	var__args.array_unset(rt.new_string('fields'))
	var__args.array_unset(rt.new_string('update_network_cache'))
	mut var_key := rt.new_string(rt.new_string(md5.hexhash(rt.call_function('serialize', [var__args.dup()]).to_string())))
	mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [rt.new_string('networks')])
	mut var_cache_key := rt.new_string(rt.new_string("get_network_ids:${var_key.to_string()}"))
	mut var_cache_value := rt.call_function('wp_cache_get_salted', [var_cache_key.dup(), rt.new_string('network-queries'), var_last_changed.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)) {
		mut var_network_ids := this.get_network_ids()
		if rt.is_true(var_network_ids) {
			this.set_found_networks()
		}
		var_cache_value = rt.create_array([rt.ArrayItem{ key: 'network_ids', val: var_network_ids }, rt.ArrayItem{ key: 'found_networks', val: this.found_networks }])
		rt.call_function('wp_cache_set_salted', [var_cache_key.dup(), var_cache_value.dup(), rt.new_string('network-queries'), var_last_changed.dup()])
	} else {
		var_network_ids = var_cache_value.array_get('network_ids')
		this.found_networks = var_cache_value.array_get('found_networks')
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.found_networks) && rt.is_true(this.query_vars.array_get('number')))) {
		this.max_num_pages = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(this.query_vars.array_get('count')) {
		return // unsupported expression: Expr_Cast_Int
	}
	var_network_ids = rt.call_function('array_map', [rt.new_string('intval'), var_network_ids.dup()])
	if rt.is_true(rt.identical(rt.new_string('ids'), this.query_vars.array_get('fields'))) {
		this.networks = var_network_ids.dup()
		return this.networks
	}
	if rt.is_true(this.query_vars.array_get('update_network_cache')) {
		rt.call_function('_prime_network_caches', [var_network_ids.dup()])
	}
	mut var__networks := rt.new_array()
	{
		mut iter_1 := var_network_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_network_id := item_1.val
			mut var__network := rt.call_function('get_network', [var_network_id.dup()])
			if rt.is_true(var__network) {
				var__networks.array_push(var__network.dup())
			}
		}
	}
	var__networks = rt.call_function('apply_filters_ref_array', [rt.new_string('the_networks'), rt.create_array([rt.ArrayItem{ key: none, val: var__networks }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) }])])
	this.networks = rt.call_function('array_map', [rt.new_string('get_network'), var__networks.dup()])
	return this.networks
}

fn (mut this Class_WP_Network_Query) get_network_ids() rt.PhpVal {
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
				if rt.is_true(rt.identical(rt.new_string('network__in'), var__orderby)) {
					var_orderby_array << var_parsed.dup()
					continue
				}
				var_orderby_array << (var_parsed).str() + ' ' + this.parse_order(var__order.dup())
			}
		}
		var_orderby = rt.call_function('implode', [rt.new_string(', '), var_orderby_array.dup()])
	} else {
		var_orderby = rt.new_string(rt.concat(rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.id ')), var_order))
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
		var_fields = rt.new_string(rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.id')))
	}
	if !(!rt.is_true(this.query_vars.array_get('network__in'))) {
		this.sql_clauses.array_get_mut('where').array_set('network__in', rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.id IN ( ')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get('network__in')])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get('network__not_in'))) {
		this.sql_clauses.array_get_mut('where').array_set('network__not_in', rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.id NOT IN ( ')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [this.query_vars.array_get('network__not_in')])])).str() + ' )')
	}
	if !(!rt.is_true(this.query_vars.array_get('domain'))) {
		this.sql_clauses.array_get_mut('where').array_set('domain', rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.domain = %s')), this.query_vars.array_get('domain')]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('domain__in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__in', rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.domain IN ( \'')) + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('domain__in')])])).str() + '\' )')
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('domain__not_in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('domain__not_in', rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.domain NOT IN ( \'')) + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('domain__not_in')])])).str() + '\' )')
	}
	if !(!rt.is_true(this.query_vars.array_get('path'))) {
		this.sql_clauses.array_get_mut('where').array_set('path', rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.path = %s')), this.query_vars.array_get('path')]))
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('path__in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__in', rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.path IN ( \'')) + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('path__in')])])).str() + '\' )')
	}
	if rt.is_true(rt.new_bool(this.query_vars.array_get('path__not_in').is_array())) {
		this.sql_clauses.array_get_mut('where').array_set('path__not_in', rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.path NOT IN ( \'')) + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_method(var_wpdb, '_escape', [this.query_vars.array_get('path__not_in')])])).str() + '\' )')
	}
	if rt.is_true(rt.new_int(this.query_vars.array_get('search').to_string().len)) {
		this.sql_clauses.array_get_mut('where').array_set('search', this.get_search_sql(this.query_vars.array_get('search'), rt.create_array([rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.domain')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'site'), rt.new_string('.path')) }])))
	}
	mut var_join := rt.new_string(rt.new_string(''))
	mut var_where := rt.call_function('implode', [rt.new_string(' AND '), this.sql_clauses.array_get('where')])
	mut var_groupby := rt.new_string(rt.new_string(''))
	mut var_pieces := ['fields', 'join', 'where', 'orderby', 'limits', 'groupby']
	mut var_clauses := rt.call_function('apply_filters_ref_array', [rt.new_string('networks_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('compact', [var_pieces.dup()]) }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Network_Query', []string{}, &this) }])])
	var_fields = if !(var_clauses.array_get('fields')).is_null() { var_clauses.array_get('fields') } else { rt.new_string('') }
	var_join = if !(var_clauses.array_get('join')).is_null() { var_clauses.array_get('join') } else { rt.new_string('') }
	var_where = if !(var_clauses.array_get('where')).is_null() { var_clauses.array_get('where') } else { rt.new_string('') }
	var_orderby = if !(var_clauses.array_get('orderby')).is_null() { var_clauses.array_get('orderby') } else { rt.new_string('') }
	var_limits = if !(var_clauses.array_get('limits')).is_null() { var_clauses.array_get('limits') } else { rt.new_string('') }
	var_groupby = if !(var_clauses.array_get('groupby')).is_null() { var_clauses.array_get('groupby') } else { rt.new_string('') }
	if rt.is_true(var_where) {
		var_where = rt.new_string('WHERE ' + (var_where).str())
	}
	if rt.is_true(var_groupby) {
		var_groupby = rt.new_string('GROUP BY ' + (var_groupby).str())
	}
	if rt.is_true(var_orderby) {
		var_orderby = rt.new_string(rt.new_string("ORDER BY ${var_orderby.to_string()}"))
	}
	mut var_found_rows := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(this.query_vars.array_get('no_found_rows'))))) {
		var_found_rows = rt.new_string(rt.new_string('SQL_CALC_FOUND_ROWS'))
	}
	this.sql_clauses.array_set('select', "SELECT ${var_found_rows.to_string()} ${var_fields.to_string()}")
	this.sql_clauses.array_set('from', rt.concat(rt.concat(rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb, 'site')), rt.new_string(' ')), var_join))
	this.sql_clauses.array_set('groupby', var_groupby.dup())
	this.sql_clauses.array_set('orderby', var_orderby.dup())
	this.sql_clauses.array_set('limits', var_limits.dup())
	this.request = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.sql_clauses.array_get('select'), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get('from')), rt.new_string('\n\t\t\t ')), var_where), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get('groupby')), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get('orderby')), rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get('limits'))
	if rt.is_true(this.query_vars.array_get('count')) {
		return // unsupported expression: Expr_Cast_Int
	}
	mut var_network_ids := rt.call_method(var_wpdb, 'get_col', [this.request])
	return rt.call_function('array_map', [rt.new_string('intval'), var_network_ids.dup()])
}

fn (mut this Class_WP_Network_Query) set_found_networks()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true() {
	}
}

fn (mut this Class_WP_Network_Query) get_search_sql(var_search rt.PhpVal, var_columns rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
}

fn (mut this Class_WP_Network_Query) parse_orderby(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_orderby_mutated := var_orderby
}

fn (mut this Class_WP_Network_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	return ''
}

fn create_wp_network_query(query string) &Class_WP_Network_Query {
	mut obj := &Class_WP_Network_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		request: ''
		sql_clauses: rt.new_array()
		query_vars: rt.new_null()
		query_var_defaults: rt.new_null()
		networks: rt.new_null()
		found_networks: rt.new_int(0)
		max_num_pages: rt.new_int(0)
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
			return this.get_networks()
		}
		'get_network_ids' {
			return this.get_network_ids()
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
		else { return none }
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
		'request' { this.request = (val).str(); return true }
		'sql_clauses' { this.sql_clauses = val; return true }
		'query_vars' { this.query_vars = val; return true }
		'query_var_defaults' { this.query_var_defaults = val; return true }
		'networks' { this.networks = val; return true }
		'found_networks' { this.found_networks = val; return true }
		'max_num_pages' { this.max_num_pages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_network_query_php() {
}
