import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	rt.PhpObjectBase
pub mut:
		defaultFieldResolver rt.PhpVal = rt.new_array()
		defaultArgsMapper rt.PhpVal = rt.new_array()
		defaultPromiseAdapter rt.PhpVal = rt.new_null()
		implementationFactory rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getdefaultfieldresolver() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setdefaultfieldresolver(mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getdefaultargsmapper() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setdefaultargsmapper(mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getdefaultpromiseadapter() rt.PhpVal {
	return // unsupported expression: Expr_AssignOp_Coalesce
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setdefaultpromiseadapter(mut var_defaultPromiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?PromiseAdapter)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getimplementationfactory() rt.PhpVal {
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setimplementationfactory(mut var_implementationFactory Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.execute(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_documentNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, var_rootValue rt.PhpVal, var_contextValue rt.PhpVal, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable) rt.PhpVal {
	mut var_promiseAdapter := create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromiseadapter()
	mut var_result := Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.promisetoexecute(mut var_promiseAdapter, mut var_schema, mut var_documentNode, var_rootValue.dup(), var_contextValue.dup(), mut var_variableValues, mut var_operationName, mut var_fieldResolver)
	return var_promiseAdapter.wait(var_result.dup())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.promisetoexecute(mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter, mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_documentNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode, var_rootValue rt.PhpVal, var_contextValue rt.PhpVal, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array, mut var_operationName Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable, mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable) rt.PhpVal {
	mut var_promiseAdapter_mutated := var_promiseAdapter
	mut var_executor := rt.call_callable(// unsupported expression: Expr_StaticPropertyFetch, [var_promiseAdapter_mutated, var_schema, var_documentNode, var_rootValue.dup(), var_contextValue.dup(), if !(var_variableValues).is_null() { var_variableValues } else { rt.new_array() }, var_operationName, if !(var_fieldResolver).is_null() { var_fieldResolver } else { // unsupported expression: Expr_StaticPropertyFetch }, if !(var_argsMapper).is_null() { var_argsMapper } else { // unsupported expression: Expr_StaticPropertyFetch }])
	return rt.call_method(var_executor, 'doExecute', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.defaultfieldresolver(var_objectLikeValue rt.PhpVal, mut var_args Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_contextValue rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) rt.PhpVal {
	mut var_property := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.extractkey(arg_0, arg_1) }(var_objectLikeValue.dup(), rt.get_property(var_info, 'fieldName'))
	return if rt.is_true(rt.new_bool(rt.instance_of(var_property, 'Automattic_WooCommerce_Vendor_GraphQL_Executor_Closure'))) { rt.call_callable(var_property, [var_objectLikeValue.dup(), var_args, var_contextValue.dup(), var_info]) } else { var_property }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.defaultargsmapper(mut var_args Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Executor_array', []string{}, var_args)
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_executor_executor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor{
		PhpObjectBase: rt.PhpObjectBase{}
		defaultFieldResolver: rt.new_array()
		defaultArgsMapper: rt.new_array()
		defaultPromiseAdapter: rt.new_null()
		implementationFactory: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_executor_promise_adapter_syncpromiseadapter() &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_Adapter_SyncPromiseAdapter{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getDefaultFieldResolver' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getdefaultfieldresolver()
		}
		'setDefaultFieldResolver' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setdefaultfieldresolver(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getDefaultArgsMapper' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getdefaultargsmapper()
		}
		'setDefaultArgsMapper' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setdefaultargsmapper(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getDefaultPromiseAdapter' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getdefaultpromiseadapter()
		}
		'setDefaultPromiseAdapter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?PromiseAdapter](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setdefaultpromiseadapter(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getImplementationFactory' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.getimplementationfactory()
		}
		'setImplementationFactory' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.setimplementationfactory(mut dispatch_arg_0)
			return rt.new_null()
		}
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable](if args.len > 6 { args[6] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.execute(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6)
		}
		'promiseToExecute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?array](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?string](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable](if args.len > 7 { args[7] } else { rt.new_null() })
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_?callable](if args.len > 8 { args[8] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.promisetoexecute(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7, mut dispatch_arg_8)
		}
		'defaultFieldResolver' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.defaultfieldresolver(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'defaultArgsMapper' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor.defaultargsmapper(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'defaultFieldResolver' { return this.defaultFieldResolver }
		'defaultArgsMapper' { return this.defaultArgsMapper }
		'defaultPromiseAdapter' { return this.defaultPromiseAdapter }
		'implementationFactory' { return this.implementationFactory }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Executor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'defaultFieldResolver' { this.defaultFieldResolver = val; return true }
		'defaultArgsMapper' { this.defaultArgsMapper = val; return true }
		'defaultPromiseAdapter' { this.defaultPromiseAdapter = val; return true }
		'implementationFactory' { this.implementationFactory = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_executor_php() {
	// unsupported statement: Stmt_Declare
}
