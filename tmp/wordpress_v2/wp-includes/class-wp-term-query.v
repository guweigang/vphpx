import rt
import crypto.md5

struct Class_WP_Term_Query {
	rt.PhpObjectBase
pub mut:
	request            string
	meta_query         rt.PhpVal = rt.new_bool(false)
	meta_query_clauses rt.PhpVal = rt.new_null()
	sql_clauses        rt.PhpVal = rt.new_array()
	query_vars         rt.PhpVal = rt.new_null()
	query_var_defaults rt.PhpVal = rt.new_null()
	terms              rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Term_Query) construct(query string) {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: rt.new_null() },
		rt.ArrayItem{ key: 'object_ids', val: rt.new_null() },
		rt.ArrayItem{ key: 'orderby', val: 'name' },
		rt.ArrayItem{ key: 'order', val: 'ASC' },
		rt.ArrayItem{ key: 'hide_empty', val: true },
		rt.ArrayItem{ key: 'include', val: rt.new_array() },
		rt.ArrayItem{ key: 'exclude', val: rt.new_array() },
		rt.ArrayItem{ key: 'exclude_tree', val: rt.new_array() },
		rt.ArrayItem{ key: 'number', val: '' },
		rt.ArrayItem{ key: 'offset', val: '' },
		rt.ArrayItem{ key: 'fields', val: 'all' },
		rt.ArrayItem{ key: 'name', val: '' },
		rt.ArrayItem{ key: 'slug', val: '' },
		rt.ArrayItem{ key: 'term_taxonomy_id', val: '' },
		rt.ArrayItem{ key: 'hierarchical', val: true },
		rt.ArrayItem{ key: 'search', val: '' },
		rt.ArrayItem{ key: 'name__like', val: '' },
		rt.ArrayItem{ key: 'description__like', val: '' },
		rt.ArrayItem{ key: 'pad_counts', val: false },
		rt.ArrayItem{ key: 'get', val: '' },
		rt.ArrayItem{ key: 'child_of', val: 0 },
		rt.ArrayItem{ key: 'parent', val: '' },
		rt.ArrayItem{ key: 'childless', val: false },
		rt.ArrayItem{ key: 'cache_domain', val: 'core' },
		rt.ArrayItem{ key: 'cache_results', val: true },
		rt.ArrayItem{ key: 'update_term_meta_cache', val: true },
		rt.ArrayItem{ key: 'meta_query', val: '' },
		rt.ArrayItem{ key: 'meta_key', val: '' },
		rt.ArrayItem{ key: 'meta_value', val: '' },
		rt.ArrayItem{ key: 'meta_type', val: '' },
		rt.ArrayItem{ key: 'meta_compare', val: '' },
	])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Term_Query) parse_query(query string) {
	mut query_mutated := query
	if query_mutated == '' {
		query_mutated = (this.query_vars).str()
	}
	mut var_taxonomies := if rt.new_string(query_mutated).array_isset(rt.new_string('taxonomy')) {
		rt.cast_array(rt.new_string(query_mutated).array_get(rt.new_string('taxonomy')))
	} else {
		rt.new_null()
	}
	this.query_var_defaults = rt.call_function('apply_filters', [
		rt.new_string('get_terms_defaults'),
		this.query_var_defaults,
		var_taxonomies.clone(),
	])
	query_mutated = (rt.call_function('wp_parse_args', [rt.new_string(query_mutated).clone(),
		this.query_var_defaults])).str()
	rt.new_string(query_mutated).array_set('number', rt.call_function('absint', [
		rt.new_string(query_mutated).array_get(rt.new_string('number')),
	]))
	rt.new_string(query_mutated).array_set('offset', rt.call_function('absint', [
		rt.new_string(query_mutated).array_get(rt.new_string('offset')),
	]))
	if 0 < rt.new_int((rt.new_string(query_mutated).array_get(rt.new_string('parent'))).to_i64()) {
		rt.new_string(query_mutated).array_set('child_of', false)
	}
	if rt.is_true(rt.identical(rt.new_string('all'),
		rt.new_string(query_mutated).array_get(rt.new_string('get'))))
	{
		rt.new_string(query_mutated).array_set('childless', false)
		rt.new_string(query_mutated).array_set('child_of', 0)
		rt.new_string(query_mutated).array_set('hide_empty', 0)
		rt.new_string(query_mutated).array_set('hierarchical', false)
		rt.new_string(query_mutated).array_set('pad_counts', false)
	}
	rt.new_string(query_mutated).array_set('taxonomy', var_taxonomies.clone())
	this.query_vars = rt.new_string(query_mutated).clone()
	rt.call_function('do_action', [rt.new_string('parse_term_query'),
		rt.new_object('WP_Term_Query', []string{}, &this)])
}

fn (mut this Class_WP_Term_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.clone()])
	return rt.new_int(this.get_terms())
}

