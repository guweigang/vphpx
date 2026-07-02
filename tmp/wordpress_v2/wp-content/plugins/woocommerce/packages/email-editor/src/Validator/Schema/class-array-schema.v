import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema {
	rt.PhpObjectBase
pub mut:
	schema rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) items(mut var_schema Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) rt.PhpVal {
	return this.update_schema_property(rt.new_string('items'), var_schema.to_array())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) minitems(value i64) rt.PhpVal {
	return this.update_schema_property(rt.new_string('minItems'), rt.new_int(value))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) maxitems(value i64) rt.PhpVal {
	return this.update_schema_property(rt.new_string('maxItems'), rt.new_int(value))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) uniqueitems() rt.PhpVal {
	return this.update_schema_property(rt.new_string('uniqueItems'), rt.new_bool(true))
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_schema_array_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema:        rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.items(mut dispatch_arg_0)
		}
		'minItems' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.minitems(dispatch_arg_0)
		}
		'maxItems' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.maxitems(dispatch_arg_0)
		}
		'uniqueItems' {
			return this.uniqueitems()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
