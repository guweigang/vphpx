import rt

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

fn init_static_actionscheduler() {
		rt.init_static_prop('ActionScheduler', 'plugin_file', rt.new_string(''))
		rt.init_static_prop('ActionScheduler', 'factory', rt.new_null())
		rt.init_static_prop('ActionScheduler', 'data_store_initialized', rt.new_bool(false))
}

fn Class_ActionScheduler.factory() rt.PhpVal {
	if !(!(rt.get_static_prop('ActionScheduler', 'factory')).is_null()) {
		rt.set_static_prop('ActionScheduler', 'factory', rt.new_object('ActionScheduler_ActionFactory', []string{}, create_actionscheduler_actionfactory()))
	}
	return rt.get_static_prop('ActionScheduler', 'factory')
}

fn Class_ActionScheduler.store() rt.PhpVal {
	mut iife_temp_0 := Class_ActionScheduler_Store{}
	mut iife_result_0 := iife_temp_0.instance()
	return iife_result_0
}

fn Class_ActionScheduler.lock() rt.PhpVal {
	mut iife_temp_1 := Class_ActionScheduler_Lock{}
	mut iife_result_1 := iife_temp_1.instance()
	return iife_result_1
}

fn Class_ActionScheduler.logger() rt.PhpVal {
	mut iife_temp_2 := Class_ActionScheduler_Logger{}
	mut iife_result_2 := iife_temp_2.instance()
	return iife_result_2
}

fn Class_ActionScheduler.runner() rt.PhpVal {
	mut iife_temp_3 := Class_ActionScheduler_QueueRunner{}
	mut iife_result_3 := iife_temp_3.instance()
	return iife_result_3
}

fn Class_ActionScheduler.admin_view() rt.PhpVal {
	mut iife_temp_4 := Class_ActionScheduler_AdminView{}
	mut iife_result_4 := iife_temp_4.instance()
	return iife_result_4
}

fn Class_ActionScheduler.plugin_path(var_path rt.PhpVal) string {
	mut var_base := rt.call_function('dirname', [rt.get_static_prop('ActionScheduler', 'plugin_file')])
	if rt.is_true(var_path) {
		return (rt.call_function('trailingslashit', [var_base.clone()])).str() + (var_path).str()
	} else {
		return (rt.call_function('untrailingslashit', [var_base.clone()])).str()
	}
	return ''
}

fn Class_ActionScheduler.plugin_url(var_path rt.PhpVal) rt.PhpVal {
	return rt.call_function('plugins_url', [var_path.clone(), rt.get_static_prop('ActionScheduler', 'plugin_file')])
}

