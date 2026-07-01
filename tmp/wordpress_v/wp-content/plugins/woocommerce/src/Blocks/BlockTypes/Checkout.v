import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('checkout')
		chunks_folder rt.PhpVal = rt.new_string('checkout-blocks')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'register_settings' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'register_patterns' }])])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'disable_wp_emoji' }])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_redirect_empty_cart := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return if rt.get_superglobal('_GET').array_isset(rt.new_string('_wp-find-template')) { rt.new_bool(false) } else { var_redirect_empty_cart }
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_checkout_redirect_empty_cart'), rt.new_closure(closure_1_fn)])
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'update_local_pickup_title' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) disable_wp_emoji()  {
	if rt.is_true(rt.call_function('has_block', [this.get_full_block_name()])) {
		rt.call_function('remove_action', [rt.new_string('wp_head'), rt.new_string('print_emoji_detection_script'), rt.new_int(7)])
		rt.call_function('remove_action', [rt.new_string('wp_print_styles'), rt.new_string('print_emoji_styles')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dequeue_woocommerce_core_scripts()  {
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-checkout')])
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-address-autocomplete')])
	rt.call_function('wp_dequeue_style', [rt.new_string('wc-address-autocomplete')])
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-password-strength-meter')])
	rt.call_function('wp_dequeue_script', [rt.new_string('selectWoo')])
	rt.call_function('wp_dequeue_style', [rt.new_string('select2')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) register_settings()  {
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('woocommerce_checkout_phone_field'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Controls the display of the phone field in checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Phone number'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'woocommerce_checkout_phone_field' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'optional' }, rt.ArrayItem{ key: none, val: 'required' }, rt.ArrayItem{ key: none, val: 'hidden' }]) }]) }]) }, rt.ArrayItem{ key: 'default', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.get_phone_field_visibility() }() }])])
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('woocommerce_checkout_company_field'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Controls the display of the company field in checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'woocommerce_checkout_company_field' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'optional' }, rt.ArrayItem{ key: none, val: 'required' }, rt.ArrayItem{ key: none, val: 'hidden' }]) }]) }]) }, rt.ArrayItem{ key: 'default', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.get_company_field_visibility() }() }])])
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('woocommerce_checkout_address_2_field'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Controls the display of the apartment (address_2) field in checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Address Line 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'woocommerce_checkout_address_2_field' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'optional' }, rt.ArrayItem{ key: none, val: 'required' }, rt.ArrayItem{ key: none, val: 'hidden' }]) }]) }]) }, rt.ArrayItem{ key: 'default', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.get_address_2_field_visibility() }() }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) register_patterns()  {
	rt.call_function('register_block_pattern', [rt.new_string('woocommerce/checkout-heading'), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val: '<!-- wp:heading {"align":"wide", "level":1} --><h1 class="wp-block-heading alignwide">' + (rt.call_function('esc_html__', [rt.new_string('Checkout'), rt.new_string('woocommerce')])).str() + '</h1><!-- /wp:heading -->' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' }, rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_api'), 'get_block_asset_build_path', [this.block_name]) }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks' }]) }])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_dependencies := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) && rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password')]))))) {
		var_dependencies.array_push('zxcvbn-async')
	}
	mut var_checkout_fields := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class()])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation{}; return temp.has_field_schema(arg_0) }(rt.call_method(var_checkout_fields, 'get_additional_fields', []rt.PhpVal{}))) {
		var_dependencies.array_push('wc-schema-parser')
	}
	mut var_script := rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block-frontend' }, rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_api'), 'get_block_asset_build_path', [(this.block_name).str() + '-frontend']) }, rt.ArrayItem{ key: 'dependencies', val: var_dependencies }])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal)  {
	mut var_attributes_mutated := var_attributes
	mut var_content_mutated := var_content
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_enqueue_checkout_block_scripts_before')])
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes_mutated), var_content_mutated.dup(), var_block.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_enqueue_checkout_block_scripts_after')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_content_mutated := var_content
	if this.is_checkout_endpoint() {
		return if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) { rt.call_function('do_shortcode', [rt.new_string('[woocommerce_checkout]')]) } else { rt.new_string('[woocommerce_checkout]') }
	}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'dequeue_woocommerce_core_scripts' }]), rt.new_int(20)])
	mut var_regex_for_empty_block := rt.new_string(rt.new_string('/<div class="[a-zA-Z0-9_\\- ]*wp-block-woocommerce-checkout[a-zA-Z0-9_\\- ]*"><\\/div>/mi'))
	mut var_has_i1_template := rt.call_function('preg_match', [var_regex_for_empty_block.dup(), var_content_mutated.dup()])
	if rt.is_true(var_has_i1_template) {
		mut var_inner_blocks_html := rt.new_string('\n\t\t\t\t<div data-block-name="woocommerce/checkout-fields-block" class="wp-block-woocommerce-checkout-fields-block">\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-express-payment-block" class="wp-block-woocommerce-checkout-express-payment-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-contact-information-block" class="wp-block-woocommerce-checkout-contact-information-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-shipping-address-block" class="wp-block-woocommerce-checkout-shipping-address-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-billing-address-block" class="wp-block-woocommerce-checkout-billing-address-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-shipping-methods-block" class="wp-block-woocommerce-checkout-shipping-methods-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-payment-block" class="wp-block-woocommerce-checkout-payment-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-additional-information-block" class="wp-block-woocommerce-checkout-additional-information-block"></div>' + if rt.is_true(rt.new_bool(var_attributes_mutated.array_isset(rt.new_string('showOrderNotes')) && rt.is_true(rt.identical(rt.new_bool(false), var_attributes_mutated.array_get('showOrderNotes'))))) { '' } else { '<div data-block-name="woocommerce/checkout-order-note-block" class="wp-block-woocommerce-checkout-order-note-block"></div>' } + if rt.is_true(rt.new_bool(var_attributes_mutated.array_isset(rt.new_string('showPolicyLinks')) && rt.is_true(rt.identical(rt.new_bool(false), var_attributes_mutated.array_get('showPolicyLinks'))))) { '' } else { '<div data-block-name="woocommerce/checkout-terms-block" class="wp-block-woocommerce-checkout-terms-block"></div>' } + '<div data-block-name="woocommerce/checkout-actions-block" class="wp-block-woocommerce-checkout-actions-block"></div>\n\t\t\t\t</div>\n\t\t\t\t<div data-block-name="woocommerce/checkout-totals-block" class="wp-block-woocommerce-checkout-totals-block">\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-order-summary-block" class="wp-block-woocommerce-checkout-order-summary-block"></div>\n\t\t\t\t</div>\n\t\t\t')
		var_content_mutated = rt.call_function('str_replace', [rt.new_string('</div>'), (var_inner_blocks_html).str() + '</div>', var_content_mutated.dup()])
	}
	mut var_order_summary_with_inner_blocks := rt.new_string(rt.new_string('$0\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-cart-items-block" class="wp-block-woocommerce-checkout-order-summary-cart-items-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-subtotal-block" class="wp-block-woocommerce-checkout-order-summary-subtotal-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-fee-block" class="wp-block-woocommerce-checkout-order-summary-fee-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-discount-block" class="wp-block-woocommerce-checkout-order-summary-discount-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-coupon-form-block" class="wp-block-woocommerce-checkout-order-summary-coupon-form-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-shipping-block" class="wp-block-woocommerce-checkout-order-summary-shipping-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-taxes-block" class="wp-block-woocommerce-checkout-order-summary-taxes-block"></div>\n\t\t'))
	mut var_regex_for_order_summary_subtotal := rt.new_string(rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-order-summary-subtotal-block"[^>]*?>/mi'))
	mut var_regex_for_order_summary := rt.new_string(rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-order-summary-block"[^>]*?>/mi'))
	mut var_has_i2_template := rt.new_bool(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [var_regex_for_order_summary_subtotal.dup(), var_content_mutated.dup()])))))
	if rt.is_true(var_has_i2_template) {
		var_content_mutated = rt.call_function('preg_replace', [var_regex_for_order_summary.dup(), var_order_summary_with_inner_blocks.dup(), var_content_mutated.dup()])
	}
	mut var_local_pickup_inner_blocks := rt.new_string('<div data-block-name="woocommerce/checkout-shipping-method-block" class="wp-block-woocommerce-checkout-shipping-method-block"></div>' + (rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() + '<div data-block-name="woocommerce/checkout-pickup-options-block" class="wp-block-woocommerce-checkout-pickup-options-block"></div>' + (rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() + '$0')
	mut var_has_local_pickup_regex := rt.new_string(rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-shipping-method-block"[^>]*?>/mi'))
	mut var_has_local_pickup := rt.call_function('preg_match', [var_has_local_pickup_regex.dup(), var_content_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_local_pickup)))) {
		mut var_shipping_address_block_regex := rt.new_string(rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-shipping-address-block" class="wp-block-woocommerce-checkout-shipping-address-block"[^>]*?><\\/div>/mi'))
		var_content_mutated = rt.call_function('preg_replace', [var_shipping_address_block_regex.dup(), var_local_pickup_inner_blocks.dup(), var_content_mutated.dup()])
	}
	mut var_additional_information_inner_blocks := rt.new_string('$0' + (rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() + '<div data-block-name="woocommerce/checkout-additional-information-block" class="wp-block-woocommerce-checkout-additional-information-block"></div>' + (rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str())
	mut var_has_additional_information_regex := rt.new_string(rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-additional-information-block"[^>]*?>/mi'))
	mut var_has_additional_information_block := rt.call_function('preg_match', [var_has_additional_information_regex.dup(), var_content_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_additional_information_block)))) {
		mut var_payment_block_regex := rt.new_string(rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-payment-block" class="wp-block-woocommerce-checkout-payment-block"[^>]*?><\\/div>/mi'))
		var_content_mutated = rt.call_function('preg_replace', [var_payment_block_regex.dup(), var_additional_information_inner_blocks.dup(), var_content_mutated.dup()])
	}
	return var_content_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) is_checkout_endpoint() bool {
	return rt.is_true(rt.call_function('is_wc_endpoint_url', [rt.new_string('order-pay')])) || rt.is_true(rt.call_function('is_wc_endpoint_url', [rt.new_string('order-received')]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) update_local_pickup_title(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_post, 'post_status')) || rt.is_true(rt.identical(rt.new_string('inherit'), rt.get_property(var_post, 'post_status'))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post, 'post_type'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), var_post.dup()]))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post, 'post_type'))) && !(!rt.is_true(rt.get_property(var_post, 'post_name'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_property(var_post, 'post_type'))))) || rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), var_post.dup()]))))) {
		return rt.new_null()
	}
	mut var_pickup_location_settings := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}; return temp.get_local_pickup_settings(arg_0) }(rt.new_string('edit'))
	if !(var_pickup_location_settings.array_isset(rt.new_string('title'))) {
		return rt.new_null()
	}
	if !rt.is_true(rt.get_property(var_post, 'post_content')) {
		return rt.new_null()
	}
	mut var_title := this.find_local_pickup_text_in_checkout_block(rt.get_property(var_post, 'post_content'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_title.dup().is_string()))))) {
		var_title = rt.new_string(rt.new_string(''))
	}
	var_pickup_location_settings.array_set('title', var_title.dup())
	rt.call_function('update_option', [rt.new_string('woocommerce_pickup_location_settings'), var_pickup_location_settings.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) find_local_pickup_text_in_checkout_block(var_post_content rt.PhpVal) rt.PhpVal {
	mut var_scanner := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Block_Scanner{}; return temp.create(arg_0) }(var_post_content.dup())
	for rt.is_true(rt.call_method(var_scanner, 'next_delimiter', []rt.PhpVal{})) {
		if rt.is_true(rt.call_method(var_scanner, 'opens_block', [rt.new_string('woocommerce/checkout-shipping-method-block')])) {
			mut var_attributes := rt.call_method(var_scanner, 'allocate_and_return_parsed_attributes', []rt.PhpVal{})
			if var_attributes.array_isset(rt.new_string('localPickupText')) {
				return var_attributes.array_get('localPickupText')
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes_mutated))
	mut var_country_data := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.get_country_data() }()
	mut var_address_formats := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_address_formats', []rt.PhpVal{})
	{
		mut iter_1 := var_address_formats.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_format := item_1.val
			mut var_country_code := item_1.key
			if rt.is_true(rt.identical(rt.new_string('default'), var_country_code)) {
				continue
			}
			var_country_data.array_get_mut(var_country_code).array_set('format', var_format.dup())
		}
	}
	mut var_providers_payload := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class()])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class()])
		mut var_providers := rt.call_method(var_controller, 'get_providers', []rt.PhpVal{})
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'name', val: rt.call_function('sanitize_text_field', [// unsupported expression: Expr_Cast_String]) }, rt.ArrayItem{ key: 'branding_html', val: rt.call_function('wp_kses_post', [// unsupported expression: Expr_Cast_String]) }])
	}
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'name', val: rt.call_function('sanitize_text_field', [// unsupported expression: Expr_Cast_String]) }, rt.ArrayItem{ key: 'branding_html', val: rt.call_function('wp_kses_post', [// unsupported expression: Expr_Cast_String]) }])
	}
		var_providers_payload = rt.call_function('array_map', [rt.new_closure(closure_2_fn), rt.cast_array(var_providers)])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('addressAutocompleteProviders'), var_providers_payload.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('countryData'), var_country_data.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultAddressFormat'), var_address_formats.array_get('default')])
	rt.call_function('wp_prime_option_caches', [rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_enable_guest_checkout' }, rt.ArrayItem{ key: none, val: 'woocommerce_enable_signup_and_login_from_checkout' }, rt.ArrayItem{ key: none, val: 'woocommerce_enable_checkout_login_reminder' }, rt.ArrayItem{ key: none, val: 'woocommerce_tax_display_cart' }, rt.ArrayItem{ key: none, val: 'woocommerce_tax_total_display' }, rt.ArrayItem{ key: none, val: 'woocommerce_ship_to_destination' }, rt.ArrayItem{ key: none, val: 'woocommerce_registration_generate_password' }, rt.ArrayItem{ key: none, val: 'pickup_location_pickup_locations' }])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('checkoutAllowsGuest'), rt.identical(rt.new_bool(false), rt.call_function('filter_var', [, ]))])
	rt.call_method(rt.get_property(, 'asset_data_registry'), 'add', [rt.new_string('checkoutAllowsSignup'), rt.call_function('filter_var', [, ])])
	rt.call_method(, 'add', [, ])
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) hydrate_customer_payment_methods()  {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) register_block_type_assets()  {
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout.get_checkout_block_types() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_Block_Scanner {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_checkout() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('checkout')
		chunks_folder: rt.new_string('checkout-blocks')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
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

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_validation() &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils() &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_block_scanner() &Class_Automattic_Block_Scanner {
	mut obj := &Class_Automattic_Block_Scanner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'disable_wp_emoji' {
			this.disable_wp_emoji()
			return rt.new_null()
		}
		'dequeue_woocommerce_core_scripts' {
			this.dequeue_woocommerce_core_scripts()
			return rt.new_null()
		}
		'register_settings' {
			this.register_settings()
			return rt.new_null()
		}
		'register_patterns' {
			this.register_patterns()
			return rt.new_null()
		}
		'get_block_type_editor_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_editor_script(dispatch_arg_0)
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'is_checkout_endpoint' {
			return rt.new_bool(this.is_checkout_endpoint())
		}
		'update_local_pickup_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_local_pickup_title(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'find_local_pickup_text_in_checkout_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_local_pickup_text_in_checkout_block(dispatch_arg_0)
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'hydrate_customer_payment_methods' {
			this.hydrate_customer_payment_methods()
			return rt.new_null()
		}
		'register_block_type_assets' {
			this.register_block_type_assets()
			return rt.new_null()
		}
		'get_checkout_block_types' {
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout.get_checkout_block_types()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'chunks_folder' { return this.chunks_folder }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		'chunks_folder' { this.chunks_folder = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_Block_Scanner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Block_Scanner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Block_Scanner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_checkout_php() {
	// unsupported statement: Stmt_Declare
}
