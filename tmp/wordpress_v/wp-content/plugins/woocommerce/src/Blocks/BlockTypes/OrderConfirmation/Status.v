import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('order-confirmation-status')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content_mutated := var_content
	mut var_block_mutated := var_block
	mut var_order := this.get_order()
	mut var_classname := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_by_attributes(arg_0, arg_1)
	}(var_attributes.dup(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'extra_classes' },
	]))
	if var_attributes.array_isset(rt.new_string('align')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_block_mutated = this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.render(var_attributes.dup(),
		var_content_mutated.dup(), var_block_mutated.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_mutated)))) {
		return ''
	}
	mut var_additional_content := rt.new_string(this.render_confirmation_notice(var_order.dup()))
	if rt.is_true(var_additional_content) {
		var_block_mutated = rt.new_string(rt.concat(var_block_mutated, rt.call_function('sprintf', [
			rt.new_string('<div class="wc-block-order-confirmation-status-description %1$s">%2$s</div>'),
			rt.call_function('esc_attr', [
				rt.new_string(var_classname.dup().to_string().trim_space()),
			]),
			var_additional_content.dup(),
		])))
	}
	return var_block_mutated.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	mut var_order_mutated := var_order
	mut permission_mutated := permission
	mut content_mutated := content
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(permission_mutated))))) {
		return '<p>' +
			(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_thankyou_order_received_text'), rt.call_function('esc_html__', [rt.new_string('Thank you. Your order has been received.'), rt.new_string('woocommerce')]), rt.new_null()])])).str() +
			'</p>'
	}
	content_mutated = (this.get_hook_content(rt.new_string('woocommerce_before_thankyou'), rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) },
	]))).str()
	mut var_status := rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})
	mut switch_val_1 := var_status
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('cancelled'))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('refunded'))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('completed'))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('failed'))) {
		mut var_order_received_text := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_thankyou_order_received_text'),
			rt.call_function('esc_html__', [
				rt.new_string('Your order cannot be processed as the originating bank/merchant has declined your transaction. Please attempt your purchase again.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_null(),
		])
		mut var_actions := rt.new_string('<a href="' +
			(rt.call_function('esc_url', [rt.call_method(var_order_mutated, 'get_checkout_payment_url', []rt.PhpVal{})])).str() +
			'" class="button">' +
			(rt.call_function('esc_html__', [rt.new_string('Try again'), rt.new_string('woocommerce')])).str() +
			'</a> ')
		if rt.is_true(rt.call_function('wc_get_page_permalink', [
			rt.new_string('myaccount'),
		]))
		{
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	return content_mutated
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) render_content_fallback() string {
	return '<p>' +
		(rt.call_function('esc_html__', [rt.new_string('Please check your email for the order confirmation.'), rt.new_string('woocommerce')])).str() +
		'</p>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) render_confirmation_notice(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) {
		mut var_content :=
			rt.new_string('<p>' +(rt.call_function('esc_html__', [rt.new_string("If you've just placed an order, give your email a quick check for the confirmation."), rt.new_string('woocommerce')])).str())
		if rt.is_true(rt.call_function('wc_get_page_permalink', [
			rt.new_string('myaccount'),
		]))
		{
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		return var_content.str()
	}
	mut var_permission := this.get_view_order_permissions(var_order_mutated.dup())
	if rt.is_true(var_permission) {
		return ''
	}
	mut var_verification_required := this.email_verification_required(var_order_mutated.dup())
	mut var_verification_permitted := this.email_verification_permitted(var_order_mutated.dup())
	mut var_my_account_page := rt.call_function('wc_get_page_permalink', [
		rt.new_string('myaccount'),
	])
	var_content = rt.new_string(rt.new_string('<p>'))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(var_verification_required)
		&& rt.is_true(var_verification_permitted)))
	{
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(var_verification_required)
		&& rt.is_true(var_verification_permitted)))
	{
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_content.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) render_verification_form() string {
	mut var_check_submission_notice := if !(!rt.is_true(rt.get_superglobal('_POST'))) { rt.call_function('wc_print_notice', [
			rt.call_function('esc_html__', [
				rt.new_string('We were unable to verify the email address you provided. Please try again.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('error'),
			rt.new_array(),
			rt.new_bool(true),
		]) } else { rt.new_string('') }
	return '<form method="post" class="woocommerce-form woocommerce-verify-email">' +
		var_check_submission_notice.str() +
		(rt.call_function('sprintf', [rt.new_string('<p class="form-row verify-email">\n\t\t\t\t\t<label for="%1$s">%2$s</label>\n\t\t\t\t\t<input type="email" name="email" id="%1$s" autocomplete="email" class="input-text" required />\n\t\t\t\t</p>'), rt.call_function('esc_attr', [rt.new_string('verify-email')]), (rt.call_function('esc_html__', [rt.new_string('Email address'), rt.new_string('woocommerce')])).str() +
		'&nbsp;<span class="required">*</span>'])).str() +
		(rt.call_function('sprintf', [rt.new_string('<p class="form-row login-submit">\n\t\t\t\t\t<input type="submit" name="wp-submit" id="%1$s" class="button button-primary %4$s" value="%2$s" />\n\t\t\t\t\t%3$s\n\t\t\t\t</p>'), rt.call_function('esc_attr', [rt.new_string('verify-email-submit')]), rt.call_function('esc_html__', [rt.new_string('Confirm email and view order'), rt.new_string('woocommerce')]), rt.call_function('wp_nonce_field', [rt.new_string('wc_verify_email'), rt.new_string('_wpnonce'), rt.new_bool(true), rt.new_bool(false)]), rt.call_function('esc_attr', [rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])])])).str() +
		'</form>'
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_status() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('order-confirmation-status')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.render_content(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'render_content_fallback' {
			return rt.new_string(this.render_content_fallback())
		}
		'render_confirmation_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_confirmation_notice(dispatch_arg_0))
		}
		'render_verification_form' {
			return rt.new_string(this.render_verification_form())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_status_php() {
}
