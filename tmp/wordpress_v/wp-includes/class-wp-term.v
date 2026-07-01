import rt

struct Class_WP_Term {
	rt.PhpObjectBase
pub mut:
		term_id rt.PhpVal = rt.new_null()
		name rt.PhpVal = rt.new_string('')
		slug rt.PhpVal = rt.new_string('')
		term_group rt.PhpVal = rt.new_string('')
		term_taxonomy_id rt.PhpVal = rt.new_int(0)
		taxonomy rt.PhpVal = rt.new_string('')
		description rt.PhpVal = rt.new_string('')
		parent rt.PhpVal = rt.new_int(0)
		count rt.PhpVal = rt.new_int(0)
		filter rt.PhpVal = rt.new_string('raw')
}

fn Class_WP_Term.get_instance(var_term_id rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_term_id_mutated := var_term_id
	// unsupported statement: Stmt_Global
	var_term_id_mutated = // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term_id_mutated)))) {
		return rt.new_bool(false)
	}
	mut var__term := rt.call_function('wp_cache_get', [var_term_id_mutated.dup(), rt.new_string('terms')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var__term)))) || rt.is_true(rt.new_bool(rt.is_true(var_taxonomy) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		var__term = rt.new_bool(rt.new_bool(false))
		mut var_terms := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT t.*, tt.* FROM '), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS t INNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tt ON t.term_id = tt.term_id WHERE t.term_id = %d')), var_term_id_mutated.dup()])])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
			return rt.new_bool(false)
		}
		if rt.is_true(var_taxonomy) {
			{
				mut iter_1 := var_terms.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_match := item_1.val
					if rt.is_true(rt.identical(var_taxonomy, rt.get_property(var_match, 'taxonomy'))) {
						var__term = var_match
						break
					}
				}
			}
			// unsupported statement: Stmt_Nop
		} else if 1 == var_terms.dup().array_count() {
			var__term = rt.call_function('reset', [var_terms.dup()])
			// unsupported statement: Stmt_Nop
		} else {
			{
				mut iter_1 := var_terms.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_t := item_1.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.get_property(var_t, 'taxonomy')]))))) {
						continue
					}
					if rt.is_true(var__term) {
						return create_wp_error(rt.new_string('ambiguous_term_id'), rt.call_function('__', [rt.new_string('Term ID is shared between multiple taxonomies')]), var_term_id_mutated.dup())
					}
					var__term = var_t
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var__term)))) {
			return rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.get_property(var__term, 'taxonomy')]))))) {
			return create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [rt.new_string('Invalid taxonomy.')]))
		}
		var__term = rt.call_function('sanitize_term', [var__term.dup(), rt.get_property(var__term, 'taxonomy'), rt.new_string('raw')])
		if 1 == var_terms.dup().array_count() {
			rt.call_function('wp_cache_add', [var_term_id_mutated.dup(), var__term.dup(), rt.new_string('terms')])
		}
	}
	mut var_term_obj := create_wp_term(var__term.dup())
	var_term_obj.filter(var_term_obj.filter)
	return rt.new_object('WP_Term', []string{}, var_term_obj)
}

fn (mut this Class_WP_Term) construct(var_term rt.PhpVal)  {
	{
		mut iter_1 := rt.call_function('get_object_vars', [var_term.dup()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":199,"name":"key"}', var_value.dup())
		}
	}
}

fn (mut this Class_WP_Term) filter(var_filter rt.PhpVal)  {
	rt.call_function('sanitize_term', [rt.new_object('WP_Term', []string{}, &this), this.taxonomy, var_filter.dup()])
}

fn (mut this Class_WP_Term) to_array() rt.PhpVal {
	return rt.call_function('get_object_vars', [rt.new_object('WP_Term', []string{}, &this)])
}

fn (mut this Class_WP_Term) magic_get(var_key rt.PhpVal)  {
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('data'))) {
		mut var_data := create_stdclass()
		mut var_columns := rt.create_array([rt.ArrayItem{ key: none, val: 'term_id' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'term_group' }, rt.ArrayItem{ key: none, val: 'term_taxonomy_id' }, rt.ArrayItem{ key: none, val: 'taxonomy' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'count' }])
		{
			mut iter_1 := var_columns.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_column := item_1.val
				rt.set_property(var_data, '{"nodeType":"Expr_Variable","line":239,"name":"column"}', if !(rt.get_property(rt.new_object('WP_Term', []string{}, &this), '{"nodeType":"Expr_Variable","line":239,"name":"column"}')).is_null() { rt.get_property(rt.new_object('WP_Term', []string{}, &this), '{"nodeType":"Expr_Variable","line":239,"name":"column"}') } else { rt.new_null() })
			}
		}
		return rt.call_function('sanitize_term', [var_data, rt.get_property(var_data, 'taxonomy'), rt.new_string('raw')])
	}
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_term(arg_0 rt.PhpVal) &Class_WP_Term {
	mut obj := &Class_WP_Term{
		PhpObjectBase: rt.PhpObjectBase{}
		term_id: rt.new_null()
		name: rt.new_string('')
		slug: rt.new_string('')
		term_group: rt.new_string('')
		term_taxonomy_id: rt.new_int(0)
		taxonomy: rt.new_string('')
		description: rt.new_string('')
		parent: rt.new_int(0)
		count: rt.new_int(0)
		filter: rt.new_string('raw')
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Term) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Term.get_instance(dispatch_arg_0, dispatch_arg_1)
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.filter(dispatch_arg_0)
			return rt.new_null()
		}
		'to_array' {
			return this.to_array()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_get(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Term) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'term_id' { return this.term_id }
		'name' { return this.name }
		'slug' { return this.slug }
		'term_group' { return this.term_group }
		'term_taxonomy_id' { return this.term_taxonomy_id }
		'taxonomy' { return this.taxonomy }
		'description' { return this.description }
		'parent' { return this.parent }
		'count' { return this.count }
		'filter' { return this.filter }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Term) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'term_id' { this.term_id = val; return true }
		'name' { this.name = val; return true }
		'slug' { this.slug = val; return true }
		'term_group' { this.term_group = val; return true }
		'term_taxonomy_id' { this.term_taxonomy_id = val; return true }
		'taxonomy' { this.taxonomy = val; return true }
		'description' { this.description = val; return true }
		'parent' { this.parent = val; return true }
		'count' { this.count = val; return true }
		'filter' { this.filter = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_class_wp_term_php() {
}
