import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.string() rt.PhpVal {
	return create_automattic_woocommerce_emaileditor_validator_schema_string_schema()
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.number() rt.PhpVal {
	return create_automattic_woocommerce_emaileditor_validator_schema_number_schema()
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.integer() rt.PhpVal {
	return create_automattic_woocommerce_emaileditor_validator_schema_integer_schema()
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.boolean() rt.PhpVal {
	return create_automattic_woocommerce_emaileditor_validator_schema_boolean_schema()
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.null() rt.PhpVal {
	return create_automattic_woocommerce_emaileditor_validator_schema_null_schema()
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.array(mut var_items Class_Automattic_WooCommerce_EmailEditor_Validator_?Schema) rt.PhpVal {
	mut var_array := create_automattic_woocommerce_emaileditor_validator_schema_array_schema()
	return if rt.is_true(var_items) { var_array.items(rt.new_object('Automattic_WooCommerce_EmailEditor_Validator_?Schema', []string{}, var_items)) } else { var_array }
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.object(mut var_properties Class_Automattic_WooCommerce_EmailEditor_Validator_?array) rt.PhpVal {
	mut var_object := create_automattic_woocommerce_emaileditor_validator_schema_object_schema()
	return if rt.is_true(rt.identical(rt.new_null(), var_properties)) { var_object } else { var_object.properties(rt.new_object('Automattic_WooCommerce_EmailEditor_Validator_?array', []string{}, var_properties)) }
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.one_of(mut var_schemas Class_Automattic_WooCommerce_EmailEditor_Validator_array) rt.PhpVal {
	return create_automattic_woocommerce_emaileditor_validator_schema_one_of_schema(var_schemas.dup())
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.any_of(mut var_schemas Class_Automattic_WooCommerce_EmailEditor_Validator_array) rt.PhpVal {
	return create_automattic_woocommerce_emaileditor_validator_schema_any_of_schema(var_schemas.dup())
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Number_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Boolean_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Null_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_One_Of_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_builder() &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_string_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_number_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Number_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Number_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_integer_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_boolean_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Boolean_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Boolean_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_null_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Null_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Null_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_array_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_object_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_one_of_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_One_Of_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_One_Of_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_schema_any_of_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'string' {
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.string()
		}
		'number' {
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.number()
		}
		'integer' {
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.integer()
		}
		'boolean' {
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.boolean()
		}
		'null' {
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.null()
		}
		'array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_?Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.array(mut dispatch_arg_0)
		}
		'object' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.object(mut dispatch_arg_0)
		}
		'one_of' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.one_of(mut dispatch_arg_0)
		}
		'any_of' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Validator_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Builder.any_of(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_String_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Number_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Number_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Number_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Integer_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Boolean_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Boolean_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Boolean_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Null_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Null_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Null_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Array_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Object_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_One_Of_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_One_Of_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_One_Of_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema_Any_Of_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_validator_class_builder_php() {
	// unsupported statement: Stmt_Declare
}
