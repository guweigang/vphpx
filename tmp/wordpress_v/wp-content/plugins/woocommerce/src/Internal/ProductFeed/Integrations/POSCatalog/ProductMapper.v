import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper {
	rt.PhpObjectBase
pub mut:
		fields rt.PhpVal = rt.new_null()
		variation_fields rt.PhpVal = rt.new_null()
		products_controller rt.PhpVal = rt.new_null()
		variations_controller rt.PhpVal = rt.new_null()
		products_request rt.PhpVal = rt.new_null()
		variations_request rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) init()  {
	this.products_controller = create_wc_rest_products_controller()
	this.variations_controller = create_wc_rest_product_variations_controller()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) set_fields(mut var_fields Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?string)  {
	mut var_fields_mutated := var_fields
	this.fields = var_fields_mutated.dup()
	this.products_request = rt.new_null()
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) set_variation_fields(mut var_fields Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?string)  {
	mut var_fields_mutated := var_fields
	this.variation_fields = var_fields_mutated.dup()
	this.variations_request = rt.new_null()
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) map_product(mut var_product Class_WC_Product) rt.PhpVal {
	mut var_is_variation := var_product.is_type(rt.new_string('variation'))
	mut var_controller := if rt.is_true(var_is_variation) { this.variations_controller } else { this.products_controller }
	if rt.is_true(rt.identical(rt.new_null(), var_controller)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_RuntimeException', []string{}, create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_runtimeexception(rt.new_string('ProductMapper::init() must be called before map_product().'))))
	}
	mut var_request := if rt.is_true(var_is_variation) { this.get_variations_request() } else { this.get_products_request() }
	mut var_response := rt.call_method(var_controller, 'prepare_object_for_response', [var_product, var_request.dup()])
	mut var_fields := if rt.is_true(var_is_variation) { this.variation_fields } else { this.fields }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_response = rt.call_function('rest_filter_response_fields', [var_response.dup(), rt.call_function('rest_get_server', []rt.PhpVal{}), var_request.dup()])
	}
	mut var_row := rt.create_array([rt.ArrayItem{ key: 'type', val: var_product.get_type() }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_response, 'get_data', []rt.PhpVal{}) }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_pos_catalog_map_product'), var_row.dup(), var_product])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) get_products_request() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.products_request)) {
		mut var_request := create_wp_rest_request(rt.new_string('GET'))
		this.products_request = var_request.dup()
		rt.call_method(this.products_request, 'set_param', [rt.new_string('context'), rt.new_string('view')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(this.products_request, 'set_param', [rt.new_string('_fields'), this.fields])
		}
	}
	return this.products_request
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) get_variations_request() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.variations_request)) {
		mut var_request := create_wp_rest_request(rt.new_string('GET'))
		this.variations_request = var_request.dup()
		rt.call_method(this.variations_request, 'set_param', [rt.new_string('context'), rt.new_string('view')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(this.variations_request, 'set_param', [rt.new_string('_fields'), this.variation_fields])
		}
	}
	return this.variations_request
}

struct Class_WC_REST_Products_Controller {
	rt.PhpObjectBase
}

struct Class_WC_REST_Product_Variations_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_RuntimeException {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_productmapper() &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper{
		PhpObjectBase: rt.PhpObjectBase{}
		fields: rt.new_null()
		variation_fields: rt.new_null()
		products_controller: rt.new_null()
		variations_controller: rt.new_null()
		products_request: rt.new_null()
		variations_request: rt.new_null()
	}
	return obj
}

fn create_wc_rest_products_controller() &Class_WC_REST_Products_Controller {
	mut obj := &Class_WC_REST_Products_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_product_variations_controller() &Class_WC_REST_Product_Variations_Controller {
	mut obj := &Class_WC_REST_Product_Variations_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_runtimeexception() &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request() &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'set_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_fields(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_variation_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_variation_fields(mut dispatch_arg_0)
			return rt.new_null()
		}
		'map_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.map_product(mut dispatch_arg_0)
		}
		'get_products_request' {
			return this.get_products_request()
		}
		'get_variations_request' {
			return this.get_variations_request()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fields' { return this.fields }
		'variation_fields' { return this.variation_fields }
		'products_controller' { return this.products_controller }
		'variations_controller' { return this.variations_controller }
		'products_request' { return this.products_request }
		'variations_request' { return this.variations_request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fields' { this.fields = val; return true }
		'variation_fields' { this.variation_fields = val; return true }
		'products_controller' { this.products_controller = val; return true }
		'variations_controller' { this.variations_controller = val; return true }
		'products_request' { this.products_request = val; return true }
		'variations_request' { this.variations_request = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Products_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Products_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Products_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_Product_Variations_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Variations_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Variations_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productfeed_integrations_poscatalog_productmapper_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
