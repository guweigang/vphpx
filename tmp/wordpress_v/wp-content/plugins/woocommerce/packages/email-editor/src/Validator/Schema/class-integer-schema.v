import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema {
	rt.PhpObjectBase
pub mut:
	schema rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) minimum(value i64) rt.PhpVal {
	return rt.call_method(this.update_schema_property(rt.new_string('minimum'), rt.new_int(value)),
		'unset_schema_property', [rt.new_string('exclusiveMinimum')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) exclusiveminimum(value i64) rt.PhpVal {
	return rt.call_method(this.update_schema_property(rt.new_string('minimum'), rt.new_int(value)),
		'update_schema_property', [rt.new_string('exclusiveMinimum'),
		rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) maximum(value i64) rt.PhpVal {
	return rt.call_method(this.update_schema_property(rt.new_string('maximum'), rt.new_int(value)),
		'unset_schema_property', [rt.new_string('exclusiveMaximum')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) exclusivemaximum(value i64) rt.PhpVal {
	return rt.call_method(this.update_schema_property(rt.new_string('maximum'), rt.new_int(value)),
		'update_schema_property', [rt.new_string('exclusiveMaximum'),
		rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) multipleof(value i64) rt.PhpVal {
	return this.update_schema_property(rt.new_string('multipleOf'), rt.new_int(value))
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_schema_integer_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema:        rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'minimum' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.minimum(dispatch_arg_0)
		}
		'exclusiveMinimum' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.exclusiveminimum(dispatch_arg_0)
		}
		'maximum' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.maximum(dispatch_arg_0)
		}
		'exclusiveMaximum' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.exclusivemaximum(dispatch_arg_0)
		}
		'multipleOf' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.multipleof(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' {
			this.schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_validator_schema_class_integer_schema_php() {
	// unsupported statement: Stmt_Declare
}
