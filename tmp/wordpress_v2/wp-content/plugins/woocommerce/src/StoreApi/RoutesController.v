import rt

struct Class_Automattic_WooCommerce_StoreApi_RoutesController {
	rt.PhpObjectBase
pub mut:
		schema_controller rt.PhpVal = rt.new_null()
		routes rt.PhpVal = rt.new_array()
}

fn init_static_automattic_woocommerce_storeapi_routescontroller() {
		rt.init_static_prop('Automattic_WooCommerce_StoreApi_RoutesController', 'api_namespace', rt.new_string('wc/store'))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) construct(mut var_schema_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	this.schema_controller = var_schema_controller
	this.routes = rt.create_array([rt.ArrayItem{ key: 'v1', val: rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartApplyCoupon.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartApplyCoupon.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCoupons.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCoupons.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartExtensions.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartExtensions.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartItems.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartItems.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartItemsByKey.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartItemsByKey.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveItem.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveItem.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartSelectShippingRate.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartSelectShippingRate.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributesById.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributesById.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductBrands.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductBrands.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductBrandsById.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductBrandsById.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductTags.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductTags.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsById.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsById.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug.class() }]) }, rt.ArrayItem{ key: 'private', val: rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns.class() }]) }, rt.ArrayItem{ key: 'agentic', val: rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessions.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsUpdate.class() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete.identifier(), val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete.class() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) register_all_routes() {
	this.register_routes('v1', (rt.get_static_prop('Automattic_WooCommerce_StoreApi_RoutesController', 'api_namespace')).str())
	this.register_routes('v1', (rt.get_static_prop('Automattic_WooCommerce_StoreApi_RoutesController', 'api_namespace')).str() + '/v1')
	this.register_routes('private', 'wc/private')
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('agentic_checkout'))
	if rt.is_true(iife_result_0) {
		this.register_routes('agentic', 'wc/agentic/v1')
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) get(var_name rt.PhpVal, version string) rt.PhpVal {
	mut var_route := if !(this.routes.array_get(rt.new_string(version)).array_get(var_name)).is_null() { this.routes.array_get(rt.new_string(version)).array_get(var_name) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_route)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exception', []string{}, create_automattic_woocommerce_storeapi_exception(rt.new_string("${var_name.to_string()} ${var_version} route does not exist"))))
	}
	return rt.new_object('', []string{}, rt.create_object_dynamically(var_route, [this.schema_controller, rt.call_method(this.schema_controller, 'get', [Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":119,"name":"route"}.schema_type(), Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":119,"name":"route"}.schema_version()])]))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) get_all_routes(version string, controller bool) rt.PhpVal {
	mut var_routes := rt.new_array()
	mut iter_1 := this.routes.array_get(rt.new_string(version)).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_route_class := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_route_class.clone(), rt.new_string('get_path_regex')]))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exception', []string{}, create_automattic_woocommerce_storeapi_exception(rt.call_function('esc_html', [rt.new_string("${var_route_class.to_string()} route does not have a get_path_regex method")]))))
		}
		mut iife_temp_1 := Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"}{}
		mut iife_result_1 := iife_temp_1.get_path_regex()
		mut var_route_path := rt.new_string('/' + (rt.call_function('trailingslashit', [rt.get_static_prop('Automattic_WooCommerce_StoreApi_RoutesController', 'api_namespace')])).str() + version + (iife_result_1).str())
		var_routes.array_set(var_route_path, if var_controller { var_route_class } else { rt.new_array() })
	}
	return var_routes.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) register_routes(version string, namespace string) {
	if !(this.routes.array_isset(rt.new_string(version))) {
		return
	}
	mut var_route_identifiers := rt.func_array_keys(this.routes.array_get(rt.new_string(version)))
	mut iter_2 := var_route_identifiers.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_route := item_2.val
		mut var_route_instance := this.get(var_route.clone(), version)
		rt.call_method(var_route_instance, 'set_namespace', [rt.new_string(namespace)])
		rt.call_function('register_rest_route', [rt.call_method(var_route_instance, 'get_namespace', []rt.PhpVal{}), rt.call_method(var_route_instance, 'get_path', []rt.PhpVal{}), rt.call_method(var_route_instance, 'get_args', []rt.PhpVal{})])
	}
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"} {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routescontroller(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_RoutesController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_RoutesController{
		PhpObjectBase: rt.PhpObjectBase{}
		schema_controller: rt.new_null()
		routes: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exception {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_{"nodetype":"expr_variable","line":144,"name":"route_class"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"} {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_all_routes' {
			this.register_all_routes()
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'get_all_routes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_all_routes(dispatch_arg_0, dispatch_arg_1)
		}
		'register_routes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.register_routes(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_RoutesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema_controller' { return this.schema_controller }
		'routes' { return this.routes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema_controller' { this.schema_controller = val; return true }
		'routes' { this.routes = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_RoutesController', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_automattic_woocommerce_storeapi_routescontroller(c_arg_0)
		return rt.new_object('Automattic_WooCommerce_StoreApi_RoutesController', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_FeaturesUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_featuresutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_FeaturesUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_storeapi_exception()
		return rt.new_object('Automattic_WooCommerce_StoreApi_Exception', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_storeapi_{"nodetype":"expr_variable","line":144,"name":"route_class"}()
		return rt.new_object('Automattic_WooCommerce_StoreApi_{"nodeType":"Expr_Variable","line":144,"name":"route_class"}', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
