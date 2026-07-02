import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-quantity-selector')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.get_superglobal('product')
	mut var_previous_product := var_product.clone()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_0 := iife_temp_0.get_product_from_context(var_block.clone(),
		var_previous_product.clone())
	var_product = iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		var_product = var_previous_product.clone()
		return ''
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_1 := iife_temp_1.is_not_purchasable_product(var_product.clone())
	if rt.is_true(iife_result_1) {
		var_product = var_previous_product.clone()
		return ''
	}
	mut var_is_external_product_with_url := rt.new_bool(
		rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product_External')))
		&& rt.is_true(rt.call_method(var_product, 'get_product_url', []rt.PhpVal{})))
	mut var_can_only_be_purchased_one_at_a_time := rt.call_method(var_product,
		'is_sold_individually', []rt.PhpVal{})
	mut var_managing_stock := rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})
	mut var_stock_quantity := rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})
	mut var_allows_backorders := rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{})
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_2 := iife_temp_2.is_min_max_quantity_same(var_product.clone())
	if rt.is_true(iife_result_2) {
		var_product = var_previous_product.clone()
		return ''
	}
	if rt.is_true(var_is_external_product_with_url)
		|| rt.is_true(var_can_only_be_purchased_one_at_a_time)
		|| (rt.is_true(var_managing_stock)
		&& rt.is_true(rt.less_equal(var_stock_quantity, rt.new_int(1)))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_allows_backorders))))) {
		var_product = var_previous_product.clone()
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_quantity_input', [
		rt.create_array([
			rt.ArrayItem{ key: 'min_value', val: rt.call_method(var_product,
				'get_min_purchase_quantity', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'max_value', val: rt.call_method(var_product,
				'get_max_purchase_quantity', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'input_value'
				val: if rt.get_superglobal('_POST').array_isset(rt.new_string('quantity')) {
					rt.call_function('wc_stock_amount', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_POST').array_get(rt.new_string('quantity')),
						]),
					])
				} else {
					rt.call_method(var_product, 'get_min_purchase_quantity', []rt.PhpVal{})
				}
			},
		]),
	])
	mut var_product_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_3 := iife_temp_3.has_visible_quantity_input(var_product_html.clone())
	mut var_has_visible_quantity_input := iife_result_3
	if rt.is_true(var_has_visible_quantity_input) {
		mut var_product_name := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		mut iife_result_4 := iife_temp_4.add_quantity_steppers(var_product_html.clone(),
			var_product_name.clone())
		var_product_html = iife_result_4
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		mut iife_result_5 := iife_temp_5.add_quantity_stepper_classes(var_product_html.clone())
		var_product_html = iife_result_5
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_6 := iife_temp_6.get_classes_and_styles_by_attributes(var_attributes.clone(),
		rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_classes_and_styles := iife_result_6
	mut var_classes := rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'wp-block-add-to-cart-with-options-quantity-selector wc-block-add-to-cart-with-options__quantity-selector'
				},
				rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
					var_classes_and_styles.array_get(rt.new_string('classes')),
				]) },
				rt.ArrayItem{
					key: none
					val: if rt.is_true(var_has_visible_quantity_input) {
						''
					} else {
						'wc-block-add-to-cart-with-options__quantity-selector--hidden'
					}
				},
			]),
		])])
	mut var_wrapper_attributes := rt.create_array([
		rt.ArrayItem{ key: 'class', val: var_classes },
		rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
			var_classes_and_styles.array_get(rt.new_string('styles')),
		]) },
	])
	mut var_input_attributes := rt.new_array()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_7 := iife_temp_7.get_product_quantity_constraints(var_product.clone())
	mut var_product_quantity_constraints := iife_result_7
	if rt.is_true(rt.call_method(var_product, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variable(),
	]))
	{
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('woocommerce/product-elements'),
		])
		var_wrapper_attributes.array_set('data-wp-bind--hidden',
			'woocommerce/add-to-cart-with-options-quantity-selector::!state.allowsQuantityChange')
		var_input_attributes.array_set('data-wp-bind--min',
			'woocommerce/products::state.productInContext.add_to_cart.minimum')
		var_input_attributes.array_set('data-wp-bind--max',
			'woocommerce/products::state.productInContext.add_to_cart.maximum')
		var_input_attributes.array_set('data-wp-bind--step',
			'woocommerce/products::state.productInContext.add_to_cart.multiple_of')
		var_input_attributes.array_set('data-wp-watch',
			'woocommerce/add-to-cart-with-options::callbacks.watchQuantityConstraints')
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_8 := iife_temp_8.make_quantity_input_interactive(var_product_html.clone(),
		var_wrapper_attributes.clone(), var_input_attributes.clone())
	mut var_form := iife_result_8
	var_product = var_previous_product.clone()
	return var_form.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_quantityselector(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-quantity-selector')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
