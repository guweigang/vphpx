import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.max_file_rotations() i64 {
	return 10
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.defaults_get_files() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'date_end', val: 0 }, rt.ArrayItem{ key: 'date_filter', val: '' }, rt.ArrayItem{ key: 'date_start', val: 0 }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'order', val: 'desc' }, rt.ArrayItem{ key: 'orderby', val: 'modified' }, rt.ArrayItem{ key: 'per_page', val: 20 }, rt.ArrayItem{ key: 'source', val: '' }])
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.defaults_search_within_files() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'per_page', val: 50 }])
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.search_max_files() i64 {
	return 100
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.search_max_results() i64 {
	return 200
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.cache_group() string {
	return 'log-files'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.search_cache_key() string {
	return 'logs_previous_search'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_file_size_limit() i64 {
	mut var_default := rt.mul(rt.new_int(5), rt.get_constant('MB_IN_BYTES'))
	mut var_file_size_limit := rt.call_function('apply_filters', [rt.new_string('woocommerce_log_file_size_limit'), var_default.clone()])
	if !(var_file_size_limit.clone().is_long()) || rt.is_true(rt.less(var_file_size_limit, rt.new_int(1))) {
		return (var_default).to_i64()
	}
	return (var_file_size_limit).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) write_to_file(source string, text string, mut var_time Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int) bool {
	mut source_mutated := source
	mut var_time_mutated := var_time
	if rt.is_true(rt.new_bool(var_time_mutated.is_null())) {
	var_time_mutated = rt.call_function('time', []rt.PhpVal{})
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}
	mut iife_result_0 := iife_temp_0.generate_file_id(rt.new_string(source_mutated), rt.new_null(), rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int', []string{}, var_time_mutated))
	mut var_file_id := iife_result_0
	mut var_file := this.get_file_by_id((var_file_id).str())
	if rt.is_true(rt.new_bool(rt.instance_of(var_file, 'Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File'))) && rt.is_true(rt.greater_equal(rt.call_method(var_file, 'get_file_size', []rt.PhpVal{}), this.get_file_size_limit())) {
		mut var_rotated := rt.new_bool(this.rotate_file(rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})))
		if rt.is_true(var_rotated) {
		var_file = rt.new_null()
		} else {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_file, 'Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File')))))) {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_1 := iife_temp_1.get_log_directory()
	mut var_new_path := rt.new_string((iife_result_1).str() + this.generate_filename(source_mutated, var_time_mutated))
	var_file = create_automattic_woocommerce_internal_admin_logging_filev2_file(var_new_path.clone())
	}
	return (rt.call_method(var_file, 'write', [rt.new_string(text)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) generate_filename(source string, time i64) string {
	mut source_mutated := source
	mut time_mutated := time
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}
	mut iife_result_2 := iife_temp_2.generate_file_id(rt.new_string(source_mutated), rt.new_null(), rt.new_int(time_mutated))
	mut var_file_id := iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}
	mut iife_result_3 := iife_temp_3.generate_hash(var_file_id.clone())
	mut var_hash := iife_result_3
	return "${var_file_id.to_string()}-${var_hash.to_string()}.log"
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) rotate_file(var_file_id rt.PhpVal) bool {
	mut var_file_id_mutated := var_file_id
	mut var_rotations := this.get_file_rotations((var_file_id_mutated).str())
	if rt.is_true(rt.call_function('is_wp_error', [var_rotations.clone()])) || !(var_rotations.array_isset(rt.new_string('current'))) {
		return false
	}
	mut var_max_rotation_marker := rt.sub(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.max_file_rotations(), rt.new_int(1))
	var_rotations.array_unset(var_max_rotation_marker)
	mut var_results := rt.new_array()
	mut var_i := var_max_rotation_marker.clone()
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break }
		if var_rotations.array_isset(var_i) {
			var_results.array_push(rt.call_method(var_rotations.array_get(var_i), 'rotate', []rt.PhpVal{}))
		}
		rt.post_dec(var_i)
	}
	var_results.array_push(rt.call_method(var_rotations.array_get(rt.new_string('current')), 'rotate', []rt.PhpVal{}))
	return !(rt.is_true(rt.call_function('in_array', [rt.new_bool(false), var_results.clone(), rt.new_bool(true)])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_files(mut var_args Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array, count_only bool) i64 {
	mut var_file := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated, Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.defaults_get_files()])
	mut var_pattern := rt.new_string((var_args_mutated.array_get(rt.new_string('source'))).str() + '*.log')
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_4 := iife_temp_4.get_log_directory()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_5 := iife_temp_5.get_log_directory()
	mut var_paths := rt.call_function('glob', [rt.new_string((iife_result_4).str() + (var_pattern).str())])
	if rt.is_true(rt.identical(rt.new_bool(false), var_paths)) {
		return (create_wp_error(rt.new_string('wc_log_directory_error'), rt.call_function('__', [rt.new_string('Could not access the log file directory.'), rt.new_string('woocommerce')]))).to_i64()
	}
	mut var_files := this.convert_paths_to_objects(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](var_paths))
	if rt.is_true(var_args_mutated.array_get(rt.new_string('date_filter'))) && rt.is_true(var_args_mutated.array_get(rt.new_string('date_start'))) && rt.is_true(var_args_mutated.array_get(rt.new_string('date_end'))) {
		mut switch_val_1 := var_args_mutated.array_get(rt.new_string('date_filter'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('created'))) {
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(rt.is_true(rt.greater_equal(rt.call_method(var_file, 'get_created_timestamp', []rt.PhpVal{}), var_args_mutated.array_get(rt.new_string('date_start')))) && rt.is_true(rt.less_equal(rt.call_method(var_file, 'get_created_timestamp', []rt.PhpVal{}), var_args_mutated.array_get(rt.new_string('date_end')))))
			}
		var_files = rt.call_function('array_filter', [var_files.clone(), rt.new_closure(closure_7_fn)])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('modified'))) {
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(rt.is_true(rt.greater_equal(rt.call_method(var_file, 'get_modified_timestamp', []rt.PhpVal{}), var_args_mutated.array_get(rt.new_string('date_start')))) && rt.is_true(rt.less_equal(rt.call_method(var_file, 'get_modified_timestamp', []rt.PhpVal{}), var_args_mutated.array_get(rt.new_string('date_end')))))
			}
		var_files = rt.call_function('array_filter', [var_files.clone(), rt.new_closure(closure_8_fn)])
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(count_only))) {
		return var_files.clone().array_count()
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sort_sets := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_order_sets := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_comparison := rt.new_int(0)
		for !(!rt.is_true(var_sort_sets)) {
			mut var_set := rt.call_function('array_shift', [var_sort_sets.clone()])
			mut var_order := rt.call_function('array_shift', [var_order_sets.clone()])
			if rt.is_true(rt.identical(rt.new_string('desc'), var_order)) {
			var_comparison = rt.new_null()
			} else {
			var_comparison = rt.new_null()
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_comparison)))) {
				break
			}
		}
		return (var_comparison).to_i64()
		}
	mut var_multi_sorter := rt.new_closure(closure_9_fn)
	mut switch_val_2 := var_args_mutated.array_get(rt.new_string('orderby'))
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('created'))) {
	closure_10_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_created_timestamp', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_created_timestamp', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }]) }])
		mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get(rt.new_string('order')) }, rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'asc' }])
		return (rt.call_callable(var_multi_sorter, [var_sort_sets.clone(), var_order_sets.clone()])).to_i64()
		}
	mut var_sort_callback := rt.new_closure(closure_10_fn)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('modified'))) {
	closure_11_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_modified_timestamp', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_modified_timestamp', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }]) }])
		mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get(rt.new_string('order')) }, rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'asc' }])
		return (rt.call_callable(var_multi_sorter, [var_sort_sets.clone(), var_order_sets.clone()])).to_i64()
		}
	var_sort_callback = rt.new_closure(closure_11_fn)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('source'))) {
	closure_12_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_created_timestamp', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_created_timestamp', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }]) }])
		mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get(rt.new_string('order')) }, rt.ArrayItem{ key: none, val: 'desc' }, rt.ArrayItem{ key: none, val: 'asc' }])
		return (rt.call_callable(var_multi_sorter, [var_sort_sets.clone(), var_order_sets.clone()])).to_i64()
		}
	var_sort_callback = rt.new_closure(closure_12_fn)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('size'))) {
	closure_13_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_file_size', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_file_size', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(-1) }]) }])
		mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get(rt.new_string('order')) }, rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'asc' }])
		return (rt.call_callable(var_multi_sorter, [var_sort_sets.clone(), var_order_sets.clone()])).to_i64()
		}
	var_sort_callback = rt.new_closure(closure_13_fn)
	}
	rt.call_function('usort', [var_files.clone(), var_sort_callback.clone()])
	return (rt.call_function('array_slice', [var_files.clone(), var_args_mutated.array_get(rt.new_string('offset')), var_args_mutated.array_get(rt.new_string('per_page'))])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_files_by_id(mut var_file_ids Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) rt.PhpVal {
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_13 := iife_temp_13.get_log_directory()
	mut var_log_directory := iife_result_13
	mut var_paths := rt.new_array()
	mut iter_1 := var_file_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_file_id := item_1.val
		mut var_glob := rt.call_function('glob', [rt.new_string((var_log_directory).str() + (var_file_id).str() + '-*.log')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_glob)))) {
		var_glob = rt.call_function('glob', [rt.new_string((var_log_directory).str() + (var_file_id).str() + '.log')])
		}
		if rt.is_true(rt.new_bool(var_glob.clone().is_array())) {
		var_paths = rt.call_function('array_merge', [var_paths.clone(), var_glob.clone()])
		}
	}
	mut var_files := this.convert_paths_to_objects(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](rt.call_function('array_unique', [var_paths.clone()])))
	return var_files.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_file_by_id(file_id string) rt.PhpVal {
	mut file_id_mutated := file_id
	mut var_result := this.get_files_by_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](rt.create_array([rt.ArrayItem{ key: none, val: file_id_mutated }])))
	if var_result.clone().array_count() < 1 {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc_log_file_error'), rt.call_function('esc_html__', [rt.new_string('This file does not exist.'), rt.new_string('woocommerce')])))
	}
	if var_result.clone().array_count() > 1 {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc_log_file_error'), rt.call_function('esc_html__', [rt.new_string('Multiple files match this ID.'), rt.new_string('woocommerce')])))
	}
	return rt.call_function('reset', [var_result.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_file_rotations(file_id string) rt.PhpVal {
	mut file_id_mutated := file_id
	mut var_file := this.get_file_by_id(file_id_mutated)
	if rt.is_true(rt.call_function('is_wp_error', [var_file.clone()])) {
		return var_file.clone()
	}
	mut var_current := rt.new_array()
	mut var_rotations := rt.new_array()
	mut var_source := rt.call_method(var_file, 'get_source', []rt.PhpVal{})
	mut var_created := rt.new_int(0)
	if rt.is_true(rt.call_method(var_file, 'has_standard_filename', []rt.PhpVal{})) {
	var_created = rt.call_method(var_file, 'get_created_timestamp', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.call_method(var_file, 'get_rotation', []rt.PhpVal{}).is_null())) {
		var_current.array_set('current', var_file.clone())
	} else {
		mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}
		mut iife_result_14 := iife_temp_14.generate_file_id(var_source.clone(), rt.new_null(), var_created.clone())
		mut var_current_file_id := iife_result_14
		mut var_result := this.get_file_by_id((var_current_file_id).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))))) {
			var_current.array_set('current', var_result.clone())
		}
	}
	mut var_rotations_pattern := rt.call_function('sprintf', [rt.new_string('.[%s]'), rt.call_function('implode', [rt.new_string(''), rt.call_function('range', [rt.new_int(0), rt.sub(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.max_file_rotations(), rt.new_int(1))])])])
	mut var_created_pattern := rt.new_string((if rt.is_true(var_created) { '-' + (rt.call_function('gmdate', [rt.new_string('Y-m-d'), var_created.clone()])).str() + '-' } else { '' }).str())
	mut iife_temp_15 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_15 := iife_temp_15.get_log_directory()
	mut var_rotation_pattern := rt.new_string((iife_result_15).str() + (var_source).str() + (var_rotations_pattern).str() + (var_created_pattern).str() + '*.log')
	mut var_rotation_paths := rt.call_function('glob', [var_rotation_pattern.clone()])
	mut var_rotation_files := this.convert_paths_to_objects(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](var_rotation_paths))
	mut iter_2 := var_rotation_files.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_rotation_file := item_2.val
		if rt.is_true(rt.call_method(var_rotation_file, 'is_readable', []rt.PhpVal{})) {
			var_rotations.array_set(rt.call_method(var_rotation_file, 'get_rotation', []rt.PhpVal{}), var_rotation_file.clone())
		}
	}
	rt.call_function('ksort', [var_rotations.clone()])
	return rt.call_function('array_merge', [var_current.clone(), var_rotations.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) convert_paths_to_objects(mut var_paths Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) rt.PhpVal {
	mut var_paths_mutated := var_paths
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_file := create_automattic_woocommerce_internal_admin_logging_filev2_file(var_path.clone())
		return if rt.is_true(rt.call_method(var_file, 'is_readable', []rt.PhpVal{})) { var_file } else { rt.new_null() }
		}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_file := create_automattic_woocommerce_internal_admin_logging_filev2_file(var_path.clone())
		return if rt.is_true(rt.call_method(var_file, 'is_readable', []rt.PhpVal{})) { var_file } else { rt.new_null() }
		}
	mut var_files := rt.call_function('array_map', [rt.new_closure(closure_17_fn), var_paths_mutated])
	return rt.call_function('array_filter', [var_files.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_file_sources() rt.PhpVal {
	mut iife_temp_18 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_18 := iife_temp_18.get_log_directory()
	mut iife_temp_19 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_19 := iife_temp_19.get_log_directory()
	mut var_paths := rt.call_function('glob', [rt.new_string((iife_result_18).str() + '*.log')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_paths)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc_log_directory_error'), rt.call_function('__', [rt.new_string('Could not access the log file directory.'), rt.new_string('woocommerce')])))
	}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_file := create_automattic_woocommerce_internal_admin_logging_filev2_file(var_path.clone())
		return if rt.is_true(rt.call_method(var_file, 'is_readable', []rt.PhpVal{})) { rt.call_method(var_file, 'get_source', []rt.PhpVal{}) } else { rt.new_null() }
		}
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_file := create_automattic_woocommerce_internal_admin_logging_filev2_file(var_path.clone())
		return if rt.is_true(rt.call_method(var_file, 'is_readable', []rt.PhpVal{})) { rt.call_method(var_file, 'get_source', []rt.PhpVal{}) } else { rt.new_null() }
		}
	mut var_all_sources := rt.call_function('array_map', [rt.new_closure(closure_21_fn), var_paths.clone()])
	return rt.call_function('array_unique', [rt.call_function('array_filter', [var_all_sources.clone()])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) delete_files(mut var_file_ids Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) i64 {
	mut var_deleted := rt.new_int(0)
	mut var_files := this.get_files_by_id(mut var_file_ids)
	mut iter_3 := var_files.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_file := item_3.val
		mut var_result := rt.call_method(var_file, 'delete', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_bool(true), var_result)) {
			rt.post_inc(var_deleted)
		}
	}
	if rt.is_true(rt.greater(var_deleted, rt.new_int(0))) {
		this.invalidate_cache()
	}
	return (var_deleted).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) export_single_file(var_file_id rt.PhpVal) rt.PhpVal {
	mut var_file_id_mutated := var_file_id
	mut var_file := this.get_file_by_id((var_file_id_mutated).str())
	if rt.is_true(rt.call_function('is_wp_error', [var_file.clone()])) {
		return var_file.clone()
	}
	mut var_file_name := rt.new_string((rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})).str() + '.log')
	mut var_exporter := create_automattic_woocommerce_internal_admin_logging_filev2_fileexporter(rt.call_method(var_file, 'get_path', []rt.PhpVal{}), var_file_name.clone())
	return var_exporter.emit_file()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) export_multiple_files(mut var_file_ids Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) rt.PhpVal {
	mut var_file := rt.new_null()
	mut var_files := this.get_files_by_id(mut var_file_ids)
	if var_files.clone().array_count() < 1 {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc_logs_invalid_file'), rt.call_function('__', [rt.new_string('Could not access the specified files.'), rt.new_string('woocommerce')])))
	}
	mut var_temp_dir := rt.call_function('get_temp_dir', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_temp_dir.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_writable', [var_temp_dir.clone()]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc_logs_invalid_directory'), rt.call_function('__', [rt.new_string('Could not write to the temp directory. Try downloading files one at a time instead.'), rt.new_string('woocommerce')])))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-pclzip.php', '4')
	mut var_path := rt.new_string((rt.call_function('trailingslashit', [var_temp_dir.clone()])).str() + 'woocommerce_logs_' + (rt.call_function('gmdate', [rt.new_string('Y-m-d_H-i-s')])).str() + '.zip')
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'get_path', []rt.PhpVal{})
		}
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_file, 'get_path', []rt.PhpVal{})
		}
	mut var_file_paths := rt.call_function('array_map', [rt.new_closure(closure_23_fn), var_files.clone()])
	mut var_archive := create_pclzip(var_path.clone())
	var_archive.create(var_file_paths.clone(), rt.get_constant('PCLZIP_OPT_REMOVE_ALL_PATH'))
	mut var_exporter := create_automattic_woocommerce_internal_admin_logging_filev2_fileexporter(var_path.clone())
	return var_exporter.emit_file()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) search_within_files(search string, mut var_args Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array, mut var_file_args Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array, count_only bool) i64 {
	mut search_mutated := search
	mut var_args_mutated := var_args
	mut var_file_args_mutated := var_file_args
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(search_mutated))) {
		return (if var_count_only { rt.new_int(0) } else { rt.new_array() }).to_i64()
	}
	search_mutated = (rt.call_function('esc_html', [rt.new_string(search_mutated).clone()])).str()
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated, Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.defaults_search_within_files()])
	var_file_args_mutated = rt.call_function('array_merge', [var_file_args_mutated, rt.create_array([rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'per_page', val: Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.search_max_files() }])])
	mut iife_temp_24 := Class_WC_Cache_Helper{}
	mut iife_result_24 := iife_temp_24.get_prefixed_key(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.search_cache_key(), Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.cache_group())
	mut var_cache_key := iife_result_24
	mut var_query := rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: none, val: search_mutated }, rt.ArrayItem{ key: none, val: var_args_mutated }, rt.ArrayItem{ key: none, val: var_file_args_mutated }])])
	mut var_cache := rt.call_function('wp_cache_get', [var_cache_key.clone()])
	mut var_is_cached := rt.new_bool(var_cache.array_isset(rt.new_string('query')) && var_cache.array_isset(rt.new_string('results')) && rt.is_true(rt.identical(var_query, var_cache.array_get(rt.new_string('query')))))
	if rt.is_true(rt.identical(rt.new_bool(true), var_is_cached)) {
	mut var_matched_lines := var_cache.array_get(rt.new_string('results'))
	} else {
		mut var_files := rt.new_int(this.get_files(mut var_file_args_mutated, false))
		if rt.is_true(rt.call_function('is_wp_error', [var_files.clone()])) {
			return (var_files).to_i64()
		}
		mut var_max_string_size := rt.mul(rt.new_int(5), rt.get_constant('KB_IN_BYTES'))
		var_matched_lines = rt.new_array()
		mut iter_4 := var_files.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_file := item_4.val
			mut var_stream := rt.call_method(var_file, 'get_stream', []rt.PhpVal{})
			mut var_line_number := rt.new_int(1)
			for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_stream.clone()]))))) {
				mut var_line := rt.call_function('fgets', [var_stream.clone(), var_max_string_size.clone()])
				if !(var_line.clone().is_string()) {
					continue
				}
				mut var_sanitized_line := rt.call_function('esc_html', [rt.new_string(var_line.clone().to_string().trim_space())])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_sanitized_line.clone(), rt.new_string(search_mutated).clone()]))))) {
					var_matched_lines.array_push(rt.create_array([rt.ArrayItem{ key: 'file_id', val: rt.call_method(var_file, 'get_file_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'line_number', val: var_line_number }, rt.ArrayItem{ key: 'line', val: var_sanitized_line }]))
				}
				if rt.is_true(rt.greater_equal(rt.new_int(var_matched_lines.clone().array_count()), Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.search_max_results())) {
					rt.call_method(var_file, 'close_stream', []rt.PhpVal{})
					break
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strstr', [var_line.clone(), rt.get_constant('PHP_EOL')]))))) {
					rt.post_inc(var_line_number)
				}
			}
			rt.call_method(var_file, 'close_stream', []rt.PhpVal{})
		}
		mut var_to_cache := rt.create_array([rt.ArrayItem{ key: 'query', val: var_query }, rt.ArrayItem{ key: 'results', val: var_matched_lines }])
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_to_cache.clone(), Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.cache_group(), rt.get_constant('DAY_IN_SECONDS')])
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(count_only))) {
		return var_matched_lines.clone().array_count()
	}
	return (rt.call_function('array_slice', [var_matched_lines.clone(), var_args_mutated.array_get(rt.new_string('offset')), var_args_mutated.array_get(rt.new_string('per_page'))])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_log_directory_size() i64 {
	mut var_bytes := rt.new_int(0)
	mut iife_temp_25 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_25 := iife_temp_25.get_log_directory(rt.new_bool(false))
	mut iife_temp_26 := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}
	mut iife_result_26 := iife_temp_26.get_log_directory(rt.new_bool(false))
	mut var_path := rt.call_function('realpath', [iife_result_25])
	if rt.is_true(rt.call_function('wp_is_writable', [var_path.clone()])) {
		mut var_iterator := create_automattic_woocommerce_internal_admin_logging_filev2_recursiveiteratoriterator(create_automattic_woocommerce_internal_admin_logging_filev2_recursivedirectoryiterator(var_path.clone(), Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FilesystemIterator.skip_dots()), Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveIteratorIterator.catch_get_child())
		mut iter_5 := var_iterator.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_file := item_5.val
			var_bytes = rt.add(var_bytes, rt.call_method(var_file, 'getSize', []rt.PhpVal{}))
		}
	}
	return (var_bytes).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) invalidate_cache() bool {
	mut iife_temp_27 := Class_WC_Cache_Helper{}
	mut iife_result_27 := iife_temp_27.invalidate_cache_group(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.cache_group())
	return (iife_result_27).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter {
	rt.PhpObjectBase
}

struct Class_PclZip {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveIteratorIterator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveDirectoryIterator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_filecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_file(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_settings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_fileexporter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pclzip(_args ...rt.PhpVal) &Class_PclZip {
	mut obj := &Class_PclZip{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_recursiveiteratoriterator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveIteratorIterator {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_recursivedirectoryiterator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveDirectoryIterator {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveDirectoryIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_file_size_limit' {
			return rt.new_int(this.get_file_size_limit())
		}
		'write_to_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.write_to_file(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'generate_filename' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.generate_filename(dispatch_arg_0, dispatch_arg_1))
		}
		'rotate_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.rotate_file(dispatch_arg_0))
		}
		'get_files' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.get_files(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_files_by_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_files_by_id(mut dispatch_arg_0)
		}
		'get_file_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_file_by_id(dispatch_arg_0)
		}
		'get_file_rotations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_file_rotations(dispatch_arg_0)
		}
		'convert_paths_to_objects' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.convert_paths_to_objects(mut dispatch_arg_0)
		}
		'get_file_sources' {
			return this.get_file_sources()
		}
		'delete_files' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.delete_files(mut dispatch_arg_0))
		}
		'export_single_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export_single_file(dispatch_arg_0)
		}
		'export_multiple_files' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.export_multiple_files(mut dispatch_arg_0)
		}
		'search_within_files' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.search_within_files(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3))
		}
		'get_log_directory_size' {
			return rt.new_int(this.get_log_directory_size())
		}
		'invalidate_cache' {
			return rt.new_bool(this.invalidate_cache())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_PclZip) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PclZip) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PclZip) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveIteratorIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveIteratorIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveIteratorIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveDirectoryIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveDirectoryIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_RecursiveDirectoryIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
