import rt

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner {
	rt.PhpObjectBase
pub mut:
		data_regenerator rt.PhpVal = rt.new_null()
		lookup_data_store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) construct()  {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	this.data_regenerator = rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.class()])
	this.lookup_data_store = rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) enable(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('enable_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) enable_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_enabled')]))) {
		this.warning("The usage of the of the %W${var_table_name.to_string()}%n table is already enabled.")
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('force'))))))) {
		mut var_must_confirm := rt.new_bool(rt.new_bool(true))
		if rt.is_true(rt.call_method(this.lookup_data_store, 'regeneration_is_in_progress', []rt.PhpVal{})) {
			this.warning("The regeneration of the %W${var_table_name.to_string()}%n table is currently in process.")
		} else if rt.is_true(rt.call_method(this.lookup_data_store, 'regeneration_was_aborted', []rt.PhpVal{})) {
			this.warning("The regeneration of the %W${var_table_name.to_string()}%n table was aborted.")
		} else if rt.is_true(rt.identical(rt.new_int(0), this.get_lookup_table_info().array_get('total_rows'))) {
			this.warning("The %W${var_table_name.to_string()}%n table is empty.")
		} else {
			var_must_confirm = rt.new_bool(rt.new_bool(false))
		}
		if rt.is_true(var_must_confirm) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.confirm(arg_0) }(rt.new_string('Are you sure that you want to enable the table usage?'))
		}
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_enabled'), rt.new_string('yes')])
	var_table_name = rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	this.success("The usage of the %W${var_table_name.to_string()}%n table for product attribute lookup has been enabled.")
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) disable(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('disable_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) disable_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
		this.warning("The usage of the of the %W${var_table_name.to_string()}%n table is already disabled.")
		return rt.new_null()
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_enabled'), rt.new_string('no')])
	var_table_name = rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	this.success("The usage of the %W${var_table_name.to_string()}%n table for product attribute lookup has been disabled.")
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) regenerate_for_product(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('regenerate_for_product_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) regenerate_for_product_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	mut var_product_id := rt.call_function('current', [var_args])
	rt.call_method(this.data_regenerator, 'check_can_do_lookup_table_regeneration', [var_product_id.dup()])
	mut var_use_db_optimization := rt.new_bool(rt.new_bool(!(rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('disable-db-optimization')))))))
	this.check_can_use_db_optimization((var_use_db_optimization).to_bool())
	mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
	rt.call_method(this.lookup_data_store, 'create_data_for_product', [var_product_id.dup(), var_use_db_optimization.dup()])
	if rt.is_true(rt.call_method(this.lookup_data_store, 'get_last_create_operation_failed', []rt.PhpVal{})) {
		this.error('Lookup data regeneration failed.\nSee the WooCommerce logs (source is %9palt-updates%n) for details.')
	} else {
		mut var_total_time := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time)
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.call_function('sprintf', [rt.new_string('Attributes lookup data for product %d regenerated in %f seconds.'), var_product_id.dup(), var_total_time.dup()]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) check_can_use_db_optimization(use_db_optimization bool)  {
	mut use_db_optimization_mutated := use_db_optimization
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(use_db_optimization_mutated)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.lookup_data_store, 'can_use_optimized_db_access', []rt.PhpVal{}))))))) {
		this.warning('Optimized database access can\'t be used (products aren\'t stored as custom post types).')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) info(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('info_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) info_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_enabled := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_enabled')]))
	mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	mut var_info := this.get_lookup_table_info()
	this.log("Table name: %W${var_table_name.to_string()}%n")
	this.log('Table usage is ' + if rt.is_true(var_enabled) { '%Genabled%n' } else { '%Ydisabled%n' })
	this.log(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('The table contains %C'), var_info.array_get('total_rows')), rt.new_string('%n rows corresponding to %G')), var_info.array_get('products_count')), rt.new_string('%n products.')))
	if rt.is_true(rt.greater(var_info.array_get('total_rows'), rt.new_int(0))) {
		mut var_highest_product_id_in_table := rt.call_method(var_wpdb, 'get_var', ['select max(product_or_parent_id) from ' + (var_table_name).str()])
		this.log("The highest product id in the table is %B${var_highest_product_id_in_table.to_string()}%n.")
	}
	if rt.is_true(rt.call_method(this.lookup_data_store, 'regeneration_is_in_progress', []rt.PhpVal{})) {
		mut var_max_product_id_to_process := rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_last_product_id_to_process'), rt.new_string('???')])
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.new_string(''))
		this.warning('Full regeneration of the table is currently %Gin progress.%n')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_regenerator, 'has_scheduled_action_for_regeneration_step', []rt.PhpVal{}))))) {
			this.log('However, there are %9NO%n actions scheduled to run the regeneration steps (a %9wp cli palt regenerate%n command was aborted?).')
		}
		this.log("The last product id that will be processed is %Y${var_max_product_id_to_process.to_string()}%n.")
		this.log('\nRun %9wp cli palt abort_regeneration%n to abort the regeneration process,')
		this.log('then you\'ll be able to run %9wp cli palt resume_regeneration%n to resume the regeneration process,')
	} else if rt.is_true(rt.call_method(this.lookup_data_store, 'regeneration_was_aborted', []rt.PhpVal{})) {
		var_max_product_id_to_process = rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_last_product_id_to_process'), rt.new_string('???')])
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.new_string(''))
		this.warning("Full regeneration of the table has been %Raborted.%n\nThe last product id that will be processed is %Y${var_max_product_id_to_process.to_string()}%n.")
		this.log('\nRun %9wp cli palt resume_regeneration%n to resume the regeneration process.')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) abort_regeneration(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('abort_regeneration_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) abort_regeneration_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	rt.call_method(this.data_regenerator, 'abort_regeneration', [rt.new_bool(false)])
	mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	this.success("The regeneration of the data in the %W${var_table_name.to_string()}%n table has been aborted.")
	if rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('cleanup')))) {
		this.cleanup_regeneration_progress(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](rt.new_array()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](rt.new_array()))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) resume_regeneration(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('resume_regeneration_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) resume_regeneration_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	rt.call_method(this.data_regenerator, 'resume_regeneration', [rt.new_bool(false)])
	mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	this.success("The regeneration of the data in the %W${var_table_name.to_string()}%n table has been resumed.")
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) cleanup_regeneration_progress(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('cleanup_regeneration_progress_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) cleanup_regeneration_progress_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	rt.call_method(this.data_regenerator, 'finalize_regeneration', [rt.new_bool(false)])
	mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	this.success("The temporary data used for regeneration of the data in the %W${var_table_name.to_string()}%n table has been deleted.")
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) initiate_regeneration(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('initiate_regeneration_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) initiate_regeneration_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array)  {
	rt.call_method(this.data_regenerator, 'check_can_do_lookup_table_regeneration', []rt.PhpVal{})
	mut var_info := this.get_lookup_table_info()
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_info.array_get('total_rows'), rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('force'))))))))) {
		mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
		this.warning(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('The %W'), var_table_name), rt.new_string('%n table contains %C')), var_info.array_get('total_rows')), rt.new_string('%n rows corresponding to %G')), var_info.array_get('products_count')), rt.new_string('%n products.')))
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.confirm(arg_0) }(rt.new_string('Initiating the regeneration will first delete the data. Are you sure?'))
	}
	rt.call_method(this.data_regenerator, 'initiate_regeneration', []rt.PhpVal{})
	var_table_name = rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	this.log("%GSuccess:%n The regeneration of the data in the %W${var_table_name.to_string()}%n table has been initiated.")
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) regenerate(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return this.invoke('regenerate_core', mut var_args, mut var_assoc_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) regenerate_core(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := rt.call_method(this.lookup_data_store, 'get_lookup_table_name', []rt.PhpVal{})
	mut var_batch_size := if !(var_assoc_args.array_get('batch-size')).is_null() { var_assoc_args.array_get('batch-size') } else { Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.products_per_generation_step() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_batch_size.dup().is_long() || var_batch_size.dup().is_double()))))) || rt.is_true(rt.less(var_batch_size, rt.new_int(1))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('batch_size must be a number bigger than 0'))))
	}
	mut var_was_enabled := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_enabled')]))
	mut var_products_count := rt.call_function('wp_count_posts', [rt.new_string('product')])
	var_products_count = rt.new_int(rt.get_property(var_products_count, 'publish').to_i64() + rt.get_property(var_products_count, 'pending').to_i64() + rt.get_property(var_products_count, 'draft').to_i64())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.lookup_data_store, 'regeneration_is_in_progress', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('from-scratch')))))) {
		mut var_info := this.get_lookup_table_info()
		if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_info.array_get('total_rows'), rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('force'))))))))) {
			this.warning(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('The %W'), var_table_name), rt.new_string('%n table contains %C')), var_info.array_get('total_rows')), rt.new_string('%n rows corresponding to %G')), var_info.array_get('products_count')), rt.new_string('%n products.')))
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.confirm(arg_0) }(rt.new_string('Triggering the regeneration will first delete the data. Are you sure?'))
		}
		rt.call_method(this.data_regenerator, 'finalize_regeneration', [rt.new_bool(false)])
		mut var_last_product_id := rt.call_method(this.data_regenerator, 'initiate_regeneration', [rt.new_bool(false)])
		if rt.is_true(rt.identical(rt.new_int(0), var_last_product_id)) {
			rt.call_method(this.data_regenerator, 'finalize_regeneration', [var_was_enabled.dup()])
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.new_string('No products exist in the database, the table is left empty.'))
			return 0
		}
		mut var_processed_count := rt.new_int(rt.new_int(0))
	} else {
		var_last_product_id = 
		if rt.is_true() {
		}
		
	}
	
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) get_lookup_table_info() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) invoke(method_name string, mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_assoc_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) log(text string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) warning(text string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) success(text string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) error(text string)  {
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productattributeslookup_clirunner() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner{
		PhpObjectBase: rt.PhpObjectBase{}
		data_regenerator: rt.new_null()
		lookup_data_store: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_exception() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'enable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.enable(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'enable_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.enable_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'disable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.disable(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'disable_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.disable_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'regenerate_for_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.regenerate_for_product(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'regenerate_for_product_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.regenerate_for_product_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'check_can_use_db_optimization' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.check_can_use_db_optimization(dispatch_arg_0)
			return rt.new_null()
		}
		'info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.info(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'info_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.info_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'abort_regeneration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.abort_regeneration(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'abort_regeneration_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.abort_regeneration_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'resume_regeneration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.resume_regeneration(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'resume_regeneration_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.resume_regeneration_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'cleanup_regeneration_progress' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.cleanup_regeneration_progress(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'cleanup_regeneration_progress_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.cleanup_regeneration_progress_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'initiate_regeneration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.initiate_regeneration(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'initiate_regeneration_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.initiate_regeneration_core(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'regenerate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.regenerate(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'regenerate_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_int(this.regenerate_core(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_lookup_table_info' {
			return this.get_lookup_table_info()
		}
		'invoke' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.invoke(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'log' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.log(dispatch_arg_0)
			return rt.new_null()
		}
		'warning' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.warning(dispatch_arg_0)
			return rt.new_null()
		}
		'success' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.success(dispatch_arg_0)
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.error(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data_regenerator' { return this.data_regenerator }
		'lookup_data_store' { return this.lookup_data_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_CLIRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data_regenerator' { this.data_regenerator = val; return true }
		'lookup_data_store' { this.lookup_data_store = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productattributeslookup_clirunner_php() {
}
