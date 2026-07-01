import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('order-confirmation-billing-address')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	if rt.is_true(rt.new_bool(!var_permission
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_billing_address', []rt.PhpVal{})))))))
	{
		return ''
	}
	mut var_address := rt.new_string('<address>' +
		(rt.call_function('wp_kses_post', [rt.call_method(var_order, 'get_formatted_billing_address', []rt.PhpVal{})])).str() +
		'</address>')
	mut var_phone := rt.new_string(if rt.is_true(rt.call_method(var_order, 'get_billing_phone',
		[]rt.PhpVal{}))
	{
		'<p class="woocommerce-customer-details--phone">' +
			(rt.call_function('esc_html', [rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})])).str() +
			'</p>'
	} else {
		rt.new_string('')
	})
	mut var_controller := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
		return temp.container()
	}(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
	mut var_custom := this.render_additional_fields(rt.call_method(var_controller,
		'get_order_additional_fields_with_values', [var_order.dup(),
		rt.new_string('address'), rt.new_string('billing'), rt.new_string('view')]))
	return var_address.str() + var_phone.str() + var_custom.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array',
		[]string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress', [
		'Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('additionalAddressFields'),
		rt.call_method(rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
			return temp.container()
		}(), 'get', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
		]), 'get_fields_for_location', [
			rt.new_string('address'),
		])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_billingaddress() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('order-confirmation-billing-address')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.render_content(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array](if args.len > 0 {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_BillingAddress) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_billingaddress_php() {
}
