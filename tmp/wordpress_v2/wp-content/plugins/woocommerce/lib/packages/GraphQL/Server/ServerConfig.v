import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
		context rt.PhpVal = rt.new_null()
		rootValue rt.PhpVal = rt.new_null()
		errorFormatter rt.PhpVal = rt.new_null()
		errorsHandler rt.PhpVal = rt.new_null()
		debugFlag rt.PhpVal = rt.new_null()
		queryBatching rt.PhpVal = rt.new_bool(false)
		validationRules rt.PhpVal = rt.new_null()
		fieldResolver rt.PhpVal = rt.new_null()
		promiseAdapter rt.PhpVal = rt.new_null()
		persistedQueryLoader rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig.create(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array) rt.PhpVal {
	mut var_instance := create_automattic_woocommerce_vendor_graphql_server_static()
	mut iter_1 := var_config.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		mut switch_val_1 := var_key
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('schema'))) {
			var_instance.setschema(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rootValue'))) {
			var_instance.setrootvalue(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('context'))) {
			var_instance.setcontext(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fieldResolver'))) {
			var_instance.setfieldresolver(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('validationRules'))) {
			var_instance.setvalidationrules(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('queryBatching'))) {
			var_instance.setquerybatching(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('debugFlag'))) {
			var_instance.setdebugflag(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('persistedQueryLoader'))) {
			var_instance.setpersistedqueryloader(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('errorFormatter'))) {
			var_instance.seterrorformatter(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('errorsHandler'))) {
			var_instance.seterrorshandler(var_value.clone())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('promiseAdapter'))) {
			var_instance.setpromiseadapter(var_value.clone())
		} else {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Unknown server config option: ${var_key.to_string()}"))))
		}
	}
	return mut var_instance
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	this.schema = var_schema
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setcontext(var_context rt.PhpVal) rt.PhpVal {
	this.context = var_context.clone()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setrootvalue(var_rootValue rt.PhpVal) rt.PhpVal {
	this.rootValue = var_rootValue.clone()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) seterrorformatter(mut var_errorFormatter Class_Automattic_WooCommerce_Vendor_GraphQL_Server_callable) rt.PhpVal {
	this.errorFormatter = var_errorFormatter
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) seterrorshandler(mut var_handler Class_Automattic_WooCommerce_Vendor_GraphQL_Server_callable) rt.PhpVal {
	this.errorsHandler = var_handler
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setvalidationrules(var_validationRules rt.PhpVal) rt.PhpVal {
	if !(var_validationRules.clone().is_array()) && !(rt.call_function('is_callable', [var_validationRules.clone()])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_validationRules, rt.new_null())))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.printsafe(var_validationRules.clone())
		mut var_invalidValidationRules := iife_result_0
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Server config expects array of validation rules or callable returning such array, but got ${var_invalidValidationRules.to_string()}"))))
	}
	this.validationRules = var_validationRules.clone()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setfieldresolver(mut var_fieldResolver Class_Automattic_WooCommerce_Vendor_GraphQL_Server_callable) rt.PhpVal {
	this.fieldResolver = var_fieldResolver
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setpersistedqueryloader(mut var_persistedQueryLoader Class_Automattic_WooCommerce_Vendor_GraphQL_Server_?callable) rt.PhpVal {
	this.persistedQueryLoader = var_persistedQueryLoader
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setdebugflag(debugFlag i64) rt.PhpVal {
	this.debugFlag = rt.new_int(debugFlag)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setquerybatching(enableBatching bool) rt.PhpVal {
	this.queryBatching = rt.new_bool(enableBatching)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) setpromiseadapter(mut var_promiseAdapter Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter) rt.PhpVal {
	this.promiseAdapter = var_promiseAdapter
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getcontext() rt.PhpVal {
	return this.context
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getrootvalue() rt.PhpVal {
	return this.rootValue
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getschema() rt.PhpVal {
	return this.schema
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) geterrorformatter() rt.PhpVal {
	return this.errorFormatter
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) geterrorshandler() rt.PhpVal {
	return this.errorsHandler
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getpromiseadapter() rt.PhpVal {
	return this.promiseAdapter
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getvalidationrules() rt.PhpVal {
	return this.validationRules
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getfieldresolver() rt.PhpVal {
	return this.fieldResolver
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getpersistedqueryloader() rt.PhpVal {
	return this.persistedQueryLoader
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getdebugflag() i64 {
	return (this.debugFlag).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) getquerybatching() bool {
	return (this.queryBatching).to_bool()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_server_serverconfig(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
		context: rt.new_null()
		rootValue: rt.new_null()
		errorFormatter: rt.new_null()
		errorsHandler: rt.new_null()
		debugFlag: rt.new_null()
		queryBatching: rt.new_bool(false)
		validationRules: rt.new_null()
		fieldResolver: rt.new_null()
		promiseAdapter: rt.new_null()
		persistedQueryLoader: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static{
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

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig.create(mut dispatch_arg_0)
		}
		'setSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setschema(mut dispatch_arg_0)
		}
		'setContext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.setcontext(dispatch_arg_0)
		}
		'setRootValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.setrootvalue(dispatch_arg_0)
		}
		'setErrorFormatter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.seterrorformatter(mut dispatch_arg_0)
		}
		'setErrorsHandler' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.seterrorshandler(mut dispatch_arg_0)
		}
		'setValidationRules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.setvalidationrules(dispatch_arg_0)
		}
		'setFieldResolver' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setfieldresolver(mut dispatch_arg_0)
		}
		'setPersistedQueryLoader' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_?callable](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setpersistedqueryloader(mut dispatch_arg_0)
		}
		'setDebugFlag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.setdebugflag(dispatch_arg_0)
		}
		'setQueryBatching' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.setquerybatching(dispatch_arg_0)
		}
		'setPromiseAdapter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Executor_Promise_PromiseAdapter](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.setpromiseadapter(mut dispatch_arg_0)
		}
		'getContext' {
			return this.getcontext()
		}
		'getRootValue' {
			return this.getrootvalue()
		}
		'getSchema' {
			return this.getschema()
		}
		'getErrorFormatter' {
			return this.geterrorformatter()
		}
		'getErrorsHandler' {
			return this.geterrorshandler()
		}
		'getPromiseAdapter' {
			return this.getpromiseadapter()
		}
		'getValidationRules' {
			return this.getvalidationrules()
		}
		'getFieldResolver' {
			return this.getfieldresolver()
		}
		'getPersistedQueryLoader' {
			return this.getpersistedqueryloader()
		}
		'getDebugFlag' {
			return rt.new_int(this.getdebugflag())
		}
		'getQueryBatching' {
			return rt.new_bool(this.getquerybatching())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		'context' { return this.context }
		'rootValue' { return this.rootValue }
		'errorFormatter' { return this.errorFormatter }
		'errorsHandler' { return this.errorsHandler }
		'debugFlag' { return this.debugFlag }
		'queryBatching' { return this.queryBatching }
		'validationRules' { return this.validationRules }
		'fieldResolver' { return this.fieldResolver }
		'promiseAdapter' { return this.promiseAdapter }
		'persistedQueryLoader' { return this.persistedQueryLoader }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		'context' { this.context = val; return true }
		'rootValue' { this.rootValue = val; return true }
		'errorFormatter' { this.errorFormatter = val; return true }
		'errorsHandler' { this.errorsHandler = val; return true }
		'debugFlag' { this.debugFlag = val; return true }
		'queryBatching' { this.queryBatching = val; return true }
		'validationRules' { this.validationRules = val; return true }
		'fieldResolver' { this.fieldResolver = val; return true }
		'promiseAdapter' { this.promiseAdapter = val; return true }
		'persistedQueryLoader' { this.persistedQueryLoader = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
