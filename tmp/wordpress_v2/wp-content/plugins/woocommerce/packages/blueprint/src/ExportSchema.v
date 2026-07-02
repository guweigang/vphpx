import rt

struct Class_Automattic_WooCommerce_Blueprint_ExportSchema {
	rt.PhpObjectBase
pub mut:
	exporters rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) construct(var_exporters rt.PhpVal) {
	mut var_exporters_mutated := var_exporters
	this.exporters = var_exporters_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) export(var_steps rt.PhpVal) rt.PhpVal {
	mut var_loading_page_path := this.wp_apply_filters(rt.new_string('wooblueprint_export_landingpage'),
		rt.new_string('/'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('#^/$|^/[^/].*#'),
		var_loading_page_path.clone(),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wooblueprint_invalid_landing_page_path'),
			rt.new_string('Invalid loading page path.')))
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'landingPage', val: var_loading_page_path },
		rt.ArrayItem{ key: 'steps', val: rt.new_array() },
	])
	mut var_built_in_exporters := rt.call_method(create_automattic_woocommerce_blueprint_builtinexporters(),
		'get_all', []rt.PhpVal{})
	mut var_exporters := this.wp_apply_filters(rt.new_string('wooblueprint_exporters'), rt.call_function('array_merge', [
		this.exporters,
		var_built_in_exporters.clone(),
	]))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_exporter := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.instance_of(var_exporter,
			'Automattic_WooCommerce_Blueprint_Exporters_StepExporter'))
	}
	var_exporters = rt.call_function('array_filter', [var_exporters.clone(),
		rt.new_closure(closure_1_fn)])
	if rt.is_true(rt.new_int(var_steps.clone().array_count())) {
		mut iter_1 := var_exporters.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_exporter := item_1.val
			mut var_key := item_1.key
			mut var_name := rt.call_method(var_exporter, 'get_step_name', []rt.PhpVal{})
			mut var_alias := if rt.is_true(rt.new_bool(rt.instance_of(var_exporter,
				'Automattic_WooCommerce_Blueprint_Exporters_HasAlias')))
			{
				rt.call_method(var_exporter, 'get_alias', []rt.PhpVal{})
			} else {
				var_name
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_name.clone(), var_steps.clone(), rt.new_bool(true)])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_alias.clone(), var_steps.clone(), rt.new_bool(true)]))))) {
				var_exporters.array_unset(var_key)
			}
		}
	}
	mut iter_2 := var_exporters.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_exporter := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_exporter,
			'check_step_capabilities', []rt.PhpVal{})))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wooblueprint_insufficient_permissions'),
				'Insufficient permissions to export for step: ' +
				(rt.call_method(var_exporter, 'get_step_name', []rt.PhpVal{})).str()))
		}
	}
	mut var_logger := create_automattic_woocommerce_blueprint_logger()
	var_logger.start_export(var_exporters.clone())
	mut iter_3 := var_exporters.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_exporter := item_3.val
		this.publish(rt.new_string('onBeforeExport'), var_exporter.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_step := rt.call_method(var_exporter, 'export', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		this.add_result_to_schema(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_array](var_schema),
			var_step.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blueprint_Throwable') {
			mut var_e := var_e_1.clone()
			mut var_step_name := if rt.is_true(rt.new_bool(rt.instance_of(var_exporter,
				'Automattic_WooCommerce_Blueprint_Exporters_HasAlias')))
			{
				rt.call_method(var_exporter, 'get_alias', []rt.PhpVal{})
			} else {
				rt.call_method(var_exporter, 'get_step_name', []rt.PhpVal{})
			}
			var_logger.export_step_failed(var_step_name.clone(), var_e.clone())
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wooblueprint_export_step_failed'),

				'Export step failed: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()))
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
	var_logger.complete_export(var_exporters.clone())
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) on_before_export(var_step_name rt.PhpVal, var_callback rt.PhpVal) {
	mut var_step_name_mutated := var_step_name
	closure_2_fn := fn [var_step_name, var_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_exporter := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(var_step_name_mutated, rt.call_method(var_exporter,
			'get_step_name', []rt.PhpVal{})))
		{
			rt.call_callable(var_callback, [var_exporter.clone()])
		}
		return rt.new_null()
	}
	this.subscribe(rt.new_string('onBeforeExport'), rt.new_closure(closure_2_fn))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) add_result_to_schema(mut var_schema Class_Automattic_WooCommerce_Blueprint_array, var_step rt.PhpVal) {
	mut var_schema_mutated := var_schema
	mut var_step_mutated := var_step
	if rt.is_true(rt.new_bool(var_step_mutated.clone().is_array())) {
		mut iter_4 := var_step_mutated.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var__step := item_4.val
			var_schema_mutated.array_get_mut('steps').array_push(rt.call_method(var__step,
				'get_json_array', []rt.PhpVal{}))
		}
		return
	}
	var_schema_mutated.array_get_mut('steps').array_push(rt.call_method(var_step_mutated,
		'get_json_array', []rt.PhpVal{}))
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_BuiltInExporters {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Logger {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_exportschema(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ExportSchema {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ExportSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		exporters:     rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_builtinexporters(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_BuiltInExporters {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_BuiltInExporters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_logger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Logger {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export(dispatch_arg_0)
		}
		'on_before_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.on_before_export(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_result_to_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_result_to_schema(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'exporters' { return this.exporters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ExportSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'exporters' {
			this.exporters = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInExporters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_BuiltInExporters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInExporters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