fn Class_ActionScheduler.autoload(var_class rt.PhpVal) {
	mut var_class_mutated := var_class
	mut var_d := rt.get_constant('DIRECTORY_SEPARATOR')
	mut var_classes_dir := Class_ActionScheduler.plugin_path(rt.new_string('classes' + (var_d).str()))
	mut var_separator := rt.call_function('strrpos', [var_class_mutated.clone(), rt.new_string('\\')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_separator)))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.clone(), rt.new_string('Action_Scheduler')]))))) {
			return
		}
	var_class_mutated = rt.call_function('substr', [var_class_mutated.clone(), rt.add(var_separator, rt.new_int(1))])
	}
	if rt.is_true(rt.identical(rt.new_string('Deprecated'), rt.call_function('substr', [var_class_mutated.clone(), rt.new_int(-10)]))) {
	mut var_dir := Class_ActionScheduler.plugin_path(rt.new_string('deprecated' + (var_d).str()))
	} else if rt.is_true(Class_ActionScheduler.is_class_abstract(var_class_mutated.clone())) {
	var_dir = rt.new_string((var_classes_dir).str() + 'abstracts' + (var_d).str())
	} else if rt.is_true(Class_ActionScheduler.is_class_migration(var_class_mutated.clone())) {
	var_dir = rt.new_string((var_classes_dir).str() + 'migration' + (var_d).str())
	} else if rt.is_true(rt.identical(rt.new_string('Schedule'), rt.call_function('substr', [var_class_mutated.clone(), rt.new_int(-8)]))) {
	var_dir = rt.new_string((var_classes_dir).str() + 'schedules' + (var_d).str())
	} else if rt.is_true(rt.identical(rt.new_string('Action'), rt.call_function('substr', [var_class_mutated.clone(), rt.new_int(-6)]))) {
	var_dir = rt.new_string((var_classes_dir).str() + 'actions' + (var_d).str())
	} else if rt.is_true(rt.identical(rt.new_string('Schema'), rt.call_function('substr', [var_class_mutated.clone(), rt.new_int(-6)]))) {
	var_dir = rt.new_string((var_classes_dir).str() + 'schema' + (var_d).str())
	} else if rt.is_true(rt.identical(rt.call_function('strpos', [var_class_mutated.clone(), rt.new_string('ActionScheduler')]), rt.new_int(0))) {
		mut var_segments := rt.call_function('explode', [rt.new_string('_'), var_class_mutated.clone()])
		mut var_type := if var_segments.array_isset(rt.new_int(1)) { var_segments.array_get(rt.new_int(1)) } else { rt.new_string('') }
		mut switch_val_1 := var_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('WPCLI'))) {
		var_dir = rt.new_string((var_classes_dir).str() + 'WP_CLI' + (var_d).str())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('DBLogger'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('DBStore'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('HybridStore'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('wpPostStore'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('wpCommentLogger'))) {
		var_dir = rt.new_string((var_classes_dir).str() + 'data-stores' + (var_d).str())
		} else {
		var_dir = var_classes_dir.clone()
		}
	} else if rt.is_true(Class_ActionScheduler.is_class_cli(var_class_mutated.clone())) {
	var_dir = rt.new_string((var_classes_dir).str() + 'WP_CLI' + (var_d).str())
	} else if rt.is_true(rt.identical(rt.call_function('strpos', [var_class_mutated.clone(), rt.new_string('CronExpression')]), rt.new_int(0))) {
	var_dir = Class_ActionScheduler.plugin_path(rt.new_string('lib' + (var_d).str() + 'cron-expression' + (var_d).str()))
	} else if rt.is_true(rt.identical(rt.call_function('strpos', [var_class_mutated.clone(), rt.new_string('WP_Async_Request')]), rt.new_int(0))) {
	var_dir = Class_ActionScheduler.plugin_path(rt.new_string('lib' + (var_d).str()))
	} else {
		return
	}
	if rt.is_true(rt.call_function('file_exists', [rt.new_string((var_dir).str() + "${var_class.to_string()}.php")])) {
		rt.include_file((var_dir).str() + "${var_class.to_string()}.php", '1')
		return
	}
}

fn Class_ActionScheduler.init(var_plugin_file rt.PhpVal) {
	rt.set_static_prop('ActionScheduler', 'plugin_file', var_plugin_file.clone())
	rt.call_function('spl_autoload_register', [rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'autoload' }])])
	rt.call_function('do_action', [rt.new_string('action_scheduler_pre_init')])
	rt.include_file((Class_ActionScheduler.plugin_path(rt.new_string('functions.php'))).to_string(), '4')
	mut iife_temp_5 := Class_ActionScheduler_DataController{}
	mut iife_result_5 := iife_temp_5.init()
	mut var_store := Class_ActionScheduler.store()
	mut var_logger := Class_ActionScheduler.logger()
	mut var_runner := Class_ActionScheduler.runner()
	mut var_admin_view := Class_ActionScheduler.admin_view()
	mut var_recurring_action_scheduler := create_actionscheduler_recurringactionscheduler()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))))) {
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: var_admin_view }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(0), rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: var_store }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(1), rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: var_logger }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(1), rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: var_runner }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(1), rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: var_recurring_action_scheduler }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(1), rt.new_int(0)])
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.set_static_prop('ActionScheduler', 'data_store_initialized', rt.new_bool(true))
			rt.call_function('do_action', [rt.new_string('action_scheduler_init')])
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('init'), rt.new_closure(closure_7_fn), rt.new_int(1)])
	} else {
		rt.call_method(var_admin_view, 'init', []rt.PhpVal{})
		rt.call_method(var_store, 'init', []rt.PhpVal{})
		rt.call_method(var_logger, 'init', []rt.PhpVal{})
		rt.call_method(var_runner, 'init', []rt.PhpVal{})
		var_recurring_action_scheduler.init()
		rt.set_static_prop('ActionScheduler', 'data_store_initialized', rt.new_bool(true))
		rt.call_function('do_action', [rt.new_string('action_scheduler_init')])
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('action_scheduler_load_deprecated_functions'), rt.new_bool(true)])) {
		rt.include_file((Class_ActionScheduler.plugin_path(rt.new_string('deprecated/functions.php'))).to_string(), '4')
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI')) {
		mut iife_temp_7 := Class_WP_CLI{}
		mut iife_result_7 := iife_temp_7.add_command(rt.new_string('action-scheduler'), rt.new_string('ActionScheduler_WPCLI_Scheduler_command'))
		mut iife_temp_8 := Class_WP_CLI{}
		mut iife_result_8 := iife_temp_8.add_command(rt.new_string('action-scheduler'), rt.new_string('ActionScheduler_WPCLI_Clean_Command'))
		mut iife_temp_9 := Class_WP_CLI{}
		mut iife_result_9 := iife_temp_9.add_command(rt.new_string('action-scheduler action'), rt.new_string('\\Action_Scheduler\\WP_CLI\\Action_Command'))
		mut iife_temp_10 := Class_WP_CLI{}
		mut iife_result_10 := iife_temp_10.add_command(rt.new_string('action-scheduler'), rt.new_string('\\Action_Scheduler\\WP_CLI\\System_Command'))
		mut iife_temp_11 := Class_ActionScheduler_DataController{}
		mut iife_result_11 := iife_temp_11.is_migration_complete()
		mut iife_temp_12 := Class_Action_Scheduler_Migration_Controller{}
		mut iife_result_12 := iife_temp_12.instance()
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_11)))) && rt.is_true(rt.call_method(iife_result_12, 'allow_migration', []rt.PhpVal{})) {
			mut var_command := create_action_scheduler_wp_cli_migration_command()
			var_command.register()
		}
	}
	mut iife_temp_13 := Class_ActionScheduler_DataController{}
	mut iife_result_13 := iife_temp_13.is_migration_complete()
	mut iife_temp_14 := Class_ActionScheduler_WPCommentCleaner{}
	mut iife_result_14 := iife_temp_14.has_logs()
	if rt.is_true(rt.call_function('is_a', [var_logger.clone(), rt.new_string('ActionScheduler_DBLogger')])) && rt.is_true(iife_result_13) && rt.is_true(iife_result_14) {
	mut iife_temp_15 := Class_ActionScheduler_WPCommentCleaner{}
	mut iife_result_15 := iife_temp_15.init()
	}
	rt.call_function('add_action', [rt.new_string('action_scheduler/migration_complete'), rt.new_string('ActionScheduler_WPCommentCleaner::maybe_schedule_cleanup')])
}

