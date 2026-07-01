import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFields {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('order-confirmation-additional-fields')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFields) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) rt.PhpVal {
	if !var_permission {
		return rt.new_string(content)
	}
	mut var_controller := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
	// unsupported expression: Expr_AssignOp_Concat
	return rt.new_string(content)
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_additionalfields() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFields {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFields{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('order-confirmation-additional-fields')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.render_content(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_additionalfields_php() {
}
