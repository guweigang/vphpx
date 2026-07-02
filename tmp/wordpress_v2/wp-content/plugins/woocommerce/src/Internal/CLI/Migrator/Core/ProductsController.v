import rt

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController {
	rt.PhpObjectBase
pub mut:
		credential_manager rt.PhpVal = rt.new_null()
		platform_registry rt.PhpVal = rt.new_null()
		session rt.PhpVal = rt.new_null()
		parsed_args rt.PhpVal = rt.new_array()
		fields_to_process rt.PhpVal = rt.new_array()
		product_importer rt.PhpVal = rt.new_null()
		tracker rt.PhpVal = rt.new_null()
		session_start_time rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) init(mut var_credential_manager Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager, mut var_platform_registry Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry, mut var_product_importer Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter, mut var_tracker Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) {
	this.credential_manager = var_credential_manager
	this.platform_registry = var_platform_registry
	this.product_importer = var_product_importer
	this.tracker = var_tracker
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) migrate_products(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, platform string) {
	mut platform_mutated := platform
	this.parsed_args = this.parse_and_validate_args(mut var_assoc_args, platform_mutated)
	if !rt.is_true(this.parsed_args) {
		return
	}
	this.session_start_time = rt.call_function('time', []rt.PhpVal{})
	if rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run'))) {
	mut iife_temp_0 := Class_WP_CLI{}
	mut iife_result_0 := iife_temp_0.colorize(rt.new_string('%Y--- DRY RUN MODE ENABLED ---%n'))
	mut iife_temp_1 := Class_WP_CLI{}
	mut iife_result_1 := iife_temp_1.line(iife_result_0)
	mut iife_temp_2 := Class_WP_CLI{}
	mut iife_result_2 := iife_temp_2.line(rt.new_string('No products will be created or modified. This is a simulation only.'))
	mut iife_temp_3 := Class_WP_CLI{}
	mut iife_result_3 := iife_temp_3.line(rt.new_string(''))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run')))))) {
		this.session = this.manage_session_lifecycle(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](this.parsed_args))
		if rt.is_true(rt.new_bool(!(rt.is_true(this.session)))) {
			return
		}
		rt.call_function('do_action', [rt.new_string('wc_migrator_session_started'), this.parsed_args.array_get(rt.new_string('platform')), rt.create_array([rt.ArrayItem{ key: 'session_id', val: rt.call_method(this.session, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'filters', val: this.parsed_args.array_get(rt.new_string('filters')) }, rt.ArrayItem{ key: 'fields', val: this.fields_to_process }, rt.ArrayItem{ key: 'is_dry_run', val: this.parsed_args.array_get(rt.new_string('dry_run')) }, rt.ArrayItem{ key: 'resume', val: this.parsed_args.array_get(rt.new_string('resume')) }])])
	}
	mut var_fetcher := rt.call_method(this.platform_registry, 'get_fetcher', [this.parsed_args.array_get(rt.new_string('platform'))])
	mut var_mapper := rt.call_method(this.platform_registry, 'get_mapper', [this.parsed_args.array_get(rt.new_string('platform')), rt.create_array([rt.ArrayItem{ key: 'fields', val: this.fields_to_process }])])
	mut var_total_count := rt.call_method(var_fetcher, 'fetch_total_count', [this.parsed_args.array_get(rt.new_string('filters'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run')))))) {
		mut var_existing_total := rt.call_method(this.session, 'count_all_total_entities', []rt.PhpVal{})
		if rt.is_true(rt.less(rt.new_int(0), var_total_count)) && rt.is_true(rt.identical(rt.new_int(0), var_existing_total)) {
			rt.call_method(this.session, 'bump_total_number_of_entities', [rt.create_array([rt.ArrayItem{ key: 'post', val: var_total_count }])])
		}
	}
	mut iife_temp_4 := Class_WP_CLI{}
	mut iife_result_4 := iife_temp_4.line(rt.new_string("Total entities found: ${var_total_count.to_string()}"))
	mut var_progress_label := rt.new_string((if rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run'))) { 'Simulating Products from ' + (rt.call_function('ucfirst', [this.parsed_args.array_get(rt.new_string('platform'))])).str() } else { 'Importing Products from ' + (rt.call_function('ucfirst', [this.parsed_args.array_get(rt.new_string('platform'))])).str() }).str())
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [var_progress_label.clone(), var_total_count.clone()])
	mut var_initial_tick := rt.call_function('max', [rt.new_int(1), rt.new_int((rt.call_function('ceil', [rt.new_float(var_total_count * 0.01)])).to_i64())])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run')))))) {
		mut var_already_imported := rt.call_method(this.session, 'count_all_imported_entities', []rt.PhpVal{})
		if rt.is_true(rt.greater(var_already_imported, rt.new_int(0))) {
			rt.call_method(var_progress, 'tick', [var_already_imported.clone()])
		} else {
			rt.call_method(var_progress, 'tick', [var_initial_tick.clone()])
		}
	} else {
		rt.call_method(var_progress, 'tick', [var_initial_tick.clone()])
	}
	this.configure_product_importer()
	this.execute_migration_loop(var_fetcher.clone(), var_mapper.clone(), var_progress.clone())
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	this.display_migration_summary()
	this.display_feedback_survey()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run')))))) {
		mut var_final_stats := rt.create_array([rt.ArrayItem{ key: 'total_found', val: var_total_count }, rt.ArrayItem{ key: 'total_imported', val: rt.call_method(this.session, 'count_all_imported_entities', []rt.PhpVal{}) }])
		rt.call_function('do_action', [rt.new_string('wc_migrator_session_completed'), this.parsed_args.array_get(rt.new_string('platform')), var_final_stats.clone()])
		this.log_session_time_metrics(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_final_stats))
	}
	if rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run'))) {
	mut iife_temp_5 := Class_WP_CLI{}
	mut iife_result_5 := iife_temp_5.success(rt.new_string('Dry-run completed successfully. No products were actually created or modified.'))
	} else {
	mut iife_temp_6 := Class_WP_CLI{}
	mut iife_result_6 := iife_temp_6.success(rt.new_string('Migration completed successfully.'))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) execute_migration_loop(var_fetcher rt.PhpVal, var_mapper rt.PhpVal, var_progress rt.PhpVal) {
	mut var_fetcher_mutated := var_fetcher
	mut var_mapper_mutated := var_mapper
	mut var_progress_mutated := var_progress
	mut var_limit_remaining := this.parsed_args.array_get(rt.new_string('limit'))
	mut var_session_cursor := if rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run'))) { rt.new_null() } else { rt.call_method(this.session, 'get_reentrancy_cursor', []rt.PhpVal{}) }
	mut var_after_cursor := if !(!rt.is_true(var_session_cursor)) { var_session_cursor } else { rt.new_null() }
	mut var_has_next_page := rt.new_bool(true)
	mut var_total_processed_in_session := rt.new_int(0)
	for {
		mut var_batch_limit := rt.call_function('min', [this.parsed_args.array_get(rt.new_string('batch_size')), var_limit_remaining.clone()])
		if rt.is_true(rt.less_equal(var_batch_limit, rt.new_int(0))) {
			break
		}
		mut var_batch_args := rt.create_array([rt.ArrayItem{ key: 'limit', val: var_batch_limit }, rt.ArrayItem{ key: 'after_cursor', val: var_after_cursor }])
		if !(!rt.is_true(this.parsed_args.array_get(rt.new_string('filters')))) {
		var_batch_args = rt.call_function('array_merge', [var_batch_args.clone(), this.parsed_args.array_get(rt.new_string('filters'))])
		}
		mut var_batch_data := rt.call_method(var_fetcher_mutated, 'fetch_batch', [var_batch_args.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			rt.call_function('do_action', [rt.new_string('wc_migrator_error_occurred'), rt.new_string('fetch'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'batch_args', val: var_batch_args }, rt.ArrayItem{ key: 'platform', val: this.parsed_args.array_get(rt.new_string('platform')) }])])
			mut iife_temp_7 := Class_WP_CLI{}
			mut iife_result_7 := iife_temp_7.warning(rt.new_string((rt.concat(rt.new_string('Error fetching batch: '), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))).str()))
			break
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		if !rt.is_true(var_batch_data.array_get(rt.new_string('items'))) {
			break
		}
		mut var_processed_count := rt.new_int(this.process_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_batch_data.array_get(rt.new_string('items'))), var_mapper_mutated.clone()))
		var_total_processed_in_session = rt.add(var_total_processed_in_session, var_processed_count)
		if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run')))))) {
			rt.call_method(this.session, 'bump_imported_entities_counts', [rt.create_array([rt.ArrayItem{ key: 'post', val: var_processed_count }])])
			var_after_cursor = var_batch_data.array_get(rt.new_string('cursor'))
			rt.call_method(this.session, 'set_reentrancy_cursor', [var_after_cursor.clone()])
		} else {
		var_after_cursor = var_batch_data.array_get(rt.new_string('cursor'))
		}
		var_limit_remaining = rt.sub(var_limit_remaining, rt.new_int(var_batch_data.array_get(rt.new_string('items')).array_count()))
		var_has_next_page = if !(var_batch_data.array_get(rt.new_string('has_next_page'))).is_null() { var_batch_data.array_get(rt.new_string('has_next_page')) } else { rt.new_bool(false) }
		rt.call_method(var_progress_mutated, 'tick', [var_processed_count.clone(), rt.call_function('sprintf', [rt.new_string('Processed %d products'), var_total_processed_in_session.clone()])])
		if !(rt.is_true(var_has_next_page) && rt.is_true(rt.greater(var_limit_remaining, rt.new_int(0)))) {
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_next_page)))) && rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run')))))) {
		rt.call_method(this.session, 'set_stage', [Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.stage_finished()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) parse_and_validate_args(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, platform string) rt.PhpVal {
	mut platform_mutated := platform
	mut var_parsed := rt.new_array()
	if platform_mutated == '' {
		platform_mutated = (rt.call_method(this.platform_registry, 'resolve_platform', [var_assoc_args])).str()
		if platform_mutated == '' {
			return rt.new_array()
		}
	}
	var_parsed.array_set('platform', platform_mutated)
	this.fields_to_process = this.parse_field_selection(mut var_assoc_args)
	var_parsed.array_set('fields', this.fields_to_process)
	var_parsed.array_set('limit', if var_assoc_args.array_isset(rt.new_string('limit')) { rt.call_function('max', [rt.new_int(1), rt.new_int((var_assoc_args.array_get(rt.new_string('limit'))).to_i64())]) } else { rt.get_constant('PHP_INT_MAX') })
	var_parsed.array_set('batch_size', if var_assoc_args.array_isset(rt.new_string('batch-size')) { rt.call_function('max', [rt.new_int(1), rt.call_function('min', [rt.new_int(250), rt.new_int((var_assoc_args.array_get(rt.new_string('batch-size'))).to_i64())])]) } else { rt.new_int(20) })
	var_parsed.array_set('skip_existing', rt.new_bool(var_assoc_args.array_isset(rt.new_string('skip-existing'))))
	var_parsed.array_set('dry_run', rt.new_bool(var_assoc_args.array_isset(rt.new_string('dry-run'))))
	var_parsed.array_set('resume', rt.new_bool(var_assoc_args.array_isset(rt.new_string('resume'))))
	var_parsed.array_set('verbose', rt.new_bool(var_assoc_args.array_isset(rt.new_string('verbose'))))
	var_parsed.array_set('assign_default_category', rt.new_bool(var_assoc_args.array_isset(rt.new_string('assign-default-category'))))
	var_parsed.array_set('filters', this.parse_query_filters(mut var_assoc_args))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.credential_manager, 'has_credentials', [rt.new_string(platform_mutated).clone()]))))) {
		mut var_platform_display_name := rt.call_method(this.platform_registry, 'get_platform_display_name', [rt.new_string(platform_mutated).clone()])
		mut iife_temp_8 := Class_WP_CLI{}
		mut iife_result_8 := iife_temp_8.error(rt.call_function('sprintf', [rt.new_string('No credentials found for platform \'%s\'. Please run: wp wc migrate setup --platform=%s'), var_platform_display_name.clone(), rt.new_string(platform_mutated).clone()]))
		return rt.new_array()
	}
	return var_parsed.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) parse_field_selection(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_default_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'catalog_visibility' }, rt.ArrayItem{ key: none, val: 'categories' }, rt.ArrayItem{ key: none, val: 'tags' }, rt.ArrayItem{ key: none, val: 'price' }, rt.ArrayItem{ key: none, val: 'sku' }, rt.ArrayItem{ key: none, val: 'stock' }, rt.ArrayItem{ key: none, val: 'weight' }, rt.ArrayItem{ key: none, val: 'brand' }, rt.ArrayItem{ key: none, val: 'images' }, rt.ArrayItem{ key: none, val: 'attributes' }, rt.ArrayItem{ key: none, val: 'metafields' }])
	mut var_excluded_fields := rt.new_array()
	mut var_explicitly_selected := rt.new_bool(false)
	if var_assoc_args.array_isset(rt.new_string('fields')) {
		var_explicitly_selected = rt.new_bool(true)
		mut var_selected_fields := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_assoc_args.array_get(rt.new_string('fields'))])])
		var_selected_fields = rt.call_function('array_filter', [var_selected_fields.clone()])
		mut var_invalid_fields := rt.call_function('array_diff', [var_selected_fields.clone(), var_default_fields.clone()])
		if !(!rt.is_true(var_invalid_fields)) {
		mut iife_temp_9 := Class_WP_CLI{}
		mut iife_result_9 := iife_temp_9.warning(rt.call_function('sprintf', [rt.new_string('Invalid field names: %s. Valid fields: %s'), rt.call_function('implode', [rt.new_string(', '), var_invalid_fields.clone()]), rt.call_function('implode', [rt.new_string(', '), var_default_fields.clone()])]))
		}
	mut var_fields := rt.call_function('array_intersect', [var_selected_fields.clone(), var_default_fields.clone()])
	var_excluded_fields = rt.call_function('array_diff', [var_default_fields.clone(), var_fields.clone()])
	} else {
	var_fields = var_default_fields.clone()
	}
	if var_assoc_args.array_isset(rt.new_string('exclude-fields')) {
	mut var_exclude_fields_input := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_assoc_args.array_get(rt.new_string('exclude-fields'))])])
	var_excluded_fields = rt.call_function('array_merge', [var_excluded_fields.clone(), var_exclude_fields_input.clone()])
	var_fields = rt.call_function('array_diff', [var_fields.clone(), var_exclude_fields_input.clone()])
	}
	if !rt.is_true(var_fields) {
		mut iife_temp_10 := Class_WP_CLI{}
		mut iife_result_10 := iife_temp_10.error(rt.new_string('No valid fields selected for migration.'))
		return rt.new_array()
	}
	if rt.is_true(var_explicitly_selected) || var_assoc_args.array_isset(rt.new_string('exclude-fields')) || !(!rt.is_true(var_assoc_args.array_get(rt.new_string('verbose')))) {
		mut var_include_message := rt.call_function('sprintf', [rt.new_string('Including fields: %s'), rt.call_function('implode', [rt.new_string(', '), var_fields.clone()])])
		mut iife_temp_11 := Class_WP_CLI{}
		mut iife_result_11 := iife_temp_11.log(var_include_message.clone())
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [var_include_message.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
		if !(!rt.is_true(var_excluded_fields)) {
			mut var_exclude_message := rt.call_function('sprintf', [rt.new_string('Excluding fields: %s'), rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_unique', [var_excluded_fields.clone()])])])
			mut iife_temp_12 := Class_WP_CLI{}
			mut iife_result_12 := iife_temp_12.log(var_exclude_message.clone())
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [var_exclude_message.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
		}
	}
	return var_fields.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) parse_query_filters(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_filters := rt.new_array()
	if var_assoc_args.array_isset(rt.new_string('status')) {
		mut var_valid_statuses := rt.create_array([rt.ArrayItem{ key: none, val: 'active' }, rt.ArrayItem{ key: none, val: 'archived' }, rt.ArrayItem{ key: none, val: 'draft' }])
		mut var_status := rt.new_string(var_assoc_args.array_get(rt.new_string('status')).to_string().to_lower())
		if rt.is_true(rt.call_function('in_array', [var_status.clone(), var_valid_statuses.clone(), rt.new_bool(true)])) {
			var_filters.array_set('status', var_status.clone())
		} else {
		mut iife_temp_13 := Class_WP_CLI{}
		mut iife_result_13 := iife_temp_13.warning(rt.call_function('sprintf', [rt.new_string('Invalid status "%s". Valid options: %s'), var_status.clone(), rt.call_function('implode', [rt.new_string(', '), var_valid_statuses.clone()])]))
		}
	}
	if var_assoc_args.array_isset(rt.new_string('created-after')) {
		mut var_date := rt.new_string(this.validate_date_filter((var_assoc_args.array_get(rt.new_string('created-after'))).str(), 'created-after'))
		if rt.is_true(var_date) {
			var_filters.array_set('created_after', var_date.clone())
		}
	}
	if var_assoc_args.array_isset(rt.new_string('created-before')) {
		var_date = rt.new_string(this.validate_date_filter((var_assoc_args.array_get(rt.new_string('created-before'))).str(), 'created-before'))
		if rt.is_true(var_date) {
			var_filters.array_set('created_before', var_date.clone())
		}
	}
	if var_assoc_args.array_isset(rt.new_string('product-type')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_assoc_args.array_get(rt.new_string('product-type')))))) {
		var_filters.array_set('product_type', var_assoc_args.array_get(rt.new_string('product-type')))
	}
	if var_assoc_args.array_isset(rt.new_string('handle')) {
		var_filters.array_set('handle', rt.call_function('sanitize_title', [var_assoc_args.array_get(rt.new_string('handle'))]))
	}
	if var_assoc_args.array_isset(rt.new_string('vendor')) {
		var_filters.array_set('vendor', var_assoc_args.array_get(rt.new_string('vendor')))
	}
	if var_assoc_args.array_isset(rt.new_string('ids')) {
		var_filters.array_set('ids', var_assoc_args.array_get(rt.new_string('ids')))
	}
	return var_filters.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) validate_date_filter(date_input string, filter_name string) string {
	mut var_timestamp := rt.call_function('strtotime', [rt.new_string(date_input)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_timestamp)) {
		mut iife_temp_14 := Class_WP_CLI{}
		mut iife_result_14 := iife_temp_14.warning(rt.call_function('sprintf', [rt.new_string('Invalid date format for --%s: %s'), rt.new_string(filter_name), rt.new_string(date_input)]))
		return (rt.new_null()).str()
	}
	return (rt.call_function('gmdate', [rt.new_string('Y-m-d\\TH:i:s\\Z'), var_timestamp.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) manage_session_lifecycle(mut var_parsed_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut iife_temp_15 := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession{}
	mut iife_result_15 := iife_temp_15.get_active()
	mut var_active_session := iife_result_15
	if rt.is_true(var_active_session) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_active_session, 'is_finished', []rt.PhpVal{}))))) {
		return this.handle_existing_session(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession](var_active_session), mut var_parsed_args)
	}
	return this.create_new_session(mut var_parsed_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) handle_existing_session(mut var_session Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession, mut var_parsed_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_session_mutated := var_session
	mut var_metadata := rt.call_method(var_session_mutated, 'get_metadata', []rt.PhpVal{})
	mut var_total_imported := rt.call_method(var_session_mutated, 'count_all_imported_entities', []rt.PhpVal{})
	mut var_total_entities := rt.call_method(var_session_mutated, 'count_all_total_entities', []rt.PhpVal{})
	mut var_started_timestamp := rt.call_method(var_session_mutated, 'get_started_at', []rt.PhpVal{})
	mut var_started_at := if var_started_timestamp.clone().is_long() || var_started_timestamp.clone().is_double() { rt.call_function('get_date_from_gmt', [rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.new_int((var_started_timestamp).to_i64())])]) } else { var_started_timestamp }
	mut iife_temp_16 := Class_WP_CLI{}
	mut iife_result_16 := iife_temp_16.line(rt.new_string(''))
	mut iife_temp_17 := Class_WP_CLI{}
	mut iife_result_17 := iife_temp_17.colorize(rt.new_string('%YExisting Migration Session Found:%n'))
	mut iife_temp_18 := Class_WP_CLI{}
	mut iife_result_18 := iife_temp_18.line(iife_result_17)
	mut iife_temp_19 := Class_WP_CLI{}
	mut iife_result_19 := iife_temp_19.line(rt.call_function('sprintf', [rt.new_string('  Session ID: %d'), rt.call_method(var_session_mutated, 'get_id', []rt.PhpVal{})]))
	mut iife_temp_20 := Class_WP_CLI{}
	mut iife_result_20 := iife_temp_20.line(rt.call_function('sprintf', [rt.new_string('  Platform: %s'), var_metadata.array_get(rt.new_string('data_source'))]))
	mut iife_temp_21 := Class_WP_CLI{}
	mut iife_result_21 := iife_temp_21.line(rt.call_function('sprintf', [rt.new_string('  Started: %s'), var_started_at.clone()]))
	mut iife_temp_22 := Class_WP_CLI{}
	mut iife_result_22 := iife_temp_22.line(rt.call_function('sprintf', [rt.new_string('  Progress: %d / %d products imported'), var_total_imported.clone(), var_total_entities.clone()]))
	if rt.is_true(if !(var_parsed_args.array_get(rt.new_string('verbose'))).is_null() { var_parsed_args.array_get(rt.new_string('verbose')) } else { rt.new_bool(false) }) && rt.is_true(rt.call_method(var_session_mutated, 'get_reentrancy_cursor', []rt.PhpVal{})) {
	mut iife_temp_23 := Class_WP_CLI{}
	mut iife_result_23 := iife_temp_23.line(rt.call_function('sprintf', [rt.new_string('  Last Cursor: %s'), rt.new_string((rt.call_function('substr', [rt.call_method(var_session_mutated, 'get_reentrancy_cursor', []rt.PhpVal{}), rt.new_int(0), rt.new_int(50)])).str() + '...')]))
	}
	mut var_original_args := rt.call_method(var_session_mutated, 'get_original_arguments', []rt.PhpVal{})
	if rt.is_true(var_original_args) {
		mut iife_temp_24 := Class_WP_CLI{}
		mut iife_result_24 := iife_temp_24.line(rt.new_string(''))
		mut iife_temp_25 := Class_WP_CLI{}
		mut iife_result_25 := iife_temp_25.colorize(rt.new_string('%YOriginal Command Arguments:%n'))
		mut iife_temp_26 := Class_WP_CLI{}
		mut iife_result_26 := iife_temp_26.line(iife_result_25)
		this.display_saved_arguments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_original_args))
	}
	mut iife_temp_27 := Class_WP_CLI{}
	mut iife_result_27 := iife_temp_27.line(rt.new_string(''))
	mut var_should_resume := if !(var_parsed_args.array_get(rt.new_string('resume'))).is_null() { var_parsed_args.array_get(rt.new_string('resume')) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_resume)))) {
		mut iife_temp_28 := Class_WP_CLI{}
		mut iife_result_28 := iife_temp_28.out(rt.new_string('Do you want to resume this migration session? [y/n] '))
		mut var_answer := rt.new_string(this.get_user_input())
		if rt.is_true(rt.identical(rt.new_string('y'), var_answer)) {
		var_should_resume = rt.new_bool(true)
		} else {
		var_should_resume = rt.new_bool(false)
		}
	}
	if rt.is_true(var_should_resume) {
		mut iife_temp_29 := Class_WP_CLI{}
		mut iife_result_29 := iife_temp_29.success(rt.call_function('sprintf', [rt.new_string('Resuming migration session %d'), rt.call_method(var_session_mutated, 'get_id', []rt.PhpVal{})]))
		var_original_args = rt.call_method(var_session_mutated, 'get_original_arguments', []rt.PhpVal{})
		if rt.is_true(var_original_args) {
			this.restore_original_arguments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_original_args))
		mut iife_temp_30 := Class_WP_CLI{}
		mut iife_result_30 := iife_temp_30.line(rt.new_string('Original command arguments have been restored.'))
		}
		return rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession', []string{}, var_session_mutated)
	} else {
		rt.call_method(var_session_mutated, 'archive', []rt.PhpVal{})
		mut iife_temp_31 := Class_WP_CLI{}
		mut iife_result_31 := iife_temp_31.line(rt.new_string('Previous session archived. Starting a new import session.'))
		mut var_new_session := this.create_new_session(mut var_parsed_args)
		if rt.is_true(var_new_session) {
		mut iife_temp_32 := Class_WP_CLI{}
		mut iife_result_32 := iife_temp_32.success(rt.call_function('sprintf', [rt.new_string('Starting fresh migration from the beginning (Session %d)'), rt.call_method(var_new_session, 'get_id', []rt.PhpVal{})]))
		}
		return var_new_session.clone()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) create_new_session(mut var_parsed_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut iife_temp_33 := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession{}
	mut iife_result_33 := iife_temp_33.create(rt.create_array([rt.ArrayItem{ key: 'data_source', val: var_parsed_args.array_get(rt.new_string('platform')) }, rt.ArrayItem{ key: 'file_name', val: rt.call_function('sprintf', [rt.new_string('%s Migration - %s'), rt.call_function('ucfirst', [var_parsed_args.array_get(rt.new_string('platform'))]), rt.call_function('current_time', [rt.new_string('mysql')])]) }]))
	mut var_session := iife_result_33
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_session, 'set_original_arguments', [var_parsed_args])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return var_session.clone()
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		mut iife_temp_34 := Class_WP_CLI{}
		mut iife_result_34 := iife_temp_34.error(rt.call_function('sprintf', [rt.new_string('Failed to create migration session: %s'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]))
		return rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) process_batch(mut var_batch_items Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, var_mapper rt.PhpVal) i64 {
	mut var_mapper_mutated := var_mapper
	mut var_processed_count := rt.new_int(0)
	mut var_mapped_products := rt.new_array()
	mut var_source_data_batch := rt.new_array()
	mut iter_1 := var_batch_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if var_item.clone().is_object() && !(rt.get_property(var_item, 'node')).is_null() {
			mut var_product_data := rt.get_property(var_item, 'node')
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		} else if var_item.clone().is_array() && var_item.array_isset(rt.new_string('node')) {
			var_product_data = var_item.array_get(rt.new_string('node'))
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		} else {
			var_product_data = var_item
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		mut var_mapped_product := rt.call_method(var_mapper_mutated, 'map_product_data', [var_product_data.clone()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if !(!rt.is_true(var_mapped_product)) {
			var_mapped_products.array_push(var_mapped_product.clone())
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			var_source_data_batch.array_push(if var_product_data.clone().is_object() { rt.cast_array(var_product_data) } else { var_product_data })
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Exception') {
			mut var_e := var_e_3.clone()
			rt.call_function('do_action', [rt.new_string('wc_migrator_error_occurred'), rt.new_string('mapping'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'product_data', val: var_product_data }, rt.ArrayItem{ key: 'platform', val: this.parsed_args.array_get(rt.new_string('platform')) }])])
			mut iife_temp_35 := Class_WP_CLI{}
			mut iife_result_35 := iife_temp_35.warning(rt.call_function('sprintf', [rt.new_string('Error mapping product: %s'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]))
			continue
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
	}
	if !(!rt.is_true(var_mapped_products)) {
		if rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run'))) {
		mut var_batch_results := this.simulate_import_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_mapped_products))
		} else {
		var_batch_results = rt.call_method(this.product_importer, 'import_batch', [var_mapped_products.clone(), var_source_data_batch.clone()])
		}
		rt.call_function('do_action', [rt.new_string('wc_migrator_batch_processed'), var_batch_results.clone(), var_source_data_batch.clone(), var_mapped_products.clone()])
		this.log_batch_results(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_batch_results))
		var_processed_count = var_batch_results.array_get(rt.new_string('stats')).array_get(rt.new_string('successful'))
		if rt.is_true(rt.greater(var_processed_count, rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run')))))) {
			mut var_current_count := rt.call_function('get_option', [rt.new_string('wc_migrator_products_count'), rt.new_int(0)])
			rt.call_function('update_option', [rt.new_string('wc_migrator_products_count'), rt.add(var_current_count, var_processed_count)])
		}
	}
	return (var_processed_count).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) simulate_import_batch(mut var_mapped_products Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_mapped_products_mutated := var_mapped_products
	mut var_results := rt.new_array()
	mut var_stats := rt.create_array([rt.ArrayItem{ key: 'successful', val: 0 }, rt.ArrayItem{ key: 'failed', val: 0 }, rt.ArrayItem{ key: 'skipped', val: 0 }])
	mut iter_2 := var_mapped_products_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product_data := item_2.val
		mut var_product_name := if !(var_product_data.array_get(rt.new_string('name'))).is_null() { var_product_data.array_get(rt.new_string('name')) } else { rt.new_string('Unknown Product') }
		if !rt.is_true(var_product_data.array_get(rt.new_string('name'))) {
			var_results.array_push(rt.create_array([rt.ArrayItem{ key: 'status', val: 'error' }, rt.ArrayItem{ key: 'message', val: 'Product name is required' }, rt.ArrayItem{ key: 'data', val: var_product_data }]))
			rt.pre_inc(var_stats.array_get(rt.new_string('failed')))
			this.simulate_stats_increment('errors_encountered')
			continue
		}
		mut var_existing_product_id := rt.new_null()
		if !(!rt.is_true(var_product_data.array_get(rt.new_string('sku')))) {
		var_existing_product_id = rt.call_function('wc_get_product_id_by_sku', [var_product_data.array_get(rt.new_string('sku'))])
		}
		mut var_would_skip := rt.new_bool(false)
		if rt.is_true(var_existing_product_id) && rt.is_true(this.parsed_args.array_get(rt.new_string('skip_existing'))) {
		var_would_skip = rt.new_bool(true)
		}
		if rt.is_true(var_would_skip) {
			var_results.array_push(rt.create_array([rt.ArrayItem{ key: 'status', val: 'skipped' }, rt.ArrayItem{ key: 'message', val: "Product '${var_product_name.to_string()}' would be skipped (already exists)" }, rt.ArrayItem{ key: 'data', val: var_product_data }]))
			rt.pre_inc(var_stats.array_get(rt.new_string('skipped')))
			this.simulate_stats_increment('products_skipped')
		} else {
			var_results.array_push(rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'message', val: "Product '${var_product_name.to_string()}' would be imported" }, rt.ArrayItem{ key: 'data', val: var_product_data }]))
			rt.pre_inc(var_stats.array_get(rt.new_string('successful')))
			if rt.is_true(var_existing_product_id) {
				this.simulate_stats_increment('products_updated')
			} else {
				this.simulate_stats_increment('products_created')
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string('images'), this.fields_to_process, rt.new_bool(true)])) && !(!rt.is_true(var_product_data.array_get(rt.new_string('images')))) {
				mut var_image_count := rt.new_int(if var_product_data.array_get(rt.new_string('images')).is_array() { var_product_data.array_get(rt.new_string('images')).array_count() } else { 1 })
				mut var_i := rt.new_int(0)
				for {
					if !(rt.is_true(rt.less(var_i, var_image_count))) { break }
					this.simulate_stats_increment('images_processed')
					rt.post_inc(var_i)
				}
			}
		}
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string("DRY RUN: Would import product '${var_product_name.to_string()}'"), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
	}
	return rt.create_array([rt.ArrayItem{ key: 'results', val: var_results }, rt.ArrayItem{ key: 'stats', val: var_stats }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) simulate_stats_increment(stat_key string) {
	mut var_reflection := create_automattic_woocommerce_internal_cli_migrator_core_reflectionclass(this.product_importer)
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_stats_property := var_reflection.getproperty(rt.new_string('import_stats'))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_method(var_stats_property, 'setAccessible', [rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_current_stats := rt.call_method(var_stats_property, 'getValue', [this.product_importer])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if var_current_stats.array_isset(rt.new_string(stat_key)) {
		rt.pre_inc(var_current_stats.array_get(rt.new_string(stat_key)))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		rt.call_method(var_stats_property, 'setValue', [this.product_importer, var_current_stats.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Internal_CLI_Migrator_Core_ReflectionException') {
		mut var_e := var_e_4.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string("DRY RUN: Could not update import stats for '${var_stat_key}': " + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) configure_product_importer() {
	mut var_import_options := rt.create_array([rt.ArrayItem{ key: 'skip_existing', val: if !(this.parsed_args.array_get(rt.new_string('skip_existing'))).is_null() { this.parsed_args.array_get(rt.new_string('skip_existing')) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'update_existing', val: !(rt.is_true(if !(this.parsed_args.array_get(rt.new_string('skip_existing'))).is_null() { this.parsed_args.array_get(rt.new_string('skip_existing')) } else { rt.new_bool(false) })) }, rt.ArrayItem{ key: 'import_images', val: rt.call_function('in_array', [rt.new_string('images'), this.fields_to_process, rt.new_bool(true)]) }, rt.ArrayItem{ key: 'skip_duplicate_images', val: true }, rt.ArrayItem{ key: 'create_categories', val: rt.call_function('in_array', [rt.new_string('categories'), this.fields_to_process, rt.new_bool(true)]) }, rt.ArrayItem{ key: 'create_tags', val: rt.call_function('in_array', [rt.new_string('tags'), this.fields_to_process, rt.new_bool(true)]) }, rt.ArrayItem{ key: 'handle_variations', val: rt.call_function('in_array', [rt.new_string('attributes'), this.fields_to_process, rt.new_bool(true)]) }, rt.ArrayItem{ key: 'assign_default_category', val: if !(this.parsed_args.array_get(rt.new_string('assign_default_category'))).is_null() { this.parsed_args.array_get(rt.new_string('assign_default_category')) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'verbose', val: if !(this.parsed_args.array_get(rt.new_string('verbose'))).is_null() { this.parsed_args.array_get(rt.new_string('verbose')) } else { rt.new_bool(false) } }])
	rt.call_method(this.product_importer, 'configure', [var_import_options.clone()])
	if rt.is_true(if !(this.parsed_args.array_get(rt.new_string('verbose'))).is_null() { this.parsed_args.array_get(rt.new_string('verbose')) } else { rt.new_bool(false) }) {
		rt.call_method(this.product_importer, 'set_progress_callback', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'display_product_progress' }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_product_progress(current_index i64, total_count i64, product_name string, mut var_result Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?array) {
	mut total_count_mutated := total_count
	mut product_name_mutated := product_name
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		return
	}
	mut var_display_name := rt.new_string((if product_name_mutated.len > 40 { (rt.call_function('substr', [rt.new_string(product_name_mutated).clone(), rt.new_int(0), rt.new_int(37)])).str() + '...' } else { product_name_mutated }).str())
	mut var_status_char := rt.new_string('✓')
	mut var_status_color := rt.new_string('%G')
	if rt.is_true(rt.identical(rt.new_string('error'), var_result.array_get(rt.new_string('status')))) {
	var_status_char = rt.new_string('✗')
	var_status_color = rt.new_string('%R')
	} else if rt.is_true(rt.identical(rt.new_string('success'), var_result.array_get(rt.new_string('status')))) && rt.is_true(rt.identical(rt.new_string('skipped'), var_result.array_get(rt.new_string('action')))) {
	var_status_char = rt.new_string('−')
	var_status_color = rt.new_string('%Y')
	}
	mut var_progress := rt.call_function('sprintf', [rt.new_string('[%d/%d]'), rt.new_int(current_index), rt.new_int(total_count_mutated).clone()])
	if 1 == current_index {
	mut iife_temp_36 := Class_WP_CLI{}
	mut iife_result_36 := iife_temp_36.line(rt.new_string(''))
	}
mut iife_temp_37 := Class_WP_CLI{}
mut iife_result_37 := iife_temp_37.colorize(rt.call_function('sprintf', [rt.new_string('%s%s%s %s %s'), var_status_color.clone(), var_status_char.clone(), rt.new_string('%n'), var_progress.clone(), var_display_name.clone()]))
mut iife_temp_38 := Class_WP_CLI{}
mut iife_result_38 := iife_temp_38.line(iife_result_37)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) log_batch_results(mut var_batch_results Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_batch_results_mutated := var_batch_results
	mut var_stats := var_batch_results_mutated.array_get(rt.new_string('stats'))
	if rt.is_true(this.parsed_args.array_get(rt.new_string('verbose'))) && rt.is_true(rt.greater(var_stats.array_get(rt.new_string('failed')), rt.new_int(0))) {
		mut iife_temp_39 := Class_WP_CLI{}
		mut iife_result_39 := iife_temp_39.warning(rt.call_function('sprintf', [rt.new_string('%d products failed to import'), var_stats.array_get(rt.new_string('failed'))]))
		mut var_error_count := rt.new_int(0)
		mut iter_3 := var_batch_results_mutated.array_get(rt.new_string('results')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_result := item_3.val
			if rt.is_true(rt.identical(rt.new_string('error'), var_result.array_get(rt.new_string('status')))) && rt.is_true(rt.less(var_error_count, rt.new_int(3))) {
				mut iife_temp_40 := Class_WP_CLI{}
				mut iife_result_40 := iife_temp_40.warning(rt.call_function('sprintf', [rt.new_string('Import error: %s'), var_result.array_get(rt.new_string('message'))]))
				rt.pre_inc(var_error_count)
			}
		}
	}
	if rt.is_true(this.parsed_args.array_get(rt.new_string('verbose'))) && rt.is_true(rt.greater(var_stats.array_get(rt.new_string('skipped')), rt.new_int(5))) {
	mut iife_temp_41 := Class_WP_CLI{}
	mut iife_result_41 := iife_temp_41.log(rt.call_function('sprintf', [rt.new_string('Skipped %d existing products'), var_stats.array_get(rt.new_string('skipped'))]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_migration_summary() {
	if rt.is_true(rt.identical(rt.new_null(), this.product_importer)) {
		return
	}
	mut var_stats := rt.call_method(this.product_importer, 'get_import_stats', []rt.PhpVal{})
	mut iife_temp_42 := Class_WP_CLI{}
	mut iife_result_42 := iife_temp_42.line(rt.new_string(''))
	if rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run'))) {
	mut iife_temp_43 := Class_WP_CLI{}
	mut iife_result_43 := iife_temp_43.colorize(rt.new_string('%YDry-Run Summary:%n'))
	mut iife_temp_44 := Class_WP_CLI{}
	mut iife_result_44 := iife_temp_44.line(iife_result_43)
	mut iife_temp_45 := Class_WP_CLI{}
	mut iife_result_45 := iife_temp_45.line(rt.call_function('sprintf', [rt.new_string('  Products Would Be Created: %d'), var_stats.array_get(rt.new_string('products_created'))]))
	mut iife_temp_46 := Class_WP_CLI{}
	mut iife_result_46 := iife_temp_46.line(rt.call_function('sprintf', [rt.new_string('  Products Would Be Updated: %d'), var_stats.array_get(rt.new_string('products_updated'))]))
	mut iife_temp_47 := Class_WP_CLI{}
	mut iife_result_47 := iife_temp_47.line(rt.call_function('sprintf', [rt.new_string('  Products Would Be Skipped: %d'), var_stats.array_get(rt.new_string('products_skipped'))]))
	mut iife_temp_48 := Class_WP_CLI{}
	mut iife_result_48 := iife_temp_48.line(rt.call_function('sprintf', [rt.new_string('  Images Would Be Processed: %d'), var_stats.array_get(rt.new_string('images_processed'))]))
	} else {
	mut iife_temp_49 := Class_WP_CLI{}
	mut iife_result_49 := iife_temp_49.colorize(rt.new_string('%YMigration Summary:%n'))
	mut iife_temp_50 := Class_WP_CLI{}
	mut iife_result_50 := iife_temp_50.line(iife_result_49)
	mut iife_temp_51 := Class_WP_CLI{}
	mut iife_result_51 := iife_temp_51.line(rt.call_function('sprintf', [rt.new_string('  Products Created: %d'), var_stats.array_get(rt.new_string('products_created'))]))
	mut iife_temp_52 := Class_WP_CLI{}
	mut iife_result_52 := iife_temp_52.line(rt.call_function('sprintf', [rt.new_string('  Products Updated: %d'), var_stats.array_get(rt.new_string('products_updated'))]))
	mut iife_temp_53 := Class_WP_CLI{}
	mut iife_result_53 := iife_temp_53.line(rt.call_function('sprintf', [rt.new_string('  Products Skipped: %d'), var_stats.array_get(rt.new_string('products_skipped'))]))
	mut iife_temp_54 := Class_WP_CLI{}
	mut iife_result_54 := iife_temp_54.line(rt.call_function('sprintf', [rt.new_string('  Images Processed: %d'), var_stats.array_get(rt.new_string('images_processed'))]))
	}
	if rt.is_true(rt.greater(var_stats.array_get(rt.new_string('errors_encountered')), rt.new_int(0))) {
		if rt.is_true(this.parsed_args.array_get(rt.new_string('dry_run'))) {
		mut iife_temp_55 := Class_WP_CLI{}
		mut iife_result_55 := iife_temp_55.colorize(rt.call_function('sprintf', [rt.new_string('  %%RValidation Errors Found: %d%%n'), var_stats.array_get(rt.new_string('errors_encountered'))]))
		mut iife_temp_56 := Class_WP_CLI{}
		mut iife_result_56 := iife_temp_56.line(iife_result_55)
		} else {
		mut iife_temp_57 := Class_WP_CLI{}
		mut iife_result_57 := iife_temp_57.colorize(rt.call_function('sprintf', [rt.new_string('  %%RErrors Encountered: %d%%n'), var_stats.array_get(rt.new_string('errors_encountered'))]))
		mut iife_temp_58 := Class_WP_CLI{}
		mut iife_result_58 := iife_temp_58.line(iife_result_57)
		}
	}
mut iife_temp_59 := Class_WP_CLI{}
mut iife_result_59 := iife_temp_59.line(rt.new_string(''))
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) log_session_time_metrics(mut var_final_stats Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_final_stats_mutated := var_final_stats
	mut var_session_products := if !(var_final_stats_mutated.array_get(rt.new_string('total_imported'))).is_null() { var_final_stats_mutated.array_get(rt.new_string('total_imported')) } else { rt.new_int(0) }
	if !rt.is_true(var_session_products) {
		return
	}
	if !rt.is_true(this.session_start_time) {
		return
	}
	mut var_session_duration_seconds := rt.sub(rt.call_function('time', []rt.PhpVal{}), this.session_start_time)
	mut var_platform := this.parsed_args.array_get(rt.new_string('platform'))
	mut var_avg_time_per_product := rt.div(var_session_duration_seconds, var_session_products)
	mut var_session_time_formatted := rt.call_function('human_time_diff', [rt.new_int(0), var_session_duration_seconds.clone()])
	mut var_avg_time_formatted := rt.call_function('number_format', [var_avg_time_per_product.clone(), rt.new_int(2)])
	mut var_platform_display_name := rt.call_method(this.platform_registry, 'get_platform_display_name', [var_platform.clone()])
	mut var_metrics_message := rt.call_function('sprintf', [rt.new_string('Session completed for %s: %d products in %s (avg: %s seconds per product)'), var_platform_display_name.clone(), var_session_products.clone(), var_session_time_formatted.clone(), var_avg_time_formatted.clone()])
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [var_metrics_message.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-migrator' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_feedback_survey() {
mut iife_temp_60 := Class_WP_CLI{}
mut iife_result_60 := iife_temp_60.line(rt.new_string(''))
mut iife_temp_61 := Class_WP_CLI{}
mut iife_result_61 := iife_temp_61.colorize(rt.new_string('%GHelp us improve the WooCommerce Migrator!%n'))
mut iife_temp_62 := Class_WP_CLI{}
mut iife_result_62 := iife_temp_62.line(iife_result_61)
mut iife_temp_63 := Class_WP_CLI{}
mut iife_result_63 := iife_temp_63.line(rt.new_string('Please share your feedback about this migration experience:'))
mut iife_temp_64 := Class_WP_CLI{}
mut iife_result_64 := iife_temp_64.colorize(rt.new_string('%Chttps://developer.woocommerce.com/migrator-feedback/%n'))
mut iife_temp_65 := Class_WP_CLI{}
mut iife_result_65 := iife_temp_65.line(iife_result_64)
mut iife_temp_66 := Class_WP_CLI{}
mut iife_result_66 := iife_temp_66.line(rt.new_string(''))
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) get_user_input() string {
	return rt.call_function('fgets', [rt.get_constant('STDIN')]).to_string().trim_space().to_lower()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_saved_arguments(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_important_args := rt.create_array([rt.ArrayItem{ key: 'platform', val: 'Platform' }, rt.ArrayItem{ key: 'limit', val: 'Product Limit' }, rt.ArrayItem{ key: 'batch_size', val: 'Batch Size' }, rt.ArrayItem{ key: 'skip_existing', val: 'Skip Existing' }, rt.ArrayItem{ key: 'dry_run', val: 'Dry Run' }, rt.ArrayItem{ key: 'verbose', val: 'Verbose' }, rt.ArrayItem{ key: 'assign_default_category', val: 'Assign Default Category' }])
	mut iter_4 := var_important_args.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_label := item_4.val
		mut var_key := item_4.key
		if var_args.array_isset(var_key) {
			mut var_value := var_args.array_get(var_key)
			if rt.is_true(rt.new_bool(var_value.clone().is_bool())) {
			var_value = rt.new_string((if rt.is_true(var_value) { 'Yes' } else { 'No' }).str())
			} else if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_value = rt.call_function('implode', [rt.new_string(', '), var_value.clone()])
			} else if rt.is_true(rt.identical(rt.new_string('limit'), var_key)) && rt.is_true(rt.identical(rt.get_constant('PHP_INT_MAX'), rt.new_int((var_value).to_i64()))) {
			var_value = rt.new_string('All')
			}
		mut iife_temp_67 := Class_WP_CLI{}
		mut iife_result_67 := iife_temp_67.line(rt.call_function('sprintf', [rt.new_string('  %s: %s'), var_label.clone(), var_value.clone()]))
		}
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('filters')))) && var_args.array_get(rt.new_string('filters')).is_array() {
		mut iife_temp_68 := Class_WP_CLI{}
		mut iife_result_68 := iife_temp_68.line(rt.new_string('  Filters:'))
		mut iter_5 := var_args.array_get(rt.new_string('filters')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_filter_value := item_5.val
			mut var_filter_key := item_5.key
			if rt.is_true(rt.new_bool(var_filter_value.clone().is_array())) {
			var_filter_value = rt.call_function('implode', [rt.new_string(', '), var_filter_value.clone()])
			}
		mut iife_temp_69 := Class_WP_CLI{}
		mut iife_result_69 := iife_temp_69.line(rt.call_function('sprintf', [rt.new_string('    %s: %s'), var_filter_key.clone(), var_filter_value.clone()]))
		}
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('fields')))) && var_args.array_get(rt.new_string('fields')).is_array() {
	mut iife_temp_70 := Class_WP_CLI{}
	mut iife_result_70 := iife_temp_70.line(rt.call_function('sprintf', [rt.new_string('  Fields: %s'), rt.call_function('implode', [rt.new_string(', '), var_args.array_get(rt.new_string('fields'))])]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) restore_original_arguments(mut var_original_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_original_args_mutated := var_original_args
	mut iter_6 := var_original_args_mutated.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('resume'), var_key)))) {
			this.parsed_args.array_set(var_key, var_value.clone())
		}
	}
	if var_original_args_mutated.array_isset(rt.new_string('fields')) {
		this.fields_to_process = var_original_args_mutated.array_get(rt.new_string('fields'))
	}
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ReflectionClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_core_productscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController{
		PhpObjectBase: rt.PhpObjectBase{}
		credential_manager: rt.new_null()
		platform_registry: rt.new_null()
		session: rt.new_null()
		parsed_args: rt.new_array()
		fields_to_process: rt.new_array()
		product_importer: rt.new_null()
		tracker: rt.new_null()
		session_start_time: rt.new_int(0)
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_lib_importsession(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_core_reflectionclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ReflectionClass {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker](if args.len > 3 { args[3] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'migrate_products' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.migrate_products(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'execute_migration_loop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.execute_migration_loop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'parse_and_validate_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.parse_and_validate_args(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parse_field_selection' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parse_field_selection(mut dispatch_arg_0)
		}
		'parse_query_filters' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parse_query_filters(mut dispatch_arg_0)
		}
		'validate_date_filter' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.validate_date_filter(dispatch_arg_0, dispatch_arg_1))
		}
		'manage_session_lifecycle' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.manage_session_lifecycle(mut dispatch_arg_0)
		}
		'handle_existing_session' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.handle_existing_session(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'create_new_session' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create_new_session(mut dispatch_arg_0)
		}
		'process_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.process_batch(mut dispatch_arg_0, dispatch_arg_1))
		}
		'simulate_import_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.simulate_import_batch(mut dispatch_arg_0)
		}
		'simulate_stats_increment' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.simulate_stats_increment(dispatch_arg_0)
			return rt.new_null()
		}
		'configure_product_importer' {
			this.configure_product_importer()
			return rt.new_null()
		}
		'display_product_progress' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?array](if args.len > 3 { args[3] } else { rt.new_null() })
			this.display_product_progress(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'log_batch_results' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.log_batch_results(mut dispatch_arg_0)
			return rt.new_null()
		}
		'display_migration_summary' {
			this.display_migration_summary()
			return rt.new_null()
		}
		'log_session_time_metrics' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.log_session_time_metrics(mut dispatch_arg_0)
			return rt.new_null()
		}
		'display_feedback_survey' {
			this.display_feedback_survey()
			return rt.new_null()
		}
		'get_user_input' {
			return rt.new_string(this.get_user_input())
		}
		'display_saved_arguments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.display_saved_arguments(mut dispatch_arg_0)
			return rt.new_null()
		}
		'restore_original_arguments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.restore_original_arguments(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'credential_manager' { return this.credential_manager }
		'platform_registry' { return this.platform_registry }
		'session' { return this.session }
		'parsed_args' { return this.parsed_args }
		'fields_to_process' { return this.fields_to_process }
		'product_importer' { return this.product_importer }
		'tracker' { return this.tracker }
		'session_start_time' { return this.session_start_time }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'credential_manager' { this.credential_manager = val; return true }
		'platform_registry' { this.platform_registry = val; return true }
		'session' { this.session = val; return true }
		'parsed_args' { this.parsed_args = val; return true }
		'fields_to_process' { this.fields_to_process = val; return true }
		'product_importer' { this.product_importer = val; return true }
		'tracker' { this.tracker = val; return true }
		'session_start_time' { this.session_start_time = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
