import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('mini-cart-footer-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	mut var_description := rt.new_string(this.get_totals_item_description())
	if !(!rt.is_true(var_description)) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock',
		], &this), 'asset_data_registry'), 'add', [
			rt.new_string('miniCartFooterDescription'),
			var_description.clone(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) render_experimental_iapi_mini_cart_footer(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_cart := this.get_cart_instance()
	mut var_subtotal_label := rt.call_function('__', [rt.new_string('Subtotal'),
		rt.new_string('woocommerce')])
	mut var_other_costs_label := rt.new_string(this.get_totals_item_description())
	mut var_display_cart_price_including_tax := rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_cart'),
	]), rt.new_string('incl'))
	mut var_subtotal := if rt.is_true(var_display_cart_price_including_tax) {
		rt.call_method(var_cart, 'get_subtotal_tax', []rt.PhpVal{})
	} else {
		rt.call_method(var_cart, 'get_subtotal', []rt.PhpVal{})
	}
	mut var_formatted_subtotal := rt.new_string('')
	mut var_html := create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(rt.call_function('wc_price', [
		var_subtotal.clone(),
	]))
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/mini-cart-footer-block' },
			rt.ArrayItem{ key: 'class', val: 'wc-block-mini-cart__footer' },
		]),
	])
	if rt.is_true(var_html.next_tag(rt.new_string('bdi'))) {
		for rt.is_true(var_html.next_token()) {
			if rt.is_true(rt.identical(rt.new_string('#text'), var_html.get_token_name())) {
				var_formatted_subtotal = rt.concat(var_formatted_subtotal,
					var_html.get_modifiable_text())
			}
		}
	}
	rt.call_function('wp_interactivity_state', [this.get_full_block_name(),
		rt.create_array([
			rt.ArrayItem{ key: 'formattedSubtotal', val: var_formatted_subtotal },
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_subtotal_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_other_costs_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_content) {
		rt.echo_val(rt.call_function('do_blocks', [
			rt.new_string('<!-- wp:woocommerce/mini-cart-cart-button-block /--><!-- wp:woocommerce/mini-cart-checkout-button-block /-->'),
		]))
	} else {
		rt.echo_val(var_content)
	}
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) get_cart_instance() rt.PhpVal {
	mut var_cart := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')
	if rt.is_true(var_cart)
		&& rt.is_true(rt.new_bool(rt.instance_of(var_cart, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Cart'))) {
		return var_cart.clone()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) get_totals_item_description() string {
	mut var_taxes_enabled := rt.call_function('wc_tax_enabled', []rt.PhpVal{})
	mut var_shipping_enabled := rt.call_function('wc_shipping_enabled', []rt.PhpVal{})
	mut var_coupons_enabled := rt.call_function('wc_coupons_enabled', []rt.PhpVal{})
	if rt.is_true(var_taxes_enabled) && rt.is_true(var_shipping_enabled)
		&& rt.is_true(var_coupons_enabled) {
		return (rt.call_function('__', [
			rt.new_string('Shipping, taxes, and discounts calculated at checkout.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	if rt.is_true(var_shipping_enabled) && rt.is_true(var_taxes_enabled) {
		return (rt.call_function('__', [
			rt.new_string('Shipping and taxes calculated at checkout.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	if rt.is_true(var_shipping_enabled) && rt.is_true(var_coupons_enabled) {
		return (rt.call_function('__', [
			rt.new_string('Shipping and discounts calculated at checkout.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	if rt.is_true(var_taxes_enabled) && rt.is_true(var_coupons_enabled) {
		return (rt.call_function('__', [
			rt.new_string('Taxes and discounts calculated at checkout.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	if rt.is_true(var_shipping_enabled) {
		return (rt.call_function('__', [
			rt.new_string('Shipping calculated at checkout.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	if rt.is_true(var_taxes_enabled) {
		return (rt.call_function('__', [rt.new_string('Taxes calculated at checkout.'),
			rt.new_string('woocommerce')])).str()
	}
	if rt.is_true(var_coupons_enabled) {
		return (rt.call_function('__', [
			rt.new_string('Discounts calculated at checkout.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(iife_result_0) {
		return this.render_experimental_iapi_mini_cart_footer(var_attributes.clone(),
			var_content.clone(), var_block.clone())
	}
	return var_content.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_minicartfooterblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('mini-cart-footer-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_experimental_iapi_mini_cart_footer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_experimental_iapi_mini_cart_footer(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_cart_instance' {
			return this.get_cart_instance()
		}
		'get_totals_item_description' {
			return rt.new_string(this.get_totals_item_description())
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartFooterBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
