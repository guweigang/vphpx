import rt

struct Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController {
	rt.PhpObjectBase
pub mut:
	features_controller          rt.PhpVal = rt.new_null()
	extend_schema                rt.PhpVal = rt.new_null()
	order_attribution_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) init(mut var_extend_schema Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_features_controller Class_Automattic_WooCommerce_Internal_Features_FeaturesController, mut var_order_attribution_controller Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) {
	this.extend_schema = var_extend_schema
	this.features_controller = var_features_controller
	this.order_attribution_controller = var_order_attribution_controller
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) register() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'on_init' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) on_init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.features_controller,
		'feature_is_enabled', [rt.new_string('order_attribution')])))))
	{
		return
	}
	this.extend_api()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) extend_api() {
	rt.call_method(this.extend_schema, 'register_endpoint_data', [
		rt.create_array([
			rt.ArrayItem{
				key: 'endpoint'
				val: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CheckoutSchema.identifier()
			},
			rt.ArrayItem{ key: 'namespace', val: 'woocommerce/order-attribution' },
			rt.ArrayItem{ key: 'schema_callback', val: this.get_schema_callback() },
		]),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_extensions := rt.call_method(var_request, 'get_param', [
			rt.new_string('extensions'),
		])
		mut var_params := if !(var_extensions.array_get(rt.new_string('woocommerce/order-attribution'))).is_null() {
			var_extensions.array_get(rt.new_string('woocommerce/order-attribution'))
		} else {
			rt.new_array()
		}
		if !rt.is_true(var_params) {
			return
		}
		if rt.is_true(rt.call_method(this.order_attribution_controller, 'has_attribution', [
			var_order.clone(),
		]))
		{
			return
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_order_save_attribution_data'),
			var_order.clone(),
			var_params.clone(),
		])
		return rt.new_null()
	}
	rt.call_function('add_action', [
		rt.new_string('woocommerce_store_api_checkout_update_order_from_request'),
		rt.new_closure(closure_1_fn),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) get_schema_callback() rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_schema := rt.new_array()
		mut var_field_names := rt.call_method(this.order_attribution_controller, 'get_field_names',
			[]rt.PhpVal{})
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if !(var_value.clone().is_string())
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value)))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('api-error'), rt.call_function('sprintf', [
					rt.call_function('esc_html__', [
						rt.new_string('Value of type %s was posted to the order attribution callback'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('gettype', [
						var_value.clone(),
					]),
				])))
			}
			return rt.new_bool(true)
		}
		mut var_validate_callback := rt.new_closure(closure_3_fn)
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_function('sanitize_text_field', [var_value.clone()])
		}
		mut var_sanitize_callback := rt.new_closure(closure_4_fn)
		mut iter_1 := var_field_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_name := item_1.val
			var_schema.array_set(var_field_name, rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Order attribution field: %s'),
						rt.new_string('woocommerce')]),
					rt.call_function('esc_html', [var_field_name.clone()]),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.new_array() },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'validate_callback', val: var_validate_callback },
					rt.ArrayItem{ key: 'sanitize_callback', val: var_sanitize_callback },
				]) },
			]))
		}
		return var_schema.clone()
	}
	return rt.new_closure(closure_4_fn)
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_orderattributionblockscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController{
		PhpObjectBase:                rt.PhpObjectBase{}
		features_controller:          rt.new_null()
		extend_schema:                rt.new_null()
		order_attribution_controller: rt.new_null()
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_FeaturesController](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'on_init' {
			this.on_init()
			return rt.new_null()
		}
		'extend_api' {
			this.extend_api()
			return rt.new_null()
		}
		'get_schema_callback' {
			return this.get_schema_callback()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'features_controller' { return this.features_controller }
		'extend_schema' { return this.extend_schema }
		'order_attribution_controller' { return this.order_attribution_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionBlocksController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'features_controller' {
			this.features_controller = val
			return true
		}
		'extend_schema' {
			this.extend_schema = val
			return true
		}
		'order_attribution_controller' {
			this.order_attribution_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