fn (mut this Class_WP_Term_Query) get_terms() i64 {
	mut var_wpdb := rt.new_null()
	this.parse_query((this.query_vars).str())
	mut var_args := this.query_vars
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [var_args.clone()])
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_terms'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Term_Query', []string{}, &this) },
		])])
	mut var_taxonomies := rt.cast_array(var_args.array_get(rt.new_string('taxonomy')))
	mut var_has_hierarchical_tax := rt.new_bool(false)
	if rt.is_true(var_taxonomies) {
		mut iter_1 := var_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__tax := item_1.val
			if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
				var__tax.clone()]))
			{
				var_has_hierarchical_tax = rt.new_bool(true)
			}
		}
	} else {
		var_has_hierarchical_tax = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_hierarchical_tax)))) {
		var_args.array_set('hierarchical', false)
		var_args.array_set('pad_counts', false)
	}
	if 0 < rt.new_int((var_args.array_get(rt.new_string('parent'))).to_i64()) {
		var_args.array_set('child_of', false)
	}
	if rt.is_true(rt.identical(rt.new_string('all'), var_args.array_get(rt.new_string('get')))) {
		var_args.array_set('childless', false)
		var_args.array_set('child_of', 0)
		var_args.array_set('hide_empty', 0)
		var_args.array_set('hierarchical', false)
		var_args.array_set('pad_counts', false)
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('get_terms_args'),
		var_args.clone(), var_taxonomies.clone()])
	mut var_child_of := var_args.array_get(rt.new_string('child_of'))
	mut var_parent := var_args.array_get(rt.new_string('parent'))
	if rt.is_true(var_child_of) {
		mut var__parent := var_child_of.clone()
	} else if rt.is_true(var_parent) {
		var__parent = var_parent.clone()
	} else {
		var__parent = rt.new_bool(false)
	}
	if rt.is_true(var__parent) {
		mut var_in_hierarchy := rt.new_bool(false)
		mut iter_2 := var_taxonomies.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var__tax := item_2.val
			mut var_hierarchy := rt.call_function('_get_term_hierarchy', [
				var__tax.clone()])
			if var_hierarchy.array_isset(var__parent) {
				var_in_hierarchy = rt.new_bool(true)
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_in_hierarchy)))) {
			if rt.is_true(rt.identical(rt.new_string('count'),
				var_args.array_get(rt.new_string('fields'))))
			{
				return 0
			} else {
				this.terms = rt.new_array()
				return (this.terms).to_i64()
			}
		}
	}
	mut var__orderby := this.query_vars.array_get(rt.new_string('orderby'))
	if rt.is_true(rt.identical(rt.new_string('term_order'), var__orderby))
		&& !rt.is_true(this.query_vars.array_get(rt.new_string('object_ids'))) {
		var__orderby = rt.new_string('term_id')
	}
	mut var_orderby := this.parse_orderby(var__orderby.clone())
	if rt.is_true(var_orderby) {
		var_orderby = rt.new_string('ORDER BY ${var_orderby.to_string()}')
	}
	mut var_order :=
		rt.new_string(this.parse_order(this.query_vars.array_get(rt.new_string('order'))))
	if rt.is_true(var_taxonomies) {
		this.sql_clauses.array_get_mut('where').array_set('taxonomy',
			"tt.taxonomy IN ('" + (rt.call_function('implode', [rt.new_string("', '"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_taxonomies.clone()])])).str() +
			"')")
	}
	if !rt.is_true(var_args.array_get(rt.new_string('exclude'))) {
		var_args.array_set('exclude', rt.new_array())
	}
	if !rt.is_true(var_args.array_get(rt.new_string('include'))) {
		var_args.array_set('include', rt.new_array())
	}
	mut var_exclude := var_args.array_get(rt.new_string('exclude'))
	mut var_exclude_tree := var_args.array_get(rt.new_string('exclude_tree'))
	mut var_include := var_args.array_get(rt.new_string('include'))
	if !(!rt.is_true(var_include)) {
		var_exclude = rt.new_string('')
		var_exclude_tree = rt.new_string('')
		mut var_inclusions := rt.call_function('implode', [rt.new_string(','),
			rt.call_function('wp_parse_id_list', [var_include.clone()])])
		this.sql_clauses.array_get_mut('where').array_set('inclusions',

			't.term_id IN ( ' + var_inclusions.str() + ' )')
	}
	mut var_exclusions := rt.new_array()
	if !(!rt.is_true(var_exclude_tree)) {
		var_exclude_tree = rt.call_function('wp_parse_id_list', [
			var_exclude_tree.clone()])
		mut var_excluded_children := var_exclude_tree.clone()
		mut iter_3 := var_exclude_tree.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_extrunk := item_3.val
			var_excluded_children = rt.call_function('array_merge', [
				var_excluded_children.clone(),
				rt.cast_array(rt.call_function('get_terms', [
					rt.create_array([
						rt.ArrayItem{ key: 'taxonomy', val: rt.call_function('reset', [
							var_taxonomies.clone(),
						]) },
						rt.ArrayItem{ key: 'child_of', val: rt.new_int(var_extrunk.to_i64()) },
						rt.ArrayItem{ key: 'fields', val: 'ids' },
						rt.ArrayItem{ key: 'hide_empty', val: 0 },
					]),
				]))])
		}
		var_exclusions = rt.call_function('array_merge', [var_excluded_children.clone(),
			var_exclusions.clone()])
	}
	if !(!rt.is_true(var_exclude)) {
		var_exclusions = rt.call_function('array_merge', [
			rt.call_function('wp_parse_id_list', [var_exclude.clone()]),
			var_exclusions.clone(),
		])
	}
	mut var_childless := rt.new_bool((var_args.array_get(rt.new_string('childless'))).to_bool())
	if rt.is_true(var_childless) {
		mut iter_4 := var_taxonomies.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var__tax := item_4.val
			mut var_term_hierarchy := rt.call_function('_get_term_hierarchy', [
				var__tax.clone(),
			])
			var_exclusions = rt.call_function('array_merge', [
				rt.func_array_keys(var_term_hierarchy.clone()),
				var_exclusions.clone(),
			])
		}
	}
	if !(!rt.is_true(var_exclusions)) {
		var_exclusions = rt.new_string(
			't.term_id NOT IN (' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('intval'), var_exclusions.clone()])])).str() +
			')')
	} else {
		var_exclusions = rt.new_string('')
	}
	var_exclusions = rt.call_function('apply_filters', [
		rt.new_string('list_terms_exclusions'),
		var_exclusions.clone(),
		var_args.clone(),
		var_taxonomies.clone(),
	])
	if !(!rt.is_true(var_exclusions)) {
		this.sql_clauses.array_get_mut('where').array_set('exclusions', rt.call_function('preg_replace', [
			rt.new_string('/^\\s*AND\\s*/'),
			rt.new_string(''),
			var_exclusions.clone(),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('name')))) {
		var_args.array_set('name', rt.new_array())
	} else {
		var_args.array_set('name', rt.cast_array(var_args.array_get(rt.new_string('name'))))
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('name')))) {
		mut var_names := var_args.array_get(rt.new_string('name'))
		mut iter_5 := var_names.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var__name := item_5.val
			var__name = rt.call_function('stripslashes', [
				rt.call_function('sanitize_term_field', [rt.new_string('name'),
					var__name.clone(), rt.new_int(0),
					rt.call_function('reset', [
						var_taxonomies.clone(),
					]),
					rt.new_string('db')]),
			])
		}
		this.sql_clauses.array_get_mut('where').array_set('name',
			"t.name IN ('" + (rt.call_function('implode', [rt.new_string("', '"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_names.clone()])])).str() +
			"')")
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('slug')))) {
		var_args.array_set('slug', rt.new_array())
	} else {
		var_args.array_set('slug', rt.call_function('array_map', [
			rt.new_string('sanitize_title'),
			rt.cast_array(var_args.array_get(rt.new_string('slug'))),
		]))
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('slug')))) {
		mut var_slug := rt.call_function('implode', [rt.new_string("', '"),
			var_args.array_get(rt.new_string('slug'))])
		this.sql_clauses.array_get_mut('where').array_set('slug', "t.slug IN ('" + var_slug.str() +
			"')")
	}
	if rt.is_true(rt.identical(rt.new_string(''),
		var_args.array_get(rt.new_string('term_taxonomy_id'))))
	{
		var_args.array_set('term_taxonomy_id', rt.new_array())
	} else {
		var_args.array_set('term_taxonomy_id', rt.call_function('array_map', [
			rt.new_string('intval'),
			rt.cast_array(var_args.array_get(rt.new_string('term_taxonomy_id'))),
		]))
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('term_taxonomy_id')))) {
		mut var_tt_ids := rt.call_function('implode', [rt.new_string(','),
			var_args.array_get(rt.new_string('term_taxonomy_id'))])
		this.sql_clauses.array_get_mut('where').array_set('term_taxonomy_id',
			'tt.term_taxonomy_id IN (${var_tt_ids.to_string()})')
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('name__like')))) {
		this.sql_clauses.array_get_mut('where').array_set('name__like', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('t.name LIKE %s'),
			rt.new_string('%' +
				(rt.call_method(var_wpdb, 'esc_like', [var_args.array_get(rt.new_string('name__like'))])).str() +
				'%')]))
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('description__like')))) {
		this.sql_clauses.array_get_mut('where').array_set('description__like', rt.call_method(var_wpdb,
			'prepare', [rt.new_string('tt.description LIKE %s'),
			rt.new_string('%' +
				(rt.call_method(var_wpdb, 'esc_like', [var_args.array_get(rt.new_string('description__like'))])).str() +
				'%')]))
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('object_ids')))) {
		var_args.array_set('object_ids', rt.new_array())
	} else {
		var_args.array_set('object_ids', rt.call_function('array_map', [
			rt.new_string('intval'),
			rt.cast_array(var_args.array_get(rt.new_string('object_ids'))),
		]))
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('object_ids')))) {
		mut var_object_ids := rt.call_function('implode', [rt.new_string(', '),
			var_args.array_get(rt.new_string('object_ids'))])
		this.sql_clauses.array_get_mut('where').array_set('object_ids',
			'tr.object_id IN (${var_object_ids.to_string()})')
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('object_ids')))) {
		var_args.array_set('hide_empty', false)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_parent)))) {
		var_parent = rt.new_int(var_parent.to_i64())
		this.sql_clauses.array_get_mut('where').array_set('parent',
			"tt.parent = '${var_parent.to_string()}'")
	}
	mut var_hierarchical := var_args.array_get(rt.new_string('hierarchical'))
	if rt.is_true(rt.identical(rt.new_string('count'), var_args.array_get(rt.new_string('fields')))) {
		var_hierarchical = rt.new_bool(false)
	}
	if rt.is_true(var_args.array_get(rt.new_string('hide_empty')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_hierarchical)))) {
		this.sql_clauses.array_get_mut('where').array_set('count', 'tt.count > 0')
	}
	mut var_number := var_args.array_get(rt.new_string('number'))
	mut var_offset := var_args.array_get(rt.new_string('offset'))
	if rt.is_true(var_number) && rt.is_true(rt.new_bool(!(rt.is_true(var_hierarchical))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_child_of))))
		&& rt.is_true(rt.identical(rt.new_string(''), var_parent)) {
		if rt.is_true(var_offset) {
			mut var_limits := rt.new_string('LIMIT ' + var_offset.str() + ',' + var_number.str())
		} else {
			var_limits = rt.new_string('LIMIT ' + var_number.str())
		}
	} else {
		var_limits = rt.new_string('')
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('search')))) {
		this.sql_clauses.array_get_mut('where').array_set('search',
			this.get_search_sql(var_args.array_get(rt.new_string('search'))))
	}
	mut var_join := rt.new_string('')
	mut var_distinct := rt.new_string('')
	rt.call_method(this.meta_query, 'parse_query_vars', [this.query_vars])
	mut var_mq_sql := rt.call_method(this.meta_query, 'get_sql', [
		rt.new_string('term'), rt.new_string('t'), rt.new_string('term_id')])
	mut var_meta_clauses := rt.call_method(this.meta_query, 'get_clauses', []rt.PhpVal{})
	if !(!rt.is_true(var_meta_clauses)) {
		var_join = rt.concat(var_join, var_mq_sql.array_get(rt.new_string('join')))
		this.sql_clauses.array_get_mut('where').array_set('meta_query', rt.call_function('preg_replace', [
			rt.new_string('/^\\s*AND\\s*/'),
			rt.new_string(''),
			var_mq_sql.array_get(rt.new_string('where')),
		]))
		var_distinct = rt.concat(var_distinct, rt.new_string('DISTINCT'))
	}
	mut var_selects := rt.new_array()
	mut switch_val_1 := var_args.array_get(rt.new_string('fields'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('count'))) {
		var_orderby = rt.new_string('')
		var_order = rt.new_string('')
		var_selects = rt.create_array([rt.ArrayItem{ key: none, val: 'COUNT(*)' }])
	} else {
		var_selects = rt.create_array([rt.ArrayItem{ key: none, val: 't.term_id' }])
		if rt.is_true(rt.identical(rt.new_string('all_with_object_id'), var_args.array_get(rt.new_string('fields'))))
			&& !(!rt.is_true(var_args.array_get(rt.new_string('object_ids')))) {
			var_selects.array_push('tr.object_id')
		}
	}
	mut var__fields := var_args.array_get(rt.new_string('fields'))
	mut var_fields := rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('apply_filters', [rt.new_string('get_terms_fields'),
			var_selects.clone(), var_args.clone(), var_taxonomies.clone()])])
	var_join = rt.concat(var_join, rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb,
		'term_taxonomy')), rt.new_string(' AS tt ON t.term_id = tt.term_id')))
	if !(!rt.is_true(this.query_vars.array_get(rt.new_string('object_ids')))) {
		var_join = rt.concat(var_join, rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb,
			'term_relationships')),
			rt.new_string(' AS tr ON tr.term_taxonomy_id = tt.term_taxonomy_id')))
		var_distinct = rt.new_string('DISTINCT')
	}
	mut var_where := rt.call_function('implode', [rt.new_string(' AND '),
		this.sql_clauses.array_get(rt.new_string('where'))])
	mut var_pieces := ['fields', 'join', 'where', 'distinct', 'orderby', 'order', 'limits']
	mut var_clauses := rt.call_function('apply_filters', [rt.new_string('terms_clauses'),
		rt.call_function('compact', [rt.create_array_from_list(var_pieces)]),
		var_taxonomies.clone(), var_args.clone()])
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
	var_distinct = if !(var_clauses.array_get(rt.new_string('distinct'))).is_null() {
		var_clauses.array_get(rt.new_string('distinct'))
	} else {
		rt.new_string('')
	}
	var_orderby = if !(var_clauses.array_get(rt.new_string('orderby'))).is_null() {
		var_clauses.array_get(rt.new_string('orderby'))
	} else {
		rt.new_string('')
	}
	var_order = if !(var_clauses.array_get(rt.new_string('order'))).is_null() {
		var_clauses.array_get(rt.new_string('order'))
	} else {
		rt.new_string('')
	}
	var_limits = if !(var_clauses.array_get(rt.new_string('limits'))).is_null() {
		var_clauses.array_get(rt.new_string('limits'))
	} else {
		rt.new_string('')
	}
	mut var_fields_is_filtered := rt.new_bool(!rt.is_true(rt.identical(rt.call_function('implode', [
		rt.new_string(', '),
		var_selects.clone(),
	]), var_fields)))
	if rt.is_true(var_where) {
		var_where = rt.new_string('WHERE ${var_where.to_string()}')
	}
	this.sql_clauses.array_set('select',
		'SELECT ${var_distinct.to_string()} ${var_fields.to_string()}')
	this.sql_clauses.array_set('from', rt.concat(rt.concat(rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb,
		'terms')), rt.new_string(' AS t ')), var_join))
	this.sql_clauses.array_set('orderby', if rt.is_true(var_orderby) {
		'${var_orderby.to_string()} ${var_order.to_string()}'
	} else {
		''
	})
	this.sql_clauses.array_set('limits', var_limits.clone())
	this.request = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(this.sql_clauses.array_get(rt.new_string('select')),
		rt.new_string('\n\t\t\t ')), this.sql_clauses.array_get(rt.new_string('from'))),
		rt.new_string('\n\t\t\t ')), var_where), rt.new_string('\n\t\t\t ')),
		this.sql_clauses.array_get(rt.new_string('orderby'))), rt.new_string('\n\t\t\t ')),
		this.sql_clauses.array_get(rt.new_string('limits')))
	this.terms = rt.new_null()
	this.terms = rt.call_function('apply_filters_ref_array', [
		rt.new_string('terms_pre_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.terms },
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Term_Query', []string{}, &this) }]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.terms)))) {
		return (this.terms).to_i64()
	}
	if rt.is_true(var_args.array_get(rt.new_string('cache_results'))) {
		mut var_cache_key := rt.new_string(this.generate_cache_key(mut rt.cast_object_ptr[Class_array](var_args),
			rt.new_string(this.request)))
		mut var_last_changed := rt.call_function('wp_cache_get_last_changed', [
			rt.new_string('terms'),
		])
		mut var_cache := rt.call_function('wp_cache_get_salted', [
			var_cache_key.clone(), rt.new_string('term-queries'),
			var_last_changed.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache)))) {
			if rt.is_true(rt.identical(rt.new_string('ids'), var__fields)) {
				var_cache = rt.call_function('array_map', [rt.new_string('intval'),
					var_cache.clone()])
			} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('count'),
				var__fields))))
			{
				if (rt.is_true(rt.identical(rt.new_string('all_with_object_id'), var__fields))
					&& !(!rt.is_true(var_args.array_get(rt.new_string('object_ids')))))
					|| ((rt.is_true(rt.identical(rt.new_string('all'), var__fields))
					&& rt.is_true(var_args.array_get(rt.new_string('pad_counts'))))
					|| rt.is_true(var_fields_is_filtered)) {
					mut var_term_ids := rt.call_function('wp_list_pluck', [
						var_cache.clone(), rt.new_string('term_id')])
				} else {
					var_term_ids = rt.call_function('array_map', [
						rt.new_string('intval'),
						var_cache.clone(),
					])
				}
				rt.call_function('_prime_term_caches', [var_term_ids.clone(),
					var_args.array_get(rt.new_string('update_term_meta_cache'))])
				mut var_term_objects := this.populate_terms(var_cache.clone())
				var_cache = this.format_terms(var_term_objects.clone(), var__fields.clone())
			}
			this.terms = var_cache.clone()
			return (this.terms).to_i64()
		}
	}
	if rt.is_true(rt.identical(rt.new_string('count'), var__fields)) {
		mut var_count := rt.call_method(var_wpdb, 'get_var', [
			rt.new_string(this.request),
		])
		if rt.is_true(var_args.array_get(rt.new_string('cache_results'))) {
			rt.call_function('wp_cache_set_salted', [var_cache_key.clone(),
				var_count.clone(), rt.new_string('term-queries'),
				var_last_changed.clone()])
		}
		return var_count.to_i64()
	}
	mut var_terms := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string(this.request),
	])
	if !rt.is_true(var_terms) {
		this.terms = rt.new_array()
		if rt.is_true(var_args.array_get(rt.new_string('cache_results'))) {
			rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), this.terms,
				rt.new_string('term-queries'), var_last_changed.clone()])
		}
		return (this.terms).to_i64()
	}
	var_term_ids = rt.call_function('wp_list_pluck', [var_terms.clone(),
		rt.new_string('term_id')])
	rt.call_function('_prime_term_caches', [var_term_ids.clone(),
		rt.new_bool(false)])
	var_term_objects = this.populate_terms(var_terms.clone())
	if rt.is_true(var_child_of) {
		mut iter_6 := var_taxonomies.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var__tax := item_6.val
			mut var_children := rt.call_function('_get_term_hierarchy', [
				var__tax.clone()])
			if !(!rt.is_true(var_children)) {
				var_term_objects = rt.call_function('_get_term_children', [
					var_child_of.clone(), var_term_objects.clone(),
					var__tax.clone()])
			}
		}
	}
	if rt.is_true(var_args.array_get(rt.new_string('pad_counts')))
		&& rt.is_true(rt.identical(rt.new_string('all'), var__fields)) {
		mut iter_7 := var_taxonomies.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var__tax := item_7.val
			rt.call_function('_pad_term_counts', [var_term_objects.clone(),
				var__tax.clone()])
		}
	}
	if rt.is_true(var_hierarchical) && rt.is_true(var_args.array_get(rt.new_string('hide_empty')))
		&& var_term_objects.clone().is_array() {
		mut iter_8 := var_term_objects.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_term := item_8.val
			mut var_k := item_8.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_term, 'count'))))) {
				mut var_children := rt.call_function('get_term_children', [
					rt.get_property(var_term, 'term_id'),
					rt.get_property(var_term, 'taxonomy'),
				])
				if rt.is_true(rt.new_bool(var_children.clone().is_array())) {
					mut iter_9 := var_children.iterator()
					for {
						item_9 := iter_9.next() or { break }
						mut var_child_id := item_9.val
						mut var_child := rt.call_function('get_term', [
							var_child_id.clone(), rt.get_property(var_term, 'taxonomy')])
						if rt.is_true(rt.new_bool(rt.instance_of(var_child, 'WP_Term')))
							&& rt.is_true(rt.get_property(var_child, 'count')) {
							continue
						}
					}
				}
				var_term_objects.array_unset(var_k)
			}
		}
	}
	if rt.is_true(var_hierarchical) && rt.is_true(var_number) && var_term_objects.clone().is_array() {
		if rt.is_true(rt.greater_equal(var_offset,
			rt.new_int(var_term_objects.clone().array_count())))
		{
			var_term_objects = rt.new_array()
		} else {
			var_term_objects = rt.call_function('array_slice', [
				var_term_objects.clone(), var_offset.clone(),
				var_number.clone(), rt.new_bool(true)])
		}
	}
	if rt.is_true(var_args.array_get(rt.new_string('update_term_meta_cache'))) {
		var_term_ids = rt.call_function('wp_list_pluck', [var_term_objects.clone(),
			rt.new_string('term_id')])
		rt.call_function('wp_lazyload_term_meta', [var_term_ids.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('all_with_object_id'), var__fields))
		&& !(!rt.is_true(var_args.array_get(rt.new_string('object_ids')))) {
		mut var_term_cache := rt.new_array()
		mut iter_10 := var_term_objects.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_term := item_10.val
			mut var_object := create_stdclass()
			rt.set_property(var_object, 'term_id', rt.get_property(var_term, 'term_id'))
			rt.set_property(var_object, 'object_id', rt.get_property(var_term, 'object_id'))
			var_term_cache.array_push(var_object)
		}
	} else if rt.is_true(rt.identical(rt.new_string('all'), var__fields))
		&& rt.is_true(var_args.array_get(rt.new_string('pad_counts'))) {
		var_term_cache = rt.new_array()
		mut iter_11 := var_term_objects.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_term := item_11.val
			mut var_object := create_stdclass()
			rt.set_property(var_object, 'term_id', rt.get_property(var_term, 'term_id'))
			rt.set_property(var_object, 'count', rt.get_property(var_term, 'count'))
			var_term_cache.array_push(var_object)
		}
	} else if rt.is_true(var_fields_is_filtered) {
		var_term_cache = var_term_objects.clone()
	} else {
		var_term_cache = rt.call_function('wp_list_pluck', [var_term_objects.clone(),
			rt.new_string('term_id')])
	}
	if rt.is_true(var_args.array_get(rt.new_string('cache_results'))) {
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(),
			var_term_cache.clone(), rt.new_string('term-queries'),
			var_last_changed.clone()])
	}
	this.terms = this.format_terms(var_term_objects.clone(), var__fields.clone())
	return (this.terms).to_i64()
}

