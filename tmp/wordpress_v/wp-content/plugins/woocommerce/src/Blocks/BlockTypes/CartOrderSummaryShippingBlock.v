import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryShippingBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('cart-order-summary-shipping-block')
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_cartordersummaryshippingblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryShippingBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryShippingBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('cart-order-summary-shipping-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryShippingBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryShippingBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryShippingBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_cartordersummaryshippingblock_php() {
}
