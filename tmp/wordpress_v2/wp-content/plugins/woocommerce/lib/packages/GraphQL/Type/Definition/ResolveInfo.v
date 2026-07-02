import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo {
	rt.PhpObjectBase
pub mut:
	fieldDefinition rt.PhpVal = rt.new_null()
	fieldName       rt.PhpVal = rt.new_null()
	returnType      rt.PhpVal = rt.new_null()
	fieldNodes      rt.PhpVal = rt.new_null()
	parentType      rt.PhpVal = rt.new_null()
	path            rt.PhpVal = rt.new_null()
	unaliasedPath   rt.PhpVal = rt.new_null()
	schema          rt.PhpVal = rt.new_null()
	fragments       rt.PhpVal = rt.new_array()
	rootValue       rt.PhpVal = rt.new_null()
	operation       rt.PhpVal = rt.new_null()
	variableValues  rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) construct(mut var_fieldDefinition Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ArrayObject, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_fragments Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, var_rootValue rt.PhpVal, mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	mut var_parentType_mutated := var_parentType
	this.fieldDefinition = var_fieldDefinition
	this.fieldName = rt.get_property(var_fieldDefinition, 'name')
	this.returnType = var_fieldDefinition.gettype()
	this.fieldNodes = var_fieldNodes
	this.parentType = var_parentType_mutated
	this.path = var_path
	this.unaliasedPath = var_unaliasedPath
	this.schema = var_schema
	this.fragments = var_fragments
	this.rootValue = var_rootValue.clone()
	this.operation = var_operation
	this.variableValues = var_variableValues
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) getfieldselection(depth i64) rt.PhpVal {
	mut var_fields := rt.new_array()
	mut iter_1 := this.fieldNodes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_fieldNode := item_1.val
		mut var_selectionSet := rt.get_property(var_fieldNode, 'selectionSet')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_selectionSet, rt.new_null())))) {
			var_fields = rt.call_function('array_merge_recursive', [
				var_fields.clone(),
				this.foldselectionset(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_selectionSet),
					depth)])
		}
	}
	return var_fields.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) getfieldselectionwithaliases(depth i64) rt.PhpVal {
	mut var_fields := rt.new_array()
	mut iter_2 := this.fieldNodes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_fieldNode := item_2.val
		mut var_selectionSet := rt.get_property(var_fieldNode, 'selectionSet')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_selectionSet, rt.new_null())))) {
			mut var_field := rt.call_method(this.parentType, 'getField', [
				rt.get_property(rt.get_property(var_fieldNode, 'name'), 'value'),
			])
			mut var_fieldType := rt.call_method(var_field, 'getType', []rt.PhpVal{})
			var_fields = rt.call_function('array_merge_recursive', [
				var_fields.clone(),
				this.foldselectionwithalias(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_selectionSet),
					depth, mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType))])
		}
	}
	return var_fields.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) lookahead(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan',
		[]string{}, create_automattic_woocommerce_vendor_graphql_type_definition_queryplan(this.parentType,
		this.schema, this.fieldNodes, this.variableValues, this.fragments, var_options))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) foldselectionset(mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, descend i64) rt.PhpVal {
	mut var_selectionSet_mutated := var_selectionSet
	mut var_fields := rt.new_array()
	mut iter_3 := rt.get_property(var_selectionSet_mutated, 'selections').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_selection := item_3.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_selection,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))
		{
			var_fields.array_set(rt.get_property(rt.get_property(var_selection, 'name'), 'value'), if descend > 0 && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_selection, 'selectionSet'), rt.new_null())))) { rt.call_function('array_merge_recursive', [
					if !(var_fields.array_get(rt.get_property(rt.get_property(var_selection, 'name'),
						'value'))).is_null() {
						var_fields.array_get(rt.get_property(rt.get_property(var_selection, 'name'),
							'value'))
					} else {
						rt.new_array()
					},
					this.foldselectionset(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection,
						'selectionSet')), descend - 1),
				])
			 } else { rt.new_bool(true)
			 })
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))
		{
			mut var_spreadName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
			mut var_fragment := if !(this.fragments.array_get(var_spreadName)).is_null() {
				this.fragments.array_get(var_spreadName)
			} else {
				rt.new_null()
			}
			if rt.is_true(rt.identical(var_fragment, rt.new_null())) {
				continue
			}
			var_fields = rt.call_function('array_merge_recursive', [
				this.foldselectionset(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fragment,
					'selectionSet')), descend),
				var_fields.clone(),
			])
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))
		{
			var_fields = rt.call_function('array_merge_recursive', [
				this.foldselectionset(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection,
					'selectionSet')), descend),
				var_fields.clone(),
			])
		}
	}
	return var_fields.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) foldselectionwithalias(mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, descend i64, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) rt.PhpVal {
	mut var_aliasInfo := rt.new_null()
	mut var_fieldTypeInfo := rt.new_null()
	mut var_selectionSet_mutated := var_selectionSet
	mut var_parentType_mutated := var_parentType
	mut var_fields := rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(var_parentType_mutated,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType')))
	{
		var_parentType_mutated = rt.call_method(var_parentType_mutated, 'getInnermostType',
			[]rt.PhpVal{})
	}
	mut iter_4 := rt.get_property(var_selectionSet_mutated, 'selections').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_selection := item_4.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_selection,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))
		{
			mut var_fieldName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
			mut var_aliasName := if !(rt.get_property(rt.get_property(var_selection, 'alias'),
				'value')).is_null() {
				rt.get_property(rt.get_property(var_selection, 'alias'), 'value')
			} else {
				var_fieldName
			}
			if rt.is_true(rt.identical(var_fieldName,
				Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_name_field_name()))
			{
				continue
			}
			rt.call_function('assert', [
				rt.new_bool(rt.instance_of(var_parentType_mutated,
					'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_HasFieldsType')),
				rt.new_string('ensured by query validation'),
			])
			var_aliasInfo = var_fields.array_get(var_fieldName).array_get(var_aliasName)
			mut var_fieldDef := rt.call_method(var_parentType_mutated, 'getField', [
				var_fieldName.clone(),
			])
			mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
			mut iife_result_0 := iife_temp_0.getargumentvalues(var_fieldDef.clone(),
				var_selection.clone(), this.variableValues)
			var_aliasInfo.array_set('args', iife_result_0)
			mut var_fieldType := rt.call_method(var_fieldDef, 'getType', []rt.PhpVal{})
			mut var_namedFieldType := var_fieldType.clone()
			if rt.is_true(rt.new_bool(rt.instance_of(var_namedFieldType,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType')))
			{
				var_namedFieldType = rt.call_method(var_namedFieldType, 'getInnermostType',
					[]rt.PhpVal{})
			}
			var_aliasInfo.array_set('type', var_namedFieldType.clone())
			if descend <= 0 {
				continue
			}
			mut var_nestedSelectionSet := rt.get_property(var_selection, 'selectionSet')
			if rt.is_true(rt.identical(var_nestedSelectionSet, rt.new_null())) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.instance_of(var_namedFieldType,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))
			{
				var_aliasInfo.array_set('unions', this.foldselectionwithalias(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_nestedSelectionSet),
					descend, mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType)))
				continue
			}
			var_aliasInfo.array_set('selectionSet', this.foldselectionwithalias(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_nestedSelectionSet),
				descend - 1, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType)))
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))
		{
			mut var_spreadName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
			mut var_fragment := if !(this.fragments.array_get(var_spreadName)).is_null() {
				this.fragments.array_get(var_spreadName)
			} else {
				rt.new_null()
			}
			if rt.is_true(rt.identical(var_fragment, rt.new_null())) {
				continue
			}
			var_fieldType = rt.call_method(this.schema, 'getType', [
				rt.get_property(rt.get_property(rt.get_property(var_fragment, 'typeCondition'),
					'name'), 'value'),
			])
			rt.call_function('assert', [
				rt.new_bool(rt.instance_of(var_fieldType,
					'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')),
				rt.new_string('ensured by query validation'),
			])
			var_fields = rt.call_function('array_merge_recursive', [
				this.foldselectionwithalias(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fragment,
					'selectionSet')), descend, mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType)),
				var_fields.clone(),
			])
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))
		{
			mut var_typeCondition := rt.get_property(var_selection, 'typeCondition')
			var_fieldType = if rt.is_true(rt.identical(var_typeCondition, rt.new_null())) { var_parentType_mutated } else { rt.call_method(this.schema, 'getType', [
					rt.get_property(rt.get_property(var_typeCondition, 'name'), 'value'),
				]) }
			rt.call_function('assert', [
				rt.new_bool(rt.instance_of(var_fieldType,
					'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')),
				rt.new_string('ensured by query validation'),
			])
			if rt.is_true(rt.new_bool(rt.instance_of(var_parentType_mutated,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))
			{
				rt.call_function('assert', [
					rt.new_bool(rt.instance_of(var_fieldType,
						'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')),
					rt.new_string('ensured by query validation'),
				])
				var_fieldTypeInfo = var_fields.array_get(rt.call_method(var_fieldType, 'name',
					[]rt.PhpVal{}))
				var_fieldTypeInfo.array_set('type', var_fieldType.clone())
				var_fieldTypeInfo.array_set('selectionSet', this.foldselectionwithalias(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection,
					'selectionSet')), descend, mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType)))
				continue
			}
			var_fields = rt.call_function('array_merge_recursive', [
				this.foldselectionwithalias(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection,
					'selectionSet')), descend, mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_fieldType)),
				var_fields.clone(),
			])
		}
	}
	return var_fields.clone()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_resolveinfo(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal, arg_7 rt.PhpVal, arg_8 rt.PhpVal, arg_9 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo{
		PhpObjectBase:   rt.PhpObjectBase{}
		fieldDefinition: rt.new_null()
		fieldName:       rt.new_null()
		returnType:      rt.new_null()
		fieldNodes:      rt.new_null()
		parentType:      rt.new_null()
		path:            rt.new_null()
		unaliasedPath:   rt.new_null()
		schema:          rt.new_null()
		fragments:       rt.new_array()
		rootValue:       rt.new_null()
		operation:       rt.new_null()
		variableValues:  rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_queryplan(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_values(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ArrayObject](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 5 {
				args[5]
			} else {
				rt.new_null()
			})
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](if args.len > 7 {
				args[7]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 8 {
				args[8]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_9 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 9 {
				args[9]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut
				dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, dispatch_arg_6, mut
				dispatch_arg_7, mut dispatch_arg_8, mut dispatch_arg_9)
			return rt.new_null()
		}
		'getFieldSelection' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.getfieldselection(dispatch_arg_0)
		}
		'getFieldSelectionWithAliases' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.getfieldselectionwithaliases(dispatch_arg_0)
		}
		'lookAhead' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.lookahead(mut dispatch_arg_0)
		}
		'foldSelectionSet' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.foldselectionset(mut dispatch_arg_0, dispatch_arg_1)
		}
		'foldSelectionWithAlias' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.foldselectionwithalias(mut dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fieldDefinition' { return this.fieldDefinition }
		'fieldName' { return this.fieldName }
		'returnType' { return this.returnType }
		'fieldNodes' { return this.fieldNodes }
		'parentType' { return this.parentType }
		'path' { return this.path }
		'unaliasedPath' { return this.unaliasedPath }
		'schema' { return this.schema }
		'fragments' { return this.fragments }
		'rootValue' { return this.rootValue }
		'operation' { return this.operation }
		'variableValues' { return this.variableValues }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fieldDefinition' {
			this.fieldDefinition = val
			return true
		}
		'fieldName' {
			this.fieldName = val
			return true
		}
		'returnType' {
			this.returnType = val
			return true
		}
		'fieldNodes' {
			this.fieldNodes = val
			return true
		}
		'parentType' {
			this.parentType = val
			return true
		}
		'path' {
			this.path = val
			return true
		}
		'unaliasedPath' {
			this.unaliasedPath = val
			return true
		}
		'schema' {
			this.schema = val
			return true
		}
		'fragments' {
			this.fragments = val
			return true
		}
		'rootValue' {
			this.rootValue = val
			return true
		}
		'operation' {
			this.operation = val
			return true
		}
		'variableValues' {
			this.variableValues = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
