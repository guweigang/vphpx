import rt

struct Class_WC_REST_Order_Refunds_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Order_Refunds_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_RestApiParameterUtil{}; return temp.adjust_create_refund_request_parameters(arg_0) }(var_request.dup())
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_order_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	if rt.is_true(rt.greater(rt.new_int(0), var_request.array_get('amount'))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_order_refund'), rt.call_function('__', [rt.new_string('Refund amount must be greater than zero.'), rt.new_string('woocommerce')]), rt.new_int(400))
	}
	mut var_refund := rt.call_function('wc_create_refund', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'amount', val: var_request.array_get('amount') }, rt.ArrayItem{ key: 'reason', val: var_request.array_get('reason') }, rt.ArrayItem{ key: 'line_items', val: var_request.array_get('line_items') }, rt.ArrayItem{ key: 'refund_payment', val: var_request.array_get('api_refund') }, rt.ArrayItem{ key: 'restock_items', val: var_request.array_get('api_restock') }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_refund.dup()])) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_create_order_refund'), rt.call_method(var_refund, 'get_error_message', []rt.PhpVal{}), rt.new_int(500))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_refund)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_create_order_refund'), rt.call_function('__', [rt.new_string('Cannot create order refund, please try again.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	if !(!rt.is_true(var_request.array_get('meta_data'))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1) }(var_request.array_get('meta_data'), var_refund.dup())
		rt.call_method(var_refund, 'save_meta_data', []rt.PhpVal{})
	}
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), rt.get_property(rt.new_object('WC_REST_Order_Refunds_Controller', ['WC_REST_Order_Refunds_V2_Controller'], &this), 'post_type')), rt.new_string('_object')), var_refund.dup(), var_request.dup(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Order_Refunds_Controller) get_formatted_item_data(var_data_object rt.PhpVal) rt.PhpVal {
	mut var_data := this.Class_WC_REST_Order_Refunds_V2_Controller.get_formatted_item_data(var_data_object.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))) {
		return var_data.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_data_object, 'WC_Abstract_Order'))) && rt.is_true(rt.call_method(var_data_object, 'has_cogs', []rt.PhpVal{})))) {
		var_data.array_set('cost_of_goods_sold', rt.create_array([rt.ArrayItem{ key: 'value', val: rt.call_method(var_data_object, 'get_cogs_total_value', []rt.PhpVal{}) }]))
		{
			mut iter_1 := var_data.array_get('line_items').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_line_item := item_1.val
				mut var_key := item_1.key
				mut var_cogs_value := if !(var_line_item.array_get('cogs_value')).is_null() { var_line_item.array_get('cogs_value') } else { rt.new_null() }
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cogs_value.dup().is_null()))))) {
					var_data.array_get_mut('line_items').array_get_mut(var_key).array_set('cost_of_goods_sold', rt.create_array([rt.ArrayItem{ key: 'value', val: var_cogs_value }]))
					var_data.array_get('line_items').array_get(var_key).array_unset(rt.new_string('cogs_value'))
				}
			}
		}
	}
	return var_data.dup()
}

fn (mut this Class_WC_REST_Order_Refunds_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WC_REST_Order_Refunds_V2_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_get_mut('line_items').array_get_mut('items').array_get_mut('properties').array_set('refund_total', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount that will be refunded for this line item (excluding taxes).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
	var_schema.array_get_mut('properties').array_get_mut('line_items').array_get_mut('items').array_get_mut('properties').array_get_mut('taxes').array_get_mut('items').array_get_mut('properties').array_set('refund_total', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount that will be refunded for this tax.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
	var_schema.array_get_mut('properties').array_set('api_restock', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('When true, refunded items are restocked.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'default', val: true }]))
	if rt.is_true(this.cogs_is_enabled()) {
		var_schema = this.add_cogs_related_schema(mut rt.cast_object_ptr[Class_array](var_schema))
	}
	return var_schema.dup()
}

fn (mut this Class_WC_REST_Order_Refunds_Controller) add_cogs_related_schema(mut var_schema Class_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	var_schema_mutated.array_get_mut('properties').array_set('cost_of_goods_sold', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Cost of Goods Sold data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'total_value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total value of the Cost of Goods Sold for the refund.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]))
	var_schema_mutated.array_get_mut('properties').array_get_mut('line_items').array_get_mut('items').array_get_mut('properties').array_set('cost_of_goods_sold', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Cost of Goods Sold data. Only present for product refund line items.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'total_value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Value of the Cost of Goods Sold for the refund item.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]))
	return rt.new_object('array', []string{}, var_schema_mutated)
}

struct Class_WC_REST_Order_Refunds_V2_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApiParameterUtil {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_order_refunds_controller() &Class_WC_REST_Order_Refunds_Controller {
	mut obj := &Class_WC_REST_Order_Refunds_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_order_refunds_v2_controller() &Class_WC_REST_Order_Refunds_V2_Controller {
	mut obj := &Class_WC_REST_Order_Refunds_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapiparameterutil() &Class_Automattic_WooCommerce_Internal_RestApiParameterUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiParameterUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_metadatautil() &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Order_Refunds_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'get_formatted_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_item_data(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'add_cogs_related_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_cogs_related_schema(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Order_Refunds_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Order_Refunds_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Order_Refunds_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Order_Refunds_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApiParameterUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApiParameterUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiParameterUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_order_refunds_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
