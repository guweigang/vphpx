import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged {
	rt.PhpObjectBase
pub mut:
		comparedFragmentPairs rt.PhpVal = rt.new_null()
		cachedFieldsAndFragmentNames rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	this.comparedFragmentPairs = create_automattic_woocommerce_vendor_graphql_utils_pairset()
	this.cachedFieldsAndFragmentNames = create_automattic_woocommerce_vendor_graphql_validator_rules_splobjectstorage()
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_selectionSet := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_responseName := rt.new_null()
	mut var_reason := rt.new_null()
	mut var_fields1 := rt.new_null()
	mut var_fields2 := rt.new_null()
	mut var_conflicts := this.findconflictswithinselectionset(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](var_context.getparenttype()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_selectionSet))
	{
		mut iter_1 := var_conflicts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_conflict := item_1.val
			// unsupported assign target: Expr_List
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged.fieldsconflictmessage((var_responseName).str(), var_reason.dup()), rt.call_function('array_merge', [var_fields1.dup(), var_fields2.dup()])))
		}
	}
	return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.selection_set(), val: rt.new_closure(closure_1_fn) }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) findconflictswithinselectionset(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type, mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode) rt.PhpVal {
	mut var_fieldMap := rt.new_null()
	mut var_fragmentNames := rt.new_null()
	// unsupported assign target: Expr_List
	mut var_conflicts := rt.new_array()
	this.collectconflictswithin(mut var_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_conflicts), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_fieldMap))
	mut var_fragmentNamesLength := rt.new_int(rt.new_int(var_fragmentNames.dup().array_count()))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_comparedFragments := rt.new_array()
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_fragmentNamesLength))) { break }
				this.collectconflictsbetweenfieldsandfragment(mut var_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_conflicts), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_comparedFragments), false, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_fieldMap), (var_fragmentNames.array_get(var_i)).str())
				{
					mut var_j := rt.add(var_i, rt.new_int(1))
					for {
						if !(rt.is_true(rt.less(var_j, var_fragmentNamesLength))) { break }
						this.collectconflictsbetweenfragments(mut var_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_conflicts), false, (var_fragmentNames.array_get(var_i)).str(), (var_fragmentNames.array_get(var_j)).str())
						rt.pre_inc(var_j)
					}
				}
				rt.pre_inc(var_i)
			}
		}
	}
	return var_conflicts.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) getfieldsandfragmentnames(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type, mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode) rt.PhpVal {
	if !(this.cachedFieldsAndFragmentNames.array_isset(var_selectionSet)) {
		mut var_astAndDefs := rt.new_array()
		mut var_fragmentNames := rt.new_array()
		this.internalcollectfieldsandfragmentnames(mut var_context, mut var_parentType, mut var_selectionSet, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_astAndDefs), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_fragmentNames))
		return this.cachedFieldsAndFragmentNames.array_set(var_selectionSet, rt.create_array([rt.ArrayItem{ key: none, val: var_astAndDefs }, rt.ArrayItem{ key: none, val: rt.func_array_keys(var_fragmentNames.dup()) }]))
	}
	return this.cachedFieldsAndFragmentNames.array_get(var_selectionSet)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) internalcollectfieldsandfragmentnames(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type, mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, mut var_astAndDefs Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, mut var_fragmentNames Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array)  {
	mut var_astAndDefs_mutated := var_astAndDefs
	mut var_fragmentNames_mutated := var_fragmentNames
	{
		mut iter_1 := rt.get_property(var_selectionSet, 'selections').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_selection := item_1.val
			mut switch_val_1 := rt.new_bool(true)
			if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
				mut var_fieldName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
				mut var_fieldDef := rt.new_null()
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) || rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type', []string{}, var_parentType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))))) && rt.is_true(var_parentType.hasfield(var_fieldName.dup())))) {
					var_fieldDef = var_parentType.getfield(var_fieldName.dup())
				}
				mut var_responseName := if !(rt.get_property(rt.get_property(var_selection, 'alias'), 'value')).is_null() { rt.get_property(rt.get_property(var_selection, 'alias'), 'value') } else { var_fieldName }
				// unsupported expression: Expr_AssignOp_Coalesce
				var_astAndDefs_mutated.array_get_mut(var_responseName).array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_parentType }, rt.ArrayItem{ key: none, val: var_selection }, rt.ArrayItem{ key: none, val: var_fieldDef }]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))) {
				var_fragmentNames_mutated.array_set(rt.get_property(rt.get_property(var_selection, 'name'), 'value'), true)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) {
				mut var_typeCondition := rt.get_property(var_selection, 'typeCondition')
				mut var_inlineFragmentType := if rt.is_true(rt.identical(var_typeCondition, rt.new_null())) { var_parentType } else { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.typefromast(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: var_context.getschema() }, rt.ArrayItem{ key: none, val: 'getType' }]), var_typeCondition.dup()) }
				this.internalcollectfieldsandfragmentnames(mut var_context, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](var_inlineFragmentType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection, 'selectionSet')), mut var_astAndDefs_mutated, mut var_fragmentNames_mutated)
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) collectconflictswithin(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_conflicts Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, mut var_fieldMap Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array)  {
	mut var_conflicts_mutated := var_conflicts
	{
		mut iter_1 := var_fieldMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fields := item_1.val
			mut var_responseName := item_1.key
			mut var_fieldsLength := rt.new_int(rt.new_int(var_fields.dup().array_count()))
			if rt.is_true(rt.less_equal(var_fieldsLength, rt.new_int(1))) {
				continue
			}
			var_fields = this.deduplicatefields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_fields))
			var_fieldsLength = rt.new_int(rt.new_int(var_fields.dup().array_count()))
			if rt.is_true(rt.less_equal(var_fieldsLength, rt.new_int(1))) {
				continue
			}
			{
				mut var_i := rt.new_int(rt.new_int(0))
				for {
					if !(rt.is_true(rt.less(var_i, var_fieldsLength))) { break }
					{
						mut var_j := rt.add(var_i, rt.new_int(1))
						for {
							if !(rt.is_true(rt.less(var_j, var_fieldsLength))) { break }
							mut var_conflict := this.findconflict(mut var_context, false, (var_responseName).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_fields.array_get(var_i)), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_fields.array_get(var_j)))
							if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								var_conflicts_mutated.array_push(var_conflict.dup())
							}
							rt.pre_inc(var_j)
						}
					}
					rt.pre_inc(var_i)
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) deduplicatefields(mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut var_unique := rt.new_array()
	mut var_seen := rt.new_array()
	{
		mut iter_1 := var_fields_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := rt.new_string(this.fieldfingerprint(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_field)))
			if !(var_seen.array_isset(var_key)) {
				var_seen.array_set(var_key, true)
				var_unique.array_push(var_field.dup())
			}
		}
	}
	return var_unique.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) fieldfingerprint(mut var_field Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) string {
	mut var_parentType := rt.new_null()
	mut var_ast := rt.new_null()
	// unsupported assign target: Expr_List
	mut var_parentTypeId := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('spl_object_id', [var_parentType]) } else { rt.new_string('') }
	mut var_name := rt.get_property(rt.get_property(var_ast, 'name'), 'value')
	mut var_selectionSetId := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('spl_object_id', [rt.get_property(var_ast, 'selectionSet')]) } else { rt.new_string('') }
	mut var_fingerprint := rt.new_string(rt.new_string("${var_parentTypeId.to_string()}:${var_name.to_string()}:${var_selectionSetId.to_string()}"))
	{
		mut iter_1 := rt.get_property(var_ast, 'arguments').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_argument := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return (var_fingerprint).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) findconflict(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, parentFieldsAreMutuallyExclusive bool, responseName string, mut var_field1 Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, mut var_field2 Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) rt.PhpVal {
	mut var_parentType1 := rt.new_null()
	mut var_ast1 := rt.new_null()
	mut var_def1 := rt.new_null()
	mut var_parentType2 := rt.new_null()
	mut var_ast2 := rt.new_null()
	mut var_def2 := rt.new_null()
	mut responseName_mutated := responseName
	// unsupported assign target: Expr_List
	// unsupported assign target: Expr_List
	mut var_areMutuallyExclusive := rt.new_bool(rt.new_bool(var_parentFieldsAreMutuallyExclusive || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.instance_of(var_parentType1, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))))) && rt.is_true(rt.new_bool(rt.instance_of(var_parentType2, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))))
	mut var_type1 := if rt.is_true(rt.identical(var_def1, rt.new_null())) { rt.new_null() } else { rt.call_method(var_def1, 'getType', []rt.PhpVal{}) }
	mut var_type2 := if rt.is_true(rt.identical(var_def2, rt.new_null())) { rt.new_null() } else { rt.call_method(var_def2, 'getType', []rt.PhpVal{}) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_areMutuallyExclusive)))) {
		mut var_name1 := rt.get_property(rt.get_property(var_ast1, 'name'), 'value')
		mut var_name2 := rt.get_property(rt.get_property(var_ast2, 'name'), 'value')
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: responseName_mutated }, rt.ArrayItem{ key: none, val: "${var_name1.to_string()} and ${var_name2.to_string()} are different fields" }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_ast1 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_ast2 }]) }])
		}
		if !(this.samearguments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_ast1, 'arguments')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_ast2, 'arguments')))) {
			return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: responseName_mutated }, rt.ArrayItem{ key: none, val: 'they have differing arguments' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_ast1 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_ast2 }]) }])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && this.dotypesconflict(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type1), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type2)))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: responseName_mutated }, rt.ArrayItem{ key: none, val: "they return conflicting types ${var_type1.to_string()} and ${var_type2.to_string()}" }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_ast1 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_ast2 }]) }])
	}
	mut var_selectionSet1 := rt.get_property(var_ast1, 'selectionSet')
	mut var_selectionSet2 := rt.get_property(var_ast2, 'selectionSet')
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_conflicts := this.findconflictsbetweensubselectionsets(mut var_context, (var_areMutuallyExclusive).to_bool(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(var_type1.dup())), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_selectionSet1), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(var_type2.dup())), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](var_selectionSet2))
		return this.subfieldconflicts(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_conflicts), responseName_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](var_ast1), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](var_ast2))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) samearguments(mut var_arguments1 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, mut var_arguments2 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	{
		mut iter_1 := var_arguments1.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_argument1 := item_1.val
			
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) samevalue(mut var_value1 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_value2 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) bool {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) dotypesconflict(mut var_type1 Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_type2 Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	mut var_type1_mutated := var_type1
	mut var_type2_mutated := var_type2
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) findconflictsbetweensubselectionsets(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, areMutuallyExclusive bool, mut var_parentType1 Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type, mut var_selectionSet1 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, mut var_parentType2 Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type, mut var_selectionSet2 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode) rt.PhpVal {
	mut var_fieldMap1 := rt.new_null()
	mut var_fragmentNames1 := rt.new_null()
	mut var_fieldMap2 := rt.new_null()
	mut var_fragmentNames2 := rt.new_null()
	mut areMutuallyExclusive_mutated := areMutuallyExclusive
	mut var_selectionSet1_mutated := var_selectionSet1
	mut var_selectionSet2_mutated := var_selectionSet2
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) collectconflictsbetween(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_conflicts Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, parentFieldsAreMutuallyExclusive bool, mut var_fieldMap1 Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, mut var_fieldMap2 Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array)  {
	mut var_conflicts_mutated := var_conflicts
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) collectconflictsbetweenfieldsandfragment(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_conflicts Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, mut var_comparedFragments Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, areMutuallyExclusive bool, mut var_fieldMap Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, fragmentName string)  {
	mut var_fieldMap2 := rt.new_null()
	mut var_fragmentNames2 := rt.new_null()
	mut var_conflicts_mutated := var_conflicts
	mut var_comparedFragments_mutated := var_comparedFragments
	mut areMutuallyExclusive_mutated := areMutuallyExclusive
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) getreferencedfieldsandfragmentnames(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_fragment Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode) rt.PhpVal {
	mut var_fragment_mutated := var_fragment
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) collectconflictsbetweenfragments(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_conflicts Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, areMutuallyExclusive bool, fragmentName1 string, fragmentName2 string)  {
	mut var_fieldMap1 := rt.new_null()
	mut var_fragmentNames1 := rt.new_null()
	mut var_fieldMap2 := rt.new_null()
	mut var_fragmentNames2 := rt.new_null()
	mut var_conflicts_mutated := var_conflicts
	mut areMutuallyExclusive_mutated := areMutuallyExclusive
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) subfieldconflicts(mut var_conflicts Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, responseName string, mut var_ast1 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode, mut var_ast2 Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) rt.PhpVal {
	mut var_conflicts_mutated := var_conflicts
	mut responseName_mutated := responseName
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged.fieldsconflictmessage(responseName string, var_reasonOrReasons rt.PhpVal) string {
	mut responseName_mutated := responseName
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged.reasonmessage(var_reasonOrReasons rt.PhpVal) string {
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_SplObjectStorage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_overlappingfieldscanbemerged() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged{
		PhpObjectBase: rt.PhpObjectBase{}
		comparedFragmentPairs: rt.new_null()
		cachedFieldsAndFragmentNames: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_pairset() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_splobjectstorage() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_SplObjectStorage {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_SplObjectStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'findConflictsWithinSelectionSet' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.findconflictswithinselectionset(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'getFieldsAndFragmentNames' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.getfieldsandfragmentnames(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'internalCollectFieldsAndFragmentNames' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.internalcollectfieldsandfragmentnames(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'collectConflictsWithin' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.collectconflictswithin(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'deduplicateFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.deduplicatefields(mut dispatch_arg_0)
		}
		'fieldFingerprint' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.fieldfingerprint(mut dispatch_arg_0))
		}
		'findConflict' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 4 { args[4] } else { rt.new_null() })
			return this.findconflict(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
		}
		'sameArguments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.samearguments(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'sameValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.samevalue(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'doTypesConflict' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.dotypesconflict(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'findConflictsBetweenSubSelectionSets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?Type](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 5 { args[5] } else { rt.new_null() })
			return this.findconflictsbetweensubselectionsets(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5)
		}
		'collectConflictsBetween' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.collectconflictsbetween(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'collectConflictsBetweenFieldsAndFragment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			this.collectconflictsbetweenfieldsandfragment(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'getReferencedFieldsAndFragmentNames' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.getreferencedfieldsandfragmentnames(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'collectConflictsBetweenFragments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			this.collectconflictsbetweenfragments(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'subfieldConflicts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.subfieldconflicts(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'fieldsConflictMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged.fieldsconflictmessage(dispatch_arg_0, dispatch_arg_1))
		}
		'reasonMessage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged.reasonmessage(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'comparedFragmentPairs' { return this.comparedFragmentPairs }
		'cachedFieldsAndFragmentNames' { return this.cachedFieldsAndFragmentNames }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_OverlappingFieldsCanBeMerged) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'comparedFragmentPairs' { this.comparedFragmentPairs = val; return true }
		'cachedFieldsAndFragmentNames' { this.cachedFieldsAndFragmentNames = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_SplObjectStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_SplObjectStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_SplObjectStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_overlappingfieldscanbemerged_php() {
	// unsupported statement: Stmt_Declare
}
