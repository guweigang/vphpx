import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer {
	rt.PhpObjectBase
pub mut:
	config rt.PhpVal = rt.new_null()
	helper rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) construct(var_config rt.PhpVal) {
	mut var_config_mutated := var_config
	if rt.is_true(rt.new_bool(var_config_mutated.dup().is_array())) {
		var_config_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig{}
			return temp.create(arg_0)
		}(var_config_mutated.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_config_mutated,
		'Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig'))))))
	{
		mut var_safeConfig := fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			return temp.printsafe(arg_0)
		}(var_config_mutated.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{},
			create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Expecting valid server config, but got ${var_safeConfig.to_string()}'))))
	}
	this.config = var_config_mutated.dup()
	this.helper = create_automattic_woocommerce_vendor_graphql_server_helper()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) handlerequest(var_parsedBody rt.PhpVal) {
	mut var_parsedBody_mutated := var_parsedBody
	mut var_result := this.executerequest(var_parsedBody_mutated.dup())
	rt.call_method(this.helper, 'sendResponse', [var_result.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) executerequest(var_parsedBody rt.PhpVal) rt.PhpVal {
	mut var_parsedBody_mutated := var_parsedBody
	if rt.is_true(rt.identical(var_parsedBody_mutated, rt.new_null())) {
		var_parsedBody_mutated = rt.call_method(this.helper, 'parseHttpRequest', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(var_parsedBody_mutated.dup().is_array())) {
		return rt.call_method(this.helper, 'executeBatch',
			[this.config, var_parsedBody_mutated.dup()])
	}
	return rt.call_method(this.helper, 'executeOperation',
		[this.config, var_parsedBody_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) processpsrrequest(mut var_request Class_Psr_Http_Message_RequestInterface, mut var_response Class_Psr_Http_Message_ResponseInterface, mut var_writableBodyStream Class_Psr_Http_Message_StreamInterface) rt.PhpVal {
	mut var_result := this.executepsrrequest(mut var_request)
	return rt.call_method(this.helper, 'toPsrResponse', [var_result.dup(), var_response,
		var_writableBodyStream])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) executepsrrequest(mut var_request Class_Psr_Http_Message_RequestInterface) rt.PhpVal {
	mut var_parsedBody := rt.call_method(this.helper, 'parsePsrRequest', [var_request])
	return this.executerequest(var_parsedBody.dup())
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_server_standardserver(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer{
		PhpObjectBase: rt.PhpObjectBase{}
		config:        rt.new_null()
		helper:        rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_serverconfig() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig{
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

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_helper() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'handleRequest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handlerequest(dispatch_arg_0)
			return rt.new_null()
		}
		'executeRequest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.executerequest(dispatch_arg_0)
		}
		'processPsrRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Message_RequestInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Psr_Http_Message_ResponseInterface](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Psr_Http_Message_StreamInterface](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.processpsrrequest(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2)
		}
		'executePsrRequest' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Message_RequestInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.executepsrrequest(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'config' { return this.config }
		'helper' { return this.helper }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_StandardServer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'config' {
			this.config = val
			return true
		}
		'helper' {
			this.helper = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_ServerConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_server_standardserver_php() {
	// unsupported statement: Stmt_Declare
}
