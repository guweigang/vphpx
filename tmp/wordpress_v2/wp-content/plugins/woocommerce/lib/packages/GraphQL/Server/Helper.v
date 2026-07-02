import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) parsehttprequest(mut var_readRawBodyFn Class_Automattic_WooCommerce_Vendor_GraphQL_Server_?callable) rt.PhpVal {
	mut var_method := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')) } else { rt.new_null() }
	mut var_bodyParams := rt.new_array()
	mut var_urlParams := rt.get_superglobal('_GET')
	if rt.is_true(rt.identical(var_method, rt.new_string('POST'))) {
		mut var_contentType := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('CONTENT_TYPE'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('CONTENT_TYPE')) } else { rt.new_null() }
		if rt.is_true(rt.identical(var_contentType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_missingcontenttypeheader(rt.new_string('Missing "Content-Type" header'))))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_contentType.clone(), rt.new_string('application/graphql')]), rt.new_bool(false))))) {
		mut var_rawBody := if rt.is_true(rt.identical(var_readRawBodyFn, rt.new_null())) { this.readrawbody() } else { rt.call_callable(var_readRawBodyFn, []rt.PhpVal{}) }
		var_bodyParams = rt.create_array([rt.ArrayItem{ key: 'query', val: var_rawBody }])
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_contentType.clone(), rt.new_string('application/json')]), rt.new_bool(false))))) {
			var_rawBody = if rt.is_true(rt.identical(var_readRawBodyFn, rt.new_null())) { this.readrawbody() } else { rt.call_callable(var_readRawBodyFn, []rt.PhpVal{}) }
			var_bodyParams = this.decodejson((var_rawBody).str())
			this.assertjsonobjectorarray(var_bodyParams.clone())
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_contentType.clone(), rt.new_string('application/x-www-form-urlencoded')]), rt.new_bool(false))))) {
		var_bodyParams = rt.get_superglobal('_POST')
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_contentType.clone(), rt.new_string('multipart/form-data')]), rt.new_bool(false))))) {
		var_bodyParams = rt.get_superglobal('_POST')
		} else {
			mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_0 := iife_temp_0.printsafejson(var_contentType.clone())
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_unexpectedcontenttype('Unexpected content type: ' + (iife_result_0).str())))
		}
	}
	return this.parserequestparams((var_method).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](var_bodyParams), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](var_urlParams))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) parserequestparams(method string, mut var_bodyParams Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array, mut var_queryParams Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array) rt.PhpVal {
	mut method_mutated := method
	mut var_bodyParams_mutated := var_bodyParams
	if rt.is_true(rt.identical(rt.new_string(method_mutated), rt.new_string('GET'))) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{}
		mut iife_result_1 := iife_temp_1.create(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_array', []string{}, var_queryParams), rt.new_bool(true))
		return iife_result_1
	}
	if rt.is_true(rt.identical(rt.new_string(method_mutated), rt.new_string('POST'))) {
		if var_bodyParams_mutated.array_isset(rt.new_int(0)) {
			mut var_operations := rt.new_array()
			mut iter_1 := var_bodyParams_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_entry := item_1.val
				mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{}
				mut iife_result_2 := iife_temp_2.create(var_entry.clone())
				var_operations.array_push(iife_result_2)
			}
			return var_operations.clone()
		}
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{}
		mut iife_result_3 := iife_temp_3.create(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_array', []string{}, var_bodyParams_mutated))
		return iife_result_3
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_httpmethodnotsupported(rt.new_string("HTTP Method \"${var_method.to_string()}\" is not supported"))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) validateoperationparams(mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) rt.PhpVal {
	mut var_errors := rt.new_array()
	mut var_query := if !(rt.get_property(var_params, 'query')).is_null() { rt.get_property(var_params, 'query') } else { rt.new_string('') }
	mut var_queryId := if !(rt.get_property(var_params, 'queryId')).is_null() { rt.get_property(var_params, 'queryId') } else { rt.new_string('') }
	if rt.is_true(rt.identical(var_query, rt.new_string(''))) && rt.is_true(rt.identical(var_queryId, rt.new_string(''))) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_missingqueryorqueryidparameter(rt.new_string('Automattic\\WooCommerce\\Vendor\\GraphQL Request must include at least one of those two parameters: "query" or "queryId"')))
	}
	if !(var_query.clone().is_string()) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_4 := iife_temp_4.printsafejson(rt.get_property(var_params, 'query'))
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryparameter('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "query" must be string, but got ' + (iife_result_4).str()))
	}
	if !(var_queryId.clone().is_string()) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_5 := iife_temp_5.printsafejson(rt.get_property(var_params, 'queryId'))
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryidparameter('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "queryId" must be string, but got ' + (iife_result_5).str()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_params, 'operation'), rt.new_null())))) && !(rt.get_property(var_params, 'operation').is_string()) {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_6 := iife_temp_6.printsafejson(rt.get_property(var_params, 'operation'))
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_invalidoperationparameter('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "operation" must be string, but got ' + (iife_result_6).str()))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_params, 'variables'), rt.new_null())))) && !(rt.get_property(var_params, 'variables').is_array()) || rt.get_property(var_params, 'variables').array_isset(rt.new_int(0)) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_7 := iife_temp_7.printsafejson(rt.get_property(var_params, 'originalInput').array_get(rt.new_string('variables')))
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_cannotparsevariables('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "variables" must be object or JSON string parsed to object, but got ' + (iife_result_7).str()))
	}
	return var_errors.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) executeoperation(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_op Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) rt.PhpVal {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}
	mut iife_result_8 := iife_temp_8.getdefaultpromiseadapter()
	mut var_promiseAdapter := if !(var_config.getpromiseadapter()).is_null() { var_config.getpromiseadapter() } else { iife_result_8 }
	mut var_result := this.promisetoexecuteoperation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](var_promiseAdapter), mut var_config, mut var_op, false)
	if rt.is_true(rt.new_bool(rt.instance_of(var_promiseAdapter, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter'))) {
	var_result = rt.call_method(var_promiseAdapter, 'wait', [var_result.clone()])
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) executebatch(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_operations Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array) rt.PhpVal {
	mut var_operations_mutated := var_operations
	mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}
	mut iife_result_9 := iife_temp_9.getdefaultpromiseadapter()
	mut var_promiseAdapter := if !(var_config.getpromiseadapter()).is_null() { var_config.getpromiseadapter() } else { iife_result_9 }
	mut var_result := rt.new_array()
	mut iter_2 := var_operations_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_operation := item_2.val
		var_result.array_push(this.promisetoexecuteoperation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](var_promiseAdapter), mut var_config, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](var_operation), true))
	}
	var_result = rt.call_method(var_promiseAdapter, 'all', [var_result.clone()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_promiseAdapter, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter'))) {
	var_result = rt.call_method(var_promiseAdapter, 'wait', [var_result.clone()])
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) promisetoexecuteoperation(mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter, mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_op Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, isBatch bool) rt.PhpVal {
	mut var_promiseAdapter_mutated := var_promiseAdapter
	if rt.is_true(rt.identical(var_config.getschema(), rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Schema is required for the server'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_isBatch && rt.is_true(rt.new_bool(!(rt.is_true(var_config.getquerybatching())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_batchedqueriesarenotsupported(rt.new_string('Batched queries are not supported by this server'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_errors := this.validateoperationparams(mut var_op)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
		mut var_locatedErrors := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error.class() }, rt.ArrayItem{ key: none, val: 'createLocatedError' }]), var_errors.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), var_locatedErrors.clone())])
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_doc := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_op, 'queryId'), rt.new_null())))) { this.loadpersistedquery(mut var_config, mut var_op) } else { rt.get_property(var_op, 'query') }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_doc, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode')))))) {
		mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{}
		mut iife_result_10 := iife_temp_10.parse(var_doc.clone())
		var_doc = iife_result_10
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
	mut iife_result_11 := iife_temp_11.getoperationast(var_doc.clone(), rt.get_property(var_op, 'operation'))
	mut var_operationAST := iife_result_11
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(var_operationAST, rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_failedtodetermineoperationtype(rt.new_string('Failed to determine operation type'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_operationType := rt.get_property(var_operationAST, 'operation')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_operationType, rt.new_string('query'))))) && rt.is_true(rt.get_property(var_op, 'readOnly')) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_getmethodsupportsonlyqueryoperation(rt.new_string('GET supports only query operation'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{}
	mut iife_result_12 := iife_temp_12.promisetoexecute(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter', []string{}, var_promiseAdapter_mutated), var_config.getschema(), var_doc.clone(), this.resolverootvalue(mut var_config, mut var_op, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_doc), (var_operationType).str()), this.resolvecontextvalue(mut var_config, mut var_op, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_doc), (var_operationType).str()), rt.get_property(var_op, 'variables'), rt.get_property(var_op, 'operation'), var_config.getfieldresolver(), this.resolvevalidationrules(mut var_config, mut var_op, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_doc), (var_operationType).str()))
	mut var_result := iife_result_12
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError') {
		mut var_e := var_e_1.clone()
		mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{}
		mut iife_result_13 := iife_temp_13.createlocatederror(var_e.clone())
		var_result = rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: iife_result_13 }]))])
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error') {
		var_e = var_e_1.clone()
		var_result = rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: var_e }]))])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	closure_16_fn := fn [var_config] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		rt.call_method(var_result, 'setErrorsHandler', [var_config.geterrorshandler()])
		mut iife_temp_15 := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{}
		mut iife_result_15 := iife_temp_15.prepareformatter(var_config.geterrorformatter(), var_config.getdebugflag())
		rt.call_method(var_result, 'setErrorFormatter', [iife_result_15])
		return var_result.clone()
		}
	mut var_applyErrorHandling := rt.new_closure(closure_16_fn)
	return rt.call_method(var_result, 'then', [var_applyErrorHandling.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) loadpersistedquery(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_operationParams Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) rt.PhpVal {
	mut var_loader := var_config.getpersistedqueryloader()
	if rt.is_true(rt.identical(var_loader, rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_persistedqueriesarenotsupported(rt.new_string('Persisted queries are not supported by this server'))))
	}
	mut var_source := rt.call_callable(var_loader, [rt.get_property(var_operationParams, 'queryId'), var_operationParams])
	if !(var_source.clone().is_string()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_source, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode')))))) {
		mut var_documentNode := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode.class()
		mut iife_temp_16 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_16 := iife_temp_16.printsafe(var_source.clone())
		mut var_safeSource := iife_result_16
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Persisted query loader must return query string or instance of ${var_documentNode.to_string()} but got: ${var_safeSource.to_string()}"))))
	}
	return var_source.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) resolvevalidationrules(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, mut var_doc Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, operationType string) rt.PhpVal {
	mut var_doc_mutated := var_doc
	mut operationType_mutated := operationType
	mut var_validationRules := var_config.getvalidationrules()
	if rt.is_true(rt.call_function('is_callable', [var_validationRules.clone()])) {
	var_validationRules = rt.call_callable(var_validationRules, [var_params, var_doc_mutated, rt.new_string(operationType_mutated).clone()])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_validationRules, rt.new_null())))) && !(var_validationRules.clone().is_array()) {
		mut iife_temp_17 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_17 := iife_temp_17.printsafe(var_validationRules.clone())
		mut var_safeValidationRules := iife_result_17
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Expecting validation rules to be array or callable returning array, but got: ${var_safeValidationRules.to_string()}"))))
	}
	return var_validationRules.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) resolverootvalue(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, mut var_doc Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, operationType string) rt.PhpVal {
	mut var_doc_mutated := var_doc
	mut operationType_mutated := operationType
	mut var_rootValue := var_config.getrootvalue()
	if rt.is_true(rt.call_function('is_callable', [var_rootValue.clone()])) {
	var_rootValue = rt.call_callable(var_rootValue, [var_params, var_doc_mutated, rt.new_string(operationType_mutated).clone()])
	}
	return var_rootValue.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) resolvecontextvalue(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, mut var_doc Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, operationType string) rt.PhpVal {
	mut var_doc_mutated := var_doc
	mut operationType_mutated := operationType
	mut var_context := var_config.getcontext()
	if rt.is_true(rt.call_function('is_callable', [var_context.clone()])) {
	var_context = rt.call_callable(var_context, [var_params, var_doc_mutated, rt.new_string(operationType_mutated).clone()])
	}
	return var_context.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) sendresponse(var_result rt.PhpVal) {
	mut var_result_mutated := var_result
	if rt.is_true(rt.new_bool(rt.instance_of(var_result_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_actualResult := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			this.emitresponse(var_actualResult.clone())
			return rt.new_null()
			}
		rt.call_method(var_result_mutated, 'then', [rt.new_closure(closure_19_fn)])
	} else {
		this.emitresponse(var_result_mutated.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) emitresponse(var_jsonSerializable rt.PhpVal) {
	rt.call_function('header', [rt.new_string('Content-Type: application/json;charset=utf-8')])
	print(rt.json_encode(var_jsonSerializable.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) readrawbody() string {
	mut var_body := rt.call_function('file_get_contents', [rt.new_string('php://input')])
	if rt.is_true(rt.identical(var_body, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotReadBody', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_cannotreadbody(rt.new_string('Cannot not read body.'))))
	}
	return (var_body).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) parsepsrrequest(mut var_request Class_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_queryParams := rt.new_null()
	if rt.is_true(rt.identical(var_request.getmethod(), rt.new_string('GET'))) {
	mut var_bodyParams := rt.new_array()
	} else {
		mut var_contentType := var_request.getheader(rt.new_string('content-type'))
		if !(var_contentType.array_isset(rt.new_int(0))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_missingcontenttypeheader(rt.new_string('Missing "Content-Type" header'))))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_contentType.array_get(rt.new_int(0)), rt.new_string('application/graphql')]), rt.new_bool(false))))) {
		var_bodyParams = rt.create_array([rt.ArrayItem{ key: 'query', val: (var_request.getbody()).str() }])
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_contentType.array_get(rt.new_int(0)), rt.new_string('application/json')]), rt.new_bool(false))))) {
			var_bodyParams = if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Psr_Http_Message_RequestInterface', []string{}, var_request), 'Psr_Http_Message_ServerRequestInterface'))) { var_request.getparsedbody() } else { this.decodejson((var_request.getbody()).str()) }
			this.assertjsonobjectorarray(var_bodyParams.clone())
		} else {
			if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Psr_Http_Message_RequestInterface', []string{}, var_request), 'Psr_Http_Message_ServerRequestInterface'))) {
			var_bodyParams = var_request.getparsedbody()
			}
			rt.new_null()
		}
	}
	rt.call_function('parse_str', [rt.call_function('html_entity_decode', [rt.call_method(var_request.geturi(), 'getQuery', []rt.PhpVal{})]), var_queryParams])
	return this.parserequestparams((var_request.getmethod()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](var_bodyParams), mut var_queryParams)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) decodejson(rawBody string) rt.PhpVal {
	mut rawBody_mutated := rawBody
	mut var_bodyParams := rt.call_function('json_decode', [rt.new_string(rawBody_mutated).clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('json_last_error', []rt.PhpVal{}), rt.get_constant('JSON_ERROR_NONE'))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_cannotparsejsonbody('Expected JSON object or array for "application/json" request, but failed to parse because: ' + (rt.call_function('json_last_error_msg', []rt.PhpVal{})).str())))
	}
	return var_bodyParams.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) decodecontent(rawBody string) rt.PhpVal {
	mut var_bodyParams := rt.new_null()
	mut rawBody_mutated := rawBody
	rt.call_function('parse_str', [rt.new_string(rawBody_mutated).clone(), var_bodyParams.clone()])
	return var_bodyParams.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) assertjsonobjectorarray(var_bodyParams rt.PhpVal) {
	mut var_bodyParams_mutated := var_bodyParams
	if !(var_bodyParams_mutated.clone().is_array()) {
		mut iife_temp_19 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_19 := iife_temp_19.printsafejson(var_bodyParams_mutated.clone())
		mut var_notArray := iife_result_19
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_cannotparsejsonbody(rt.new_string("Expected JSON object or array for \"application/json\" request, got: ${var_notArray.to_string()}"))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) topsrresponse(var_result rt.PhpVal, mut var_response Class_Psr_Http_Message_ResponseInterface, mut var_writableBodyStream Class_Psr_Http_Message_StreamInterface) rt.PhpVal {
	mut var_actualResult := rt.new_null()
	mut var_result_mutated := var_result
	if rt.is_true(rt.new_bool(rt.instance_of(var_result_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Promise'))) {
		closure_21_fn := fn [var_response, var_writableBodyStream] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_actualResult := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return this.doconverttopsrresponse(var_actualResult.clone(), mut rt.new_object('Psr_Http_Message_ResponseInterface', []string{}, var_response), mut rt.new_object('Psr_Http_Message_StreamInterface', []string{}, var_writableBodyStream))
			}
		return rt.call_method(var_result_mutated, 'then', [rt.new_closure(closure_21_fn)])
	}
	return this.doconverttopsrresponse(var_result_mutated.clone(), mut var_response, mut var_writableBodyStream)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) doconverttopsrresponse(var_result rt.PhpVal, mut var_response Class_Psr_Http_Message_ResponseInterface, mut var_writableBodyStream Class_Psr_Http_Message_StreamInterface) rt.PhpVal {
	mut var_result_mutated := var_result
	var_writableBodyStream.write(rt.new_string((rt.json_encode(var_result_mutated.clone())).str()))
	return rt.call_method(var_response.withheader(rt.new_string('Content-Type'), rt.new_string('application/json')), 'withBody', [var_writableBodyStream])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotReadBody {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_server_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_missingcontenttypeheader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_unexpectedcontenttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_operationparams(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_httpmethodnotsupported(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_missingqueryorqueryidparameter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryparameter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryidparameter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_invalidoperationparameter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_cannotparsevariables(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables{
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

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_batchedqueriesarenotsupported(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported{
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

fn create_automattic_woocommerce_vendor_graphql_language_parser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{
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

fn create_automattic_woocommerce_vendor_graphql_server_exception_failedtodetermineoperationtype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_getmethodsupportsonlyqueryoperation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_graphql(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{
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

fn create_automattic_woocommerce_vendor_graphql_error_formattederror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_persistedqueriesarenotsupported(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_cannotreadbody(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotReadBody {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotReadBody{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_cannotparsejsonbody(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parseHttpRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parsehttprequest(mut dispatch_arg_0)
		}
		'parseRequestParams' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.parserequestparams(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'validateOperationParams' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.validateoperationparams(mut dispatch_arg_0)
		}
		'executeOperation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.executeoperation(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'executeBatch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.executebatch(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'promiseToExecuteOperation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.promisetoexecuteoperation(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
		}
		'loadPersistedQuery' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.loadpersistedquery(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'resolveValidationRules' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.resolvevalidationrules(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
		}
		'resolveRootValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.resolverootvalue(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
		}
		'resolveContextValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.resolvecontextvalue(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
		}
		'sendResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.sendresponse(dispatch_arg_0)
			return rt.new_null()
		}
		'emitResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.emitresponse(dispatch_arg_0)
			return rt.new_null()
		}
		'readRawBody' {
			return rt.new_string(this.readrawbody())
		}
		'parsePsrRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Message_RequestInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parsepsrrequest(mut dispatch_arg_0)
		}
		'decodeJson' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.decodejson(dispatch_arg_0)
		}
		'decodeContent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.decodecontent(dispatch_arg_0)
		}
		'assertJsonObjectOrArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.assertjsonobjectorarray(dispatch_arg_0)
			return rt.new_null()
		}
		'toPsrResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Psr_Http_Message_ResponseInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Psr_Http_Message_StreamInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.topsrresponse(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'doConvertToPsrResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Psr_Http_Message_ResponseInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Psr_Http_Message_StreamInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.doconverttopsrresponse(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotReadBody) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotReadBody) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotReadBody) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseJsonBody) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
