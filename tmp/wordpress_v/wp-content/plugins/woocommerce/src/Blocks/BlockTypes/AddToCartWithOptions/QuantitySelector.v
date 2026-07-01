import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-quantity-selector')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	// unsupported statement: Stmt_Global
	mut var_previous_product := var_product.dup()
	mut var_product := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.get_product_from_context(arg_0, arg_1)
	}(var_block.dup(), var_previous_product.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		var_product = var_previous_product.dup()
		return ''
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.is_not_purchasable_product(arg_0)
	}(var_product.dup()))
	{
		var_product = var_previous_product.dup()
		return ''
	}
	mut var_is_external_product_with_url := rt.new_bool(rt.new_bool(
		rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product_External')))
		&& rt.is_true(rt.call_method(var_product, 'get_product_url', []rt.PhpVal{}))))
	mut var_can_only_be_purchased_one_at_a_time := rt.call_method(var_product,
		'is_sold_individually', []rt.PhpVal{})
	mut var_managing_stock := rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})
	mut var_stock_quantity := rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})
	mut var_allows_backorders := rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{})
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.is_min_max_quantity_same(arg_0)
	}(var_product.dup()))
	{
		var_product = var_previous_product.dup()
		return ''
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_external_product_with_url)
		|| rt.is_true(var_can_only_be_purchased_one_at_a_time)))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_managing_stock)
		&& rt.is_true(rt.less_equal(var_stock_quantity, rt.new_int(1)))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_allows_backorders))))))))
	{
		var_product = var_previous_product.dup()
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
						rt.call_function('wp_unslash',
							[rt.get_superglobal('_POST').array_get('quantity')]),
					])
				} else {
					rt.call_method(var_product, 'get_min_purchase_quantity', []rt.PhpVal{})
				}
			},
		]),
	])
	mut var_product_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_has_visible_quantity_input := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.has_visible_quantity_input(arg_0)
	}(var_product_html.dup())
	if rt.is_true(var_has_visible_quantity_input) {
		mut var_product_name := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
		var_product_html = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
			return temp.add_quantity_steppers(arg_0, arg_1)
		}(var_product_html.dup(), var_product_name.dup())
		var_product_html = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
			return temp.add_quantity_stepper_classes(arg_0)
		}(var_product_html.dup())
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0, arg_1, arg_2)
	}(var_attributes.dup(), rt.new_array(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'extra_classes' },
	]))
	mut var_classes := rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'wp-block-add-to-cart-with-options-quantity-selector wc-block-add-to-cart-with-options__quantity-selector'
				},
				rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
					var_classes_and_styles.array_get('classes'),
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
			var_classes_and_styles.array_get('styles'),
		]) },
	])
	mut var_input_attributes := rt.new_array()
	mut var_product_quantity_constraints := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.get_product_quantity_constraints(arg_0)
	}(var_product.dup())
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
	mut var_form := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.make_quantity_input_interactive(arg_0, arg_1, arg_2)
	}(var_product_html.dup(), var_wrapper_attributes.dup(), var_input_attributes.dup())
	var_product = var_previous_product.dup()
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

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_quantityselector() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_QuantitySelector{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-quantity-selector')
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

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_addtocartwithoptions_quantityselector_php() {
	// unsupported statement: Stmt_Declare
}
