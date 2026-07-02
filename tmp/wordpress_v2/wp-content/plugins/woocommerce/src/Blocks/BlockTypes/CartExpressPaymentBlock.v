import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CartExpressPaymentBlock {
	rt.PhpObjectBase
pub mut:
	block_name     rt.PhpVal = rt.new_string('cart-express-payment-block')
	default_styles rt.PhpVal = rt.new_null()
	current_styles rt.PhpVal = rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_cartexpresspaymentblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartExpressPaymentBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartExpressPaymentBlock{
		PhpObjectBase:  rt.PhpObjectBase{}
		block_name:     rt.new_string('cart-express-payment-block')
		default_styles: rt.new_null()
		current_styles: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartExpressPaymentBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartExpressPaymentBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'default_styles' { return this.default_styles }
		'current_styles' { return this.current_styles }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartExpressPaymentBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'default_styles' {
			this.default_styles = val
			return true
		}
		'current_styles' {
			this.current_styles = val
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
