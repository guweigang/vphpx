import rt

struct Class_Automattic_WooCommerce_Blueprint_ImportSchema {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
		validator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportSchema) construct(mut var_schema Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema, mut var_validator Class_Automattic_WooCommerce_Blueprint_?Validator) {
	mut var_validator_mutated := var_validator
	this.schema = var_schema
	if rt.is_true(rt.identical(rt.new_null(), var_validator_mutated)) {
	var_validator_mutated = create_opis_jsonschema_validator()
	}
	this.validator = var_validator_mutated
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportSchema) get_schema() rt.PhpVal {
	return this.schema
}

fn Class_Automattic_WooCommerce_Blueprint_ImportSchema.create_from_file(var_file rt.PhpVal) rt.PhpVal {
	return Class_Automattic_WooCommerce_Blueprint_ImportSchema.create_from_json(var_file.clone())
}

fn Class_Automattic_WooCommerce_Blueprint_ImportSchema.create_from_json(var_json_path rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Blueprint_self', []string{}, create_automattic_woocommerce_blueprint_self(create_automattic_woocommerce_blueprint_schemas_jsonschema(var_json_path.clone())))
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportSchema) import() rt.PhpVal {
	mut var_results := rt.new_array()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}
	mut iife_result_0 := iife_temp_0.success(rt.new_string('ImportSchema'))
	mut var_result := iife_result_0
	var_results.array_push(var_result.clone())
	mut iter_1 := rt.call_method(this.schema, 'get_steps', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_step_schema := item_1.val
		mut var_step_importer := create_automattic_woocommerce_blueprint_importstep(var_step_schema.clone(), this.validator)
		var_results.array_push(var_step_importer.import())
	}
	return var_results.clone()
}

struct Class_Opis_JsonSchema_Validator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_ImportStep {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ImportSchema {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ImportSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
		validator: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_opis_jsonschema_validator(_args ...rt.PhpVal) &Class_Opis_JsonSchema_Validator {
	mut obj := &Class_Opis_JsonSchema_Validator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_self {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_schemas_jsonschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_importstep(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_ImportStep {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ImportStep{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_?Validator](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_schema' {
			return this.get_schema()
		}
		'create_from_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blueprint_ImportSchema.create_from_file(dispatch_arg_0)
		}
		'create_from_json' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blueprint_ImportSchema.create_from_json(dispatch_arg_0)
		}
		'import' {
			return this.import()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ImportSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'validator' { return this.validator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		'validator' { this.validator = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Blueprint_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ImportStep) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
