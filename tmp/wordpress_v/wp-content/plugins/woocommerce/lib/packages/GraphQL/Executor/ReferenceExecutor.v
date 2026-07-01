import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor {
	rt.PhpObjectBase
pub mut:
		UNDEFINED rt.PhpVal = rt.new_null()
		exeContext rt.PhpVal = rt.new_null()
		subFieldCache rt.PhpVal = rt.new_null()
		fieldArgsCache rt.PhpVal = rt.new_null()
		schemaMetaFieldDef rt.PhpVal = rt.new_null()
		typeMetaFieldDef rt.PhpVal = rt.new_null()
		typeNameMetaFieldDef rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) construct(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext)  {
	if !(!(// unsupported expression: Expr_StaticPropertyFetch).is_null()) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	this.exeContext = var_context.dup()
	this.subFieldCache = create_automattic_woocommerce_vendor_graphql_executor_splobjectstorage()
	this.fieldArgsCache = create_automattic_woocommerce_vendor_graphql_executor_splobjectstorage()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.create(mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_documentNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, var_rootValue rt.PhpVal, var_contextValue rt.PhpVal, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable) rt.PhpVal {
	mut var_promiseAdapter_mutated := var_promiseAdapter
	mut var_schema_mutated := var_schema
	mut var_variableValues_mutated := var_variableValues
	mut var_argsMapper_mutated := var_argsMapper
	mut var_exeContext := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.buildexecutioncontext(mut var_schema_mutated, mut var_documentNode, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_rootValue), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string](var_contextValue), mut var_variableValues_mutated, mut var_operationName, mut var_fieldResolver, if !(var_argsMapper_mutated).is_null() { var_argsMapper_mutated } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}; return temp.getdefaultargsmapper() }() }, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter', []string{}, var_promiseAdapter_mutated))
	if rt.is_true(rt.new_bool(var_exeContext.dup().is_array())) {
		mut var_executionResult := create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), var_exeContext.dup())
		mut var_fulfilledPromise := rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [var_executionResult])
		return create_automattic_woocommerce_vendor_graphql_executor_promiseexecutor(var_fulfilledPromise.dup())
	}
	return create_automattic_woocommerce_vendor_graphql_executor_static(var_exeContext.dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.buildexecutioncontext(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_documentNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, var_rootValue rt.PhpVal, var_contextValue rt.PhpVal, mut var_rawVariableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter) rt.PhpVal {
	mut var_coercionErrors := rt.new_null()
	mut var_coercedVariableValues := rt.new_null()
	mut var_schema_mutated := var_schema
	mut var_argsMapper_mutated := var_argsMapper
	mut var_promiseAdapter_mutated := var_promiseAdapter
	mut var_errors := rt.new_array()
	mut var_fragments := rt.new_array()
	mut var_operation := rt.new_null()
	mut var_hasMultipleAssumedOperations := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := rt.get_property(var_documentNode, 'definitions').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_definition := item_1.val
			mut switch_val_1 := rt.new_bool(true)
			if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_operationName, rt.new_null())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_hasMultipleAssumedOperations = rt.new_bool(rt.new_bool(true))
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_operationName, rt.new_null())) || rt.is_true(rt.new_bool(!(rt.get_property(var_definition, 'name')).is_null() && rt.is_true(rt.identical(rt.get_property(rt.get_property(var_definition, 'name'), 'value'), var_operationName)))))) {
					var_operation = var_definition
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode')))) {
				var_fragments.array_set(rt.get_property(rt.get_property(var_definition, 'name'), 'value'), var_definition.dup())
			}
		}
	}
	if rt.is_true(rt.identical(var_operation, rt.new_null())) {
		mut var_message := rt.new_string(if rt.is_true(rt.identical(var_operationName, rt.new_null())) { rt.new_string('Must provide an operation.') } else { rt.new_string("Unknown operation named \"${var_operationName.to_string()}\".") })
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(var_message.dup()))
	} else if rt.is_true(var_hasMultipleAssumedOperations) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Must provide operation name if query contains multiple operations.')))
	}
	mut var_variableValues := rt.new_null()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported assign target: Expr_List
		if rt.is_true(rt.identical(var_coercionErrors, rt.new_null())) {
			var_variableValues = var_coercedVariableValues
		} else {
			var_errors = rt.call_function('array_merge', [var_errors.dup(), var_coercionErrors.dup()])
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_errors.dup()
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_operation, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')), rt.new_string('Has operation if no errors.')])
	rt.call_function('assert', [rt.new_bool(var_variableValues.dup().is_array()), rt.new_string('Has variables if no errors.')])
	return create_automattic_woocommerce_vendor_graphql_executor_executioncontext(var_schema_mutated.dup(), var_fragments.dup(), var_rootValue.dup(), var_contextValue.dup(), var_operation.dup(), var_variableValues.dup(), var_errors.dup(), var_fieldResolver.dup(), var_argsMapper_mutated.dup(), var_promiseAdapter_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) doexecute() rt.PhpVal {
	mut var_data := this.executeoperation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](rt.get_property(this.exeContext, 'operation')), rt.get_property(this.exeContext, 'rootValue'))
	mut var_result := this.buildresponse(var_data.dup())
	mut var_promise := this.getpromise(var_result.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_promise.dup()
	}
	return rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'createFulfilled', [var_result.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) buildresponse(var_data rt.PhpVal) rt.PhpVal {
	mut var_resolved := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_resolved := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.buildresponse(var_resolved.dup())
	}
		return rt.call_method(var_data_mutated, 'then', [rt.new_closure(closure_1_fn)])
	}
	mut var_promiseAdapter := rt.get_property(this.exeContext, 'promiseAdapter')
	if rt.is_true(rt.call_method(var_promiseAdapter, 'isThenable', [var_data_mutated.dup()])) {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_resolved := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.buildresponse(var_resolved.dup())
	}
		return rt.call_method(rt.call_method(var_promiseAdapter, 'convertThenable', [var_data_mutated.dup()]), 'then', [rt.new_closure(closure_2_fn)])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data_mutated = rt.cast_array(var_data_mutated)
	}
	return create_automattic_woocommerce_vendor_graphql_executor_executionresult(var_data_mutated.dup(), rt.get_property(this.exeContext, 'errors'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) executeoperation(mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode, var_rootValue rt.PhpVal) rt.PhpVal {
	mut var_operation_mutated := var_operation
	mut var_type := this.getoperationroottype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](rt.get_property(this.exeContext, 'schema')), mut var_operation_mutated)
	mut var_fields := this.collectfields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](var_type), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_operation_mutated, 'selectionSet')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](create_automattic_woocommerce_vendor_graphql_executor_arrayobject()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](create_automattic_woocommerce_vendor_graphql_executor_arrayobject()))
	mut var_path := rt.new_array()
	mut var_unaliasedPath := rt.new_array()
	mut var_result := if rt.is_true(rt.identical(rt.get_property(var_operation_mutated, 'operation'), rt.new_string('mutation'))) { this.executefieldsserially(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](var_type), var_rootValue.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_path), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_unaliasedPath), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_fields), rt.get_property(this.exeContext, 'contextValue')) } else { this.executefields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](var_type), var_rootValue.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_path), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_unaliasedPath), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_fields), rt.get_property(this.exeContext, 'contextValue')) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_promise := this.getpromise(var_result.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.call_method(var_promise, 'then', [rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', ['ExecutorImplementation'], &this) }, rt.ArrayItem{ key: none, val: 'onError' }])])
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_result.dup()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error') {
		mut var_error := var_e_1.dup()
		rt.call_method(this.exeContext, 'addError', [var_error.dup()])
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) onerror(var_error rt.PhpVal) rt.PhpVal {
	mut var_error_mutated := var_error
	if rt.is_true(rt.new_bool(rt.instance_of(var_error_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) {
		rt.call_method(this.exeContext, 'addError', [var_error_mutated.dup()])
		return rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'createFulfilled', []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) getoperationroottype(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode)  {
	mut var_schema_mutated := var_schema
	mut var_operation_mutated := var_operation
	mut switch_val_2 := rt.get_property(var_operation_mutated, 'operation')
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('query'))) {
		mut var_queryType := rt.call_method(var_schema_mutated, 'getQueryType', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_queryType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Schema does not define the required query root type.'), rt.create_array([rt.ArrayItem{ key: none, val: var_operation_mutated }]))))
		}
		return var_queryType.dup()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mutation'))) {
		mut var_mutationType := rt.call_method(var_schema_mutated, 'getMutationType', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_mutationType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Schema is not configured for mutations.'), rt.create_array([rt.ArrayItem{ key: none, val: var_operation_mutated }]))))
		}
		return var_mutationType.dup()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('subscription'))) {
		mut var_subscriptionType := rt.call_method(var_schema_mutated, 'getSubscriptionType', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_subscriptionType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Schema is not configured for subscriptions.'), rt.create_array([rt.ArrayItem{ key: none, val:  }]))))
		}
		return var_subscriptionType.dup()
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(, )))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) collectfields(mut var_runtimeType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_visitedFragmentNames Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) rt.PhpVal {
	mut var_runtimeType_mutated := var_runtimeType
	mut var_fields_mutated := var_fields
	mut var_visitedFragmentNames_mutated := var_visitedFragmentNames
	mut var_exeContext := 
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_selection := item_1.val
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) shouldincludenode(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode) bool {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.getfieldentrykey(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) string {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) doesfragmentconditionmatch(mut var_fragment Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) bool {
	mut var_fragment_mutated := var_fragment
	mut var_type_mutated := var_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) executefieldsserially(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_rootValue rt.PhpVal, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_resolvedResults := rt.new_null()
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_fields_mutated := var_fields
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) resolvefield(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_rootValue rt.PhpVal, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, responseName string, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) getfielddef(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, fieldName string) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut fieldName_mutated := fieldName
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) resolvefieldvalueorerror(mut var_fieldDef Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition, mut var_fieldNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode, mut var_resolveFn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, var_rootValue rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_fieldDef_mutated := var_fieldDef
	mut var_fieldNode_mutated := var_fieldNode
	mut var_resolveFn_mutated := var_resolveFn
	mut var_argsMapper_mutated := var_argsMapper
	mut var_info_mutated := var_info
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completevaluecatchingerror(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_resolved := rt.new_null()
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) handlefielderror(var_rawError rt.PhpVal, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type)  {
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_returnType_mutated := var_returnType
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completevalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) ispromise(var_value rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) getpromise(var_value rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) promisereduce(mut var_values Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_callback Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, var_initialValue rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completelistvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_results Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_iterable, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_results_mutated := var_results
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completeleafvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType, var_result rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_result_mutated := var_result
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completeabstractvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_resolvedRuntimeType := rt.new_null()
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) defaulttyperesolver(var_value rt.PhpVal, var_contextValue rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType) rt.PhpVal {
	mut var_info_mutated := var_info
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completeobjectvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) invalidreturntypeerror(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_result rt.PhpVal, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_result_mutated := var_result
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) collectandexecutesubfields(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) collectsubfields(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) executefields(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_rootValue rt.PhpVal, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_fields_mutated := var_fields
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.fixresultsifemptyarray(var_results rt.PhpVal) rt.PhpVal {
	mut var_results_mutated := var_results
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) promiseforassocarray(mut var_assoc Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) ensurevalidruntimetype(var_runtimeTypeOrName rt.PhpVal, mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, var_result rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_result_mutated := var_result
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) maybescopecontext(var_contextValue rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_referenceexecutor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor{
		PhpObjectBase: rt.PhpObjectBase{}
		UNDEFINED: rt.new_null()
		exeContext: rt.new_null()
		subFieldCache: rt.new_null()
		fieldArgsCache: rt.new_null()
		schemaMetaFieldDef: rt.new_null()
		typeMetaFieldDef: rt.new_null()
		typeNameMetaFieldDef: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_splobjectstorage() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_executor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_executionresult() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promiseexecutor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_static() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static{
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

fn create_automattic_woocommerce_vendor_graphql_executor_executioncontext() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_arrayobject() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 7 { args[7] } else { rt.new_null() })
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable](if args.len > 8 { args[8] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.create(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7, mut dispatch_arg_8)
		}
		'buildExecutionContext' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 7 { args[7] } else { rt.new_null() })
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 8 { args[8] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.buildexecutioncontext(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7, mut dispatch_arg_8)
		}
		'doExecute' {
			return this.doexecute()
		}
		'buildResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.buildresponse(dispatch_arg_0)
		}
		'executeOperation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.executeoperation(mut dispatch_arg_0, dispatch_arg_1)
		}
		'onError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.onerror(dispatch_arg_0)
		}
		'getOperationRootType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](if args.len > 1 { args[1] } else { rt.new_null() })
			this.getoperationroottype(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'collectFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.collectfields(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'shouldIncludeNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.shouldincludenode(mut dispatch_arg_0))
		}
		'getFieldEntryKey' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.getfieldentrykey(mut dispatch_arg_0))
		}
		'doesFragmentConditionMatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.doesfragmentconditionmatch(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'executeFieldsSerially' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.executefieldsserially(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5)
		}
		'resolveField' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 5 { args[5] } else { rt.new_null() })
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.resolvefield(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, dispatch_arg_6)
		}
		'getFieldDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.getfielddef(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'resolveFieldValueOrError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 5 { args[5] } else { rt.new_null() })
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.resolvefieldvalueorerror(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5, dispatch_arg_6)
		}
		'completeValueCatchingError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.completevaluecatchingerror(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		'handleFieldError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 4 { args[4] } else { rt.new_null() })
			this.handlefielderror(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'completeValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.completevalue(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		'isPromise' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.ispromise(dispatch_arg_0))
		}
		'getPromise' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getpromise(dispatch_arg_0)
		}
		'promiseReduce' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.promisereduce(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'completeListValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_iterable](if args.len > 5 { args[5] } else { rt.new_null() })
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.completelistvalue(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, dispatch_arg_6)
		}
		'completeLeafValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.completeleafvalue(mut dispatch_arg_0, dispatch_arg_1)
		}
		'completeAbstractValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.completeabstractvalue(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		'defaultTypeResolver' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.defaulttyperesolver(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'completeObjectValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.completeobjectvalue(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		'invalidReturnTypeError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.invalidreturntypeerror(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'collectAndExecuteSubfields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.collectandexecutesubfields(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'collectSubFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.collectsubfields(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'executeFields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.executefields(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5)
		}
		'fixResultsIfEmptyArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.fixresultsifemptyarray(dispatch_arg_0)
		}
		'promiseForAssocArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.promiseforassocarray(mut dispatch_arg_0)
		}
		'ensureValidRuntimeType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.ensurevalidruntimetype(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
		}
		'maybeScopeContext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.maybescopecontext(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'UNDEFINED' { return this.UNDEFINED }
		'exeContext' { return this.exeContext }
		'subFieldCache' { return this.subFieldCache }
		'fieldArgsCache' { return this.fieldArgsCache }
		'schemaMetaFieldDef' { return this.schemaMetaFieldDef }
		'typeMetaFieldDef' { return this.typeMetaFieldDef }
		'typeNameMetaFieldDef' { return this.typeNameMetaFieldDef }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'UNDEFINED' { this.UNDEFINED = val; return true }
		'exeContext' { this.exeContext = val; return true }
		'subFieldCache' { this.subFieldCache = val; return true }
		'fieldArgsCache' { this.fieldArgsCache = val; return true }
		'schemaMetaFieldDef' { this.schemaMetaFieldDef = val; return true }
		'typeMetaFieldDef' { this.typeMetaFieldDef = val; return true }
		'typeNameMetaFieldDef' { this.typeNameMetaFieldDef = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_referenceexecutor_php() {
	// unsupported statement: Stmt_Declare
}
