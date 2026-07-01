import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('proceed-to-checkout-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock',
	], &this), 'asset_data_registry'), 'register_page_id', [if var_attributes.array_isset(rt.new_string('checkoutPageId')) {
		var_attributes.array_get('checkoutPageId')
	} else {
		rt.new_int(0)
	}])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_proceedtocheckoutblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('proceed-to-checkout-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProceedToCheckoutBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_proceedtocheckoutblock_php() {
}
