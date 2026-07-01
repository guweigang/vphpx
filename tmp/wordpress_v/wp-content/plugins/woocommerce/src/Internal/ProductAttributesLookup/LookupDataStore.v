import rt

pub fn Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_none() i64 {
	return 0
}
pub fn Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert() i64 {
	return 1
}
pub fn Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_update_stock() i64 {
	return 2
}
pub fn Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete() i64 {
	return 3
}
struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore {
	rt.PhpObjectBase
pub mut:
		lookup_table_name rt.PhpVal = rt.new_null()
		optimized_db_access_is_enabled bool
		last_create_operation_failed bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) construct()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.lookup_table_name = (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_product_attributes_lookup'
	this.optimized_db_access_is_enabled = rt.is_true(this.can_use_optimized_db_access()) && rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_optimized_updates')])))
	this.init_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) init_hooks()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_run_product_attribute_lookup_update_callback'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_update_callback' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_sections_products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_advanced_section_to_product_settings' }]), rt.new_int(100), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_insert_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_product_created_or_updated_via_rest_api' }]), rt.new_int(100), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_settings_products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_product_attributes_lookup_table_settings' }]), rt.new_int(100), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) can_use_optimized_db_access() rt.PhpVal {
	return rt.call_function('is_a', [rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product')), 'get_current_class_name', []rt.PhpVal{}), rt.new_string('WC_Product_Data_Store_CPT'), rt.new_bool(true)])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception') {
		mut var_ex := var_e_1.dup()
		return rt.new_bool(false)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) check_lookup_table_exists() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'), rt.call_method(var_wpdb, 'esc_like', [this.lookup_table_name])])
	return rt.identical(this.lookup_table_name, rt.call_method(var_wpdb, 'get_var', [var_query.dup()]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_lookup_table_name() rt.PhpVal {
	return this.lookup_table_name
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_last_create_operation_failed() bool {
	return this.last_create_operation_failed
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) on_product_changed(var_product rt.PhpVal, var_changeset rt.PhpVal)  {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(this.check_lookup_table_exists())))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product_mutated.dup(), Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product.class()]))))) {
		var_product_mutated = rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_product'), var_product_mutated.dup()])
	}
	mut var_action := this.get_update_action(var_changeset.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.maybe_schedule_update((rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).to_i64(), (var_action).to_i64())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) maybe_schedule_update(product_id i64, action i64)  {
	mut product_id_mutated := product_id
	mut action_mutated := action
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_direct_updates')]), rt.new_string('yes'))) {
		this.run_update_callback(product_id_mutated, action_mutated)
		return rt.new_null()
	}
	mut var_args := rt.create_array([rt.ArrayItem{ key: none, val: product_id_mutated }, rt.ArrayItem{ key: none, val: action_mutated }])
	mut var_queue := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_instance_of', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Queue.class()])
	mut var_already_scheduled := rt.call_method(var_queue, 'search', [rt.create_array([rt.ArrayItem{ key: 'hook', val: 'woocommerce_run_product_attribute_lookup_update_callback' }, rt.ArrayItem{ key: 'args', val: var_args }, rt.ArrayItem{ key: 'status', val: Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_ActionScheduler_Store.status_pending() }]), rt.new_string('ids')])
	if !rt.is_true(var_already_scheduled) {
		rt.call_method(var_queue, 'schedule_single', [rt.add(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('time')]), rt.new_int(1)), rt.new_string('woocommerce_run_product_attribute_lookup_update_callback'), var_args.dup(), rt.new_string('woocommerce-db-updates')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) run_update_callback(product_id i64, action i64)  {
	mut product_id_mutated := product_id
	mut action_mutated := action
	if rt.is_true(rt.new_bool(!(rt.is_true(this.check_lookup_table_exists())))) {
		return rt.new_null()
	}
	mut var_product := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_product'), rt.new_int(product_id_mutated).dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		action_mutated = (Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete()).to_i64()
	}
	mut switch_val_1 := rt.new_int(action_mutated)
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert())) {
		this.delete_data_for(product_id_mutated)
		if rt.is_true(this.optimized_db_access_is_enabled) {
			this.create_data_for_product_cpt(product_id_mutated)
		} else {
			this.create_data_for(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](var_product))
		}
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_update_stock())) {
		this.update_stock_status_for(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](var_product))
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete())) {
		this.delete_data_for(product_id_mutated)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_update_action(var_changeset rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_changeset.dup().is_null())) {
		return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert()
	}
	mut var_keys := rt.func_array_keys(var_changeset.dup())
	if rt.is_true(rt.call_function('in_array', [rt.new_string('catalog_visibility'), var_keys.dup(), rt.new_bool(true)])) {
		mut var_new_visibility := var_changeset.array_get('catalog_visibility')
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible(), var_new_visibility)) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog(), var_new_visibility)))) {
			return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert()
		} else {
			return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete()
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('attributes'), var_keys.dup(), rt.new_bool(true)])) {
		return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert()
	}
	if rt.is_true(rt.call_function('array_intersect', [var_keys.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'stock_quantity' }, rt.ArrayItem{ key: none, val: 'stock_status' }, rt.ArrayItem{ key: none, val: 'manage_stock' }])])) {
		return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_update_stock()
	}
	return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_none()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) update_stock_status_for(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product)  {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
	// unsupported statement: Stmt_Global
	mut var_in_stock := rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{})
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('UPDATE %i SET in_stock = %d WHERE product_id = %d'), this.lookup_table_name, if rt.is_true(var_in_stock) { rt.new_int(1) } else { rt.new_int(0) }, rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) on_product_deleted(var_product rt.PhpVal)  {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(this.check_lookup_table_exists())))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_a', [var_product_mutated.dup(), Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product.class()])) {
		mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	} else {
		var_product_id = var_product_mutated.dup()
	}
	this.maybe_schedule_update((var_product_id).to_i64(), (Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete()).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_product(var_product rt.PhpVal, use_optimized_db_access bool)  {
	mut var_product_mutated := var_product
	if var_use_optimized_db_access {
		mut var_product_id := rt.new_int(rt.new_int(if rt.is_true(rt.new_bool(rt.instance_of(var_product_mutated, 'Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product'))) { rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}) } else { var_product_mutated }.to_i64()))
		this.create_data_for_product_cpt((var_product_id).to_i64())
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product_mutated.dup(), Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product.class()]))))) {
			var_product_mutated = rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_product'), var_product_mutated.dup()])
		}
		this.delete_data_for((rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).to_i64())
		this.create_data_for(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](var_product_mutated))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product)  {
	mut var_product_mutated := var_product
	this.last_create_operation_failed = false
	if rt.is_true(this.is_variation(mut var_product_mutated)) {
		this.create_data_for_variation(mut var_product_mutated)
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else if rt.is_true(this.is_variable_product(mut var_product_mutated)) {
		this.create_data_for_variable_product(mut var_product_mutated)
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else {
		this.create_data_for_simple_product(mut var_product_mutated)
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception') {
		mut var_e := var_e_2.dup()
		mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_logger')]), 'error', ["Lookup data creation (not optimized) failed for product ${var_product_id.to_string()}: " + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'palt-updates' }, rt.ArrayItem{ key: 'exception', val: var_e }, rt.ArrayItem{ key: 'product_id', val: var_product_id }])])
		this.last_create_operation_failed = true
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) delete_data_for(product_id i64)  {
	mut var_wpdb := rt.new_null()
	mut product_id_mutated := product_id
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('DELETE FROM %i WHERE product_or_parent_id = %d'), this.lookup_table_name, rt.new_int(product_id_mutated).dup()])])
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('DELETE FROM %i WHERE product_id = %d'), this.lookup_table_name, rt.new_int(product_id_mutated).dup()])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_simple_product(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product)  {
	mut var_product_mutated := var_product
	mut var_product_attributes_data := this.get_attribute_taxonomies(mut var_product_mutated)
	mut var_has_stock := rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{})
	mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	{
		mut iter_1 := var_product_attributes_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_taxonomy := item_1.key
			mut var_term_ids := var_data.array_get('term_ids')
			{
				mut iter_2 := var_term_ids.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_term_id := item_2.val
					this.insert_lookup_table_data((var_product_id).to_i64(), (var_product_id).to_i64(), (var_taxonomy).str(), (var_term_id).to_i64(), false, (var_has_stock).to_bool())
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_variable_product(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable)  {
	mut var_product_mutated := var_product
	mut var_product_attributes_data := this.get_attribute_taxonomies(mut var_product_mutated)
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_item.array_get('used_for_variations')
	}
	mut var_variation_attributes_data := rt.call_function('array_filter', [var_product_attributes_data.dup(), rt.new_closure(closure_1_fn)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.is_true(var_item.array_get('used_for_variations'))))
	}
	mut var_non_variation_attributes_data := rt.call_function('array_filter', [var_product_attributes_data.dup(), rt.new_closure(closure_2_fn)])
	mut var_main_product_has_stock := rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{})
	mut var_main_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	{
		mut iter_1 := var_non_variation_attributes_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_taxonomy := item_1.key
			mut var_term_ids := var_data.array_get('term_ids')
			{
				mut iter_2 := var_term_ids.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_term_id := item_2.val
					this.insert_lookup_table_data((var_main_product_id).to_i64(), (var_main_product_id).to_i64(), (var_taxonomy).str(), (var_term_id).to_i64(), false, (var_main_product_has_stock).to_bool())
				}
			}
		}
	}
	mut var_term_ids_by_slug_cache := this.get_term_ids_by_slug_cache(rt.func_array_keys(var_variation_attributes_data.dup()))
	mut var_variations := this.get_variations_of(mut var_product_mutated)
	{
		mut iter_1 := var_variation_attributes_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_taxonomy := item_1.key
			{
				mut iter_2 := var_variations.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_variation := item_2.val
					this.insert_lookup_table_data_for_variation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](var_variation), (var_taxonomy).str(), (var_main_product_id).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](var_data.array_get('term_ids')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](var_term_ids_by_slug_cache))
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_variation(mut var_variation Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation)  {
	mut var_main_product := rt.call_method(, 'call_function', [, ])
	if rt.is_true(rt.identical(, )) {
		
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) insert_lookup_table_data_for_variation(mut var_variation Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation, taxonomy string, main_product_id i64, mut var_term_ids Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_term_ids_by_slug_cache Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	mut main_product_id_mutated := main_product_id
	mut var_term_ids_mutated := var_term_ids
	mut var_term_ids_by_slug_cache_mutated := var_term_ids_by_slug_cache
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_term_ids_by_slug_cache(var_taxonomies rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_variation_definition_term_id(mut var_variation Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation, taxonomy string, mut var_term_ids_by_slug_cache Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	mut var_term_ids_by_slug_cache_mutated := var_term_ids_by_slug_cache
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_variations_of(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) is_variable_product(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) is_variation(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_attribute_taxonomies(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) insert_lookup_table_data(product_id i64, product_or_parent_id i64, taxonomy string, term_id i64, is_variation_attribute bool, has_stock bool)  {
	mut var_wpdb := rt.new_null()
	mut product_id_mutated := product_id
	mut term_id_mutated := term_id
	mut has_stock_mutated := has_stock
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) on_product_created_or_updated_via_rest_api(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Post, mut var_request Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_REST_Request)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) regeneration_is_in_progress() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) set_regeneration_in_progress_flag()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) unset_regeneration_in_progress_flag()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) set_regeneration_aborted_flag()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) unset_regeneration_aborted_flag()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) regeneration_was_aborted() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) lookup_table_has_data() bool {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) add_advanced_section_to_product_settings(mut var_products Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	mut var_products_mutated := var_products
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) add_product_attributes_lookup_table_settings(mut var_settings Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, section_id string) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) optimized_data_access_is_enabled() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_product_cpt(product_id i64)  {
	mut product_id_mutated := product_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_product_cpt_core(product_id i64)  {
	mut var_wpdb := rt.new_null()
	mut var_item := rt.new_null()
	mut var_slug := rt.new_null()
	mut product_id_mutated := product_id
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productattributeslookup_lookupdatastore() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		lookup_table_name: rt.new_null()
		optimized_db_access_is_enabled: false
		last_create_operation_failed: false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_wc_data_store() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'can_use_optimized_db_access' {
			return this.can_use_optimized_db_access()
		}
		'check_lookup_table_exists' {
			return this.check_lookup_table_exists()
		}
		'get_lookup_table_name' {
			return this.get_lookup_table_name()
		}
		'get_last_create_operation_failed' {
			return rt.new_bool(this.get_last_create_operation_failed())
		}
		'on_product_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.on_product_changed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_schedule_update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.maybe_schedule_update(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'run_update_callback' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.run_update_callback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_update_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_update_action(dispatch_arg_0)
		}
		'update_stock_status_for' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.update_stock_status_for(mut dispatch_arg_0)
			return rt.new_null()
		}
		'on_product_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_product_deleted(dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.create_data_for_product(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'create_data_for' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.create_data_for(mut dispatch_arg_0)
			return rt.new_null()
		}
		'delete_data_for' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.delete_data_for(dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_simple_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.create_data_for_simple_product(mut dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_variable_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable](if args.len > 0 { args[0] } else { rt.new_null() })
			this.create_data_for_variable_product(mut dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_variation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](if args.len > 0 { args[0] } else { rt.new_null() })
			this.create_data_for_variation(mut dispatch_arg_0)
			return rt.new_null()
		}
		'insert_lookup_table_data_for_variation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.insert_lookup_table_data_for_variation(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'get_term_ids_by_slug_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_term_ids_by_slug_cache(dispatch_arg_0)
		}
		'get_variation_definition_term_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_variation_definition_term_id(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_variations_of' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_variations_of(mut dispatch_arg_0)
		}
		'is_variable_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.is_variable_product(mut dispatch_arg_0)
		}
		'is_variation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.is_variation(mut dispatch_arg_0)
		}
		'get_attribute_taxonomies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_attribute_taxonomies(mut dispatch_arg_0)
		}
		'insert_lookup_table_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			this.insert_lookup_table_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'on_product_created_or_updated_via_rest_api' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			this.on_product_created_or_updated_via_rest_api(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'regeneration_is_in_progress' {
			return this.regeneration_is_in_progress()
		}
		'set_regeneration_in_progress_flag' {
			this.set_regeneration_in_progress_flag()
			return rt.new_null()
		}
		'unset_regeneration_in_progress_flag' {
			this.unset_regeneration_in_progress_flag()
			return rt.new_null()
		}
		'set_regeneration_aborted_flag' {
			this.set_regeneration_aborted_flag()
			return rt.new_null()
		}
		'unset_regeneration_aborted_flag' {
			this.unset_regeneration_aborted_flag()
			return rt.new_null()
		}
		'regeneration_was_aborted' {
			return rt.new_bool(this.regeneration_was_aborted())
		}
		'lookup_table_has_data' {
			return rt.new_bool(this.lookup_table_has_data())
		}
		'add_advanced_section_to_product_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_advanced_section_to_product_settings(mut dispatch_arg_0)
		}
		'add_product_attributes_lookup_table_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.add_product_attributes_lookup_table_settings(mut dispatch_arg_0, dispatch_arg_1)
		}
		'optimized_data_access_is_enabled' {
			return this.optimized_data_access_is_enabled()
		}
		'create_data_for_product_cpt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.create_data_for_product_cpt(dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_product_cpt_core' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.create_data_for_product_cpt_core(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'lookup_table_name' { return this.lookup_table_name }
		'optimized_db_access_is_enabled' { return rt.new_bool(this.optimized_db_access_is_enabled) }
		'last_create_operation_failed' { return rt.new_bool(this.last_create_operation_failed) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'lookup_table_name' { this.lookup_table_name = val; return true }
		'optimized_db_access_is_enabled' { this.optimized_db_access_is_enabled = (val).to_bool(); return true }
		'last_create_operation_failed' { this.last_create_operation_failed = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productattributeslookup_lookupdatastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
