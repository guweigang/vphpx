import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.int() string {
	return 'Int'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.float() string {
	return 'Float'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.string() string {
	return 'String'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.boolean() string {
	return 'Boolean'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.id() string {
	return 'ID'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_scalar_names() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.int() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.float() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.string() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.boolean() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.id() }])
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.standard_type_names() rt.PhpVal {
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_scalar_names()
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_type_names() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_scalar_names() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_names() }])
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
pub mut:
		builtInScalars rt.PhpVal = rt.new_null()
		builtInTypes rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.int() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.float() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.string() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.boolean() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.id() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.listof(var_type rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_vendor_graphql_type_definition_listoftype(var_type.dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.nonnull(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		return var_type.dup()
	}
	return create_automattic_woocommerce_vendor_graphql_type_definition_nonnull(var_type.dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.builtintypes() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.builtinscalars() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.int(), val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.int() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.float(), val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.float() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.string(), val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.string() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.boolean(), val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.boolean() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.id(), val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.id() }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getstandardtypes() rt.PhpVal {
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.builtinscalars()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.overridestandardtypes(mut var_types Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array)  {
	// unsupported assign target: Expr_StaticPropertyFetch
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}; return temp.resetcachedinstances() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}; return temp.resetcachedinstances() }()
	{
		mut iter_1 := var_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')))))) {
				mut var_typeClass := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType.class()
				mut var_notType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_type.dup())
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Expecting instance of ${var_typeClass.to_string()}, got ${var_notType.to_string()}"))))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isbuiltinscalarname((rt.get_property(var_type, 'name')).str()))))) {
				mut var_standardTypeNames := rt.call_function('implode', [rt.new_string(', '), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_scalar_names()])
				mut var_notStandardTypeName := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(rt.get_property(var_type, 'name'))
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Expecting one of the following names for a standard type: ${var_standardTypeNames.to_string()}; got ${var_notStandardTypeName.to_string()}"))))
			}
			// unsupported expression: Expr_StaticPropertyFetch.array_set(rt.get_property(var_type, 'name'), var_type.dup())
		}
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isbuiltinscalar(var_type rt.PhpVal) bool {
	return rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isbuiltinscalarname((rt.get_property(var_type, 'name')).str()))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isbuiltinscalarname(name string) bool {
	return (rt.call_function('in_array', [rt.new_string(name), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_scalar_names(), rt.new_bool(true)])).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isinputtype(var_type rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getnamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?Type](var_type)), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType'))).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getnamedtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?Type) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))) {
		return var_type.getinnermosttype()
	}
	rt.call_function('assert', [rt.new_bool(rt.is_true(rt.identical(var_type, rt.new_null())) || rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?Type', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')))), rt.new_string('only other option')])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?Type', []string{}, var_type)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isoutputtype(var_type rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getnamedtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?Type](var_type)), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_OutputType'))).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isleaftype(var_type rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType'))).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.iscompositetype(var_type rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CompositeType'))).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isabstracttype(var_type rt.PhpVal) bool {
	return (rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType'))).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getnullabletype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
	if false {
		return var_type.getwrappedtype()
	}
	rt.call_function('assert', [rt.new_bool(false), rt.new_string('only other option')])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) tostring() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) magic_tostring() string {
	return this.tostring()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) jsonserialize() string {
	return this.tostring()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
		builtInScalars: rt.new_null()
		builtInTypes: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_listoftype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_nonnull() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_introspection() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'int' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.int()
		}
		'float' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.float()
		}
		'string' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.string()
		}
		'boolean' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.boolean()
		}
		'id' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.id()
		}
		'listOf' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.listof(dispatch_arg_0)
		}
		'nonNull' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.nonnull(dispatch_arg_0)
		}
		'builtInTypes' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.builtintypes()
		}
		'builtInScalars' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.builtinscalars()
		}
		'getStandardTypes' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getstandardtypes()
		}
		'overrideStandardTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.overridestandardtypes(mut dispatch_arg_0)
			return rt.new_null()
		}
		'isBuiltInScalar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isbuiltinscalar(dispatch_arg_0))
		}
		'isBuiltInScalarName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isbuiltinscalarname(dispatch_arg_0))
		}
		'isInputType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isinputtype(dispatch_arg_0))
		}
		'getNamedType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getnamedtype(mut dispatch_arg_0)
		}
		'isOutputType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isoutputtype(dispatch_arg_0))
		}
		'isLeafType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isleaftype(dispatch_arg_0))
		}
		'isCompositeType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.iscompositetype(dispatch_arg_0))
		}
		'isAbstractType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.isabstracttype(dispatch_arg_0))
		}
		'getNullableType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.getnullabletype(mut dispatch_arg_0)
		}
		'toString' {
			return rt.new_string(this.tostring())
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'jsonSerialize' {
			return rt.new_string(this.jsonserialize())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'builtInScalars' { return this.builtInScalars }
		'builtInTypes' { return this.builtInTypes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'builtInScalars' { this.builtInScalars = val; return true }
		'builtInTypes' { this.builtInTypes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_type_php() {
	// unsupported statement: Stmt_Declare
}
