import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.fromarray(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_kind := if !(var_node.array_get('kind')).is_null() { var_node.array_get('kind') } else { rt.new_null() }
	if rt.is_true(rt.identical(var_kind, rt.new_null())) {
		mut var_safeNode := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_node))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Node is missing kind: ${var_safeNode.to_string()}"))))
	}
	mut var_class := if !(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.class_map().array_get(var_kind)).is_null() { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.class_map().array_get(var_kind) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_class, rt.new_null())) {
		var_safeNode = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_node))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Node has unexpected kind: ${var_safeNode.to_string()}"))))
	}
	mut var_instance := rt.create_object_dynamically(var_class, [rt.new_array()])
	if var_node.array_get('loc').array_isset(rt.new_string('start')) && var_node.array_get('loc').array_isset(rt.new_string('end')) {
		rt.set_property(var_instance, 'loc', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location{}; return temp.create(arg_0, arg_1) }(var_node.array_get('loc').array_get('start'), var_node.array_get('loc').array_get('end')))
	}
	{
		mut iter_1 := var_node.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_key, rt.new_string('loc'))) || rt.is_true(rt.identical(var_key, rt.new_string('kind'))))) {
				continue
			}
			if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				var_value = if rt.is_true(rt.new_bool(var_value.array_isset(rt.new_int(0)) || rt.is_true(rt.identical(var_value, rt.new_array())))) { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_value.dup()) } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.fromarray(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_value)) }
			}
			rt.set_property(var_instance, '{"nodeType":"Expr_Variable","line":106,"name":"key"}', var_value.dup())
		}
	}
	return var_instance.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.toarray(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) rt.PhpVal {
	return var_node.toarray()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(var_value rt.PhpVal, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_type_mutated := var_type
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		mut var_wrappedType := rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_wrappedType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType'))])
		mut var_astValue := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), var_wrappedType.dup())
		return if rt.is_true(rt.new_bool(rt.instance_of(var_astValue, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) { rt.new_null() } else { var_astValue }
	}
	if rt.is_true(rt.identical(var_value_mutated, rt.new_null())) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode(rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		mut var_itemType := rt.call_method(var_type_mutated, 'getWrappedType', []rt.PhpVal{})
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_itemType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType')), rt.new_string('proven by schema validation')])
		if rt.is_true(rt.call_function('is_iterable', [var_value_mutated.dup()])) {
			mut var_valuesNodes := rt.new_array()
			{
				mut iter_1 := var_value_mutated.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_item := item_1.val
					mut var_itemNode := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_item), var_itemType.dup())
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_valuesNodes.array_push(var_itemNode.dup())
					}
				}
			}
			return create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode(rt.create_array([rt.ArrayItem{ key: 'values', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_valuesNodes.dup()) }]))
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_value_mutated), var_itemType.dup())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		mut var_isArray := rt.new_bool(rt.new_bool(var_value_mutated.dup().is_array()))
		mut var_isArrayLike := rt.new_bool(rt.new_bool(rt.is_true(var_isArray) || rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_ArrayAccess')))))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_isArrayLike)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_object()))))))) {
			return rt.new_null()
		}
		mut var_fields := rt.call_method(var_type_mutated, 'getFields', []rt.PhpVal{})
		mut var_fieldNodes := rt.new_array()
		{
			mut iter_1 := var_fields.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				mut var_fieldName := item_1.key
				mut var_fieldValue := if rt.is_true(var_isArrayLike) { if !(var_value_mutated.array_get(var_fieldName)).is_null() { var_value_mutated.array_get(var_fieldName) } else { rt.new_null() } } else { if !(rt.get_property(var_value_mutated, '{"nodeType":"Expr_Variable","line":205,"name":"fieldName"}')).is_null() { rt.get_property(var_value_mutated, '{"nodeType":"Expr_Variable","line":205,"name":"fieldName"}') } else { rt.new_null() } }
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					mut var_fieldExists := rt.new_bool(rt.new_bool(true))
				} else if rt.is_true(var_isArray) {
					var_fieldExists = rt.new_bool(rt.new_bool(var_value_mutated.dup().array_isset(var_fieldName.dup())))
				} else if rt.is_true(var_isArrayLike) {
					var_fieldExists = rt.call_method(var_value_mutated, 'offsetExists', [var_fieldName.dup()])
				} else {
					var_fieldExists = rt.call_function('property_exists', [var_value_mutated.dup(), var_fieldName.dup()])
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(var_fieldExists)))) {
					continue
				}
				mut var_fieldNode := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](var_fieldValue), rt.call_method(var_field, 'getType', []rt.PhpVal{}))
				if rt.is_true(rt.identical(var_fieldNode, rt.new_null())) {
					continue
				}
				var_fieldNodes.array_push(create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode(rt.create_array([rt.ArrayItem{ key: 'name', val: create_automattic_woocommerce_vendor_graphql_language_ast_namenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_fieldName }])) }, rt.ArrayItem{ key: 'value', val: var_fieldNode }])))
			}
		}
		return create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode(rt.create_array([rt.ArrayItem{ key: 'fields', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_fieldNodes.dup()) }]))
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType')), rt.new_string('other options were exhausted')])
	mut var_serialized := rt.call_method(var_type_mutated, 'serialize', [var_value_mutated.dup()])
	if rt.is_true(rt.new_bool(var_serialized.dup().is_bool())) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
	}
	if rt.is_true(rt.new_bool(var_serialized.dup().is_long())) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }]))
	}
	if rt.is_true(rt.new_bool(var_serialized.dup().is_double())) {
		if rt.is_true(rt.equal(// unsupported expression: Expr_Cast_Int, var_serialized)) {
			return create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }]))
		}
		return create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }]))
	}
	if rt.is_true(rt.new_bool(var_serialized.dup().is_string())) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) {
			return create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
		}
		mut var_asInt := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IDType'))) && rt.is_true(rt.identical(// unsupported expression: Expr_Cast_String, var_serialized)))) {
			return create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
		}
		return create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: var_serialized }]))
	}
	mut var_notConvertible := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_serialized.dup())
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Cannot convert value to AST: ${var_notConvertible.to_string()}"))))
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_undefined := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.undefined() }()
	if rt.is_true(rt.identical(var_valueNode, rt.new_null())) {
		return var_undefined.dup()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) {
			return var_undefined.dup()
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut , mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](), mut , mut )
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode', []string{}, ), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode'))) {
		return 
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.ismissingvariable(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array) bool {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromastuntyped(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array)  {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.typefromast(mut var_typeLoader Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable, mut var_inputTypeNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.getoperationast(mut var_document Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?string) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.concatast(mut var_documents Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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

fn create_automattic_woocommerce_vendor_graphql_language_ast_location() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_namenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.fromarray(mut dispatch_arg_0)
		}
		'toArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.toarray(mut dispatch_arg_0)
		}
		'astFromValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.astfromvalue(dispatch_arg_0, mut dispatch_arg_1)
		}
		'valueFromAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?ValueNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Schema](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromast(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'isMissingVariable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.ismissingvariable(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'valueFromASTUntyped' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.valuefromastuntyped(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'typeFromAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.typefromast(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getOperationAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.getoperationast(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'concatAST' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST.concatast(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Utils_AST', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_utils_ast()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_AST', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_utils_utils()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_error_invariantviolation()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_location()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_nodelist()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_namenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode()
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_ast_php() {
	// unsupported statement: Stmt_Declare
}