fn Class_ActionScheduler.is_initialized(var_function_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('ActionScheduler', 'data_store_initialized'))))) && !(!rt.is_true(var_function_name)) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s() was called before the Action Scheduler data store was initialized'), rt.new_string('woocommerce')]), rt.call_function('esc_attr', [var_function_name.clone()])])
		rt.call_function('_doing_it_wrong', [rt.call_function('esc_html', [var_function_name.clone()]), rt.call_function('esc_html', [var_message.clone()]), rt.new_string('3.1.6')])
	}
	return rt.get_static_prop('ActionScheduler', 'data_store_initialized')
}

fn Class_ActionScheduler.is_class_abstract(var_class rt.PhpVal) bool {
	mut var_abstracts := rt.new_null()
	mut var_class_mutated := var_class
	return var_abstracts.array_isset(var_class_mutated) && rt.is_true(var_abstracts.array_get(var_class_mutated))
}

fn Class_ActionScheduler.is_class_migration(var_class rt.PhpVal) bool {
	mut var_migration_segments := rt.new_null()
	mut var_class_mutated := var_class
	mut var_segments := rt.call_function('explode', [rt.new_string('_'), var_class_mutated.clone()])
	mut var_segment := if var_segments.array_isset(rt.new_int(1)) { var_segments.array_get(rt.new_int(1)) } else { var_class_mutated }
	return var_migration_segments.array_isset(var_segment) && rt.is_true(var_migration_segments.array_get(var_segment))
}

