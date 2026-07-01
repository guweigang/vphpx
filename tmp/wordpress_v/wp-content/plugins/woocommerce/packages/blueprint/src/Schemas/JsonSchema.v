import rt

struct Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) construct(var_json_path rt.PhpVal)  {
	mut var_real_path := rt.call_function('realpath', [var_json_path.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_real_path)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException', []string{}, create_automattic_woocommerce_blueprint_schemas_invalidargumentexception(rt.new_string('Invalid schema path'))))
	}
	mut var_contents := this.wp_filesystem_get_contents(var_real_path.dup())
	if rt.is_true(rt.identical(rt.new_bool(false), var_contents)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_Schemas_RuntimeException', []string{}, create_automattic_woocommerce_blueprint_schemas_runtimeexception(rt.new_string("Failed to read the JSON file at ${var_real_path.to_string()}."))))
	}
	mut var_schema := rt.call_function('json_decode', [var_contents.dup()])
	this.schema = var_schema.dup()
	if !(this.validate()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException', []string{}, create_automattic_woocommerce_blueprint_schemas_invalidargumentexception(rt.new_string('Invalid JSON or missing \'steps\' field.'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) get_steps() rt.PhpVal {
	return rt.get_property(this.schema, 'steps')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) get_step(var_name rt.PhpVal) rt.PhpVal {
	mut var_steps := rt.new_array()
	{
		mut iter_1 := rt.get_property(this.schema, 'steps').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_step := item_1.val
			if rt.is_true(rt.identical(rt.get_property(var_step, 'step'), var_name)) {
				var_steps.array_push(var_step.dup())
			}
		}
	}
	return var_steps.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) validate() bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	if rt.is_true(rt.new_bool(!(!(rt.get_property(this.schema, 'steps')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(this.schema, 'steps').is_array()))))))) {
		return false
	}
	return true
}

struct Class_Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Schemas_RuntimeException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_schemas_jsonschema(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_schemas_invalidargumentexception() &Class_Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_schemas_runtimeexception() &Class_Automattic_WooCommerce_Blueprint_Schemas_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Schemas_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_steps' {
			return this.get_steps()
		}
		'get_step' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_step(dispatch_arg_0)
		}
		'validate' {
			return rt.new_bool(this.validate())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_JsonSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Schemas_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Schemas_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_schemas_jsonschema_php() {
}