fn (mut this Class_WP_Term_Query) parse_orderby(var_orderby_raw rt.PhpVal) rt.PhpVal {
	mut var__orderby := rt.new_string(var_orderby_raw.clone().to_string().to_lower())
	mut var_maybe_orderby_meta := rt.new_bool(false)
	if rt.is_true(rt.call_function('in_array', [var__orderby.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'term_id' },
			rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'term_group' }]),
		rt.new_bool(true)]))
	{
		mut var_orderby := rt.new_string('t.${var__orderby.to_string()}')
	} else if rt.is_true(rt.call_function('in_array', [var__orderby.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'count' },
			rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'taxonomy' },
			rt.ArrayItem{ key: none, val: 'term_taxonomy_id' },
			rt.ArrayItem{ key: none, val: 'description' }]),
		rt.new_bool(true)]))
	{
		var_orderby = rt.new_string('tt.${var__orderby.to_string()}')
	} else if rt.is_true(rt.identical(rt.new_string('term_order'), var__orderby)) {
		var_orderby = rt.new_string('tr.term_order')
	} else if rt.is_true(rt.identical(rt.new_string('include'), var__orderby))
		&& !(!rt.is_true(this.query_vars.array_get(rt.new_string('include')))) {
		mut var_include := rt.call_function('implode', [rt.new_string(','),
			rt.call_function('wp_parse_id_list',
				[this.query_vars.array_get(rt.new_string('include'))])])
		var_orderby = rt.new_string('FIELD( t.term_id, ${var_include.to_string()} )')
	} else if rt.is_true(rt.identical(rt.new_string('slug__in'), var__orderby))
		&& !(!rt.is_true(this.query_vars.array_get(rt.new_string('slug'))))
		&& this.query_vars.array_get(rt.new_string('slug')).is_array() {
		mut var_slugs := rt.call_function('implode', [rt.new_string("', '"),
			rt.call_function('array_map', [rt.new_string('sanitize_title_for_query'),
				this.query_vars.array_get(rt.new_string('slug'))])])
		var_orderby = rt.new_string("FIELD( t.slug, '" + var_slugs.str() + "')")
	} else if rt.is_true(rt.identical(rt.new_string('none'), var__orderby)) {
		var_orderby = rt.new_string('')
	} else if !rt.is_true(var__orderby)
		|| rt.is_true(rt.identical(rt.new_string('id'), var__orderby))
		|| rt.is_true(rt.identical(rt.new_string('term_id'), var__orderby)) {
		var_orderby = rt.new_string('t.term_id')
	} else {
		var_orderby = rt.new_string('t.name')
		var_maybe_orderby_meta = rt.new_bool(true)
	}
	var_orderby = rt.call_function('apply_filters', [rt.new_string('get_terms_orderby'),
		var_orderby.clone(), this.query_vars, this.query_vars.array_get(rt.new_string('taxonomy'))])
	if rt.is_true(var_maybe_orderby_meta) {
		var_maybe_orderby_meta = this.parse_orderby_meta(var__orderby.clone())
		if rt.is_true(var_maybe_orderby_meta) {
			var_orderby = var_maybe_orderby_meta.clone()
		}
	}
	return var_orderby.clone()
}

