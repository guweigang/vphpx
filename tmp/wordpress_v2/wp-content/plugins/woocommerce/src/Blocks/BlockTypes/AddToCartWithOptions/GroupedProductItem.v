import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-grouped-product-item')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem) set_is_descendant_of_grouped_product_selector_context(var_context rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	if rt.is_true(rt.identical(rt.new_string('woocommerce/product-price'), var_block.array_get(rt.new_string('blockName'))))
		|| rt.is_true(rt.identical(rt.new_string('woocommerce/product-stock-indicator'), var_block.array_get(rt.new_string('blockName')))) {
		var_context_mutated.array_set('isDescendantOfGroupedProductSelector', true)
	}
	return var_context_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem) get_product_row(var_product_id rt.PhpVal, var_attributes rt.PhpVal, var_block rt.PhpVal) string {
	mut var_post := rt.get_superglobal('post')
	mut var_product := rt.get_superglobal('product')
	mut var_previous_post := var_post.clone()
	mut var_previous_product := var_product.clone()
	var_post = rt.call_function('get_post', [var_product_id.clone()])
	var_product = rt.call_function('wc_get_product', [var_product_id.clone()])
	rt.call_function('add_filter', [rt.new_string('render_block_context'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_is_descendant_of_grouped_product_selector_context' },
		]),
		rt.new_int(10), rt.new_int(2)])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
	mut iife_result_0 := iife_temp_0.render_block_with_context(var_block.clone(), rt.create_array([
		rt.ArrayItem{ key: 'postType', val: 'product' },
		rt.ArrayItem{ key: 'postId', val: rt.get_property(var_post, 'ID') },
	]))
	mut var_block_content := iife_result_0
	rt.call_function('remove_filter', [rt.new_string('render_block_context'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_is_descendant_of_grouped_product_selector_context' },
		])])
	var_post = var_previous_post.clone()
	var_product = var_previous_product.clone()
	return var_block_content.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.new_null()
	mut var_content_mutated := var_content
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product_Grouped'))))))
	{
		return ''
	}
	var_content_mutated = rt.new_string('')
	mut var_children := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('wc_get_product'),
			rt.call_method(var_product, 'get_children', []rt.PhpVal{})]),
		rt.new_string('wc_products_array_filter_visible_grouped'),
	])
	mut iter_1 := var_children.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_child := item_1.val
		var_content_mutated = rt.concat(var_content_mutated, this.get_product_row(rt.call_method(var_child,
			'get_id', []rt.PhpVal{}), var_attributes.clone(), var_block.clone()))
	}
	return var_content_mutated.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_groupedproductitem(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-grouped-product-item')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_is_descendant_of_grouped_product_selector_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_is_descendant_of_grouped_product_selector_context(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_product_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.get_product_row(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItem) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
