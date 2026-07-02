import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-sku')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
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
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var_product_sku := rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_sku)))) {
		return ''
	}
	mut var_is_descendant_of_product_collection :=
		rt.new_bool(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('isProductCollectionBlock')))
	mut var_is_interactive := rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(var_is_descendant_of_product_collection))))
		&& rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])))
	if rt.is_true(var_is_interactive) {
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('woocommerce/product-elements'),
		])
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_0 := iife_temp_0.get_classes_and_styles_by_attributes(var_attributes.clone())
	mut var_styles_and_classes := iife_result_0
	mut var_prefix := if var_attributes.array_isset(rt.new_string('prefix')) { rt.call_function('wp_kses_post', [
			var_attributes.array_get(rt.new_string('prefix')),
		]) } else { rt.call_function('__', [rt.new_string('SKU: '),
			rt.new_string('woocommerce')]) }
	if !(!rt.is_true(var_prefix)) {
		var_prefix = rt.call_function('sprintf', [
			rt.new_string('<span class="wp-block-post-terms__prefix">%s</span>'),
			var_prefix.clone(),
		])
	}
	mut var_suffix := if var_attributes.array_isset(rt.new_string('suffix')) { rt.call_function('wp_kses_post', [
			var_attributes.array_get(rt.new_string('suffix')),
		]) } else { rt.new_string('') }
	if !(!rt.is_true(var_suffix)) {
		var_suffix = rt.call_function('sprintf', [
			rt.new_string('<span class="wp-block-post-terms__suffix">%s</span>'),
			var_suffix.clone(),
		])
	}
	mut var_interactive_attributes := rt.new_string((if rt.is_true(var_is_interactive) {
		'data-wp-interactive="woocommerce/products" data-wp-text="state.productInContext.sku"'
	} else {
		''
	}).str())
	return (rt.call_function('sprintf', [
		rt.new_string('<div class="wc-block-components-product-sku wc-block-grid__product-sku wp-block-woocommerce-product-sku product_meta wp-block-post-terms %1$s" style="%2$s">\n\t\t\t\t%3$s\n\t\t\t\t<span class="sku" %4$s>%5$s</span>\n\t\t\t\t%6$s\n\t\t\t</div>'),
		rt.call_function('esc_attr', [var_styles_and_classes.array_get(rt.new_string('classes'))]),
		rt.call_function('esc_attr', [if !(var_styles_and_classes.array_get(rt.new_string('styles'))).is_null() {
			var_styles_and_classes.array_get(rt.new_string('styles'))
		} else {
			rt.new_string('')
		}]),
		var_prefix.clone(),
		var_interactive_attributes.clone(),
		var_product_sku.clone(),
		var_suffix.clone(),
	])).str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productsku(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-sku')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSKU) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