fn (mut this Class_WP_Term_Query) format_terms(var_term_objects rt.PhpVal, var__fields rt.PhpVal) rt.PhpVal {
	mut var_term_objects_mutated := var_term_objects
	mut var__fields_mutated := var__fields
	mut var__terms := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('id=>parent'), var__fields_mutated)) {
		mut iter_12 := var_term_objects_mutated.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_term := item_12.val
			var__terms.array_set(rt.get_property(var_term, 'term_id'), rt.get_property(var_term,
				'parent'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('ids'), var__fields_mutated)) {
		mut iter_13 := var_term_objects_mutated.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_term := item_13.val
			var__terms.array_push(rt.new_int((rt.get_property(var_term, 'term_id')).to_i64()))
		}
	} else if rt.is_true(rt.identical(rt.new_string('tt_ids'), var__fields_mutated)) {
		mut iter_14 := var_term_objects_mutated.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_term := item_14.val
			var__terms.array_push(rt.new_int((rt.get_property(var_term, 'term_taxonomy_id')).to_i64()))
		}
	} else if rt.is_true(rt.identical(rt.new_string('names'), var__fields_mutated)) {
		mut iter_15 := var_term_objects_mutated.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_term := item_15.val
			var__terms.array_push(rt.get_property(var_term, 'name'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('slugs'), var__fields_mutated)) {
		mut iter_16 := var_term_objects_mutated.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_term := item_16.val
			var__terms.array_push(rt.get_property(var_term, 'slug'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('id=>name'), var__fields_mutated)) {
		mut iter_17 := var_term_objects_mutated.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_term := item_17.val
			var__terms.array_set(rt.get_property(var_term, 'term_id'), rt.get_property(var_term,
				'name'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('id=>slug'), var__fields_mutated)) {
		mut iter_18 := var_term_objects_mutated.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_term := item_18.val
			var__terms.array_set(rt.get_property(var_term, 'term_id'), rt.get_property(var_term,
				'slug'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('all'), var__fields_mutated))
		|| rt.is_true(rt.identical(rt.new_string('all_with_object_id'), var__fields_mutated)) {
		var__terms = var_term_objects_mutated.clone()
	}
	return var__terms.clone()
}

fn (mut this Class_WP_Term_Query) parse_orderby_meta(var_orderby_raw rt.PhpVal) rt.PhpVal {
	mut var_orderby := rt.new_string('')
	rt.call_method(this.meta_query, 'get_sql', [rt.new_string('term'),
		rt.new_string('t'), rt.new_string('term_id')])
	mut var_meta_clauses := rt.call_method(this.meta_query, 'get_clauses', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_clauses))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_orderby_raw)))) {
		return var_orderby.clone()
	}
	mut var_allowed_keys := rt.new_array()
	mut var_primary_meta_key := rt.new_null()
	mut var_primary_meta_query := rt.call_function('reset', [
		var_meta_clauses.clone()])
	if !(!rt.is_true(var_primary_meta_query.array_get(rt.new_string('key')))) {
		var_primary_meta_key = var_primary_meta_query.array_get(rt.new_string('key'))
		var_allowed_keys.array_push(var_primary_meta_key.clone())
	}
	var_allowed_keys.array_push('meta_value')
	var_allowed_keys.array_push('meta_value_num')
	var_allowed_keys = rt.call_function('array_merge', [var_allowed_keys.clone(),
		rt.func_array_keys(var_meta_clauses.clone())])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_orderby_raw.clone(), var_allowed_keys.clone(), rt.new_bool(true)])))))
	{
		return var_orderby.clone()
	}
	mut switch_val_2 := var_orderby_raw
	if rt.is_true(rt.equal(switch_val_2, var_primary_meta_key))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('meta_value'))) {
		if !(!rt.is_true(var_primary_meta_query.array_get(rt.new_string('type')))) {
			var_orderby = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST('),
				var_primary_meta_query.array_get(rt.new_string('alias'))),
				rt.new_string('.meta_value AS ')),
				var_primary_meta_query.array_get(rt.new_string('cast'))), rt.new_string(')'))).str())
		} else {
			var_orderby = rt.new_string((rt.concat(var_primary_meta_query.array_get(rt.new_string('alias')),
				rt.new_string('.meta_value'))).str())
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('meta_value_num'))) {
		var_orderby = rt.new_string((rt.concat(var_primary_meta_query.array_get(rt.new_string('alias')),
			rt.new_string('.meta_value+0'))).str())
	} else {
		if rt.is_true(rt.new_bool(var_meta_clauses.clone().array_isset(var_orderby_raw.clone()))) {
			mut var_meta_clause := var_meta_clauses.array_get(var_orderby_raw)
			var_orderby = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST('),
				var_meta_clause.array_get(rt.new_string('alias'))),
				rt.new_string('.meta_value AS ')), var_meta_clause.array_get(rt.new_string('cast'))),
				rt.new_string(')'))).str())
		}
	}
	return var_orderby.clone()
}

