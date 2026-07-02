import rt

struct Class_WC_Deprecated_Action_Hooks {
	rt.PhpObjectBase
pub mut:
	deprecated_hooks   rt.PhpVal = rt.new_array()
	deprecated_version rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Deprecated_Action_Hooks) hook_in(var_hook_name rt.PhpVal) {
	rt.call_function('add_action', [var_hook_name.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Deprecated_Action_Hooks', [
				'WC_Deprecated_Hooks',
			], &this) },
			rt.ArrayItem{ key: none, val: 'maybe_handle_deprecated_hook' },
		]),
		rt.new_int(-1000), rt.new_int(8)])
}

fn (mut this Class_WC_Deprecated_Action_Hooks) handle_deprecated_hook(var_new_hook rt.PhpVal, var_old_hook rt.PhpVal, var_new_callback_args rt.PhpVal, var_return_value rt.PhpVal) rt.PhpVal {
	mut var_return_value_mutated := var_return_value
	if rt.is_true(rt.call_function('has_action', [var_old_hook.clone()])) {
		this.display_notice(var_old_hook.clone(), var_new_hook.clone())
		var_return_value_mutated = this.trigger_hook(var_old_hook.clone(),
			var_new_callback_args.clone())
	}
	return var_return_value_mutated.clone()
}

fn (mut this Class_WC_Deprecated_Action_Hooks) trigger_hook(var_old_hook rt.PhpVal, var_new_callback_args rt.PhpVal) {
	mut switch_val_1 := var_old_hook
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_order_add_shipping')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_order_add_fee'))) {
		mut var_item_id := var_new_callback_args.array_get(rt.new_int(0))
		mut var_item := var_new_callback_args.array_get(rt.new_int(1))
		mut var_order_id := var_new_callback_args.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('is_a', [var_item.clone(), rt.new_string('WC_Order_Item_Shipping')]))
			|| rt.is_true(rt.call_function('is_a', [var_item.clone(), rt.new_string('WC_Order_Item_Fee')])) {
			rt.call_function('do_action', [var_old_hook.clone(),
				var_order_id.clone(), var_item_id.clone(), var_item.clone()])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_order_add_coupon'))) {
		var_item_id = var_new_callback_args.array_get(rt.new_int(0))
		var_item = var_new_callback_args.array_get(rt.new_int(1))
		var_order_id = var_new_callback_args.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('is_a', [var_item.clone(),
			rt.new_string('WC_Order_Item_Coupon')]))
		{
			rt.call_function('do_action', [var_old_hook.clone(),
				var_order_id.clone(), var_item_id.clone(),
				rt.call_method(var_item, 'get_code',
					[]rt.PhpVal{}),
				rt.call_method(var_item, 'get_discount', []rt.PhpVal{}),
				rt.call_method(var_item, 'get_discount_tax', []rt.PhpVal{})])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_order_add_tax'))) {
		var_item_id = var_new_callback_args.array_get(rt.new_int(0))
		var_item = var_new_callback_args.array_get(rt.new_int(1))
		var_order_id = var_new_callback_args.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('is_a', [var_item.clone(),
			rt.new_string('WC_Order_Item_Tax')]))
		{
			rt.call_function('do_action', [var_old_hook.clone(),
				var_order_id.clone(), var_item_id.clone(),
				rt.call_method(var_item, 'get_rate_id',
					[]rt.PhpVal{}),
				rt.call_method(var_item, 'get_tax_total', []rt.PhpVal{}),
				rt.call_method(var_item, 'get_shipping_tax_total', []rt.PhpVal{})])
		}
	} else if rt.is_true(rt.equal(switch_val_1,
		rt.new_string('woocommerce_add_shipping_order_item')))
	{
		var_item_id = var_new_callback_args.array_get(rt.new_int(0))
		var_item = var_new_callback_args.array_get(rt.new_int(1))
		var_order_id = var_new_callback_args.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('is_a', [var_item.clone(),
			rt.new_string('WC_Order_Item_Shipping')]))
		{
			rt.call_function('do_action', [var_old_hook.clone(),
				var_order_id.clone(), var_item_id.clone(),
				rt.get_property(var_item,
					'legacy_package_key')])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_add_order_item_meta'))) {
		var_item_id = var_new_callback_args.array_get(rt.new_int(0))
		var_item = var_new_callback_args.array_get(rt.new_int(1))
		var_order_id = var_new_callback_args.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('is_a', [var_item.clone(),
			rt.new_string('WC_Order_Item_Product')]))
		{
			rt.call_function('do_action', [var_old_hook.clone(),
				var_item_id.clone(), rt.get_property(var_item, 'legacy_values'),
				rt.get_property(var_item, 'legacy_cart_item_key')])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_add_order_fee_meta'))) {
		var_item_id = var_new_callback_args.array_get(rt.new_int(0))
		var_item = var_new_callback_args.array_get(rt.new_int(1))
		var_order_id = var_new_callback_args.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('is_a', [var_item.clone(),
			rt.new_string('WC_Order_Item_Fee')]))
		{
			rt.call_function('do_action', [var_old_hook.clone(),
				var_order_id.clone(), var_item_id.clone(), rt.get_property(var_item, 'legacy_fee'),
				rt.get_property(var_item, 'legacy_fee_key')])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_order_edit_product'))) {
		var_item_id = var_new_callback_args.array_get(rt.new_int(0))
		var_item = var_new_callback_args.array_get(rt.new_int(1))
		var_order_id = var_new_callback_args.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('is_a', [var_item.clone(),
			rt.new_string('WC_Order_Item_Product')]))
		{
			rt.call_function('do_action', [var_old_hook.clone(),
				var_order_id.clone(), var_item_id.clone(), var_item.clone(),
				rt.call_method(var_item, 'get_product', []rt.PhpVal{})])
		}
	} else {
		rt.call_function('do_action_ref_array', [var_old_hook.clone(),
			var_new_callback_args.clone()])
	}
}

struct Class_WC_Deprecated_Hooks {
	rt.PhpObjectBase
}

fn create_wc_deprecated_action_hooks(_args ...rt.PhpVal) &Class_WC_Deprecated_Action_Hooks {
	mut obj := &Class_WC_Deprecated_Action_Hooks{
		PhpObjectBase:      rt.PhpObjectBase{}
		deprecated_hooks:   rt.new_array()
		deprecated_version: rt.new_array()
	}
	return obj
}

fn create_wc_deprecated_hooks(_args ...rt.PhpVal) &Class_WC_Deprecated_Hooks {
	mut obj := &Class_WC_Deprecated_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Deprecated_Action_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hook_in' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.hook_in(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_deprecated_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.handle_deprecated_hook(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'trigger_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.trigger_hook(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Deprecated_Action_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'deprecated_hooks' { return this.deprecated_hooks }
		'deprecated_version' { return this.deprecated_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Deprecated_Action_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'deprecated_hooks' {
			this.deprecated_hooks = val
			return true
		}
		'deprecated_version' {
			this.deprecated_version = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Deprecated_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Deprecated_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Deprecated_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
