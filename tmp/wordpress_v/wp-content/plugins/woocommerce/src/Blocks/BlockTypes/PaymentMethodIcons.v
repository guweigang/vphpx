import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('payment-method-icons')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('availablePaymentMethods'),
		this.get_available_payment_methods()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_payment_methods := this.get_available_payment_methods()
	if !rt.is_true(var_payment_methods) {
		return ''
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0)
	}(var_attributes.dup())
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [
				var_classes_and_styles.array_get('classes'),
			]) },
			rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
				var_classes_and_styles.array_get('styles'),
			]) },
		]),
	])
	mut var_output := rt.new_string('<div ' + var_wrapper_attributes.str() + '>')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	return var_output.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) render_payment_method_icons(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_string(rt.new_string(''))
	mut var_all_payment_methods := this.get_available_payment_methods()
	mut var_number_of_icons := if !(var_attributes.array_get('numberOfIcons')).is_null() {
		var_attributes.array_get('numberOfIcons')
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_number_of_icons)) {
		var_number_of_icons = rt.new_int(rt.new_int(var_all_payment_methods.dup().array_count()))
	} else {
		var_number_of_icons = rt.call_function('max', [rt.new_int(0),
			rt.call_function('min', [rt.new_int(var_number_of_icons.dup().to_i64()),
				rt.new_int(var_all_payment_methods.dup().array_count())])])
	}
	if !(!rt.is_true(var_all_payment_methods)) {
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_number_of_icons))) { break
				 }
				mut var_payment_method := var_all_payment_methods.array_get(var_i)
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
				rt.post_inc(var_i)
			}
		}
	}
	return var_output.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) is_woopayments_enabled() bool {
	mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	return var_payment_gateways.array_isset(rt.new_string('woocommerce_payments'))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_payment_gateways.array_get('woocommerce_payments'), 'enabled')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) get_enabled_card_types() rt.PhpVal {
	if !(this.is_woopayments_enabled()) {
		return rt.new_array()
	}
	mut var_card_types := rt.create_array([
		rt.ArrayItem{ key: 'visa', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'Visa' },
			rt.ArrayItem{ key: 'icon', val: this.get_card_type_icon_url(rt.new_string('visa')) },
		]) },
		rt.ArrayItem{ key: 'mastercard', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'Mastercard' },
			rt.ArrayItem{ key: 'icon', val: this.get_card_type_icon_url(rt.new_string('mastercard')) },
		]) },
		rt.ArrayItem{ key: 'amex', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'American Express' },
			rt.ArrayItem{ key: 'icon', val: this.get_card_type_icon_url(rt.new_string('amex')) },
		]) },
		rt.ArrayItem{ key: 'discover', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'Discover' },
			rt.ArrayItem{ key: 'icon', val: this.get_card_type_icon_url(rt.new_string('discover')) },
		]) },
		rt.ArrayItem{ key: 'jcb', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'JCB' },
			rt.ArrayItem{ key: 'icon', val: this.get_card_type_icon_url(rt.new_string('jcb')) },
		]) },
	])
	return var_card_types.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) get_card_type_icon_url(var_card_type rt.PhpVal) rt.PhpVal {
	mut var_assets_path := rt.new_string(rt.new_string('assets/images/payment-methods-cards/'))
	mut var_icon_path := rt.new_string(
		(rt.get_constant('WC_ABSPATH')).str() + var_assets_path.str() + var_card_type.str() + '.svg')
	mut var_icon_url := rt.call_function('plugins_url', [
		var_assets_path.str() + var_card_type.str() + '.svg',
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	return if rt.is_true(rt.call_function('file_exists', [var_icon_path.dup()])) {
		var_icon_url
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) get_other_payment_method_icons() rt.PhpVal {
	mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	mut var_other_payment_methods := rt.new_array()
	if !rt.is_true(var_available_gateways) {
		return var_other_payment_methods.dup()
	}
	{
		mut iter_1 := var_available_gateways.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_gateway := item_1.val
			if rt.is_true(rt.identical(rt.new_string('yes'),
				rt.get_property(var_gateway, 'enabled')))
			{
				if rt.is_true(rt.identical(rt.new_string('woocommerce_payments'), rt.get_property(var_gateway,
					'id')))
				{
					continue
				}
				mut var_icon_url := rt.new_string(rt.new_string(''))
				if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_gateway },
						rt.ArrayItem{ key: none, val: 'get_icon_url' }]),
				]))
				{
					var_icon_url = rt.call_method(var_gateway, 'get_icon_url', []rt.PhpVal{})
				}
				if !(!rt.is_true(var_icon_url)) {
					var_other_payment_methods.array_push(rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.call_method(var_gateway, 'get_title',
							[]rt.PhpVal{}) },
						rt.ArrayItem{ key: 'icon', val: var_icon_url },
					]))
				}
			}
		}
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		return rt.call_function('strcmp', [var_a.array_get('name'),
			var_b.array_get('name')])
	}
	rt.call_function('usort', [var_other_payment_methods.dup(),
		rt.new_closure(closure_1_fn)])
	return var_other_payment_methods.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) get_available_payment_methods() rt.PhpVal {
	mut var_enabled_cards := rt.call_function('array_values', [
		this.get_enabled_card_types(),
	])
	mut var_payment_methods := rt.call_function('array_merge', [
		var_enabled_cards.dup(), this.get_other_payment_method_icons()])
	return var_payment_methods.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_paymentmethodicons() &Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('payment-method-icons')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'render_payment_method_icons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_payment_method_icons(dispatch_arg_0)
		}
		'is_woopayments_enabled' {
			return rt.new_bool(this.is_woopayments_enabled())
		}
		'get_enabled_card_types' {
			return this.get_enabled_card_types()
		}
		'get_card_type_icon_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_card_type_icon_url(dispatch_arg_0)
		}
		'get_other_payment_method_icons' {
			return this.get_other_payment_method_icons()
		}
		'get_available_payment_methods' {
			return this.get_available_payment_methods()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_PaymentMethodIcons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_paymentmethodicons_php() {
	// unsupported statement: Stmt_Declare
}
