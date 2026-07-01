import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('checkout-express-payment-block')
		default_styles rt.PhpVal = rt.new_null()
		current_styles rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock.initialize()
	this.default_styles = rt.create_array([rt.ArrayItem{ key: 'showButtonStyles', val: false }, rt.ArrayItem{ key: 'buttonHeight', val: '48' }, rt.ArrayItem{ key: 'buttonBorderRadius', val: '4' }])
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock'], &this) }, rt.ArrayItem{ key: none, val: 'sync_express_payment_attrs' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock) sync_express_payment_attrs(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
	if rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [rt.new_string('cart')]), var_post_id)) {
		mut var_cart_or_checkout := rt.new_string(rt.new_string('cart'))
	} else if rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [rt.new_string('checkout')]), var_post_id)) {
		var_cart_or_checkout = rt.new_string(rt.new_string('checkout'))
	} else {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_post_mutated, 'post_status')) || rt.is_true(rt.identical(rt.new_string('inherit'), rt.get_property(var_post_mutated, 'post_status'))))) {
		return rt.new_null()
	}
	mut var_block_name := rt.new_string('woocommerce/' + (var_cart_or_checkout).str())
	mut var_page_id := rt.new_string('woocommerce_' + (var_cart_or_checkout).str() + '_page_id')
	mut var_template_name := rt.new_string('page-' + (var_cart_or_checkout).str())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post_mutated, 'post_type'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_block', [var_block_name.dup(), var_post_mutated.dup()]))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post_mutated, 'post_type'))) && !(!rt.is_true(rt.get_property(var_post_mutated, 'post_name'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_property(var_post_mutated, 'post_type'))))) || rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_block', [var_block_name.dup(), var_post_mutated.dup()]))))) {
		return rt.new_null()
	}
	if !rt.is_true(rt.get_property(var_post_mutated, 'post_content')) {
		return rt.new_null()
	}
	mut var_attrs := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.find_express_checkout_attributes(arg_0, arg_1) }(rt.get_property(var_post_mutated, 'post_content'), var_cart_or_checkout.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attrs.dup().is_array()))))) {
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_updated_attrs := rt.call_function('array_merge', [this.default_styles, var_attrs.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_other_page := rt.new_string(if rt.is_true(rt.identical(rt.new_string('cart'), var_cart_or_checkout)) { rt.new_string('checkout') } else { rt.new_string('cart') })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.update_other_page_with_express_payment_attrs(var_other_page.dup(), var_updated_attrs.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [rt.new_string('error'), 'Error updating express payment attributes: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock) update_other_page_with_express_payment_attrs(var_cart_or_checkout rt.PhpVal, var_updated_attrs rt.PhpVal)  {
	mut var_cart_or_checkout_mutated := var_cart_or_checkout
	mut var_updated_attrs_mutated := var_updated_attrs
	mut var_page_id := if rt.is_true(rt.identical(rt.new_string('cart'), var_cart_or_checkout_mutated)) { rt.call_function('wc_get_page_id', [rt.new_string('cart')]) } else { rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }
	if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_page_id)) {
		return rt.new_null()
	}
	mut var_post := rt.call_function('get_post', [var_page_id.dup()])
	if !rt.is_true(rt.get_property(var_post, 'post_content')) {
		return rt.new_null()
	}
	mut var_blocks := rt.call_function('parse_blocks', [rt.get_property(var_post, 'post_content')])
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.update_blocks_with_new_attrs(arg_0, arg_1, arg_2) }(var_blocks.dup(), var_cart_or_checkout_mutated.dup(), var_updated_attrs_mutated.dup())
	mut var_updated_content := rt.call_function('serialize_blocks', [var_blocks.dup()])
	rt.call_function('remove_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock'], &this) }, rt.ArrayItem{ key: none, val: 'sync_express_payment_attrs' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_page_id }, rt.ArrayItem{ key: 'post_content', val: var_updated_content }]), rt.new_bool(false), rt.new_bool(false)])
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock'], &this) }, rt.ArrayItem{ key: none, val: 'sync_express_payment_attrs' }]), rt.new_int(10), rt.new_int(2)])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_checkoutexpresspaymentblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('checkout-express-payment-block')
		default_styles: rt.new_null()
		current_styles: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils() &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'sync_express_payment_attrs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.sync_express_payment_attrs(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_other_page_with_express_payment_attrs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_other_page_with_express_payment_attrs(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'default_styles' { return this.default_styles }
		'current_styles' { return this.current_styles }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutExpressPaymentBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		'default_styles' { this.default_styles = val; return true }
		'current_styles' { this.current_styles = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_checkoutexpresspaymentblock_php() {
}
