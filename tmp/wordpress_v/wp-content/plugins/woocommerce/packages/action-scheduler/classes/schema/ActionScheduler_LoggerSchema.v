import rt

pub fn Class_ActionScheduler_LoggerSchema.log_table() string {
	return 'actionscheduler_logs'
}
struct Class_ActionScheduler_LoggerSchema {
	rt.PhpObjectBase
pub mut:
		schema_version rt.PhpVal = rt.new_int(3)
}

fn (mut this Class_ActionScheduler_LoggerSchema) construct()  {
	this.dispatch_set_prop('tables', rt.create_array([rt.ArrayItem{ key: none, val: Class_ActionScheduler_LoggerSchema.log_table() }]))
}

fn (mut this Class_ActionScheduler_LoggerSchema) init()  {
	rt.call_function('add_action', [rt.new_string('action_scheduler_before_schema_update'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_LoggerSchema', ['ActionScheduler_Abstract_Schema'], &this) }, rt.ArrayItem{ key: none, val: 'update_schema_3_0' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_ActionScheduler_LoggerSchema) get_table_definition(var_table rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := rt.get_property(var_wpdb, '{"nodeType":"Expr_Variable","line":45,"name":"table"}')
	mut var_charset_collate := rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
	mut switch_val_1 := var_table
	if rt.is_true(rt.equal(switch_val_1, Class_ActionScheduler_LoggerSchema.log_table())) {
		mut var_default_date := Class_ActionScheduler_StoreSchema.default_date()
		return rt.new_string("CREATE TABLE ${var_table_name.to_string()} (\n\t\t\t\t        log_id bigint(20) unsigned NOT NULL auto_increment,\n\t\t\t\t        action_id bigint(20) unsigned NOT NULL,\n\t\t\t\t        message text NOT NULL,\n\t\t\t\t        log_date_gmt datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\t        log_date_local datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\t        PRIMARY KEY  (log_id),\n\t\t\t\t        KEY action_id (action_id),\n\t\t\t\t        KEY log_date_gmt (log_date_gmt)\n\t\t\t\t        ) ${var_charset_collate.to_string()}")
	} else {
		return rt.new_string('')
	}
}

fn (mut this Class_ActionScheduler_LoggerSchema) update_schema_3_0(var_table rt.PhpVal, var_db_version rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.call_function('version_compare', [var_db_version.dup(), rt.new_string('3'), rt.new_string('>=')])))) {
		return rt.new_null()
	}
	mut var_table_name := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'actionscheduler_logs')
	mut var_table_list := rt.call_method(var_wpdb, 'get_col', [rt.new_string("SHOW TABLES LIKE '${var_table_name.to_string()}'")])
	mut var_default_date := Class_ActionScheduler_StoreSchema.default_date()
	if !(!rt.is_true(var_table_list)) {
		mut var_query := rt.new_string(rt.new_string("\n\t\t\t\tALTER TABLE ${var_table_name.to_string()}\n\t\t\t\tMODIFY COLUMN log_date_gmt datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\tMODIFY COLUMN log_date_local datetime NULL default '${var_default_date.to_string()}'\n\t\t\t"))
		rt.call_method(var_wpdb, 'query', [var_query.dup()])
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Nop
}

struct Class_ActionScheduler_Abstract_Schema {
	rt.PhpObjectBase
}

fn create_actionscheduler_loggerschema() &Class_ActionScheduler_LoggerSchema {
	mut obj := &Class_ActionScheduler_LoggerSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema_version: rt.new_int(3)
	}
	obj.construct()
	return obj
}

fn create_actionscheduler_abstract_schema() &Class_ActionScheduler_Abstract_Schema {
	mut obj := &Class_ActionScheduler_Abstract_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_table_definition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_table_definition(dispatch_arg_0)
			return rt.new_null()
		}
		'update_schema_3_0' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_schema_3_0(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_LoggerSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema_version' { return this.schema_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema_version' { this.schema_version = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Abstract_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Abstract_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_schema_actionscheduler_loggerschema_php() {
}
