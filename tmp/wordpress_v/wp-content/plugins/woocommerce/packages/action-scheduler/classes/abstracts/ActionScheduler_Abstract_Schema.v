import rt

struct Class_ActionScheduler_Abstract_Schema {
	rt.PhpObjectBase
pub mut:
		schema_version rt.PhpVal = rt.new_int(1)
		db_version rt.PhpVal = rt.new_null()
		tables rt.PhpVal = rt.new_array()
}

fn (mut this Class_ActionScheduler_Abstract_Schema) init()  {
}

fn (mut this Class_ActionScheduler_Abstract_Schema) register_tables(force_update bool)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := this.tables.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table := item_1.val
			rt.get_property(var_wpdb, 'tables').array_push(var_table.dup())
			mut var_name := rt.new_string(this.get_full_table_name(var_table.dup()))
			rt.set_property(var_wpdb, '{"nodeType":"Expr_Variable","line":56,"name":"table"}', var_name.dup())
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.schema_update_required()) || var_force_update)) {
		{
			mut iter_1 := this.tables.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_table := item_1.val
				rt.call_function('do_action', [rt.new_string('action_scheduler_before_schema_update'), var_table.dup(), this.db_version])
				this.update_table(var_table.dup())
			}
		}
		this.mark_schema_update_complete()
	}
}

fn (mut this Class_ActionScheduler_Abstract_Schema) get_table_definition(var_table rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_Abstract_Schema) schema_update_required() rt.PhpVal {
	mut var_option_name := rt.new_string('schema-' + (Class_static.class()).str())
	this.db_version = rt.call_function('get_option', [var_option_name.dup(), rt.new_int(0)])
	if rt.is_true(rt.identical(rt.new_int(0), this.db_version)) {
		mut var_plugin_option_name := rt.new_string(rt.new_string('schema-'))
		mut switch_val_1 := Class_static.class()
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('ActionScheduler_StoreSchema'))) {
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ActionScheduler_LoggerSchema'))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		this.db_version = rt.call_function('get_option', [var_plugin_option_name.dup(), rt.new_int(0)])
		rt.call_function('delete_option', [var_plugin_option_name.dup()])
	}
	return rt.call_function('version_compare', [this.db_version, this.schema_version, rt.new_string('<')])
}

fn (mut this Class_ActionScheduler_Abstract_Schema) mark_schema_update_complete()  {
	mut var_option_name := rt.new_string('schema-' + (Class_static.class()).str())
	mut var_value_to_save := rt.new_string((// unsupported expression: Expr_Cast_String).str() + '.0.' + (rt.call_function('time', []rt.PhpVal{})).str())
	rt.call_function('update_option', [var_option_name.dup(), var_value_to_save.dup()])
}

fn (mut this Class_ActionScheduler_Abstract_Schema) update_table(var_table rt.PhpVal)  {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	mut var_definition := this.get_table_definition(var_table.dup())
	if rt.is_true(var_definition) {
		mut var_updated := rt.call_function('dbDelta', [var_definition.dup()])
		{
			mut iter_1 := var_updated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_update_description := item_1.val
				mut var_updated_table := item_1.key
				if rt.is_true(rt.identical(rt.call_function('strpos', [var_update_description.dup(), rt.new_string('Created table')]), rt.new_int(0))) {
					rt.call_function('do_action', [rt.new_string('action_scheduler/created_table'), var_updated_table.dup(), var_table.dup()])
					// unsupported statement: Stmt_Nop
				}
			}
		}
	}
}

fn (mut this Class_ActionScheduler_Abstract_Schema) get_full_table_name(var_table rt.PhpVal) string {
	mut var_GLOBALS := rt.new_null()
	return (rt.get_property(var_GLOBALS.array_get('wpdb'), 'prefix')).str() + (var_table).str()
}

fn (mut this Class_ActionScheduler_Abstract_Schema) tables_exist() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_tables_exist := rt.new_bool(rt.new_bool(true))
	{
		mut iter_1 := this.tables.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table_name := item_1.val
			var_table_name = rt.new_string(rt.concat(rt.get_property(var_wpdb, 'prefix'), var_table_name))
			mut var_pattern := rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('\\_'), var_table_name.dup()])
			mut var_existing_table := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'), var_pattern.dup()])])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_tables_exist = rt.new_bool(rt.new_bool(false))
				break
			}
		}
	}
	return var_tables_exist.dup()
}

fn create_actionscheduler_abstract_schema() &Class_ActionScheduler_Abstract_Schema {
	mut obj := &Class_ActionScheduler_Abstract_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema_version: rt.new_int(1)
		db_version: rt.new_null()
		tables: rt.new_array()
	}
	return obj
}

fn (mut this Class_ActionScheduler_Abstract_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_tables' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.register_tables(dispatch_arg_0)
			return rt.new_null()
		}
		'get_table_definition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_table_definition(dispatch_arg_0)
			return rt.new_null()
		}
		'schema_update_required' {
			return this.schema_update_required()
		}
		'mark_schema_update_complete' {
			this.mark_schema_update_complete()
			return rt.new_null()
		}
		'update_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_table(dispatch_arg_0)
			return rt.new_null()
		}
		'get_full_table_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_full_table_name(dispatch_arg_0))
		}
		'tables_exist' {
			return this.tables_exist()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Abstract_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema_version' { return this.schema_version }
		'db_version' { return this.db_version }
		'tables' { return this.tables }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Abstract_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema_version' { this.schema_version = val; return true }
		'db_version' { this.db_version = val; return true }
		'tables' { this.tables = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_abstract_schema_php() {
}
