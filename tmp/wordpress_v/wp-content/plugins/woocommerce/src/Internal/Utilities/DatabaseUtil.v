import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) dbdelta(queries string, execute bool) rt.PhpVal {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	return rt.call_function('dbDelta', [rt.new_string(queries), rt.new_bool(execute)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) get_missing_tables(creation_queries string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_suppress_errors := rt.call_method(var_wpdb, 'suppress_errors', [rt.new_bool(true)])
	mut var_dbdelta_output := this.dbdelta(creation_queries, false)
	rt.call_method(var_wpdb, 'suppress_errors', [var_suppress_errors.dup()])
	mut var_parsed_output := this.parse_dbdelta_output(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](var_dbdelta_output))
	return var_parsed_output.array_get('created_tables')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) parse_dbdelta_output(mut var_dbdelta_output Class_Automattic_WooCommerce_Internal_Utilities_array) rt.PhpVal {
	mut var_dbdelta_output_mutated := var_dbdelta_output
	mut var_created_tables := rt.new_array()
	{
		mut iter_1 := var_dbdelta_output_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result := item_1.val
			mut var_table_name := item_1.key
			if rt.is_true(rt.identical(rt.new_string("Created table ${var_table_name.to_string()}"), var_result)) {
				var_created_tables.array_push(rt.call_function('str_replace', [rt.new_string('('), rt.new_string(''), var_table_name.dup()]))
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'created_tables', val: var_created_tables }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) drop_database_table(table_name string, add_prefix bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut table_name_mutated := table_name
	// unsupported statement: Stmt_Global
	if var_add_prefix {
		table_name_mutated = (rt.get_property(var_wpdb, 'prefix')).str() + table_name_mutated
	}
	return rt.call_method(var_wpdb, 'query', [rt.new_string("DROP TABLE IF EXISTS `${var_table_name.to_string()}`")])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) drop_table_index(table_name string, index_name string) bool {
	mut var_wpdb := rt.new_null()
	mut table_name_mutated := table_name
	mut index_name_mutated := index_name
	// unsupported statement: Stmt_Global
	if !rt.is_true(this.get_index_columns(table_name_mutated, index_name_mutated)) {
		return false
	}
	rt.call_method(var_wpdb, 'query', [rt.new_string("ALTER TABLE ${var_table_name.to_string()} DROP INDEX ${var_index_name.to_string()}")])
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) create_primary_key(table_name string, mut var_columns Class_Automattic_WooCommerce_Internal_Utilities_array) bool {
	mut var_wpdb := rt.new_null()
	mut table_name_mutated := table_name
	mut var_columns_mutated := var_columns
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(this.get_index_columns(table_name_mutated, ''))) {
		return false
	}
	rt.call_method(var_wpdb, 'query', ["ALTER TABLE ${var_table_name.to_string()} ADD PRIMARY KEY(`" + (rt.call_function('join', [rt.new_string('`,`'), var_columns_mutated.dup()])).str() + '`)'])
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) get_index_columns(table_name string, index_name string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut table_name_mutated := table_name
	mut index_name_mutated := index_name
	// unsupported statement: Stmt_Global
	if index_name_mutated == '' {
		index_name_mutated = 'PRIMARY'
	}
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SHOW INDEX FROM ${var_table_name.to_string()} WHERE Key_name = %s"), rt.new_string(index_name_mutated).dup()])])
	if !rt.is_true(var_results) {
		return rt.new_array()
	}
	return rt.call_function('array_column', [var_results.dup(), rt.new_string('Column_name')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) format_object_value_for_db(var_value rt.PhpVal, type string) rt.PhpVal {
	mut var_value_mutated := var_value
	mut switch_val_1 := rt.new_string(type)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('decimal'))) {
		var_value_mutated = rt.call_function('wc_format_decimal', [var_value_mutated.dup(), rt.new_bool(false), rt.new_bool(true)])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('int'))) {
		var_value_mutated = // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bool'))) {
		var_value_mutated = rt.call_function('wc_string_to_bool', [var_value_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('string'))) {
		var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string()))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date'))) {
		var_value_mutated = if rt.is_true(var_value_mutated) { rt.call_method(rt.call_method(create_datetime(var_value_mutated.dup()), 'setTimezone', [create_datetimezone(rt.new_string('+00:00'))]), 'format', [rt.new_string('Y-m-d H:i:s')]) } else { rt.new_null() }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_epoch'))) {
		var_value_mutated = if rt.is_true(var_value_mutated) { rt.call_method(create_datetime(rt.new_string("@${var_value.to_string()}")), 'format', [rt.new_string('Y-m-d H:i:s')]) } else { rt.new_null() }
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Utilities_Exception', []string{}, create_automattic_woocommerce_internal_utilities_exception(rt.call_function('esc_html', ['Invalid type received: ' + type]))))
	}
	return var_value_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) get_wpdb_format_for_type(type string) rt.PhpVal {
	mut var_wpdb_placeholder_for_type := rt.new_null()
	// unsupported statement: Stmt_Static
	if !(var_wpdb_placeholder_for_type.array_isset(rt.new_string(type))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Utilities_Exception', []string{}, create_automattic_woocommerce_internal_utilities_exception(rt.call_function('esc_html', ['Invalid column type: ' + type]))))
	}
	return var_wpdb_placeholder_for_type.array_get(type)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) generate_on_duplicate_statement_clause(mut var_columns Class_Automattic_WooCommerce_Internal_Utilities_array) string {
	mut var_columns_mutated := var_columns
	mut var_update_value_statements := rt.new_array()
	{
		mut iter_1 := var_columns_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column := item_1.val
			var_update_value_statements.array_push("`${var_column.to_string()}` = VALUES( `${var_column.to_string()}` )")
		}
	}
	mut var_update_value_clause := rt.call_function('implode', [rt.new_string(', '), var_update_value_statements.dup()])
	return "ON DUPLICATE KEY UPDATE ${var_update_value_clause.to_string()}"
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) insert_on_duplicate_key_update(var_table_name rt.PhpVal, var_data rt.PhpVal, var_format rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_table_name_mutated := var_table_name
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_data) {
		return 0
	}
	mut var_columns := rt.func_array_keys(var_data.dup())
	mut var_value_format := rt.new_array()
	mut var_values := rt.new_array()
	mut var_index := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_value.dup().is_null())) {
				var_value_format.array_push('NULL')
			} else {
				var_values.array_push(var_value.dup())
				var_value_format.array_push(var_format.array_get(var_index))
			}
			rt.pre_inc(var_index)
		}
	}
	mut var_column_clause := rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`, `'), var_columns.dup()])).str() + '`')
	mut var_value_format_clause := rt.call_function('implode', [rt.new_string(', '), var_value_format.dup()])
	mut var_on_duplicate_clause := rt.new_string(this.generate_on_duplicate_statement_clause(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](var_columns)))
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nINSERT INTO ${var_table_name.to_string()} ( ${var_column_clause.to_string()} )\nVALUES ( ${var_value_format_clause.to_string()} )\n${var_on_duplicate_clause.to_string()}\n"), var_values.dup()])
	return (rt.call_method(var_wpdb, 'query', [var_sql.dup()])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) insert_or_update(var_table_name rt.PhpVal, var_data rt.PhpVal, var_where rt.PhpVal, var_format rt.PhpVal, var_where_format rt.PhpVal, primary_key_column string, primary_key_format string) i64 {
	mut var_wpdb := rt.new_null()
	mut var_table_name_mutated := var_table_name
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_data) || !rt.is_true(var_where) {
		return 0
	}
	mut var_values := rt.new_array()
	mut var_index := rt.new_int(rt.new_int(0))
	mut var_conditions := rt.new_array()
	{
		mut iter_1 := var_where.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_column := item_1.key
			if rt.is_true(rt.new_bool(var_value.dup().is_null())) {
				var_conditions.array_push("`${var_column.to_string()}` IS NULL")
				continue
			}
			var_conditions.array_push("`${var_column.to_string()}` = " + (var_where_format.array_get(var_index)).str())
			var_values.array_push(var_value.dup())
			rt.pre_inc(var_index)
		}
	}
	var_conditions = rt.call_function('implode', [rt.new_string(' AND '), var_conditions.dup()])
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT `${var_primary_key_column}` FROM `${var_table_name.to_string()}` WHERE ${var_conditions.to_string()} LIMIT 1"), var_values.dup()])
	mut var_row_id := rt.call_method(var_wpdb, 'get_var', [var_query.dup()])
	if rt.is_true(var_row_id) {
		mut var_result := rt.call_method(var_wpdb, 'update', [var_table_name_mutated.dup(), var_data.dup(), rt.create_array([rt.ArrayItem{ key: primary_key_column, val: var_row_id }]), var_format.dup(), rt.create_array([rt.ArrayItem{ key: none, val: primary_key_format }])])
	} else {
		var_result = rt.call_method(var_wpdb, 'insert', [var_table_name_mutated.dup(), var_data.dup(), var_format.dup()])
	}
	return (var_result).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) get_max_index_length() i64 {
	mut var_max_index_length := rt.call_function('apply_filters', [rt.new_string('woocommerce_database_max_index_length'), rt.new_int(191)])
	return (rt.call_function('min', [rt.call_function('absint', [var_max_index_length.dup()]), rt.new_int(767)])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) create_fts_index_order_address_table()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_address_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_addresses')
	rt.call_method(var_wpdb, 'query', [rt.new_string("CREATE FULLTEXT INDEX order_addresses_fts ON ${var_address_table.to_string()} (first_name, last_name, company, address_1, address_2, city, state, postcode, country, email, phone)")])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) drop_fts_index_order_address_table()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_address_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_addresses')
	rt.call_method(var_wpdb, 'query', [rt.new_string("ALTER TABLE ${var_address_table.to_string()} DROP INDEX order_addresses_fts;")])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) sanitise_boolean_fts_search_term(param string) string {
	mut param_mutated := param
	mut var_sanitized_param := rt.call_function('preg_replace', [rt.new_string('/[^\\p{L}\\p{N}_]+/u'), rt.new_string(' '), rt.new_string(param_mutated).dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		param_mutated = (rt.call_function('str_replace', [rt.new_string('"'), rt.new_string(''), rt.new_string(param_mutated).dup()])).str()
		return '"' + param_mutated + '"'
	}
	mut var_words := rt.call_function('explode', [rt.new_string(' '), rt.new_string(param_mutated).dup()])
	mut var_sanitized_words := rt.new_array()
	{
		mut iter_1 := var_words.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_word := item_1.val
			var_word = rt.new_string(().str() + )
			.array_push(.dup())
		}
	}
	return ().str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) fts_index_on_order_address_table_exists() bool {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) create_fts_index_order_item_table()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) fts_index_on_order_item_table_exists() bool {
	mut var_wpdb := rt.new_null()
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_databaseutil() &Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_exception() &Class_Automattic_WooCommerce_Internal_Utilities_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'dbdelta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.dbdelta(dispatch_arg_0, dispatch_arg_1)
		}
		'get_missing_tables' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_missing_tables(dispatch_arg_0)
		}
		'parse_dbdelta_output' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parse_dbdelta_output(mut dispatch_arg_0)
		}
		'drop_database_table' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.drop_database_table(dispatch_arg_0, dispatch_arg_1)
		}
		'drop_table_index' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.drop_table_index(dispatch_arg_0, dispatch_arg_1))
		}
		'create_primary_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.create_primary_key(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_index_columns' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_index_columns(dispatch_arg_0, dispatch_arg_1)
		}
		'format_object_value_for_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.format_object_value_for_db(dispatch_arg_0, dispatch_arg_1)
		}
		'get_wpdb_format_for_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_wpdb_format_for_type(dispatch_arg_0)
		}
		'generate_on_duplicate_statement_clause' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_on_duplicate_statement_clause(mut dispatch_arg_0))
		}
		'insert_on_duplicate_key_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_int(this.insert_on_duplicate_key_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'insert_or_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).str()
			return rt.new_int(this.insert_or_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6))
		}
		'get_max_index_length' {
			return rt.new_int(this.get_max_index_length())
		}
		'create_fts_index_order_address_table' {
			this.create_fts_index_order_address_table()
			return rt.new_null()
		}
		'drop_fts_index_order_address_table' {
			this.drop_fts_index_order_address_table()
			return rt.new_null()
		}
		'sanitise_boolean_fts_search_term' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.sanitise_boolean_fts_search_term(dispatch_arg_0))
		}
		'fts_index_on_order_address_table_exists' {
			return rt.new_bool(this.fts_index_on_order_address_table_exists())
		}
		'create_fts_index_order_item_table' {
			this.create_fts_index_order_item_table()
			return rt.new_null()
		}
		'fts_index_on_order_item_table_exists' {
			return rt.new_bool(this.fts_index_on_order_item_table_exists())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_databaseutil_php() {
}