fn Class_ActionScheduler.is_class_cli(var_class rt.PhpVal) bool {
	mut var_cli_segments := rt.new_null()
	mut var_class_mutated := var_class
	mut var_segments := rt.call_function('explode', [rt.new_string('_'), var_class_mutated.clone()])
	mut var_segment := if var_segments.array_isset(rt.new_int(1)) { var_segments.array_get(rt.new_int(1)) } else { var_class_mutated }
	return var_cli_segments.array_isset(var_segment) && rt.is_true(var_cli_segments.array_get(var_segment))
}

fn (mut this Class_ActionScheduler) magic_clone() {
	rt.call_function('trigger_error', [rt.new_string('Singleton. No cloning allowed!'), rt.get_constant('E_USER_ERROR')])
}

fn (mut this Class_ActionScheduler) magic_wakeup() {
	rt.call_function('trigger_error', [rt.new_string('Singleton. No serialization allowed!'), rt.get_constant('E_USER_ERROR')])
}

fn (mut this Class_ActionScheduler) construct() {
}

fn Class_ActionScheduler.get_datetime_object(var_when rt.PhpVal, timezone string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('2.0'), rt.new_string('wcs_add_months()')])
	return rt.call_function('as_get_datetime_object', [var_when.clone(), rt.new_string(timezone)])
}

fn Class_ActionScheduler.check_shutdown_hook(var_function_name rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.1.6')])
}

struct Class_ActionScheduler_ActionFactory {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Lock {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Logger {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_QueueRunner {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_AdminView {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_DataController {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_RecurringActionScheduler {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Controller {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Migration_Command {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_WPCommentCleaner {
	rt.PhpObjectBase
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_actionscheduler_actionfactory(_args ...rt.PhpVal) &Class_ActionScheduler_ActionFactory {
	mut obj := &Class_ActionScheduler_ActionFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_lock(_args ...rt.PhpVal) &Class_ActionScheduler_Lock {
	mut obj := &Class_ActionScheduler_Lock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_logger(_args ...rt.PhpVal) &Class_ActionScheduler_Logger {
	mut obj := &Class_ActionScheduler_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_queuerunner(_args ...rt.PhpVal) &Class_ActionScheduler_QueueRunner {
	mut obj := &Class_ActionScheduler_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_adminview(_args ...rt.PhpVal) &Class_ActionScheduler_AdminView {
	mut obj := &Class_ActionScheduler_AdminView{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_datacontroller(_args ...rt.PhpVal) &Class_ActionScheduler_DataController {
	mut obj := &Class_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_recurringactionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler_RecurringActionScheduler {
	mut obj := &Class_ActionScheduler_RecurringActionScheduler{
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

fn create_action_scheduler_wp_cli_migration_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Migration_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Migration_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_wpcommentcleaner(_args ...rt.PhpVal) &Class_ActionScheduler_WPCommentCleaner {
	mut obj := &Class_ActionScheduler_WPCommentCleaner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'factory' {
			return Class_ActionScheduler.factory()
		}
		'store' {
			return Class_ActionScheduler.store()
		}
		'lock' {
			return Class_ActionScheduler.lock()
		}
		'logger' {
			return Class_ActionScheduler.logger()
		}
		'runner' {
			return Class_ActionScheduler.runner()
		}
		'admin_view' {
			return Class_ActionScheduler.admin_view()
		}
		'plugin_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ActionScheduler.plugin_path(dispatch_arg_0))
		}
		'plugin_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ActionScheduler.plugin_url(dispatch_arg_0)
		}
		'autoload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ActionScheduler.autoload(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ActionScheduler.init(dispatch_arg_0)
			return rt.new_null()
		}
		'is_initialized' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ActionScheduler.is_initialized(dispatch_arg_0)
		}
		'is_class_abstract' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_ActionScheduler.is_class_abstract(dispatch_arg_0))
		}
		'is_class_migration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_ActionScheduler.is_class_migration(dispatch_arg_0))
		}
		'is_class_cli' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_ActionScheduler.is_class_cli(dispatch_arg_0))
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_datetime_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_ActionScheduler.get_datetime_object(dispatch_arg_0, dispatch_arg_1)
		}
		'check_shutdown_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_ActionScheduler.check_shutdown_hook(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_ActionFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_ActionFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_ActionFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Lock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Lock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Lock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_AdminView) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_AdminView) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_AdminView) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_ActionScheduler_RecurringActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_RecurringActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_RecurringActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Migration_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_WPCommentCleaner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_WPCommentCleaner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_WPCommentCleaner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
