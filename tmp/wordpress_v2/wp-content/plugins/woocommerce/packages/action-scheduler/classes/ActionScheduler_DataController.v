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
}

fn init_static_actionscheduler_datacontroller() {
	rt.init_static_prop('ActionScheduler_DataController', 'instance', rt.new_null())
	rt.init_static_prop('ActionScheduler_DataController', 'sleep_time', rt.new_int(0))
	rt.init_static_prop('ActionScheduler_DataController', 'free_ticks', rt.new_int(50))
}

fn Class_ActionScheduler_DataController.dependencies_met() bool {
	mut var_php_support := rt.call_function('version_compare', [
		rt.get_constant('PHP_VERSION'),
		rt.new_string(Class_ActionScheduler_DataController.min_php_version()),
		rt.new_string('>='),
	])
	return rt.is_true(var_php_support)
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('action_scheduler_migration_dependencies_met'), rt.new_bool(true)]))
}

fn Class_ActionScheduler_DataController.is_migration_complete() rt.PhpVal {
	return rt.identical(rt.call_function('get_option', [
		rt.new_string(Class_ActionScheduler_DataController.status_flag()),
	]), Class_ActionScheduler_DataController.status_complete())
}

fn Class_ActionScheduler_DataController.mark_migration_complete() {
	rt.call_function('update_option', [
		rt.new_string(Class_ActionScheduler_DataController.status_flag()),
		rt.new_string(Class_ActionScheduler_DataController.status_complete()),
	])
}

fn Class_ActionScheduler_DataController.mark_migration_incomplete() {
	rt.call_function('delete_option', [
		rt.new_string(Class_ActionScheduler_DataController.status_flag()),
	])
}

fn Class_ActionScheduler_DataController.set_store_class(var_class rt.PhpVal) string {
	return Class_ActionScheduler_DataController.datastore_class()
}

fn Class_ActionScheduler_DataController.set_logger_class(var_class rt.PhpVal) string {
	return Class_ActionScheduler_DataController.logger_class()
}

fn Class_ActionScheduler_DataController.set_sleep_time(var_sleep_time rt.PhpVal) {
	rt.set_static_prop('ActionScheduler_DataController', 'sleep_time',
		rt.new_int(var_sleep_time.to_i64()))
}

fn Class_ActionScheduler_DataController.set_free_ticks(var_free_ticks rt.PhpVal) {
	rt.set_static_prop('ActionScheduler_DataController', 'free_ticks',
		rt.new_int(var_free_ticks.to_i64()))
}

fn Class_ActionScheduler_DataController.maybe_free_memory(var_ticks rt.PhpVal) {
	if rt.is_true(rt.get_static_prop('ActionScheduler_DataController', 'free_ticks'))
		&& rt.is_true(rt.identical(rt.new_int(0), rt.mod_(var_ticks, rt.get_static_prop('ActionScheduler_DataController', 'free_ticks')))) {
		Class_ActionScheduler_DataController.free_memory()
	}
}

fn Class_ActionScheduler_DataController.free_memory() {
	mut var_wpdb := rt.new_null()
	mut var_wp_object_cache := rt.new_null()
	if rt.is_true(rt.less(rt.new_int(0), rt.get_static_prop('ActionScheduler_DataController',
		'sleep_time')))
	{
		mut iife_temp_0 := Class_WP_CLI{}
		mut iife_result_0 := iife_temp_0.warning(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('Stopped the insanity for %d second'),
				rt.new_string('Stopped the insanity for %d seconds'),
				rt.get_static_prop('ActionScheduler_DataController', 'sleep_time'),
				rt.new_string('woocommerce')]),
			rt.get_static_prop('ActionScheduler_DataController', 'sleep_time'),
		]))
		rt.call_function('sleep', [
			rt.get_static_prop('ActionScheduler_DataController', 'sleep_time'),
		])
	}
	mut iife_temp_1 := Class_WP_CLI{}
	mut iife_result_1 := iife_temp_1.warning(rt.call_function('__', [
		rt.new_string('Attempting to reduce used memory...'),
		rt.new_string('woocommerce'),
	]))
	rt.set_property(var_wpdb, 'queries', rt.new_array())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_wp_object_cache.clone(), rt.new_string('WP_Object_Cache')])))))
	{
		return
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.clone(),
		rt.new_string('group_ops')]))
	{
		rt.set_property(var_wp_object_cache, 'group_ops', rt.new_array())
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.clone(),
		rt.new_string('stats')]))
	{
		rt.set_property(var_wp_object_cache, 'stats', rt.new_array())
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.clone(),
		rt.new_string('memcache_debug')]))
	{
		rt.set_property(var_wp_object_cache, 'memcache_debug', rt.new_array())
	}
	if rt.is_true(rt.call_function('property_exists', [var_wp_object_cache.clone(),
		rt.new_string('cache')]))
	{
		rt.set_property(var_wp_object_cache, 'cache', rt.new_array())
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_wp_object_cache },
			rt.ArrayItem{ key: none, val: '__remoteset' }]),
	]))
	{
		rt.call_function('call_user_func', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_wp_object_cache },
				rt.ArrayItem{ key: none, val: '__remoteset' }]),
		])
	}
}

fn Class_ActionScheduler_DataController.init() {
	if rt.is_true(Class_ActionScheduler_DataController.is_migration_complete()) {
		rt.call_function('add_filter', [rt.new_string('action_scheduler_store_class'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' },
				rt.ArrayItem{ key: none, val: 'set_store_class' },
			]),
			rt.new_int(100)])
		rt.call_function('add_filter', [rt.new_string('action_scheduler_logger_class'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' },
				rt.ArrayItem{ key: none, val: 'set_logger_class' },
			]),
			rt.new_int(100)])
		rt.call_function('add_action', [rt.new_string('deactivate_plugin'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' },
				rt.ArrayItem{ key: none, val: 'mark_migration_incomplete' },
			])])
	} else if rt.is_true(Class_ActionScheduler_DataController.dependencies_met()) {
		mut iife_temp_2 := Class_Action_Scheduler_Migration_Controller{}
		mut iife_result_2 := iife_temp_2.init()
	}
	rt.call_function('add_action', [rt.new_string('action_scheduler/progress_tick'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'ActionScheduler_DataController' },
			rt.ArrayItem{ key: none, val: 'maybe_free_memory' },
		])])
}

fn Class_ActionScheduler_DataController.instance() rt.PhpVal {
	if !(!(rt.get_static_prop('ActionScheduler_DataController', 'instance')).is_null()) {
		rt.set_static_prop('ActionScheduler_DataController', 'instance', rt.new_object('ActionScheduler_DataController',
			[]string{}, create_actionscheduler_datacontroller()))
	}
	return rt.get_static_prop('ActionScheduler_DataController', 'instance')
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Controller {
	rt.PhpObjectBase
}

fn create_actionscheduler_datacontroller(_args ...rt.PhpVal) &Class_ActionScheduler_DataController {
	mut obj := &Class_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_controller(_args ...rt.PhpVal) &Class_Action_Scheduler_Migration_Controller {
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
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
