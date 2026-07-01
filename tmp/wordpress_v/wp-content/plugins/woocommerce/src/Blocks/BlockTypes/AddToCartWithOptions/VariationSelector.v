import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelector {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-variation-selector')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelector) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_product := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WC_Product'))) && rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.is_not_purchasable_product(arg_0)
	}(var_product.dup())))))))
	{
		mut var_p :=
			create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor(var_content.dup())
		if rt.is_true(var_p.next_tag(rt.create_array([
			rt.ArrayItem{
				key: 'class_name'
				val: 'wp-block-woocommerce-add-to-cart-with-options-variation-selector'
			},
		])))
		{
			var_p.set_attribute(rt.new_string('data-wp-watch'),
				rt.new_string('callbacks.setSelectedVariationId'))
			var_p.set_attribute(rt.new_string('data-wp-watch--validate'),
				rt.new_string('callbacks.validateVariation'))
		}
		return (var_p.get_updated_html()).str()
	}
	return ''
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_variationselector() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelector {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelector{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-variation-selector')
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

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_VariationSelector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_addtocartwithoptions_variationselector_php() {
	// unsupported statement: Stmt_Declare
}
