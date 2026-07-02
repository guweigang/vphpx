import rt

pub fn Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData.cache_group() string {
	return 'wc_taxonomy_hierarchy'
}

struct Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData {
	rt.PhpObjectBase
pub mut:
	hierarchy_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) get_hierarchy_map(taxonomy string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
		rt.new_string(taxonomy),
	])))))
	{
		return rt.new_array()
	}
	if this.hierarchy_data.array_isset(rt.new_string(taxonomy)) {
		return this.hierarchy_data.array_get(rt.new_string(taxonomy))
	}
	mut var_cache_key := rt.new_string(
		(Class_Automattic_WooCommerce_Internal_ProductFilters_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData.cache_group()).str() + '_' + taxonomy)
	mut var_cached_map := rt.new_null()
	if !(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG'))) {
		var_cached_map = rt.call_function('get_option', [var_cache_key.clone()])
	}
	if !(!rt.is_true(var_cached_map)) && this.validate_cache(var_cached_map.clone()) {
		this.hierarchy_data.array_set(taxonomy, var_cached_map.clone())
		return var_cached_map.clone()
	}
	mut var_map := this.build_full_hierarchy_map(taxonomy)
	if !(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG'))) {
		rt.call_function('update_option', [var_cache_key.clone(),
			var_map.clone(), rt.new_bool(false)])
	}
	this.hierarchy_data.array_set(taxonomy, var_map.clone())
	return var_map.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) get_descendants(term_id i64, taxonomy string) rt.PhpVal {
	mut term_id_mutated := term_id
	mut var_map := this.get_hierarchy_map(taxonomy)
	return if !(var_map.array_get(rt.new_string('descendants')).array_get(rt.new_int(term_id_mutated))).is_null() {
		var_map.array_get(rt.new_string('descendants')).array_get(rt.new_int(term_id_mutated))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) get_ancestors(term_id i64, taxonomy string) rt.PhpVal {
	mut term_id_mutated := term_id
	mut var_map := this.get_hierarchy_map(taxonomy)
	return if !(var_map.array_get(rt.new_string('ancestors')).array_get(rt.new_int(term_id_mutated))).is_null() {
		var_map.array_get(rt.new_string('ancestors')).array_get(rt.new_int(term_id_mutated))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) clear_cache(taxonomy string) {
	this.hierarchy_data.array_unset(rt.new_string(taxonomy))
	mut var_cache_key := rt.new_string(
		(Class_Automattic_WooCommerce_Internal_ProductFilters_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData.cache_group()).str() + '_' + taxonomy)
	rt.call_function('delete_option', [var_cache_key.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) validate_cache(var_data rt.PhpVal) bool {
	return var_data.clone().is_array()
		&& rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string('descendants'))))
		&& rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string('ancestors'))))
		&& rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string('tree'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) build_full_hierarchy_map(taxonomy string) rt.PhpVal {
	mut var_terms := rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy },
			rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'orderby', val: 'name' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) || !rt.is_true(var_terms) {
		return rt.new_array()
	}
	mut var_map := rt.create_array([
		rt.ArrayItem{ key: 'descendants', val: rt.new_array() },
		rt.ArrayItem{ key: 'ancestors', val: rt.new_array() },
		rt.ArrayItem{ key: 'tree', val: rt.new_array() },
	])
	mut var_temp_children := rt.new_array()
	mut var_temp_parents := rt.new_array()
	mut var_temp_terms := rt.new_array()
	rt.call_function('update_termmeta_cache', [
		rt.call_function('wp_list_pluck', [var_terms.clone(),
			rt.new_string('term_id')]),
	])
	mut iter_1 := var_terms.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_term := item_1.val
		mut var_term_id := rt.get_property(var_term, 'term_id')
		mut var_parent_id := rt.get_property(var_term, 'parent')
		var_temp_parents.array_set(var_term_id, var_parent_id.clone())
		if !(var_temp_children.array_isset(var_parent_id)) {
			var_temp_children.array_set(var_parent_id, rt.new_array())
		}
		var_temp_children.array_get_mut(var_parent_id).array_push(var_term_id.clone())
		mut var_menu_order := rt.call_function('get_term_meta', [
			var_term_id.clone(), rt.new_string('order'), rt.new_bool(true)])
		var_temp_terms.array_set(var_term_id, rt.create_array([
			rt.ArrayItem{ key: 'slug', val: rt.get_property(var_term, 'slug') },
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_term, 'name') },
			rt.ArrayItem{ key: 'parent', val: var_parent_id },
			rt.ArrayItem{ key: 'term_id', val: rt.get_property(var_term, 'term_id') },
			rt.ArrayItem{
				key: 'menu_order'
				val: if var_menu_order.clone().is_long() || var_menu_order.clone().is_double() {
					rt.new_int(var_menu_order.to_i64())
				} else {
					0
				}
			},
		]))
	}
	mut iter_2 := rt.func_array_keys(var_temp_parents.clone()).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term_id := item_2.val
		var_map.array_get_mut('descendants').array_set(var_term_id, this.compute_descendants(var_term_id.to_i64(), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_temp_children)))
		var_map.array_get_mut('ancestors').array_set(var_term_id, this.compute_ancestors(var_term_id.to_i64(), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_temp_parents)))
	}
	mut iter_3 := var_temp_children.array_get(rt.new_int(0)).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_term_id := item_3.val
		this.build_term_tree(var_map.array_get(rt.new_string('tree')), var_term_id.clone(),
			var_temp_children.clone(), var_temp_terms.clone(), 0)
	}
	return var_map.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) build_term_tree(var_tree rt.PhpVal, var_term_id rt.PhpVal, var_children rt.PhpVal, var_temp_terms rt.PhpVal, depth i64) {
	mut var_tree_mutated := var_tree
	mut var_term_id_mutated := var_term_id
	mut var_temp_terms_mutated := var_temp_terms
	var_tree_mutated.array_set(var_term_id_mutated,
		var_temp_terms_mutated.array_get(var_term_id_mutated))
	var_tree_mutated.array_get_mut(var_term_id_mutated).array_set('depth', depth)
	if !(!rt.is_true(var_children.array_get(var_term_id_mutated))) {
		mut iter_4 := var_children.array_get(var_term_id_mutated).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_child_id := item_4.val
			this.build_term_tree(var_tree_mutated.array_get(var_term_id_mutated).array_get(rt.new_string('children')),
				var_child_id.clone(), var_children.clone(), var_temp_terms_mutated.clone(), depth +
				1)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) compute_descendants(term_id i64, mut var_children Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut term_id_mutated := term_id
	mut var_descendants := rt.new_array()
	if !(var_children.array_isset(rt.new_int(term_id_mutated))) {
		return var_descendants.clone()
	}
	mut iter_5 := var_children.array_get(rt.new_int(term_id_mutated)).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_child_id := item_5.val
		var_descendants.array_push(var_child_id.clone())
		var_descendants = rt.call_function('array_merge', [var_descendants.clone(),
			this.compute_descendants(var_child_id.to_i64(), mut var_children)])
	}
	return rt.call_function('array_unique', [var_descendants.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) compute_ancestors(term_id i64, mut var_parent_lookup Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut term_id_mutated := term_id
	mut var_ancestors := rt.new_array()
	mut var_current_id := rt.new_int(term_id_mutated).clone()
	for var_parent_lookup.array_isset(var_current_id)
		&& rt.is_true(rt.greater(var_parent_lookup.array_get(var_current_id), rt.new_int(0))) {
		mut var_parent_id := var_parent_lookup.array_get(var_current_id)
		var_ancestors.array_push(var_parent_id.clone())
		var_current_id = var_parent_id.clone()
	}
	return var_ancestors.clone()
}

fn create_automattic_woocommerce_internal_productfilters_taxonomyhierarchydata(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData{
		PhpObjectBase:  rt.PhpObjectBase{}
		hierarchy_data: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_hierarchy_map' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_hierarchy_map(dispatch_arg_0)
		}
		'get_descendants' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_descendants(dispatch_arg_0, dispatch_arg_1)
		}
		'get_ancestors' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_ancestors(dispatch_arg_0, dispatch_arg_1)
		}
		'clear_cache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.clear_cache(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_cache(dispatch_arg_0))
		}
		'build_full_hierarchy_map' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.build_full_hierarchy_map(dispatch_arg_0)
		}
		'build_term_tree' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			this.build_term_tree(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'compute_descendants' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.compute_descendants(dispatch_arg_0, mut dispatch_arg_1)
		}
		'compute_ancestors' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.compute_ancestors(dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hierarchy_data' { return this.hierarchy_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hierarchy_data' {
			this.hierarchy_data = val
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
