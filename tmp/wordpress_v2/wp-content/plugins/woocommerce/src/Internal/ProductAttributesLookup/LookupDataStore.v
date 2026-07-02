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
	lookup_table_name              rt.PhpVal = rt.new_null()
	optimized_db_access_is_enabled bool
	last_create_operation_failed   bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) construct() {
	mut var_wpdb := rt.new_null()
	this.lookup_table_name = (rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_product_attributes_lookup'
	this.optimized_db_access_is_enabled = this.can_use_optimized_db_access()
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_optimized_updates')])))
	this.init_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) init_hooks() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_run_product_attribute_lookup_update_callback'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_update_callback' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_sections_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_advanced_section_to_product_settings' },
		]),
		rt.new_int(100), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_insert_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_product_created_or_updated_via_rest_api' },
		]),
		rt.new_int(100), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_settings_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_product_attributes_lookup_table_settings' },
		]),
		rt.new_int(100), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) can_use_optimized_db_access() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('product'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('product'))
	return (rt.call_function('is_a', [
		rt.call_method(iife_result_0, 'get_current_class_name', []rt.PhpVal{}),
		rt.new_string('WC_Product_Data_Store_CPT'),
		rt.new_bool(true),
	])).to_bool()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception') {
		mut var_ex := var_e_1.clone()
		return false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) check_lookup_table_exists() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SHOW TABLES LIKE %s'),
		rt.call_method(var_wpdb, 'esc_like', [this.lookup_table_name]),
	])
	return rt.identical(this.lookup_table_name, rt.call_method(var_wpdb, 'get_var', [
		var_query.clone(),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_lookup_table_name() rt.PhpVal {
	return this.lookup_table_name
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_last_create_operation_failed() bool {
	return this.last_create_operation_failed
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) on_product_changed(var_product rt.PhpVal, var_changeset rt.PhpVal) {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(this.check_lookup_table_exists())))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product_mutated.clone(),
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product.class()])))))
	{
		var_product_mutated = rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
			'call_function', [rt.new_string('wc_get_product'),
			var_product_mutated.clone()])
	}
	mut var_action := this.get_update_action(var_changeset.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_none(),
		var_action))))
	{
		this.maybe_schedule_update((rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).to_i64(),
			var_action.to_i64())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) maybe_schedule_update(product_id i64, action i64) {
	mut product_id_mutated := product_id
	mut action_mutated := action
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_attribute_lookup_direct_updates'),
	]), rt.new_string('yes')))
	{
		this.run_update_callback(product_id_mutated, action_mutated)
		return
	}
	mut var_args := rt.create_array([rt.ArrayItem{ key: none, val: product_id_mutated },
		rt.ArrayItem{ key: none, val: action_mutated }])
	mut var_queue := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_instance_of', [
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Queue.class(),
	])
	mut var_already_scheduled := rt.call_method(var_queue, 'search', [
		rt.create_array([
			rt.ArrayItem{
				key: 'hook'
				val: 'woocommerce_run_product_attribute_lookup_update_callback'
			},
			rt.ArrayItem{ key: 'args', val: var_args },
			rt.ArrayItem{
				key: 'status'
				val: Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_ActionScheduler_Store.status_pending()
			},
		]),
		rt.new_string('ids'),
	])
	if !rt.is_true(var_already_scheduled) {
		rt.call_method(var_queue, 'schedule_single', [
			rt.add(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
				rt.new_string('time'),
			]), rt.new_int(1)),
			rt.new_string('woocommerce_run_product_attribute_lookup_update_callback'),
			var_args.clone(),
			rt.new_string('woocommerce-db-updates'),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) run_update_callback(product_id i64, action i64) {
	mut product_id_mutated := product_id
	mut action_mutated := action
	if rt.is_true(rt.new_bool(!(rt.is_true(this.check_lookup_table_exists())))) {
		return
	}
	mut var_product := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
		rt.new_string('wc_get_product'),
		rt.new_int(product_id_mutated).clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		action_mutated =
			(Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete()).to_i64()
	}
	mut switch_val_1 := rt.new_int(action_mutated)
	if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert()))
	{
		this.delete_data_for(product_id_mutated)
		if this.optimized_db_access_is_enabled {
			this.create_data_for_product_cpt(product_id_mutated)
		} else {
			this.create_data_for(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](var_product))
		}
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_update_stock()))
	{
		this.update_stock_status_for(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](var_product))
	} else if rt.is_true(rt.equal(switch_val_1,
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete()))
	{
		this.delete_data_for(product_id_mutated)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_update_action(var_changeset rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_changeset.clone().is_null())) {
		return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert()
	}
	mut var_keys := rt.func_array_keys(var_changeset.clone())
	if rt.is_true(rt.call_function('in_array', [rt.new_string('catalog_visibility'),
		var_keys.clone(), rt.new_bool(true)]))
	{
		mut var_new_visibility := var_changeset.array_get(rt.new_string('catalog_visibility'))
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible(), var_new_visibility))
			|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog(), var_new_visibility)) {
			return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert()
		} else {
			return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete()
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('attributes'),
		var_keys.clone(), rt.new_bool(true)]))
	{
		return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_insert()
	}
	if rt.is_true(rt.call_function('array_intersect', [var_keys.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'stock_quantity' },
			rt.ArrayItem{ key: none, val: 'stock_status' }, rt.ArrayItem{
				key: none
				val: 'manage_stock'
			}])]))
	{
		return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_update_stock()
	}
	return Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_none()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) update_stock_status_for(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
	mut var_in_stock := rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{})
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('UPDATE %i SET in_stock = %d WHERE product_id = %d'),
			this.lookup_table_name,
			rt.new_int(if rt.is_true(var_in_stock) { 1 } else { 0 }),
			rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) on_product_deleted(var_product rt.PhpVal) {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(this.check_lookup_table_exists())))) {
		return
	}
	if rt.is_true(rt.call_function('is_a', [var_product_mutated.clone(),
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product.class()]))
	{
		mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	} else {
		var_product_id = var_product_mutated.clone()
	}
	this.maybe_schedule_update(var_product_id.to_i64(),
		(Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.action_delete()).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_product(var_product rt.PhpVal, use_optimized_db_access bool) {
	mut var_product_mutated := var_product
	if var_use_optimized_db_access {
		mut var_product_id := rt.new_int(if rt.is_true(rt.new_bool(rt.instance_of(var_product_mutated,
			'Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product')))
		{
			rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
		} else {
			var_product_mutated
		}.to_i64())
		this.create_data_for_product_cpt(var_product_id.to_i64())
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
			var_product_mutated.clone(),
			Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product.class()])))))
		{
			var_product_mutated = rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
				'call_function', [rt.new_string('wc_get_product'),
				var_product_mutated.clone()])
		}
		this.delete_data_for((rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).to_i64())
		this.create_data_for(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](var_product_mutated))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) {
	mut var_product_mutated := var_product
	this.last_create_operation_failed = false
	if rt.is_true(this.is_variation(mut var_product_mutated)) {
		this.create_data_for_variation(mut var_product_mutated)
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	} else if rt.is_true(this.is_variable_product(mut var_product_mutated)) {
		this.create_data_for_variable_product(mut var_product_mutated)
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	} else {
		this.create_data_for_simple_product(mut var_product_mutated)
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception') {
		mut var_e := var_e_2.clone()
		mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
			rt.new_string('wc_get_logger'),
		]), 'error', [
			rt.new_string(
				'Lookup data creation (not optimized) failed for product ${var_product_id.to_string()}: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'palt-updates' },
				rt.ArrayItem{ key: 'exception', val: var_e },
				rt.ArrayItem{ key: 'product_id', val: var_product_id }]),
		])
		this.last_create_operation_failed = true
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) delete_data_for(product_id i64) {
	mut var_wpdb := rt.new_null()
	mut product_id_mutated := product_id
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('DELETE FROM %i WHERE product_or_parent_id = %d'),
			this.lookup_table_name,
			rt.new_int(product_id_mutated).clone(),
		]),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('DELETE FROM %i WHERE product_id = %d'),
			this.lookup_table_name,
			rt.new_int(product_id_mutated).clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_simple_product(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) {
	mut var_product_mutated := var_product
	mut var_product_attributes_data := this.get_attribute_taxonomies(mut var_product_mutated)
	mut var_has_stock := rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{})
	mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	mut iter_1 := var_product_attributes_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		mut var_taxonomy := item_1.key
		mut var_term_ids := var_data.array_get(rt.new_string('term_ids'))
		mut iter_2 := var_term_ids.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_term_id := item_2.val
			this.insert_lookup_table_data(var_product_id.to_i64(), var_product_id.to_i64(),
				var_taxonomy.str(), var_term_id.to_i64(), false, var_has_stock.to_bool())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_variable_product(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable) {
	mut var_product_mutated := var_product
	mut var_product_attributes_data := this.get_attribute_taxonomies(mut var_product_mutated)
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_variation_attributes_data := rt.call_function('array_filter', [
		var_product_attributes_data.clone(), rt.new_closure(closure_3_fn)])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_non_variation_attributes_data := rt.call_function('array_filter', [
		var_product_attributes_data.clone(),
		rt.new_closure(closure_4_fn),
	])
	mut var_main_product_has_stock := rt.call_method(var_product_mutated, 'is_in_stock',
		[]rt.PhpVal{})
	mut var_main_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	mut iter_3 := var_non_variation_attributes_data.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_data := item_3.val
		mut var_taxonomy := item_3.key
		mut var_term_ids := var_data.array_get(rt.new_string('term_ids'))
		mut iter_4 := var_term_ids.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_term_id := item_4.val
			this.insert_lookup_table_data(var_main_product_id.to_i64(),
				var_main_product_id.to_i64(), var_taxonomy.str(), var_term_id.to_i64(), false,
				var_main_product_has_stock.to_bool())
		}
	}
	mut var_term_ids_by_slug_cache :=
		this.get_term_ids_by_slug_cache(rt.func_array_keys(var_variation_attributes_data.clone()))
	mut var_variations := this.get_variations_of(mut var_product_mutated)
	mut iter_5 := var_variation_attributes_data.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_data := item_5.val
		mut var_taxonomy := item_5.key
		mut iter_6 := var_variations.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_variation := item_6.val
			this.insert_lookup_table_data_for_variation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](var_variation),
				var_taxonomy.str(), var_main_product_id.to_i64(), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](var_data.array_get(rt.new_string('term_ids'))), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](var_term_ids_by_slug_cache))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_variation(mut var_variation Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation) {
	mut var_main_product := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
		rt.new_string('wc_get_product'),
		var_variation.get_parent_id(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_main_product)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception',
			[]string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.concat(rt.concat(rt.new_string('The product is a variation, and the retrieval of data for the parent product (id '),
			var_variation.get_parent_id()), rt.new_string(') failed.')))))
	}
	mut var_product_attributes_data :=
		this.get_attribute_taxonomies(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](var_main_product))
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_variation_attributes_data := rt.call_function('array_filter', [
		var_product_attributes_data.clone(), rt.new_closure(closure_5_fn)])
	mut var_term_ids_by_slug_cache :=
		this.get_term_ids_by_slug_cache(rt.func_array_keys(var_variation_attributes_data.clone()))
	mut iter_7 := var_variation_attributes_data.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_data := item_7.val
		mut var_taxonomy := item_7.key
		this.insert_lookup_table_data_for_variation(mut var_variation, var_taxonomy.str(), (rt.call_method(var_main_product,
			'get_id', []rt.PhpVal{})).to_i64(), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](var_data.array_get(rt.new_string('term_ids'))), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](var_term_ids_by_slug_cache))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) insert_lookup_table_data_for_variation(mut var_variation Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation, taxonomy string, main_product_id i64, mut var_term_ids Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_term_ids_by_slug_cache Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) {
	mut main_product_id_mutated := main_product_id
	mut var_term_ids_mutated := var_term_ids
	mut var_term_ids_by_slug_cache_mutated := var_term_ids_by_slug_cache
	mut var_variation_id := var_variation.get_id()
	mut var_variation_has_stock := var_variation.is_in_stock()
	mut var_variation_definition_term_id := this.get_variation_definition_term_id(mut var_variation,
		taxonomy, mut var_term_ids_by_slug_cache_mutated)
	if rt.is_true(var_variation_definition_term_id) {
		this.insert_lookup_table_data(var_variation_id.to_i64(), main_product_id_mutated, taxonomy,
			var_variation_definition_term_id.to_i64(), true, var_variation_has_stock.to_bool())
	} else {
		mut var_term_ids_for_taxonomy := var_term_ids_mutated
		mut iter_8 := var_term_ids_for_taxonomy.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_term_id := item_8.val
			this.insert_lookup_table_data(var_variation_id.to_i64(), main_product_id_mutated,
				taxonomy, var_term_id.to_i64(), true, var_variation_has_stock.to_bool())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_term_ids_by_slug_cache(var_taxonomies rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_array()
	mut iter_9 := var_taxonomies.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_taxonomy := item_9.val
		mut var_terms := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
			rt.new_string('get_terms'),
			rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: rt.call_function('wc_sanitize_taxonomy_name', [
					var_taxonomy.clone(),
				]) },
				rt.ArrayItem{ key: 'hide_empty', val: false },
				rt.ArrayItem{ key: 'fields', val: 'id=>slug' },
			]),
		])
		var_result.array_set(var_taxonomy, rt.call_function('array_flip', [
			var_terms.clone()]))
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_variation_definition_term_id(mut var_variation Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation, taxonomy string, mut var_term_ids_by_slug_cache Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	mut var_term_ids_by_slug_cache_mutated := var_term_ids_by_slug_cache
	mut var_variation_attributes := var_variation.get_attributes()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_5 := iife_temp_5.get_value_or_default(var_variation_attributes.clone(),
		rt.new_string(taxonomy))
	mut var_term_slug := iife_result_5
	if rt.is_true(var_term_slug) {
		return var_term_ids_by_slug_cache_mutated.array_get(rt.new_string(taxonomy)).array_get(var_term_slug)
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_variations_of(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_variation_ids := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
			rt.new_string('wc_get_product'),
			var_id.clone(),
		])
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
			rt.new_string('wc_get_product'),
			var_id.clone(),
		])
	}
	return rt.call_function('array_map', [rt.new_closure(closure_7_fn),
		var_variation_ids.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) is_variable_product(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
	return rt.call_function('is_a', [var_product_mutated,
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) is_variation(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
	return rt.call_function('is_a', [var_product_mutated,
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) get_attribute_taxonomies(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_product_attributes := rt.call_method(var_product_mutated, 'get_attributes',
		[]rt.PhpVal{})
	mut var_result := rt.new_array()
	mut iter_10 := var_product_attributes.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_attribute_data := item_10.val
		mut var_taxonomy_name := item_10.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute_data, 'get_id',
			[]rt.PhpVal{})))))
		{
			continue
		}
		var_result.array_set(var_taxonomy_name, rt.create_array([
			rt.ArrayItem{ key: 'term_ids', val: rt.call_method(var_attribute_data, 'get_options',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'used_for_variations', val: rt.call_method(var_attribute_data,
				'get_variation', []rt.PhpVal{}) },
		]))
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) insert_lookup_table_data(product_id i64, product_or_parent_id i64, taxonomy string, term_id i64, is_variation_attribute bool, has_stock bool) {
	mut var_wpdb := rt.new_null()
	mut product_id_mutated := product_id
	mut term_id_mutated := term_id
	mut has_stock_mutated := has_stock
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('INSERT INTO %i (\n\t\t\t\t\t  product_id,\n\t\t\t\t\t  product_or_parent_id,\n\t\t\t\t\t  taxonomy,\n\t\t\t\t\t  term_id,\n\t\t\t\t\t  is_variation_attribute,\n\t\t\t\t\t  in_stock)\n\t\t\t\t\tVALUES\n\t\t\t\t\t  ( %d, %d, %s, %d, %d, %d )'),
			this.lookup_table_name,
			rt.new_int(product_id_mutated).clone(),
			rt.new_int(product_or_parent_id),
			rt.new_string(taxonomy),
			rt.new_int(term_id_mutated).clone(),
			rt.new_int(if var_is_variation_attribute { 1 } else { 0 }),
			rt.new_int(if rt.is_true(rt.new_bool(has_stock_mutated)) { 1 } else { 0 }),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) on_product_created_or_updated_via_rest_api(mut var_product Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Post, mut var_request Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_REST_Request) {
	mut var_product_mutated := var_product
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_8 := iife_temp_8.ends_with(var_request.get_route(), rt.new_string('/batch'))
	if rt.is_true(iife_result_8) {
		this.on_product_changed(rt.get_property(var_product_mutated, 'ID'), rt.new_null())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) regeneration_is_in_progress() rt.PhpVal {
	return rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_attribute_lookup_regeneration_in_progress'),
		rt.new_null(),
	]), rt.new_string('yes'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) set_regeneration_in_progress_flag() {
	rt.call_function('update_option', [
		rt.new_string('woocommerce_attribute_lookup_regeneration_in_progress'),
		rt.new_string('yes'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) unset_regeneration_in_progress_flag() {
	rt.call_function('delete_option', [
		rt.new_string('woocommerce_attribute_lookup_regeneration_in_progress'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) set_regeneration_aborted_flag() {
	rt.call_function('update_option', [
		rt.new_string('woocommerce_attribute_lookup_regeneration_aborted'),
		rt.new_string('yes'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) unset_regeneration_aborted_flag() {
	rt.call_function('delete_option', [
		rt.new_string('woocommerce_attribute_lookup_regeneration_aborted'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) regeneration_was_aborted() bool {
	return (rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_attribute_lookup_regeneration_aborted'),
	]), rt.new_string('yes'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) lookup_table_has_data() bool {
	mut var_wpdb := rt.new_null()
	return rt.new_bool(rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT EXISTS (SELECT 1 FROM '), this.lookup_table_name),
			rt.new_string(')')),
	])).to_i64()) != 0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) add_advanced_section_to_product_settings(mut var_products Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	mut var_products_mutated := var_products
	if rt.is_true(this.check_lookup_table_exists()) {
		var_products_mutated.array_set('advanced', rt.call_function('__', [
			rt.new_string('Advanced'),
			rt.new_string('woocommerce'),
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_array',
		[]string{}, var_products_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) add_product_attributes_lookup_table_settings(mut var_settings Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, section_id string) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.identical(rt.new_string('advanced'), rt.new_string(section_id)))
		&& rt.is_true(this.check_lookup_table_exists()) {
		mut var_title_item := rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Product attributes lookup table'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
		])
		mut var_regeneration_is_in_progress := this.regeneration_is_in_progress()
		if rt.is_true(var_regeneration_is_in_progress) {
			var_title_item.array_set('desc', rt.call_function('__', [
				rt.new_string('These settings are not available while the lookup table regeneration is in progress.'),
				rt.new_string('woocommerce'),
			]))
		}
		var_settings_mutated.array_push(var_title_item.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_regeneration_is_in_progress)))) {
			mut var_regeneration_aborted_warning := if this.regeneration_was_aborted() { rt.call_function('sprintf', [
					rt.new_string("<p><strong style='color: #E00000'>%s</strong></p><p>%s</p>"),
					rt.call_function('__', [
						rt.new_string('WARNING: The product attributes lookup table regeneration process was aborted.'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('__', [
						rt.new_string("This means that the table is probably in an inconsistent state. It's recommended to run a new regeneration process or to resume the aborted process (Status - Tools - Regenerate the product attributes lookup table/Resume the product attributes lookup table regeneration) before enabling the table usage."),
						rt.new_string('woocommerce'),
					]),
				]) } else { rt.new_null() }
			var_settings_mutated.array_push(rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Enable table usage'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Use the product attributes lookup table for catalog filtering.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc_tip', val: var_regeneration_aborted_warning },
				rt.ArrayItem{ key: 'id', val: 'woocommerce_attribute_lookup_enabled' },
				rt.ArrayItem{ key: 'default', val: 'no' },
				rt.ArrayItem{ key: 'type', val: 'checkbox' },
				rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			]))
			var_settings_mutated.array_push(rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Direct updates'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Update the table directly upon product changes, instead of scheduling a deferred update.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'id', val: 'woocommerce_attribute_lookup_direct_updates' },
				rt.ArrayItem{ key: 'default', val: 'no' },
				rt.ArrayItem{ key: 'type', val: 'checkbox' },
				rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			]))
			var_settings_mutated.array_push(rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Optimized updates'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
					rt.new_string('Uses much more performant queries to update the lookup table, but may not be compatible with some extensions.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
					rt.new_string('This setting only works when product data is stored in the posts table.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'id', val: 'woocommerce_attribute_lookup_optimized_updates' },
				rt.ArrayItem{ key: 'default', val: 'no' },
				rt.ArrayItem{ key: 'type', val: 'checkbox' },
				rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			]))
		}
		var_settings_mutated.array_push(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_array',
		[]string{}, var_settings_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) optimized_data_access_is_enabled() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_attribute_lookup_optimized_updates'),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_product_cpt(product_id i64) {
	mut product_id_mutated := product_id
	this.last_create_operation_failed = false
	this.create_data_for_product_cpt_core(product_id_mutated)
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception') {
		mut var_e := var_e_3.clone()
		mut var_data := rt.create_array([
			rt.ArrayItem{ key: 'source', val: 'palt-updates' },
			rt.ArrayItem{ key: 'product_id', val: product_id_mutated },
		])
		if rt.is_true(rt.new_bool(rt.instance_of(var_e,
			'Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception')))
		{
			var_data = rt.call_function('array_merge', [var_data.clone(),
				rt.call_method(var_e, 'getErrorData', []rt.PhpVal{})])
		} else {
			var_data.array_set('exception', var_e.clone())
		}
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
			rt.new_string('wc_get_logger'),
		]), 'error', [
			rt.new_string(
				'Lookup data creation (optimized) failed for product ${var_product_id.to_string()}: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			var_data.clone(),
		])
		this.last_create_operation_failed = true
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) create_data_for_product_cpt_core(product_id i64) {
	mut var_wpdb := rt.new_null()
	mut var_item := rt.new_null()
	mut var_slug := rt.new_null()
	mut product_id_mutated := product_id
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('DELETE FROM %i WHERE product_or_parent_id = %d'),
			this.lookup_table_name,
			rt.new_int(product_id_mutated).clone(),
		]),
	])
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('(select p.ID as id, null parent, m.meta_value as stock_status, t.name as product_type from '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' p\n\t\t\tleft join ')),
			rt.get_property(var_wpdb, 'postmeta')),
			rt.new_string(" m on p.id=m.post_id and m.meta_key='_stock_status'\n\t\t\tleft join ")), rt.get_property(var_wpdb,
			'term_relationships')), rt.new_string(' tr on tr.object_id=p.id\n\t\t\tleft join ')), rt.get_property(var_wpdb,
			'term_taxonomy')),
			rt.new_string(' tt on tt.term_taxonomy_id=tr.term_taxonomy_id\n\t\t\tleft join ')), rt.get_property(var_wpdb,
			'terms')),
			rt.new_string(" t on t.term_id=tt.term_id\n\t\t\twhere p.post_type = 'product'\n\t\t\tand p.post_status in ('publish', 'draft', 'pending', 'private')\n\t\t\tand tt.taxonomy='product_type'\n\t\t\tand t.name != 'exclude-from-search'\n\t\t\tand p.id=%d\n\t\t\tlimit 1)\n\t\t\t\tunion\n\t\t\t(select p.ID as id, p.post_parent as parent, m.meta_value as stock_status, 'variation' as product_type from ")), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' p\n\t\t\tleft join ')),
			rt.get_property(var_wpdb, 'postmeta')),
			rt.new_string(" m on p.id=m.post_id and m.meta_key='_stock_status'\n\t\t\twhere p.post_type = 'product_variation'\n\t\t\tand p.post_status in ('publish', 'draft', 'pending', 'private')\n\t\t\tand (p.ID=%d or p.post_parent=%d));\n\t\t")),
		rt.new_int(product_id_mutated).clone(),
		rt.new_int(product_id_mutated).clone(),
		rt.new_int(product_id_mutated).clone(),
	])
	mut var_product_ids_with_stock_status := rt.call_method(var_wpdb, 'get_results', [
		var_sql.clone(),
		rt.get_constant('ARRAY_A'),
	])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(),
			var_item.array_get(rt.new_string('product_type')))))
	}
	mut var_main_product_row := rt.call_function('array_filter', [
		var_product_ids_with_stock_status.clone(), rt.new_closure(closure_10_fn)])
	mut var_is_variation := rt.new_bool(!rt.is_true(var_main_product_row))
	mut var_main_product_id := if rt.is_true(var_is_variation) { rt.call_function('current', [
			var_product_ids_with_stock_status.clone(),
		]).array_get(rt.new_string('parent')) } else { rt.new_int(product_id_mutated) }
	mut var_is_variable_product := rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(var_is_variation))))
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), rt.call_function('current', [var_main_product_row.clone()]).array_get(rt.new_string('product_type')))))
	mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_10 := iife_temp_10.group_by_column(var_product_ids_with_stock_status.clone(),
		rt.new_string('id'), rt.new_bool(true))
	var_product_ids_with_stock_status = iife_result_10
	mut var_variation_ids := if rt.is_true(var_is_variation) {
		rt.create_array([rt.ArrayItem{ key: none, val: product_id_mutated }])
	} else {
		rt.func_array_keys(rt.call_function('array_diff_key', [
			var_product_ids_with_stock_status.clone(),
			rt.create_array([
				rt.ArrayItem{ key: product_id_mutated, val: rt.new_null() },
			])]))
	}
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_11 := iife_temp_11.select(var_product_ids_with_stock_status.clone(),
		rt.new_string('stock_status'))
	var_product_ids_with_stock_status = iife_result_11
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock(),
			var_item))
		{
			1
		} else {
			0
		}
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock(),
			var_item))
		{
			1
		} else {
			0
		}
	}
	var_product_ids_with_stock_status = rt.call_function('array_map', [
		rt.new_closure(closure_13_fn),
		var_product_ids_with_stock_status.clone(),
	])
	var_sql = rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.new_string('select meta_value from '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string(' where post_id=%d and meta_key=%s')),
		var_main_product_id.clone(),
		rt.new_string('_product_attributes'),
	])
	mut var_temp := rt.call_method(var_wpdb, 'get_var', [var_sql.clone()])
	if rt.is_true(rt.new_bool(var_temp.clone().is_null())) {
		return
	}
	var_temp = rt.call_function('unserialize', [var_temp.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_temp)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception',
			[]string{}, create_automattic_woocommerce_internal_productattributeslookup_wc_data_exception(rt.new_int(0),
			rt.new_string('The product attributes metadata row is not properly serialized'))))
	}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_slug := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut iife_temp_15 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_15 := iife_temp_15.starts_with(var_slug.clone(), rt.new_string('pa_'))
		return rt.new_bool(rt.is_true(iife_result_15)
			&& rt.is_true(rt.identical(rt.new_string(''), var_item.array_get(rt.new_string('value')))))
	}
	var_temp = rt.call_function('array_filter', [var_temp.clone(),
		rt.new_closure(closure_16_fn), rt.get_constant('ARRAY_FILTER_USE_BOTH')])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_int(0), var_item.array_get(rt.new_string('is_variation')))
	}
	mut var_attributes_not_for_variations := if rt.is_true(var_is_variation) || rt.is_true(var_is_variable_product) { rt.func_array_keys(rt.call_function('array_filter', [
			var_temp.clone(),
			rt.new_closure(closure_17_fn),
		])) } else { rt.func_array_keys(var_temp.clone()) }
	var_sql = rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('select tt.term_id, tt.taxonomy as attribute, t.slug from '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('term_relationships tr\n\t\t\tjoin ')), rt.get_property(var_wpdb,
			'term_taxonomy')),
			rt.new_string(' tt on tt.term_taxonomy_id = tr.term_taxonomy_id\n\t\t\tjoin ')), rt.get_property(var_wpdb,
			'terms')),
			rt.new_string(' t on t.term_id=tt.term_id\n\t\t\twhere tr.object_id=%d and taxonomy like %s;')),
		var_main_product_id.clone(),
		rt.new_string('pa_%'),
	])
	mut var_terms_used_per_attribute := rt.call_method(var_wpdb, 'get_results', [
		var_sql.clone(),
		rt.get_constant('ARRAY_A'),
	])
	mut iter_11 := var_terms_used_per_attribute.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_term := item_11.val
		var_term.array_set('attribute', rt.call_function('rawurlencode', [
			var_term.array_get(rt.new_string('attribute')),
		]).to_string().to_lower())
	}
	mut iife_temp_17 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_17 := iife_temp_17.group_by_column(var_terms_used_per_attribute.clone(),
		rt.new_string('attribute'))
	var_terms_used_per_attribute = iife_result_17
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_variation))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_variable_product))))
		|| !rt.is_true(var_variation_ids) {
		mut var_variations_defined := rt.new_array()
	} else {
		var_sql = rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('select post_id as variation_id, substr(meta_key,11) as attribute, meta_value as slug from '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string('\n\t\t\t\twhere post_id in (select ID from ')), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(" where (id=%d or post_parent=%d) and post_type = 'product_variation')\n\t\t\t\tand meta_key like %s\n\t\t\t\tand meta_value != ''")),
			rt.new_int(product_id_mutated).clone(),
			rt.new_int(product_id_mutated).clone(),
			rt.new_string('attribute_pa_%'),
		])
		var_variations_defined = rt.call_method(var_wpdb, 'get_results', [
			var_sql.clone(), rt.get_constant('ARRAY_A')])
		mut iife_temp_18 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_18 := iife_temp_18.group_by_column(var_variations_defined.clone(),
			rt.new_string('variation_id'))
		var_variations_defined = iife_result_18
	}
	mut var_insert_data := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_variation)))) {
		mut iter_12 := var_attributes_not_for_variations.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_attribute_name := item_12.val
			mut iter_13 := if !(var_terms_used_per_attribute.array_get(var_attribute_name)).is_null() {
				var_terms_used_per_attribute.array_get(var_attribute_name)
			} else {
				rt.new_array()
			}.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_attribute_data := item_13.val
				var_insert_data.array_push(rt.create_array([
					rt.ArrayItem{ key: none, val: product_id_mutated },
					rt.ArrayItem{ key: none, val: var_main_product_id },
					rt.ArrayItem{ key: none, val: var_attribute_name },
					rt.ArrayItem{
						key: none
						val: var_attribute_data.array_get(rt.new_string('term_id'))
					},
					rt.ArrayItem{ key: none, val: 0 },
					rt.ArrayItem{
						key: none
						val: var_product_ids_with_stock_status.array_get(rt.new_int(product_id_mutated))
					},
				]))
			}
		}
	}
	var_terms_used_per_attribute = rt.call_function('array_diff_key', [
		var_terms_used_per_attribute.clone(),
		rt.call_function('array_flip', [
			var_attributes_not_for_variations.clone()])])
	mut var_used_attributes_per_variation := rt.new_array()
	mut iter_14 := var_variations_defined.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_variation_data := item_14.val
		mut var_variation_id := item_14.key
		var_used_attributes_per_variation.array_set(var_variation_id, rt.new_array())
		mut iter_15 := var_variation_data.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_variation_attribute_data := item_15.val
			mut var_attribute_name :=
				var_variation_attribute_data.array_get(rt.new_string('attribute'))
			var_used_attributes_per_variation.array_get_mut(var_variation_id).array_push(var_attribute_name.clone())
			closure_20_fn := fn [var_variation_attribute_data] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.identical(var_item.array_get(rt.new_string('slug')),
					var_variation_attribute_data.array_get(rt.new_string('slug')))
			}
			closure_21_fn := fn [var_variation_attribute_data] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.identical(var_item.array_get(rt.new_string('slug')),
					var_variation_attribute_data.array_get(rt.new_string('slug')))
			}
			mut var_term_id := if !(rt.call_function('current', [
				rt.call_function('array_filter', [if !(var_terms_used_per_attribute.array_get(var_attribute_name)).is_null() {
					var_terms_used_per_attribute.array_get(var_attribute_name)
				} else {
					rt.new_array()
				}, rt.new_closure(closure_20_fn)]),
			]).array_get(rt.new_string('term_id'))).is_null() { rt.call_function('current', [
					rt.call_function('array_filter', [if !(var_terms_used_per_attribute.array_get(var_attribute_name)).is_null() {
						var_terms_used_per_attribute.array_get(var_attribute_name)
					} else {
						rt.new_array()
					}, rt.new_closure(closure_20_fn)]),
				]).array_get(rt.new_string('term_id'))
			 } else { rt.new_null()
			 }
			if rt.is_true(rt.new_bool(var_term_id.clone().is_null())) {
				continue
			}
			var_insert_data.array_push(rt.create_array([
				rt.ArrayItem{ key: none, val: var_variation_id },
				rt.ArrayItem{ key: none, val: var_main_product_id },
				rt.ArrayItem{ key: none, val: var_attribute_name },
				rt.ArrayItem{ key: none, val: var_term_id },
				rt.ArrayItem{ key: none, val: 1 },
				rt.ArrayItem{
					key: none
					val: if !(var_product_ids_with_stock_status.array_get(var_variation_id)).is_null() {
						var_product_ids_with_stock_status.array_get(var_variation_id)
					} else {
						rt.new_bool(false)
					}
				},
			]))
		}
	}
	mut iter_16 := var_used_attributes_per_variation.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_attributes_list := item_16.val
		mut var_variation_id := item_16.key
		mut var_any_attributes := rt.call_function('array_diff_key', [
			var_terms_used_per_attribute.clone(),
			rt.call_function('array_flip', [
				var_attributes_list.clone(),
			])])
		mut iter_17 := var_any_attributes.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_attributes_data := item_17.val
			mut iter_18 := var_attributes_data.iterator()
			for {
				item_18 := iter_18.next() or { break }
				mut var_attribute_data := item_18.val
				var_insert_data.array_push(rt.create_array([
					rt.ArrayItem{ key: none, val: var_variation_id },
					rt.ArrayItem{ key: none, val: var_main_product_id },
					rt.ArrayItem{
						key: none
						val: var_attribute_data.array_get(rt.new_string('attribute'))
					},
					rt.ArrayItem{
						key: none
						val: var_attribute_data.array_get(rt.new_string('term_id'))
					},
					rt.ArrayItem{ key: none, val: 1 },
					rt.ArrayItem{
						key: none
						val: if !(var_product_ids_with_stock_status.array_get(var_variation_id)).is_null() {
							var_product_ids_with_stock_status.array_get(var_variation_id)
						} else {
							rt.new_bool(false)
						}
					},
				]))
			}
		}
	}
	mut var_variations_with_all_any := rt.func_array_keys(rt.call_function('array_diff_key', [
		rt.call_function('array_flip', [var_variation_ids.clone()]),
		var_used_attributes_per_variation.clone(),
	]))
	mut iter_19 := var_variations_with_all_any.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_variation_id := item_19.val
		mut iter_20 := var_terms_used_per_attribute.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_attribute_terms := item_20.val
			mut var_attribute_name := item_20.key
			mut iter_21 := var_attribute_terms.iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_attribute_term := item_21.val
				var_insert_data.array_push(rt.create_array([
					rt.ArrayItem{ key: none, val: var_variation_id },
					rt.ArrayItem{ key: none, val: var_main_product_id },
					rt.ArrayItem{ key: none, val: var_attribute_name },
					rt.ArrayItem{
						key: none
						val: var_attribute_term.array_get(rt.new_string('term_id'))
					},
					rt.ArrayItem{ key: none, val: 1 },
					rt.ArrayItem{
						key: none
						val: if !(var_product_ids_with_stock_status.array_get(var_variation_id)).is_null() {
							var_product_ids_with_stock_status.array_get(var_variation_id)
						} else {
							rt.new_bool(false)
						}
					},
				]))
			}
		}
	}
	mut var_insert_data_chunks := rt.call_function('array_chunk', [
		var_insert_data.clone(), rt.new_int(100)])
	mut iter_22 := var_insert_data_chunks.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_insert_data_chunk := item_22.val
		var_sql = rt.new_string('INSERT INTO ' +
			(this.lookup_table_name).str() + ' (\n\t\t\t\t\t  product_id,\n\t\t\t\t\t  product_or_parent_id,\n\t\t\t\t\t  taxonomy,\n\t\t\t\t\t  term_id,\n\t\t\t\t\t  is_variation_attribute,\n\t\t\t\t\t  in_stock)\n\t\t\t\t\tVALUES (')
		mut var_values_strings := rt.new_array()
		mut iter_23 := var_insert_data_chunk.iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_dataset := item_23.val
			mut var_attribute_name := rt.call_function('esc_sql', [
				var_dataset.array_get(rt.new_int(2)),
			])
			var_values_strings.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_dataset.array_get(rt.new_int(0)),
				rt.new_string(',')), var_dataset.array_get(rt.new_int(1))), rt.new_string(",'")),
				var_attribute_name), rt.new_string("',")), var_dataset.array_get(rt.new_int(3))),
				rt.new_string(',')), var_dataset.array_get(rt.new_int(4))), rt.new_string(',')),
				var_dataset.array_get(rt.new_int(5))))
		}
		var_sql = rt.concat(var_sql, rt.new_string(
			(rt.call_function('implode', [rt.new_string('),('), var_values_strings.clone()])).str() +
			')'))
		mut var_result := rt.call_method(var_wpdb, 'query', [
			var_sql.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception',
				[]string{}, create_automattic_woocommerce_internal_productattributeslookup_wc_data_exception(rt.new_int(0),
				rt.new_string('INSERT statement failed'), rt.new_int(0), rt.create_array([
				rt.ArrayItem{ key: 'db_error', val: rt.call_function('esc_html', [
					rt.get_property(var_wpdb, 'last_error'),
				]) },
				rt.ArrayItem{ key: 'db_query', val: rt.call_function('esc_html', [
					rt.get_property(var_wpdb, 'last_query'),
				]) },
			]))))
		}
	}
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productattributeslookup_lookupdatastore() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore{
		PhpObjectBase:                  rt.PhpObjectBase{}
		lookup_table_name:              rt.new_null()
		optimized_db_access_is_enabled: false
		last_create_operation_failed:   false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_wc_data_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception{
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
			return rt.new_bool(this.can_use_optimized_db_access())
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.create_data_for(mut dispatch_arg_0)
			return rt.new_null()
		}
		'delete_data_for' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.delete_data_for(dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_simple_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.create_data_for_simple_product(mut dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_variable_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.create_data_for_variable_product(mut dispatch_arg_0)
			return rt.new_null()
		}
		'create_data_for_variation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.create_data_for_variation(mut dispatch_arg_0)
			return rt.new_null()
		}
		'insert_lookup_table_data_for_variation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			this.insert_lookup_table_data_for_variation(mut dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'get_term_ids_by_slug_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_term_ids_by_slug_cache(dispatch_arg_0)
		}
		'get_variation_definition_term_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variation](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.get_variation_definition_term_id(mut dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2)
		}
		'get_variations_of' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product_Variable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_variations_of(mut dispatch_arg_0)
		}
		'is_variable_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.is_variable_product(mut dispatch_arg_0)
		}
		'is_variation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.is_variation(mut dispatch_arg_0)
		}
		'get_attribute_taxonomies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_attribute_taxonomies(mut dispatch_arg_0)
		}
		'insert_lookup_table_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			this.insert_lookup_table_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'on_product_created_or_updated_via_rest_api' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Post](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_advanced_section_to_product_settings(mut dispatch_arg_0)
		}
		'add_product_attributes_lookup_table_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.add_product_attributes_lookup_table_settings(mut dispatch_arg_0,
				dispatch_arg_1)
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
		else {
			return none
		}
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
		'lookup_table_name' {
			this.lookup_table_name = val
			return true
		}
		'optimized_db_access_is_enabled' {
			this.optimized_db_access_is_enabled = val.to_bool()
			return true
		}
		'last_create_operation_failed' {
			this.last_create_operation_failed = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
