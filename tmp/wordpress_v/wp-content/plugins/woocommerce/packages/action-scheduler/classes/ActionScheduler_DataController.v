import rt

pub fn Class_ActionScheduler_DataController.datastore_class() string {
	return 'ActionScheduler_DBStore'
}
pub fn Class_ActionScheduler_DataController.logger_class() string {
	return 'ActionScheduler_DBLogger'
}
pub fn Class_ActionScheduler_DataController.status_flag() string {
	return 'action_scheduler_migration_status'
}
pub fn Class_ActionScheduler_DataController.status_complete() string {
	return 'complete'
}
pub fn Class_ActionScheduler_DataController.min_php_version() string {
	return '5.5'
}
struct Class_ActionScheduler_DataController {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		sleep_time rt.PhpVal = rt.new_int(0)
		free_ticks rt.PhpVal = rt.new_int(50)
}

fn Class_ActionScheduler_DataController.dependencies_met() bool {
	mut var_php_support := rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), Class_ActionScheduler_DataController.min_php_version(), rt.new_string('>=')])
	return rt.is_true(var_php_support) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('action_scheduler_migration_dependencies_met'), rt.new_bool(true)]))
}

fn Class_ActionScheduler_DataController.is_migration_complete() rt.PhpVal {
	return rt.identical(rt.call_function('get_option', [Class_ActionScheduler_DataController.status_flag()]), Class_ActionScheduler_DataController.status_complete())
}

fn Class_ActionScheduler_DataController.mark_migration_complete()  {
	rt.call_function('update_option', [Class_ActionScheduler_DataController.status_flag(), Class_ActionScheduler_DataController.status_complete()])
}

fn Class_ActionScheduler_DataController.mark_migration_incomplete()  {
	rt.call_function('delete_option', [Class_ActionScheduler_DataController.status_flag()])
}

fn Class_ActionScheduler_DataController.set_store_class(var_class rt.PhpVal) string {
	return Class_ActionScheduler_DataController.datastore_class()
}

fn Class_ActionScheduler_DataController.set_logger_class(var_class rt.PhpVal) string {
	return Class_ActionScheduler_DataController.logger_class()
}

fn Class_ActionScheduler_DataController.set_sleep_time(var_sleep_time rt.PhpVal)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_ActionScheduler_DataController.set_free_ticks(var_free_ticks rt.PhpVal)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_ActionScheduler_DataController.maybe_free_memory(var_ticks rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) && rt.is_true(rt.identical(rt.new_int(0), rt.mod_(var_ticks, // unsupported expression: Expr_StaticPropertyFetch))))) {
		Class_ActionScheduler_DataController.free_memory()
	}
}

fn Class_ActionScheduler_DataController.free_memory()  {
	mut var_wpdb := rt.new_null()
	mut var_wp_object_cache := rt.new_null()
	if rt.is_true(rt.less(rt.new_int(0), // unsupported expression: Expr_StaticPropertyFetch)) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Stopped the insanity for %d second'), rt.new_string('Stopped the insanity for %d seconds'), // unsupported expression: Expr_StaticPropertyFetch, rt.new_string('woocommerce')]), // unsupported expression: Expr_StaticPropertyFetch]))
		rt.call_function('sleep', [// unsupported expression: Expr_StaticPropertyFetch])
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('__', [rt.new_string('Attempting to reduce used memory...'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_Global
	rt.set_property(var_wpdb, 'queries', rt.new_array())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_wp_object_cache.dup(), rt.new_string('WP_Object_Cache')]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.dup(), rt.new_string('group_ops')])) {
		rt.set_property(var_wp_object_cache, 'group_ops', rt.new_array())
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.dup(), rt.new_string('stats')])) {
		rt.set_property(var_wp_object_cache, 'stats', rt.new_array())
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.dup(), rt.new_string('memcache_debug')])) {
		rt.set_property(var_wp_object_cache, 'memcache_debug', rt.new_array())
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.dup(), rt.new_string('cache')])) {
		rt.set_property(var_wp_object_cache, 'cache', rt.new_array())
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_wp_object_cache }, rt.ArrayItem{ key: none, val: '__remoteset' }])])) {
		rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: var_wp_object_cache }, rt.ArrayItem{ key: none, val: '__remoteset' }])])
		// unsupported statement: Stmt_Nop
	}
}

fn Class_ActionScheduler_DataController.init()  {
	if rt.is_true(Class_ActionScheduler_DataController.is_migration_complete()) {
		rt.call_function('add_filter', [rt.new_string('action_scheduler_store_class'), rt.create_array([rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' }, rt.ArrayItem{ key: none, val: 'set_store_class' }]), rt.new_int(100)])
		rt.call_function('add_filter', [rt.new_string('action_scheduler_logger_class'), rt.create_array([rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' }, rt.ArrayItem{ key: none, val: 'set_logger_class' }]), rt.new_int(100)])
		rt.call_function('add_action', [rt.new_string('deactivate_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' }, rt.ArrayItem{ key: none, val: 'mark_migration_incomplete' }])])
	} else if rt.is_true(Class_ActionScheduler_DataController.dependencies_met()) {
		fn () rt.PhpVal { mut temp := Class_Action_Scheduler_Migration_Controller{}; return temp.init() }()
	}
	rt.call_function('add_action', [rt.new_string('action_scheduler/progress_tick'), rt.create_array([rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' }, rt.ArrayItem{ key: none, val: 'maybe_free_memory' }])])
}

fn Class_ActionScheduler_DataController.instance() rt.PhpVal {
	if !(!(// unsupported expression: Expr_StaticPropertyFetch).is_null()) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Controller {
	rt.PhpObjectBase
}

fn create_actionscheduler_datacontroller() &Class_ActionScheduler_DataController {
	mut obj := &Class_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		sleep_time: rt.new_int(0)
		free_ticks: rt.new_int(50)
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_controller() &Class_Action_Scheduler_Migration_Controller {
	mut obj := &Class_Action_Scheduler_Migration_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_DataController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'dependencies_met' {
			return rt.new_bool(Class_ActionScheduler_DataController.dependencies_met())
		}
		'is_migration_complete' {
			return Class_ActionScheduler_DataController.is_migration_complete()
		}
		'mark_migration_complete' {
			Class_ActionScheduler_DataController.mark_migration_complete()
			return rt.new_null()
		}
		'mark_migration_incomplete' {
			Class_ActionScheduler_DataController.mark_migration_incomplete()
			return rt.new_null()
		}
		'set_store_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ActionScheduler_DataController.set_store_class(dispatch_arg_0))
		}
		'set_logger_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ActionScheduler_DataController.set_logger_class(dispatch_arg_0))
		}
		'set_sleep_time' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ActionScheduler_DataController.set_sleep_time(dispatch_arg_0)
			return rt.new_null()
		}
		'set_free_ticks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ActionScheduler_DataController.set_free_ticks(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_free_memory' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ActionScheduler_DataController.maybe_free_memory(dispatch_arg_0)
			return rt.new_null()
		}
		'free_memory' {
			Class_ActionScheduler_DataController.free_memory()
			return rt.new_null()
		}
		'init' {
			Class_ActionScheduler_DataController.init()
			return rt.new_null()
		}
		'instance' {
			return Class_ActionScheduler_DataController.instance()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'sleep_time' { return this.sleep_time }
		'free_ticks' { return this.free_ticks }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'sleep_time' { this.sleep_time = val; return true }
		'free_ticks' { this.free_ticks = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_datacontroller_php() {
}
