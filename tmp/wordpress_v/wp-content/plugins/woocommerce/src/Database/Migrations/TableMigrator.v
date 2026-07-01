import rt

struct Class_Automattic_WooCommerce_Database_Migrations_TableMigrator {
	rt.PhpObjectBase
pub mut:
		errors rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) clear_errors()  {
	this.errors = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) add_error(error string)  {
	if rt.is_true(rt.new_bool(this.errors.is_null())) {
		this.errors = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(error), this.errors, rt.new_bool(true)]))))) {
		this.errors.array_push(error)
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) get_errors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) db_query(query string) rt.PhpVal {
	mut var_wpdb := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_global', [rt.new_string('wpdb')])
	mut var_result := rt.call_method(var_wpdb, 'query', [rt.new_string(query)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.add_error((rt.get_property(var_wpdb, 'last_error')).str())
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) db_get_results(mut var_query Class_Automattic_WooCommerce_Database_Migrations_?string, output string) rt.PhpVal {
	mut var_wpdb := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_global', [rt.new_string('wpdb')])
	mut var_result := rt.call_method(var_wpdb, 'get_results', [var_query, rt.new_string(output)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.add_error((rt.get_property(var_wpdb, 'last_error')).str())
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) process_migration_batch_for_ids(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	this.clear_errors()
	mut var_exception := rt.new_null()
	this.process_migration_batch_for_ids_core(mut var_entity_ids)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Database_Migrations_Exception') {
		mut var_ex := var_e_1.dup()
		var_exception = var_ex
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.create_array([rt.ArrayItem{ key: 'errors', val: this.get_errors() }, rt.ArrayItem{ key: 'exception', val: var_exception }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) fetch_sanitized_migration_data(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array)  {
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Database_Migrations_Exception', []string{}, create_automattic_woocommerce_database_migrations_exception(rt.new_string('Not implemented'))))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) process_migration_data(mut var_data Class_Automattic_WooCommerce_Database_Migrations_array)  {
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Database_Migrations_Exception', []string{}, create_automattic_woocommerce_database_migrations_exception(rt.new_string('Not implemented'))))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) process_migration_batch_for_ids_core(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array)  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) maybe_add_insert_or_update_error(operation string, var_received_rows_count rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_bool(false), var_received_rows_count)) {
		this.add_error("${var_operation} operation didn't complete, the database query failed")
	}
}

struct Class_Automattic_WooCommerce_Database_Migrations_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_tablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
		errors: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_exception() &Class_Automattic_WooCommerce_Database_Migrations_Exception {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'clear_errors' {
			this.clear_errors()
			return rt.new_null()
		}
		'add_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.add_error(dispatch_arg_0)
			return rt.new_null()
		}
		'get_errors' {
			return this.get_errors()
		}
		'db_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.db_query(dispatch_arg_0)
		}
		'db_get_results' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.db_get_results(mut dispatch_arg_0, dispatch_arg_1)
		}
		'process_migration_batch_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.process_migration_batch_for_ids(mut dispatch_arg_0)
		}
		'fetch_sanitized_migration_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.fetch_sanitized_migration_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_migration_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.process_migration_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_migration_batch_for_ids_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.process_migration_batch_for_ids_core(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_add_insert_or_update_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.maybe_add_insert_or_update_error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'errors' { return this.errors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'errors' { this.errors = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_database_migrations_tablemigrator_php() {
}
