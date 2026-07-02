import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema {
	rt.PhpObjectBase
pub mut:
	schema rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) construct(mut var_schemas Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_array) {
	mut iter_1 := var_schemas.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_schema := item_1.val
		this.schema.array_get_mut('anyOf').array_push(rt.call_method(var_schema, 'to_array',
			[]rt.PhpVal{}))
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) nullable() rt.PhpVal {
	mut var_null := rt.create_array([rt.ArrayItem{ key: 'type', val: 'null' }])
	mut var_any_of := this.schema.array_get(rt.new_string('anyOf'))
	mut var_value := if rt.is_true(rt.call_function('in_array', [
		var_null.clone(), var_any_of.clone(), rt.new_bool(true)]))
	{ var_any_of } else { rt.call_function('array_merge', [var_any_of.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: var_null }])]) }
	return this.update_schema_property(rt.new_string('anyOf'), var_value.clone())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) non_nullable() rt.PhpVal {
	mut var_null := rt.create_array([rt.ArrayItem{ key: 'type', val: 'null' }])
	mut var_any_of := this.schema.array_get(rt.new_string('any_of'))
	closure_1_fn := fn [var_null] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(var_item, var_null)))
	}
	mut var_value := rt.call_function('array_filter', [var_any_of.clone(),
		rt.new_closure(closure_1_fn)])
	return this.update_schema_property(rt.new_string('any_of'), var_value.clone())
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_schema_any_of_schema(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema:        rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'nullable' {
			return this.nullable()
		}
		'non_nullable' {
			return this.non_nullable()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
