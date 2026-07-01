import rt

fn maybe_create_table(var_table_name rt.PhpVal, var_create_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := rt.call_method(var_wpdb, 'get_col', [rt.new_string('SHOW TABLES'), rt.new_int(0)]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table := item_1.val
			if rt.is_true(rt.identical(var_table, var_table_name)) {
				return true
			}
		}
	}
	rt.call_method(var_wpdb, 'query', [var_create_ddl.dup()])
	{
		mut iter_1 := rt.call_method(var_wpdb, 'get_col', [rt.new_string('SHOW TABLES'), rt.new_int(0)]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table := item_1.val
			if rt.is_true(rt.identical(var_table, var_table_name)) {
				return true
			}
		}
	}
	return false
}

fn maybe_add_column(var_table_name rt.PhpVal, var_column_name rt.PhpVal, var_create_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column := item_1.val
			if rt.is_true(rt.identical(var_column, var_column_name)) {
				return true
			}
		}
	}
	rt.call_method(var_wpdb, 'query', [var_create_ddl.dup()])
	{
		mut iter_1 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column := item_1.val
			if rt.is_true(rt.identical(var_column, var_column_name)) {
				return true
			}
		}
	}
	return false
}

fn maybe_drop_column(var_table_name rt.PhpVal, var_column_name rt.PhpVal, var_drop_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column := item_1.val
			if rt.is_true(rt.identical(var_column, var_column_name)) {
				rt.call_method(var_wpdb, 'query', [var_drop_ddl.dup()])
				{
					mut iter_2 := rt.call_method(var_wpdb, 'get_col', [rt.new_string("DESC ${var_table_name.to_string()}"), rt.new_int(0)]).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_column_shadow := item_2.val
						if rt.is_true(rt.identical(var_column_shadow, var_column_name)) {
							return false
						}
					}
				}
			}
		}
	}
	return true
}

fn check_column(var_table_name rt.PhpVal, var_col_name rt.PhpVal, var_col_type rt.PhpVal, var_is_null rt.PhpVal, var_key rt.PhpVal, var_default_value rt.PhpVal, var_extra rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_diffs := 0
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.new_string("DESC ${var_table_name.to_string()}")])
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row := item_1.val
			if rt.is_true(rt.identical(rt.get_property(var_row, 'Field'), var_col_name)) {
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_diffs += 1
				}
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_diffs += 1
				}
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_diffs += 1
				}
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_diffs += 1
				}
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_diffs += 1
				}
				if var_diffs > 0 {
					return false
				}
				return true
			}
			// unsupported statement: Stmt_Nop
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
