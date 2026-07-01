import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemLabel {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('add-to-cart-with-options-grouped-product-item-label')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemLabel) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_GLOBALS := rt.new_null()
	mut var_product := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}
		return temp.get_product_from_context(arg_0, arg_1)
	}(var_block.dup(), var_GLOBALS.array_get('product'))
	mut var_markup := rt.new_string(rt.new_string(''))
	if rt.is_true(var_product) {
		mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes',
			[]rt.PhpVal{})
		mut var_title := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{})))))
			|| rt.is_true(rt.call_method(var_product, 'has_options', []rt.PhpVal{}))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{})))))))
		{
			var_markup = rt.call_function('sprintf', [
				rt.new_string('<div %1$s>%2$s</div>'),
				var_wrapper_attributes.dup(),
				rt.call_function('esc_html', [var_title.dup()]),
			])
		} else {
			var_markup = rt.call_function('sprintf', [
				rt.new_string('<label %1$s for="%2$s">%3$s</label>'),
				var_wrapper_attributes.dup(),
				rt.call_function('esc_attr', [
					'quantity_' + (rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str(),
				]),
				rt.call_function('esc_html', [
					var_title.dup(),
				]),
			])
		}
	}
	return var_markup.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_groupedproductitemlabel() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemLabel {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemLabel{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('add-to-cart-with-options-grouped-product-item-label')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemLabel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemLabel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_GroupedProductItemLabel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_addtocartwithoptions_groupedproductitemlabel_php() {
	// unsupported statement: Stmt_Declare
}
