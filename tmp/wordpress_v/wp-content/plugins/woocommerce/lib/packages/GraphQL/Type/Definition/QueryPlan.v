import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan {
	rt.PhpObjectBase
pub mut:
		typeToFields rt.PhpVal = rt.new_array()
		schema rt.PhpVal = rt.new_null()
		queryPlan rt.PhpVal = rt.new_array()
		variableValues rt.PhpVal = rt.new_null()
		fragments rt.PhpVal = rt.new_null()
		groupImplementorFields rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) construct(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_iterable, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, mut var_fragments Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array)  {
	this.schema = var_schema.dup()
	this.variableValues = var_variableValues.dup()
	this.fragments = var_fragments.dup()
	this.groupImplementorFields = if !(var_options.array_get('groupImplementorFields')).is_null() { var_options.array_get('groupImplementorFields') } else { rt.new_bool(false) }
	this.analyzequeryplan(mut var_parentType, mut var_fieldNodes)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) queryplan() rt.PhpVal {
	return this.queryPlan
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) getreferencedtypes() rt.PhpVal {
	return rt.func_array_keys(this.typeToFields)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) hastype(type string) bool {
	mut type_mutated := type
	return (rt.new_bool(this.typeToFields.array_isset(rt.new_string(type_mutated)))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) getreferencedfields() rt.PhpVal {
	mut var_allFields := rt.new_array()
	{
		mut iter_1 := this.typeToFields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fields := item_1.val
			{
				mut iter_2 := var_fields.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var__ := item_2.val
					mut var_field := item_2.key
					var_allFields.array_set(var_field, true)
				}
			}
		}
	}
	return rt.func_array_keys(var_allFields.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) hasfield(field string) bool {
	{
		mut iter_1 := this.typeToFields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fields := item_1.val
			if rt.is_true(rt.new_bool(var_fields.dup().array_isset(rt.new_string(field)))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) subfields(typename string) rt.PhpVal {
	return rt.func_array_keys(if !(this.typeToFields.array_get(typename)).is_null() { this.typeToFields.array_get(typename) } else { rt.new_array() })
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) analyzequeryplan(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_iterable)  {
	mut var_queryPlan := rt.new_array()
	mut var_implementors := rt.new_array()
	{
		mut iter_1 := var_fieldNodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fieldNode := item_1.val
			if rt.is_true(rt.identical(rt.get_property(var_fieldNode, 'selectionSet'), rt.new_null())) {
				continue
			}
			mut var_type := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(rt.call_method(var_parentType.getfield(rt.get_property(rt.get_property(var_fieldNode, 'name'), 'value')), 'getType', []rt.PhpVal{}))
			mut var_subfields := this.analyzeselectionset(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fieldNode, 'selectionSet')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_implementors))
			var_queryPlan = this.arraymergedeep(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_queryPlan), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_subfields))
		}
	}
	if rt.is_true(this.groupImplementorFields) {
		this.queryPlan = rt.create_array([rt.ArrayItem{ key: 'fields', val: var_queryPlan }])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			this.queryPlan.array_set('implementors', var_implementors.dup())
		}
	} else {
		this.queryPlan = var_queryPlan.dup()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) analyzeselectionset(mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_implementors Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) rt.PhpVal {
	mut var_implementors_mutated := var_implementors
	mut var_fields := rt.new_array()
	var_implementors_mutated = rt.new_array()
	{
		mut iter_1 := rt.get_property(var_selectionSet, 'selections').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_selection := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode'))) {
				mut var_fieldName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
				if rt.is_true(rt.identical(var_fieldName, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_name_field_name())) {
					continue
				}
				rt.call_function('assert', [rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_HasFieldsType')), rt.new_string('ensured by query validation')])
				mut var_type := var_parentType.getfield(var_fieldName.dup())
				mut var_selectionType := rt.call_method(var_type, 'getType', []rt.PhpVal{})
				mut var_subImplementors := rt.new_array()
				mut var_nestedSelectionSet := rt.get_property(var_selection, 'selectionSet')
				mut var_subfields := if rt.is_true(rt.identical(var_nestedSelectionSet, rt.new_null())) { rt.new_array() } else { this.analyzesubfields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_selectionType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_nestedSelectionSet), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_subImplementors)) }
				var_fields.array_set(var_fieldName, rt.create_array([rt.ArrayItem{ key: 'type', val: var_selectionType }, rt.ArrayItem{ key: 'fields', val: var_subfields }, rt.ArrayItem{ key: 'args', val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}; return temp.getargumentvalues(arg_0, arg_1, arg_2) }(var_type.dup(), var_selection.dup(), this.variableValues) }]))
				if rt.is_true(rt.new_bool(rt.is_true(this.groupImplementorFields) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_fields.array_get_mut(var_fieldName).array_set('implementors', var_subImplementors.dup())
				}
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode'))) {
				mut var_spreadName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
				mut var_fragment := if !(this.fragments.array_get(var_spreadName)).is_null() { this.fragments.array_get(var_spreadName) } else { rt.new_null() }
				if rt.is_true(rt.identical(var_fragment, rt.new_null())) {
					continue
				}
				var_type = rt.call_method(this.schema, 'getType', [rt.get_property(rt.get_property(rt.get_property(var_fragment, 'typeCondition'), 'name'), 'value')])
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')), rt.new_string('ensured by query validation')])
				var_subfields = this.analyzesubfields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fragment, 'selectionSet')), rt.new_null())
				var_fields = this.mergefields(mut var_parentType, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_fields), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_subfields), mut var_implementors_mutated)
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode'))) {
				mut var_typeCondition := rt.get_property(var_selection, 'typeCondition')
				var_type = if rt.is_true(rt.identical(var_typeCondition, rt.new_null())) { var_parentType } else { rt.call_method(this.schema, 'getType', [rt.get_property(rt.get_property(var_typeCondition, 'name'), 'value')]) }
				rt.call_function('assert', [rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')), rt.new_string('ensured by query validation')])
				var_subfields = this.analyzesubfields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection, 'selectionSet')), rt.new_null())
				var_fields = this.mergefields(mut var_parentType, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_fields), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_subfields), mut var_implementors_mutated)
			}
		}
	}
	mut var_parentTypeName := var_parentType.name()
	// unsupported expression: Expr_AssignOp_Coalesce
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__ := item_1.val
			mut var_fieldName := item_1.key
			this.typeToFields.array_get_mut(var_parentTypeName).array_set(var_fieldName, true)
		}
	}
	return var_fields.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) analyzesubfields(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, mut var_implementors Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_implementors_mutated := var_implementors
	var_type_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_type_mutated))
	return if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType'))))) { this.analyzeselectionset(mut var_selectionSet, mut var_type_mutated, mut var_implementors_mutated) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) mergefields(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, mut var_subfields Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, mut var_implementors Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_fields_mutated := var_fields
	mut var_subfields_mutated := var_subfields
	mut var_implementors_mutated := var_implementors
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.groupImplementorFields) && rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType')))))))) {
		mut var_name := rt.get_property(var_type_mutated, 'name')
		rt.call_function('assert', [rt.new_bool(var_name.dup().is_string())])
		var_implementors_mutated.array_set(var_name, rt.create_array([rt.ArrayItem{ key: 'type', val: var_type_mutated }, rt.ArrayItem{ key: 'fields', val: this.arraymergedeep(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if !(var_implementors_mutated.array_get(var_name).array_get('fields')).is_null() { var_implementors_mutated.array_get(var_name).array_get('fields') } else { rt.new_array() }), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](rt.call_function('array_diff_key', [var_subfields_mutated.dup(), var_fields_mutated.dup()]))) }]))
		var_fields_mutated = this.arraymergedeep(mut var_fields_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](rt.call_function('array_intersect_key', [var_subfields_mutated.dup(), var_fields_mutated.dup()])))
	} else {
		var_fields_mutated = this.arraymergedeep(mut var_subfields_mutated, mut var_fields_mutated)
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array', []string{}, var_fields_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) arraymergedeep(mut var_array1 Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array, mut var_array2 Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) rt.PhpVal {
	mut var_array1_mutated := var_array1
	{
		mut iter_1 := var_array2.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_key.dup().is_long() || var_key.dup().is_double())) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value.dup(), var_array1_mutated.dup(), rt.new_bool(true)]))))) {
					var_array1_mutated.array_push(var_value.dup())
				}
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_array())) && var_array1_mutated.array_isset(var_key))) && rt.is_true(rt.new_bool(var_array1_mutated.array_get(var_key).is_array())))) {
				var_array1_mutated.array_set(var_key, this.arraymergedeep(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_array1_mutated.array_get(var_key)), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_value)))
			} else {
				var_array1_mutated.array_set(var_key, var_value.dup())
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array', []string{}, var_array1_mutated)
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_queryplan(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan{
		PhpObjectBase: rt.PhpObjectBase{}
		typeToFields: rt.new_array()
		schema: rt.new_null()
		queryPlan: rt.new_array()
		variableValues: rt.new_null()
		fragments: rt.new_null()
		groupImplementorFields: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_values() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_iterable](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 5 { args[5] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'queryPlan' {
			return this.queryplan()
		}
		'getReferencedTypes' {
			return this.getreferencedtypes()
		}
		'hasType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hastype(dispatch_arg_0))
		}
		'getReferencedFields' {
			return this.getreferencedfields()
		}
		'hasField' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasfield(dispatch_arg_0))
		}
		'subFields' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.subfields(dispatch_arg_0)
		}
		'analyzeQueryPlan' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_iterable](if args.len > 1 { args[1] } else { rt.new_null() })
			this.analyzequeryplan(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'analyzeSelectionSet' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.analyzeselectionset(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'analyzeSubFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.analyzesubfields(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'mergeFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 4 { args[4] } else { rt.new_null() })
			return this.mergefields(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
		}
		'arrayMergeDeep' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.arraymergedeep(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'typeToFields' { return this.typeToFields }
		'schema' { return this.schema }
		'queryPlan' { return this.queryPlan }
		'variableValues' { return this.variableValues }
		'fragments' { return this.fragments }
		'groupImplementorFields' { return this.groupImplementorFields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_QueryPlan) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'typeToFields' { this.typeToFields = val; return true }
		'schema' { this.schema = val; return true }
		'queryPlan' { this.queryPlan = val; return true }
		'variableValues' { this.variableValues = val; return true }
		'fragments' { this.fragments = val; return true }
		'groupImplementorFields' { this.groupImplementorFields = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_queryplan_php() {
	// unsupported statement: Stmt_Declare
}
