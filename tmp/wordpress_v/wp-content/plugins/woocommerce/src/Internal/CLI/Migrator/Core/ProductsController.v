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

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) init(mut var_credential_manager Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_CredentialManager, mut var_platform_registry Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_PlatformRegistry, mut var_product_importer Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_WooCommerceProductImporter, mut var_tracker Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker)  {
	this.credential_manager = var_credential_manager.dup()
	this.platform_registry = var_platform_registry.dup()
	this.product_importer = var_product_importer.dup()
	this.tracker = var_tracker.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) migrate_products(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, platform string)  {
	mut platform_mutated := platform
	this.parsed_args = this.parse_and_validate_args(mut var_assoc_args, platform_mutated)
	if !rt.is_true(this.parsed_args) {
		return rt.new_null()
	}
	this.session_start_time = rt.call_function('time', []rt.PhpVal{})
	if rt.is_true(this.parsed_args.array_get('dry_run')) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.colorize(arg_0) }(rt.new_string('%Y--- DRY RUN MODE ENABLED ---%n')))
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.new_string('No products will be created or modified. This is a simulation only.'))
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.new_string(''))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get('dry_run'))))) {
		this.session = this.manage_session_lifecycle(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](this.parsed_args))
		if rt.is_true(rt.new_bool(!(rt.is_true(this.session)))) {
			return rt.new_null()
		}
		rt.call_function('do_action', [rt.new_string('wc_migrator_session_started'), this.parsed_args.array_get('platform'), rt.create_array([rt.ArrayItem{ key: 'session_id', val: rt.call_method(this.session, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'filters', val: this.parsed_args.array_get('filters') }, rt.ArrayItem{ key: 'fields', val: this.fields_to_process }, rt.ArrayItem{ key: 'is_dry_run', val: this.parsed_args.array_get('dry_run') }, rt.ArrayItem{ key: 'resume', val: this.parsed_args.array_get('resume') }])])
	}
	mut var_fetcher := rt.call_method(this.platform_registry, 'get_fetcher', [this.parsed_args.array_get('platform')])
	mut var_mapper := rt.call_method(this.platform_registry, 'get_mapper', [this.parsed_args.array_get('platform'), rt.create_array([rt.ArrayItem{ key: 'fields', val: this.fields_to_process }])])
	mut var_total_count := rt.call_method(var_fetcher, 'fetch_total_count', [this.parsed_args.array_get('filters')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get('dry_run'))))) {
		mut var_existing_total := rt.call_method(this.session, 'count_all_total_entities', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.new_int(0), var_total_count)) && rt.is_true(rt.identical(rt.new_int(0), var_existing_total)))) {
			rt.call_method(this.session, 'bump_total_number_of_entities', [rt.create_array([rt.ArrayItem{ key: 'post', val: var_total_count }])])
		}
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.line(arg_0) }(rt.new_string("Total entities found: ${var_total_count.to_string()}"))
	mut var_progress_label := rt.new_string(if rt.is_true(this.parsed_args.array_get('dry_run')) { 'Simulating Products from ' + (rt.call_function('ucfirst', [this.parsed_args.array_get('platform')])).str() } else { 'Importing Products from ' + (rt.call_function('ucfirst', [this.parsed_args.array_get('platform')])).str() })
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [var_progress_label.dup(), var_total_count.dup()])
	mut var_initial_tick := rt.call_function('max', [rt.new_int(1), // unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get('dry_run'))))) {
		mut var_already_imported := rt.call_method(this.session, 'count_all_imported_entities', []rt.PhpVal{})
		if rt.is_true(rt.greater(var_already_imported, rt.new_int(0))) {
			rt.call_method(var_progress, 'tick', [var_already_imported.dup()])
		} else {
			rt.call_method(var_progress, 'tick', [var_initial_tick.dup()])
		}
	} else {
		rt.call_method(var_progress, 'tick', [var_initial_tick.dup()])
	}
	this.configure_product_importer()
	this.execute_migration_loop(var_fetcher.dup(), var_mapper.dup(), var_progress.dup())
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	this.display_migration_summary()
	this.display_feedback_survey()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get('dry_run'))))) {
		mut var_final_stats := rt.create_array([rt.ArrayItem{ key: 'total_found', val: var_total_count }, rt.ArrayItem{ key: 'total_imported', val: rt.call_method(this.session, 'count_all_imported_entities', []rt.PhpVal{}) }])
		rt.call_function('do_action', [rt.new_string('wc_migrator_session_completed'), this.parsed_args.array_get('platform'), var_final_stats.dup()])
		this.log_session_time_metrics(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_final_stats))
	}
	if rt.is_true(this.parsed_args.array_get('dry_run')) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string('Dry-run completed successfully. No products were actually created or modified.'))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.new_string('Migration completed successfully.'))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) execute_migration_loop(var_fetcher rt.PhpVal, var_mapper rt.PhpVal, var_progress rt.PhpVal)  {
	mut var_fetcher_mutated := var_fetcher
	mut var_mapper_mutated := var_mapper
	mut var_progress_mutated := var_progress
	mut var_limit_remaining := this.parsed_args.array_get('limit')
	mut var_session_cursor := if rt.is_true(this.parsed_args.array_get('dry_run')) { rt.new_null() } else { rt.call_method(this.session, 'get_reentrancy_cursor', []rt.PhpVal{}) }
	mut var_after_cursor := if !(!rt.is_true(var_session_cursor)) { var_session_cursor } else { rt.new_null() }
	mut var_has_next_page := rt.new_bool(rt.new_bool(true))
	mut var_total_processed_in_session := rt.new_int(rt.new_int(0))
	for {
		mut var_batch_limit := rt.call_function('min', [this.parsed_args.array_get('batch_size'), var_limit_remaining.dup()])
		if rt.is_true(rt.less_equal(var_batch_limit, rt.new_int(0))) {
			break
		}
		mut var_batch_args := rt.create_array([rt.ArrayItem{ key: 'limit', val: var_batch_limit }, rt.ArrayItem{ key: 'after_cursor', val: var_after_cursor }])
		if !(!rt.is_true(this.parsed_args.array_get('filters'))) {
			var_batch_args = rt.call_function('array_merge', [var_batch_args.dup(), this.parsed_args.array_get('filters')])
		}
		mut var_batch_data := rt.call_method(var_fetcher_mutated, 'fetch_batch', [var_batch_args.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.dup()
			rt.call_function('do_action', [rt.new_string('wc_migrator_error_occurred'), rt.new_string('fetch'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'batch_args', val: var_batch_args }, rt.ArrayItem{ key: 'platform', val: this.parsed_args.array_get('platform') }])])
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.new_string(rt.concat(rt.new_string('Error fetching batch: '), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))))
			break
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		if !rt.is_true(var_batch_data.array_get('items')) {
			break
		}
		mut var_processed_count := rt.new_int(this.process_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_batch_data.array_get('items')), var_mapper_mutated.dup()))
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get('dry_run'))))) {
			rt.call_method(this.session, 'bump_imported_entities_counts', [rt.create_array([rt.ArrayItem{ key: 'post', val: var_processed_count }])])
			var_after_cursor = var_batch_data.array_get('cursor')
			rt.call_method(this.session, 'set_reentrancy_cursor', [var_after_cursor.dup()])
		} else {
			var_after_cursor = var_batch_data.array_get('cursor')
		}
		// unsupported expression: Expr_AssignOp_Minus
		var_has_next_page = if !(var_batch_data.array_get('has_next_page')).is_null() { var_batch_data.array_get('has_next_page') } else { rt.new_bool(false) }
		rt.call_method(var_progress_mutated, 'tick', [var_processed_count.dup(), rt.call_function('sprintf', [rt.new_string('Processed %d products'), var_total_processed_in_session.dup()])])
		if !(rt.is_true(rt.new_bool(rt.is_true(var_has_next_page) && rt.is_true(rt.greater(var_limit_remaining, rt.new_int(0)))))) {
			break
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_has_next_page)))) && rt.is_true(rt.new_bool(!(rt.is_true(this.parsed_args.array_get('dry_run'))))))) {
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
	var_parsed.array_set('limit', if var_assoc_args.array_isset(rt.new_string('limit')) { rt.call_function('max', [rt.new_int(1), // unsupported expression: Expr_Cast_Int]) } else { rt.get_constant('PHP_INT_MAX') })
	var_parsed.array_set('batch_size', if var_assoc_args.array_isset(rt.new_string('batch-size')) { rt.call_function('max', [rt.new_int(1), rt.call_function('min', [rt.new_int(250), // unsupported expression: Expr_Cast_Int])]) } else { rt.new_int(20) })
	var_parsed.array_set('skip_existing', rt.new_bool(var_assoc_args.array_isset(rt.new_string('skip-existing'))))
	var_parsed.array_set('dry_run', rt.new_bool(var_assoc_args.array_isset(rt.new_string('dry-run'))))
	var_parsed.array_set('resume', rt.new_bool(var_assoc_args.array_isset(rt.new_string('resume'))))
	var_parsed.array_set('verbose', rt.new_bool(var_assoc_args.array_isset(rt.new_string('verbose'))))
	var_parsed.array_set('assign_default_category', rt.new_bool(var_assoc_args.array_isset(rt.new_string('assign-default-category'))))
	var_parsed.array_set('filters', this.parse_query_filters(mut var_assoc_args))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.credential_manager, 'has_credentials', [rt.new_string(platform_mutated).dup()]))))) {
		mut var_platform_display_name := rt.call_method(this.platform_registry, 'get_platform_display_name', [rt.new_string(platform_mutated).dup()])
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('sprintf', [rt.new_string('No credentials found for platform \'%s\'. Please run: wp wc migrate setup --platform=%s'), var_platform_display_name.dup(), rt.new_string(platform_mutated).dup()]))
		return rt.new_array()
	}
	return var_parsed.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) parse_field_selection(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_default_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'catalog_visibility' }, rt.ArrayItem{ key: none, val: 'categories' }, rt.ArrayItem{ key: none, val: 'tags' }, rt.ArrayItem{ key: none, val: 'price' }, rt.ArrayItem{ key: none, val: 'sku' }, rt.ArrayItem{ key: none, val: 'stock' }, rt.ArrayItem{ key: none, val: 'weight' }, rt.ArrayItem{ key: none, val: 'brand' }, rt.ArrayItem{ key: none, val: 'images' }, rt.ArrayItem{ key: none, val: 'attributes' }, rt.ArrayItem{ key: none, val: 'metafields' }])
	mut var_excluded_fields := rt.new_array()
	mut var_explicitly_selected := rt.new_bool(rt.new_bool(false))
	if var_assoc_args.array_isset(rt.new_string('fields')) {
		var_explicitly_selected = rt.new_bool(rt.new_bool(true))
		mut var_selected_fields := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [, ])])
		var_selected_fields = rt.call_function('array_filter', [.dup()])
		mut var_invalid_fields := 
		if !(!rt.is_true()) {
		}
		
	} else {
	}
	if .array_isset() {
	}
	if !rt.is_true() {
	}
	if rt.is_true() {
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) parse_query_filters(mut var_assoc_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) validate_date_filter(date_input string, filter_name string) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) manage_session_lifecycle(mut var_parsed_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) handle_existing_session(mut var_session Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession, mut var_parsed_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_session_mutated := var_session
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) create_new_session(mut var_parsed_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) process_batch(mut var_batch_items Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, var_mapper rt.PhpVal) i64 {
	mut var_mapper_mutated := var_mapper
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) simulate_import_batch(mut var_mapped_products Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) rt.PhpVal {
	mut var_mapped_products_mutated := var_mapped_products
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) simulate_stats_increment(stat_key string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) configure_product_importer()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_product_progress(current_index i64, total_count i64, product_name string, mut var_result Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_?array)  {
	mut total_count_mutated := total_count
	mut product_name_mutated := product_name
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) log_batch_results(mut var_batch_results Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_batch_results_mutated := var_batch_results
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_migration_summary()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) log_session_time_metrics(mut var_final_stats Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_final_stats_mutated := var_final_stats
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_feedback_survey()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) get_user_input() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) display_saved_arguments(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController) restore_original_arguments(mut var_original_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array)  {
	mut var_original_args_mutated := var_original_args
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_core_productscontroller() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_ProductsController {
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

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
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




pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_core_productscontroller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
