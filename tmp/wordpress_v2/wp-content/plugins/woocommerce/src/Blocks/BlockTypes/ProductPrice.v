import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-price')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_post_id := if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	} else {
		rt.new_string('')
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	if rt.is_true(var_product) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		mut iife_result_0 :=
			iife_temp_0.get_classes_and_styles_by_attributes(var_attributes.clone())
		mut var_styles_and_classes := iife_result_0
		mut var_is_descendant_of_product_collection := rt.new_bool(rt.get_property(var_block,
			'context').array_get(rt.new_string('query')).array_isset(rt.new_string('isProductCollectionBlock')))
		mut var_is_descendant_of_grouped_product_selector := rt.new_bool(rt.get_property(var_block,
			'context').array_isset(rt.new_string('isDescendantOfGroupedProductSelector')))
		mut var_is_interactive := rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_product_collection))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_grouped_product_selector))))
			&& rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])))
		if rt.is_true(var_is_interactive) {
			mut var_prices_vary := rt.new_bool(
				rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_product, 'get_variation_sale_price', [rt.new_string('min')]), rt.call_method(var_product, 'get_variation_sale_price', [rt.new_string('max')])))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_product, 'get_variation_regular_price', [rt.new_string('min')]), rt.call_method(var_product, 'get_variation_regular_price', [rt.new_string('max')]))))))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_prices_vary)))) {
				var_is_interactive = rt.new_bool(false)
			}
		}
		mut var_wrapper_attributes := rt.create_array([
			rt.ArrayItem{
				key: 'style'
				val: if !(var_styles_and_classes.array_get(rt.new_string('styles'))).is_null() {
					var_styles_and_classes.array_get(rt.new_string('styles'))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'class'
				val: if !(var_styles_and_classes.array_get(rt.new_string('classes'))).is_null() {
					var_styles_and_classes.array_get(rt.new_string('classes'))
				} else {
					rt.new_string('')
				}
			},
		])
		mut var_interactive_attributes := rt.new_string('')
		mut var_context_directive := rt.new_string('')
		if rt.is_true(var_is_interactive) {
			rt.call_function('wp_enqueue_script_module', [
				rt.new_string('woocommerce/product-elements'),
			])
			var_wrapper_attributes.array_set('data-wp-interactive', 'woocommerce/product-elements')
			var_context_directive = rt.call_function('wp_interactivity_data_wp_context', [
				rt.create_array([
					rt.ArrayItem{ key: 'productElementKey', val: 'price_html' },
				]),
			])
			var_interactive_attributes =
				rt.new_string('data-wp-watch="callbacks.updateValue" aria-live="polite" aria-atomic="true"')
		}
		return rt.call_function('sprintf', [
			rt.new_string('<div %1$s %2$s><div class="wc-block-components-product-price wc-block-grid__product-price" %3$s>\n\t\t\t\t\t%4$s\n\t\t\t\t</div></div>'),
			rt.call_function('get_block_wrapper_attributes', [
				var_wrapper_attributes.clone()]),
			var_context_directive.clone(),
			var_interactive_attributes.clone(),
			rt.call_method(var_product, 'get_price_html', []rt.PhpVal{}),
		])
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productprice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-price')
		api_version:   rt.new_string('3')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductPrice) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'api_version' {
			this.api_version = val
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
