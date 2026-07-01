import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder {
	rt.PhpObjectBase
pub mut:
		money_formatter rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) init()  {
	this.money_formatter = create_automattic_woocommerce_storeapi_formatters_moneyformatter()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) build_payload(event string, mut var_order Class_WC_Order) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: event }, rt.ArrayItem{ key: 'data', val: this.build_order_data(mut var_order) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) build_order_data(mut var_order Class_WC_Order) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'order' }, rt.ArrayItem{ key: 'checkout_session_id', val: var_order.get_meta(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey.agentic_checkout_session_id()) }, rt.ArrayItem{ key: 'permalink_url', val: var_order.get_checkout_order_received_url() }, rt.ArrayItem{ key: 'status', val: this.map_order_status((var_order.get_status()).str()) }, rt.ArrayItem{ key: 'refunds', val: this.build_refunds_data(mut var_order) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) map_order_status(wc_status string) string {
	mut var_status_map := rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.pending(), val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.created() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.processing(), val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.confirmed() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(), val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.manual_review() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.completed(), val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.fulfilled() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled(), val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.canceled() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded(), val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.fulfilled() }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderStatus.failed(), val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.canceled() }])
	var_status_map = rt.call_function('apply_filters', [rt.new_string('woocommerce_agentic_webhook_order_status_map'), var_status_map.dup(), rt.new_string(wc_status)])
	mut var_mapped_status := if var_status_map.array_isset(rt.new_string(wc_status)) { var_status_map.array_get(wc_status) } else { Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.created() }
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus{}; return temp.is_valid(arg_0) }(var_mapped_status.dup()))))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.new_string('Invalid ACP order status "%s" returned by woocommerce_agentic_webhook_order_status_map filter for WooCommerce status "%s". Using "created" as fallback.'), var_mapped_status.dup(), rt.new_string(wc_status)]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'agentic-webhooks' }])])
		return (Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.created()).str()
	}
	return (var_mapped_status).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) build_refunds_data(mut var_order Class_WC_Order) rt.PhpVal {
	return rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'build_single_refund_data' }]), var_order.get_refunds()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) build_single_refund_data(mut var_refund Class_WC_Order_Refund) rt.PhpVal {
	mut var_refund_type := rt.new_string(this.determine_refund_type(mut var_refund))
	mut var_amount := rt.call_function('abs', [// unsupported expression: Expr_Cast_Double])
	mut var_amount_in_minor_units := // unsupported expression: Expr_Cast_Int
	return rt.create_array([rt.ArrayItem{ key: 'type', val: var_refund_type }, rt.ArrayItem{ key: 'amount', val: var_amount_in_minor_units }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) determine_refund_type(mut var_refund Class_WC_Order_Refund) string {
	mut var_refund_type := Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_RefundType.original_payment()
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_agentic_webhook_refund_type'), var_refund_type.dup(), var_refund])).str()
}

struct Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_agentic_agenticwebhookpayloadbuilder() &Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
		money_formatter: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_formatters_moneyformatter() &Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_orderstatus() &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'build_payload' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.build_payload(dispatch_arg_0, mut dispatch_arg_1)
		}
		'build_order_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_order_data(mut dispatch_arg_0)
		}
		'map_order_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.map_order_status(dispatch_arg_0))
		}
		'build_refunds_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_refunds_data(mut dispatch_arg_0)
		}
		'build_single_refund_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Refund](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_single_refund_data(mut dispatch_arg_0)
		}
		'determine_refund_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Refund](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.determine_refund_type(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'money_formatter' { return this.money_formatter }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'money_formatter' { this.money_formatter = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_agentic_agenticwebhookpayloadbuilder_php() {
	// unsupported statement: Stmt_Declare
}
