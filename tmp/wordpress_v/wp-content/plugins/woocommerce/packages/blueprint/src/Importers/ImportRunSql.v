import rt

pub fn Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql.allowed_query_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'INSERT' }, rt.ArrayItem{ key: none, val: 'UPDATE' }, rt.ArrayItem{ key: none, val: 'REPLACE INTO' }])
}
struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) process(var_schema rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_result := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}; return temp.success(arg_0) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_Steps_RunSql{}; return temp.get_step_name() }())
	mut var_sql := rt.new_string(rt.new_string(rt.get_property(rt.get_property(var_schema, 'sql'), 'contents').to_string().trim_space()))
	if !(this.is_allowed_query_type((var_sql).str())) {
		rt.call_method(var_result, 'add_error', [rt.call_function('sprintf', [rt.new_string('Only %s queries are allowed.'), rt.call_function('implode', [rt.new_string(', '), Class_Automattic_WooCommerce_Blueprint_Importers_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql.allowed_query_types()])])])
		return var_result.dup()
	}
	if this.contains_suspicious_comments((var_sql).str()) {
		rt.call_method(var_result, 'add_error', [rt.new_string('SQL query contains suspicious comment patterns.')])
		return var_result.dup()
	}
	if this.contains_sql_injection_patterns((var_sql).str()) {
		rt.call_method(var_result, 'add_error', [rt.new_string('SQL query contains potential injection patterns.')])
		return var_result.dup()
	}
	if this.affects_protected_tables((var_sql).str()) {
		rt.call_method(var_result, 'add_error', [rt.new_string('Modifications to admin users or roles are not allowed.')])
		return var_result.dup()
	}
	if this.affects_user_capabilities((var_sql).str()) {
		rt.call_method(var_result, 'add_error', [rt.new_string('Modifications to user roles or capabilities are not allowed.')])
		return var_result.dup()
	}
	rt.call_method(var_wpdb, 'suppress_errors', [rt.new_bool(true)])
	rt.call_method(var_wpdb, 'query', [rt.new_string('START TRANSACTION')])
	mut var_query_result := rt.call_method(var_wpdb, 'query', [var_sql.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_last_error := rt.get_property(var_wpdb, 'last_error')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(var_last_error) {
		rt.call_method(var_wpdb, 'query', [rt.new_string('ROLLBACK')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_result, 'add_error', ['Error executing SQL: ' + (var_last_error).str()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		rt.call_method(var_wpdb, 'query', [rt.new_string('COMMIT')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_result, 'add_debug', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Executed SQL ('), rt.get_property(rt.get_property(var_schema, 'sql'), 'name')), rt.new_string('): Affected ')), var_query_result), rt.new_string(' rows'))])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blueprint_Importers_Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(var_wpdb, 'query', [rt.new_string('ROLLBACK')])
		rt.call_method(var_result, 'add_error', [rt.concat(rt.new_string('Exception executing SQL: '), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) get_step_class() string {
	return (Class_Automattic_WooCommerce_Blueprint_Steps_RunSql.class()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) check_step_capabilities(var_schema rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')]))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) is_allowed_query_type(sql_content string) bool {
	mut var_uppercase_sql_content := rt.new_string(rt.new_string(sql_content.trim_space().to_upper()))
	{
		mut iter_1 := Class_Automattic_WooCommerce_Blueprint_Importers_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql.allowed_query_types().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query_type := item_1.val
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_uppercase_sql_content.dup(), var_query_type.dup()]))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) contains_suspicious_comments(sql_content string) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(sql_content), rt.new_string('--')]), rt.new_bool(false))) && rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(sql_content), rt.new_string('/*')]), rt.new_bool(false))))) && rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(sql_content), rt.new_string('#')]), rt.new_bool(false))))) {
		return false
	}
	mut var_dangerous_commands := rt.create_array([rt.ArrayItem{ key: none, val: 'DELETE' }, rt.ArrayItem{ key: none, val: 'DROP' }, rt.ArrayItem{ key: none, val: 'ALTER' }, rt.ArrayItem{ key: none, val: 'CREATE' }, rt.ArrayItem{ key: none, val: 'TRUNCATE' }, rt.ArrayItem{ key: none, val: 'GRANT' }, rt.ArrayItem{ key: none, val: 'REVOKE' }, rt.ArrayItem{ key: none, val: 'EXEC' }, rt.ArrayItem{ key: none, val: 'EXECUTE' }, rt.ArrayItem{ key: none, val: 'CALL' }, rt.ArrayItem{ key: none, val: 'INTO OUTFILE' }, rt.ArrayItem{ key: none, val: 'INTO DUMPFILE' }, rt.ArrayItem{ key: none, val: 'LOAD_FILE' }, rt.ArrayItem{ key: none, val: 'LOAD DATA' }, rt.ArrayItem{ key: none, val: 'BENCHMARK' }, rt.ArrayItem{ key: none, val: 'SLEEP' }, rt.ArrayItem{ key: none, val: 'INFORMATION_SCHEMA' }, rt.ArrayItem{ key: none, val: 'USER\\(' }, rt.ArrayItem{ key: none, val: 'DATABASE\\(' }, rt.ArrayItem{ key: none, val: 'SCHEMA\\(' }])
	mut var_dangerous_pattern := rt.call_function('implode', [rt.new_string('|'), var_dangerous_commands.dup()])
	mut var_patterns := rt.create_array([rt.ArrayItem{ key: none, val: '/--.*?(' + (var_dangerous_pattern).str() + ')/i' }, rt.ArrayItem{ key: none, val: '/#.*?(' + (var_dangerous_pattern).str() + ')/i' }, rt.ArrayItem{ key: none, val: '/\\/\\*.*?(' + (var_dangerous_pattern).str() + ').*?\\*\\//is' }, rt.ArrayItem{ key: none, val: '/\\/\\*![0-9]*.*?\\*\\//' }])
	{
		mut iter_1 := var_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(), rt.new_string(sql_content)])) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) contains_sql_injection_patterns(sql_content string) bool {
	mut var_patterns := rt.create_array([rt.ArrayItem{ key: none, val: '/UNION\\s+(?:ALL\\s+)?SELECT/i' }, rt.ArrayItem{ key: none, val: '/OR\\s+1\\s*=\\s*1/i' }, rt.ArrayItem{ key: none, val: '/AND\\s+0\\s*=\\s*0/i' }, rt.ArrayItem{ key: none, val: '/;\\s*--/i' }, rt.ArrayItem{ key: none, val: '/SLEEP\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/BENCHMARK\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/LOAD_FILE\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/INTO\\s+OUTFILE/i' }, rt.ArrayItem{ key: none, val: '/INTO\\s+DUMPFILE/i' }, rt.ArrayItem{ key: none, val: '/CREATE\\s+(?:TEMPORARY\\s+)?TABLE/i' }, rt.ArrayItem{ key: none, val: '/DROP\\s+TABLE/i' }, rt.ArrayItem{ key: none, val: '/ALTER\\s+TABLE/i' }, rt.ArrayItem{ key: none, val: '/INFORMATION_SCHEMA/i' }, rt.ArrayItem{ key: none, val: '/EXEC\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/SCHEMA_NAME/i' }, rt.ArrayItem{ key: none, val: '/DATABASE\\(\\)/i' }, rt.ArrayItem{ key: none, val: '/CHR\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/CHAR\\s*\\(/i' }, rt.ArrayItem{ key: none, val: '/FROM\\s+mysql\\./i' }, rt.ArrayItem{ key: none, val: '/FROM\\s+information_schema\\./i' }])
	{
		mut iter_1 := var_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(), rt.new_string(sql_content)])) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) affects_protected_tables(sql_content string) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_protected_tables := rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'users') }, rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'usermeta') }])
	{
		mut iter_1 := var_protected_tables.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table := item_1.val
			if rt.is_true(rt.call_function('preg_match', ['/\\b' + (rt.call_function('preg_quote', [var_table.dup(), rt.new_string('/')])).str() + '\\b/i', rt.new_string(sql_content)])) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) affects_user_capabilities(sql_content string) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_option_patterns := rt.create_array([rt.ArrayItem{ key: none, val: 'user_roles' }, rt.ArrayItem{ key: none, val: 'capabilities' }, rt.ArrayItem{ key: none, val: 'wp_user_' }, rt.ArrayItem{ key: none, val: 'role_' }, rt.ArrayItem{ key: none, val: 'administrator' }])
		{
			mut iter_1 := var_option_patterns.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_pattern := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					return true
				}
			}
		}
	}
	return false
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importers_importrunsql() &Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult() &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_runsql() &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process(dispatch_arg_0)
		}
		'get_step_class' {
			return rt.new_string(this.get_step_class())
		}
		'check_step_capabilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_step_capabilities(dispatch_arg_0))
		}
		'is_allowed_query_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_allowed_query_type(dispatch_arg_0))
		}
		'contains_suspicious_comments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.contains_suspicious_comments(dispatch_arg_0))
		}
		'contains_sql_injection_patterns' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.contains_sql_injection_patterns(dispatch_arg_0))
		}
		'affects_protected_tables' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.affects_protected_tables(dispatch_arg_0))
		}
		'affects_user_capabilities' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.affects_user_capabilities(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportRunSql) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_importers_importrunsql_php() {
}
