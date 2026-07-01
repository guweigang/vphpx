import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.executequery(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, var_source rt.PhpVal, var_rootValue rt.PhpVal, var_contextValue rt.PhpVal, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_?array, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_?string, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_?callable, mut var_validationRules Class_Automattic_WooCommerce_Vendor_GraphQL_?array) rt.PhpVal {
	mut var_promiseAdapter := create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromiseadapter()
	mut var_promise := Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.promisetoexecute(mut var_promiseAdapter, mut var_schema, var_source.dup(), var_rootValue.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?array](var_contextValue), mut var_variableValues, mut var_operationName, mut var_fieldResolver, rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_?array', []string{}, var_validationRules))
	return var_promiseAdapter.wait(var_promise.dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.promisetoexecute(mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, var_source rt.PhpVal, var_rootValue rt.PhpVal, var_context rt.PhpVal, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_?array, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_?string, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_?callable, mut var_validationRules Class_Automattic_WooCommerce_Vendor_GraphQL_?array) rt.PhpVal {
	mut var_promiseAdapter_mutated := var_promiseAdapter
	mut var_documentNode := if rt.is_true(rt.new_bool(rt.instance_of(var_source, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode'))) { var_source } else { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{}; return temp.parse(arg_0) }(create_automattic_woocommerce_vendor_graphql_language_source(var_source.dup(), rt.new_string('GraphQL'))) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(var_validationRules, rt.new_null())) {
		mut var_queryComplexity := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}; return temp.getrule(arg_0) }(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity.class())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_function('assert', [rt.new_bool(rt.instance_of(var_queryComplexity, 'Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity')), rt.new_string('should not register a different rule for QueryComplexity')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_queryComplexity, 'setRawVariableValues', [var_variableValues])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		{
			mut iter_1 := var_validationRules.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_rule := item_1.val
				if rt.is_true(rt.new_bool(rt.instance_of(var_rule, 'Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QueryComplexity'))) {
					rt.call_method(var_rule, 'setRawVariableValues', [var_variableValues])
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_validationErrors := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}; return temp.validate(arg_0, arg_1, arg_2) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema), var_documentNode.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_?array', []string{}, var_validationRules))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_promiseAdapter_mutated.createfulfilled(create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), var_validationErrors.dup()))
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal, arg_7 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}; return temp.promisetoexecute(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter', []string{}, var_promiseAdapter_mutated), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, var_schema), var_documentNode.dup(), var_rootValue.dup(), var_context.dup(), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_?array', []string{}, var_variableValues), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_?string', []string{}, var_operationName), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_?callable', []string{}, var_fieldResolver))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error') {
		mut var_e := var_e_1.dup()
		return var_promiseAdapter_mutated.createfulfilled(create_automattic_woocommerce_vendor_graphql_executor_executionresult(rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: var_e }])))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.getstandarddirectives() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}; return temp.builtindirectives() }()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.getstandardtypes() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.builtinscalars() }()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.overridestandardtypes(mut var_types Class_Automattic_WooCommerce_Vendor_GraphQL_array)  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.overridestandardtypes(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_array', []string{}, var_types))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.getstandardvalidationrules() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{}; return temp.defaultrules() }()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.setdefaultfieldresolver(mut var_fn Class_Automattic_WooCommerce_Vendor_GraphQL_callable)  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}; return temp.setdefaultfieldresolver(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_callable', []string{}, var_fn))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.setdefaultargsmapper(mut var_fn Class_Automattic_WooCommerce_Vendor_GraphQL_callable)  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{}; return temp.setdefaultargsmapper(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_callable', []string{}, var_fn))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_graphql() &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromiseadapter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter{
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

fn create_automattic_woocommerce_vendor_graphql_language_source() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_documentvalidator() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator{
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

fn create_automattic_woocommerce_vendor_graphql_executor_executor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'executeQuery' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?string](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?callable](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?array](if args.len > 7 { args[7] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.executequery(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7)
		}
		'promiseToExecute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?array](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?string](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?callable](if args.len > 7 { args[7] } else { rt.new_null() })
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_?array](if args.len > 8 { args[8] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.promisetoexecute(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7, mut dispatch_arg_8)
		}
		'getStandardDirectives' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.getstandarddirectives()
		}
		'getStandardTypes' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.getstandardtypes()
		}
		'overrideStandardTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_array](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.overridestandardtypes(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getStandardValidationRules' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.getstandardvalidationrules()
		}
		'setDefaultFieldResolver' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.setdefaultfieldresolver(mut dispatch_arg_0)
			return rt.new_null()
		}
		'setDefaultArgsMapper' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL.setdefaultargsmapper(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_DocumentValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_graphql_php() {
	// unsupported statement: Stmt_Declare
}