fn (mut this Class_WP_Term_Query) parse_order(var_order rt.PhpVal) string {
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

fn (mut this Class_WP_Term_Query) get_search_sql(var_search rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_like := rt.new_string('%' +
		(rt.call_method(var_wpdb, 'esc_like', [var_search.clone()])).str() + '%')
	return rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('((t.name LIKE %s) OR (t.slug LIKE %s))'),
		var_like.clone(),
		var_like.clone(),
	])
}

fn (mut this Class_WP_Term_Query) populate_terms(var_terms rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_term_objects := rt.new_array()
	if !(var_terms_mutated.clone().is_array()) {
		return var_term_objects.clone()
	}
	mut iter_19 := var_terms_mutated.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_term_data := item_19.val
		mut var_key := item_19.key
		if var_term_data.clone().is_object()
			&& rt.is_true(rt.call_function('property_exists', [var_term_data.clone(), rt.new_string('term_id')])) {
			mut var_term := rt.call_function('get_term', [
				rt.get_property(var_term_data, 'term_id'),
			])
			if rt.is_true(rt.call_function('property_exists', [
				var_term_data.clone(), rt.new_string('object_id')]))
			{
				rt.set_property(var_term, 'object_id', rt.new_int((rt.get_property(var_term_data,
					'object_id')).to_i64()))
			}
			if rt.is_true(rt.call_function('property_exists', [
				var_term_data.clone(), rt.new_string('count')]))
			{
				rt.set_property(var_term, 'count', rt.new_int((rt.get_property(var_term_data,
					'count')).to_i64()))
			}
		} else {
			var_term = rt.call_function('get_term', [var_term_data.clone()])
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term'))) {
			var_term_objects.array_set(var_key, var_term.clone())
		}
	}
	return var_term_objects.clone()
}

