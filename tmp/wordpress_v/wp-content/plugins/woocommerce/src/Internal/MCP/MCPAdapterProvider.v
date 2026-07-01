import rt

pub fn Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.mcp_namespace() string {
	return 'woocommerce'
}
pub fn Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.mcp_route() string {
	return 'mcp'
}
struct Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider {
	rt.PhpObjectBase
pub mut:
		initialized bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) construct()  {
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_initialize' }]), rt.new_int(10)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) maybe_initialize()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('mcp_integration')))))) {
		return rt.new_null()
	}
	if rt.is_true(this.initialized) {
		return rt.new_null()
	}
	this.initialize_mcp_adapter()
	this.register_hooks()
	this.initialized = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) initialize_mcp_adapter()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP\\MCP\\Core\\McpAdapter')]))))) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_logger')])) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.new_string('MCP adapter class not found. Skipping MCP initialization.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-mcp' }])])
		}
		return rt.new_null()
	}
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Core_McpAdapter{}; return temp.instance() }()
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) register_hooks()  {
	rt.call_function('add_action', [rt.new_string('mcp_adapter_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'initialize_mcp_server' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) initialize_mcp_server(var_adapter rt.PhpVal)  {
	mut var_abilities_ids := this.get_woocommerce_mcp_abilities()
	if !rt.is_true(var_abilities_ids) {
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('mcp_validation_enabled'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'disable_mcp_validation' }]), rt.new_int(999)])
	rt.call_method(var_adapter, 'create_server', [rt.new_string('woocommerce-mcp'), Class_Automattic_WooCommerce_Internal_MCP_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.mcp_namespace(), Class_Automattic_WooCommerce_Internal_MCP_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.mcp_route(), rt.call_function('__', [rt.new_string('WooCommerce MCP Server'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('AI-accessible WooCommerce operations via MCP'), rt.new_string('woocommerce')]), rt.new_string('1.0.0'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_MCP_Transport_WooCommerceRestTransport.class() }]), Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Infrastructure_ErrorHandling_ErrorLogMcpErrorHandler.class(), Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Infrastructure_Observability_NullMcpObservabilityHandler.class(), var_abilities_ids.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_MCP_Throwable') {
		mut var_e := var_e_1.dup()
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_logger')])) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', ['MCP server initialization failed: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-mcp' }])])
		}
		unsafe { goto finally_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto finally_label_1 }
	}

finally_label_1:
	rt.call_function('remove_filter', [rt.new_string('mcp_validation_enabled'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'disable_mcp_validation' }]), rt.new_int(999)])
	if rt.has_exception() { return }

end_label_1:
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) get_woocommerce_mcp_abilities() rt.PhpVal {
	mut var_abilities_registry := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRegistry.class()])
	mut var_all_abilities_ids := rt.call_method(var_abilities_registry, 'get_abilities_ids', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_ability_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_include := rt.call_function('str_starts_with', [var_ability_id.dup(), rt.new_string('woocommerce/')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_mcp_include_ability'), var_include.dup(), var_ability_id.dup()])
	}
	mut var_mcp_abilities := rt.call_function('array_filter', [var_all_abilities_ids.dup(), rt.new_closure(closure_1_fn)])
	return rt.call_function('array_values', [var_mcp_abilities.dup()])
}

fn Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.disable_mcp_validation() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) is_initialized() bool {
	return this.initialized
}

fn Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.is_mcp_request() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{}))))) {
		return false
	}
	mut var_request_uri := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])]) } else { rt.new_string('') }
	mut var_mcp_endpoint := rt.new_string('/' + (Class_Automattic_WooCommerce_Internal_MCP_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.mcp_namespace()).str() + '/' + (Class_Automattic_WooCommerce_Internal_MCP_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.mcp_route()).str())
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Core_McpAdapter {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_mcp_mcpadapterprovider() &Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		initialized: false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_mcp_wp_mcp_core_mcpadapter() &Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Core_McpAdapter {
	mut obj := &Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Core_McpAdapter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'maybe_initialize' {
			this.maybe_initialize()
			return rt.new_null()
		}
		'initialize_mcp_adapter' {
			this.initialize_mcp_adapter()
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'initialize_mcp_server' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.initialize_mcp_server(dispatch_arg_0)
			return rt.new_null()
		}
		'get_woocommerce_mcp_abilities' {
			return this.get_woocommerce_mcp_abilities()
		}
		'disable_mcp_validation' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.disable_mcp_validation())
		}
		'is_initialized' {
			return rt.new_bool(this.is_initialized())
		}
		'is_mcp_request' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider.is_mcp_request())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'initialized' { return rt.new_bool(this.initialized) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'initialized' { this.initialized = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Core_McpAdapter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Core_McpAdapter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_WP_MCP_Core_McpAdapter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_mcp_mcpadapterprovider_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
