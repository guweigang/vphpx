import rt

struct Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_blocks_sharedstores_productsstore() {
		rt.init_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'consent_statement', rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'))
		rt.init_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace', rt.new_string('woocommerce/products'))
		rt.init_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'product_variations', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'loaded_variation_parents', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'getters_registered', rt.new_bool(false))
}

fn Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.check_consent(consent_statement string) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(consent_statement), rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'consent_statement'))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('This method cannot be called without consenting that the API may change.'))))
	}
	return true
}

fn Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.register_getters() {
	if rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'getters_registered')) {
		return
	}
	rt.set_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'getters_registered', rt.new_bool(true))
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := rt.call_function('wp_interactivity_get_context', []rt.PhpVal{})
		mut var_state := rt.call_function('wp_interactivity_state', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace')])
		mut var_product_id := if rt.is_true(rt.new_bool(var_context.clone().array_isset(rt.new_string('productId')))) { var_context.array_get(rt.new_string('productId')) } else { if !(var_state.array_get(rt.new_string('productId'))).is_null() { var_state.array_get(rt.new_string('productId')) } else { rt.new_null() } }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
			return
		}
		return
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := rt.call_function('wp_interactivity_get_context', []rt.PhpVal{})
		mut var_state := rt.call_function('wp_interactivity_state', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace')])
		mut var_variation_id := if rt.is_true(rt.new_bool(var_context.clone().array_isset(rt.new_string('variationId')))) { var_context.array_get(rt.new_string('variationId')) } else { if !(var_state.array_get(rt.new_string('variationId'))).is_null() { var_state.array_get(rt.new_string('variationId')) } else { rt.new_null() } }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_variation_id)))) {
			return
		}
		return
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_state := rt.call_function('wp_interactivity_state', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace')])
		mut var_selected := if rt.is_true(rt.new_bool(rt.instance_of(var_state.array_get(rt.new_string('productVariationInContext')), 'Automattic_WooCommerce_Blocks_SharedStores_Closure'))) { rt.call_callable(var_state.array_get(rt.new_string('productVariationInContext')), []rt.PhpVal{}) } else { var_state.array_get(rt.new_string('productVariationInContext')) }
		if rt.is_true(var_selected) {
			return
		}
		return
		}
	rt.call_function('wp_interactivity_state', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace'), rt.create_array([rt.ArrayItem{ key: 'mainProductInContext', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'productVariationInContext', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'productInContext', val: rt.new_closure(closure_3_fn) }])])
}

fn Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.load_product(consent_statement string, product_id i64) rt.PhpVal {
	Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.check_consent(consent_statement)
	if rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products').array_isset(rt.new_int(product_id)) {
		return rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products').array_get(rt.new_int(product_id))
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_3 := iife_temp_3.container()
	mut var_response := rt.call_method(rt.call_method(iife_result_3, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration.class()]), 'get_rest_api_response_data', [rt.new_string('/wc/store/v1/products/' + product_id.str())])
	rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products').array_set(product_id, if !(var_response.array_get(rt.new_string('body'))).is_null() { var_response.array_get(rt.new_string('body')) } else { rt.new_array() })
	Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.register_getters()
	rt.call_function('wp_interactivity_state', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace'), rt.create_array([rt.ArrayItem{ key: 'products', val: rt.create_array([rt.ArrayItem{ key: product_id, val: rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products').array_get(rt.new_int(product_id)) }]) }])])
	return rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products').array_get(rt.new_int(product_id))
}

fn Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.load_purchasable_child_products(consent_statement string, parent_id i64) rt.PhpVal {
	mut var_id := rt.new_null()
	mut var_product := rt.new_null()
	Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.check_consent(consent_statement)
	mut var_parent_product := rt.call_function('wc_get_product', [rt.new_int(parent_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_product)))) {
		return rt.new_array()
	}
	mut var_child_ids := rt.call_method(var_parent_product, 'get_children', []rt.PhpVal{})
	if !rt.is_true(var_child_ids) {
		return rt.new_array()
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return 'include[]=' + (var_id).str()
		}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return 'include[]=' + (var_id).str()
		}
	mut var_include_params := rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_child_ids.clone()])
	mut var_query_string := rt.call_function('implode', [rt.new_string('&'), var_include_params.clone()])
	mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_6 := iife_temp_6.container()
	mut var_response := rt.call_method(rt.call_method(iife_result_6, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration.class()]), 'get_rest_api_response_data', [rt.new_string('/wc/store/v1/products?' + (var_query_string).str())])
	if !rt.is_true(var_response.array_get(rt.new_string('body'))) {
		return rt.new_array()
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product.array_get(rt.new_string('is_purchasable'))
		}
	mut var_purchasable_products := rt.call_function('array_filter', [var_response.array_get(rt.new_string('body')), rt.new_closure(closure_8_fn)])
	mut var_keyed_products := rt.call_function('array_column', [var_purchasable_products.clone(), rt.new_null(), rt.new_string('id')])
	rt.set_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products', rt.call_function('array_replace', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'products'), var_keyed_products.clone()]))
	Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.register_getters()
	rt.call_function('wp_interactivity_state', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace'), rt.create_array([rt.ArrayItem{ key: 'products', val: var_keyed_products }])])
	return var_keyed_products.clone()
}

fn Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.load_variations(consent_statement string, parent_id i64) rt.PhpVal {
	mut var_variation := rt.new_null()
	Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.check_consent(consent_statement)
	if rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'loaded_variation_parents').array_isset(rt.new_int(parent_id)) {
		closure_9_fn := fn [var_parent_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_variation := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.identical(if !(var_variation.array_get(rt.new_string('parent'))).is_null() { var_variation.array_get(rt.new_string('parent')) } else { rt.new_int(0) }, rt.new_int(parent_id))
			}
		return rt.call_function('array_filter', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'product_variations'), rt.new_closure(closure_9_fn)])
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_9 := iife_temp_9.container()
	mut var_response := rt.call_method(rt.call_method(iife_result_9, 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_Hydration.class()]), 'get_rest_api_response_data', [rt.new_string('/wc/store/v1/products?parent[]=' + parent_id.str() + '&type=variation')])
	rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'loaded_variation_parents').array_set(parent_id, true)
	if !rt.is_true(var_response.array_get(rt.new_string('body'))) {
		return rt.new_array()
	}
	mut var_keyed_variations := rt.call_function('array_column', [var_response.array_get(rt.new_string('body')), rt.new_null(), rt.new_string('id')])
	rt.set_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'product_variations', rt.call_function('array_replace', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'product_variations'), var_keyed_variations.clone()]))
	Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.register_getters()
	rt.call_function('wp_interactivity_state', [rt.get_static_prop('Automattic_WooCommerce_Blocks_SharedStores_ProductsStore', 'store_namespace'), rt.create_array([rt.ArrayItem{ key: 'productVariations', val: var_keyed_variations }])])
	return var_keyed_variations.clone()
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_sharedstores_productsstore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore {
	mut obj := &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'check_consent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.check_consent(dispatch_arg_0))
		}
		'register_getters' {
			Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.register_getters()
			return rt.new_null()
		}
		'load_product' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.load_product(dispatch_arg_0, dispatch_arg_1)
		}
		'load_purchasable_child_products' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.load_purchasable_child_products(dispatch_arg_0, dispatch_arg_1)
		}
		'load_variations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore.load_variations(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_SharedStores_ProductsStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
