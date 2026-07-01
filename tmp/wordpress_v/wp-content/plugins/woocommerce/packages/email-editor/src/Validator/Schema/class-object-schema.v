import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema {
	rt.PhpObjectBase
pub mut:
	schema rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) properties(mut var_properties Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_array) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_property := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_method(var_property, 'to_array', []rt.PhpVal{})
		}
		mut var_property := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return rt.call_method(var_property, 'to_array', []rt.PhpVal{})
	}
	return this.update_schema_property(rt.new_string('properties'), rt.call_function('array_map', [
		rt.new_closure(closure_1_fn),
		var_properties,
	]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) additionalproperties(mut var_schema Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) rt.PhpVal {
	return this.update_schema_property(rt.new_string('additionalProperties'), var_schema.to_array())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) disableadditionalproperties() rt.PhpVal {
	return this.update_schema_property(rt.new_string('additionalProperties'), rt.new_bool(false))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) patternproperties(mut var_properties Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_array) rt.PhpVal {
	mut var_pattern_properties := rt.new_array()
	{
		mut iter_1 := var_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			this.validate_pattern(var_key.dup())
			var_pattern_properties.array_set(var_key, rt.call_method(var_value, 'to_array',
				[]rt.PhpVal{}))
		}
	}
	return this.update_schema_property(rt.new_string('patternProperties'),
		var_pattern_properties.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) minproperties(value i64) rt.PhpVal {
	return this.update_schema_property(rt.new_string('minProperties'), rt.new_int(value))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) maxproperties(value i64) rt.PhpVal {
	return this.update_schema_property(rt.new_string('maxProperties'), rt.new_int(value))
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_schema_object_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'properties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.properties(mut dispatch_arg_0)
		}
		'additionalProperties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.additionalproperties(mut dispatch_arg_0)
		}
		'disableAdditionalProperties' {
			return this.disableadditionalproperties()
		}
		'patternProperties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.patternproperties(mut dispatch_arg_0)
		}
		'minProperties' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.minproperties(dispatch_arg_0)
		}
		'maxProperties' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.maxproperties(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_validator_schema_class_object_schema_php() {
	// unsupported statement: Stmt_Declare
}
