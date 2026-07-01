import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('order-confirmation-additional-fields-wrapper')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	if !var_permission {
		return ''
	}
	mut var_additional_field_values := rt.call_function('array_merge', [
		rt.call_method(rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
			return temp.container()
		}(), 'get', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
		]), 'get_order_additional_fields_with_values', [
			var_order.dup(),
			rt.new_string('contact'),
		]),
		rt.call_method(rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
			return temp.container()
		}(), 'get', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
		]), 'get_order_additional_fields_with_values', [
			var_order.dup(),
			rt.new_string('order'),
		]),
	])
	return if !rt.is_true(var_additional_field_values) { '' } else { content }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array',
		[]string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper', [
		'Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('additionalFields'),
		rt.call_method(rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
			return temp.container()
		}(), 'get', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
		]), 'get_fields_for_location', [
			rt.new_string('order'),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper', [
		'Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('additionalContactFields'),
		rt.call_method(rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Package{}
			return temp.container()
		}(), 'get', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
		]), 'get_fields_for_location', [
			rt.new_string('contact'),
		])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_additionalfieldswrapper() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('order-confirmation-additional-fields-wrapper')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AdditionalFieldsWrapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_additionalfieldswrapper_php() {
}
