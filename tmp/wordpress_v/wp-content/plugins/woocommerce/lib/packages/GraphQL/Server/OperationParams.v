import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams {
	rt.PhpObjectBase
pub mut:
	queryId       rt.PhpVal = rt.new_null()
	query         rt.PhpVal = rt.new_null()
	operation     rt.PhpVal = rt.new_null()
	variables     rt.PhpVal = rt.new_null()
	extensions    rt.PhpVal = rt.new_null()
	readOnly      rt.PhpVal = rt.new_null()
	originalInput rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams.create(mut var_params Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array, readonly bool) rt.PhpVal {
	mut var_params_mutated := var_params
	mut var_instance := create_automattic_woocommerce_vendor_graphql_server_static()
	var_params_mutated = rt.call_function('array_change_key_case', [
		var_params_mutated.dup(), rt.get_constant('CASE_LOWER')])
	rt.set_property(var_instance, 'originalInput', var_params_mutated.dup())
	// unsupported expression: Expr_AssignOp_Plus
	{
		mut iter_1 := var_params_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.identical(var_value, rt.new_string(''))) {
				var_value = rt.new_null()
			}
		}
	}
	rt.set_property(var_instance, 'query', var_params_mutated.array_get('query'))
	rt.set_property(var_instance, 'queryId', if !(var_params_mutated.array_get('queryid')).is_null() {
		var_params_mutated.array_get('queryid')
	} else {
		if !(var_params_mutated.array_get('documentid')).is_null() {
			var_params_mutated.array_get('documentid')
		} else {
			var_params_mutated.array_get('id')
		}
	})
	rt.set_property(var_instance, 'operation', var_params_mutated.array_get('operationname'))
	rt.set_property(var_instance, 'variables',
		Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams.decodeifjson(var_params_mutated.array_get('variables')))
	rt.set_property(var_instance, 'extensions',
		Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams.decodeifjson(var_params_mutated.array_get('extensions')))
	rt.set_property(var_instance, 'readOnly', rt.new_bool(readonly))
	if rt.is_true(rt.new_bool(
		rt.get_property(var_instance, 'extensions').array_get('persistedQuery').array_isset(rt.new_string('sha256Hash'))
		&& rt.is_true(rt.identical(rt.get_property(var_instance, 'queryId'), rt.new_null()))))
	{
		rt.set_property(var_instance, 'queryId',
			rt.get_property(var_instance, 'extensions').array_get('persistedQuery').array_get('sha256Hash'))
	}
	return mut var_instance
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams.decodeifjson(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return var_value_mutated.dup()
	}
	mut var_decoded := rt.call_function('json_decode', [var_value_mutated.dup(),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.call_function('json_last_error', []rt.PhpVal{}),
		rt.get_constant('JSON_ERROR_NONE')))
	{
		return var_decoded.dup()
	}
	return var_value_mutated.dup()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_server_operationparams() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams{
		PhpObjectBase: rt.PhpObjectBase{}
		queryId:       rt.new_null()
		query:         rt.new_null()
		operation:     rt.new_null()
		variables:     rt.new_null()
		extensions:    rt.new_null()
		readOnly:      rt.new_null()
		originalInput: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_static() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Server_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams.create(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		'decodeIfJSON' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams.decodeifjson(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queryId' { return this.queryId }
		'query' { return this.query }
		'operation' { return this.operation }
		'variables' { return this.variables }
		'extensions' { return this.extensions }
		'readOnly' { return this.readOnly }
		'originalInput' { return this.originalInput }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_OperationParams) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queryId' {
			this.queryId = val
			return true
		}
		'query' {
			this.query = val
			return true
		}
		'operation' {
			this.operation = val
			return true
		}
		'variables' {
			this.variables = val
			return true
		}
		'extensions' {
			this.extensions = val
			return true
		}
		'readOnly' {
			this.readOnly = val
			return true
		}
		'originalInput' {
			this.originalInput = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_server_operationparams_php() {
	// unsupported statement: Stmt_Declare
}
