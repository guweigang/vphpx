import rt

struct Class_Automattic_WooCommerce_Blueprint_ImportStep {
	rt.PhpObjectBase
pub mut:
		step_definition rt.PhpVal = rt.new_null()
		validator rt.PhpVal = rt.new_null()
		builtin_step_processors rt.PhpVal = rt.new_null()
		importers rt.PhpVal = rt.new_null()
		indexed_importers rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) construct(var_step_definition rt.PhpVal, mut var_validator Class_Automattic_WooCommerce_Blueprint_?Validator)  {
	mut var_validator_mutated := var_validator
	this.step_definition = var_step_definition.dup()
	if rt.is_true(rt.identical(rt.new_null(), var_validator_mutated)) {
		var_validator_mutated = create_opis_jsonschema_validator()
	}
	this.validator = var_validator_mutated.dup()
	this.importers = this.wp_apply_filters(rt.new_string('wooblueprint_importers'), rt.call_method(create_automattic_woocommerce_blueprint_builtinstepprocessors(), 'get_all', []rt.PhpVal{}))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_importer := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return
	}
	this.indexed_importers = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}; return temp.index_array(arg_0, arg_1) }(this.importers, rt.new_closure(closure_1_fn))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) import() rt.PhpVal {
	mut var_result := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}; return temp.success(arg_0) }(rt.get_property(this.step_definition, 'step'))
	if !(this.can_import(var_result.dup())) {
		return var_result.dup()
	}
	mut var_importer := this.indexed_importers.array_get(rt.get_property(this.step_definition, 'step'))
	mut var_logger := create_automattic_woocommerce_blueprint_logger()
	var_logger.start_import(rt.get_property(this.step_definition, 'step'), rt.call_function('get_class', [var_importer.dup()]))
	mut var_importer_result := rt.call_method(var_importer, 'process', [this.step_definition])
	if rt.is_true(rt.call_method(var_importer_result, 'is_success', []rt.PhpVal{})) {
		var_logger.complete_import(rt.get_property(this.step_definition, 'step'), var_importer_result.dup())
	} else {
		var_logger.import_step_failed(rt.get_property(this.step_definition, 'step'), var_importer_result.dup())
	}
	rt.call_method(var_result, 'merge_messages', [var_importer_result.dup()])
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) can_import(var_result rt.PhpVal) bool {
	mut var_result_mutated := var_result
	if !(this.indexed_importers.array_isset(rt.get_property(this.step_definition, 'step'))) {
		rt.call_method(var_result_mutated, 'add_error', [rt.new_string('Unable to find an importer')])
		return false
	}
	mut var_importer := this.indexed_importers.array_get(rt.get_property(this.step_definition, 'step'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_importer, 'Automattic_WooCommerce_Blueprint_StepProcessor')))))) {
		rt.call_method(var_result_mutated, 'add_error', [rt.new_string('Incorrect importer type')])
		return false
	}
	if !(this.validate_step_schemas(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_StepProcessor](var_importer), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_StepProcessorResult](var_result_mutated))) {
		rt.call_method(var_result_mutated, 'add_error', [rt.new_string('Schema validation failed for step')])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_importer, 'check_step_capabilities', [this.step_definition]))))) {
		rt.call_method(var_result_mutated, 'add_error', [rt.new_string('User does not have the required capabilities to run step')])
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) validate_step_schemas(mut var_importer Class_Automattic_WooCommerce_Blueprint_StepProcessor, mut var_result Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) bool {
	mut var_importer_mutated := var_importer
	mut var_result_mutated := var_result
	mut var_step_schema := rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_importer_mutated, 'get_step_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: 'get_schema' }])])
	mut var_validate := rt.call_method(this.validator, 'validate', [this.step_definition, rt.call_function('wp_json_encode', [var_step_schema.dup()])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_validate, 'isValid', []rt.PhpVal{}))))) {
		rt.call_method(var_result_mutated, 'add_error', [rt.concat(rt.new_string('Schema validation failed for step '), rt.get_property(this.step_definition, 'step'))])
		mut var_errors := rt.call_method(create_opis_jsonschema_errors_errorformatter(), 'format', [rt.call_method(var_validate, 'error', []rt.PhpVal{})])
		mut var_formatted_errors := rt.new_array()
		{
			mut iter_1 := var_errors.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				var_formatted_errors.array_push(rt.call_function('implode', [rt.new_string('\n'), var_value.dup()]))
			}
		}
		rt.call_method(var_result_mutated, 'add_error', [rt.call_function('implode', [rt.new_string('\n'), var_formatted_errors.dup()])])
		return false
	}
	return true
}

struct Class_Opis_JsonSchema_Validator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Util {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Logger {
	rt.PhpObjectBase
}

struct Class_Opis_JsonSchema_Errors_ErrorFormatter {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importstep(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ImportStep {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ImportStep{
		PhpObjectBase: rt.PhpObjectBase{}
		step_definition: rt.new_null()
		validator: rt.new_null()
		builtin_step_processors: rt.new_null()
		importers: rt.new_null()
		indexed_importers: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_opis_jsonschema_validator() &Class_Opis_JsonSchema_Validator {
	mut obj := &Class_Opis_JsonSchema_Validator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_builtinstepprocessors() &Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_util() &Class_Automattic_WooCommerce_Blueprint_Util {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Util{
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

fn create_automattic_woocommerce_blueprint_logger() &Class_Automattic_WooCommerce_Blueprint_Logger {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_opis_jsonschema_errors_errorformatter() &Class_Opis_JsonSchema_Errors_ErrorFormatter {
	mut obj := &Class_Opis_JsonSchema_Errors_ErrorFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_?Validator](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'import' {
			return this.import()
		}
		'can_import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.can_import(dispatch_arg_0))
		}
		'validate_step_schemas' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_StepProcessor](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_StepProcessorResult](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.validate_step_schemas(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'step_definition' { return this.step_definition }
		'validator' { return this.validator }
		'builtin_step_processors' { return this.builtin_step_processors }
		'importers' { return this.importers }
		'indexed_importers' { return this.indexed_importers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'step_definition' { this.step_definition = val; return true }
		'validator' { this.validator = val; return true }
		'builtin_step_processors' { this.builtin_step_processors = val; return true }
		'importers' { this.importers = val; return true }
		'indexed_importers' { this.indexed_importers = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Opis_JsonSchema_Validator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Opis_JsonSchema_Validator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Opis_JsonSchema_Validator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_BuiltInStepProcessors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Opis_JsonSchema_Errors_ErrorFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Opis_JsonSchema_Errors_ErrorFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Opis_JsonSchema_Errors_ErrorFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_importstep_php() {
}