fn (mut this Class_WP_Term_Query) generate_cache_key(mut var_args Class_array, var_sql rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_sql_mutated := var_sql
	mut var_cache_args := rt.call_function('wp_array_slice_assoc', [var_args_mutated,
		rt.func_array_keys(this.query_var_defaults)])
	var_cache_args.array_unset(rt.new_string('cache_results'))
	var_cache_args.array_unset(rt.new_string('update_term_meta_cache'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('count'), var_args_mutated.array_get(rt.new_string('fields'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all_with_object_id'), var_args_mutated.array_get(rt.new_string('fields')))))) {
		var_cache_args.array_set('fields', 'all')
	}
	var_sql_mutated = rt.call_method(var_wpdb, 'remove_placeholder_escape', [
		var_sql_mutated.clone()])
	mut var_key := rt.new_string(md5.hexhash(
		(rt.call_function('serialize', [var_cache_args.clone()])).str() + var_sql_mutated.str()))
	return 'get_terms:${var_key.to_string()}'
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_term_query(query string) &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase:      rt.PhpObjectBase{}
		request:            ''
		meta_query:         rt.new_bool(false)
		meta_query_clauses: rt.new_null()
		sql_clauses:        rt.new_array()
		query_vars:         rt.new_null()
		query_var_defaults: rt.new_null()
		terms:              rt.new_null()
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

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Term_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_terms' {
			return rt.new_int(this.get_terms())
		}
		'parse_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_orderby(dispatch_arg_0)
		}
		'format_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.format_terms(dispatch_arg_0, dispatch_arg_1)
		}
		'parse_orderby_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_orderby_meta(dispatch_arg_0)
		}
		'parse_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parse_order(dispatch_arg_0))
		}
		'get_search_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_search_sql(dispatch_arg_0)
		}
		'populate_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.populate_terms(dispatch_arg_0)
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
		else {
			return none
		}
	}
}

fn (this &Class_WP_Term_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'request' { return rt.new_string(this.request) }
		'meta_query' { return this.meta_query }
		'meta_query_clauses' { return this.meta_query_clauses }
		'sql_clauses' { return this.sql_clauses }
		'query_vars' { return this.query_vars }
		'query_var_defaults' { return this.query_var_defaults }
		'terms' { return this.terms }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Term_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'request' {
			this.request = val.str()
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
		'terms' {
			this.terms = val
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
