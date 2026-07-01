import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option() string {
	return 'woocommerce_admin_import_stats'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.is_importing() bool {
	mut var_pending_jobs := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.queue() }(), 'search', [rt.create_array([rt.ArrayItem{ key: 'status', val: 'pending' }, rt.ArrayItem{ key: 'per_page', val: 1 }, rt.ArrayItem{ key: 'claimed', val: false }, rt.ArrayItem{ key: 'search', val: 'import' }, rt.ArrayItem{ key: 'group', val: // unsupported expression: Expr_StaticPropertyFetch }])])
	if !rt.is_true(var_pending_jobs) {
		mut var_in_progress := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.queue() }(), 'search', [rt.create_array([rt.ArrayItem{ key: 'status', val: 'in-progress' }, rt.ArrayItem{ key: 'per_page', val: 1 }, rt.ArrayItem{ key: 'search', val: 'import' }, rt.ArrayItem{ key: 'group', val: // unsupported expression: Expr_StaticPropertyFetch }])])
	}
	return !(!rt.is_true(var_pending_jobs)) || !(!rt.is_true(var_in_progress))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_batch_sizes() rt.PhpVal {
	return rt.call_function('array_merge', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_scheduler_batch_sizes() }(), rt.create_array([rt.ArrayItem{ key: 'delete', val: 10 }, rt.ArrayItem{ key: 'import', val: 25 }, rt.ArrayItem{ key: 'queue', val: 100 }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_scheduler_actions() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'import_batch_init', val: 'wc-admin_import_batch_init_' + (// unsupported expression: Expr_StaticPropertyFetch).str() }, rt.ArrayItem{ key: 'import_batch', val: 'wc-admin_import_batch_' + (// unsupported expression: Expr_StaticPropertyFetch).str() }, rt.ArrayItem{ key: 'delete_batch_init', val: 'wc-admin_delete_batch_init_' + (// unsupported expression: Expr_StaticPropertyFetch).str() }, rt.ArrayItem{ key: 'delete_batch', val: 'wc-admin_delete_batch_' + (// unsupported expression: Expr_StaticPropertyFetch).str() }, rt.ArrayItem{ key: 'import', val: 'wc-admin_import_' + (// unsupported expression: Expr_StaticPropertyFetch).str() }])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch_init(var_days rt.PhpVal, var_skip_existing rt.PhpVal)  {
	mut var_batch_size := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_batch_size(arg_0) }(rt.new_string('import'))
	mut var_items := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_items(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_int(1), var_days.dup(), var_skip_existing.dup())
	if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_items, 'total'))) {
		return rt.new_null()
	}
	mut var_num_batches := rt.call_function('ceil', [rt.div(rt.get_property(var_items, 'total'), var_batch_size)])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.queue_batches(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), var_num_batches.dup(), rt.new_string('import_batch'), rt.create_array([rt.ArrayItem{ key: none, val: var_days }, rt.ArrayItem{ key: none, val: var_skip_existing }]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch(var_batch_number rt.PhpVal, var_days rt.PhpVal, var_skip_existing rt.PhpVal)  {
	mut var_batch_size := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_batch_size(arg_0) }(rt.new_string('import'))
	mut var_properties := rt.create_array([rt.ArrayItem{ key: 'batch_number', val: var_batch_number }, rt.ArrayItem{ key: 'batch_size', val: var_batch_size }, rt.ArrayItem{ key: 'type', val: // unsupported expression: Expr_StaticPropertyFetch }])
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('import_job_start'), var_properties.dup()])
	mut var_page := if rt.is_true(var_skip_existing) { rt.new_int(1) } else { var_batch_number }
	mut var_items := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_items(arg_0, arg_1, arg_2, arg_3) }(var_batch_size.dup(), var_page.dup(), var_days.dup(), var_skip_existing.dup())
	{
		mut iter_1 := rt.get_property(var_items, 'ids').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.import(arg_0) }(var_id.dup())
		}
	}
	mut var_import_stats := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option(), rt.new_array()])
	mut var_imported_count := rt.add(rt.call_function('absint', [var_import_stats.array_get(// unsupported expression: Expr_StaticPropertyFetch).array_get('imported')]), rt.new_int(rt.get_property(var_items, 'ids').array_count()))
	var_import_stats.array_get_mut(// unsupported expression: Expr_StaticPropertyFetch).array_set('imported', var_imported_count.dup())
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option(), var_import_stats.dup()])
	var_properties.array_set('imported_count', var_imported_count.dup())
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('import_job_complete'), var_properties.dup()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.delete_batch_init()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_batch_size := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_batch_size(arg_0) }(rt.new_string('delete'))
	mut var_count := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_total_imported() }()
	if rt.is_true(rt.identical(rt.new_int(0), var_count)) {
		return rt.new_null()
	}
	mut var_num_batches := rt.call_function('ceil', [rt.div(var_count, var_batch_size)])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.queue_batches(arg_0, arg_1, arg_2) }(rt.new_int(1), var_num_batches.dup(), rt.new_string('delete_batch'))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.delete_batch()  {
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('delete_import_data_job_start'), rt.create_array([rt.ArrayItem{ key: 'type', val: // unsupported expression: Expr_StaticPropertyFetch }])])
	mut var_batch_size := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.get_batch_size(arg_0) }(rt.new_string('delete'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}; return temp.delete(arg_0) }(var_batch_size.dup())
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}; return temp.invalidate() }()
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('delete_import_data_job_complete'), rt.create_array([rt.ArrayItem{ key: 'type', val: // unsupported expression: Expr_StaticPropertyFetch }])])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_schedulers_importscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache() &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_importing' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.is_importing())
		}
		'get_batch_sizes' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_batch_sizes()
		}
		'get_scheduler_actions' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_scheduler_actions()
		}
		'import_batch_init' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch_init(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'import_batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'delete_batch_init' {
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.delete_batch_init()
			return rt.new_null()
		}
		'delete_batch' {
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.delete_batch()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_schedulers_importscheduler_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
