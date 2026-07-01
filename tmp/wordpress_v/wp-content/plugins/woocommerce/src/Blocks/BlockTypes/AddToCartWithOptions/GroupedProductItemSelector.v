import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-grouped-product-item-selector')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) set_quantity_input_type() string {
	return 'number'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) get_quantity_selector_markup(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_min_value := rt.call_method(var_product_mutated, 'get_min_purchase_quantity',
		[]rt.PhpVal{})
	mut var_max_value := rt.call_method(var_product_mutated, 'get_max_purchase_quantity',
		[]rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_min_value, var_max_value))
		&& rt.is_true(rt.greater(var_min_value, rt.new_int(0)))))
	{
		rt.call_function('add_filter', [rt.new_string('woocommerce_quantity_input_type'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{ key: none, val: 'set_quantity_input_type' },
			])])
	}
	rt.call_function('woocommerce_quantity_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'input_name', val: 'quantity[' +
				(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).str() + ']' },
			rt.ArrayItem{ key: 'input_id', val: 'quantity_' +
				(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).str() },
			rt.ArrayItem{
				key: 'input_value'
				val: if rt.get_superglobal('_POST').array_get('quantity').array_isset(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})) { rt.call_function('wc_stock_amount', [
						rt.call_function('wc_clean', [
							rt.call_function('wp_unslash', [
								rt.get_superglobal('_POST').array_get('quantity').array_get(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})),
							]),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{ key: 'min_value', val: 0 },
			rt.ArrayItem{ key: 'max_value', val: var_max_value },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_quantity_input_placeholder'),
				rt.new_int(0),
				var_product_mutated.dup(),
			]) },
		]),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_min_value, var_max_value))
		&& rt.is_true(rt.greater(var_min_value, rt.new_int(0)))))
	{
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_quantity_input_type'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{ key: none, val: 'set_quantity_input_type' },
			]),
		])
	}
	mut var_quantity_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_quantity_html = this.remove_quantity_label(var_quantity_html.dup())
	mut var_product_name := rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{})
	var_quantity_html = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.add_quantity_steppers(arg_0, arg_1)
	}(var_quantity_html.dup(), var_product_name.dup())
	var_quantity_html = fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.add_quantity_stepper_classes(arg_0)
	}(var_quantity_html.dup())
	mut var_context := rt.create_array([rt.ArrayItem{ key: 'allowZero', val: true }])
	var_quantity_html = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.make_quantity_input_interactive(arg_0, arg_1, arg_2, arg_3, arg_4)
	}(var_quantity_html.dup(), rt.new_array(), rt.new_array(), var_context.dup(), rt.new_bool(true))
	return var_quantity_html.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) remove_quantity_label(var_quantity_html rt.PhpVal) rt.PhpVal {
	mut var_quantity_html_mutated := var_quantity_html
	var_quantity_html_mutated = rt.call_function('preg_replace', [
		rt.new_string('/<label[^>]*>.*?<\\/label>/s'),
		rt.new_string(''),
		var_quantity_html_mutated.dup(),
	])
	return rt.call_function('preg_replace', [rt.new_string('/\\s*aria-label="[^"]*"/'),
		rt.new_string(''), var_quantity_html_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) get_button_markup(var_product_to_render rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_template_loop_add_to_cart', []rt.PhpVal{})
	mut var_button_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return var_button_html.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) get_checkbox_markup(var_product rt.PhpVal) string {
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})) {
		mut var_label := rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Buy one of %1$s on sale for %2$s, original price was %3$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}),
			]),
			rt.call_function('esc_html', [
				rt.call_function('wp_strip_all_tags', [
					rt.call_function('wc_price', [
						rt.call_method(var_product_mutated, 'get_price', []rt.PhpVal{}),
					]),
				]),
			]),
			rt.call_function('esc_html', [
				rt.call_function('wp_strip_all_tags', [
					rt.call_function('wc_price', [
						rt.call_method(var_product_mutated, 'get_regular_price', []rt.PhpVal{}),
					]),
				]),
			]),
		])
	} else {
		var_label = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [rt.new_string('Buy one of %1$s for %2$s'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [
				rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}),
			]),
			rt.call_function('esc_html', [
				rt.call_function('wp_strip_all_tags', [
					rt.call_function('wc_price', [
						rt.call_method(var_product_mutated, 'get_price', []rt.PhpVal{}),
					]),
				]),
			]),
		])
	}
	mut var_product_context_directive := rt.call_function('wp_interactivity_data_wp_context', [
		rt.create_array([
			rt.ArrayItem{ key: 'productId', val: rt.call_method(var_product_mutated, 'get_id',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'variationId', val: rt.new_null() },
		]),
		rt.new_string('woocommerce/products'),
	])
	return '<input type="checkbox" name="' +
		(rt.call_function('esc_attr', ['quantity[' + (rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).str() +
		']'])).str() + '" value="1" class="wc-grouped-product-add-to-cart-checkbox" id="' +
		(rt.call_function('esc_attr', ['quantity_' + (rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).str()])).str() +
		'" data-wp-interactive="woocommerce/add-to-cart-with-options-quantity-selector" data-wp-on--change="actions.handleQuantityCheckboxChange" ' +
		var_product_context_directive.str() + ' aria-label="' +
		(rt.call_function('esc_attr', [var_label.dup()])).str() + '"/>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	// unsupported statement: Stmt_Global
	mut var_previous_product := var_product.dup()
	mut var_product := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.get_product_from_context(arg_0, arg_1)
	}(var_block.dup(), var_previous_product.dup())
	mut var_markup := rt.new_string(rt.new_string(''))
	if rt.is_true(var_product) {
		mut var_is_interactive := rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{})))))
			|| rt.is_true(rt.call_method(var_product, 'has_options', []rt.PhpVal{}))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{})))))))
		{
			var_markup = this.get_button_markup(var_product.dup())
		} else if rt.is_true(rt.call_method(var_product, 'is_sold_individually', []rt.PhpVal{})) {
			var_is_interactive = rt.new_bool(rt.new_bool(true))
			var_markup = rt.new_string(this.get_checkbox_markup(var_product.dup()))
		} else {
			var_is_interactive = rt.new_bool(rt.new_bool(true))
			var_markup = this.get_quantity_selector_markup(var_product.dup())
		}
		if rt.is_true(var_is_interactive) {
			rt.call_function('wp_enqueue_script_module', [
				rt.new_string('woocommerce/add-to-cart-with-options-quantity-selector'),
			])
		}
		if rt.is_true(var_markup) {
			var_markup = rt.new_string(
				'<div class="wp-block-add-to-cart-with-options-grouped-product-item-selector wc-block-add-to-cart-with-options-grouped-product-item-selector">' +
				var_markup.str() + '</div>')
		}
	}
	var_product = var_previous_product.dup()
	return var_markup.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_groupedproductitemselector() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-grouped-product-item-selector')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_quantity_input_type' {
			return rt.new_string(this.set_quantity_input_type())
		}
		'get_quantity_selector_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_quantity_selector_markup(dispatch_arg_0)
		}
		'remove_quantity_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_quantity_label(dispatch_arg_0)
		}
		'get_button_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_button_markup(dispatch_arg_0)
		}
		'get_checkbox_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_checkbox_markup(dispatch_arg_0))
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemSelector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_addtocartwithoptions_groupedproductitemselector_php() {
	// unsupported statement: Stmt_Declare
}
