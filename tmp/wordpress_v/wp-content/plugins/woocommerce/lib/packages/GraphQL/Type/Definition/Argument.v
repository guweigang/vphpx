import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		defaultValue rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_null()
		deprecationReason rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		astNode rt.PhpVal = rt.new_null()
		config rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array)  {
	this.name = var_config.array_get('name')
	this.defaultValue = if !(var_config.array_get('defaultValue')).is_null() { var_config.array_get('defaultValue') } else { rt.new_null() }
	this.description = if !(var_config.array_get('description')).is_null() { var_config.array_get('description') } else { rt.new_null() }
	this.deprecationReason = if !(var_config.array_get('deprecationReason')).is_null() { var_config.array_get('deprecationReason') } else { rt.new_null() }
	this.astNode = if !(var_config.array_get('astNode')).is_null() { var_config.array_get('astNode') } else { rt.new_null() }
	this.config = var_config.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument.listfromconfig(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_iterable) rt.PhpVal {
	mut var_list := rt.new_array()
	{
		mut iter_1 := var_config.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_argConfig := item_1.val
			mut var_name := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_argConfig.dup().is_array()))))) {
				var_argConfig = rt.create_array([rt.ArrayItem{ key: 'type', val: var_argConfig }])
			}
			mut var_argConfigWithName := rt.add(var_argConfig, rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }]))
			var_list.array_push(create_automattic_woocommerce_vendor_graphql_type_definition_self(var_argConfigWithName.dup()))
		}
	}
	return var_list.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) gettype() rt.PhpVal {
	if !(!(this.prop_type).is_null()) {
		this.prop_type = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{}; return temp.resolvetype(arg_0) }(this.config.array_get('type'))
	}
	return this.prop_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) defaultvalueexists() bool {
	return this.config.array_isset(rt.new_string('defaultValue'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) isrequired() bool {
	return rt.is_true(rt.new_bool(rt.instance_of(this.gettype(), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && !(this.defaultvalueexists())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) isdeprecated() bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) assertvalid(mut var_parentField Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type)  {
	mut var_error := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.isvalidnameerror(arg_0) }(this.name)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string('.')), rt.get_property(var_parentField, 'name')), rt.new_string('(')), this.name), rt.new_string(':) ')), rt.call_method(var_error, 'getMessage', []rt.PhpVal{})))))
	}
	mut var_type := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(this.gettype())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType')))))) {
		mut var_notInputType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(this.prop_type)
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string('.')), rt.get_property(var_parentField, 'name')), rt.new_string('(')), this.name), rt.new_string('): argument type must be Input Type but got: ')), var_notInputType))))
	}
	if this.isrequired() && this.isdeprecated() {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Required argument '), rt.get_property(var_parentType, 'name')), rt.new_string('.')), rt.get_property(var_parentField, 'name')), rt.new_string('(')), this.name), rt.new_string(':) cannot be deprecated.')))))
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_argument(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		defaultValue: rt.new_null()
		description: rt.new_null()
		deprecationReason: rt.new_null()
		prop_type: rt.new_null()
		astNode: rt.new_null()
		config: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_self() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schema() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'listFromConfig' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_iterable](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument.listfromconfig(mut dispatch_arg_0)
		}
		'getType' {
			return this.gettype()
		}
		'defaultValueExists' {
			return rt.new_bool(this.defaultvalueexists())
		}
		'isRequired' {
			return rt.new_bool(this.isrequired())
		}
		'isDeprecated' {
			return rt.new_bool(this.isdeprecated())
		}
		'assertValid' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			this.assertvalid(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'defaultValue' { return this.defaultValue }
		'description' { return this.description }
		'deprecationReason' { return this.deprecationReason }
		'type' { return this.prop_type }
		'astNode' { return this.astNode }
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'defaultValue' { this.defaultValue = val; return true }
		'description' { this.description = val; return true }
		'deprecationReason' { this.deprecationReason = val; return true }
		'type' { this.prop_type = val; return true }
		'astNode' { this.astNode = val; return true }
		'config' { this.config = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_argument_php() {
	// unsupported statement: Stmt_Declare
}
