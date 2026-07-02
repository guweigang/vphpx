import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option() string {
	return 'woocommerce_admin_import_stats'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.is_importing() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_0 := iife_temp_0.queue()
	mut var_pending_jobs := rt.call_method(iife_result_0, 'search', [
		rt.create_array([rt.ArrayItem{ key: 'status', val: 'pending' },
			rt.ArrayItem{ key: 'per_page', val: 1 }, rt.ArrayItem{ key: 'claimed', val: false },
			rt.ArrayItem{ key: 'search', val: 'import' }, rt.ArrayItem{ key: 'group', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler',
				'group') }]),
	])
	if !rt.is_true(var_pending_jobs) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
		mut iife_result_1 := iife_temp_1.queue()
		mut var_in_progress := rt.call_method(iife_result_1, 'search', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 'in-progress' },
				rt.ArrayItem{ key: 'per_page', val: 1 }, rt.ArrayItem{ key: 'search', val: 'import' },
				rt.ArrayItem{ key: 'group', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler',
					'group') }]),
		])
	}
	return !(!rt.is_true(var_pending_jobs)) || !(!rt.is_true(var_in_progress))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_batch_sizes() rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_2 := iife_temp_2.get_scheduler_batch_sizes()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_3 := iife_temp_3.get_scheduler_batch_sizes()
	return rt.call_function('array_merge', [iife_result_2,
		rt.create_array([rt.ArrayItem{ key: 'delete', val: 10 },
			rt.ArrayItem{ key: 'import', val: 25 }, rt.ArrayItem{ key: 'queue', val: 100 }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_scheduler_actions() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: 'import_batch_init'
			val: 'wc-admin_import_batch_init_' +(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler', 'name')).str()
		},
		rt.ArrayItem{
			key: 'import_batch'
			val: 'wc-admin_import_batch_' +(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler', 'name')).str()
		},
		rt.ArrayItem{
			key: 'delete_batch_init'
			val: 'wc-admin_delete_batch_init_' +(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler', 'name')).str()
		},
		rt.ArrayItem{
			key: 'delete_batch'
			val: 'wc-admin_delete_batch_' +(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler', 'name')).str()
		},
		rt.ArrayItem{
			key: 'import'
			val: 'wc-admin_import_' +(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler', 'name')).str()
		},
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch_init(var_days rt.PhpVal, var_skip_existing rt.PhpVal) {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_4 := iife_temp_4.get_batch_size(rt.new_string('import'))
	mut var_batch_size := iife_result_4
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_5 := iife_temp_5.get_items(rt.new_int(1), rt.new_int(1), var_days.clone(),
		var_skip_existing.clone())
	mut var_items := iife_result_5
	if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_items, 'total'))) {
		return
	}
	mut var_num_batches := rt.call_function('ceil', [
		rt.div(rt.get_property(var_items, 'total'), var_batch_size),
	])
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_6 := iife_temp_6.queue_batches(rt.new_int(1), var_num_batches.clone(),
		rt.new_string('import_batch'), rt.create_array([
		rt.ArrayItem{ key: none, val: var_days },
		rt.ArrayItem{ key: none, val: var_skip_existing },
	]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch(var_batch_number rt.PhpVal, var_days rt.PhpVal, var_skip_existing rt.PhpVal) {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_7 := iife_temp_7.get_batch_size(rt.new_string('import'))
	mut var_batch_size := iife_result_7
	mut var_properties := rt.create_array([
		rt.ArrayItem{ key: 'batch_number', val: var_batch_number },
		rt.ArrayItem{ key: 'batch_size', val: var_batch_size },
		rt.ArrayItem{ key: 'type', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler',
			'name') },
	])
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('import_job_start'),
		var_properties.clone()])
	mut var_page := if rt.is_true(var_skip_existing) { rt.new_int(1) } else { var_batch_number }
	mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_8 := iife_temp_8.get_items(var_batch_size.clone(), var_page.clone(),
		var_days.clone(), var_skip_existing.clone())
	mut var_items := iife_result_8
	mut iter_1 := rt.get_property(var_items, 'ids').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_id := item_1.val
		mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
		mut iife_result_9 := iife_temp_9.import(var_id.clone())
	}
	mut var_import_stats := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option(),
		rt.new_array(),
	])
	mut var_imported_count := rt.add(rt.call_function('absint', [
		var_import_stats.array_get(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler',
			'name')).array_get(rt.new_string('imported')),
	]), rt.new_int(rt.get_property(var_items, 'ids').array_count()))
	var_import_stats.array_get_mut(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler',
		'name')).array_set('imported', var_imported_count.clone())
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option(),
		var_import_stats.clone(),
	])
	var_properties.array_set('imported_count', var_imported_count.clone())
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('import_job_complete'),
		var_properties.clone(),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.delete_batch_init() {
	mut var_wpdb := rt.new_null()
	mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_10 := iife_temp_10.get_batch_size(rt.new_string('delete'))
	mut var_batch_size := iife_result_10
	mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_11 := iife_temp_11.get_total_imported()
	mut var_count := iife_result_11
	if rt.is_true(rt.identical(rt.new_int(0), var_count)) {
		return
	}
	mut var_num_batches := rt.call_function('ceil', [rt.div(var_count, var_batch_size)])
	mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_12 := iife_temp_12.queue_batches(rt.new_int(1), var_num_batches.clone(),
		rt.new_string('delete_batch'))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.delete_batch() {
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('delete_import_data_job_start'),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler',
				'name') },
		]),
	])
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_13 := iife_temp_13.get_batch_size(rt.new_string('delete'))
	mut var_batch_size := iife_result_13
	mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{}
	mut iife_result_14 := iife_temp_14.delete(var_batch_size.clone())
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
	mut iife_result_15 := iife_temp_15.invalidate()
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('delete_import_data_job_complete'),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler',
				'name') },
		]),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_schedulers_importscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
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
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch_init(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'import_batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_batch(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
