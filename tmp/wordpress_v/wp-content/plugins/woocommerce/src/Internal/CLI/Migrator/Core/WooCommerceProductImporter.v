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

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) construct()  {
	this.import_options = this.get_default_options()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) configure(mut var_options Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	this.import_options = rt.call_function('array_merge', [this.import_options, var_options])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_progress_callback(mut var_callback Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?callable)  {
	this.progress_callback = var_callback.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) import_product(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_source_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_source_data_mutated := var_source_data
	mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_product_name := if !(var_product_data.array_get('name')).is_null() { var_product_data.array_get('name') } else { rt.new_string('Unknown Product') }
	this.current_attribute_mapping = rt.new_array()
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Starting import for product: ${var_product_name.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_validation_result := this.validate_product_data(mut var_product_data)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_validation_result.array_get('valid'))))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', ["Validation failed for product: ${var_product_name.to_string()} - " + (var_validation_result.array_get('message')).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return this.create_error_result('validation_failed', (var_validation_result.array_get('message')).str(), mut var_product_data)
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_existing_product_id := rt.new_int(this.find_existing_product(mut var_product_data, rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_array', []string{}, var_source_data_mutated)))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(var_existing_product_id) && rt.is_true(this.import_options.array_get('skip_existing')))) {
		rt.pre_inc(this.import_stats.array_get('products_skipped'))
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
		if rt.is_true(rt.new_bool(var_existing_migration_data.dup().is_array())) {
			this.migration_data.array_set('images_mapping', if !(var_existing_migration_data.array_get('images_mapping')).is_null() { var_existing_migration_data.array_get('images_mapping') } else { rt.new_array() })
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			this.migration_data.array_set('variations_mapping', if !(var_existing_migration_data.array_get('variations_mapping')).is_null() { var_existing_migration_data.array_get('variations_mapping') } else { rt.new_array() })
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.set_basic_product_properties(mut rt.cast_object_ptr[Class_WC_Product](var_product), mut var_product_data)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.set_product_taxonomies(mut rt.cast_object_ptr[Class_WC_Product](var_product), mut var_product_data)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.handle_product_images(mut rt.cast_object_ptr[Class_WC_Product](var_product), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if !(var_product_data.array_get('images')).is_null() { var_product_data.array_get('images') } else { rt.new_array() }))
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
		rt.pre_inc(this.import_stats.array_get('products_updated'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		rt.pre_inc(this.import_stats.array_get('products_created'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_duration := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_action := rt.new_string(if rt.is_true(var_existing_product_id) { rt.new_string('updated') } else { rt.new_string('created') })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Successfully ${var_action.to_string()} product: ${var_product_name.to_string()} (ID: ${var_product_id.to_string()}) in ${var_duration.to_string()}s"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return this.create_success_result((var_action).str(), (var_product_id).to_i64(), "Product ${var_action.to_string()} successfully in ${var_duration.to_string()}s")
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		rt.pre_inc(this.import_stats.array_get('errors_encountered'))
		var_duration = rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time)
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', ["Exception importing product: ${var_product_name.to_string()} after ${var_duration.to_string()}s - " + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
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
	mut var_total_count := rt.new_int(rt.new_int(var_products_data.array_count()))
	{
		mut iter_1 := var_products_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_data := item_1.val
			mut var_index := item_1.key
			mut var_source_data := if !(var_source_data_batch.array_get(var_index)).is_null() { var_source_data_batch.array_get(var_index) } else { rt.new_array() }
			mut var_product_name := if !(var_product_data.array_get('name')).is_null() { var_product_data.array_get('name') } else { rt.new_string('Unknown Product') }
			mut var_result := this.import_product(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_product_data), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_source_data))
			var_results.array_push(var_result.dup())
			if rt.is_true(rt.identical(rt.new_string('success'), var_result.array_get('status'))) {
				if rt.is_true(rt.identical(rt.new_string('skipped'), var_result.array_get('action'))) {
					rt.pre_inc(var_batch_stats.array_get('skipped'))
				} else {
					rt.pre_inc(var_batch_stats.array_get('successful'))
				}
			} else {
				rt.pre_inc(var_batch_stats.array_get('failed'))
			}
			if rt.is_true(this.progress_callback) {
				rt.call_function('call_user_func', [this.progress_callback, rt.add(var_index, rt.new_int(1)), var_total_count.dup(), var_product_name.dup(), var_result.dup()])
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'results', val: var_results }, rt.ArrayItem{ key: 'stats', val: var_batch_stats }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_import_stats() rt.PhpVal {
	return this.import_stats
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) reset_stats()  {
	this.import_stats = rt.create_array([rt.ArrayItem{ key: 'products_created', val: 0 }, rt.ArrayItem{ key: 'products_updated', val: 0 }, rt.ArrayItem{ key: 'products_skipped', val: 0 }, rt.ArrayItem{ key: 'images_processed', val: 0 }, rt.ArrayItem{ key: 'errors_encountered', val: 0 }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_default_options() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'skip_existing', val: false }, rt.ArrayItem{ key: 'update_existing', val: true }, rt.ArrayItem{ key: 'import_images', val: true }, rt.ArrayItem{ key: 'image_timeout', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter.default_image_timeout() }, rt.ArrayItem{ key: 'max_images_per_product', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter.max_images_per_product() }, rt.ArrayItem{ key: 'skip_duplicate_images', val: false }, rt.ArrayItem{ key: 'create_categories', val: true }, rt.ArrayItem{ key: 'create_tags', val: true }, rt.ArrayItem{ key: 'handle_variations', val: true }, rt.ArrayItem{ key: 'assign_default_category', val: false }, rt.ArrayItem{ key: 'dry_run', val: false }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) validate_product_data(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_required_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'name' }])
	mut var_missing_fields := rt.new_array()
	{
		mut iter_1 := var_required_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if !rt.is_true(var_product_data.array_get(var_field)) {
				var_missing_fields.array_push(var_field.dup())
			}
		}
	}
	if !(!rt.is_true(var_missing_fields)) {
		return rt.create_array([rt.ArrayItem{ key: 'valid', val: false }, rt.ArrayItem{ key: 'message', val: 'Missing required fields: ' + (rt.call_function('implode', [rt.new_string(', '), var_missing_fields.dup()])).str() }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'valid', val: true }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) find_existing_product(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) i64 {
	if !(!rt.is_true(var_product_data.array_get('original_product_id'))) {
		mut var_existing_posts := rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{ key: 'meta_key', val: '_original_product_id' }, rt.ArrayItem{ key: 'meta_value', val: var_product_data.array_get('original_product_id') }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'numberposts', val: 1 }])])
		if !(!rt.is_true(var_existing_posts)) {
			return (// unsupported expression: Expr_Cast_Int).to_i64()
		}
	}
	if !(!rt.is_true(var_product_data.array_get('sku'))) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [var_product_data.array_get('sku')])
		if rt.is_true(var_product_id) {
			return (var_product_id).to_i64()
		}
	}
	if !(!rt.is_true(var_product_data.array_get('slug'))) {
		mut var_post := rt.call_function('get_page_by_path', [var_product_data.array_get('slug'), rt.get_constant('OBJECT'), rt.new_string('product')])
		if rt.is_true(var_post) {
			return (rt.get_property(var_post, 'ID')).to_i64()
		}
	}
	return (rt.new_null()).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) determine_product_type(mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) string {
	if var_product_data.array_isset(rt.new_string('is_variable')) {
		return if rt.is_true(var_product_data.array_get('is_variable')) { 'variable' } else { 'simple' }
	}
	if !(!rt.is_true(var_product_data.array_get('variations'))) && var_product_data.array_get('variations').array_count() >= 1 {
		return 'variable'
	}
	if !(!rt.is_true(var_product_data.array_get('attributes'))) {
		{
			mut iter_1 := var_product_data.array_get('attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				if !(!rt.is_true(var_attribute.array_get('is_variation'))) || !(!rt.is_true(var_attribute.array_get('variation'))) {
					return 'variable'
				}
			}
		}
	}
	return 'simple'
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_or_create_product_object(mut var_existing_product_id Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?int, required_type string) rt.PhpVal {
	mut var_existing_product_id_mutated := var_existing_product_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_existing_product_id_mutated)))) {
		this.create_product_object(required_type)
		return rt.new_null()
	}
	mut var_existing_product := rt.call_function('wc_get_product', [var_existing_product_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_existing_product)))) {
		this.create_product_object(required_type)
		return rt.new_null()
	}
	mut var_current_type := rt.call_method(var_existing_product, 'get_type', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_current_type, rt.new_string(required_type))) {
		return var_existing_product.dup()
	}
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("Converting product ID ${var_existing_product_id.to_string()} from ${var_current_type.to_string()} to ${var_required_type}"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	mut switch_val_2 := rt.new_string(required_type)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('variable'))) {
		return create_wc_product_variable(var_existing_product_id_mutated.dup())
	} else {
		return create_wc_product_simple(var_existing_product_id_mutated.dup())
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_product_object(product_type string)  {
	mut product_type_mutated := product_type
	mut switch_val_3 := rt.new_string(product_type_mutated)
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('variable'))) {
		return create_wc_product_variable()
	} else {
		return create_wc_product_simple()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_basic_product_properties(mut var_product Class_WC_Product, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
	rt.call_method(var_product_mutated, 'set_name', [.array_get()])
	if !(!rt.is_true(.array_get())) {
		
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if .array_isset() {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_simple_product(mut var_product Class_WC_Product_Simple, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if .array_isset() {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	if rt.is_true() {
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_variable_product(mut var_product Class_WC_Product_Variable, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_product_attributes(mut var_product Class_WC_Product, mut var_attributes Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) setup_attributes(mut var_product Class_WC_Product_Variable, mut var_attributes_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) sync_variations(mut var_product Class_WC_Product_Variable, mut var_variations_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_product_variations(parent_id i64, mut var_variations Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_post_save_operations(product_id i64, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut product_id_mutated := product_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_product_taxonomies(mut var_product Class_WC_Product, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_or_create_terms(mut var_terms_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, taxonomy string) rt.PhpVal {
	mut taxonomy_mutated := taxonomy
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) handle_product_images(mut var_product Class_WC_Product, mut var_images_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) import_image_with_mapping(image_url string, alt_text string, mut var_original_id Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?string, product_id i64) i64 {
	mut image_url_mutated := image_url
	mut var_original_id_mutated := var_original_id
	mut product_id_mutated := product_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) import_image(image_url string, alt_text string, product_id i64) i64 {
	mut image_url_mutated := image_url
	mut product_id_mutated := product_id
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_image_download_timeout() i64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) optimize_http_request_args(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) add_avif_support_to_sideload(mut var_allowed_extensions Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_allowed_extensions_mutated := var_allowed_extensions
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) get_attachment_by_url(image_url string) i64 {
	mut var_wpdb := rt.new_null()
	mut image_url_mutated := image_url
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_success_result(action string, product_id i64, message string) rt.PhpVal {
	mut action_mutated := action
	mut product_id_mutated := product_id
	mut message_mutated := message
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) update_seo_meta(product_id i64, mut var_metafields Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut product_id_mutated := product_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) set_cogs_value_direct(mut var_product Class_WC_Product, cogs_value f64)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter) create_error_result(error_code string, message string, mut var_product_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut message_mutated := message
}

struct Class_WC_Product_Variable {
	rt.PhpObjectBase
}

struct Class_WC_Product_Simple {
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

fn create_wc_product_variable() &Class_WC_Product_Variable {
	mut obj := &Class_WC_Product_Variable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_simple() &Class_WC_Product_Simple {
	mut obj := &Class_WC_Product_Simple{
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
			this.create_product_object(dispatch_arg_0)
			return rt.new_null()
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




pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_core_woocommerceproductimporter_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
