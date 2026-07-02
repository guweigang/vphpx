import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout {
	rt.PhpObjectBase
pub mut:
	block_name    rt.PhpVal = rt.new_string('checkout')
	chunks_folder rt.PhpVal = rt.new_string('checkout-blocks')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_settings' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_patterns' },
		])])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'disable_wp_emoji' },
		])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_redirect_empty_cart := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_checkout_redirect_empty_cart'),
		rt.new_closure(closure_1_fn),
	])
	rt.call_function('add_action', [rt.new_string('save_post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_local_pickup_title' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) disable_wp_emoji() {
	if rt.is_true(rt.call_function('has_block', [this.get_full_block_name()])) {
		rt.call_function('remove_action', [rt.new_string('wp_head'),
			rt.new_string('print_emoji_detection_script'), rt.new_int(7)])
		rt.call_function('remove_action', [rt.new_string('wp_print_styles'),
			rt.new_string('print_emoji_styles')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) dequeue_woocommerce_core_scripts() {
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-checkout')])
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-address-autocomplete')])
	rt.call_function('wp_dequeue_style', [rt.new_string('wc-address-autocomplete')])
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-password-strength-meter')])
	rt.call_function('wp_dequeue_script', [rt.new_string('selectWoo')])
	rt.call_function('wp_dequeue_style', [rt.new_string('select2')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) register_settings() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_1 := iife_temp_1.get_phone_field_visibility()
	rt.call_function('register_setting', [rt.new_string('options'),
		rt.new_string('woocommerce_checkout_phone_field'),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Controls the display of the phone field in checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Phone number'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'woocommerce_checkout_phone_field' },
				rt.ArrayItem{ key: 'schema', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'optional' },
						rt.ArrayItem{ key: none, val: 'required' },
						rt.ArrayItem{ key: none, val: 'hidden' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'default', val: iife_result_1 },
		])])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_2 := iife_temp_2.get_company_field_visibility()
	rt.call_function('register_setting', [rt.new_string('options'),
		rt.new_string('woocommerce_checkout_company_field'),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Controls the display of the company field in checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Company'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'woocommerce_checkout_company_field' },
				rt.ArrayItem{ key: 'schema', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'optional' },
						rt.ArrayItem{ key: none, val: 'required' },
						rt.ArrayItem{ key: none, val: 'hidden' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'default', val: iife_result_2 },
		])])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_3 := iife_temp_3.get_address_2_field_visibility()
	rt.call_function('register_setting', [rt.new_string('options'),
		rt.new_string('woocommerce_checkout_address_2_field'),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Controls the display of the apartment (address_2) field in checkout.'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Address Line 2'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'woocommerce_checkout_address_2_field' },
				rt.ArrayItem{ key: 'schema', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'optional' },
						rt.ArrayItem{ key: none, val: 'required' },
						rt.ArrayItem{ key: none, val: 'hidden' },
					]) },
				]) },
			]) }, rt.ArrayItem{ key: 'default', val: iife_result_3 }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) register_patterns() {
	rt.call_function('register_block_pattern', [
		rt.new_string('woocommerce/checkout-heading'),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val:
				'<!-- wp:heading {"align":"wide", "level":1} --><h1 class="wp-block-heading alignwide">' +
				(rt.call_function('esc_html__', [rt.new_string('Checkout'), rt.new_string('woocommerce')])).str() +
				'</h1><!-- /wp:heading -->' }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_block_asset_build_path', [
			this.block_name,
		]) },
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks' },
		]) },
	])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_dependencies := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		&& rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password')]))) {
		var_dependencies.array_push('zxcvbn-async')
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_4 := iife_temp_4.container()
	mut var_checkout_fields := rt.call_method(iife_result_4, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
	mut iife_temp_5 :=
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation{}
	mut iife_result_5 := iife_temp_5.has_field_schema(rt.call_method(var_checkout_fields,
		'get_additional_fields', []rt.PhpVal{}))
	if rt.is_true(iife_result_5) {
		var_dependencies.array_push('wc-schema-parser')
	}
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block-frontend' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_block_asset_build_path', [
			rt.new_string((this.block_name).str() + '-frontend'),
		]) },
		rt.ArrayItem{ key: 'dependencies', val: var_dependencies },
	])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal) {
	mut var_attributes_mutated := var_attributes
	mut var_content_mutated := var_content
	rt.call_function('do_action', [
		rt.new_string('woocommerce_blocks_enqueue_checkout_block_scripts_before'),
	])
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated), var_content_mutated.clone(), var_block.clone())
	rt.call_function('do_action', [
		rt.new_string('woocommerce_blocks_enqueue_checkout_block_scripts_after'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_content_mutated := var_content
	if this.is_checkout_endpoint() {
		return if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) { rt.call_function('do_shortcode', [
				rt.new_string('[woocommerce_checkout]'),
			]) } else { rt.new_string('[woocommerce_checkout]') }
	}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'dequeue_woocommerce_core_scripts' },
		]),
		rt.new_int(20)])
	mut var_regex_for_empty_block :=
		rt.new_string('/<div class="[a-zA-Z0-9_\\- ]*wp-block-woocommerce-checkout[a-zA-Z0-9_\\- ]*"><\\/div>/mi')
	mut var_has_i1_template := rt.call_function('preg_match', [
		var_regex_for_empty_block.clone(), var_content_mutated.clone()])
	if rt.is_true(var_has_i1_template) {
		mut var_inner_blocks_html := rt.new_string(
			'\n\t\t\t\t<div data-block-name="woocommerce/checkout-fields-block" class="wp-block-woocommerce-checkout-fields-block">\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-express-payment-block" class="wp-block-woocommerce-checkout-express-payment-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-contact-information-block" class="wp-block-woocommerce-checkout-contact-information-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-shipping-address-block" class="wp-block-woocommerce-checkout-shipping-address-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-billing-address-block" class="wp-block-woocommerce-checkout-billing-address-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-shipping-methods-block" class="wp-block-woocommerce-checkout-shipping-methods-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-payment-block" class="wp-block-woocommerce-checkout-payment-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-additional-information-block" class="wp-block-woocommerce-checkout-additional-information-block"></div>' +
			if var_attributes_mutated.array_isset(rt.new_string('showOrderNotes')) && rt.is_true(rt.identical(rt.new_bool(false), var_attributes_mutated.array_get(rt.new_string('showOrderNotes')))) { '' } else { '<div data-block-name="woocommerce/checkout-order-note-block" class="wp-block-woocommerce-checkout-order-note-block"></div>' } +
			if var_attributes_mutated.array_isset(rt.new_string('showPolicyLinks')) && rt.is_true(rt.identical(rt.new_bool(false), var_attributes_mutated.array_get(rt.new_string('showPolicyLinks')))) { '' } else { '<div data-block-name="woocommerce/checkout-terms-block" class="wp-block-woocommerce-checkout-terms-block"></div>' } +
			'<div data-block-name="woocommerce/checkout-actions-block" class="wp-block-woocommerce-checkout-actions-block"></div>\n\t\t\t\t</div>\n\t\t\t\t<div data-block-name="woocommerce/checkout-totals-block" class="wp-block-woocommerce-checkout-totals-block">\n\t\t\t\t\t<div data-block-name="woocommerce/checkout-order-summary-block" class="wp-block-woocommerce-checkout-order-summary-block"></div>\n\t\t\t\t</div>\n\t\t\t')
		var_content_mutated = rt.call_function('str_replace', [
			rt.new_string('</div>'), rt.new_string(var_inner_blocks_html.str() + '</div>'),
			var_content_mutated.clone()])
	}
	mut var_order_summary_with_inner_blocks :=
		rt.new_string('$0\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-cart-items-block" class="wp-block-woocommerce-checkout-order-summary-cart-items-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-subtotal-block" class="wp-block-woocommerce-checkout-order-summary-subtotal-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-fee-block" class="wp-block-woocommerce-checkout-order-summary-fee-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-discount-block" class="wp-block-woocommerce-checkout-order-summary-discount-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-coupon-form-block" class="wp-block-woocommerce-checkout-order-summary-coupon-form-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-shipping-block" class="wp-block-woocommerce-checkout-order-summary-shipping-block"></div>\n\t\t\t<div data-block-name="woocommerce/checkout-order-summary-taxes-block" class="wp-block-woocommerce-checkout-order-summary-taxes-block"></div>\n\t\t')
	mut var_regex_for_order_summary_subtotal :=
		rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-order-summary-subtotal-block"[^>]*?>/mi')
	mut var_regex_for_order_summary :=
		rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-order-summary-block"[^>]*?>/mi')
	mut var_has_i2_template := rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		var_regex_for_order_summary_subtotal.clone(),
		var_content_mutated.clone(),
	]))))
	if rt.is_true(var_has_i2_template) {
		var_content_mutated = rt.call_function('preg_replace', [
			var_regex_for_order_summary.clone(), var_order_summary_with_inner_blocks.clone(),
			var_content_mutated.clone()])
	}
	mut var_local_pickup_inner_blocks := rt.new_string(
		'<div data-block-name="woocommerce/checkout-shipping-method-block" class="wp-block-woocommerce-checkout-shipping-method-block"></div>' +
		(rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() + '<div data-block-name="woocommerce/checkout-pickup-options-block" class="wp-block-woocommerce-checkout-pickup-options-block"></div>' + (rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() + '$0')
	mut var_has_local_pickup_regex :=
		rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-shipping-method-block"[^>]*?>/mi')
	mut var_has_local_pickup := rt.call_function('preg_match', [
		var_has_local_pickup_regex.clone(), var_content_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_local_pickup)))) {
		mut var_shipping_address_block_regex :=
			rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-shipping-address-block" class="wp-block-woocommerce-checkout-shipping-address-block"[^>]*?><\\/div>/mi')
		var_content_mutated = rt.call_function('preg_replace', [
			var_shipping_address_block_regex.clone(), var_local_pickup_inner_blocks.clone(),
			var_content_mutated.clone()])
	}
	mut var_additional_information_inner_blocks := rt.new_string('$0' +
		(rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() +
		'<div data-block-name="woocommerce/checkout-additional-information-block" class="wp-block-woocommerce-checkout-additional-information-block"></div>' +
		(rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str())
	mut var_has_additional_information_regex :=
		rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-additional-information-block"[^>]*?>/mi')
	mut var_has_additional_information_block := rt.call_function('preg_match', [
		var_has_additional_information_regex.clone(),
		var_content_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_additional_information_block)))) {
		mut var_payment_block_regex :=
			rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/checkout-payment-block" class="wp-block-woocommerce-checkout-payment-block"[^>]*?><\\/div>/mi')
		var_content_mutated = rt.call_function('preg_replace', [
			var_payment_block_regex.clone(), var_additional_information_inner_blocks.clone(),
			var_content_mutated.clone()])
	}
	return var_content_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) is_checkout_endpoint() bool {
	return rt.is_true(rt.call_function('is_wc_endpoint_url', [rt.new_string('order-pay')]))
		|| rt.is_true(rt.call_function('is_wc_endpoint_url', [rt.new_string('order-received')]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) update_local_pickup_title(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_post, 'post_status'))
		|| rt.is_true(rt.identical(rt.new_string('inherit'), rt.get_property(var_post, 'post_status'))) {
		return
	}
	if !(!rt.is_true(rt.get_property(var_post, 'post_type')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_property(var_post, 'post_type')))))
		&& rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), var_post.clone()])))
		|| rt.is_true(rt.new_bool((rt.call_function('get_option', [rt.new_string('woocommerce_checkout_page_id')])).str() != var_post_id.str())) {
		return
	}
	if (!(!rt.is_true(rt.get_property(var_post, 'post_type')))
		&& !(!rt.is_true(rt.get_property(var_post, 'post_name')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page-checkout'), rt.get_property(var_post, 'post_name')))))
		&& rt.is_true(rt.identical(rt.new_string('wp_template'), rt.get_property(var_post, 'post_type'))))
		|| rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), var_post.clone()]))) {
		return
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_6 := iife_temp_6.get_local_pickup_settings(rt.new_string('edit'))
	mut var_pickup_location_settings := iife_result_6
	if !(var_pickup_location_settings.array_isset(rt.new_string('title'))) {
		return
	}
	if !rt.is_true(rt.get_property(var_post, 'post_content')) {
		return
	}
	mut var_title := this.find_local_pickup_text_in_checkout_block(rt.get_property(var_post,
		'post_content'))
	if !(var_title.clone().is_string()) {
		var_title = rt.new_string('')
	}
	var_pickup_location_settings.array_set('title', var_title.clone())
	rt.call_function('update_option', [
		rt.new_string('woocommerce_pickup_location_settings'),
		var_pickup_location_settings.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) find_local_pickup_text_in_checkout_block(var_post_content rt.PhpVal) rt.PhpVal {
	mut iife_temp_7 := Class_Automattic_Block_Scanner{}
	mut iife_result_7 := iife_temp_7.create(var_post_content.clone())
	mut var_scanner := iife_result_7
	for rt.is_true(rt.call_method(var_scanner, 'next_delimiter', []rt.PhpVal{})) {
		if rt.is_true(rt.call_method(var_scanner, 'opens_block', [
			rt.new_string('woocommerce/checkout-shipping-method-block'),
		]))
		{
			mut var_attributes := rt.call_method(var_scanner,
				'allocate_and_return_parsed_attributes', []rt.PhpVal{})
			if var_attributes.array_isset(rt.new_string('localPickupText')) {
				return var_attributes.array_get(rt.new_string('localPickupText'))
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated))
	mut iife_temp_8 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_8 := iife_temp_8.get_country_data()
	mut var_country_data := iife_result_8
	mut var_address_formats := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_address_formats', []rt.PhpVal{})
	mut iter_1 := var_address_formats.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_format := item_1.val
		mut var_country_code := item_1.key
		if rt.is_true(rt.identical(rt.new_string('default'), var_country_code)) {
			continue
		}
		var_country_data.array_get_mut(var_country_code).array_set('format', var_format.clone())
	}
	mut var_providers_payload := rt.new_array()
	if rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class()]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_address_autocomplete_enabled'), rt.new_string('no')]))))) {
		mut var_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [
			Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class(),
		])
		mut var_providers := rt.call_method(var_controller, 'get_providers', []rt.PhpVal{})
		closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_provider := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_provider := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		var_providers_payload = rt.call_function('array_map', [
			rt.new_closure(closure_10_fn),
			rt.cast_array(var_providers),
		])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('addressAutocompleteProviders'),
		var_providers_payload.clone(),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('countryData'),
		var_country_data.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultAddressFormat'),
		var_address_formats.array_get(rt.new_string('default'))])
	rt.call_function('wp_prime_option_caches', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_enable_guest_checkout' },
			rt.ArrayItem{ key: none, val: 'woocommerce_enable_signup_and_login_from_checkout' },
			rt.ArrayItem{ key: none, val: 'woocommerce_enable_checkout_login_reminder' },
			rt.ArrayItem{ key: none, val: 'woocommerce_tax_display_cart' },
			rt.ArrayItem{ key: none, val: 'woocommerce_tax_total_display' },
			rt.ArrayItem{ key: none, val: 'woocommerce_ship_to_destination' },
			rt.ArrayItem{ key: none, val: 'woocommerce_registration_generate_password' },
			rt.ArrayItem{ key: none, val: 'pickup_location_pickup_locations' },
		]),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('checkoutAllowsGuest'),
		rt.identical(rt.new_bool(false), rt.call_function('filter_var', [
			rt.call_method(rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'checkout',
				[]rt.PhpVal{}), 'is_registration_required', []rt.PhpVal{}),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
		]))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('checkoutAllowsSignup'),
		rt.call_function('filter_var', [
			rt.call_method(rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'checkout',
				[]rt.PhpVal{}), 'is_registration_enabled', []rt.PhpVal{}),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('checkoutShowLoginReminder'),
		rt.call_function('filter_var', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_enable_checkout_login_reminder'),
			]),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
		]),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('displayCartPricesIncludingTax'),
		rt.identical(rt.new_string('incl'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		])),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('displayItemizedTaxes'),
		rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_total_display'),
		]))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('forcedBillingAddress'),
		rt.identical(rt.new_string('billing_only'), rt.call_function('get_option', [
			rt.new_string('woocommerce_ship_to_destination'),
		]))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('generatePassword'),
		rt.call_function('filter_var', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_registration_generate_password'),
			]),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('taxesEnabled'),
		rt.call_function('wc_tax_enabled', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('couponsEnabled'),
		rt.call_function('wc_coupons_enabled', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('shippingEnabled'),
		rt.call_function('wc_shipping_enabled', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('hasDarkEditorStyleSupport'),
		rt.call_function('current_theme_supports', [rt.new_string('dark-editor-style')]),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'register_page_id', [if var_attributes_mutated.array_isset(rt.new_string('cartPageId')) {
		var_attributes_mutated.array_get(rt.new_string('cartPageId'))
	} else {
		rt.new_int(0)
	}])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('isBlockTheme'),
		rt.call_function('wp_is_block_theme', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('isCheckoutBlock'),
		rt.new_bool(true)])
	mut iife_temp_11 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_11 := iife_temp_11.get_local_pickup_settings()
	mut var_pickup_location_settings := iife_result_11
	mut iife_temp_12 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_12 := iife_temp_12.get_local_pickup_method_ids()
	mut var_local_pickup_method_ids := iife_result_12
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('localPickupEnabled'),
		var_pickup_location_settings.array_get(rt.new_string('enabled'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('localPickupText'),
		var_pickup_location_settings.array_get(rt.new_string('title'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('localPickupCost'),
		var_pickup_location_settings.array_get(rt.new_string('cost'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('collectableMethodIds'),
		var_local_pickup_method_ids.clone()])
	mut iife_temp_13 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_13 := iife_temp_13.shipping_methods_exist()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add',
		[rt.new_string('shippingMethodsExist'), iife_result_13])
	mut var_is_block_editor := this.is_block_editor()
	if rt.is_true(var_is_block_editor) {
		closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_location := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_string_to_bool', [
				var_location.array_get(rt.new_string('enabled')),
			])))))
			{
				return
			}
			var_location.array_set('formatted_address', rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'countries'), 'get_formatted_address', [
				var_location.array_get(rt.new_string('address')),
				rt.new_string(', '),
			]))
			return
		}
		mut iife_temp_15 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
		mut iife_result_15 := iife_temp_15.get_local_pickup_method_locations()
		closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_location := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_string_to_bool', [
				var_location.array_get(rt.new_string('enabled')),
			])))))
			{
				return
			}
			var_location.array_set('formatted_address', rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'countries'), 'get_formatted_address', [
				var_location.array_get(rt.new_string('address')),
				rt.new_string(', '),
			]))
			return
		}
		closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_location := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_string_to_bool', [
				var_location.array_get(rt.new_string('enabled')),
			])))))
			{
				return
			}
			var_location.array_set('formatted_address', rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'countries'), 'get_formatted_address', [
				var_location.array_get(rt.new_string('address')),
				rt.new_string(', '),
			]))
			return
		}
		mut iife_temp_18 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
		mut iife_result_18 := iife_temp_18.get_local_pickup_method_locations()
		closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_location := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_string_to_bool', [
				var_location.array_get(rt.new_string('enabled')),
			])))))
			{
				return
			}
			var_location.array_set('formatted_address', rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'countries'), 'get_formatted_address', [
				var_location.array_get(rt.new_string('address')),
				rt.new_string(', '),
			]))
			return
		}
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [rt.new_string('localPickupLocations'),
			rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_closure(closure_15_fn), iife_result_15]),
			])])
	}
	if rt.is_true(var_is_block_editor)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'exists', [rt.new_string('globalShippingMethods')]))))) {
		mut var_shipping_methods := rt.call_method(rt.call_method(rt.call_function('WC',
			[]rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{})
		closure_21_fn := fn [var_local_pickup_method_ids] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_method := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_method, 'id'),
				var_local_pickup_method_ids.clone(),
				rt.new_bool(true),
			]))
			{
				return
			}
			if rt.is_true(rt.call_method(var_method, 'supports', [
				rt.new_string('settings'),
			]))
			{
				var_acc.array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.get_property(var_method, 'id') },
					rt.ArrayItem{ key: 'title', val: rt.get_property(var_method, 'method_title') },
					rt.ArrayItem{ key: 'description', val: rt.get_property(var_method,
						'method_description') },
				]))
			}
			return
		}
		mut var_formatted_shipping_methods := rt.call_function('array_reduce', [
			var_shipping_methods.clone(),
			rt.new_closure(closure_21_fn),
			rt.new_array(),
		])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [
			rt.new_string('globalShippingMethods'),
			var_formatted_shipping_methods.clone(),
		])
	}
	if rt.is_true(var_is_block_editor)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'exists', [rt.new_string('activeShippingZones')])))))
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Shipping_Zones')])) {
		mut iife_temp_21 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
		mut iife_result_21 := iife_temp_21.get_shipping_zones()
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [rt.new_string('activeShippingZones'),
			iife_result_21])
	}
	if rt.is_true(var_is_block_editor)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'exists', [rt.new_string('globalPaymentMethods')]))))) {
		mut iife_temp_22 := Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{}
		mut iife_result_22 := iife_temp_22.get_enabled_payment_gateways()
		mut var_payment_methods := iife_result_22
		closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_method := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			var_acc.array_push(rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.get_property(var_method, 'id') },
				rt.ArrayItem{
					key: 'title'
					val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_method,
						'get_method_title', []rt.PhpVal{}), rt.new_string('')))))
					{
						rt.call_method(var_method, 'get_method_title', []rt.PhpVal{})
					} else {
						rt.call_method(var_method, 'get_title', []rt.PhpVal{})
					}
				},
				rt.ArrayItem{
					key: 'description'
					val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_method,
						'get_method_description', []rt.PhpVal{}), rt.new_string('')))))
					{
						rt.call_method(var_method, 'get_method_description', []rt.PhpVal{})
					} else {
						rt.call_method(var_method, 'get_description', []rt.PhpVal{})
					}
				},
			]))
			return
		}
		mut var_formatted_payment_methods := rt.call_function('array_reduce', [
			var_payment_methods.clone(),
			rt.new_closure(closure_24_fn),
			rt.new_array(),
		])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [rt.new_string('globalPaymentMethods'),
			var_formatted_payment_methods.clone()])
	}
	if rt.is_true(var_is_block_editor)
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'exists', [rt.new_string('incompatibleExtensions')]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\Utilities\\FeaturesUtil')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
			return
		}
		mut iife_temp_24 :=
			Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		mut iife_result_24 :=
			iife_temp_24.get_compatible_plugins_for_feature(rt.new_string('cart_checkout_blocks'))
		mut var_declared_extensions := iife_result_24
		mut var_all_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
		closure_26_fn := fn [var_all_plugins] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_item := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut var_plugin := if !(var_all_plugins.array_get(var_item)).is_null() {
				var_all_plugins.array_get(var_item)
			} else {
				rt.new_null()
			}
			mut var_plugin_id := if !(var_plugin.array_get(rt.new_string('TextDomain'))).is_null() { var_plugin.array_get(rt.new_string('TextDomain')) } else { rt.call_function('dirname', [
					var_item.clone(),
				]) }
			mut var_plugin_name := if !(var_plugin.array_get(rt.new_string('Name'))).is_null() {
				var_plugin.array_get(rt.new_string('Name'))
			} else {
				var_plugin_id
			}
			var_acc.array_push(rt.create_array([
				rt.ArrayItem{ key: 'id', val: var_plugin_id },
				rt.ArrayItem{ key: 'title', val: var_plugin_name },
			]))
			return
		}
		mut var_incompatible_extensions := rt.call_function('array_reduce', [
			var_declared_extensions.array_get(rt.new_string('incompatible')),
			rt.new_closure(closure_26_fn),
			rt.new_array(),
		])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [
			rt.new_string('incompatibleExtensions'),
			var_incompatible_extensions.clone(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'hydrate_api_request', [
			rt.new_string('/wc/store/v1/cart'),
		])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'hydrate_data_from_api_request', [
			rt.new_string('checkoutData'),
			rt.new_string('/wc/store/v1/checkout'),
		])
		this.hydrate_customer_payment_methods()
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_blocks_checkout_enqueue_data'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) hydrate_customer_payment_methods() {
	mut iife_temp_26 := Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{}
	mut iife_result_26 := iife_temp_26.get_saved_payment_methods()
	mut var_payment_methods := iife_result_26
	if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_methods))))
		|| rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'exists', [rt.new_string('customerPaymentMethods')])) {
		return
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Checkout', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('customerPaymentMethods'),
		if var_payment_methods.clone().is_array() {
			var_payment_methods.array_get(rt.new_string('enabled'))
		} else {
			rt.new_null()
		}])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout) register_block_type_assets() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.register_block_type_assets()
	mut var_chunks := this.get_chunks_paths(this.chunks_folder)
	mut var_vendor_chunks := this.get_chunks_paths(rt.new_string('vendors--checkout-blocks'))
	mut var_shared_chunks := rt.create_array([
		rt.ArrayItem{
			key: none
			val: 'cart-blocks/cart-express-payment--checkout-blocks/express-payment-frontend'
		},
	])
	this.register_chunk_translations(rt.call_function('array_merge', [
		var_chunks.clone(), var_vendor_chunks.clone(), var_shared_chunks.clone()]))
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout.get_checkout_block_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'Checkout' },
		rt.ArrayItem{ key: none, val: 'CheckoutActionsBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutAdditionalInformationBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutBillingAddressBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutContactInformationBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutExpressPaymentBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutFieldsBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderNoteBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryCartItemsBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryCouponFormBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryDiscountBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryFeeBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryShippingBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummarySubtotalBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryTaxesBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutOrderSummaryTotalsBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutPaymentBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutShippingAddressBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutShippingMethodsBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutShippingMethodBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutPickupOptionsBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutTermsBlock' },
		rt.ArrayItem{ key: none, val: 'CheckoutTotalsBlock' }])
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

struct Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_checkout(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('checkout')
		chunks_folder: rt.new_string('checkout-blocks')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsschema_validation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsSchema_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_block_scanner(_args ...rt.PhpVal) &Class_Automattic_Block_Scanner {
	mut obj := &Class_Automattic_Block_Scanner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_paymentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
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
		'block_name' {
			this.block_name = val
			return true
		}
		'chunks_folder' {
			this.chunks_folder = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
