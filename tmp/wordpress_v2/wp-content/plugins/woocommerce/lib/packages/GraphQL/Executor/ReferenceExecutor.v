import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor {
	rt.PhpObjectBase
pub mut:
		exeContext rt.PhpVal = rt.new_null()
		subFieldCache rt.PhpVal = rt.new_null()
		fieldArgsCache rt.PhpVal = rt.new_null()
		schemaMetaFieldDef rt.PhpVal = rt.new_null()
		typeMetaFieldDef rt.PhpVal = rt.new_null()
		typeNameMetaFieldDef rt.PhpVal = rt.new_null()
}

fn init_static_automattic_woocommerce_vendor_graphql_executor_referenceexecutor() {
		rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', 'UNDEFINED', rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) construct(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) {
	if !(!(rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', 'UNDEFINED')).is_null()) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.undefined()
		rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', 'UNDEFINED', iife_result_0)
	}
	this.exeContext = var_context
	this.subFieldCache = create_automattic_woocommerce_vendor_graphql_executor_splobjectstorage()
	this.fieldArgsCache = create_automattic_woocommerce_vendor_graphql_executor_splobjectstorage()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.create(mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_documentNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, var_rootValue rt.PhpVal, var_contextValue rt.PhpVal, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable) rt.PhpVal {
	mut var_promiseAdapter_mutated := var_promiseAdapter
	mut var_schema_mutated := var_schema
	mut var_variableValues_mutated := var_variableValues
	mut var_argsMapper_mutated := var_argsMapper
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}
	mut iife_result_1 := iife_temp_1.getdefaultargsmapper()
	mut var_exeContext := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.buildexecutioncontext(mut var_schema_mutated, mut var_documentNode, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_rootValue), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string](var_contextValue), mut var_variableValues_mutated, mut var_operationName, mut var_fieldResolver, if !(var_argsMapper_mutated).is_null() { var_argsMapper_mutated } else { iife_result_1 }, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter', []string{}, var_promiseAdapter_mutated))
	if rt.is_true(rt.new_bool(var_exeContext.clone().is_array())) {
		mut var_executionResult := create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), var_exeContext.clone())
		mut var_fulfilledPromise := rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [var_executionResult])
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor', []string{}, create_automattic_woocommerce_vendor_graphql_executor_promiseexecutor(var_fulfilledPromise.clone()))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_static', []string{}, create_automattic_woocommerce_vendor_graphql_executor_static(var_exeContext.clone()))
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
	mut var_hasMultipleAssumedOperations := rt.new_bool(false)
	mut iter_1 := rt.get_property(var_documentNode, 'definitions').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_definition := item_1.val
		mut switch_val_1 := rt.new_bool(true)
		if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))) {
			if rt.is_true(rt.identical(var_operationName, rt.new_null())) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_operation, rt.new_null())))) {
			var_hasMultipleAssumedOperations = rt.new_bool(true)
			}
			if rt.is_true(rt.identical(var_operationName, rt.new_null())) || (!(rt.get_property(var_definition, 'name')).is_null() && rt.is_true(rt.identical(rt.get_property(rt.get_property(var_definition, 'name'), 'value'), var_operationName))) {
			var_operation = var_definition
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode')))) {
			var_fragments.array_set(rt.get_property(rt.get_property(var_definition, 'name'), 'value'), var_definition.clone())
		}
	}
	if rt.is_true(rt.identical(var_operation, rt.new_null())) {
		mut var_message := rt.new_string((if rt.is_true(rt.identical(var_operationName, rt.new_null())) { 'Must provide an operation.' } else { "Unknown operation named \"${var_operationName.to_string()}\"." }).str())
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(var_message.clone()))
	} else if rt.is_true(var_hasMultipleAssumedOperations) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Must provide operation name if query contains multiple operations.')))
	}
	mut var_variableValues := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_operation, rt.new_null())))) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
		mut iife_result_2 := iife_temp_2.getvariablevalues(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema_mutated), rt.get_property(var_operation, 'variableDefinitions'), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_array', []string{}, var_rawVariableValues))
		mut list_tmp_1 := iife_result_2
		var_coercionErrors = (list_tmp_1).array_get(0)
		var_coercedVariableValues = (list_tmp_1).array_get(1)
		if rt.is_true(rt.identical(var_coercionErrors, rt.new_null())) {
		var_variableValues = var_coercedVariableValues
		} else {
		var_errors = rt.call_function('array_merge', [var_errors.clone(), var_coercionErrors.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
		return var_errors.clone()
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_operation, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')), rt.new_string('Has operation if no errors.')])
	rt.call_function('assert', [rt.new_bool(var_variableValues.clone().is_array()), rt.new_string('Has variables if no errors.')])
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext', []string{}, create_automattic_woocommerce_vendor_graphql_executor_executioncontext(var_schema_mutated, var_fragments.clone(), var_rootValue.clone(), var_contextValue.clone(), var_operation.clone(), var_variableValues.clone(), var_errors.clone(), var_fieldResolver, var_argsMapper_mutated, var_promiseAdapter_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) doexecute() rt.PhpVal {
	mut var_data := this.executeoperation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](rt.get_property(this.exeContext, 'operation')), rt.get_property(this.exeContext, 'rootValue'))
	mut var_result := this.buildresponse(var_data.clone())
	mut var_promise := this.getpromise(var_result.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
		return var_promise.clone()
	}
	return rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'createFulfilled', [var_result.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) buildresponse(var_data rt.PhpVal) rt.PhpVal {
	mut var_resolved := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_resolved := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return this.buildresponse(var_resolved.clone())
			}
		return rt.call_method(var_data_mutated, 'then', [rt.new_closure(closure_4_fn)])
	}
	mut var_promiseAdapter := rt.get_property(this.exeContext, 'promiseAdapter')
	if rt.is_true(rt.call_method(var_promiseAdapter, 'isThenable', [var_data_mutated.clone()])) {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_resolved := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return this.buildresponse(var_resolved.clone())
			}
		return rt.call_method(rt.call_method(var_promiseAdapter, 'convertThenable', [var_data_mutated.clone()]), 'then', [rt.new_closure(closure_5_fn)])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data_mutated, rt.new_null())))) {
	var_data_mutated = rt.cast_array(var_data_mutated)
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult', []string{}, create_automattic_woocommerce_vendor_graphql_executor_executionresult(var_data_mutated.clone(), rt.get_property(this.exeContext, 'errors')))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) executeoperation(mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode, var_rootValue rt.PhpVal) rt.PhpVal {
	mut var_operation_mutated := var_operation
	mut var_type := this.getoperationroottype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](rt.get_property(this.exeContext, 'schema')), mut var_operation_mutated)
	mut var_fields := this.collectfields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](var_type), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_operation_mutated, 'selectionSet')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](create_automattic_woocommerce_vendor_graphql_executor_arrayobject()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](create_automattic_woocommerce_vendor_graphql_executor_arrayobject()))
	mut var_path := rt.new_array()
	mut var_unaliasedPath := rt.new_array()
	mut var_result := if rt.is_true(rt.identical(rt.get_property(var_operation_mutated, 'operation'), rt.new_string('mutation'))) { this.executefieldsserially(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](var_type), var_rootValue.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_path), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_unaliasedPath), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_fields), rt.get_property(this.exeContext, 'contextValue')) } else { this.executefields(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](var_type), var_rootValue.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_path), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_unaliasedPath), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_fields), rt.get_property(this.exeContext, 'contextValue')) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_promise := this.getpromise(var_result.clone())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
		return rt.call_method(var_promise, 'then', [rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', ['ExecutorImplementation'], &this) }, rt.ArrayItem{ key: none, val: 'onError' }])])
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_result.clone()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error') {
		mut var_error := var_e_1.clone()
		rt.call_method(this.exeContext, 'addError', [var_error.clone()])
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
		rt.call_method(this.exeContext, 'addError', [var_error_mutated.clone()])
		return rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'createFulfilled', []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) getoperationroottype(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut var_operation_mutated := var_operation
	mut switch_val_2 := rt.get_property(var_operation_mutated, 'operation')
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('query'))) {
		mut var_queryType := rt.call_method(var_schema_mutated, 'getQueryType', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_queryType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Schema does not define the required query root type.'), rt.create_array([rt.ArrayItem{ key: none, val: var_operation_mutated }]))))
		}
		return var_queryType.clone()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mutation'))) {
		mut var_mutationType := rt.call_method(var_schema_mutated, 'getMutationType', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_mutationType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Schema is not configured for mutations.'), rt.create_array([rt.ArrayItem{ key: none, val: var_operation_mutated }]))))
		}
		return var_mutationType.clone()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('subscription'))) {
		mut var_subscriptionType := rt.call_method(var_schema_mutated, 'getSubscriptionType', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_subscriptionType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Schema is not configured for subscriptions.'), rt.create_array([rt.ArrayItem{ key: none, val: var_operation_mutated }]))))
		}
		return var_subscriptionType.clone()
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string('Can only execute queries, mutations and subscriptions.'), rt.create_array([rt.ArrayItem{ key: none, val: var_operation_mutated }]))))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) collectfields(mut var_runtimeType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_selectionSet Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode, mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_visitedFragmentNames Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) rt.PhpVal {
	mut var_runtimeType_mutated := var_runtimeType
	mut var_fields_mutated := var_fields
	mut var_visitedFragmentNames_mutated := var_visitedFragmentNames
	mut var_exeContext := this.exeContext
	mut iter_2 := rt.get_property(var_selectionSet, 'selections').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_selection := item_2.val
		mut switch_val_3 := rt.new_bool(true)
		if rt.is_true(rt.equal(switch_val_3, rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
			if !(this.shouldincludenode(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode](var_selection))) {
			}
			mut var_name := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.getfieldentrykey(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](var_selection))
			rt.new_null()
			var_fields_mutated.array_get_mut(var_name).array_push(var_selection.clone())
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) {
			if !(this.shouldincludenode(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode](var_selection))) || !(this.doesfragmentconditionmatch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_selection), mut var_runtimeType_mutated)) {
			}
			this.collectfields(mut var_runtimeType_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_selection, 'selectionSet')), mut var_fields_mutated, mut var_visitedFragmentNames_mutated)
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))) {
			mut var_fragName := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
			if var_visitedFragmentNames_mutated.array_isset(var_fragName) || !(this.shouldincludenode(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode](var_selection))) {
			}
			var_visitedFragmentNames_mutated.array_set(var_fragName, true)
			if !(rt.get_property(var_exeContext, 'fragments').array_isset(var_fragName)) {
			}
			mut var_fragment := rt.get_property(var_exeContext, 'fragments').array_get(var_fragName)
			if !(this.doesfragmentconditionmatch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_fragment), mut var_runtimeType_mutated)) {
			}
			this.collectfields(mut var_runtimeType_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fragment, 'selectionSet')), mut var_fields_mutated, mut var_visitedFragmentNames_mutated)
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject', []string{}, var_fields_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) shouldincludenode(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode) bool {
	mut var_variableValues := rt.get_property(this.exeContext, 'variableValues')
	mut var_schema := rt.get_property(this.exeContext, 'schema')
	mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
	mut iife_result_5 := iife_temp_5.skipdirective()
	mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
	mut iife_result_6 := iife_temp_6.getdirectivevalues(iife_result_5, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode', []string{}, var_node), var_variableValues.clone(), var_schema.clone())
	mut var_skip := iife_result_6
	if var_skip.array_isset(rt.new_string('if')) && rt.is_true(rt.identical(var_skip.array_get(rt.new_string('if')), rt.new_bool(true))) {
		return false
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
	mut iife_result_7 := iife_temp_7.includedirective()
	mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values{}
	mut iife_result_8 := iife_temp_8.getdirectivevalues(iife_result_7, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionNode', []string{}, var_node), var_variableValues.clone(), var_schema.clone())
	mut var_include := iife_result_8
	return !(var_include.array_isset(rt.new_string('if'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_include.array_get(rt.new_string('if')), rt.new_bool(false)))))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.getfieldentrykey(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) string {
	return (if !(rt.get_property(rt.get_property(var_node, 'alias'), 'value')).is_null() { rt.get_property(rt.get_property(var_node, 'alias'), 'value') } else { rt.get_property(rt.get_property(var_node, 'name'), 'value') }).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) doesfragmentconditionmatch(mut var_fragment Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) bool {
	mut var_fragment_mutated := var_fragment
	mut var_type_mutated := var_type
	mut var_typeConditionNode := rt.get_property(var_fragment_mutated, 'typeCondition')
	if rt.is_true(rt.identical(var_typeConditionNode, rt.new_null())) {
		return true
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
	mut iife_result_9 := iife_temp_9.typefromast(rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(this.exeContext, 'schema') }, rt.ArrayItem{ key: none, val: 'getType' }]), var_typeConditionNode.clone())
	mut var_conditionalType := iife_result_9
	if rt.is_true(rt.identical(var_conditionalType, var_type_mutated)) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_conditionalType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType'))) {
		return (rt.call_method(rt.get_property(this.exeContext, 'schema'), 'isSubType', [var_conditionalType.clone(), var_type_mutated])).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) executefieldsserially(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_rootValue rt.PhpVal, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_resolvedResults := rt.new_null()
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_fields_mutated := var_fields
	closure_12_fn := fn [var_contextValue, var_path, var_unaliasedPath, var_parentType, var_rootValue, var_fields] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_results := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_responseName := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_fieldNodes := var_fields_mutated.array_get(var_responseName)
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_fieldNodes, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject')), rt.new_string('The keys of $fields populate $responseName')])
		mut var_result := this.resolvefield(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, var_parentType), var_rootValue.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_fieldNodes), (var_responseName).str(), mut var_path_mutated, mut var_unaliasedPath_mutated, this.maybescopecontext(var_contextValue.clone()))
		if rt.is_true(rt.identical(var_result, rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', 'UNDEFINED'))) {
			return var_results.clone()
		}
		mut var_promise := this.getpromise(var_result.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
			closure_12_fn := fn [var_responseName, var_results] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_resolvedResult := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				var_results.array_set(var_responseName, var_resolvedResult.clone())
				return var_results.clone()
				}
			return rt.call_method(var_promise, 'then', [rt.new_closure(closure_12_fn)])
		}
		var_results.array_set(var_responseName, var_result.clone())
		return var_results.clone()
		}
	mut var_result := this.promisereduce(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](rt.func_array_keys(rt.call_method(var_fields_mutated, 'getArrayCopy', []rt.PhpVal{}))), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](rt.new_closure(closure_12_fn)), rt.new_array())
	mut var_promise := this.getpromise(var_result.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
		closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_resolvedResults := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.fixresultsifemptyarray(var_resolvedResults.clone())
			}
		return rt.call_method(var_result, 'then', [rt.new_closure(closure_13_fn)])
	}
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.fixresultsifemptyarray(var_result.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) resolvefield(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_rootValue rt.PhpVal, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, responseName string, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_exeContext := this.exeContext
	mut var_fieldNode := var_fieldNodes.array_get(rt.new_int(0))
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_fieldNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')), rt.new_string('$fieldNodes is non-empty')])
	mut var_fieldName := rt.get_property(rt.get_property(var_fieldNode, 'name'), 'value')
	mut var_fieldDef := this.getfielddef(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](rt.get_property(var_exeContext, 'schema')), mut var_parentType, (var_fieldName).str())
	if rt.is_true(rt.identical(var_fieldDef, rt.new_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_fieldDef, 'isVisible', []rt.PhpVal{}))))) {
		return rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', 'UNDEFINED')
	}
	var_path_mutated.array_push(responseName)
	var_unaliasedPath_mutated.array_push(var_fieldName.clone())
	mut var_returnType := rt.call_method(var_fieldDef, 'getType', []rt.PhpVal{})
	mut var_info := create_automattic_woocommerce_vendor_graphql_type_definition_resolveinfo(var_fieldDef.clone(), var_fieldNodes, var_parentType, var_path_mutated, rt.get_property(var_exeContext, 'schema'), rt.get_property(var_exeContext, 'fragments'), rt.get_property(var_exeContext, 'rootValue'), rt.get_property(var_exeContext, 'operation'), rt.get_property(var_exeContext, 'variableValues'), var_unaliasedPath_mutated)
	mut var_resolveFn := if !(rt.get_property(var_fieldDef, 'resolveFn')).is_null() { rt.get_property(var_fieldDef, 'resolveFn') } else { if !(rt.get_property(var_parentType, 'resolveFieldFn')).is_null() { rt.get_property(var_parentType, 'resolveFieldFn') } else { rt.get_property(this.exeContext, 'fieldResolver') } }
	mut var_argsMapper := if !(rt.get_property(var_fieldDef, 'argsMapper')).is_null() { rt.get_property(var_fieldDef, 'argsMapper') } else { if !(rt.get_property(var_parentType, 'argsMapper')).is_null() { rt.get_property(var_parentType, 'argsMapper') } else { rt.get_property(this.exeContext, 'argsMapper') } }
	mut var_result := this.resolvefieldvalueorerror(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition](var_fieldDef), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](var_fieldNode), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](var_resolveFn), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](var_argsMapper), var_rootValue.clone(), mut var_info, var_contextValue.clone())
	return this.completevaluecatchingerror(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_returnType), mut var_fieldNodes, mut var_info, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result.clone(), var_contextValue.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) getfielddef(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, fieldName string) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut fieldName_mutated := fieldName
	rt.new_null()
	rt.new_null()
	rt.new_null()
	mut var_queryType := rt.call_method(var_schema_mutated, 'getQueryType', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string(fieldName_mutated), rt.get_property(this.schemaMetaFieldDef, 'name'))) && rt.is_true(rt.identical(var_queryType, var_parentType)) {
		return this.schemaMetaFieldDef
	}
	if rt.is_true(rt.identical(rt.new_string(fieldName_mutated), rt.get_property(this.typeMetaFieldDef, 'name'))) && rt.is_true(rt.identical(var_queryType, var_parentType)) {
		return this.typeMetaFieldDef
	}
	if rt.is_true(rt.identical(rt.new_string(fieldName_mutated), rt.get_property(this.typeNameMetaFieldDef, 'name'))) {
		return this.typeNameMetaFieldDef
	}
	return var_parentType.findfield(rt.new_string(fieldName_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) resolvefieldvalueorerror(mut var_fieldDef Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition, mut var_fieldNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode, mut var_resolveFn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, var_rootValue rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_fieldDef_mutated := var_fieldDef
	mut var_fieldNode_mutated := var_fieldNode
	mut var_resolveFn_mutated := var_resolveFn
	mut var_argsMapper_mutated := var_argsMapper
	mut var_info_mutated := var_info
	rt.new_null()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_args := rt.new_null()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return rt.call_callable(var_resolveFn_mutated, [var_rootValue.clone(), var_args.clone(), var_contextValue.clone(), var_info_mutated])
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Throwable') {
		mut var_error := var_e_2.clone()
		return var_error.clone()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completevaluecatchingerror(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_resolved := rt.new_null()
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
	mut var_promise := this.getpromise(var_result_mutated.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
		closure_14_fn := fn [var_returnType, var_fieldNodes, var_info, var_path, var_unaliasedPath, var_contextValue] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_resolved := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return this.completevalue(mut var_returnType_mutated, mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject', []string{}, var_fieldNodes), mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, var_resolved.clone(), var_contextValue.clone())
			}
		mut var_completed := rt.call_method(var_promise, 'then', [rt.new_closure(closure_14_fn)])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	} else {
		var_completed = this.completevalue(mut var_returnType_mutated, mut var_fieldNodes, mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_promise = this.getpromise(var_completed.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
		closure_15_fn := fn [var_fieldNodes, var_path, var_unaliasedPath, var_returnType] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_error := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			this.handlefielderror(var_error.clone(), mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject', []string{}, var_fieldNodes), mut var_path_mutated, mut var_unaliasedPath_mutated, mut var_returnType_mutated)
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			return rt.new_null()
			}
		return rt.call_method(var_promise, 'then', [rt.new_null(), rt.new_closure(closure_15_fn)])
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return var_completed.clone()
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Throwable') {
		mut var_err := var_e_3.clone()
		this.handlefielderror(var_err.clone(), mut var_fieldNodes, mut var_path_mutated, mut var_unaliasedPath_mutated, mut var_returnType_mutated)
		return rt.new_null()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) handlefielderror(var_rawError rt.PhpVal, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) {
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_returnType_mutated := var_returnType
	mut iife_temp_15 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{}
	mut iife_result_15 := iife_temp_15.createlocatederror(var_rawError.clone(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject', []string{}, var_fieldNodes), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_array', []string{}, var_path_mutated), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_array', []string{}, var_unaliasedPath_mutated))
	mut var_error := iife_result_15
	if rt.is_true(rt.new_bool(rt.instance_of(var_returnType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		rt.throw_exception(var_error)
	}
	rt.call_method(this.exeContext, 'addError', [var_error.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completevalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
	if rt.is_true(rt.new_bool(rt.instance_of(var_result_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Throwable'))) {
		rt.throw_exception(var_result_mutated)
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_returnType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		mut var_completed := this.completevalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_returnType_mutated, 'getWrappedType', []rt.PhpVal{})), mut var_fieldNodes, mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
		if rt.is_true(rt.identical(var_completed, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Cannot return null for non-nullable field "'), rt.get_property(var_info_mutated, 'parentType')), rt.new_string('.')), rt.get_property(var_info_mutated, 'fieldName')), rt.new_string('".')))))
		}
		return var_completed.clone()
	}
	if rt.is_true(rt.identical(var_result_mutated, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_returnType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_iterable', [var_result_mutated.clone()]))))) {
			mut var_resultType := rt.call_function('gettype', [var_result_mutated.clone()])
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Expected field '), rt.get_property(var_info_mutated, 'parentType')), rt.new_string('.')), rt.get_property(var_info_mutated, 'fieldName')), rt.new_string(' to return iterable, but got: ')), var_resultType), rt.new_string('.')))))
		}
		return this.completelistvalue(mut var_returnType_mutated, mut var_fieldNodes, mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_iterable](var_result_mutated), var_contextValue.clone())
	}
	rt.call_function('assert', [rt.new_bool(rt.instance_of(var_returnType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')), rt.new_string('Wrapping types should return early')])
	mut iife_temp_16 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_16 := iife_temp_16.isbuiltinscalar(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_returnType_mutated))
	mut iife_temp_17 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext{}
	mut iife_result_17 := iife_temp_17.duplicatetype(rt.get_property(this.exeContext, 'schema'), rt.new_string((rt.concat(rt.concat(rt.get_property(var_info_mutated, 'parentType'), rt.new_string('.')), rt.get_property(var_info_mutated, 'fieldName'))).str()), rt.get_property(var_returnType_mutated, 'name'))
	mut iife_temp_18 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_18 := iife_temp_18.isbuiltinscalar(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_returnType_mutated))
	rt.call_function('assert', [rt.new_bool(rt.is_true(rt.identical(var_returnType_mutated, rt.call_method(rt.get_property(this.exeContext, 'schema'), 'getType', [rt.get_property(var_returnType_mutated, 'name')]))) || rt.is_true(iife_result_16)), iife_result_17])
	if rt.is_true(rt.new_bool(rt.instance_of(var_returnType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType'))) {
		mut iife_temp_19 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_19 := iife_temp_19.isbuiltinscalar(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_returnType_mutated))
		if rt.is_true(iife_result_19) {
			mut var_schemaType := rt.call_method(rt.get_property(this.exeContext, 'schema'), 'getType', [rt.get_property(var_returnType_mutated, 'name')])
			rt.call_function('assert', [rt.new_bool(rt.instance_of(var_schemaType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType')), rt.concat(rt.concat(rt.new_string('Schema must provide a LeafType for built-in scalar "'), rt.get_property(var_returnType_mutated, 'name')), rt.new_string('".'))])
		var_returnType_mutated = var_schemaType.clone()
		}
		return this.completeleafvalue(mut var_returnType_mutated, var_result_mutated.clone())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_returnType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType'))) {
		return this.completeabstractvalue(mut var_returnType_mutated, mut var_fieldNodes, mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_returnType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) {
		return this.completeobjectvalue(mut var_returnType_mutated, mut var_fieldNodes, mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
	}
	mut iife_temp_20 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_20 := iife_temp_20.printsafe(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_returnType_mutated))
	mut var_safeReturnType := iife_result_20
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_RuntimeException', []string{}, create_automattic_woocommerce_vendor_graphql_executor_runtimeexception(rt.new_string("Cannot complete value of unexpected type ${var_safeReturnType.to_string()}."))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) ispromise(var_value rt.PhpVal) bool {
	return rt.is_true(rt.new_bool(rt.instance_of(var_value, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) || rt.is_true(rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'isThenable', [var_value.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) getpromise(var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(var_value, rt.new_null())) || rt.is_true(rt.new_bool(rt.instance_of(var_value, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		return var_value.clone()
	}
	mut var_promiseAdapter := rt.get_property(this.exeContext, 'promiseAdapter')
	if rt.is_true(rt.call_method(var_promiseAdapter, 'isThenable', [var_value.clone()])) {
		return rt.call_method(var_promiseAdapter, 'convertThenable', [var_value.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) promisereduce(mut var_values Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_callback Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, var_initialValue rt.PhpVal) rt.PhpVal {
	closure_23_fn := fn [var_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_previous := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_resolved := rt.new_null()
		mut var_promise := this.getpromise(var_previous.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
			closure_23_fn := fn [var_callback, var_value] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_resolved := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.call_callable(var_callback, [var_resolved.clone(), var_value.clone()])
				}
			return rt.call_method(var_promise, 'then', [rt.new_closure(closure_23_fn)])
		}
		return rt.call_callable(var_callback, [var_previous.clone(), var_value.clone()])
		}
	return rt.call_function('array_reduce', [var_values, rt.new_closure(closure_23_fn), var_initialValue.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completelistvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_results Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_iterable, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_results_mutated := var_results
	mut var_itemType := rt.call_method(var_returnType_mutated, 'getWrappedType', []rt.PhpVal{})
	mut var_i := rt.new_int(0)
	mut var_containsPromise := rt.new_bool(false)
	mut var_completedItems := rt.new_array()
	mut iter_3 := var_results_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item := item_3.val
		mut var_itemPath := rt.create_array([rt.ArrayItem{ key: none, val: var_path_mutated }, rt.ArrayItem{ key: none, val: var_i }])
		rt.set_property(var_info_mutated, 'path', var_itemPath.clone())
		mut var_itemUnaliasedPath := rt.create_array([rt.ArrayItem{ key: none, val: var_unaliasedPath_mutated }, rt.ArrayItem{ key: none, val: var_i }])
		rt.set_property(var_info_mutated, 'unaliasedPath', var_itemUnaliasedPath.clone())
		rt.pre_inc(var_i)
		mut var_completedItem := this.completevaluecatchingerror(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_itemType), mut var_fieldNodes, mut var_info_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_itemPath), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_itemUnaliasedPath), var_item.clone(), var_contextValue.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_containsPromise)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.getpromise(var_completedItem.clone()), rt.new_null())))) {
		var_containsPromise = rt.new_bool(true)
		}
		var_completedItems.array_push(var_completedItem.clone())
	}
	return if rt.is_true(var_containsPromise) { rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'all', [var_completedItems.clone()]) } else { var_completedItems }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completeleafvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType, var_result rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_result_mutated := var_result
	return rt.call_method(var_returnType_mutated, 'serialize', [var_result_mutated.clone()])
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Throwable') {
		mut var_error := var_e_4.clone()
		mut iife_temp_23 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_23 := iife_temp_23.printsafe(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType', []string{}, var_returnType_mutated))
		mut var_safeReturnType := iife_result_23
		mut iife_temp_24 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_24 := iife_temp_24.printsafe(var_result_mutated.clone())
		mut var_safeResult := iife_result_24
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Expected a value of type '), var_safeReturnType), rt.new_string(' but received: ')), var_safeResult), rt.new_string('. ')), rt.call_method(var_error, 'getMessage', []rt.PhpVal{})), rt.new_int(0), var_error.clone())))
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completeabstractvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_resolvedRuntimeType := rt.new_null()
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
	var_result_mutated = rt.call_method(var_returnType_mutated, 'resolveValue', [var_result_mutated.clone(), var_contextValue.clone(), var_info_mutated])
	mut var_typeCandidate := rt.call_method(var_returnType_mutated, 'resolveType', [var_result_mutated.clone(), var_contextValue.clone(), var_info_mutated])
	if rt.is_true(rt.identical(var_typeCandidate, rt.new_null())) {
	mut iife_temp_25 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor{}
	mut iife_result_25 := iife_temp_25.defaulttyperesolver(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](var_result_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](var_contextValue), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo', []string{}, var_info_mutated), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType', []string{}, var_returnType_mutated))
	mut var_runtimeType := iife_result_25
	} else if !(var_typeCandidate.clone().is_string()) && rt.call_function('is_callable', [var_typeCandidate.clone()]) {
	var_runtimeType = rt.call_callable(var_typeCandidate, []rt.PhpVal{})
	} else {
	var_runtimeType = var_typeCandidate.clone()
	}
	mut var_promise := this.getpromise(var_runtimeType.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
		closure_27_fn := fn [var_returnType, var_info, var_result, var_fieldNodes, var_path, var_unaliasedPath, var_contextValue] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_resolvedRuntimeType := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return this.completeobjectvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](this.ensurevalidruntimetype(var_resolvedRuntimeType.clone(), mut var_returnType_mutated, mut var_info_mutated, var_result_mutated.clone())), mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject', []string{}, var_fieldNodes), mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
			}
		return rt.call_method(var_promise, 'then', [rt.new_closure(closure_27_fn)])
	}
	return this.completeobjectvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType](this.ensurevalidruntimetype(var_runtimeType.clone(), mut var_returnType_mutated, mut var_info_mutated, var_result_mutated.clone())), mut var_fieldNodes, mut var_info_mutated, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) defaulttyperesolver(var_value rt.PhpVal, var_contextValue rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType) rt.PhpVal {
	mut var_info_mutated := var_info
	mut iife_temp_27 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_27 := iife_temp_27.extractkey(var_value.clone(), rt.new_string('__typename'))
	mut var_typename := iife_result_27
	if rt.is_true(rt.new_bool(var_typename.clone().is_string())) {
		return var_typename.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType', []string{}, var_abstractType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))) && !(rt.get_property(rt.call_method(rt.get_property(var_info_mutated, 'schema'), 'getConfig', []rt.PhpVal{}), 'typeLoader')).is_null() {
	mut iife_temp_28 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_28 := iife_temp_28.printsafe(var_value.clone())
	mut var_safeValue := iife_result_28
	mut iife_temp_29 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning{}
	mut iife_result_29 := iife_temp_29.warnonce(rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Automattic\\WooCommerce\\Vendor\\GraphQL Interface Type `'), rt.get_property(var_abstractType, 'name')), rt.new_string('` returned `null` from its `resolveType` function for value: ')), var_safeValue), rt.new_string('. Switching to slow resolution method using `isTypeOf` of all possible implementations. It requires full schema scan and degrades query performance significantly. Make sure your `resolveType` function always returns a valid implementation or throws.'))).str()), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warning_full_schema_scan())
	}
	mut var_possibleTypes := rt.call_method(rt.get_property(var_info_mutated, 'schema'), 'getPossibleTypes', [var_abstractType])
	mut var_promisedIsTypeOfResults := rt.new_array()
	mut iter_4 := var_possibleTypes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_type := item_4.val
		mut var_index := item_4.key
		mut var_isTypeOfResult := rt.call_method(var_type, 'isTypeOf', [var_value.clone(), var_contextValue.clone(), var_info_mutated])
		if rt.is_true(rt.identical(var_isTypeOfResult, rt.new_null())) {
			continue
		}
		mut var_promise := this.getpromise(var_isTypeOfResult.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
			var_promisedIsTypeOfResults.array_set(var_index, var_promise.clone())
		} else if rt.is_true(rt.identical(var_isTypeOfResult, rt.new_bool(true))) {
			return var_type.clone()
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promisedIsTypeOfResults, rt.new_array())))) {
		closure_31_fn := fn [var_possibleTypes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_isTypeOfResults := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iter_5 := var_isTypeOfResults.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_result := item_5.val
				mut var_index := item_5.key
				if rt.is_true(var_result) {
					return var_possibleTypes.array_get(var_index)
				}
			}
			return rt.new_null()
			}
		return rt.call_method(rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'all', [var_promisedIsTypeOfResults.clone()]), 'then', [rt.new_closure(closure_31_fn)])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) completeobjectvalue(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
	mut var_isTypeOf := rt.call_method(var_returnType_mutated, 'isTypeOf', [var_result_mutated.clone(), var_contextValue.clone(), var_info_mutated])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_isTypeOf, rt.new_null())))) {
		mut var_promise := this.getpromise(var_isTypeOf.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_promise, rt.new_null())))) {
			closure_32_fn := fn [var_contextValue, var_returnType, var_fieldNodes, var_path, var_unaliasedPath, var_result] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_isTypeOfResult := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				if rt.is_true(rt.new_bool(!(rt.is_true(var_isTypeOfResult)))) {
					rt.throw_exception(this.invalidreturntypeerror(mut var_returnType_mutated, var_result_mutated.clone(), mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject', []string{}, var_fieldNodes)))
				}
				return this.collectandexecutesubfields(mut var_returnType_mutated, mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject', []string{}, var_fieldNodes), mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
				}
			return rt.call_method(var_promise, 'then', [rt.new_closure(closure_32_fn)])
		}
		rt.call_function('assert', [rt.new_bool(var_isTypeOf.clone().is_bool()), rt.new_string('Promise would return early')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_isTypeOf)))) {
			rt.throw_exception(this.invalidreturntypeerror(mut var_returnType_mutated, var_result_mutated.clone(), mut var_fieldNodes))
		}
	}
	return this.collectandexecutesubfields(mut var_returnType_mutated, mut var_fieldNodes, mut var_path_mutated, mut var_unaliasedPath_mutated, var_result_mutated.clone(), var_contextValue.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) invalidreturntypeerror(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_result rt.PhpVal, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_result_mutated := var_result
	mut iife_temp_32 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_32 := iife_temp_32.printsafe(var_result_mutated.clone())
	mut var_safeResult := iife_result_32
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Expected value of type "'), rt.get_property(var_returnType_mutated, 'name')), rt.new_string('" but got: ')), var_safeResult), rt.new_string('.')), var_fieldNodes))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) collectandexecutesubfields(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_result rt.PhpVal, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_result_mutated := var_result
	mut var_subFieldNodes := this.collectsubfields(mut var_returnType_mutated, mut var_fieldNodes)
	return this.executefields(mut var_returnType_mutated, var_result_mutated.clone(), mut var_path_mutated, mut var_unaliasedPath_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_subFieldNodes), var_contextValue.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) collectsubfields(mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, mut var_fieldNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_returnTypeCache := rt.new_null()
	if !(var_returnTypeCache.array_isset(var_fieldNodes)) {
		mut var_subFieldNodes := create_automattic_woocommerce_vendor_graphql_executor_arrayobject()
		mut var_visitedFragmentNames := create_automattic_woocommerce_vendor_graphql_executor_arrayobject()
		mut iter_6 := var_fieldNodes.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_fieldNode := item_6.val
			if !(rt.get_property(var_fieldNode, 'selectionSet')).is_null() {
			var_subFieldNodes = this.collectfields(mut var_returnType_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode](rt.get_property(var_fieldNode, 'selectionSet')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_subFieldNodes), mut var_visitedFragmentNames)
			}
		}
		var_returnTypeCache.array_set(var_fieldNodes, var_subFieldNodes.clone())
	}
	return var_returnTypeCache.array_get(var_fieldNodes)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) executefields(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType, var_rootValue rt.PhpVal, mut var_path Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_unaliasedPath Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject, var_contextValue rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_unaliasedPath_mutated := var_unaliasedPath
	mut var_fields_mutated := var_fields
	mut var_containsPromise := rt.new_bool(false)
	mut var_results := rt.new_array()
	mut iter_7 := var_fields_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_fieldNodes := item_7.val
		mut var_responseName := item_7.key
		mut var_result := this.resolvefield(mut var_parentType, var_rootValue.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject](var_fieldNodes), (var_responseName).str(), mut var_path_mutated, mut var_unaliasedPath_mutated, this.maybescopecontext(var_contextValue.clone()))
		if rt.is_true(rt.identical(var_result, rt.get_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor', 'UNDEFINED'))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_containsPromise)))) && this.ispromise(var_result.clone()) {
		var_containsPromise = rt.new_bool(true)
		}
		var_results.array_set(var_responseName, var_result.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_containsPromise)))) {
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.fixresultsifemptyarray(var_results.clone())
	}
	return this.promiseforassocarray(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](var_results))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.fixresultsifemptyarray(var_results rt.PhpVal) rt.PhpVal {
	mut var_results_mutated := var_results
	if rt.is_true(rt.identical(var_results_mutated, rt.new_array())) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_stdClass', []string{}, create_automattic_woocommerce_vendor_graphql_executor_stdclass())
	}
	return var_results_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) promiseforassocarray(mut var_assoc Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array) rt.PhpVal {
	mut var_keys := rt.func_array_keys(var_assoc)
	mut var_valuesAndPromises := rt.call_function('array_values', [var_assoc])
	mut var_promise := rt.call_method(rt.get_property(this.exeContext, 'promiseAdapter'), 'all', [var_valuesAndPromises.clone()])
	closure_34_fn := fn [var_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_values := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_resolvedResults := rt.new_array()
		mut iter_8 := var_values.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value := item_8.val
			mut var_i := item_8.key
			var_resolvedResults.array_set(var_keys.array_get(var_i), var_value.clone())
		}
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor.fixresultsifemptyarray(var_resolvedResults.clone())
		}
	return rt.call_method(var_promise, 'then', [rt.new_closure(closure_34_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) ensurevalidruntimetype(var_runtimeTypeOrName rt.PhpVal, mut var_returnType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, var_result rt.PhpVal) rt.PhpVal {
	mut var_returnType_mutated := var_returnType
	mut var_info_mutated := var_info
	mut var_result_mutated := var_result
	mut var_runtimeType := if var_runtimeTypeOrName.clone().is_string() { rt.call_method(rt.get_property(this.exeContext, 'schema'), 'getType', [var_runtimeTypeOrName.clone()]) } else { var_runtimeTypeOrName }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_runtimeType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) {
		mut iife_temp_34 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_34 := iife_temp_34.printsafe(var_result_mutated.clone())
		mut var_safeResult := iife_result_34
		mut iife_temp_35 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_35 := iife_temp_35.printsafe(var_runtimeType.clone())
		mut var_notObjectType := iife_result_35
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Abstract type '), var_returnType_mutated), rt.new_string(' must resolve to an Object type at runtime for field ')), rt.get_property(var_info_mutated, 'parentType')), rt.new_string('.')), rt.get_property(var_info_mutated, 'fieldName')), rt.new_string(' with value ')), var_safeResult), rt.new_string(', received "')), var_notObjectType), rt.new_string('". Either the ')), var_returnType_mutated), rt.new_string(' type should provide a "resolveType" function or each possible type should provide an "isTypeOf" function.')))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(this.exeContext, 'schema'), 'isSubType', [var_returnType_mutated, var_runtimeType.clone()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Runtime Object type \"${var_runtimeType.to_string()}\" is not a possible type for \"${var_returnType.to_string()}\"."))))
	}
	rt.call_function('assert', [rt.new_bool(!rt.is_true(rt.identical(rt.call_method(rt.get_property(this.exeContext, 'schema'), 'getType', [rt.get_property(var_runtimeType, 'name')]), rt.new_null()))), rt.new_string("Schema does not contain type \"${var_runtimeType.to_string()}\". This can happen when an object type is only referenced indirectly through abstract types and never directly through fields.List the type in the option \"types\" during schema construction, see https://webonyx.github.io/graphql-php/schema-definition/#configuration-options.")])
	rt.call_function('assert', [rt.identical(var_runtimeType, rt.call_method(rt.get_property(this.exeContext, 'schema'), 'getType', [rt.get_property(var_runtimeType, 'name')])), rt.new_string("Schema must contain unique named types but contains multiple types named \"${var_runtimeType.to_string()}\". Make sure that `resolveType` function of abstract type \"${var_returnType.to_string()}\" returns the same type instance as referenced anywhere else within the schema (see https://webonyx.github.io/graphql-php/type-definitions/#type-registry).")])
	return var_runtimeType.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor) maybescopecontext(var_contextValue rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_contextValue, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_ScopedContext'))) {
		return rt.call_method(var_contextValue, 'clone', []rt.PhpVal{})
	}
	return var_contextValue.clone()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
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

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_RuntimeException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_stdClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_referenceexecutor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ReferenceExecutor{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_splobjectstorage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_SplObjectStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_executor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_executionresult(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promiseexecutor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_PromiseExecutor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
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

fn create_automattic_woocommerce_vendor_graphql_executor_executioncontext(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_arrayobject(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ArrayObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_resolveinfo(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schemavalidationcontext(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_runtimeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_warning(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_stdclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_stdClass{
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
			return this.getoperationroottype(mut dispatch_arg_0, mut dispatch_arg_1)
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
		'exeContext' { this.exeContext = val; return true }
		'subFieldCache' { this.subFieldCache = val; return true }
		'fieldArgsCache' { this.fieldArgsCache = val; return true }
		'schemaMetaFieldDef' { this.schemaMetaFieldDef = val; return true }
		'typeMetaFieldDef' { this.typeMetaFieldDef = val; return true }
		'typeNameMetaFieldDef' { this.typeNameMetaFieldDef = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Values) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
