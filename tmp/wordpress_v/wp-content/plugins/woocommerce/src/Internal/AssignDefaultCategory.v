import rt

struct Class_Automattic_WooCommerce_Internal_AssignDefaultCategory {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_AssignDefaultCategory) init()  {
	rt.call_function('add_action', [rt.new_string('wc_schedule_update_product_default_cat'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_AssignDefaultCategory', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_assign_default_product_cat' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_AssignDefaultCategory) schedule_action()  {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'schedule_single', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('wc_schedule_update_product_default_cat'), rt.new_array(), rt.new_string('wc_update_product_default_cat')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_AssignDefaultCategory) maybe_assign_default_product_cat()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_default_category := rt.call_function('get_option', [rt.new_string('default_product_cat'), rt.new_int(0)])
	if rt.is_true(var_default_category) {
		mut var_affected_rows := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' (object_id, term_taxonomy_id)\n\t\t\t\t\tSELECT DISTINCT posts.ID, %s FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts\n\t\t\t\t\tLEFT JOIN\n\t\t\t\t\t\t(\n\t\t\t\t\t\t\tSELECT object_id FROM ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' term_relationships\n\t\t\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' term_taxonomy ON term_relationships.term_taxonomy_id = term_taxonomy.term_taxonomy_id\n\t\t\t\t\t\t\tWHERE term_taxonomy.taxonomy = \'product_cat\'\n\t\t\t\t\t\t) AS tax_query\n\t\t\t\t\tON posts.ID = tax_query.object_id\n\t\t\t\t\tWHERE posts.post_type = \'product\'\n\t\t\t\t\tAND tax_query.object_id IS NULL')), var_default_category.dup()])])
		if rt.is_true(rt.greater(var_affected_rows, rt.new_int(0))) {
			rt.call_function('wp_cache_flush', []rt.PhpVal{})
			rt.call_function('delete_transient', [rt.new_string('wc_term_counts')])
			rt.call_function('wp_update_term_count_now', [rt.create_array([rt.ArrayItem{ key: none, val: var_default_category }]), rt.new_string('product_cat')])
		}
	}
}

fn create_automattic_woocommerce_internal_assigndefaultcategory() &Class_Automattic_WooCommerce_Internal_AssignDefaultCategory {
	mut obj := &Class_Automattic_WooCommerce_Internal_AssignDefaultCategory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_AssignDefaultCategory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'schedule_action' {
			this.schedule_action()
			return rt.new_null()
		}
		'maybe_assign_default_product_cat' {
			this.maybe_assign_default_product_cat()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_AssignDefaultCategory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_AssignDefaultCategory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_assigndefaultcategory_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
