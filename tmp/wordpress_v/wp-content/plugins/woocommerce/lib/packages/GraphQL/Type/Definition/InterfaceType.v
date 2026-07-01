import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType {
	rt.PhpObjectBase
pub mut:
		astNode rt.PhpVal = rt.new_null()
		extensionASTNodes rt.PhpVal = rt.new_null()
		config rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array)  {
	this.dispatch_set_prop('name', if !(var_config.array_get('name')).is_null() { var_config.array_get('name') } else { this.infername() })
	this.dispatch_set_prop('description', if !(var_config.array_get('description')).is_null() { var_config.array_get('description') } else { rt.new_null() })
	this.astNode = if !(var_config.array_get('astNode')).is_null() { var_config.array_get('astNode') } else { rt.new_null() }
	this.extensionASTNodes = if !(var_config.array_get('extensionASTNodes')).is_null() { var_config.array_get('extensionASTNodes') } else { rt.new_array() }
	this.config = var_config.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType.assertinterfacetype(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self')))))) {
		mut var_notInterfaceType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_type.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Expected ${var_notInterfaceType.to_string()} to be a Automattic\\WooCommerce\\Vendor\\GraphQL Interface type."))))
	}
	return var_type.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) resolvevalue(var_objectValue rt.PhpVal, var_context rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) rt.PhpVal {
	if this.config.array_isset(rt.new_string('resolveValue')) {
		return rt.call_callable(this.config.array_get('resolveValue'), [var_objectValue.dup(), var_context.dup(), var_info])
	}
	return var_objectValue.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) resolvetype(var_objectValue rt.PhpVal, var_context rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) rt.PhpVal {
	if this.config.array_isset(rt.new_string('resolveType')) {
		return rt.call_callable(this.config.array_get('resolveType'), [var_objectValue.dup(), var_context.dup(), var_info])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) assertvalid()  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.assertvalidname(arg_0) }(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'AbstractType', 'OutputType', 'CompositeType', 'NullableType', 'HasFieldsType', 'NamedType', 'ImplementingType'], &this), 'name'))
	mut var_resolveType := if !(this.config.array_get('resolveType')).is_null() { this.config.array_get('resolveType') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_resolveType.dup()]))))))) {
		mut var_notCallable := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_resolveType.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'AbstractType', 'OutputType', 'CompositeType', 'NullableType', 'HasFieldsType', 'NamedType', 'ImplementingType'], &this), 'name'), rt.new_string(' must provide "resolveType" as null or a callable, but got: ')), var_notCallable), rt.new_string('.')))))
	}
	this.assertvalidinterfaces()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) astnode() rt.PhpVal {
	return this.astNode
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) extensionastnodes() rt.PhpVal {
	return this.extensionASTNodes
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_interfacetype(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType{
		PhpObjectBase: rt.PhpObjectBase{}
		astNode: rt.new_null()
		extensionASTNodes: rt.new_null()
		config: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'assertInterfaceType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType.assertinterfacetype(dispatch_arg_0)
		}
		'resolveValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.resolvevalue(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'resolveType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.resolvetype(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'assertValid' {
			this.assertvalid()
			return rt.new_null()
		}
		'astNode' {
			return this.astnode()
		}
		'extensionASTNodes' {
			return this.extensionastnodes()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'astNode' { this.astNode = val; return true }
		'extensionASTNodes' { this.extensionASTNodes = val; return true }
		'config' { this.config = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_interfacetype_php() {
	// unsupported statement: Stmt_Declare
}
