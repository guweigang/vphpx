import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) parsehttprequest(mut var_readRawBodyFn Class_Automattic_WooCommerce_Vendor_GraphQL_Server_?callable) rt.PhpVal {
	mut var_method := if !(rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD')).is_null() { rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD') } else { rt.new_null() }
	mut var_bodyParams := rt.new_array()
	mut var_urlParams := rt.get_superglobal('_GET')
	if rt.is_true(rt.identical(var_method, rt.new_string('POST'))) {
		mut var_contentType := if !(rt.get_superglobal('_SERVER').array_get('CONTENT_TYPE')).is_null() { rt.get_superglobal('_SERVER').array_get('CONTENT_TYPE') } else { rt.new_null() }
		if rt.is_true(rt.identical(var_contentType, rt.new_null())) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_missingcontenttypeheader(rt.new_string('Missing "Content-Type" header'))))
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_rawBody := if rt.is_true(rt.identical(var_readRawBodyFn, rt.new_null())) { this.readrawbody() } else { rt.call_callable(var_readRawBodyFn, []rt.PhpVal{}) }
			var_bodyParams = rt.create_array([rt.ArrayItem{ key: 'query', val: var_rawBody }])
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_rawBody = if rt.is_true(rt.identical(var_readRawBodyFn, rt.new_null())) { this.readrawbody() } else { rt.call_callable(var_readRawBodyFn, []rt.PhpVal{}) }
			var_bodyParams = this.decodejson((var_rawBody).str())
			this.assertjsonobjectorarray(var_bodyParams.dup())
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_bodyParams = rt.get_superglobal('_POST')
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_bodyParams = rt.get_superglobal('_POST')
		} else {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_unexpectedcontenttype('Unexpected content type: ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(var_contentType.dup())).str())))
		}
	}
	return this.parserequestparams((var_method).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](var_bodyParams), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](var_urlParams))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) parserequestparams(method string, mut var_bodyParams Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array, mut var_queryParams Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array) rt.PhpVal {
	mut method_mutated := method
	mut var_bodyParams_mutated := var_bodyParams
	if rt.is_true(rt.identical(rt.new_string(method_mutated), rt.new_string('GET'))) {
		return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{}; return temp.create(arg_0, arg_1) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_array', []string{}, var_queryParams), rt.new_bool(true))
	}
	if rt.is_true(rt.identical(rt.new_string(method_mutated), rt.new_string('POST'))) {
		if var_bodyParams_mutated.array_isset(rt.new_int(0)) {
			mut var_operations := rt.new_array()
			{
				mut iter_1 := var_bodyParams_mutated.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_entry := item_1.val
					var_operations.array_push(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{}; return temp.create(arg_0) }(var_entry.dup()))
				}
			}
			return var_operations.dup()
		}
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{}; return temp.create(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_array', []string{}, var_bodyParams_mutated))
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_httpmethodnotsupported(rt.new_string("HTTP Method \"${var_method.to_string()}\" is not supported"))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) validateoperationparams(mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) rt.PhpVal {
	mut var_errors := rt.new_array()
	mut var_query := if !(rt.get_property(var_params, 'query')).is_null() { rt.get_property(var_params, 'query') } else { rt.new_string('') }
	mut var_queryId := if !(rt.get_property(var_params, 'queryId')).is_null() { rt.get_property(var_params, 'queryId') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_query, rt.new_string(''))) && rt.is_true(rt.identical(var_queryId, rt.new_string(''))))) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_missingqueryorqueryidparameter(rt.new_string('Automattic\\WooCommerce\\Vendor\\GraphQL Request must include at least one of those two parameters: "query" or "queryId"')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_query.dup().is_string()))))) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryparameter('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "query" must be string, but got ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(rt.get_property(var_params, 'query'))).str()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_queryId.dup().is_string()))))) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryidparameter('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "queryId" must be string, but got ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(rt.get_property(var_params, 'queryId'))).str()))
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_params, 'operation').is_string()))))))) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_invalidoperationparameter('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "operation" must be string, but got ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(rt.get_property(var_params, 'operation'))).str()))
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_params, 'variables').is_array()))))) || rt.get_property(var_params, 'variables').array_isset(rt.new_int(0)))))) {
		var_errors.array_push(create_automattic_woocommerce_vendor_graphql_server_exception_cannotparsevariables('Automattic\\WooCommerce\\Vendor\\GraphQL Request parameter "variables" must be object or JSON string parsed to object, but got ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(rt.get_property(var_params, 'originalInput').array_get('variables'))).str()))
	}
	return var_errors.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) executeoperation(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_op Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) rt.PhpVal {
	mut var_promiseAdapter := if !(var_config.getpromiseadapter()).is_null() { var_config.getpromiseadapter() } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}; return temp.getdefaultpromiseadapter() }() }
	mut var_result := this.promisetoexecuteoperation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](var_promiseAdapter), mut var_config, mut var_op, false)
	if rt.is_true(rt.new_bool(rt.instance_of(var_promiseAdapter, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter'))) {
		var_result = rt.call_method(var_promiseAdapter, 'wait', [var_result.dup()])
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) executebatch(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_operations Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array) rt.PhpVal {
	mut var_operations_mutated := var_operations
	mut var_promiseAdapter := if !(var_config.getpromiseadapter()).is_null() { var_config.getpromiseadapter() } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}; return temp.getdefaultpromiseadapter() }() }
	mut var_result := rt.new_array()
	{
		mut iter_1 := var_operations_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_operation := item_1.val
			var_result.array_push(this.promisetoexecuteoperation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](var_promiseAdapter), mut var_config, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams](var_operation), true))
		}
	}
	var_result = rt.call_method(var_promiseAdapter, 'all', [var_result.dup()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_promiseAdapter, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter'))) {
		var_result = rt.call_method(var_promiseAdapter, 'wait', [var_result.dup()])
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) promisetoexecuteoperation(mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter, mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_op Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, isBatch bool) rt.PhpVal {
	mut var_promiseAdapter_mutated := var_promiseAdapter
	if rt.is_true(rt.identical(var_config.getschema(), rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Schema is required for the server'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(var_isBatch && rt.is_true(rt.new_bool(!(rt.is_true(var_config.getquerybatching())))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_batchedqueriesarenotsupported(rt.new_string('Batched queries are not supported by this server'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_errors := this.validateoperationparams(mut var_op)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_locatedErrors := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error.class() }, rt.ArrayItem{ key: none, val: 'createLocatedError' }]), var_errors.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), var_locatedErrors.dup())])
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_doc := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { this.loadpersistedquery(mut var_config, mut var_op) } else { rt.get_property(var_op, 'query') }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_doc, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode')))))) {
		var_doc = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{}; return temp.parse(arg_0) }(var_doc.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_operationAST := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.getoperationast(arg_0, arg_1) }(var_doc.dup(), rt.get_property(var_op, 'operation'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(var_operationAST, rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_failedtodetermineoperationtype(rt.new_string('Failed to determine operation type'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_operationType := rt.get_property(var_operationAST, 'operation')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.get_property(var_op, 'readOnly')))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_getmethodsupportsonlyqueryoperation(rt.new_string('GET supports only query operation'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal, arg_7 rt.PhpVal, arg_8 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{}; return temp.promisetoexecute(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter', []string{}, var_promiseAdapter_mutated), var_config.getschema(), var_doc.dup(), this.resolverootvalue(mut var_config, mut var_op, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_doc), (var_operationType).str()), this.resolvecontextvalue(mut var_config, mut var_op, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_doc), (var_operationType).str()), rt.get_property(var_op, 'variables'), rt.get_property(var_op, 'operation'), var_config.getfieldresolver(), this.resolvevalidationrules(mut var_config, mut var_op, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](var_doc), (var_operationType).str()))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError') {
		mut var_e := var_e_1.dup()
		var_result = rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{}; return temp.createlocatederror(arg_0) }(var_e.dup()) }]))])
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error') {
		mut var_e := var_e_1.dup()
		var_result = rt.call_method(var_promiseAdapter_mutated, 'createFulfilled', [create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: var_e }]))])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	closure_1_fn := fn [var_config] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_result := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	rt.call_method(var_result, 'setErrorsHandler', [var_config.geterrorshandler()])
	rt.call_method(var_result, 'setErrorFormatter', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{}; return temp.prepareformatter(arg_0, arg_1) }(var_config.geterrorformatter(), var_config.getdebugflag())])
	return var_result.dup()
	}
	mut var_applyErrorHandling := rt.new_closure(closure_1_fn)
	return rt.call_method(var_result, 'then', [var_applyErrorHandling.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) loadpersistedquery(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_operationParams Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) rt.PhpVal {
	mut var_loader := var_config.getpersistedqueryloader()
	if rt.is_true(rt.identical(var_loader, rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported', []string{}, create_automattic_woocommerce_vendor_graphql_server_exception_persistedqueriesarenotsupported()))
	}
	mut var_source := rt.call_callable(, [, ])
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) resolvevalidationrules(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, mut var_doc Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, operationType string) rt.PhpVal {
	mut var_doc_mutated := var_doc
	mut operationType_mutated := operationType
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) resolverootvalue(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, mut var_doc Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, operationType string) rt.PhpVal {
	mut var_doc_mutated := var_doc
	mut operationType_mutated := operationType
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) resolvecontextvalue(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig, mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams, mut var_doc Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, operationType string) rt.PhpVal {
	mut var_doc_mutated := var_doc
	mut operationType_mutated := operationType
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) sendresponse(var_result rt.PhpVal)  {
	mut var_result_mutated := var_result
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) emitresponse(var_jsonSerializable rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) readrawbody() string {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) parsepsrrequest(mut var_request Class_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_queryParams := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) decodejson(rawBody string) rt.PhpVal {
	mut rawBody_mutated := rawBody
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) decodecontent(rawBody string) rt.PhpVal {
	mut var_bodyParams := rt.new_null()
	mut rawBody_mutated := rawBody
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) assertjsonobjectorarray(var_bodyParams rt.PhpVal)  {
	mut var_bodyParams_mutated := var_bodyParams
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) topsrresponse(var_result rt.PhpVal, mut var_response Class_Psr_Http_Message_ResponseInterface, mut var_writableBodyStream Class_Psr_Http_Message_StreamInterface) rt.PhpVal {
	mut var_actualResult := rt.new_null()
	mut var_result_mutated := var_result
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) doconverttopsrresponse(var_result rt.PhpVal, mut var_response Class_Psr_Http_Message_ResponseInterface, mut var_writableBodyStream Class_Psr_Http_Message_StreamInterface) rt.PhpVal {
	mut var_result_mutated := var_result
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

fn create_automattic_woocommerce_vendor_graphql_server_helper() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_missingcontenttypeheader() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingContentTypeHeader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_unexpectedcontenttype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType{
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

fn create_automattic_woocommerce_vendor_graphql_server_operationparams() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_httpmethodnotsupported() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_HttpMethodNotSupported{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_missingqueryorqueryidparameter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_MissingQueryOrQueryIdParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryparameter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryidparameter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_invalidoperationparameter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidOperationParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_cannotparsevariables() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_CannotParseVariables{
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

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_batchedqueriesarenotsupported() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_BatchedQueriesAreNotSupported{
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

fn create_automattic_woocommerce_vendor_graphql_language_parser() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{
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

fn create_automattic_woocommerce_vendor_graphql_server_exception_failedtodetermineoperationtype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_FailedToDetermineOperationType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_getmethodsupportsonlyqueryoperation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_GetMethodSupportsOnlyQueryOperation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_graphql() &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{
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

fn create_automattic_woocommerce_vendor_graphql_error_formattederror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_FormattedError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_persistedqueriesarenotsupported() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_PersistedQueriesAreNotSupported{
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_server_helper_php() {
	// unsupported statement: Stmt_Declare
}
