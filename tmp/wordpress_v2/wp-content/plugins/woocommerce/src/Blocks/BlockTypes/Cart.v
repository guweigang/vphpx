import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart {
	rt.PhpObjectBase
pub mut:
	block_name    rt.PhpVal = rt.new_string('cart')
	chunks_folder rt.PhpVal = rt.new_string('cart-blocks')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_patterns' },
		])])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'disable_wp_emoji' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) disable_wp_emoji() {
	if rt.is_true(rt.call_function('has_block', [this.get_full_block_name()])) {
		rt.call_function('remove_action', [rt.new_string('wp_head'),
			rt.new_string('print_emoji_detection_script'), rt.new_int(7)])
		rt.call_function('remove_action', [rt.new_string('wp_print_styles'),
			rt.new_string('print_emoji_styles')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) dequeue_woocommerce_core_scripts() {
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-cart')])
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-password-strength-meter')])
	rt.call_function('wp_dequeue_script', [rt.new_string('selectWoo')])
	rt.call_function('wp_dequeue_style', [rt.new_string('select2')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) register_patterns() {
	mut var_shop_permalink := rt.call_function('wc_get_page_permalink', [
		rt.new_string('shop'),
	])
	rt.call_function('register_block_pattern', [
		rt.new_string('woocommerce/cart-heading'),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val:
				'<!-- wp:heading {"align":"wide", "level":1} --><h1 class="wp-block-heading alignwide">' +
				(rt.call_function('esc_html__', [rt.new_string('Cart'), rt.new_string('woocommerce')])).str() +
				'</h1><!-- /wp:heading -->' }]),
	])
	rt.call_function('register_block_pattern', [
		rt.new_string('woocommerce/cart-cross-sells-message'),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val:
				'<!-- wp:heading {"fontSize":"large"} --><h2 class="wp-block-heading has-large-font-size">' +
				(rt.call_function('esc_html__', [rt.new_string('You may be interested in…'), rt.new_string('woocommerce')])).str() +
				'</h2><!-- /wp:heading -->' }]),
	])
	rt.call_function('register_block_pattern', [
		rt.new_string('woocommerce/cart-empty-message'),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val:
				'\n\t\t\t\t\t<!-- wp:heading {"textAlign":"center","className":"with-empty-cart-icon wc-block-cart__empty-cart__title"} --><h2 class="wp-block-heading has-text-align-center with-empty-cart-icon wc-block-cart__empty-cart__title">' +
				(rt.call_function('esc_html__', [rt.new_string('Your cart is currently empty!'), rt.new_string('woocommerce')])).str() +
				'</h2><!-- /wp:heading -->\n\t\t\t\t\t<!-- wp:paragraph {"align":"center"} --><p class="has-text-align-center"><a href="' +
				(rt.call_function('esc_attr', [rt.call_function('esc_url', [var_shop_permalink.clone()])])).str() +
				'">' +
				(rt.call_function('esc_html__', [rt.new_string('Browse store'), rt.new_string('woocommerce')])).str() +
				'</a></p><!-- /wp:paragraph -->\n\t\t\t\t' }]),
	])
	rt.call_function('register_block_pattern', [
		rt.new_string('woocommerce/cart-new-in-store-message'),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val:
				'<!-- wp:heading {"textAlign":"center"} --><h2 class="wp-block-heading has-text-align-center">' +
				(rt.call_function('esc_html__', [rt.new_string('New in store'), rt.new_string('woocommerce')])).str() +
				'</h2><!-- /wp:heading -->' }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block-frontend' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_block_asset_build_path', [
			rt.new_string((this.block_name).str() + '-frontend'),
		]) },
		rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
	])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal) {
	mut var_content_mutated := var_content
	rt.call_function('do_action', [
		rt.new_string('woocommerce_blocks_enqueue_cart_block_scripts_before'),
	])
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes), var_content_mutated.clone(), var_block.clone())
	rt.call_function('do_action', [
		rt.new_string('woocommerce_blocks_enqueue_cart_block_scripts_after'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'dequeue_woocommerce_core_scripts' },
		]),
		rt.new_int(20)])
	mut var_regex_for_filled_cart_block :=
		rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/filled-cart-block"[^>]*?>/mi')
	mut var_has_i1_template := rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		var_regex_for_filled_cart_block.clone(),
		var_content_mutated.clone(),
	]))))
	if rt.is_true(var_has_i1_template) {
		mut var_inner_blocks_html :=
			rt.new_string('$0\n\t\t\t<div data-block-name="woocommerce/filled-cart-block" class="wp-block-woocommerce-filled-cart-block">\n\t\t\t\t<div data-block-name="woocommerce/cart-items-block" class="wp-block-woocommerce-cart-items-block">\n\t\t\t\t\t<div data-block-name="woocommerce/cart-line-items-block" class="wp-block-woocommerce-cart-line-items-block"></div>\n\t\t\t\t</div>\n\t\t\t\t<div data-block-name="woocommerce/cart-totals-block" class="wp-block-woocommerce-cart-totals-block">\n\t\t\t\t\t<div data-block-name="woocommerce/cart-order-summary-block" class="wp-block-woocommerce-cart-order-summary-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/cart-express-payment-block" class="wp-block-woocommerce-cart-express-payment-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/proceed-to-checkout-block" class="wp-block-woocommerce-proceed-to-checkout-block"></div>\n\t\t\t\t\t<div data-block-name="woocommerce/cart-accepted-payment-methods-block" class="wp-block-woocommerce-cart-accepted-payment-methods-block"></div>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t<div data-block-name="woocommerce/empty-cart-block" class="wp-block-woocommerce-empty-cart-block">\n\t\t\t')
		var_content_mutated = rt.call_function('preg_replace', [
			rt.new_string('/<div class="[a-zA-Z0-9_\\- ]*wp-block-woocommerce-cart[a-zA-Z0-9_\\- ]*">/mi'),
			var_inner_blocks_html.clone(),
			var_content_mutated.clone(),
		])
		var_content_mutated = rt.new_string(var_content_mutated.str() + '</div>')
	}
	mut var_order_summary_with_inner_blocks :=
		rt.new_string('$0\n\t\t\t<div data-block-name="woocommerce/cart-order-summary-heading-block" class="wp-block-woocommerce-cart-order-summary-heading-block"></div>\n\t\t\t<div data-block-name="woocommerce/cart-order-summary-subtotal-block" class="wp-block-woocommerce-cart-order-summary-subtotal-block"></div>\n\t\t\t<div data-block-name="woocommerce/cart-order-summary-fee-block" class="wp-block-woocommerce-cart-order-summary-fee-block"></div>\n\t\t\t<div data-block-name="woocommerce/cart-order-summary-discount-block" class="wp-block-woocommerce-cart-order-summary-discount-block"></div>\n\t\t\t<div data-block-name="woocommerce/cart-order-summary-coupon-form-block" class="wp-block-woocommerce-cart-order-summary-coupon-form-block"></div>\n\t\t\t<div data-block-name="woocommerce/cart-order-summary-shipping-form-block" class="wp-block-woocommerce-cart-order-summary-shipping-block"></div>\n\t\t\t<div data-block-name="woocommerce/cart-order-summary-taxes-block" class="wp-block-woocommerce-cart-order-summary-taxes-block"></div>\n\t\t')
	mut var_regex_for_order_summary_subtotal :=
		rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/cart-order-summary-subtotal-block"[^>]*?>/mi')
	mut var_regex_for_order_summary :=
		rt.new_string('/<div[^<]*?data-block-name="woocommerce\\/cart-order-summary-block"[^>]*?>/mi')
	mut var_has_i2_template := rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		var_regex_for_order_summary_subtotal.clone(),
		var_content_mutated.clone(),
	]))))
	if rt.is_true(var_has_i2_template) {
		var_content_mutated = rt.call_function('preg_replace', [
			var_regex_for_order_summary.clone(), var_order_summary_with_inner_blocks.clone(),
			var_content_mutated.clone()])
	}
	return var_content_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_0 := iife_temp_0.get_country_data()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('countryData'), iife_result_0])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('displayItemizedTaxes'),
		rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_total_display'),
		]))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('displayCartPricesIncludingTax'),
		rt.identical(rt.new_string('incl'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		])),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('taxesEnabled'),
		rt.call_function('wc_tax_enabled', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('couponsEnabled'),
		rt.call_function('wc_coupons_enabled', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('shippingEnabled'),
		rt.call_function('wc_shipping_enabled', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('hasDarkEditorStyleSupport'),
		rt.call_function('current_theme_supports', [rt.new_string('dark-editor-style')]),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'register_page_id', [if var_attributes.array_isset(rt.new_string('checkoutPageId')) {
		var_attributes.array_get(rt.new_string('checkoutPageId'))
	} else {
		rt.new_int(0)
	}])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('isBlockTheme'),
		rt.call_function('wp_is_block_theme', []rt.PhpVal{})])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_1 := iife_temp_1.shipping_methods_exist()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('shippingMethodsExist'),
		rt.greater(iife_result_1, rt.new_int(0))])
	mut var_is_block_editor := this.is_block_editor()
	if rt.is_true(var_is_block_editor)
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'exists', [rt.new_string('incompatibleExtensions')]))))) {
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\Utilities\\FeaturesUtil')]))
			&& rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')])) {
			mut iife_temp_2 :=
				Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil{}
			mut iife_result_2 :=
				iife_temp_2.get_compatible_plugins_for_feature(rt.new_string('cart_checkout_blocks'))
			mut var_declared_extensions := iife_result_2
			mut var_all_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
			closure_4_fn := fn [var_all_plugins] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
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
				rt.new_closure(closure_4_fn),
				rt.new_array(),
			])
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this), 'asset_data_registry'), 'add', [
				rt.new_string('incompatibleExtensions'),
				var_incompatible_extensions.clone(),
			])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_Cart', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'hydrate_api_request', [
			rt.new_string('/wc/store/v1/cart'),
		])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_cart_enqueue_data')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) register_block_type_assets() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.register_block_type_assets()
	mut var_chunks := this.get_chunks_paths(this.chunks_folder)
	mut var_vendor_chunks := this.get_chunks_paths(rt.new_string('vendors--cart-blocks'))
	mut var_shared_chunks := rt.new_array()
	this.register_chunk_translations(rt.call_function('array_merge', [
		var_chunks.clone(), var_vendor_chunks.clone(), var_shared_chunks.clone()]))
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart.get_cart_block_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'Cart' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummaryTaxesBlock' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummarySubtotalBlock' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummaryTotalsBlock' },
		rt.ArrayItem{ key: none, val: 'FilledCartBlock' }, rt.ArrayItem{
			key: none
			val: 'EmptyCartBlock'
		}, rt.ArrayItem{ key: none, val: 'CartTotalsBlock' },
		rt.ArrayItem{ key: none, val: 'CartItemsBlock' }, rt.ArrayItem{
			key: none
			val: 'CartLineItemsBlock'
		}, rt.ArrayItem{ key: none, val: 'CartOrderSummaryBlock' },
		rt.ArrayItem{ key: none, val: 'CartExpressPaymentBlock' },
		rt.ArrayItem{ key: none, val: 'ProceedToCheckoutBlock' },
		rt.ArrayItem{ key: none, val: 'CartAcceptedPaymentMethodsBlock' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummaryCouponFormBlock' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummaryDiscountBlock' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummaryFeeBlock' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummaryHeadingBlock' },
		rt.ArrayItem{ key: none, val: 'CartOrderSummaryShippingBlock' },
		rt.ArrayItem{ key: none, val: 'CartCrossSellsBlock' },
		rt.ArrayItem{ key: none, val: 'CartCrossSellsProductsBlock' }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_cart(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('cart')
		chunks_folder: rt.new_string('cart-blocks')
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

fn create_automattic_woocommerce_blocks_blocktypes_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_block_type_assets' {
			this.register_block_type_assets()
			return rt.new_null()
		}
		'get_cart_block_types' {
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart.get_cart_block_types()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'chunks_folder' { return this.chunks_folder }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
