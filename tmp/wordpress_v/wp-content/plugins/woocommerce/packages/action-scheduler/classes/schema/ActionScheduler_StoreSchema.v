import rt

pub fn Class_ActionScheduler_StoreSchema.actions_table() string {
	return 'actionscheduler_actions'
}
pub fn Class_ActionScheduler_StoreSchema.claims_table() string {
	return 'actionscheduler_claims'
}
pub fn Class_ActionScheduler_StoreSchema.groups_table() string {
	return 'actionscheduler_groups'
}
pub fn Class_ActionScheduler_StoreSchema.default_date() string {
	return '0000-00-00 00:00:00'
}
struct Class_ActionScheduler_StoreSchema {
	rt.PhpObjectBase
pub mut:
		schema_version rt.PhpVal = rt.new_int(8)
}

fn (mut this Class_ActionScheduler_StoreSchema) construct()  {
	this.dispatch_set_prop('tables', rt.create_array([rt.ArrayItem{ key: none, val: Class_ActionScheduler_StoreSchema.actions_table() }, rt.ArrayItem{ key: none, val: Class_ActionScheduler_StoreSchema.claims_table() }, rt.ArrayItem{ key: none, val: Class_ActionScheduler_StoreSchema.groups_table() }]))
}

fn (mut this Class_ActionScheduler_StoreSchema) init()  {
	rt.call_function('add_action', [rt.new_string('action_scheduler_before_schema_update'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_StoreSchema', ['ActionScheduler_Abstract_Schema'], &this) }, rt.ArrayItem{ key: none, val: 'update_schema_5_0' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_ActionScheduler_StoreSchema) get_table_definition(var_table rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := rt.get_property(var_wpdb, '{"nodeType":"Expr_Variable","line":50,"name":"table"}')
	mut var_charset_collate := rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
	mut var_default_date := rt.new_string(Class_ActionScheduler_StoreSchema.default_date())
	mut var_max_index_length := rt.new_int(rt.new_int(191))
	mut var_hook_status_scheduled_date_gmt_max_index_length := rt.sub(rt.sub(var_max_index_length, rt.new_int(20)), rt.new_int(8))
	mut switch_val_1 := var_table
	if rt.is_true(rt.equal(switch_val_1, Class_ActionScheduler_StoreSchema.actions_table())) {
		return rt.new_string("CREATE TABLE ${var_table_name.to_string()} (\n\t\t\t\t        action_id bigint(20) unsigned NOT NULL auto_increment,\n\t\t\t\t        hook varchar(191) NOT NULL,\n\t\t\t\t        status varchar(20) NOT NULL,\n\t\t\t\t        scheduled_date_gmt datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\t        scheduled_date_local datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\t        priority tinyint unsigned NOT NULL default '10',\n\t\t\t\t        args varchar(${var_max_index_length.to_string()}),\n\t\t\t\t        schedule longtext,\n\t\t\t\t        group_id bigint(20) unsigned NOT NULL default '0',\n\t\t\t\t        attempts int(11) NOT NULL default '0',\n\t\t\t\t        last_attempt_gmt datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\t        last_attempt_local datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\t        claim_id bigint(20) unsigned NOT NULL default '0',\n\t\t\t\t        extended_args varchar(8000) DEFAULT NULL,\n\t\t\t\t        PRIMARY KEY  (action_id),\n\t\t\t\t        KEY hook_status_scheduled_date_gmt (hook(${var_hook_status_scheduled_date_gmt_max_index_length.to_string()}), status, scheduled_date_gmt),\n\t\t\t\t        KEY status_scheduled_date_gmt (status, scheduled_date_gmt),\n\t\t\t\t        KEY scheduled_date_gmt (scheduled_date_gmt),\n\t\t\t\t        KEY args (args(${var_max_index_length.to_string()})),\n\t\t\t\t        KEY group_id (group_id),\n\t\t\t\t        KEY last_attempt_gmt (last_attempt_gmt),\n\t\t\t\t        KEY `claim_id_status_priority_scheduled_date_gmt` (`claim_id`,`status`,`priority`,`scheduled_date_gmt`),\n\t\t\t\t        KEY `status_last_attempt_gmt` (`status`,`last_attempt_gmt`),\n\t\t\t\t        KEY `status_claim_id` (`status`,`claim_id`)\n\t\t\t\t        ) ${var_charset_collate.to_string()}")
	} else if rt.is_true(rt.equal(switch_val_1, Class_ActionScheduler_StoreSchema.claims_table())) {
		return rt.new_string("CREATE TABLE ${var_table_name.to_string()} (\n\t\t\t\t        claim_id bigint(20) unsigned NOT NULL auto_increment,\n\t\t\t\t        date_created_gmt datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\t        PRIMARY KEY  (claim_id),\n\t\t\t\t        KEY date_created_gmt (date_created_gmt)\n\t\t\t\t        ) ${var_charset_collate.to_string()}")
	} else if rt.is_true(rt.equal(switch_val_1, Class_ActionScheduler_StoreSchema.groups_table())) {
		return rt.new_string("CREATE TABLE ${var_table_name.to_string()} (\n\t\t\t\t        group_id bigint(20) unsigned NOT NULL auto_increment,\n\t\t\t\t        slug varchar(255) NOT NULL,\n\t\t\t\t        PRIMARY KEY  (group_id),\n\t\t\t\t        KEY slug (slug(${var_max_index_length.to_string()}))\n\t\t\t\t        ) ${var_charset_collate.to_string()}")
	} else {
		return rt.new_string('')
	}
}

fn (mut this Class_ActionScheduler_StoreSchema) update_schema_5_0(var_table rt.PhpVal, var_db_version rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.call_function('version_compare', [var_db_version.dup(), rt.new_string('5'), rt.new_string('>=')])))) {
		return rt.new_null()
	}
	mut var_table_name := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'actionscheduler_actions')
	mut var_table_list := rt.call_method(var_wpdb, 'get_col', [rt.new_string("SHOW TABLES LIKE '${var_table_name.to_string()}'")])
	mut var_default_date := rt.new_string(Class_ActionScheduler_StoreSchema.default_date())
	if !(!rt.is_true(var_table_list)) {
		mut var_query := rt.new_string(rt.new_string("\n\t\t\t\tALTER TABLE ${var_table_name.to_string()}\n\t\t\t\tMODIFY COLUMN scheduled_date_gmt datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\tMODIFY COLUMN scheduled_date_local datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\tMODIFY COLUMN last_attempt_gmt datetime NULL default '${var_default_date.to_string()}',\n\t\t\t\tMODIFY COLUMN last_attempt_local datetime NULL default '${var_default_date.to_string()}'\n\t\t"))
		rt.call_method(var_wpdb, 'query', [var_query.dup()])
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Nop
}

struct Class_ActionScheduler_Abstract_Schema {
	rt.PhpObjectBase
}

fn create_actionscheduler_storeschema() &Class_ActionScheduler_StoreSchema {
	mut obj := &Class_ActionScheduler_StoreSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema_version: rt.new_int(8)
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

fn (mut this Class_ActionScheduler_StoreSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'update_schema_5_0' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_schema_5_0(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_StoreSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema_version' { return this.schema_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_StoreSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_schema_actionscheduler_storeschema_php() {
}
