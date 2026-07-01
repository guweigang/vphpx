import rt

struct Class_Automattic_WooCommerce_Blueprint_Logger {
	rt.PhpObjectBase
pub mut:
	logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) construct() {
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) log(message string, level string, var_context rt.PhpVal) {
	rt.call_method(this.logger, 'log', [rt.new_string(level),
		rt.new_string(message),
		rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-blueprint' },
				rt.ArrayItem{ key: 'user_id', val: this.wp_get_current_user_id() }]),
			var_context.dup(),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) start_export(mut var_exporters Class_Automattic_WooCommerce_Blueprint_array) {
	mut var_export_data := this.get_export_data(mut var_exporters)
	this.log((rt.call_function('sprintf', [rt.new_string('Starting export of %d steps'),
		rt.new_int(var_export_data.array_get('steps').array_count())])).str(),
		(Class_Automattic_WooCommerce_Blueprint_WC_Log_Levels.info()).str(), rt.create_array([
		rt.ArrayItem{ key: 'steps', val: var_export_data.array_get('steps') },
		rt.ArrayItem{ key: 'exporters', val: var_export_data.array_get('exporters') },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) complete_export(mut var_exporters Class_Automattic_WooCommerce_Blueprint_array) {
	mut var_export_data := this.get_export_data(mut var_exporters)
	this.log((rt.call_function('sprintf', [rt.new_string('Export of %d steps completed'),
		rt.new_int(var_export_data.array_get('steps').array_count())])).str(),
		(Class_Automattic_WooCommerce_Blueprint_WC_Log_Levels.info()).str(), rt.create_array([
		rt.ArrayItem{ key: 'steps', val: var_export_data.array_get('steps') },
		rt.ArrayItem{ key: 'exporters', val: var_export_data.array_get('exporters') },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) get_export_data(mut var_exporters Class_Automattic_WooCommerce_Blueprint_array) rt.PhpVal {
	mut var_export_steps := rt.new_array()
	mut var_exporter_classes := rt.new_array()
	{
		mut iter_1 := var_exporters.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_exporter := item_1.val
			mut var_step_name := if rt.is_true(rt.call_function('method_exists', [
				var_exporter.dup(),
				rt.new_string('get_alias'),
			]))
			{
				rt.call_method(var_exporter, 'get_alias', []rt.PhpVal{})
			} else {
				rt.call_method(var_exporter, 'get_step_name', []rt.PhpVal{})
			}
			var_export_steps.array_push(var_step_name.dup())
			var_exporter_classes.array_push(rt.call_function('get_class', [
				var_exporter.dup()]))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'steps', val: var_export_steps },
		rt.ArrayItem{ key: 'exporters', val: var_exporter_classes }])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) export_step_failed(step_name string, mut var_exception Class_Automattic_WooCommerce_Blueprint_Throwable) {
	mut step_name_mutated := step_name
	this.log((rt.call_function('sprintf', [rt.new_string('Export "%s" step failed'),
		rt.new_string(step_name_mutated).dup()])).str(),
		(Class_Automattic_WooCommerce_Blueprint_WC_Log_Levels.error()).str(), rt.create_array([
		rt.ArrayItem{ key: 'error', val: var_exception.getmessage() },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) start_import(step_name string, importer_class string) {
	mut step_name_mutated := step_name
	this.log((rt.call_function('sprintf', [rt.new_string('Starting import "%s" step'),
		rt.new_string(step_name_mutated).dup()])).str(),
		(Class_Automattic_WooCommerce_Blueprint_WC_Log_Levels.info()).str(), rt.create_array([
		rt.ArrayItem{ key: 'importer', val: importer_class },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) complete_import(step_name string, mut var_result Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) {
	mut step_name_mutated := step_name
	this.log((rt.call_function('sprintf', [rt.new_string('Import "%s" step completed'),
		rt.new_string(step_name_mutated).dup()])).str(),
		(Class_Automattic_WooCommerce_Blueprint_WC_Log_Levels.info()).str(), rt.create_array([
		rt.ArrayItem{ key: 'messages', val: var_result.get_messages(rt.new_string('info')) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) import_step_failed(step_name string, mut var_result Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) {
	mut step_name_mutated := step_name
	this.log((rt.call_function('sprintf', [rt.new_string('Import "%s" step failed'),
		rt.new_string(step_name_mutated).dup()])).str(),
		(Class_Automattic_WooCommerce_Blueprint_WC_Log_Levels.error()).str(), rt.create_array([
		rt.ArrayItem{ key: 'messages', val: var_result.get_messages(rt.new_string('error')) },
	]))
}

fn create_automattic_woocommerce_blueprint_logger() &Class_Automattic_WooCommerce_Blueprint_Logger {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
		logger:        rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'log' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.log(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'start_export' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.start_export(mut dispatch_arg_0)
			return rt.new_null()
		}
		'complete_export' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.complete_export(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_export_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_export_data(mut dispatch_arg_0)
		}
		'export_step_failed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Throwable](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.export_step_failed(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'start_import' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.start_import(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'complete_import' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_StepProcessorResult](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.complete_import(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'import_step_failed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_StepProcessorResult](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.import_step_failed(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' {
			this.logger = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_logger_php() {
}
