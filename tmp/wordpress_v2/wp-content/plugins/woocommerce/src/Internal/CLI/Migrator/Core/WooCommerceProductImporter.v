import rt

pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter.default_image_timeout() i64 {
	return 10
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter.max_images_per_product() i64 {
	return 50
}
struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter {
	rt.PhpObjectBase
pub mut:
		import_options rt.PhpVal = rt.new_null()
		progress_callback rt.PhpVal = rt.new_null()
		import_stats rt.PhpVal = rt.new_array()
		migration_data rt.PhpVal = rt.new_array()
		current_attribute_mapping rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) construct() {
	this.import_options = this.get_default_options()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) configure(mut var_options Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	this.import_options = rt.call_function('array_merge', [this.import_options, var_options])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_progress_callback(mut var_callback Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?callable) {
	this.progress_callback = var_callback
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) import_product(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_source_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_source_data_mutated := var_source_data
	mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_product_name := if !(var_product_data.array_get(rt.new_string('name'))).is_null() { var_product_data.array_get(rt.new_string('name')) } else { rt.new_string('Unknown Product') }
	this.current_attribute_mapping = rt.new_array()
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Starting import for product: ${var_product_name.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_validation_result := this.validate_product_data(mut var_product_data)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_validation_result.array_get(rt.new_string('valid')))))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string("Validation failed for product: ${var_product_name.to_string()} - " + (var_validation_result.array_get(rt.new_string('message'))).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return this.create_error_result('validation_failed', (var_validation_result.array_get(rt.new_string('message'))).str(), mut var_product_data)
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_existing_product_id := rt.new_int(this.find_existing_product(mut var_product_data, rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_array', []string{}, var_source_data_mutated)))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(var_existing_product_id) && rt.is_true(this.import_options.array_get(rt.new_string('skip_existing'))) {
		rt.pre_inc(this.import_stats.array_get(rt.new_string('products_skipped')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return this.create_success_result('skipped', (var_existing_product_id).to_i64(), 'Product already exists and skip_existing is enabled')
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_product_type := rt.new_string(this.determine_product_type(mut var_product_data))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_product := this.get_or_create_product_object(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?int](var_existing_product_id), (var_product_type).str())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return this.create_error_result('product_creation_failed', 'Failed to create product object', mut var_product_data)
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(var_existing_product_id) {
		mut var_existing_migration_data := rt.call_method(var_product, 'get_meta', [rt.new_string('_migration_data')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(var_existing_migration_data.clone().is_array())) {
			this.migration_data.array_set('images_mapping', if !(var_existing_migration_data.array_get(rt.new_string('images_mapping'))).is_null() { var_existing_migration_data.array_get(rt.new_string('images_mapping')) } else { rt.new_array() })
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			this.migration_data.array_set('variations_mapping', if !(var_existing_migration_data.array_get(rt.new_string('variations_mapping'))).is_null() { var_existing_migration_data.array_get(rt.new_string('variations_mapping')) } else { rt.new_array() })
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.set_basic_product_properties(mut rt.cast_object_ptr[Class_WC_Product](var_product), mut var_product_data)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.set_product_taxonomies(mut rt.cast_object_ptr[Class_WC_Product](var_product), mut var_product_data)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.handle_product_images(mut rt.cast_object_ptr[Class_WC_Product](var_product), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if !(var_product_data.array_get(rt.new_string('images'))).is_null() { var_product_data.array_get(rt.new_string('images')) } else { rt.new_array() }))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'debug', [rt.new_string("Processing ${var_product_type.to_string()} product: ${var_product_name.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut switch_val_1 := var_product_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('variable'))) {
		this.handle_variable_product(mut rt.cast_object_ptr[Class_WC_Product_Variable](var_product), mut var_product_data)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		this.handle_simple_product(mut rt.cast_object_ptr[Class_WC_Product_Simple](var_product), mut var_product_data)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_product_id := rt.call_method(var_product, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		return this.create_error_result('save_failed', 'Failed to save product to database', mut var_product_data)
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.handle_post_save_operations((var_product_id).to_i64(), mut var_product_data, rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_array', []string{}, var_source_data_mutated))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(var_existing_product_id) {
		rt.pre_inc(this.import_stats.array_get(rt.new_string('products_updated')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		rt.pre_inc(this.import_stats.array_get(rt.new_string('products_created')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_duration := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_action := rt.new_string((if rt.is_true(var_existing_product_id) { 'updated' } else { 'created' }).str())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Successfully ${var_action.to_string()} product: ${var_product_name.to_string()} (ID: ${var_product_id.to_string()}) in ${var_duration.to_string()}s"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return this.create_success_result((var_action).str(), (var_product_id).to_i64(), "Product ${var_action.to_string()} successfully in ${var_duration.to_string()}s")
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.pre_inc(this.import_stats.array_get(rt.new_string('errors_encountered')))
		var_duration = rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time)
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string("Exception importing product: ${var_product_name.to_string()} after ${var_duration.to_string()}s - " + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		return this.create_error_result('exception', (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), mut var_product_data)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) import_batch(mut var_products_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_source_data_batch Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_results := rt.new_array()
	mut var_batch_stats := rt.create_array([rt.ArrayItem{ key: 'successful', val: 0 }, rt.ArrayItem{ key: 'failed', val: 0 }, rt.ArrayItem{ key: 'skipped', val: 0 }])
	mut var_total_count := rt.new_int(var_products_data.array_count())
	mut iter_1 := var_products_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_data := item_1.val
		mut var_index := item_1.key
		mut var_source_data := if !(var_source_data_batch.array_get(var_index)).is_null() { var_source_data_batch.array_get(var_index) } else { rt.new_array() }
		mut var_product_name := if !(var_product_data.array_get(rt.new_string('name'))).is_null() { var_product_data.array_get(rt.new_string('name')) } else { rt.new_string('Unknown Product') }
		mut var_result := this.import_product(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_product_data), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_source_data))
		var_results.array_push(var_result.clone())
		if rt.is_true(rt.identical(rt.new_string('success'), var_result.array_get(rt.new_string('status')))) {
			if rt.is_true(rt.identical(rt.new_string('skipped'), var_result.array_get(rt.new_string('action')))) {
				rt.pre_inc(var_batch_stats.array_get(rt.new_string('skipped')))
			} else {
				rt.pre_inc(var_batch_stats.array_get(rt.new_string('successful')))
			}
		} else {
			rt.pre_inc(var_batch_stats.array_get(rt.new_string('failed')))
		}
		if rt.is_true(this.progress_callback) {
			rt.call_function('call_user_func', [this.progress_callback, rt.add(var_index, rt.new_int(1)), var_total_count.clone(), var_product_name.clone(), var_result.clone()])
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'results', val: var_results }, rt.ArrayItem{ key: 'stats', val: var_batch_stats }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_import_stats() rt.PhpVal {
	return this.import_stats
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) reset_stats() {
	this.import_stats = rt.create_array([rt.ArrayItem{ key: 'products_created', val: 0 }, rt.ArrayItem{ key: 'products_updated', val: 0 }, rt.ArrayItem{ key: 'products_skipped', val: 0 }, rt.ArrayItem{ key: 'images_processed', val: 0 }, rt.ArrayItem{ key: 'errors_encountered', val: 0 }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_default_options() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'skip_existing', val: false }, rt.ArrayItem{ key: 'update_existing', val: true }, rt.ArrayItem{ key: 'import_images', val: true }, rt.ArrayItem{ key: 'image_timeout', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter.default_image_timeout() }, rt.ArrayItem{ key: 'max_images_per_product', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter.max_images_per_product() }, rt.ArrayItem{ key: 'skip_duplicate_images', val: false }, rt.ArrayItem{ key: 'create_categories', val: true }, rt.ArrayItem{ key: 'create_tags', val: true }, rt.ArrayItem{ key: 'handle_variations', val: true }, rt.ArrayItem{ key: 'assign_default_category', val: false }, rt.ArrayItem{ key: 'dry_run', val: false }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) validate_product_data(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_required_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'name' }])
	mut var_missing_fields := rt.new_array()
	mut iter_2 := var_required_fields.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		if !rt.is_true(var_product_data.array_get(var_field)) {
			var_missing_fields.array_push(var_field.clone())
		}
	}
	if !(!rt.is_true(var_missing_fields)) {
		return rt.create_array([rt.ArrayItem{ key: 'valid', val: false }, rt.ArrayItem{ key: 'message', val: 'Missing required fields: ' + (rt.call_function('implode', [rt.new_string(', '), var_missing_fields.clone()])).str() }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'valid', val: true }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) find_existing_product(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) i64 {
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('original_product_id')))) {
		mut var_existing_posts := rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{ key: 'meta_key', val: '_original_product_id' }, rt.ArrayItem{ key: 'meta_value', val: var_product_data.array_get(rt.new_string('original_product_id')) }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'numberposts', val: 1 }])])
		if !(!rt.is_true(var_existing_posts)) {
			return rt.new_int((var_existing_posts.array_get(rt.new_int(0))).to_i64())
		}
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('sku')))) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [var_product_data.array_get(rt.new_string('sku'))])
		if rt.is_true(var_product_id) {
			return (var_product_id).to_i64()
		}
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('slug')))) {
		mut var_post := rt.call_function('get_page_by_path', [var_product_data.array_get(rt.new_string('slug')), rt.get_constant('OBJECT'), rt.new_string('product')])
		if rt.is_true(var_post) {
			return (rt.get_property(var_post, 'ID')).to_i64()
		}
	}
	return (rt.new_null()).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) determine_product_type(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) string {
	if var_product_data.array_isset(rt.new_string('is_variable')) {
		return if rt.is_true(var_product_data.array_get(rt.new_string('is_variable'))) { 'variable' } else { 'simple' }
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('variations')))) && var_product_data.array_get(rt.new_string('variations')).array_count() >= 1 {
		return 'variable'
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('attributes')))) {
		mut iter_3 := var_product_data.array_get(rt.new_string('attributes')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attribute := item_3.val
			if !(!rt.is_true(var_attribute.array_get(rt.new_string('is_variation')))) || !(!rt.is_true(var_attribute.array_get(rt.new_string('variation')))) {
				return 'variable'
			}
		}
	}
	return 'simple'
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_or_create_product_object(mut var_existing_product_id Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?int, required_type string) rt.PhpVal {
	mut var_existing_product_id_mutated := var_existing_product_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_existing_product_id_mutated)))) {
		return this.create_product_object(required_type)
	}
	mut var_existing_product := rt.call_function('wc_get_product', [var_existing_product_id_mutated])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_existing_product)))) {
		return this.create_product_object(required_type)
	}
	mut var_current_type := rt.call_method(var_existing_product, 'get_type', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_current_type, rt.new_string(required_type))) {
		return var_existing_product.clone()
	}
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Converting product ID ${var_existing_product_id.to_string()} from ${var_current_type.to_string()} to ${var_required_type}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	mut switch_val_2 := rt.new_string(required_type)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('variable'))) {
		return rt.new_object('WC_Product_Variable', []string{}, create_wc_product_variable(var_existing_product_id_mutated))
	} else {
		return rt.new_object('WC_Product_Simple', []string{}, create_wc_product_simple(var_existing_product_id_mutated))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_product_object(product_type string) rt.PhpVal {
	mut product_type_mutated := product_type
	mut switch_val_3 := rt.new_string(product_type_mutated)
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('variable'))) {
		return rt.new_object('WC_Product_Variable', []string{}, create_wc_product_variable())
	} else {
		return rt.new_object('WC_Product_Simple', []string{}, create_wc_product_simple())
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_basic_product_properties(mut var_product Class_WC_Product, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	rt.call_method(var_product_mutated, 'set_name', [var_product_data.array_get(rt.new_string('name'))])
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('slug')))) {
		rt.call_method(var_product_mutated, 'set_slug', [var_product_data.array_get(rt.new_string('slug'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('description')))) {
		rt.call_method(var_product_mutated, 'set_description', [var_product_data.array_get(rt.new_string('description'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('short_description')))) {
		rt.call_method(var_product_mutated, 'set_short_description', [var_product_data.array_get(rt.new_string('short_description'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('status')))) {
		rt.call_method(var_product_mutated, 'set_status', [var_product_data.array_get(rt.new_string('status'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('sku')))) {
		rt.call_method(var_product_mutated, 'set_sku', [var_product_data.array_get(rt.new_string('sku'))])
	}
	if var_product_data.array_isset(rt.new_string('catalog_visibility')) {
		rt.call_method(var_product_mutated, 'set_catalog_visibility', [var_product_data.array_get(rt.new_string('catalog_visibility'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('date_created_gmt')))) {
		rt.call_method(var_product_mutated, 'set_date_created', [var_product_data.array_get(rt.new_string('date_created_gmt'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('weight')))) {
		rt.call_method(var_product_mutated, 'set_weight', [var_product_data.array_get(rt.new_string('weight'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('tax_status')))) {
		rt.call_method(var_product_mutated, 'set_tax_status', [var_product_data.array_get(rt.new_string('tax_status'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('metafields')))) {
		mut iter_4 := var_product_data.array_get(rt.new_string('metafields')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			mut var_key := item_4.key
			if !(!rt.is_true(var_key)) {
				rt.call_method(var_product_mutated, 'add_meta_data', [var_key.clone(), var_value.clone(), rt.new_bool(true)])
			}
		}
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('meta_data')))) {
		mut iter_5 := var_product_data.array_get(rt.new_string('meta_data')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_meta := item_5.val
			if !(!rt.is_true(var_meta.array_get(rt.new_string('key')))) {
				rt.call_method(var_product_mutated, 'add_meta_data', [var_meta.array_get(rt.new_string('key')), if !(var_meta.array_get(rt.new_string('value'))).is_null() { var_meta.array_get(rt.new_string('value')) } else { rt.new_string('') }, rt.new_bool(true)])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_simple_product(mut var_product Class_WC_Product_Simple, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('regular_price')))) {
		rt.call_method(var_product_mutated, 'set_regular_price', [var_product_data.array_get(rt.new_string('regular_price'))])
		rt.call_method(var_product_mutated, 'set_price', [var_product_data.array_get(rt.new_string('regular_price'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('sale_price')))) {
		rt.call_method(var_product_mutated, 'set_sale_price', [var_product_data.array_get(rt.new_string('sale_price'))])
		rt.call_method(var_product_mutated, 'set_price', [var_product_data.array_get(rt.new_string('sale_price'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('sku')))) {
		rt.call_function('add_filter', [rt.new_string('wc_product_has_unique_sku'), rt.new_string('__return_false'), rt.new_int(999)])
		rt.call_method(var_product_mutated, 'set_sku', [var_product_data.array_get(rt.new_string('sku'))])
		rt.call_function('remove_filter', [rt.new_string('wc_product_has_unique_sku'), rt.new_string('__return_false'), rt.new_int(999)])
	}
	if var_product_data.array_isset(rt.new_string('manage_stock')) {
		rt.call_method(var_product_mutated, 'set_manage_stock', [var_product_data.array_get(rt.new_string('manage_stock'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('stock_quantity')))) {
		rt.call_method(var_product_mutated, 'set_stock_quantity', [rt.new_int((var_product_data.array_get(rt.new_string('stock_quantity'))).to_i64())])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('stock_status')))) {
		rt.call_method(var_product_mutated, 'set_stock_status', [var_product_data.array_get(rt.new_string('stock_status'))])
	}
	if rt.is_true(rt.new_bool(var_product_data.array_isset(rt.new_string('cost_of_goods')))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('cost_of_goods_sold'))
		mut var_cogs_is_enabled := iife_result_0
		if rt.is_true(var_cogs_is_enabled) {
			rt.call_method(var_product_mutated, 'set_cogs_value', [rt.new_float((var_product_data.array_get(rt.new_string('cost_of_goods'))).to_f64())])
		} else {
			this.set_cogs_value_direct(mut var_product_mutated, rt.new_float((var_product_data.array_get(rt.new_string('cost_of_goods'))).to_f64()))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_variable_product(mut var_product Class_WC_Product_Variable, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	rt.call_method(var_product_mutated, 'set_sku', [rt.new_string('')])
	rt.call_method(var_product_mutated, 'set_regular_price', [rt.new_string('')])
	rt.call_method(var_product_mutated, 'set_sale_price', [rt.new_string('')])
	rt.call_method(var_product_mutated, 'set_manage_stock', [rt.new_bool(false)])
	rt.call_method(var_product_mutated, 'set_weight', [rt.new_string('')])
	rt.call_method(var_product_mutated, 'set_stock_quantity', [rt.new_null()])
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('attributes')))) {
		this.setup_attributes(mut var_product_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_product_data.array_get(rt.new_string('attributes'))))
	}
	mut var_product_id := rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('variations')))) && rt.is_true(this.import_options.array_get(rt.new_string('handle_variations'))) {
		this.sync_variations(mut var_product_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_product_data.array_get(rt.new_string('variations'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_product_attributes(mut var_product Class_WC_Product, mut var_attributes Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	mut var_product_attributes := rt.new_array()
	mut iter_6 := var_attributes.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_attribute_data := item_6.val
		if !rt.is_true(var_attribute_data.array_get(rt.new_string('name'))) {
			continue
		}
		mut var_attribute := create_automattic_woocommerce_internal_cli_migrator_core_wc_product_attribute()
		var_attribute.set_name(var_attribute_data.array_get(rt.new_string('name')))
		var_attribute.set_options(if !(var_attribute_data.array_get(rt.new_string('options'))).is_null() { var_attribute_data.array_get(rt.new_string('options')) } else { rt.new_array() })
		var_attribute.set_variation(if !(var_attribute_data.array_get(rt.new_string('is_variation'))).is_null() { var_attribute_data.array_get(rt.new_string('is_variation')) } else { if !(var_attribute_data.array_get(rt.new_string('variation'))).is_null() { var_attribute_data.array_get(rt.new_string('variation')) } else { rt.new_bool(false) } })
		var_attribute.set_visible(if !(var_attribute_data.array_get(rt.new_string('is_visible'))).is_null() { var_attribute_data.array_get(rt.new_string('is_visible')) } else { if !(var_attribute_data.array_get(rt.new_string('visible'))).is_null() { var_attribute_data.array_get(rt.new_string('visible')) } else { rt.new_bool(true) } })
		var_product_attributes.array_push(var_attribute)
	}
	rt.call_method(var_product_mutated, 'set_attributes', [var_product_attributes.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) setup_attributes(mut var_product Class_WC_Product_Variable, mut var_attributes_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	mut var_woo_attributes := rt.new_array()
	this.current_attribute_mapping = rt.new_array()
	mut iter_7 := var_attributes_data.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_attribute_info := item_7.val
		mut var_attr_name := if !(var_attribute_info.array_get(rt.new_string('name'))).is_null() { var_attribute_info.array_get(rt.new_string('name')) } else { rt.new_null() }
		mut var_attr_options := if !(var_attribute_info.array_get(rt.new_string('options'))).is_null() { var_attribute_info.array_get(rt.new_string('options')) } else { rt.new_array() }
		if !rt.is_true(var_attr_name) || !rt.is_true(var_attr_options) {
			continue
		}
		mut var_taxonomy_slug := rt.call_function('sanitize_title', [var_attr_name.clone()])
		mut var_taxonomy_name := rt.new_string('pa_' + (var_taxonomy_slug).str())
		mut var_attribute_id := rt.new_int(0)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy_name.clone()]))))) {
			var_attribute_id = rt.call_function('wc_create_attribute', [rt.create_array([rt.ArrayItem{ key: 'name', val: var_attr_name }, rt.ArrayItem{ key: 'slug', val: var_taxonomy_slug }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'order_by', val: 'menu_order' }, rt.ArrayItem{ key: 'has_archives', val: false }])])
			if rt.is_true(rt.call_function('is_wp_error', [var_attribute_id.clone()])) {
				rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("Failed to create attribute '${var_attr_name.to_string()}': " + (rt.call_method(var_attribute_id, 'get_error_message', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
				continue
			}
			rt.call_function('register_taxonomy', [var_taxonomy_name.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_taxonomy_objects_' + (var_taxonomy_name).str()), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }])]), rt.call_function('apply_filters', [rt.new_string('woocommerce_taxonomy_args_' + (var_taxonomy_name).str()), rt.create_array([rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: var_attr_name }]) }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'query_var', val: true }, rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'public', val: false }])])])
		} else {
		var_attribute_id = rt.call_function('wc_attribute_taxonomy_id_by_name', [var_taxonomy_name.clone()])
		}
		mut var_term_ids := rt.new_array()
		mut var_term_slugs := rt.new_array()
		mut iter_8 := var_attr_options.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value := item_8.val
			mut var_term_slug := rt.call_function('sanitize_title', [var_value.clone()])
			mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_term_slug.clone(), var_taxonomy_name.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
				mut var_term_result := rt.call_function('wp_insert_term', [var_value.clone(), var_taxonomy_name.clone(), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_term_slug }])])
				if rt.is_true(rt.call_function('is_wp_error', [var_term_result.clone()])) {
					rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("Failed to insert term '${var_value.to_string()}' (slug: ${var_term_slug.to_string()}) into ${var_taxonomy_name.to_string()}: " + (rt.call_method(var_term_result, 'get_error_message', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
					continue
				}
				var_term_ids.array_push(var_term_result.array_get(rt.new_string('term_id')))
				var_term_slugs.array_push(var_term_slug.clone())
			} else {
				var_term_ids.array_push(rt.get_property(var_term, 'term_id'))
				var_term_slugs.array_push(rt.get_property(var_term, 'slug'))
			}
		}
		mut var_woo_attribute := create_automattic_woocommerce_internal_cli_migrator_core_wc_product_attribute()
		var_woo_attribute.set_name(var_taxonomy_name.clone())
		var_woo_attribute.set_id(var_attribute_id.clone())
		var_woo_attribute.set_options(var_term_ids.clone())
		var_woo_attribute.set_position(if !(var_attribute_info.array_get(rt.new_string('position'))).is_null() { var_attribute_info.array_get(rt.new_string('position')) } else { rt.new_int(0) })
		var_woo_attribute.set_visible(if !(var_attribute_info.array_get(rt.new_string('is_visible'))).is_null() { var_attribute_info.array_get(rt.new_string('is_visible')) } else { rt.new_bool(true) })
		var_woo_attribute.set_variation(if !(var_attribute_info.array_get(rt.new_string('is_variation'))).is_null() { var_attribute_info.array_get(rt.new_string('is_variation')) } else { rt.new_bool(true) })
		var_woo_attributes.array_push(var_woo_attribute)
		this.current_attribute_mapping.array_set(var_attr_name, var_taxonomy_name.clone())
	}
	rt.call_method(var_product_mutated, 'set_attributes', [var_woo_attributes.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) sync_variations(mut var_product Class_WC_Product_Variable, mut var_variations_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	mut var_parent_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	mut var_parent_original_id := rt.call_method(var_product_mutated, 'get_meta', [rt.new_string('_original_product_id')])
	mut var_processed_variation_ids := rt.new_array()
	mut var_variation_count := rt.new_int(var_variations_data.array_count())
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'debug', [rt.new_string("Syncing ${var_variation_count.to_string()} variations for product ID ${var_parent_product_id.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	mut var_attribute_taxonomy_map := this.current_attribute_mapping
	if !rt.is_true(var_attribute_taxonomy_map) {
		mut var_product_attributes := rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{})
		mut iter_9 := var_product_attributes.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_attribute_obj := item_9.val
			mut var_taxonomy := item_9.key
			if rt.is_true(rt.call_method(var_attribute_obj, 'get_variation', []rt.PhpVal{})) {
				mut var_attribute_label := rt.call_function('wc_attribute_label', [var_taxonomy.clone(), var_product_mutated])
				var_attribute_taxonomy_map.array_set(var_attribute_label, var_taxonomy.clone())
				var_attribute_taxonomy_map.array_set(var_attribute_label.clone().to_string().to_lower(), var_taxonomy.clone())
			}
		}
	}
	mut iter_10 := var_variations_data.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_data := item_10.val
		mut var_original_variant_id := if !(var_var_data.array_get(rt.new_string('original_id'))).is_null() { var_var_data.array_get(rt.new_string('original_id')) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_original_variant_id)))) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string('Skipping variation: Missing original ID.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
			continue
		}
		mut var_variation_id := rt.new_null()
		mut var_variation := rt.new_null()
		if this.migration_data.array_get(rt.new_string('variations_mapping')).array_isset(var_original_variant_id) {
			mut var__variation_id := this.migration_data.array_get(rt.new_string('variations_mapping')).array_get(var_original_variant_id)
			mut var__variation := rt.call_function('wc_get_product', [var__variation_id.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var__variation, 'WC_Product_Variation'))) && rt.is_true(rt.identical(rt.call_method(var__variation, 'get_parent_id', []rt.PhpVal{}), var_parent_product_id)) {
			var_variation = var__variation.clone()
			var_variation_id = var__variation_id.clone()
			} else {
				this.migration_data.array_get(rt.new_string('variations_mapping')).array_unset(var_original_variant_id)
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_variation)))) {
			mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_parent_product_id }, rt.ArrayItem{ key: 'post_type', val: 'product_variation' }, rt.ArrayItem{ key: 'numberposts', val: 1 }, rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{ key: 'meta_key', val: '_original_variant_id' }, rt.ArrayItem{ key: 'meta_value', val: var_original_variant_id }, rt.ArrayItem{ key: 'fields', val: 'ids' }])
			mut var_found_ids := rt.call_function('get_posts', [var_query_args.clone()])
			if !(!rt.is_true(var_found_ids)) {
				var_variation_id = var_found_ids.array_get(rt.new_int(0))
				var_variation = rt.call_function('wc_get_product', [var_variation_id.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_variation, 'WC_Product_Variation')))))) {
					rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("Found post ID ${var_variation_id.to_string()} for original variant ${var_original_variant_id.to_string()}, but it's not a WC_Product_Variation."), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
				var_variation = rt.new_null()
				var_variation_id = rt.new_null()
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_variation)))) {
			var_variation = create_wc_product_variation()
			rt.call_method(var_variation, 'set_parent_id', [var_parent_product_id.clone()])
		}
		rt.call_method(var_variation, 'set_status', [rt.new_string('publish')])
		rt.call_method(var_variation, 'set_menu_order', [if !(var_var_data.array_get(rt.new_string('menu_order'))).is_null() { var_var_data.array_get(rt.new_string('menu_order')) } else { rt.new_int(0) }])
		rt.call_method(var_variation, 'set_regular_price', [if !(var_var_data.array_get(rt.new_string('regular_price'))).is_null() { var_var_data.array_get(rt.new_string('regular_price')) } else { rt.new_string('') }])
		rt.call_method(var_variation, 'set_sale_price', [if !(var_var_data.array_get(rt.new_string('sale_price'))).is_null() { var_var_data.array_get(rt.new_string('sale_price')) } else { rt.new_string('') }])
		if !(!rt.is_true(var_var_data.array_get(rt.new_string('sku')))) {
			rt.call_function('add_filter', [rt.new_string('wc_product_has_unique_sku'), rt.new_string('__return_false'), rt.new_int(999)])
			rt.call_method(var_variation, 'set_sku', [var_var_data.array_get(rt.new_string('sku'))])
			rt.call_function('remove_filter', [rt.new_string('wc_product_has_unique_sku'), rt.new_string('__return_false'), rt.new_int(999)])
		}
		rt.call_method(var_variation, 'set_manage_stock', [if !(var_var_data.array_get(rt.new_string('manage_stock'))).is_null() { var_var_data.array_get(rt.new_string('manage_stock')) } else { rt.new_bool(false) }])
		rt.call_method(var_variation, 'set_stock_quantity', [if !(var_var_data.array_get(rt.new_string('stock_quantity'))).is_null() { var_var_data.array_get(rt.new_string('stock_quantity')) } else { rt.new_null() }])
		rt.call_method(var_variation, 'set_stock_status', [if !(var_var_data.array_get(rt.new_string('stock_status'))).is_null() { var_var_data.array_get(rt.new_string('stock_status')) } else { rt.new_string('instock') }])
		rt.call_method(var_variation, 'set_weight', [if !(var_var_data.array_get(rt.new_string('weight'))).is_null() { var_var_data.array_get(rt.new_string('weight')) } else { rt.new_string('') }])
		if !(!rt.is_true(var_var_data.array_get(rt.new_string('tax_status')))) {
			rt.call_method(var_variation, 'set_tax_status', [var_var_data.array_get(rt.new_string('tax_status'))])
		}
		mut var_image_original_id := if !(var_var_data.array_get(rt.new_string('image_original_id'))).is_null() { var_var_data.array_get(rt.new_string('image_original_id')) } else { rt.new_null() }
		if rt.is_true(var_image_original_id) && this.migration_data.array_get(rt.new_string('images_mapping')).array_isset(var_image_original_id) {
			rt.call_method(var_variation, 'set_image_id', [this.migration_data.array_get(rt.new_string('images_mapping')).array_get(var_image_original_id)])
		} else {
			rt.call_method(var_variation, 'set_image_id', [rt.new_string('')])
		}
		mut var_wc_variation_attributes := rt.new_array()
		if !(!rt.is_true(var_var_data.array_get(rt.new_string('attributes')))) && var_var_data.array_get(rt.new_string('attributes')).is_array() {
			mut iter_11 := var_var_data.array_get(rt.new_string('attributes')).iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_attr_value := item_11.val
				mut var_attr_name := item_11.key
				if var_attribute_taxonomy_map.array_isset(var_attr_name) {
					mut var_taxonomy := var_attribute_taxonomy_map.array_get(var_attr_name)
					mut var_term_slug := rt.call_function('sanitize_title', [var_attr_value.clone()])
					mut var_normalized_attribute_name := rt.call_function('wc_variation_attribute_name', [var_taxonomy.clone()])
					var_wc_variation_attributes.array_set(var_normalized_attribute_name, var_term_slug.clone())
				} else {
					rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("Attribute taxonomy mapping not found for option '${var_attr_name.to_string()}' while processing variation ${var_original_variant_id.to_string()}."), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
				}
			}
		}
		rt.call_method(var_variation, 'set_attributes', [var_wc_variation_attributes.clone()])
		rt.call_method(var_variation, 'update_meta_data', [rt.new_string('_original_variant_id'), var_original_variant_id.clone()])
		if rt.is_true(var_parent_original_id) {
			rt.call_method(var_variation, 'update_meta_data', [rt.new_string('_original_product_id'), var_parent_original_id.clone()])
		}
		mut var_saved_variation_id := rt.call_method(var_variation, 'save', []rt.PhpVal{})
		if rt.is_true(var_saved_variation_id) {
			var_processed_variation_ids.array_push(var_saved_variation_id.clone())
			this.migration_data.array_get_mut('variations_mapping').array_set(var_original_variant_id, var_saved_variation_id.clone())
			if !(!rt.is_true(var_var_data.array_get(rt.new_string('cost_of_goods')))) {
				rt.call_function('update_post_meta', [var_saved_variation_id.clone(), rt.new_string('_cogs_total_value'), rt.new_float((var_var_data.array_get(rt.new_string('cost_of_goods'))).to_f64())])
			}
		} else {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string("Failed to save variation for original variant ${var_original_variant_id.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
		}
	}
	mut iife_temp_1 := Class_WC_Product_Variable{}
	mut iife_result_1 := iife_temp_1.sync(var_parent_product_id.clone())
	mut var_processed_count := rt.new_int(var_processed_variation_ids.clone().array_count())
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'debug', [rt.new_string("Successfully synced ${var_processed_count.to_string()}/${var_variation_count.to_string()} variations for product ID ${var_parent_product_id.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_product_variations(parent_id i64, mut var_variations Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product := rt.call_function('wc_get_product', [rt.new_int(parent_id)])
	if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product_Variable'))) {
		this.sync_variations(mut rt.cast_object_ptr[Class_WC_Product_Variable](var_product), mut var_variations)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_post_save_operations(product_id i64, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut product_id_mutated := product_id
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('original_product_id')))) {
		rt.call_function('update_post_meta', [rt.new_int(product_id_mutated).clone(), rt.new_string('_original_product_id'), var_product_data.array_get(rt.new_string('original_product_id'))])
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('original_url')))) {
		rt.call_function('update_post_meta', [rt.new_int(product_id_mutated).clone(), rt.new_string('_original_url'), var_product_data.array_get(rt.new_string('original_url'))])
	}
	rt.call_function('update_post_meta', [rt.new_int(product_id_mutated).clone(), rt.new_string('_migration_data'), this.migration_data])
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('metafields')))) {
		this.update_seo_meta(product_id_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_product_data.array_get(rt.new_string('metafields'))), mut var_product_data)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_product_taxonomies(mut var_product Class_WC_Product, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		var_product_id = rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string('Could not save product to set taxonomies.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
			return
		}
	}
	mut var_taxonomies_to_set := rt.new_array()
	if var_product_data.array_isset(rt.new_string('categories')) && var_product_data.array_get(rt.new_string('categories')).is_array() && rt.is_true(this.import_options.array_get(rt.new_string('create_categories'))) {
		mut var_term_ids := this.get_or_create_terms(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_product_data.array_get(rt.new_string('categories'))), 'product_cat')
		if !(!rt.is_true(var_term_ids)) {
			var_taxonomies_to_set.array_set('product_cat', var_term_ids.clone())
		} else if rt.is_true(this.import_options.array_get(rt.new_string('assign_default_category'))) {
			mut var_default_cat_id := rt.call_function('get_option', [rt.new_string('default_product_cat')])
			if rt.is_true(var_default_cat_id) {
				var_taxonomies_to_set.array_set('product_cat', rt.create_array([rt.ArrayItem{ key: none, val: var_default_cat_id }]))
				rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Assigned default category (ID: ${var_default_cat_id.to_string()}) to product with no categories"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
			}
		} else {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'debug', [rt.new_string('Product has no categories and assign_default_category is disabled'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
		}
	}
	if var_product_data.array_isset(rt.new_string('tags')) && var_product_data.array_get(rt.new_string('tags')).is_array() && rt.is_true(this.import_options.array_get(rt.new_string('create_tags'))) {
		var_term_ids = this.get_or_create_terms(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_product_data.array_get(rt.new_string('tags'))), 'product_tag')
		if !(!rt.is_true(var_term_ids)) {
			var_taxonomies_to_set.array_set('product_tag', var_term_ids.clone())
		}
	}
	if !(!rt.is_true(var_product_data.array_get(rt.new_string('brand')).array_get(rt.new_string('name')))) && rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string('product_brand')])) {
		mut var_brand_data := rt.create_array([rt.ArrayItem{ key: none, val: var_product_data.array_get(rt.new_string('brand')) }])
		var_term_ids = this.get_or_create_terms(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_brand_data), 'product_brand')
		if !(!rt.is_true(var_term_ids)) {
			var_taxonomies_to_set.array_set('product_brand', var_term_ids.clone())
		}
	}
	mut iter_12 := var_taxonomies_to_set.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_ids := item_12.val
		mut var_taxonomy := item_12.key
		rt.call_function('wp_set_object_terms', [var_product_id.clone(), var_ids.clone(), var_taxonomy.clone(), rt.new_bool(false)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_or_create_terms(mut var_terms_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, taxonomy string) rt.PhpVal {
	mut taxonomy_mutated := taxonomy
	mut var_term_ids := rt.new_array()
	mut iter_13 := var_terms_data.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_term_info := item_13.val
		mut var_term_name := if !(var_term_info.array_get(rt.new_string('name'))).is_null() { var_term_info.array_get(rt.new_string('name')) } else { rt.new_null() }
		mut var_term_slug := if !(var_term_info.array_get(rt.new_string('slug'))).is_null() { var_term_info.array_get(rt.new_string('slug')) } else { rt.call_function('sanitize_title', [var_term_name.clone()]) }
		if !rt.is_true(var_term_name) || !rt.is_true(var_term_slug) {
			continue
		}
		mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_term_slug.clone(), rt.new_string(taxonomy_mutated).clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
			mut var_term_result := rt.call_function('wp_insert_term', [var_term_name.clone(), rt.new_string(taxonomy_mutated).clone(), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_term_slug }])])
			if rt.is_true(rt.call_function('is_wp_error', [var_term_result.clone()])) {
				rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("Failed to insert term '${var_term_name.to_string()}' (slug: ${var_term_slug.to_string()}) into ${var_taxonomy.to_string()}: " + (rt.call_method(var_term_result, 'get_error_message', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
				continue
			}
			var_term_ids.array_push(var_term_result.array_get(rt.new_string('term_id')))
		} else {
			var_term_ids.array_push(rt.get_property(var_term, 'term_id'))
		}
	}
	return rt.call_function('array_unique', [var_term_ids.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_product_images(mut var_product Class_WC_Product, mut var_images_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_product_mutated := var_product
	if !rt.is_true(var_images_data) {
		return
	}
	mut var_gallery_ids := rt.new_array()
	mut var_featured_id := rt.new_null()
	mut var_product_id := rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	mut var_processed_count := rt.new_int(0)
	mut iter_14 := var_images_data.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_image := item_14.val
		mut var_index := item_14.key
		if rt.is_true(rt.greater_equal(var_processed_count, this.import_options.array_get(rt.new_string('max_images_per_product')))) {
			break
		}
		mut var_original_id := if !(var_image.array_get(rt.new_string('original_id'))).is_null() { var_image.array_get(rt.new_string('original_id')) } else { rt.new_null() }
		mut var_image_url := if !(var_image.array_get(rt.new_string('src'))).is_null() { var_image.array_get(rt.new_string('src')) } else { rt.new_null() }
		mut var_image_alt := if !(var_image.array_get(rt.new_string('alt'))).is_null() { var_image.array_get(rt.new_string('alt')) } else { rt.new_string('') }
		mut var_is_featured := if !(var_image.array_get(rt.new_string('is_featured'))).is_null() { var_image.array_get(rt.new_string('is_featured')) } else { rt.identical(rt.new_int(0), var_index) }
		if !rt.is_true(var_original_id) || !rt.is_true(var_image_url) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string('Skipping image: Missing original ID or URL.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
			continue
		}
		if this.migration_data.array_get(rt.new_string('images_mapping')).array_isset(var_original_id) && rt.is_true(rt.call_function('wp_attachment_is_image', [this.migration_data.array_get(rt.new_string('images_mapping')).array_get(var_original_id)])) {
		mut var_attachment_id := this.migration_data.array_get(rt.new_string('images_mapping')).array_get(var_original_id)
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
				var_product_id = rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
					rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("Skipping image upload ${var_original_id.to_string()}: Could not get product ID before sideloading."), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
					continue
				}
			}
			mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
			mut var_image_desc := if rt.is_true(var_image_alt) { var_image_alt } else { rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}) }
			var_attachment_id = rt.new_int(this.import_image((var_image_url).str(), (var_image_alt).str(), (var_product_id).to_i64()))
			mut var_duration := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time)
			if rt.is_true(rt.call_function('is_wp_error', [var_attachment_id.clone()])) {
				rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string("Error uploading ${var_image_url.to_string()}: " + (rt.call_method(var_attachment_id, 'get_error_message', []rt.PhpVal{})).str() + " (Duration: ${var_duration.to_string()}s)"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment_id)))) {
				rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("Image upload failed for ${var_image_url.to_string()} (Duration: ${var_duration.to_string()}s)"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
				continue
			}
			this.migration_data.array_get_mut('images_mapping').array_set(var_original_id, var_attachment_id.clone())
			if rt.is_true(var_image_alt) {
				rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), var_image_alt.clone()])
			}
		}
		if rt.is_true(var_is_featured) {
		var_featured_id = var_attachment_id.clone()
		} else {
			var_gallery_ids.array_push(var_attachment_id.clone())
		}
		rt.pre_inc(var_processed_count)
		rt.pre_inc(this.import_stats.array_get(rt.new_string('images_processed')))
	}
	if rt.is_true(var_featured_id) {
		rt.call_method(var_product_mutated, 'set_image_id', [var_featured_id.clone()])
	}
	if !(!rt.is_true(var_gallery_ids)) {
		rt.call_method(var_product_mutated, 'set_gallery_image_ids', [rt.call_function('array_unique', [var_gallery_ids.clone()])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) import_image_with_mapping(image_url string, alt_text string, mut var_original_id Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?string, product_id i64) i64 {
	mut image_url_mutated := image_url
	mut var_original_id_mutated := var_original_id
	mut product_id_mutated := product_id
	if rt.is_true(var_original_id_mutated) && this.migration_data.array_get(rt.new_string('images_mapping')).array_isset(var_original_id_mutated) {
		mut var_attachment_id := this.migration_data.array_get(rt.new_string('images_mapping')).array_get(var_original_id_mutated)
		if rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_id.clone()])) {
			return (var_attachment_id).to_i64()
		} else {
			this.migration_data.array_get(rt.new_string('images_mapping')).array_unset(var_original_id_mutated)
		}
	}
	mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
	var_attachment_id = rt.new_int(this.import_image(image_url_mutated, alt_text, product_id_mutated))
	mut var_duration := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time)
	if rt.is_true(var_attachment_id) && rt.is_true(var_original_id_mutated) {
		this.migration_data.array_get_mut('images_mapping').array_set(var_original_id_mutated, var_attachment_id.clone())
	}
	if rt.is_true(var_attachment_id) {
		mut var_message := rt.call_function('sprintf', [rt.new_string('Image uploaded successfully in %.2fs: %s -> %d'), var_duration.clone(), rt.new_string(image_url_mutated).clone(), var_attachment_id.clone()])
		if rt.is_true(if !(this.import_options.array_get(rt.new_string('verbose'))).is_null() { this.import_options.array_get(rt.new_string('verbose')) } else { rt.new_bool(false) }) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI{}
		mut iife_result_2 := iife_temp_2.log(var_message.clone())
		}
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator-images' }])])
	} else {
		var_message = rt.call_function('sprintf', [rt.new_string('Image upload failed in %.2fs: %s'), var_duration.clone(), rt.new_string(image_url_mutated).clone()])
		if rt.is_true(if !(this.import_options.array_get(rt.new_string('verbose'))).is_null() { this.import_options.array_get(rt.new_string('verbose')) } else { rt.new_bool(false) }) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI{}
		mut iife_result_3 := iife_temp_3.warning(var_message.clone())
		}
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator-images' }])])
	}
	return (var_attachment_id).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) import_image(image_url string, alt_text string, product_id i64) i64 {
	mut image_url_mutated := image_url
	mut product_id_mutated := product_id
	if rt.is_true(this.import_options.array_get(rt.new_string('dry_run'))) {
		return (rt.new_null()).to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.import_options.array_get(rt.new_string('skip_duplicate_images')))))) {
		mut var_existing_attachment := rt.new_int(this.get_attachment_by_url(image_url_mutated))
		if rt.is_true(var_existing_attachment) {
			return (var_existing_attachment).to_i64()
		}
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	rt.call_function('add_filter', [rt.new_string('http_request_timeout'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_image_download_timeout' }])])
	rt.call_function('add_filter', [rt.new_string('http_request_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'optimize_http_request_args' }])])
	rt.call_function('add_filter', [rt.new_string('image_sideload_extensions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_avif_support_to_sideload' }])])
	mut var_attachment_id := rt.call_function('media_sideload_image', [rt.new_string(image_url_mutated).clone(), rt.new_int(product_id_mutated).clone(), rt.new_null(), rt.new_string('id')])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_attachment_id.clone()])) {
		mut var_message := rt.call_function('sprintf', [rt.new_string('Image import failed for URL %s: %s'), rt.new_string(image_url_mutated).clone(), rt.call_method(var_attachment_id, 'get_error_message', []rt.PhpVal{})])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(if !(this.import_options.array_get(rt.new_string('verbose'))).is_null() { this.import_options.array_get(rt.new_string('verbose')) } else { rt.new_bool(false) }) {
			mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI{}
			mut iife_result_4 := iife_temp_4.warning(var_message.clone())
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator-images' }])])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return (rt.new_null()).to_i64()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_alt_text.len > 0 && var_alt_text != '0' {
		rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.new_string(alt_text)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return (var_attachment_id).to_i64()
	unsafe { goto finally_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()

finally_label_2:
	rt.call_function('remove_filter', [rt.new_string('http_request_timeout'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_image_download_timeout' }])])
	rt.call_function('remove_filter', [rt.new_string('http_request_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'optimize_http_request_args' }])])
	rt.call_function('remove_filter', [rt.new_string('image_sideload_extensions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_avif_support_to_sideload' }])])
	if rt.has_exception() { return rt.new_null() }

end_label_2:
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_image_download_timeout() i64 {
	return (this.import_options.array_get(rt.new_string('image_timeout'))).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) optimize_http_request_args(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('redirection', 3)
	var_args_mutated.array_set('timeout', if !(this.import_options.array_get(rt.new_string('image_timeout'))).is_null() { this.import_options.array_get(rt.new_string('image_timeout')) } else { rt.new_int(30) })
	return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) add_avif_support_to_sideload(mut var_allowed_extensions Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_allowed_extensions_mutated := var_allowed_extensions
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('avif'), var_allowed_extensions_mutated, rt.new_bool(true)]))))) {
		var_allowed_extensions_mutated.array_push('avif')
	}
	return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_array', []string{}, var_allowed_extensions_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_attachment_by_url(image_url string) i64 {
	mut var_wpdb := rt.new_null()
	mut image_url_mutated := image_url
	mut var_basename := rt.call_function('wp_basename', [rt.new_string(image_url_mutated).clone()])
	mut var_attachment_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_wp_attached_file\' AND meta_value LIKE %s')), rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_basename.clone()])).str())])])
	return (if rt.is_true(var_attachment_id) { rt.new_int((var_attachment_id).to_i64()) } else { rt.new_null() }).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_success_result(action string, product_id i64, message string) rt.PhpVal {
	mut action_mutated := action
	mut product_id_mutated := product_id
	mut message_mutated := message
	return rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'action', val: action_mutated }, rt.ArrayItem{ key: 'product_id', val: product_id_mutated }, rt.ArrayItem{ key: 'message', val: message_mutated }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) update_seo_meta(product_id i64, mut var_metafields Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut product_id_mutated := product_id
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WPSEO_VERSION')]))))) {
		return
	}
	mut var_seo_title := if !(var_metafields.array_get(rt.new_string('global_title_tag'))).is_null() { var_metafields.array_get(rt.new_string('global_title_tag')) } else { rt.new_null() }
	mut var_seo_description := if !(var_metafields.array_get(rt.new_string('global_description_tag'))).is_null() { var_metafields.array_get(rt.new_string('global_description_tag')) } else { rt.new_null() }
	mut var_final_seo_title := if rt.is_true(var_seo_title) { var_seo_title } else { if !(var_product_data.array_get(rt.new_string('name'))).is_null() { var_product_data.array_get(rt.new_string('name')) } else { rt.new_string('') } }
	mut var_fallback_desc := if rt.is_true(var_product_data.array_get(rt.new_string('description'))) { var_product_data.array_get(rt.new_string('description')) } else { if !(var_product_data.array_get(rt.new_string('short_description'))).is_null() { var_product_data.array_get(rt.new_string('short_description')) } else { rt.new_string('') } }
	mut var_final_seo_description := if rt.is_true(var_seo_description) { var_seo_description } else { rt.call_function('wp_strip_all_tags', [var_fallback_desc.clone()]) }
	mut var_current_title := rt.call_function('get_post_meta', [rt.new_int(product_id_mutated).clone(), rt.new_string('_yoast_wpseo_title'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_title, var_final_seo_title)))) && !(!rt.is_true(var_final_seo_title)) {
		rt.call_function('update_post_meta', [rt.new_int(product_id_mutated).clone(), rt.new_string('_yoast_wpseo_title'), var_final_seo_title.clone()])
	}
	mut var_current_desc := rt.call_function('get_post_meta', [rt.new_int(product_id_mutated).clone(), rt.new_string('_yoast_wpseo_metadesc'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_desc, var_final_seo_description)))) && !(!rt.is_true(var_final_seo_description)) {
		mut var_truncated_desc := rt.call_function('mb_substr', [var_final_seo_description.clone(), rt.new_int(0), rt.new_int(160)])
		rt.call_function('update_post_meta', [rt.new_int(product_id_mutated).clone(), rt.new_string('_yoast_wpseo_metadesc'), var_truncated_desc.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_cogs_value_direct(mut var_product Class_WC_Product, cogs_value f64) {
	mut var_product_mutated := var_product
	rt.call_method(var_product_mutated, 'update_meta_data', [rt.new_string('_cogs_total_value'), rt.new_float(cogs_value)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_error_result(error_code string, message string, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut message_mutated := message
	return rt.create_array([rt.ArrayItem{ key: 'status', val: 'error' }, rt.ArrayItem{ key: 'error_code', val: error_code }, rt.ArrayItem{ key: 'message', val: message_mutated }, rt.ArrayItem{ key: 'product_data', val: var_product_data }])
}

struct Class_WC_Product_Variable {
	rt.PhpObjectBase
}

struct Class_WC_Product_Simple {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_WC_Product_Variation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_core_woocommerceproductimporter() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter{
		PhpObjectBase: rt.PhpObjectBase{}
		import_options: rt.new_null()
		progress_callback: rt.new_null()
		import_stats: rt.new_array()
		migration_data: rt.new_array()
		current_attribute_mapping: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wc_product_variable(_args ...rt.PhpVal) &Class_WC_Product_Variable {
	mut obj := &Class_WC_Product_Variable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_simple(_args ...rt.PhpVal) &Class_WC_Product_Simple {
	mut obj := &Class_WC_Product_Simple{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_core_wc_product_attribute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WC_Product_Attribute {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_variation(_args ...rt.PhpVal) &Class_WC_Product_Variation {
	mut obj := &Class_WC_Product_Variation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_core_wp_cli(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'configure' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.configure(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_progress_callback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_progress_callback(mut dispatch_arg_0)
			return rt.new_null()
		}
		'import_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.import_product(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'import_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.import_batch(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_import_stats' {
			return this.get_import_stats()
		}
		'reset_stats' {
			this.reset_stats()
			return rt.new_null()
		}
		'get_default_options' {
			return this.get_default_options()
		}
		'validate_product_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.validate_product_data(mut dispatch_arg_0)
		}
		'find_existing_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.find_existing_product(mut dispatch_arg_0))
		}
		'determine_product_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.determine_product_type(mut dispatch_arg_0))
		}
		'get_or_create_product_object' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_or_create_product_object(mut dispatch_arg_0, dispatch_arg_1)
		}
		'create_product_object' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.create_product_object(dispatch_arg_0)
		}
		'set_basic_product_properties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.set_basic_product_properties(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_simple_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product_Simple](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_simple_product(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_variable_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product_Variable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_variable_product(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'set_product_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.set_product_attributes(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'setup_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product_Variable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.setup_attributes(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'sync_variations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product_Variable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.sync_variations(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'create_product_variations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.create_product_variations(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_post_save_operations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_post_save_operations(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'set_product_taxonomies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.set_product_taxonomies(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_or_create_terms' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_or_create_terms(mut dispatch_arg_0, dispatch_arg_1)
		}
		'handle_product_images' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_product_images(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'import_image_with_mapping' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.import_image_with_mapping(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3))
		}
		'import_image' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.import_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'set_image_download_timeout' {
			return rt.new_int(this.set_image_download_timeout())
		}
		'optimize_http_request_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.optimize_http_request_args(mut dispatch_arg_0)
		}
		'add_avif_support_to_sideload' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_avif_support_to_sideload(mut dispatch_arg_0)
		}
		'get_attachment_by_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.get_attachment_by_url(dispatch_arg_0))
		}
		'create_success_result' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.create_success_result(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_seo_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.update_seo_meta(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'set_cogs_value_direct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			this.set_cogs_value_direct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'create_error_result' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.create_error_result(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'import_options' { return this.import_options }
		'progress_callback' { return this.progress_callback }
		'import_stats' { return this.import_stats }
		'migration_data' { return this.migration_data }
		'current_attribute_mapping' { return this.current_attribute_mapping }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'import_options' { this.import_options = val; return true }
		'progress_callback' { this.progress_callback = val; return true }
		'import_stats' { this.import_stats = val; return true }
		'migration_data' { this.migration_data = val; return true }
		'current_attribute_mapping' { this.current_attribute_mapping = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Product_Variable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Variable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Simple) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Simple) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Simple) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WC_Product_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WC_Product_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WC_Product_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Variation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Variation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
