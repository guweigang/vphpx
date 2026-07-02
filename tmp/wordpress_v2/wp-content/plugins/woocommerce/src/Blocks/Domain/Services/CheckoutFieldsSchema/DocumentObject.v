import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject {
	rt.PhpObjectBase
pub mut:
	context           rt.PhpVal = rt.new_null()
	valid_contexts    rt.PhpVal = rt.new_array()
	cart              rt.PhpVal = rt.new_null()
	customer          rt.PhpVal = rt.new_null()
	cart_controller   rt.PhpVal = rt.new_null()
	schema_controller rt.PhpVal = rt.new_null()
	request_data      rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) construct(mut var_request_data Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_array) {
	this.cart_controller = create_automattic_woocommerce_storeapi_utilities_cartcontroller()
	mut iife_temp_0 := Class_Automattic_WooCommerce_StoreApi_StoreApi{}
	mut iife_result_0 := iife_temp_0.container()
	this.schema_controller = rt.call_method(iife_result_0, 'get', [
		Class_Automattic_WooCommerce_StoreApi_SchemaController.class(),
	])
	this.request_data = var_request_data
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) set_context(var_context rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_context.clone(), this.valid_contexts, rt.new_bool(true)])))))
	{
		return
	}
	this.context = var_context.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) set_customer(mut var_customer Class_WC_Customer) {
	this.customer = var_customer
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) set_cart(mut var_cart Class_WC_Cart) {
	this.cart = var_cart
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) get_cart_data() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_StoreApi_StoreApi{}
	mut iife_result_1 := iife_temp_1.container()
	mut var_cart_data := rt.call_method(rt.call_method(rt.call_method(iife_result_1, 'get', [
		Class_Automattic_WooCommerce_StoreApi_SchemaController.class(),
	]), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartSchema.identifier(),
	]), 'get_item_response', [this.cart])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_selected_rate := rt.call_function('array_search', [
			rt.new_bool(true),
			rt.call_function('array_column', [
				var_package.array_get(rt.new_string('shipping_rates')),
				rt.new_string('selected'),
			]),
			rt.new_bool(true)])
		return if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate))))
			&& var_package.array_get(rt.new_string('shipping_rates')).array_isset(var_selected_rate) {
			var_package.array_get(rt.new_string('shipping_rates')).array_get(var_selected_rate)
		} else {
			rt.new_null()
		}
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_selected_rate := rt.call_function('array_search', [
			rt.new_bool(true),
			rt.call_function('array_column', [
				var_package.array_get(rt.new_string('shipping_rates')),
				rt.new_string('selected'),
			]),
			rt.new_bool(true)])
		return if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate))))
			&& var_package.array_get(rt.new_string('shipping_rates')).array_isset(var_selected_rate) {
			var_package.array_get(rt.new_string('shipping_rates')).array_get(var_selected_rate)
		} else {
			rt.new_null()
		}
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_selected_rate := rt.call_function('array_search', [
			rt.new_bool(true),
			rt.call_function('array_column', [
				var_package.array_get(rt.new_string('shipping_rates')),
				rt.new_string('selected'),
			]),
			rt.new_bool(true)])
		return if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate))))
			&& var_package.array_get(rt.new_string('shipping_rates')).array_isset(var_selected_rate) {
			var_package.array_get(rt.new_string('shipping_rates')).array_get(var_selected_rate)
		} else {
			rt.new_null()
		}
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_selected_rate := rt.call_function('array_search', [
			rt.new_bool(true),
			rt.call_function('array_column', [
				var_package.array_get(rt.new_string('shipping_rates')),
				rt.new_string('selected'),
			]),
			rt.new_bool(true)])
		return if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_selected_rate))))
			&& var_package.array_get(rt.new_string('shipping_rates')).array_isset(var_selected_rate) {
			var_package.array_get(rt.new_string('shipping_rates')).array_get(var_selected_rate)
		} else {
			rt.new_null()
		}
	}
	mut var_selected_shipping_rates := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_closure(closure_3_fn),
			var_cart_data.array_get(rt.new_string('shipping_rates'))]),
	])
	mut iife_temp_6 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_6 := iife_temp_6.get_local_pickup_method_ids()
	mut var_local_pickup_method_ids := iife_result_6
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_8 := iife_temp_8.ceil(var_item.array_get(rt.new_string('quantity')))
		return rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(iife_result_8.to_i64()), var_item.array_get(rt.new_string('id'))])
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_10 := iife_temp_10.ceil(var_item.array_get(rt.new_string('quantity')))
		return rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(iife_result_10.to_i64()), var_item.array_get(rt.new_string('id'))])
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_12 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_12 := iife_temp_12.ceil(var_item.array_get(rt.new_string('quantity')))
		return rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(iife_result_12.to_i64()), var_item.array_get(rt.new_string('id'))])
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_14 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_14 := iife_temp_14.ceil(var_item.array_get(rt.new_string('quantity')))
		return rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(iife_result_14.to_i64()), var_item.array_get(rt.new_string('id'))])
	}
	return rt.call_function('wp_parse_args', [if !(this.request_data.array_get(rt.new_string('cart'))).is_null() {
		this.request_data.array_get(rt.new_string('cart'))
	} else {
		rt.new_array()
	},
		rt.create_array([
			rt.ArrayItem{ key: 'coupons', val: rt.call_function('array_values', [
				rt.call_function('wc_list_pluck', [
					var_cart_data.array_get(rt.new_string('coupons')),
					rt.new_string('code'),
				]),
			]) },
			rt.ArrayItem{ key: 'shipping_rates', val: rt.call_function('array_values', [
				rt.call_function('wc_list_pluck', [
					var_selected_shipping_rates.clone(),
					rt.new_string('rate_id'),
				]),
			]) },
			rt.ArrayItem{ key: 'items', val: rt.call_function('array_merge', [
				rt.call_function('array_map', [
					rt.new_closure(closure_9_fn),
					var_cart_data.array_get(rt.new_string('items')),
				]),
			]) },
			rt.ArrayItem{ key: 'items_type', val: rt.call_function('array_unique', [
				rt.call_function('array_values', [
					rt.call_function('wc_list_pluck', [
						var_cart_data.array_get(rt.new_string('items')),
						rt.new_string('type'),
					]),
				]),
			]) },
			rt.ArrayItem{
				key: 'items_count'
				val: var_cart_data.array_get(rt.new_string('items_count'))
			},
			rt.ArrayItem{
				key: 'items_weight'
				val: var_cart_data.array_get(rt.new_string('items_weight'))
			},
			rt.ArrayItem{
				key: 'needs_shipping'
				val: var_cart_data.array_get(rt.new_string('needs_shipping'))
			},
			rt.ArrayItem{ key: 'prefers_collection', val: rt.new_bool(rt.call_function('array_intersect', [
				var_local_pickup_method_ids.clone(),
				rt.call_function('wc_list_pluck', [
					var_selected_shipping_rates.clone(),
					rt.new_string('method_id'),
				]),
			]).array_count() > 0) },
			rt.ArrayItem{ key: 'totals', val: rt.create_array([
				rt.ArrayItem{ key: 'total_price', val: rt.new_int((rt.get_property(var_cart_data.array_get(rt.new_string('totals')),
					'total_price')).to_i64()) },
				rt.ArrayItem{ key: 'total_tax', val: rt.new_int((rt.get_property(var_cart_data.array_get(rt.new_string('totals')),
					'total_tax')).to_i64()) },
			]) },
			rt.ArrayItem{
				key: 'extensions'
				val: rt.array_to_object(var_cart_data.array_get(rt.new_string('extensions')))
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) get_checkout_data() rt.PhpVal {
	return if !(this.request_data.array_get(rt.new_string('checkout'))).is_null() {
		this.request_data.array_get(rt.new_string('checkout'))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) get_customer_data() rt.PhpVal {
	mut var_customer_data := rt.create_array([
		rt.ArrayItem{
			key: 'id'
			val: if !(this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('id'))).is_null() {
				this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('id'))
			} else {
				rt.call_method(this.customer, 'get_id', []rt.PhpVal{})
			}
		},
		rt.ArrayItem{ key: 'shipping_address', val: rt.call_function('wp_parse_args', [
			if !(this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('shipping_address'))).is_null() {
				this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('shipping_address'))
			} else {
				rt.array_to_object(rt.new_array())
			},
			rt.call_method(rt.call_method(this.schema_controller, 'get', [
				Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ShippingAddressSchema.identifier(),
			]), 'get_item_response', [
				this.customer,
			]),
		]) },
		rt.ArrayItem{ key: 'billing_address', val: rt.call_function('wp_parse_args', [
			if !(this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('billing_address'))).is_null() {
				this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('billing_address'))
			} else {
				rt.array_to_object(rt.new_array())
			},
			rt.call_method(rt.call_method(this.schema_controller, 'get', [
				Class_Automattic_WooCommerce_StoreApi_Schemas_V1_BillingAddressSchema.identifier(),
			]), 'get_item_response', [
				this.customer,
			]),
		]) },
		rt.ArrayItem{
			key: 'additional_fields'
			val: if !(this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('additional_fields'))).is_null() {
				this.request_data.array_get(rt.new_string('customer')).array_get(rt.new_string('additional_fields'))
			} else {
				rt.array_to_object(rt.new_array())
			}
		},
	])
	if rt.is_true(rt.identical(rt.new_string('shipping_address'), this.context)) {
		var_customer_data.array_set('address',
			var_customer_data.array_get(rt.new_string('shipping_address')))
	}
	if rt.is_true(rt.identical(rt.new_string('billing_address'), this.context)) {
		var_customer_data.array_set('address',
			var_customer_data.array_get(rt.new_string('billing_address')))
	}
	return var_customer_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) get_data() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.cart.is_null())) {
		this.cart = rt.call_method(this.cart_controller, 'get_cart_for_response', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(this.customer.is_null())) {
		this.customer = if !(!rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'customer'))) {
			rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
		} else {
			create_wc_customer()
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'cart', val: this.get_cart_data() },
		rt.ArrayItem{ key: 'customer', val: this.get_customer_data() },
		rt.ArrayItem{ key: 'checkout', val: this.get_checkout_data() }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) get_context() rt.PhpVal {
	return this.context
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_StoreApi {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_documentobject(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject{
		PhpObjectBase:     rt.PhpObjectBase{}
		context:           rt.new_null()
		valid_contexts:    rt.new_array()
		cart:              rt.new_null()
		customer:          rt.new_null()
		cart_controller:   rt.new_null()
		schema_controller: rt.new_null()
		request_data:      rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_storeapi(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_StoreApi {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_StoreApi{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_context(dispatch_arg_0)
			return rt.new_null()
		}
		'set_customer' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Customer](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_customer(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Cart](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_cart(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_cart_data' {
			return this.get_cart_data()
		}
		'get_checkout_data' {
			return this.get_checkout_data()
		}
		'get_customer_data' {
			return this.get_customer_data()
		}
		'get_data' {
			return this.get_data()
		}
		'get_context' {
			return this.get_context()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'context' { return this.context }
		'valid_contexts' { return this.valid_contexts }
		'cart' { return this.cart }
		'customer' { return this.customer }
		'cart_controller' { return this.cart_controller }
		'schema_controller' { return this.schema_controller }
		'request_data' { return this.request_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_DocumentObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'context' {
			this.context = val
			return true
		}
		'valid_contexts' {
			this.valid_contexts = val
			return true
		}
		'cart' {
			this.cart = val
			return true
		}
		'customer' {
			this.customer = val
			return true
		}
		'cart_controller' {
			this.cart_controller = val
			return true
		}
		'schema_controller' {
			this.schema_controller = val
			return true
		}
		'request_data' {
			this.request_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
