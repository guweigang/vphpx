import rt

struct Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup {
	rt.PhpObjectBase
pub mut:
		edited_product_cats rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) construct()  {
}

fn Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup.instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) init()  {
	rt.call_function('add_action', [rt.new_string('generate_category_lookup_table'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CategoryLookup', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'regenerate' }])])
	rt.call_function('add_action', [rt.new_string('edit_product_cat'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CategoryLookup', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'before_edit' }]), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('edited_product_cat'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CategoryLookup', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_edit' }]), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('created_product_cat'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CategoryLookup', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_create' }]), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_CategoryLookup', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'define_category_lookup_tables_in_wpdb' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) regenerate()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.new_string('TRUNCATE TABLE '), rt.get_property(var_wpdb, 'wc_category_lookup'))])
	mut var_terms := rt.call_function('get_terms', [rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'fields', val: 'id=>parent' }])])
	mut var_hierarchy := rt.new_array()
	mut var_inserts := rt.new_array()
	this.unflatten_terms(var_hierarchy.dup(), var_terms.dup(), 0)
	this.get_term_insert_values(var_inserts.dup(), var_hierarchy.dup(), rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_inserts)))) {
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('implode', [rt.new_string(','), var_item.dup()])
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('implode', [rt.new_string(','), var_item.dup()])
	}
	mut var_insert_string := rt.call_function('implode', [rt.new_string('),('), rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_inserts.dup()])])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string(' (category_tree_id,category_id) VALUES (')), var_insert_string), rt.new_string(')'))])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) before_edit(var_category_id rt.PhpVal)  {
	mut var_category := rt.call_function('get_term', [var_category_id.dup(), rt.new_string('product_cat')])
	this.edited_product_cats.array_set(var_category_id, rt.get_property(var_category, 'parent'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) on_edit(var_category_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(this.edited_product_cats.array_isset(var_category_id)) {
		return rt.new_null()
	}
	mut var_category_object := rt.call_function('get_term', [var_category_id.dup(), rt.new_string('product_cat')])
	mut var_prev_parent := this.edited_product_cats.array_get(var_category_id)
	mut var_new_parent := rt.get_property(var_category_object, 'parent')
	if rt.is_true(rt.identical(var_prev_parent, var_new_parent)) {
		return rt.new_null()
	}
	this.delete(var_category_id.dup(), var_prev_parent.dup())
	this.update(var_category_id.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) on_create(var_category_id rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_transient', [rt.new_string('wc_installing')]))) {
		return rt.new_null()
	}
	this.update(var_category_id.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) delete(var_category_id rt.PhpVal, var_category_tree_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(var_category_tree_id)))) {
		return rt.new_null()
	}
	mut var_ancestors := rt.call_function('get_ancestors', [var_category_tree_id.dup(), rt.new_string('product_cat'), rt.new_string('taxonomy')])
	var_ancestors.array_push(var_category_tree_id.dup())
	mut var_children := rt.call_function('get_term_children', [var_category_id.dup(), rt.new_string('product_cat')])
	var_children.array_push(var_category_id.dup())
	mut var_id_list := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('intval'), rt.call_function('array_unique', [rt.call_function('array_filter', [var_children.dup()])])])])
	{
		mut iter_1 := var_ancestors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_ancestor := item_1.val
			rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string(' WHERE category_tree_id = %d AND category_id IN (')), var_id_list), rt.new_string(')')), var_ancestor.dup()])])
			// unsupported statement: Stmt_Nop
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) update(var_category_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_ancestors := rt.call_function('get_ancestors', [var_category_id.dup(), rt.new_string('product_cat'), rt.new_string('taxonomy')])
	mut var_children := rt.call_function('get_term_children', [var_category_id.dup(), rt.new_string('product_cat')])
	mut var_inserts := rt.new_array()
	var_inserts.array_push(this.get_insert_sql(var_category_id.dup(), var_category_id.dup()))
	mut var_children_ids := rt.call_function('array_map', [rt.new_string('intval'), rt.call_function('array_unique', [rt.call_function('array_filter', [var_children.dup()])])])
	{
		mut iter_1 := var_ancestors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_ancestor := item_1.val
			var_inserts.array_push(this.get_insert_sql(var_category_id.dup(), var_ancestor.dup()))
			{
				mut iter_2 := var_children_ids.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_child_category_id := item_2.val
					var_inserts.array_push(this.get_insert_sql(var_child_category_id.dup(), var_ancestor.dup()))
				}
			}
		}
	}
	mut var_insert_string := rt.call_function('implode', [rt.new_string(','), var_inserts.dup()])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string(' (category_id, category_tree_id) VALUES ')), var_insert_string)])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) get_insert_sql(var_category_id rt.PhpVal, var_category_tree_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'prepare', [rt.new_string('(%d,%d)'), var_category_id.dup(), var_category_tree_id.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) get_term_insert_values(var_inserts rt.PhpVal, var_terms rt.PhpVal, var_parents rt.PhpVal)  {
	mut var_inserts_mutated := var_inserts
	mut var_terms_mutated := var_terms
	{
		mut iter_1 := var_terms_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_insert_parents := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_term.array_get('term_id') }]), var_parents.dup()])
			{
				mut iter_2 := var_insert_parents.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_parent := item_2.val
					var_inserts_mutated.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_parent }, rt.ArrayItem{ key: none, val: var_term.array_get('term_id') }]))
				}
			}
			this.get_term_insert_values(var_inserts_mutated.dup(), var_term.array_get('descendants'), var_insert_parents.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) unflatten_terms(var_hierarchy rt.PhpVal, var_terms rt.PhpVal, parent i64)  {
	mut var_hierarchy_mutated := var_hierarchy
	mut var_terms_mutated := var_terms
	{
		mut iter_1 := var_terms_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_parent_id := item_1.val
			mut var_term_id := item_1.key
			if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, rt.new_int(parent))) {
				var_hierarchy_mutated.array_set(var_term_id, rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term_id }, rt.ArrayItem{ key: 'descendants', val: rt.new_array() }]))
				var_terms_mutated.array_unset(var_term_id)
			}
		}
	}
	{
		mut iter_1 := var_hierarchy_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_terms_array := item_1.val
			mut var_term_id := item_1.key
			this.unflatten_terms(var_hierarchy_mutated.array_get(var_term_id).array_get('descendants'), var_terms_mutated.dup(), (var_term_id).to_i64())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) get_descendants(var_category_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_function('wp_parse_id_list', [rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT category_id FROM '), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string(' WHERE category_tree_id = %d')), var_category_id.dup()])])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) get_ancestors(var_category_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_function('wp_parse_id_list', [rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT category_tree_id FROM '), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string(' WHERE category_id = %d')), var_category_id.dup()])])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup.define_category_lookup_tables_in_wpdb()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_tables := rt.create_array([rt.ArrayItem{ key: 'wc_category_lookup', val: 'wc_category_lookup' }])
	{
		mut iter_1 := var_tables.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table := item_1.val
			mut var_name := item_1.key
			rt.set_property(var_wpdb, '{"nodeType":"Expr_Variable","line":305,"name":"name"}', rt.concat(rt.get_property(var_wpdb, 'prefix'), var_table))
			rt.get_property(var_wpdb, 'tables').array_push(var_table.dup())
		}
	}
}

fn create_automattic_woocommerce_internal_admin_categorylookup() &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup{
		PhpObjectBase: rt.PhpObjectBase{}
		edited_product_cats: rt.new_array()
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'regenerate' {
			this.regenerate()
			return rt.new_null()
		}
		'before_edit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.before_edit(dispatch_arg_0)
			return rt.new_null()
		}
		'on_edit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_edit(dispatch_arg_0)
			return rt.new_null()
		}
		'on_create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_create(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'get_insert_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_insert_sql(dispatch_arg_0, dispatch_arg_1)
		}
		'get_term_insert_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.get_term_insert_values(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'unflatten_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.unflatten_terms(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_descendants' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_descendants(dispatch_arg_0)
		}
		'get_ancestors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_ancestors(dispatch_arg_0)
		}
		'define_category_lookup_tables_in_wpdb' {
			Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup.define_category_lookup_tables_in_wpdb()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'edited_product_cats' { return this.edited_product_cats }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_CategoryLookup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'edited_product_cats' { this.edited_product_cats = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_categorylookup_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
