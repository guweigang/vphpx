import rt

struct Class_Action_Scheduler_Migration_Controller {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		migration_scheduler rt.PhpVal = rt.new_null()
		store_classname rt.PhpVal = rt.new_null()
		logger_classname rt.PhpVal = rt.new_null()
		migrate_custom_store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_Controller) construct(mut var_migration_scheduler Class_Action_Scheduler_Migration_Scheduler)  {
	this.migration_scheduler = var_migration_scheduler.dup()
	this.store_classname = rt.new_string('')
}

fn (mut this Class_Action_Scheduler_Migration_Controller) get_store_class(var_class rt.PhpVal) string {
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_ActionScheduler_DataController{}; return temp.is_migration_complete() }()) {
		return (Class_ActionScheduler_DataController.datastore_class()).str()
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.store_classname = var_class.dup()
		return (var_class).str()
	} else {
		return 'ActionScheduler_HybridStore'
	}
	return ''
}

fn (mut this Class_Action_Scheduler_Migration_Controller) get_logger_class(var_class rt.PhpVal) rt.PhpVal {
	fn () rt.PhpVal { mut temp := Class_Action_Scheduler_Migration_ActionScheduler_Store{}; return temp.instance() }()
	if rt.is_true(this.has_custom_datastore()) {
		this.logger_classname = var_class.dup()
		return var_class.dup()
	} else {
		return Class_ActionScheduler_DataController.logger_class()
	}
	return rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_Controller) has_custom_datastore() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_Action_Scheduler_Migration_Controller) schedule_migration()  {
	mut var_logging_tables := create_actionscheduler_loggerschema()
	mut var_store_tables := create_actionscheduler_storeschema()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_ActionScheduler_DataController{}; return temp.is_migration_complete() }()) || rt.is_true(rt.call_method(this.migration_scheduler, 'is_migration_scheduled', []rt.PhpVal{})))) || rt.is_true(rt.new_bool(!(rt.is_true(var_store_tables.tables_exist())))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_logging_tables.tables_exist())))))) {
		return rt.new_null()
	}
	rt.call_method(this.migration_scheduler, 'schedule_migration', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_Migration_Controller) get_migration_config_object() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(var_config)))) {
		mut var_source_store := if rt.is_true(this.store_classname) { rt.create_object_dynamically(this.store_classname, []rt.PhpVal{}) } else { create_action_scheduler_migration_actionscheduler_wppoststore() }
		mut var_source_logger := if rt.is_true(this.logger_classname) { rt.create_object_dynamically(this.logger_classname, []rt.PhpVal{}) } else { create_action_scheduler_migration_actionscheduler_wpcommentlogger() }
		mut var_config := create_action_scheduler_migration_config()
		var_config.set_source_store(var_source_store.dup())
		var_config.set_source_logger(var_source_logger.dup())
		var_config.set_destination_store(create_action_scheduler_migration_actionscheduler_dbstoremigrator())
		var_config.set_destination_logger(create_action_scheduler_migration_actionscheduler_dblogger())
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI')))) {
			var_config.set_progress_bar(create_action_scheduler_wp_cli_progressbar(rt.new_string(''), rt.new_int(0)))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler/migration_config'), var_config])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_Controller) hook_admin_notices()  {
	if rt.is_true(rt.new_bool(!(this.allow_migration()) || rt.is_true(fn () rt.PhpVal { mut temp := Class_ActionScheduler_DataController{}; return temp.is_migration_complete() }()))) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'display_migration_notice' }]), rt.new_int(10), rt.new_int(0)])
}

fn (mut this Class_Action_Scheduler_Migration_Controller) display_migration_notice()  {
	rt.call_function('printf', [rt.new_string('<div class="notice notice-warning"><p>%s</p></div>'), rt.call_function('esc_html__', [rt.new_string('Action Scheduler migration in progress. The list of scheduled actions may be incomplete.'), rt.new_string('woocommerce')])])
}

