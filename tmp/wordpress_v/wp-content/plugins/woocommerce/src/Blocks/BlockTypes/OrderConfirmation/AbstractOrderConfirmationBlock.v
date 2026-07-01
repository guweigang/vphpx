import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) get_hook_content(var_hook rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action_ref_array', [var_hook.dup(), var_args.dup()])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_order := this.get_order()
	mut var_permission := this.get_view_order_permissions(var_order.dup())
	mut var_block_content := if rt.is_true(var_order) { this.render_content(var_order.dup(), (var_permission).to_bool(), var_attributes.dup(), (var_content).str()) } else { this.render_content_fallback() }
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_and_styles_by_attributes(arg_0) }(var_attributes.dup())
	return if rt.is_true(var_block_content) { rt.call_function('sprintf', [rt.new_string('<div class="wp-block-%5$s-%4$s wc-block-%4$s %1$s" style="%2$s">%3$s</div>'), rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')]), rt.call_function('esc_attr', [var_classes_and_styles.array_get('styles')]), var_block_content.dup(), rt.call_function('esc_attr', [rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'block_name')]), rt.call_function('esc_attr', [rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'namespace')])]) } else { rt.new_string('') }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string)  {
	mut var_order_mutated := var_order
	mut permission_mutated := permission
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) render_content_fallback() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) get_order() rt.PhpVal {
	mut var_order_id := rt.call_function('absint', [rt.call_function('get_query_var', [rt.new_string('order-received')])])
	if rt.is_true(var_order_id) {
		return rt.call_function('wc_get_order', [var_order_id.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) get_view_order_permissions(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) || !(this.has_valid_order_key(var_order_mutated.dup())))) {
		return rt.new_bool(false)
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(this.is_customer_order(var_order_mutated.dup())) {
		mut var_verify_known_shoppers := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_received_verify_known_shoppers'), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_verify_known_shoppers)))) {
			return rt.new_string('full')
		}
		return if this.is_current_customer_order(var_order_mutated.dup()) { rt.new_string('full') } else { rt.new_bool(false) }
	}
	return if this.email_verification_required(var_order_mutated.dup()) { rt.new_bool(false) } else { rt.new_string('full') }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) allow_guest_checkout() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_guest_checkout')]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) email_verification_permitted(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	return rt.is_true(rt.new_bool(rt.is_true(this.allow_guest_checkout()) && this.has_valid_order_key(var_order_mutated.dup()))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_customer_order(var_order_mutated.dup())))))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) is_within_grace_period(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_verification_grace_period := // unsupported expression: Expr_Cast_Int
	mut var_date_created := rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{})
	return rt.is_true(rt.call_function('is_a', [var_date_created.dup(), Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WC_DateTime.class()])) && rt.is_true(rt.less_equal(rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_method(var_date_created, 'getTimestamp', []rt.PhpVal{})), var_verification_grace_period))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) is_email_verified(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	if !rt.is_true(rt.get_superglobal('_POST')) || !(rt.get_superglobal('_POST').array_isset(rt.new_string('email')) && rt.get_superglobal('_POST').array_isset(rt.new_string('_wpnonce'))) {
		return false
	}
	mut var_nonce_value := rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('_wpnonce')).is_null() { rt.get_superglobal('_POST').array_get('_wpnonce') } else { rt.new_string('') }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.dup(), rt.new_string('wc_verify_email')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.dup(), rt.new_string('wc_create_account')]))))))) {
		return false
	}
	return rt.is_true(rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.call_function('sanitize_email', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('email')).is_null() { rt.get_superglobal('_POST').array_get('email') } else { rt.new_string('') }])]), rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) email_verification_required(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_session := rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session')
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_a', [var_session.dup(), Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_WC_Session.class()])) && rt.is_true(rt.identical(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), // unsupported expression: Expr_Cast_Int)))) {
		return false
	}
	if this.is_within_grace_period(var_order_mutated.dup()) {
		return false
	}
	if this.is_email_verified(var_order_mutated.dup()) {
		return false
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) has_valid_order_key(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	return !(!rt.is_true(rt.get_superglobal('_GET').array_get('key'))) && rt.is_true(rt.call_method(var_order_mutated, 'key_is_valid', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('key')])])]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) is_customer_order(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return rt.less(rt.new_int(0), rt.call_method(var_order_mutated, 'get_user_id', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) is_current_customer_order(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	return rt.is_true(this.is_customer_order(var_order_mutated.dup())) && rt.is_true(rt.identical(rt.call_method(var_order_mutated, 'get_user_id', []rt.PhpVal{}), rt.call_function('get_current_user_id', []rt.PhpVal{})))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) render_additional_fields(var_fields rt.PhpVal) string {
	if !rt.is_true(var_fields) {
		return ''
	}
	return '<dl class="wc-block-components-additional-fields-list">' + (rt.call_function('implode', [rt.new_string(''), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'render_additional_field' }]), var_fields.dup()])])).str() + '</dl>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) render_additional_field(var_field rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<dt>%1$s</dt><dd>%2$s</dd>'), rt.call_function('esc_html', [var_field.array_get('label')]), rt.call_function('esc_html', [var_field.array_get('value')])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_hook_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_hook_content(dispatch_arg_0, dispatch_arg_1)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.render_content(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'render_content_fallback' {
			return rt.new_string(this.render_content_fallback())
		}
		'get_order' {
			return this.get_order()
		}
		'get_view_order_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_view_order_permissions(dispatch_arg_0)
		}
		'allow_guest_checkout' {
			return this.allow_guest_checkout()
		}
		'email_verification_permitted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.email_verification_permitted(dispatch_arg_0))
		}
		'is_within_grace_period' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_within_grace_period(dispatch_arg_0))
		}
		'is_email_verified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_email_verified(dispatch_arg_0))
		}
		'email_verification_required' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.email_verification_required(dispatch_arg_0))
		}
		'has_valid_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_valid_order_key(dispatch_arg_0))
		}
		'is_customer_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_customer_order(dispatch_arg_0)
		}
		'is_current_customer_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_current_customer_order(dispatch_arg_0))
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'render_additional_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_additional_fields(dispatch_arg_0))
		}
		'render_additional_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_additional_field(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock_php() {
}
