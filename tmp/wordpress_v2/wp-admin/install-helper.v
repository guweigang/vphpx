import rt

fn maybe_create_table(var_table_name rt.PhpVal, var_create_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut iter_1 := rt.call_method(var_wpdb, 'get_col', [rt.new_string('SHOW TABLES'), rt.new_int(0)]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_table_shadow := item_1.val
		if rt.is_true(rt.identical(var_table_shadow, var_table_name)) {
			return true
		}
	}
	rt.call_method(var_wpdb, 'query', [var_create_ddl.clone()])
	mut iter_2 := rt.call_method(var_wpdb, 'get_col', [rt.new_string('SHOW TABLES'), rt.new_int(0)]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_table_shadow := item_2.val
		if rt.is_true(rt.identical(var_table_shadow, var_table_name)) {
			return true
		}
	}
	return false
}

fn maybe_add_column(var_table_name rt.PhpVal, var_column_name rt.PhpVal, var_create_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_column := rt.new_null()
	mut iter_3 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_column_shadow := item_3.val
		if rt.is_true(rt.identical(var_column_shadow, var_column_name)) {
			return true
		}
	}
	rt.call_method(var_wpdb, 'query', [var_create_ddl.clone()])
	mut iter_4 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_column_shadow := item_4.val
		if rt.is_true(rt.identical(var_column_shadow, var_column_name)) {
			return true
		}
	}
	return false
}

fn maybe_drop_column(var_table_name rt.PhpVal, var_column_name rt.PhpVal, var_drop_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_column := rt.new_null()
	mut iter_5 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_column_shadow := item_5.val
		if rt.is_true(rt.identical(var_column_shadow, var_column_name)) {
			rt.call_method(var_wpdb, 'query', [var_drop_ddl.clone()])
			mut iter_6 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_column_shadow := item_6.val
				if rt.is_true(rt.identical(var_column_shadow, var_column_name)) {
					return false
				}
			}
		}
	}
	return true
}

fn check_column(var_table_name rt.PhpVal, var_col_name rt.PhpVal, var_col_type rt.PhpVal, var_is_null rt.PhpVal, var_key rt.PhpVal, var_default_value rt.PhpVal, var_extra rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_diffs := i64(0)
	mut var_results := rt.new_null()
	mut var_row := rt.new_null()
	var_diffs = 0
	var_results = rt.call_method(var_wpdb, 'get_results', [rt.new_string("DESC ${var_table_name.to_string()}")])
	mut iter_7 := var_results.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_row_shadow := item_7.val
		if rt.is_true(rt.identical(rt.get_property(var_row_shadow, 'Field'), var_col_name)) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_col_type)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_row_shadow, 'Type'), var_col_type)))) {
				var_diffs += 1
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_is_null)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_row_shadow, 'Null'), var_is_null)))) {
				var_diffs += 1
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_key)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_row_shadow, 'Key'), var_key)))) {
				var_diffs += 1
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_default_value)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_row_shadow, 'Default'), var_default_value)))) {
				var_diffs += 1
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_extra)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_row_shadow, 'Extra'), var_extra)))) {
				var_diffs += 1
			}
			if var_diffs > 0 {
				return false
			}
			return true
		}
	}
	return false
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('maybe_create_table')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('maybe_add_column')]))))) {
	}
}