fn (mut this Class_Action_Scheduler_Migration_Controller) hook()  {
	rt.call_function('add_filter', [rt.new_string('action_scheduler_store_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_store_class' }]), rt.new_int(100), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('action_scheduler_logger_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_logger_class' }]), rt.new_int(100), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_hook_migration' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'schedule_migration' }])])
	rt.call_function('add_action', [rt.new_string('load-tools_page_action-scheduler'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hook_admin_notices' }]), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hook_admin_notices' }]), rt.new_int(10), rt.new_int(0)])
}

fn (mut this Class_Action_Scheduler_Migration_Controller) maybe_hook_migration()  {
	if rt.is_true(rt.new_bool(!(this.allow_migration()) || rt.is_true(fn () rt.PhpVal { mut temp := Class_ActionScheduler_DataController{}; return temp.is_migration_complete() }()))) {
		return rt.new_null()
	}
	rt.call_method(this.migration_scheduler, 'hook', []rt.PhpVal{})
}

fn (mut this Class_Action_Scheduler_Migration_Controller) allow_migration() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_ActionScheduler_DataController{}; return temp.dependencies_met() }())))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), this.migrate_custom_store)) {
		this.migrate_custom_store = rt.call_function('apply_filters', [rt.new_string('action_scheduler_migrate_data_store'), rt.new_bool(false)])
	}
	return rt.is_true(rt.new_bool(!(rt.is_true(this.has_custom_datastore())))) || rt.is_true(this.migrate_custom_store)
}

fn Class_Action_Scheduler_Migration_Controller.init()  {
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_ActionScheduler_DataController{}; return temp.dependencies_met() }()) {
		rt.call_method(Class_Action_Scheduler_Migration_Controller.instance(), 'hook', []rt.PhpVal{})
	}
}

