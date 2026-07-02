import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-stock-indicator')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) get_product_types_without_stock_indicator() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.external() },
		rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.grouped() },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('productTypesWithoutStockIndicator'),
		this.get_product_types_without_stock_indicator(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.new_null()
	if !(!rt.is_true(var_content)) {
		this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.register_block_type_assets()
		this.register_chunk_translations(rt.create_array([
			rt.ArrayItem{ key: none, val: this.block_name },
		]))
		return var_content.str()
	}
	mut var_post_id := if rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')) {
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
	} else {
		rt.new_string('')
	}
	mut var_product_to_render := rt.call_function('wc_get_product', [
		var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product_to_render,
		'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product'))))))
	{
		var_product_to_render = var_product
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_to_render))))
		|| rt.is_true(rt.call_function('in_array', [rt.call_method(var_product_to_render, 'get_type', []rt.PhpVal{}), this.get_product_types_without_stock_indicator(), rt.new_bool(true)])) {
		return ''
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils{}
	mut iife_result_0 := iife_temp_0.get_product_availability(var_product_to_render.clone())
	mut var_availability := iife_result_0
	mut var_is_descendant_of_product_collection :=
		rt.new_bool(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('isProductCollectionBlock')))
	mut var_is_descendant_of_grouped_product_selector := rt.new_bool(rt.get_property(var_block,
		'context').array_isset(rt.new_string('isDescendantOfGroupedProductSelector')))
	mut var_is_interactive := rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_product_collection))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_grouped_product_selector))))
		&& rt.is_true(rt.call_method(var_product_to_render, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])))
	if !rt.is_true(var_availability.array_get(rt.new_string('availability')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_interactive)))) {
		return ''
	}
	mut var_total_stock := rt.call_method(var_product_to_render, 'get_stock_quantity',
		[]rt.PhpVal{})
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_1 := iife_temp_1.get_classes_and_styles_by_attributes(var_attributes.clone())
	mut var_classes_and_styles := iife_result_1
	mut var_classnames := rt.new_string((if var_classes_and_styles.array_isset(rt.new_string('classes')) {
		' ' + (var_classes_and_styles.array_get(rt.new_string('classes'))).str() + ' '
	} else {
		''
	}).str())
	var_classnames = rt.concat(var_classnames, rt.call_function('sprintf', [
		rt.new_string(' wc-block-components-product-stock-indicator--%s'),
		var_availability.array_get(rt.new_string('class')),
	]))
	mut var_is_backorder_notification_visible := rt.new_bool(
		rt.is_true(rt.call_method(var_product_to_render, 'is_in_stock', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_product_to_render, 'backorders_require_notification', []rt.PhpVal{})))
	if !rt.is_true(var_content) && rt.is_true(var_is_backorder_notification_visible)
		&& rt.is_true(rt.greater(var_total_stock, rt.new_int(0))) {
		mut var_low_stock_text := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%d left in stock'),
				rt.new_string('woocommerce')]),
			var_total_stock.clone(),
		])
	}
	mut var_wrapper_attributes := rt.new_array()
	mut var_watch_attribute := rt.new_string('')
	if rt.is_true(var_is_interactive)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('out-of-stock'), var_availability.array_get(rt.new_string('class')))))) {
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('woocommerce/product-elements'),
		])
		var_wrapper_attributes.array_set('data-wp-interactive', 'woocommerce/products')
		var_wrapper_attributes.array_set('data-wp-text',
			'state.productInContext.stock_availability.text')
		var_wrapper_attributes.array_set('aria-live', 'polite')
		var_wrapper_attributes.array_set('aria-atomic', 'true')
	}
	mut var_output_text := if !var_low_stock_text.is_null() {
		var_low_stock_text
	} else {
		var_availability.array_get(rt.new_string('availability'))
	}
	mut var_output := rt.new_string('')
	var_output = rt.concat(var_output, rt.new_string(
		'<div class="wc-block-components-product-stock-indicator wp-block-woocommerce-product-stock-indicator ' +
		(rt.call_function('esc_attr', [var_classnames.clone()])).str() + '"'))
	var_output = rt.concat(var_output, if var_classes_and_styles.array_isset(rt.new_string('styles')) {
		' style="' +
			(rt.call_function('esc_attr', [var_classes_and_styles.array_get(rt.new_string('styles'))])).str() +
			'"'
	} else {
		''
	})
	if rt.is_true(var_is_interactive)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('out-of-stock'), var_availability.array_get(rt.new_string('class')))))) {
		var_output = rt.concat(var_output,
			rt.new_string(' ' +(rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.clone()])).str()))
	}
	var_output = rt.concat(var_output, rt.new_string('>'))
	var_output = rt.concat(var_output, rt.call_function('wp_kses_post', [
		var_output_text.clone()]))
	var_output = rt.concat(var_output, rt.new_string('</div>'))
	return var_output.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productstockindicator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-stock-indicator')
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

fn create_automattic_woocommerce_blocks_utils_productavailabilityutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'get_product_types_without_stock_indicator' {
			return this.get_product_types_without_stock_indicator()
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductStockIndicator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
