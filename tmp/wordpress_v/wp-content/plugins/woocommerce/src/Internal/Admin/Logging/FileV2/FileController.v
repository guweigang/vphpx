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
	mut var_file_size_limit := rt.call_function('apply_filters', [rt.new_string('woocommerce_log_file_size_limit'), var_default.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_file_size_limit.dup().is_long()))))) || rt.is_true(rt.less(var_file_size_limit, rt.new_int(1))))) {
		return (var_default).to_i64()
	}
	return (var_file_size_limit).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) write_to_file(source string, text string, mut var_time Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int) bool {
	mut source_mutated := source
	mut var_time_mutated := var_time
	if rt.is_true(rt.new_bool(var_time_mutated.dup().is_null())) {
		var_time_mutated = rt.call_function('time', []rt.PhpVal{})
	}
	mut var_file_id := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}; return temp.generate_file_id(arg_0, arg_1, arg_2) }(rt.new_string(source_mutated), rt.new_null(), rt.new_object('Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int', []string{}, var_time_mutated))
	mut var_file := this.get_file_by_id((var_file_id).str())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_file, 'Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File'))) && rt.is_true(rt.greater_equal(rt.call_method(var_file, 'get_file_size', []rt.PhpVal{}), this.get_file_size_limit())))) {
		mut var_rotated := rt.new_bool(this.rotate_file(rt.call_method(var_file, 'get_file_id', []rt.PhpVal{})))
		if rt.is_true(var_rotated) {
			var_file = rt.new_null()
		} else {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_file, 'Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File')))))) {
		mut var_new_path := rt.new_string((fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}; return temp.get_log_directory() }()).str() + this.generate_filename(source_mutated, var_time_mutated))
		var_file = create_automattic_woocommerce_internal_admin_logging_filev2_file(var_new_path.dup())
	}
	return (rt.call_method(var_file, 'write', [rt.new_string(text)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) generate_filename(source string, time i64) string {
	mut source_mutated := source
	mut time_mutated := time
	mut var_file_id := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}; return temp.generate_file_id(arg_0, arg_1, arg_2) }(rt.new_string(source_mutated), rt.new_null(), rt.new_int(time_mutated))
	mut var_hash := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}; return temp.generate_hash(arg_0) }(var_file_id.dup())
	return "${var_file_id.to_string()}-${var_hash.to_string()}.log"
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) rotate_file(var_file_id rt.PhpVal) bool {
	mut var_file_id_mutated := var_file_id
	mut var_rotations := this.get_file_rotations((var_file_id_mutated).str())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_rotations.dup()])) || !(var_rotations.array_isset(rt.new_string('current'))))) {
		return false
	}
	mut var_max_rotation_marker := rt.sub(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.max_file_rotations(), rt.new_int(1))
	var_rotations.array_unset(var_max_rotation_marker)
	mut var_results := rt.new_array()
	{
		mut var_i := var_max_rotation_marker.dup()
		for {
			if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break }
			if var_rotations.array_isset(var_i) {
				var_results.array_push(rt.call_method(var_rotations.array_get(var_i), 'rotate', []rt.PhpVal{}))
			}
			rt.post_dec(var_i)
		}
	}
	var_results.array_push(rt.call_method(var_rotations.array_get('current'), 'rotate', []rt.PhpVal{}))
	return !(rt.is_true(rt.call_function('in_array', [rt.new_bool(false), var_results.dup(), rt.new_bool(true)])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_files(mut var_args Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array, count_only bool) i64 {
	mut var_file := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.defaults_get_files()])
	mut var_pattern := rt.new_string((var_args_mutated.array_get('source')).str() + '*.log')
	mut var_paths := rt.call_function('glob', [rt.concat(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}; return temp.get_log_directory() }(), var_pattern)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_paths)) {
		return (create_wp_error(rt.new_string('wc_log_directory_error'), rt.call_function('__', [rt.new_string('Could not access the log file directory.'), rt.new_string('woocommerce')]))).to_i64()
	}
	mut var_files := this.convert_paths_to_objects(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](var_paths))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_args_mutated.array_get('date_filter')) && rt.is_true(var_args_mutated.array_get('date_start')))) && rt.is_true(var_args_mutated.array_get('date_end')))) {
		mut switch_val_1 := var_args_mutated.array_get('date_filter')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('created'))) {
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.greater_equal(rt.call_method(var_file, 'get_created_timestamp', []rt.PhpVal{}), var_args_mutated.array_get('date_start'))) && rt.is_true(rt.less_equal(rt.call_method(var_file, 'get_created_timestamp', []rt.PhpVal{}), var_args_mutated.array_get('date_end'))))
	}
			var_files = rt.call_function('array_filter', [var_files.dup(), rt.new_closure(closure_1_fn)])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('modified'))) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.greater_equal(rt.call_method(var_file, 'get_modified_timestamp', []rt.PhpVal{}), var_args_mutated.array_get('date_start'))) && rt.is_true(rt.less_equal(rt.call_method(var_file, 'get_modified_timestamp', []rt.PhpVal{}), var_args_mutated.array_get('date_end'))))
	}
			var_files = rt.call_function('array_filter', [var_files.dup(), rt.new_closure(closure_2_fn)])
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(count_only))) {
		return var_files.dup().array_count()
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_sort_sets := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_order_sets := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_comparison := rt.new_int(rt.new_int(0))
	for !(!rt.is_true(var_sort_sets)) {
		mut var_set := rt.call_function('array_shift', [var_sort_sets.dup()])
		mut var_order := rt.call_function('array_shift', [var_order_sets.dup()])
		if rt.is_true(rt.identical(rt.new_string('desc'), var_order)) {
			var_comparison = // unsupported expression: Expr_BinaryOp_Spaceship
		} else {
			var_comparison = // unsupported expression: Expr_BinaryOp_Spaceship
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			break
		}
	}
	return (var_comparison).to_i64()
	}
	mut var_multi_sorter := rt.new_closure(closure_3_fn)
	mut switch_val_2 := var_args_mutated.array_get('orderby')
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('created'))) {
		closure_4_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_created_timestamp', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_created_timestamp', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }]) }])
	mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get('order') }, rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'asc' }])
	return (rt.call_callable(var_multi_sorter, [var_sort_sets.dup(), var_order_sets.dup()])).to_i64()
	}
		mut var_sort_callback := rt.new_closure(closure_4_fn)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('modified'))) {
		closure_5_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_modified_timestamp', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_modified_timestamp', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }]) }])
	mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get('order') }, rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'asc' }])
	return (rt.call_callable(var_multi_sorter, [var_sort_sets.dup(), var_order_sets.dup()])).to_i64()
	}
		var_sort_callback = rt.new_closure(closure_5_fn)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('source'))) {
		closure_6_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_created_timestamp', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_created_timestamp', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }]) }])
	mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get('order') }, rt.ArrayItem{ key: none, val: 'desc' }, rt.ArrayItem{ key: none, val: 'asc' }])
	return (rt.call_callable(var_multi_sorter, [var_sort_sets.dup(), var_order_sets.dup()])).to_i64()
	}
		var_sort_callback = rt.new_closure(closure_6_fn)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('size'))) {
		closure_7_fn := fn [var_args, var_multi_sorter] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_sort_sets := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_file_size', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_file_size', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_a, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_b, 'get_source', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_a, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }, rt.ArrayItem{ key: none, val: rt.is_true(rt.call_method(var_b, 'get_rotation', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_UnaryMinus) }]) }])
	mut var_order_sets := rt.create_array([rt.ArrayItem{ key: none, val: var_args_mutated.array_get('order') }, rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'asc' }])
	return (rt.call_callable(var_multi_sorter, [var_sort_sets.dup(), var_order_sets.dup()])).to_i64()
	}
		var_sort_callback = rt.new_closure(closure_7_fn)
	}
	rt.call_function('usort', [var_files.dup(), var_sort_callback.dup()])
	return (rt.call_function('array_slice', [var_files.dup(), var_args_mutated.array_get('offset'), var_args_mutated.array_get('per_page')])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_files_by_id(mut var_file_ids Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) rt.PhpVal {
	mut var_log_directory := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{}; return temp.get_log_directory() }()
	mut var_paths := rt.new_array()
	{
		mut iter_1 := var_file_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_file_id := item_1.val
			mut var_glob := rt.call_function('glob', [(var_log_directory).str() + (var_file_id).str() + '-*.log'])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_glob)))) {
				var_glob = rt.call_function('glob', [(var_log_directory).str() + (var_file_id).str() + '.log'])
			}
			if rt.is_true(rt.new_bool(var_glob.dup().is_array())) {
				var_paths = rt.call_function('array_merge', [var_paths.dup(), var_glob.dup()])
			}
		}
	}
	mut var_files := this.convert_paths_to_objects(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](rt.call_function('array_unique', [var_paths.dup()])))
	return var_files.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_file_by_id(file_id string) rt.PhpVal {
	mut file_id_mutated := file_id
	mut var_result := this.get_files_by_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array](rt.create_array([rt.ArrayItem{ key: none, val: file_id_mutated }])))
	if var_result.dup().array_count() < 1 {
		return create_wp_error(rt.new_string('wc_log_file_error'), rt.call_function('esc_html__', [rt.new_string('This file does not exist.'), rt.new_string('woocommerce')]))
	}
	if var_result.dup().array_count() > 1 {
		return create_wp_error(rt.new_string('wc_log_file_error'), rt.call_function('esc_html__', [rt.new_string('Multiple files match this ID.'), rt.new_string('woocommerce')]))
	}
	return rt.call_function('reset', [var_result.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_file_rotations(file_id string) rt.PhpVal {
	mut file_id_mutated := file_id
	mut var_file := this.get_file_by_id(file_id_mutated)
	if rt.is_true(rt.call_function('is_wp_error', [var_file.dup()])) {
		return var_file.dup()
	}
	mut var_current := rt.new_array()
	mut var_rotations := rt.new_array()
	mut var_source := rt.call_method(var_file, 'get_source', []rt.PhpVal{})
	mut var_created := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.call_method(var_file, 'has_standard_filename', []rt.PhpVal{})) {
		var_created = rt.call_method(var_file, 'get_created_timestamp', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.call_method(var_file, 'get_rotation', []rt.PhpVal{}).is_null())) {
		var_current.array_set('current', var_file.dup())
	} else {
		mut var_current_file_id := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{}; return temp.generate_file_id(arg_0, arg_1, arg_2) }(var_source.dup(), rt.new_null(), var_created.dup())
		mut var_result := this.get_file_by_id((var_current_file_id).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))) {
			var_current.array_set('current', var_result.dup())
		}
	}
	mut var_rotations_pattern := rt.call_function('sprintf', [rt.new_string('.[%s]'), rt.call_function('implode', [rt.new_string(''), rt.call_function('range', [rt.new_int(0), rt.sub(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.max_file_rotations(), rt.new_int(1))])])])
	mut var_created_pattern := rt.new_string(if rt.is_true(var_created) { '-' + (rt.call_function('gmdate', [, .dup()])).str() + '-' } else { rt.new_string('') })
	mut var_rotation_pattern := rt.new_string( + ().str() + (var_created_pattern).str() + '*.log')
	mut var_rotation_paths := rt.call_function('glob', [var_rotation_pattern.dup()])
	mut var_rotation_files := this.convert_paths_to_objects(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array]())
	{
		mut iter_1 := var_rotation_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rotation_file := item_1.val
			if rt.is_true() {
			}
		}
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) convert_paths_to_objects(mut var_paths Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) rt.PhpVal {
	mut var_paths_mutated := var_paths
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_file_sources() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) delete_files(mut var_file_ids Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) i64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) export_single_file(var_file_id rt.PhpVal) rt.PhpVal {
	mut var_file_id_mutated := var_file_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) export_multiple_files(mut var_file_ids Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array) rt.PhpVal {
	mut var_file := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) search_within_files(search string, mut var_args Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array, mut var_file_args Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_array, count_only bool) i64 {
	mut search_mutated := search
	mut var_args_mutated := var_args
	mut var_file_args_mutated := var_file_args
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) get_log_directory_size() i64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController) invalidate_cache() bool {
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

fn create_automattic_woocommerce_internal_admin_logging_filev2_filecontroller() &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_file() &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_logging_settings() &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_admin_logging_filev2_filecontroller_php() {
	// unsupported statement: Stmt_Declare
}
