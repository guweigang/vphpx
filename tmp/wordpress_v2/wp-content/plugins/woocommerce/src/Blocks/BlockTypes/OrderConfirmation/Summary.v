import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('order-confirmation-summary')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	mut content_mutated := content
	if !var_permission {
		return ''
	}
	content_mutated = '<ul class="wc-block-order-confirmation-summary-list">'
	content_mutated = content_mutated +
		this.render_summary_row(rt.call_function('__', [rt.new_string('Order #:'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}))
	content_mutated = content_mutated +
		this.render_summary_row(rt.call_function('__', [rt.new_string('Date:'), rt.new_string('woocommerce')]), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})]))
	content_mutated = content_mutated +
		this.render_summary_row(rt.call_function('__', [rt.new_string('Total:'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_formatted_order_total', []rt.PhpVal{}))
	content_mutated = content_mutated +
		this.render_summary_row(rt.call_function('__', [rt.new_string('Email:'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}))
	content_mutated = content_mutated +
		this.render_summary_row(rt.call_function('__', [rt.new_string('Payment:'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{}))
	content_mutated = content_mutated + '</ul>'
	return content_mutated
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary) render_summary_row(var_name rt.PhpVal, var_value rt.PhpVal) string {
	return if rt.is_true(var_value) {
			'<li class="wc-block-order-confirmation-summary-list-item"><span class="wc-block-order-confirmation-summary-list-item__key">' +
			(rt.call_function('esc_html', [var_name.clone()])).str() +
			'</span> <span class="wc-block-order-confirmation-summary-list-item__value">' +
			(rt.call_function('wp_kses_post', [var_value.clone()])).str() + '</span></li>'
	} else {
		''
	}
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_summary(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('order-confirmation-summary')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.render_content(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'render_summary_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.render_summary_row(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Summary) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