fn Class_Action_Scheduler_Migration_Controller.instance() rt.PhpVal {
	if !(!(// unsupported expression: Expr_StaticPropertyFetch).is_null()) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_ActionScheduler_DataController {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_LoggerSchema {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_StoreSchema {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_ActionScheduler_wpPostStore {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_ActionScheduler_wpCommentLogger {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Config {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_ActionScheduler_DBLogger {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_ProgressBar {
	rt.PhpObjectBase
}

fn create_action_scheduler_migration_controller(arg_0 rt.PhpVal) &Class_Action_Scheduler_Migration_Controller {
	mut obj := &Class_Action_Scheduler_Migration_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		migration_scheduler: rt.new_null()
		store_classname: rt.new_null()
		logger_classname: rt.new_null()
		migrate_custom_store: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_actionscheduler_datacontroller() &Class_ActionScheduler_DataController {
	mut obj := &Class_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionscheduler_store() &Class_Action_Scheduler_Migration_ActionScheduler_Store {
	mut obj := &Class_Action_Scheduler_Migration_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_loggerschema() &Class_ActionScheduler_LoggerSchema {
	mut obj := &Class_ActionScheduler_LoggerSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_storeschema() &Class_ActionScheduler_StoreSchema {
	mut obj := &Class_ActionScheduler_StoreSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionscheduler_wppoststore() &Class_Action_Scheduler_Migration_ActionScheduler_wpPostStore {
	mut obj := &Class_Action_Scheduler_Migration_ActionScheduler_wpPostStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionscheduler_wpcommentlogger() &Class_Action_Scheduler_Migration_ActionScheduler_wpCommentLogger {
	mut obj := &Class_Action_Scheduler_Migration_ActionScheduler_wpCommentLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_config() &Class_Action_Scheduler_Migration_Config {
	mut obj := &Class_Action_Scheduler_Migration_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionscheduler_dbstoremigrator() &Class_Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator {
	mut obj := &Class_Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionscheduler_dblogger() &Class_Action_Scheduler_Migration_ActionScheduler_DBLogger {
	mut obj := &Class_Action_Scheduler_Migration_ActionScheduler_DBLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_progressbar() &Class_Action_Scheduler_WP_CLI_ProgressBar {
	mut obj := &Class_Action_Scheduler_WP_CLI_ProgressBar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_Migration_Scheduler](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_store_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_store_class(dispatch_arg_0))
		}
		'get_logger_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_logger_class(dispatch_arg_0)
		}
		'has_custom_datastore' {
			return this.has_custom_datastore()
		}
		'schedule_migration' {
			this.schedule_migration()
			return rt.new_null()
		}
		'get_migration_config_object' {
			return this.get_migration_config_object()
		}
		'hook_admin_notices' {
			this.hook_admin_notices()
			return rt.new_null()
		}
		'display_migration_notice' {
			this.display_migration_notice()
			return rt.new_null()
		}
		'hook' {
			this.hook()
			return rt.new_null()
		}
		'maybe_hook_migration' {
			this.maybe_hook_migration()
			return rt.new_null()
		}
		'allow_migration' {
			return rt.new_bool(this.allow_migration())
		}
		'init' {
			Class_Action_Scheduler_Migration_Controller.init()
			return rt.new_null()
		}
		'instance' {
			return Class_Action_Scheduler_Migration_Controller.instance()
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_Migration_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'migration_scheduler' { return this.migration_scheduler }
		'store_classname' { return this.store_classname }
		'logger_classname' { return this.logger_classname }
		'migrate_custom_store' { return this.migrate_custom_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'migration_scheduler' { this.migration_scheduler = val; return true }
		'store_classname' { this.store_classname = val; return true }
		'logger_classname' { this.logger_classname = val; return true }
		'migrate_custom_store' { this.migrate_custom_store = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_DataController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_LoggerSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_LoggerSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_StoreSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_StoreSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_StoreSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_wpPostStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionScheduler_wpPostStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_wpPostStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_wpCommentLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionScheduler_wpCommentLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_wpCommentLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_DBLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionScheduler_DBLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_DBLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_ProgressBar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Action_Scheduler_Migration_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_action_scheduler_migration_controller(c_arg_0)
		return rt.new_object('Action_Scheduler_Migration_Controller', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_DataController', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_datacontroller()
		return rt.new_object('ActionScheduler_DataController', []string{}, obj)
	})
	rt.register_class_factory('Action_Scheduler_Migration_ActionScheduler_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_action_scheduler_migration_actionscheduler_store()
		return rt.new_object('Action_Scheduler_Migration_ActionScheduler_Store', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_LoggerSchema', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_loggerschema()
		return rt.new_object('ActionScheduler_LoggerSchema', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_StoreSchema', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_storeschema()
		return rt.new_object('ActionScheduler_StoreSchema', []string{}, obj)
	})
	rt.register_class_factory('Action_Scheduler_Migration_ActionScheduler_wpPostStore', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_action_scheduler_migration_actionscheduler_wppoststore()
		return rt.new_object('Action_Scheduler_Migration_ActionScheduler_wpPostStore', []string{}, obj)
	})
	rt.register_class_factory('Action_Scheduler_Migration_ActionScheduler_wpCommentLogger', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_action_scheduler_migration_actionscheduler_wpcommentlogger()
		return rt.new_object('Action_Scheduler_Migration_ActionScheduler_wpCommentLogger', []string{}, obj)
	})
	rt.register_class_factory('Action_Scheduler_Migration_Config', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_action_scheduler_migration_config()
		return rt.new_object('Action_Scheduler_Migration_Config', []string{}, obj)
	})
	rt.register_class_factory('Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_action_scheduler_migration_actionscheduler_dbstoremigrator()
		return rt.new_object('Action_Scheduler_Migration_ActionScheduler_DBStoreMigrator', []string{}, obj)
	})
	rt.register_class_factory('Action_Scheduler_Migration_ActionScheduler_DBLogger', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_action_scheduler_migration_actionscheduler_dblogger()
		return rt.new_object('Action_Scheduler_Migration_ActionScheduler_DBLogger', []string{}, obj)
	})
	rt.register_class_factory('Action_Scheduler_WP_CLI_ProgressBar', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_action_scheduler_wp_cli_progressbar()
		return rt.new_object('Action_Scheduler_WP_CLI_ProgressBar', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_migration_controller_php() {
}
