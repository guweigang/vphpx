import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('checkout-actions-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock.initialize()
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_style_variations' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock) register_style_variations() {
	rt.call_function('register_block_style', [this.get_full_block_name(),
		rt.create_array([rt.ArrayItem{ key: 'name', val: 'without-price' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Hide Price'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'is_default', val: true }])])
	rt.call_function('register_block_style', [this.get_full_block_name(),
		rt.create_array([rt.ArrayItem{ key: 'name', val: 'with-price' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Show Price'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'is_default', val: false }])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_checkoutactionsblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('checkout-actions-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'register_style_variations' {
			this.register_style_variations()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CheckoutActionsBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
