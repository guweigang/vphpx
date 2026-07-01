import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext {
	rt.PhpObjectBase
pub mut:
	schema         rt.PhpVal = rt.new_null()
	fragments      rt.PhpVal = rt.new_null()
	rootValue      rt.PhpVal = rt.new_null()
	contextValue   rt.PhpVal = rt.new_null()
	operation      rt.PhpVal = rt.new_null()
	variableValues rt.PhpVal = rt.new_null()
	fieldResolver  rt.PhpVal = rt.new_null()
	argsMapper     rt.PhpVal = rt.new_null()
	errors         rt.PhpVal = rt.new_null()
	promiseAdapter rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) construct(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_fragments Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, var_rootValue rt.PhpVal, var_contextValue rt.PhpVal, mut var_operation Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode, mut var_variableValues Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_errors Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array, mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_argsMapper Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable, mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter) {
	this.schema = var_schema.dup()
	this.fragments = var_fragments.dup()
	this.rootValue = var_rootValue.dup()
	this.contextValue = var_contextValue.dup()
	this.operation = var_operation.dup()
	this.variableValues = var_variableValues.dup()
	this.errors = var_errors.dup()
	this.fieldResolver = var_fieldResolver.dup()
	this.argsMapper = var_argsMapper.dup()
	this.promiseAdapter = var_promiseAdapter.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) adderror(mut var_error Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) {
	this.errors.array_push(var_error.dup())
}

fn create_automattic_woocommerce_vendor_graphql_executor_executioncontext(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal, arg_7 rt.PhpVal, arg_8 rt.PhpVal, arg_9 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext{
		PhpObjectBase:  rt.PhpObjectBase{}
		schema:         rt.new_null()
		fragments:      rt.new_null()
		rootValue:      rt.new_null()
		contextValue:   rt.new_null()
		operation:      rt.new_null()
		variableValues: rt.new_null()
		fieldResolver:  rt.new_null()
		argsMapper:     rt.new_null()
		errors:         rt.new_null()
		promiseAdapter: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7, arg_8, arg_9)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 5 {
				args[5]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_array](if args.len > 6 {
				args[6]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 7 {
				args[7]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_callable](if args.len > 8 {
				args[8]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_9 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 9 {
				args[9]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut
				dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7, mut
				dispatch_arg_8, mut dispatch_arg_9)
			return rt.new_null()
		}
		'addError' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.adderror(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'fragments' { return this.fragments }
		'rootValue' { return this.rootValue }
		'contextValue' { return this.contextValue }
		'operation' { return this.operation }
		'variableValues' { return this.variableValues }
		'fieldResolver' { return this.fieldResolver }
		'argsMapper' { return this.argsMapper }
		'errors' { return this.errors }
		'promiseAdapter' { return this.promiseAdapter }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_ExecutionContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
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
		'contextValue' {
			this.contextValue = val
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
		'fieldResolver' {
			this.fieldResolver = val
			return true
		}
		'argsMapper' {
			this.argsMapper = val
			return true
		}
		'errors' {
			this.errors = val
			return true
		}
		'promiseAdapter' {
			this.promiseAdapter = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_executioncontext_php() {
	// unsupported statement: Stmt_Declare
}
