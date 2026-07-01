import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.has_visible_quantity_input(var_html_content rt.PhpVal) bool {
	mut var_processor := create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(var_html_content.dup())
	for rt.is_true(var_processor.next_tag()) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_processor.get_tag(), rt.new_string('INPUT'))) && rt.is_true(var_processor.has_class(rt.new_string('qty'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return true
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.add_quantity_steppers(var_quantity_html rt.PhpVal, var_product_name rt.PhpVal) rt.PhpVal {
	mut var_quantity_html_mutated := var_quantity_html
	mut var_pattern := rt.new_string(rt.new_string('/(<input[^>]*id="quantity_[^"]*"[^>]*\\/>)/'))
	closure_1_fn := fn [var_product_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_matches := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_plus_aria := rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Increase quantity of %s'), rt.new_string('woocommerce')]), var_product_name.dup()])])
	return rt.new_string((var_matches.array_get(1)).str() + '<button aria-label="' + (var_plus_aria).str() + '" type="button" data-wp-on--click="actions.increaseQuantity" data-wp-bind--disabled="!state.allowsIncrease" class="wc-block-components-quantity-selector__button wc-block-components-quantity-selector__button--plus">+</button>')
	}
	mut var_new_html := rt.call_function('preg_replace_callback', [var_pattern.dup(), rt.new_closure(closure_1_fn), if !(var_quantity_html_mutated).is_null() { var_quantity_html_mutated } else { rt.new_string('') }])
	closure_2_fn := fn [var_product_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_matches := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_minus_aria := rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Reduce quantity of %s'), rt.new_string('woocommerce')]), var_product_name.dup()])])
	return rt.new_string((var_matches.array_get(1)).str() + '<button aria-label="' + (var_minus_aria).str() + '" type="button" data-wp-on--click="actions.decreaseQuantity" data-wp-bind--disabled="!state.allowsDecrease" class="wc-block-components-quantity-selector__button wc-block-components-quantity-selector__button--minus">−</button>')
	}
	var_new_html = rt.call_function('preg_replace_callback', [var_pattern.dup(), rt.new_closure(closure_2_fn), if !(var_new_html).is_null() { var_new_html } else { rt.new_string('') }])
	return if !(var_new_html).is_null() { var_new_html } else { rt.new_string('') }
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.add_quantity_stepper_classes(var_quantity_html rt.PhpVal) rt.PhpVal {
	mut var_quantity_html_mutated := var_quantity_html
	mut var_processor := create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(var_quantity_html_mutated.dup())
	for rt.is_true(var_processor.next_tag()) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_processor.get_tag(), rt.new_string('DIV'))) && rt.is_true(var_processor.has_class(rt.new_string('quantity'))))) {
			var_processor.add_class(rt.new_string('wc-block-components-quantity-selector'))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_processor.get_tag(), rt.new_string('INPUT'))) && rt.is_true(var_processor.has_class(rt.new_string('qty'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_processor.add_class(rt.new_string('wc-block-components-quantity-selector__input'))
		}
	}
	return var_processor.get_updated_html()
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.make_quantity_input_interactive(var_quantity_html rt.PhpVal, var_wrapper_attributes rt.PhpVal, var_input_attributes rt.PhpVal, var_context rt.PhpVal, set_product_context bool) rt.PhpVal {
	mut var_product := rt.new_null()
	mut var_quantity_html_mutated := var_quantity_html
	mut var_wrapper_attributes_mutated := var_wrapper_attributes
	mut var_processor := create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(var_quantity_html_mutated.dup())
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(var_set_product_context && rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))))) {
		mut var_product_context := rt.create_array([rt.ArrayItem{ key: 'productId', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variationId', val: rt.new_null() }])
		mut var_products_context := rt.new_string('woocommerce/products::' + (rt.call_function('wp_json_encode', [var_product_context.dup(), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))])).str())
		if rt.is_true(var_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'div' }, rt.ArrayItem{ key: 'class_name', val: 'quantity' }]))) {
			var_processor.set_attribute(rt.new_string('data-wp-context'), var_products_context.dup())
		} else {
			var_processor = create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(var_quantity_html_mutated.dup())
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_processor.next_tag(rt.new_string('input'))) && rt.is_true(rt.identical(var_processor.get_attribute(rt.new_string('type')), rt.new_string('number'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_default_quantity := if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))) { rt.call_method(var_product, 'get_min_purchase_quantity', []rt.PhpVal{}) } else { rt.new_int(1) }
		mut var_input_quantity := if rt.is_true(rt.new_bool(var_context.array_isset(rt.new_string('allowZero')) && rt.is_true(rt.identical(rt.new_bool(true), var_context.array_get('allowZero'))))) { rt.new_int(0) } else { var_default_quantity }
		rt.call_function('wp_interactivity_state', [rt.new_string('woocommerce/add-to-cart-with-options-quantity-selector'), rt.create_array([rt.ArrayItem{ key: 'inputQuantity', val: var_input_quantity }])])
		var_processor.set_attribute(rt.new_string('data-wp-on--blur'), rt.new_string('actions.handleQuantityBlur'))
		var_processor.set_attribute(rt.new_string('data-wp-bind--value'), rt.new_string('state.inputQuantity'))
		{
			mut iter_1 := var_input_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_attribute := item_1.key
				var_processor.set_attribute(var_attribute.dup(), var_value.dup())
			}
		}
	}
	var_quantity_html_mutated = var_processor.get_updated_html()
	var_wrapper_attributes_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/add-to-cart-with-options-quantity-selector' }, rt.ArrayItem{ key: 'data-wp-init', val: 'callbacks.storeInputElementRef' }]), var_wrapper_attributes_mutated.dup()])
	mut var_context_attribute := rt.call_function('wp_interactivity_data_wp_context', [var_context.dup()])
	return rt.call_function('sprintf', [rt.new_string('<div %1$s %2$s>%3$s</div>'), rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes_mutated.dup()]), var_context_attribute.dup(), var_quantity_html_mutated.dup()])
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.get_product_from_context(var_block rt.PhpVal, var_previous_product rt.PhpVal) rt.PhpVal {
	mut var_post_id := if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) { rt.get_property(var_block, 'context').array_get('postId') } else { rt.new_string('') }
	mut var_product := rt.new_null()
	if !(!rt.is_true(var_post_id)) {
		var_product = rt.call_function('wc_get_product', [var_post_id.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product')))))) && rt.is_true(rt.new_bool(rt.instance_of(var_previous_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))))) {
		var_product = var_previous_product
	}
	return if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))) { var_product } else { rt.new_null() }
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.is_not_purchasable_product(var_product rt.PhpVal) bool {
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.simple()])) {
		return rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_purchasable', []rt.PhpVal{})))))
	} else if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
		return rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'has_purchasable_variations', []rt.PhpVal{})))))
	}
	return false
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.render_block_with_context(var_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_block_instance := rt.get_property(var_block, 'parsed_block')
	mut var_new_block := create_wp_block(var_block_instance.dup(), var_context.dup())
	return var_new_block.render(rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }]))
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.is_min_max_quantity_same(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_min_purchase_quantity := rt.call_method(var_product_mutated, 'get_min_purchase_quantity', []rt.PhpVal{})
	mut var_max_purchase_quantity := rt.call_method(var_product_mutated, 'get_max_purchase_quantity', []rt.PhpVal{})
	return rt.identical(var_min_purchase_quantity, var_max_purchase_quantity)
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.get_product_quantity_constraints(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_min := if rt.is_true(rt.new_bool(rt.call_method(var_product_mutated, 'get_min_purchase_quantity', []rt.PhpVal{}).is_long() || rt.call_method(var_product_mutated, 'get_min_purchase_quantity', []rt.PhpVal{}).is_double())) { rt.call_method(var_product_mutated, 'get_min_purchase_quantity', []rt.PhpVal{}) } else { rt.new_int(1) }
	mut var_max_quantity := rt.call_method(var_product_mutated, 'get_max_purchase_quantity', []rt.PhpVal{})
	mut var_max := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_max_quantity.dup().is_long() || var_max_quantity.dup().is_double())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { var_max_quantity } else { rt.new_null() }
	mut var_step := if rt.is_true(rt.new_bool(rt.call_method(var_product_mutated, 'get_purchase_quantity_step', []rt.PhpVal{}).is_long() || rt.call_method(var_product_mutated, 'get_purchase_quantity_step', []rt.PhpVal{}).is_double())) { rt.call_method(var_product_mutated, 'get_purchase_quantity_step', []rt.PhpVal{}) } else { rt.new_int(1) }
	return rt.create_array([rt.ArrayItem{ key: 'min', val: var_min }, rt.ArrayItem{ key: 'max', val: var_max }, rt.ArrayItem{ key: 'step', val: var_step }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block() &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'has_visible_quantity_input' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.has_visible_quantity_input(dispatch_arg_0))
		}
		'add_quantity_steppers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.add_quantity_steppers(dispatch_arg_0, dispatch_arg_1)
		}
		'add_quantity_stepper_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.add_quantity_stepper_classes(dispatch_arg_0)
		}
		'make_quantity_input_interactive' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.make_quantity_input_interactive(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'get_product_from_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.get_product_from_context(dispatch_arg_0, dispatch_arg_1)
		}
		'is_not_purchasable_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.is_not_purchasable_product(dispatch_arg_0))
		}
		'render_block_with_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.render_block_with_context(dispatch_arg_0, dispatch_arg_1)
		}
		'is_min_max_quantity_same' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.is_min_max_quantity_same(dispatch_arg_0)
		}
		'get_product_quantity_constraints' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils.get_product_quantity_constraints(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_addtocartwithoptions_utils_php() {
	// unsupported statement: Stmt_Declare
}
