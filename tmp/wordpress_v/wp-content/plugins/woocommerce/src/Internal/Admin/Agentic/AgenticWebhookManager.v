import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.webhook_action() string {
	return 'woocommerce_agentic_order_changed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.webhook_topic() string {
	return 'action.' + (Class_Automattic_WooCommerce_Internal_Admin_Agentic_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.webhook_action()).str()
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.first_event_delivered_meta_key() string {
	return '_acp_order_created_sent'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager {
	rt.PhpObjectBase
pub mut:
		payload_builder rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) init(mut var_payload_builder Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder)  {
	this.payload_builder = var_payload_builder.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) register()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_webhook_topics'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'register_webhook_topic_names' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_order_created' }]), rt.new_int(999), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_changed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_order_status_changed' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_refunded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_order_refunded' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_webhook_payload'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'customize_webhook_payload' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_webhook_http_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'customize_webhook_http_args' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_webhook_delivery'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'mark_first_event_delivered' }]), rt.new_int(10), rt.new_int(5)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) register_webhook_topic_names(var_topics rt.PhpVal) rt.PhpVal {
	mut var_topics_mutated := var_topics
	var_topics_mutated.array_set(Class_Automattic_WooCommerce_Internal_Admin_Agentic_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.webhook_topic(), rt.call_function('__', [rt.new_string('Agentic Commerce Protocol: Order created or updated'), rt.new_string('woocommerce')]))
	return var_topics_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) handle_order_created(var_order_id rt.PhpVal, var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	if !(this.should_trigger_webhook(var_order_mutated.dup())) {
		return rt.new_null()
	}
	rt.call_function('do_action', [Class_Automattic_WooCommerce_Internal_Admin_Agentic_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.webhook_action(), var_order_id.dup(), var_order_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) handle_order_status_changed(var_order_id rt.PhpVal, var_old_status rt.PhpVal, var_new_status rt.PhpVal, var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	if !(this.should_trigger_webhook(var_order_mutated.dup())) {
		return rt.new_null()
	}
	rt.call_function('do_action', [Class_Automattic_WooCommerce_Internal_Admin_Agentic_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.webhook_action(), var_order_id.dup(), var_order_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) handle_order_refunded(var_order_id rt.PhpVal)  {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || !(this.should_trigger_webhook(var_order.dup())))) {
		return rt.new_null()
	}
	rt.call_function('do_action', [Class_Automattic_WooCommerce_Internal_Admin_Agentic_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.webhook_action(), var_order_id.dup(), var_order.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) should_trigger_webhook(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_checkout_session_id := rt.call_method(var_order_mutated, 'get_meta', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey.agentic_checkout_session_id()])
	if !rt.is_true(var_checkout_session_id) {
		return false
	}
	if rt.is_true(rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.checkout_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }]), rt.new_bool(true)])) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) customize_webhook_payload(var_payload rt.PhpVal, var_resource_type rt.PhpVal, var_resource_id rt.PhpVal, var_webhook_id rt.PhpVal) rt.PhpVal {
	mut var_webhook := rt.call_function('wc_get_webhook', [var_webhook_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_webhook)))) {
		return var_payload.dup()
	}
	mut var_topic := rt.call_method(var_webhook, 'get_topic', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_payload.dup()
	}
	mut var_order := rt.call_function('wc_get_order', [var_resource_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return var_payload.dup()
	}
	mut var_is_first_event := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_event := rt.new_string(if rt.is_true(var_is_first_event) { rt.new_string('order_create') } else { rt.new_string('order_update') })
	return rt.call_method(this.payload_builder, 'build_payload', [var_event.dup(), var_order.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) customize_webhook_http_args(var_http_args rt.PhpVal, var_arg rt.PhpVal, var_webhook_id rt.PhpVal) rt.PhpVal {
	mut var_webhook := rt.call_function('wc_get_webhook', [var_webhook_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_webhook)))) {
		return var_http_args.dup()
	}
	mut var_topic := rt.call_method(var_webhook, 'get_topic', []rt.PhpVal{})
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_http_args.dup()
	}
	if var_http_args.array_isset(rt.new_string('body')) && !(!rt.is_true(rt.call_method(var_webhook, 'get_secret', []rt.PhpVal{}))) {
		mut var_signature := rt.call_method(var_webhook, 'generate_signature', [var_http_args.array_get('body')])
		var_http_args.array_get_mut('headers').array_set('Merchant-Signature', var_signature.dup())
	}
	return var_http_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) mark_first_event_delivered(var_http_args rt.PhpVal, var_response rt.PhpVal, var_duration rt.PhpVal, var_arg rt.PhpVal, var_webhook_id rt.PhpVal)  {
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		return rt.new_null()
	}
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_code, rt.new_int(200))) || rt.is_true(rt.greater_equal(var_code, rt.new_int(300))))) {
		return rt.new_null()
	}
	mut var_webhook := rt.call_function('wc_get_webhook', [var_webhook_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_webhook)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_order := rt.call_function('wc_get_order', [var_arg.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_order, 'update_meta_data', [Class_Automattic_WooCommerce_Internal_Admin_Agentic_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager.first_event_delivered_meta_key(), rt.new_string('sent')])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
	}
}

fn create_automattic_woocommerce_internal_admin_agentic_agenticwebhookmanager() &Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager{
		PhpObjectBase: rt.PhpObjectBase{}
		payload_builder: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookPayloadBuilder](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'register_webhook_topic_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_webhook_topic_names(dispatch_arg_0)
		}
		'handle_order_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_order_created(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_order_status_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.handle_order_status_changed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'handle_order_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_order_refunded(dispatch_arg_0)
			return rt.new_null()
		}
		'should_trigger_webhook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.should_trigger_webhook(dispatch_arg_0))
		}
		'customize_webhook_payload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.customize_webhook_payload(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'customize_webhook_http_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.customize_webhook_http_args(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'mark_first_event_delivered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.mark_first_event_delivered(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payload_builder' { return this.payload_builder }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Agentic_AgenticWebhookManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payload_builder' { this.payload_builder = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_agentic_agenticwebhookmanager_php() {
	// unsupported statement: Stmt_Declare
}
