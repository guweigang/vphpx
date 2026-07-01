import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-button')
		cart rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' }, rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal)  {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes_mutated), var_content.dup(), var_block.dup())
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductButton', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'dequeue_add_to_cart_scripts' }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) dequeue_add_to_cart_scripts()  {
	rt.call_function('wp_dequeue_script', [rt.new_string('wc-add-to-cart')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-button')])
	// unsupported statement: Stmt_Global
	mut var_previous_product := var_product.dup()
	mut var_post_id := if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) { rt.get_property(var_block, 'context').array_get('postId') } else { rt.new_string('') }
	mut var_post := if rt.is_true(var_post_id) { rt.call_function('wc_get_product', [var_post_id.dup()]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product'))) {
		mut var_product := var_post.dup()
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product')))))) {
		return ''
	}
	mut var_is_descendant_of_add_to_cart_form := if rt.get_property(var_block, 'context').array_isset(rt.new_string('woocommerce/isDescendantOfAddToCartWithOptions')) { rt.get_property(var_block, 'context').array_get('woocommerce/isDescendantOfAddToCartWithOptions') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(var_is_descendant_of_add_to_cart_form) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}; return temp.is_not_purchasable_product(arg_0) }(var_product.dup())))) {
		var_product = var_previous_product.dup()
		return ''
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{}; return temp.load_cart_state(arg_0) }(rt.new_string('I acknowledge that using private APIs means my theme or plugin will inevitably break in the next version of WooCommerce'))
	mut var_number_of_items_in_cart := rt.new_int(this.get_cart_item_quantities_by_product_id(rt.call_method(var_product, 'get_id', []rt.PhpVal{})))
	mut var_is_product_purchasable := rt.new_bool(this.is_product_purchasable(var_product.dup()))
	mut var_cart_redirect_after_add := rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_cart_redirect_after_add')]), rt.new_string('yes'))
	mut var_ajax_add_to_cart_enabled := rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_enable_ajax_add_to_cart')]), rt.new_string('yes'))
	mut var_is_ajax_button := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_ajax_add_to_cart_enabled) && rt.is_true(rt.call_method(var_product, 'supports', [rt.new_string('ajax_add_to_cart')])))) || rt.is_true(var_is_descendant_of_add_to_cart_form))) && rt.is_true(var_is_product_purchasable))) && rt.is_true(rt.new_bool(!(rt.is_true(var_cart_redirect_after_add))))))
	mut var_html_element := rt.new_string(if rt.is_true(rt.new_bool(rt.is_true(var_is_ajax_button) || rt.is_true(rt.new_bool(rt.is_true(var_is_descendant_of_add_to_cart_form) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()]))))))))) { rt.new_string('button') } else { rt.new_string('a') })
	mut var_styles_and_classes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_and_styles_by_attributes(arg_0, arg_1, arg_2) }(var_attributes_mutated.dup(), rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_classname := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_by_attributes(arg_0, arg_1) }(var_attributes_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_custom_width_classes := rt.new_string(if var_attributes_mutated.array_isset(rt.new_string('width')) { 'has-custom-width wp-block-button__width-' + (var_attributes_mutated.array_get('width')).str() } else { rt.new_string('') })
	mut var_custom_align_classes := rt.new_string(if var_attributes_mutated.array_isset(rt.new_string('textAlign')) { 'align-' + (var_attributes_mutated.array_get('textAlign')).str() } else { rt.new_string('') })
	mut var_html_classes := rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: 'wp-block-button__link' }, rt.ArrayItem{ key: none, val: 'wp-element-button' }, rt.ArrayItem{ key: none, val: 'wc-block-components-product-button__button' }, rt.ArrayItem{ key: none, val: if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{})))) { 'add_to_cart_button' } else { '' } }, rt.ArrayItem{ key: none, val: if rt.is_true(var_is_ajax_button) { 'ajax_add_to_cart' } else { '' } }, rt.ArrayItem{ key: none, val: 'product_type_' + (rt.call_method(var_product, 'get_type', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [var_styles_and_classes.array_get('classes')]) }])])])
	mut var_default_quantity := rt.new_int(rt.new_int(1))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_add_to_cart_form)))) {
		var_default_quantity = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_quantity'), var_default_quantity.dup(), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	}
	mut var_add_to_cart_text := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_method(var_product, 'add_to_cart_text', []rt.PhpVal{}) } else { rt.call_function('__', [rt.new_string('Add to cart'), rt.new_string('woocommerce')]) }
	if rt.is_true(rt.new_bool(rt.is_true(var_is_descendant_of_add_to_cart_form) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_add_to_cart_text = rt.call_method(var_product, 'single_add_to_cart_text', []rt.PhpVal{})
	}
	mut var_context := rt.create_array([rt.ArrayItem{ key: 'quantityToAdd', val: var_default_quantity }, rt.ArrayItem{ key: 'addToCartText', val: var_add_to_cart_text }, rt.ArrayItem{ key: 'tempQuantity', val: var_number_of_items_in_cart }, rt.ArrayItem{ key: 'animationStatus', val: 'IDLE' }, rt.ArrayItem{ key: 'inTheCartText', val: this.get_in_the_cart_text(var_product.dup()) }, rt.ArrayItem{ key: 'noticeId', val: '' }, rt.ArrayItem{ key: 'hasPressedButton', val: false }])
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) {
		var_context.array_set('groupedProductIds', rt.call_method(var_product, 'get_children', []rt.PhpVal{}))
	}
	var_attributes_mutated = rt.create_array([rt.ArrayItem{ key: 'type', val: if rt.is_true(var_is_descendant_of_add_to_cart_form) { 'submit' } else { 'button' } }])
	if rt.is_true(rt.identical(rt.new_string('a'), var_html_element)) {
		var_attributes_mutated = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('esc_url', [rt.call_method(var_product, 'add_to_cart_url', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'rel', val: 'nofollow' }])
		if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) {
			var_attributes_mutated.array_set('target', '_blank')
			var_attributes_mutated.array_set('rel', 'nofollow noopener noreferrer')
		}
	}
	rt.call_function('wp_interactivity_config', [rt.new_string('woocommerce'), rt.create_array([rt.ArrayItem{ key: 'messages', val: rt.create_array([rt.ArrayItem{ key: 'addedToCartText', val: rt.call_function('__', [rt.new_string('Added to cart'), rt.new_string('woocommerce')]) }]) }])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_context := rt.call_function('wp_interactivity_get_context', []rt.PhpVal{})
	mut var_quantity := var_context.array_get('tempQuantity')
	mut var_add_to_cart_text := var_context.array_get('addToCartText')
	return (if rt.is_true(rt.greater(var_quantity, rt.new_int(0))) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s in cart'), rt.new_string('woocommerce')]), var_quantity.dup()]) } else { var_add_to_cart_text }).str()
	}
	rt.call_function('wp_interactivity_state', [rt.new_string('woocommerce/product-button'), rt.create_array([rt.ArrayItem{ key: 'addToCartText', val: rt.new_closure(closure_1_fn) }])])
	mut var_args := rt.call_function('apply_filters', [rt.new_string('woocommerce_loop_add_to_cart_args'), rt.create_array([rt.ArrayItem{ key: 'class', val: var_html_classes }, rt.ArrayItem{ key: 'attributes', val: rt.call_function('array_merge', [var_attributes_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'data-product_id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data-product_sku', val: rt.call_method(var_product, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'aria-label', val: if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_add_to_cart_form)))) || rt.is_true(rt.identical(rt.new_string('simple'), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))))) { rt.call_method(var_product, 'add_to_cart_description', []rt.PhpVal{}) } else { rt.new_null() } }])]) }]), var_product.dup()])
	if var_args.array_get('attributes').array_isset(rt.new_string('aria-label')) {
		var_args.array_get_mut('attributes').array_set('aria-label', rt.call_function('wp_strip_all_tags', [var_args.array_get('attributes').array_get('aria-label')]))
	}
	mut var_div_directives := rt.new_string(rt.new_string('\n\t\t\tdata-wp-interactive="woocommerce/product-button"\n\t\t'))
	mut var_context_directives := rt.call_function('wp_interactivity_data_wp_context', [var_context.dup()])
	mut var_button_directives := rt.new_string(if rt.is_true(var_is_descendant_of_add_to_cart_form) { rt.new_string('data-wp-class--disabled="woocommerce/add-to-cart-with-options::!state.isFormValid"\n\t\t\tdata-wp-bind--hidden="woocommerce/add-to-cart-with-options::!state.allowsAddingToCart"\n\t\t\tdata-wp-on--click="actions.handlePressedState"') } else { rt.new_string('data-wp-on--click="actions.addCartItem"') })
	mut var_anchor_directive := rt.new_string(if rt.is_true(var_is_descendant_of_add_to_cart_form) { rt.new_string('') } else { rt.new_string('data-wp-on--click="woocommerce/product-collection::actions.viewProduct"') })
	mut var_span_button_directives := rt.new_string(rt.new_string('\n\t\t\tdata-wp-text="state.addToCartText"\n\t\t\tdata-wp-class--wc-block-slide-in="state.slideInAnimation"\n\t\t\tdata-wp-class--wc-block-slide-out="state.slideOutAnimation"\n\t\t\tdata-wp-on--animationend="actions.handleAnimationEnd"\n\t\t\tdata-wp-watch="callbacks.startAnimation"\n\t\t\tdata-wp-run="callbacks.syncTempQuantityOnLoad"\n\t\t'))
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: 'wp-block-button wc-block-components-product-button' }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [(var_classname).str() + ' ' + (var_custom_width_classes).str() + ' ' + (var_custom_align_classes).str()]) }])])]) }])])
	mut var_button_classes := if var_args.array_isset(rt.new_string('class')) { rt.call_function('esc_attr', [(var_args.array_get('class')).str() + ' wc-interactive']) } else { rt.new_string('wc-interactive') }
	if rt.is_true(var_is_descendant_of_add_to_cart_form) {
		// unsupported expression: Expr_AssignOp_Concat
		var_args.array_get_mut('attributes').array_set('value', rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
	}
	mut var_html := rt.call_function('strtr', [rt.new_string('<div {wrapper_attributes}\n\t\t\t\t\t{div_directives}\n\t\t\t\t\t{context_directives}\n\t\t\t\t>\n\t\t\t\t\t<{html_element}\n\t\t\t\t\t\tclass="{button_classes}"\n\t\t\t\t\t\tstyle="{button_styles}"\n\t\t\t\t\t\t{attributes}\n\t\t\t\t\t\t{button_directives}\n\t\t\t\t\t>\n\t\t\t\t\t<span {span_button_directives}>{add_to_cart_text}</span>\n\t\t\t\t\t</{html_element}>\n\t\t\t\t\t{view_cart_html}\n\t\t\t\t</div>'), rt.create_array([rt.ArrayItem{ key: '{wrapper_attributes}', val: var_wrapper_attributes }, rt.ArrayItem{ key: '{html_element}', val: var_html_element }, rt.ArrayItem{ key: '{button_classes}', val: var_button_classes }, rt.ArrayItem{ key: '{context_directives}', val: var_context_directives }, rt.ArrayItem{ key: '{button_styles}', val: rt.call_function('esc_attr', [var_styles_and_classes.array_get('styles')]) }, rt.ArrayItem{ key: '{attributes}', val: if var_args.array_isset(rt.new_string('attributes')) { rt.call_function('wc_implode_html_attributes', [var_args.array_get('attributes')]) } else { rt.new_string('') } }, rt.ArrayItem{ key: '{add_to_cart_text}', val: if rt.is_true(var_is_ajax_button) { rt.new_string('') } else { var_add_to_cart_text } }, rt.ArrayItem{ key: '{div_directives}', val: if rt.is_true(var_is_ajax_button) { var_div_directives } else { rt.new_string('') } }, rt.ArrayItem{ key: '{button_directives}', val: if rt.is_true(var_is_ajax_button) { var_button_directives } else { var_anchor_directive } }, rt.ArrayItem{ key: '{span_button_directives}', val: if rt.is_true(var_is_ajax_button) { var_span_button_directives } else { rt.new_string('') } }, rt.ArrayItem{ key: '{view_cart_html}', val: if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_ajax_button) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.has_cart_page() }()))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_add_to_cart_form)))))) { this.get_view_cart_html() } else { rt.new_string('') } }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_add_to_cart_form)))) {
		var_html = rt.call_function('apply_filters', [rt.new_string('woocommerce_loop_add_to_cart_link'), var_html.dup(), var_product.dup(), var_args.dup()])
	}
	var_product = var_previous_product.dup()
	return (var_html).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) get_cart_item_quantities_by_product_id(var_product_id rt.PhpVal) i64 {
	if !(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null()) {
		return 0
	}
	mut var_cart := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_item_quantities', []rt.PhpVal{})
	return (if var_cart.array_isset(var_product_id) { var_cart.array_get(var_product_id) } else { rt.new_int(0) }).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) is_product_purchasable(var_product rt.PhpVal) bool {
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) {
		mut var_grouped_product_ids := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
		if !(!rt.is_true(var_grouped_product_ids)) {
			rt.call_function('_prime_post_caches', [var_grouped_product_ids.dup()])
		}
		{
			mut iter_1 := var_grouped_product_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_child := item_1.val
				mut var_child_product := rt.call_function('wc_get_product', [var_child.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_child_product, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product')))))) {
					continue
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_child_product, 'is_purchasable', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_child_product, 'is_in_stock', []rt.PhpVal{})))) {
					return true
				}
			}
		}
		return false
	}
	return rt.is_true(rt.call_method(var_product_mutated, 'is_purchasable', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) get_in_the_cart_text(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) {
		return rt.call_function('__', [rt.new_string('Added to cart'), rt.new_string('woocommerce')])
	}
	return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s in cart'), rt.new_string('woocommerce')]), rt.new_string('###')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) get_view_cart_html() rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('<span\n\t\t\t\thidden\n\t\t\t\tdata-wp-bind--hidden="!state.displayViewCart"\n\t\t\t>\n\t\t\t\t<a\n\t\t\t\t\thref="%1$s"\n\t\t\t\t\tclass="added_to_cart wc_forward"\n\t\t\t\t\ttitle="%2$s"\n\t\t\t\t>\n\t\t\t\t\t%3$s\n\t\t\t\t</a>\n\t\t\t</span>'), rt.call_function('esc_url', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})]), rt.call_function('esc_attr__', [rt.new_string('View cart'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('View cart'), rt.new_string('woocommerce')])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productbutton() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-button')
		cart: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blockssharedstate() &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{
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

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils() &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'dequeue_add_to_cart_scripts' {
			this.dequeue_add_to_cart_scripts()
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_cart_item_quantities_by_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_cart_item_quantities_by_product_id(dispatch_arg_0))
		}
		'is_product_purchasable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_product_purchasable(dispatch_arg_0))
		}
		'get_in_the_cart_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_in_the_cart_text(dispatch_arg_0)
		}
		'get_view_cart_html' {
			return this.get_view_cart_html()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'cart' { return this.cart }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductButton) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		'cart' { this.cart = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productbutton_php() {
	// unsupported statement: Stmt_Declare
}
