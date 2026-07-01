import rt

struct Class_WP_Term_Query {
	rt.PhpObjectBase
pub mut:
		request string
		meta_query rt.PhpVal = rt.new_bool(false)
		meta_query_clauses rt.PhpVal = rt.new_null()
		sql_clauses rt.PhpVal = rt.new_array()
		query_vars rt.PhpVal = rt.new_null()
		query_var_defaults rt.PhpVal = rt.new_null()
		terms rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Term_Query) construct(query string)  {
	mut query_mutated := query
	this.query_var_defaults = rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.new_null() }, rt.ArrayItem{ key: 'object_ids', val: rt.new_null() }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'hide_empty', val: true }, rt.ArrayItem{ key: 'include', val: rt.new_array() }, rt.ArrayItem{ key: 'exclude', val: rt.new_array() }, rt.ArrayItem{ key: 'exclude_tree', val: rt.new_array() }, rt.ArrayItem{ key: 'number', val: '' }, rt.ArrayItem{ key: 'offset', val: '' }, rt.ArrayItem{ key: 'fields', val: 'all' }, rt.ArrayItem{ key: 'name', val: '' }, rt.ArrayItem{ key: 'slug', val: '' }, rt.ArrayItem{ key: 'term_taxonomy_id', val: '' }, rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'search', val: '' }, rt.ArrayItem{ key: 'name__like', val: '' }, rt.ArrayItem{ key: 'description__like', val: '' }, rt.ArrayItem{ key: 'pad_counts', val: false }, rt.ArrayItem{ key: 'get', val: '' }, rt.ArrayItem{ key: 'child_of', val: 0 }, rt.ArrayItem{ key: 'parent', val: '' }, rt.ArrayItem{ key: 'childless', val: false }, rt.ArrayItem{ key: 'cache_domain', val: 'core' }, rt.ArrayItem{ key: 'cache_results', val: true }, rt.ArrayItem{ key: 'update_term_meta_cache', val: true }, rt.ArrayItem{ key: 'meta_query', val: '' }, rt.ArrayItem{ key: 'meta_key', val: '' }, rt.ArrayItem{ key: 'meta_value', val: '' }, rt.ArrayItem{ key: 'meta_type', val: '' }, rt.ArrayItem{ key: 'meta_compare', val: '' }])
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Term_Query) parse_query(query string)  {
	mut query_mutated := query
	if query_mutated == '' {
		query_mutated = (this.query_vars).str()
	}
	mut var_taxonomies := if rt.new_string(query_mutated).array_isset(rt.new_string('taxonomy')) { rt.cast_array(rt.new_string(query_mutated).array_get('taxonomy')) } else { rt.new_null() }
	this.query_var_defaults = rt.call_function('apply_filters', [rt.new_string('get_terms_defaults'), this.query_var_defaults, var_taxonomies.dup()])
	query_mutated = (rt.call_function('wp_parse_args', [rt.new_string(query_mutated).dup(), this.query_var_defaults])).str()
	rt.new_string(query_mutated).array_set('number', rt.call_function('absint', [rt.new_string(query_mutated).array_get('number')]))
	rt.new_string(query_mutated).array_set('offset', rt.call_function('absint', [rt.new_string(query_mutated).array_get('offset')]))
	if rt.is_true(rt.less(rt.new_int(0), // unsupported expression: Expr_Cast_Int)) {
		rt.new_string(query_mutated).array_set('child_of', false)
	}
	if rt.is_true(rt.identical(rt.new_string('all'), rt.new_string(query_mutated).array_get('get'))) {
		rt.new_string(query_mutated).array_set('childless', false)
		rt.new_string(query_mutated).array_set('child_of', 0)
		rt.new_string(query_mutated).array_set('hide_empty', 0)
		rt.new_string(query_mutated).array_set('hierarchical', false)
		rt.new_string(query_mutated).array_set('pad_counts', false)
	}
	rt.new_string(query_mutated).array_set('taxonomy', var_taxonomies.dup())
	this.query_vars = rt.new_string(query_mutated).dup()
	rt.call_function('do_action', [rt.new_string('parse_term_query'), rt.new_object('WP_Term_Query', []string{}, &this)])
}

fn (mut this Class_WP_Term_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.query_vars = rt.call_function('wp_parse_args', [var_query_mutated.dup()])
	return rt.new_int(this.get_terms())
}

fn (mut this Class_WP_Term_Query) get_terms() i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.parse_query((this.query_vars).str())
	// unsupported expression: Expr_AssignRef
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [var_args.dup()])
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_terms'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Term_Query', []string{}, &this) }])])
	mut var_taxonomies := rt.cast_array(var_args.array_get('taxonomy'))
	mut var_has_hierarchical_tax := rt.new_bool(rt.new_bool(false))
	if rt.is_true(var_taxonomies) {
		{
			mut iter_1 := var_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__tax := item_1.val
				if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var__tax.dup()])) {
					var_has_hierarchical_tax = rt.new_bool(rt.new_bool(true))
				}
			}
		}
	} else {
		var_has_hierarchical_tax = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_hierarchical_tax)))) {
		var_args.array_set('hierarchical', false)
		var_args.array_set('pad_counts', false)
	}
	if rt.is_true(rt.less(rt.new_int(0), // unsupported expression: Expr_Cast_Int)) {
		var_args.array_set('child_of', false)
	}
	if rt.is_true(rt.identical(rt.new_string('all'), var_args.array_get('get'))) {
		var_args.array_set('childless', false)
		var_args.array_set('child_of', 0)
		var_args.array_set('hide_empty', 0)
		var_args.array_set('hierarchical', false)
		var_args.array_set('pad_counts', false)
	}
	mut var_args := rt.call_function('apply_filters', [rt.new_string('get_terms_args'), var_args.dup(), var_taxonomies.dup()])
	mut var_child_of := var_args.array_get('child_of')
	mut var_parent := var_args.array_get('parent')
	if rt.is_true(var_child_of) {
		mut var__parent := var_child_of.dup()
	} else if rt.is_true(var_parent) {
		var__parent = var_parent.dup()
	} else {
		var__parent = rt.new_bool(rt.new_bool(false))
	}
	if rt.is_true(var__parent) {
		mut var_in_hierarchy := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := var_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__tax := item_1.val
				mut var_hierarchy := rt.call_function('_get_term_hierarchy', [var__tax.dup()])
				if var_hierarchy.array_isset(var__parent) {
					var_in_hierarchy = rt.new_bool(rt.new_bool(true))
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_in_hierarchy)))) {
			if rt.is_true(rt.identical(rt.new_string('count'), var_args.array_get('fields'))) {
				return 0
			} else {
				this.terms = rt.new_array()
				return (this.terms).to_i64()
			}
		}
	}
	mut var__orderby := this.query_vars.array_get('orderby')
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('term_order'), var__orderby)) && !rt.is_true(this.query_vars.array_get('object_ids')))) {
		var__orderby = rt.new_string(rt.new_string('term_id'))
	}
	mut var_orderby := this.parse_orderby(var__orderby.dup())
	if rt.is_true(var_orderby) {
		var_orderby = rt.new_string(rt.new_string("ORDER BY ${var_orderby.to_string()}"))
	}
	mut var_order := rt.new_string(this.parse_order(this.query_vars.array_get('order')))
	if rt.is_true(var_taxonomies) {
		this.sql_clauses.array_get_mut('where').array_set('taxonomy', 'tt.taxonomy IN (\'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_function('array_map', [rt.new_string('esc_sql'), var_taxonomies.dup()])])).str() + '\')')
	}
	if !rt.is_true(var_args.array_get('exclude')) {
		var_args.array_set('exclude', rt.new_array())
	}
	if !rt.is_true(var_args.array_get('include')) {
		var_args.array_set('include', rt.new_array())
	}
	mut var_exclude := var_args.array_get('exclude')
	mut var_exclude_tree := var_args.array_get('exclude_tree')
	mut var_include := var_args.array_get('include')
	if !(!rt.is_true(var_include)) {
		var_exclude = rt.new_string(rt.new_string(''))
		var_exclude_tree = rt.new_string(rt.new_string(''))
		mut var_inclusions := rt.call_function('implode', [rt.new_string(','), rt.call_function('wp_parse_id_list', [var_include.dup()])])
		this.sql_clauses.array_get_mut('where').array_set('inclusions', 't.term_id IN ( ' + (var_inclusions).str() + ' )')
	}
	mut var_exclusions := rt.new_array()
	if !(!rt.is_true(var_exclude_tree)) {
		var_exclude_tree = rt.call_function('wp_parse_id_list', [var_exclude_tree.dup()])
		mut var_excluded_children := var_exclude_tree.dup()
		{
			mut iter_1 := var_exclude_tree.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_extrunk := item_1.val
				var_excluded_children = rt.call_function('array_merge', [var_excluded_children.dup(), rt.cast_array(rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.call_function('reset', [var_taxonomies.dup()]) }, rt.ArrayItem{ key: 'child_of', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'hide_empty', val: 0 }])]))])
			}
		}
		var_exclusions = rt.call_function('array_merge', [var_excluded_children.dup(), var_exclusions.dup()])
	}
	if !(!rt.is_true(var_exclude)) {
		var_exclusions = rt.call_function('array_merge', [rt.call_function('wp_parse_id_list', [var_exclude.dup()]), var_exclusions.dup()])
	}
	mut var_childless := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(var_childless) {
		{
			mut iter_1 := var_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__tax := item_1.val
				mut var_term_hierarchy := rt.call_function('_get_term_hierarchy', [var__tax.dup()])
				var_exclusions = rt.call_function('array_merge', [rt.func_array_keys(var_term_hierarchy.dup()), var_exclusions.dup()])
			}
		}
	}
	if !(!rt.is_true(var_exclusions)) {
		var_exclusions = rt.new_string('t.term_id NOT IN (' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('intval'), var_exclusions.dup()])])).str() + ')')
	} else {
		var_exclusions = rt.new_string(rt.new_string(''))
	}
	var_exclusions = rt.call_function('apply_filters', [rt.new_string('list_terms_exclusions'), var_exclusions.dup(), var_args.dup(), var_taxonomies.dup()])
	if !(!rt.is_true(var_exclusions)) {
		this.sql_clauses.array_get_mut('where').array_set('exclusions', rt.call_function('preg_replace', [rt.new_string('/^\\s*AND\\s*/'), rt.new_string(''), var_exclusions.dup()]))
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get('name'))) {
		var_args.array_set('name', rt.new_array())
	} else {
		var_args.array_set('name', rt.cast_array(var_args.array_get('name')))
	}
	if !(!rt.is_true(var_args.array_get('name'))) {
		mut var_names := var_args.array_get('name')
		{
			mut iter_1 := var_names.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var__name := item_1.val
				var__name = rt.call_function('stripslashes', [rt.call_function('sanitize_term_field', [rt.new_string('name'), var__name.dup(), rt.new_int(0), rt.call_function('reset', [var_taxonomies.dup()]), rt.new_string('db')])])
			}
		}
		this.sql_clauses.array_get_mut('where').array_set('name', 't.name IN (\'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_function('array_map', [rt.new_string('esc_sql'), var_names.dup()])])).str() + '\')')
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get('slug'))) {
		var_args.array_set('slug', rt.new_array())
	} else {
		var_args.array_set('slug', rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.cast_array(var_args.array_get('slug'))]))
	}
	if !(!rt.is_true(var_args.array_get('slug'))) {
		mut var_slug := rt.call_function('implode', [rt.new_string('\', \''), var_args.array_get('slug')])
		this.sql_clauses.array_get_mut('where').array_set('slug', 't.slug IN (\'' + (var_slug).str() + '\')')
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get('term_taxonomy_id'))) {
		var_args.array_set('term_taxonomy_id', rt.new_array())
	} else {
		var_args.array_set('term_taxonomy_id', rt.call_function('array_map', [rt.new_string('intval'), rt.cast_array(var_args.array_get('term_taxonomy_id'))]))
	}
	if !(!rt.is_true(var_args.array_get('term_taxonomy_id'))) {
		mut var_tt_ids := rt.call_function('implode', [rt.new_string(','), var_args.array_get('term_taxonomy_id')])
		this.sql_clauses.array_get_mut('where').array_set('term_taxonomy_id', "tt.term_taxonomy_id IN (${var_tt_ids.to_string()})")
	}
	if !(!rt.is_true(var_args.array_get('name__like'))) {
		this.sql_clauses.array_get_mut('where').array_set('name__like', rt.call_method(, 'prepare', [, ]))
	}
	if !(!rt.is_true(var_args.array_get('description__like'))) {
		.array_get_mut().array_set(, )
	}
	if rt.is_true(rt.identical(, )) {
		
	} else {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP_Term_Query) parse_orderby(var_orderby_raw rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Term_Query) format_terms(var_term_objects rt.PhpVal, var__fields rt.PhpVal) rt.PhpVal {
	mut var_term_objects_mutated := var_term_objects
	mut var__fields_mutated := var__fields
}

fn (mut this Class_WP_Term_Query) parse_orderby_meta(var_orderby_raw rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Term_Query) parse_order(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	return ''
}

fn (mut this Class_WP_Term_Query) get_search_sql(var_search rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_Term_Query) populate_terms(var_terms rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
}

fn (mut this Class_WP_Term_Query) generate_cache_key(mut var_args Class_array, var_sql rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_sql_mutated := var_sql
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

fn create_wp_term_query(query string) &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		request: ''
		meta_query: rt.new_bool(false)
		meta_query_clauses: rt.new_null()
		sql_clauses: rt.new_array()
		query_vars: rt.new_null()
		query_var_defaults: rt.new_null()
		terms: rt.new_null()
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.generate_cache_key(mut dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
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
		'request' { this.request = (val).str(); return true }
		'meta_query' { this.meta_query = val; return true }
		'meta_query_clauses' { this.meta_query_clauses = val; return true }
		'sql_clauses' { this.sql_clauses = val; return true }
		'query_vars' { this.query_vars = val; return true }
		'query_var_defaults' { this.query_var_defaults = val; return true }
		'terms' { this.terms = val; return true }
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




pub fn init_wp_includes_class_wp_term_query_php() {
}
