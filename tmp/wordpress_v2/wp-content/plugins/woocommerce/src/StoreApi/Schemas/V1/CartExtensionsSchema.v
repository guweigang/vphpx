import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema.identifier() string {
	return 'cart-extensions'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema {
	rt.PhpObjectBase
pub mut:
	title       rt.PhpVal = rt.new_string('cart-extensions')
	cart_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	mut var_controller_mutated := var_controller
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema',
		[]string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController',
		[]string{}, var_controller_mutated))
	this.cart_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema) get_properties() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema) get_item_response(var_request rt.PhpVal) rt.PhpVal {
	mut var_callback := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
	], &this), 'extend'), 'get_update_callback', [
		var_request.array_get(rt.new_string('namespace')),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Schemas_V1_Exception') {
		mut var_e := var_e_1.clone()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_extensions_error'), rt.call_function('esc_html', [
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
		]), rt.new_int(400))))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	rt.call_callable(var_callback, [var_request.array_get(rt.new_string('data'))])
	mut var_controller := create_automattic_woocommerce_storeapi_utilities_cartcontroller()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_cart := var_controller.calculate_totals()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_response := rt.call_method(this.cart_schema, 'get_item_response', [
		var_cart.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return rt.call_function('rest_ensure_response', [var_response.clone()])
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_StoreApi_Schemas_V1_Exception') {
		var_e = var_e_2.clone()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_extensions_error'), rt.call_function('esc_html', [
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
		]), rt.new_int(400))))
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_cartextensionsschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('cart-extensions')
		cart_schema:   rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'cart_schema' { return this.cart_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartExtensionsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		'cart_schema' {
			this.cart_schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
