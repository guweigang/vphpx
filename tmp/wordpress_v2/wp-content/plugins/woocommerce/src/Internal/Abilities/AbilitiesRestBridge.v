import rt

struct Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge.get_configurations() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'controller'
				val: Class_Automattic_WooCommerce_Internal_Abilities_WC_REST_Products_Controller.class()
			},
			rt.ArrayItem{ key: 'route', val: '/wc/v3/products' },
			rt.ArrayItem{ key: 'abilities', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/products-list' },
					rt.ArrayItem{ key: 'operation', val: 'list' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('List Products'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Retrieve a paginated list of products with optional filters for status, category, price range, and other attributes.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/products-get' },
					rt.ArrayItem{ key: 'operation', val: 'get' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Get Product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Retrieve detailed information about a single product by ID, including price, description, images, and metadata.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/products-create' },
					rt.ArrayItem{ key: 'operation', val: 'create' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Create Product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Create a new product in WooCommerce with name, price, description, and other product attributes.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/products-update' },
					rt.ArrayItem{ key: 'operation', val: 'update' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Update Product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Update an existing product by modifying its attributes such as price, stock, description, or metadata.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/products-delete' },
					rt.ArrayItem{ key: 'operation', val: 'delete' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Delete Product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Permanently delete a product from the store. This action cannot be undone.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'controller'
				val: Class_Automattic_WooCommerce_Internal_Abilities_WC_REST_Orders_Controller.class()
			},
			rt.ArrayItem{ key: 'route', val: '/wc/v3/orders' },
			rt.ArrayItem{ key: 'abilities', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/orders-list' },
					rt.ArrayItem{ key: 'operation', val: 'list' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('List Orders'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Retrieve a paginated list of orders with optional filters for status, customer, date range, and other criteria.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/orders-get' },
					rt.ArrayItem{ key: 'operation', val: 'get' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Get Order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Retrieve detailed information about a single order by ID, including line items, customer details, and payment information.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/orders-create' },
					rt.ArrayItem{ key: 'operation', val: 'create' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Create Order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Create a new order with customer information, line items, shipping details, and payment information.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce/orders-update' },
					rt.ArrayItem{ key: 'operation', val: 'update' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Update Order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Update an existing order by modifying status, customer information, line items, or other order details.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
			]) },
		]) },
	])
}

fn Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge.init() {
	rt.call_function('add_action', [rt.new_string('abilities_api_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_abilities' }])])
	rt.call_function('add_action', [rt.new_string('wp_abilities_api_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_abilities' }])])
}

fn Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge.register_abilities() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider{}
	mut iife_result_0 := iife_temp_0.is_mcp_request()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	mut iter_1 :=
		Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge.get_configurations().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_config := item_1.val
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory{}
		mut iife_result_1 := iife_temp_1.register_controller_abilities(var_config.clone())
	}
}

struct Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_abilities_abilitiesrestbridge(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_mcp_mcpadapterprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_abilities_rest_restabilityfactory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory {
	mut obj := &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_configurations' {
			return Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge.get_configurations()
		}
		'init' {
			Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge.init()
			return rt.new_null()
		}
		'register_abilities' {
			Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge.register_abilities()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_AbilitiesRestBridge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_MCP_MCPAdapterProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Abilities_REST_RestAbilityFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
