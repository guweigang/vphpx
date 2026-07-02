import rt

struct Class_WC_Abstract_Legacy_Order {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_coupon(var_code rt.PhpVal, discount i64, discount_tax i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_coupon'),
		rt.new_string('3.0'),
		rt.new_string('a new WC_Order_Item_Coupon object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_coupon()
	rt.call_method(var_item, 'set_props', [
		rt.create_array([rt.ArrayItem{ key: 'code', val: var_code },
			rt.ArrayItem{ key: 'discount', val: discount }, rt.ArrayItem{
				key: 'discount_tax'
				val: discount_tax
			}, rt.ArrayItem{ key: 'order_id', val: this.get_id() }]),
	])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.clone())
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('woocommerce_order_add_coupon'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() },
			rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: var_code }, rt.ArrayItem{ key: none, val: discount },
			rt.ArrayItem{ key: none, val: discount_tax }]),
		rt.new_string('3.0'),
		rt.new_string('woocommerce_new_order_item action instead.'),
	])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_tax(var_tax_rate_id rt.PhpVal, tax_amount i64, shipping_tax_amount i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_tax'),
		rt.new_string('3.0'),
		rt.new_string('a new WC_Order_Item_Tax object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_tax()
	rt.call_method(var_item, 'set_props', [
		rt.create_array([rt.ArrayItem{ key: 'rate_id', val: var_tax_rate_id },
			rt.ArrayItem{ key: 'tax_total', val: tax_amount },
			rt.ArrayItem{ key: 'shipping_tax_total', val: shipping_tax_amount }]),
	])
	rt.call_method(var_item, 'set_rate', [var_tax_rate_id.clone()])
	rt.call_method(var_item, 'set_order_id', [this.get_id()])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.clone())
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('woocommerce_order_add_tax'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() },
			rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: var_tax_rate_id }, rt.ArrayItem{
				key: none
				val: tax_amount
			}, rt.ArrayItem{ key: none, val: shipping_tax_amount }]),
		rt.new_string('3.0'),
		rt.new_string('woocommerce_new_order_item action instead.'),
	])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_shipping(var_shipping_rate rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_shipping'),
		rt.new_string('3.0'),
		rt.new_string('a new WC_Order_Item_Shipping object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_shipping()
	rt.call_method(var_item, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'method_title', val: rt.get_property(var_shipping_rate, 'label') },
			rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_shipping_rate, 'id') },
			rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [
				rt.get_property(var_shipping_rate, 'cost'),
			]) },
			rt.ArrayItem{ key: 'taxes', val: rt.get_property(var_shipping_rate, 'taxes') },
			rt.ArrayItem{ key: 'order_id', val: this.get_id() },
		]),
	])
	mut iter_1 := rt.call_method(var_shipping_rate, 'get_meta_data', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		rt.call_method(var_item, 'add_meta_data', [var_key.clone(),
			var_value.clone(), rt.new_bool(true)])
	}
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.clone())
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('woocommerce_order_add_shipping'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() },
			rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: var_shipping_rate }]),
		rt.new_string('3.0'),
		rt.new_string('woocommerce_new_order_item action instead.'),
	])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_fee(var_fee rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_fee'),
		rt.new_string('3.0'),
		rt.new_string('a new WC_Order_Item_Fee object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_fee()
	rt.call_method(var_item, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_fee, 'name') },
			rt.ArrayItem{
				key: 'tax_class'
				val: if rt.is_true(rt.get_property(var_fee, 'taxable')) {
					rt.get_property(var_fee, 'tax_class')
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{ key: 'total', val: rt.get_property(var_fee, 'amount') },
			rt.ArrayItem{ key: 'total_tax', val: rt.get_property(var_fee, 'tax') },
			rt.ArrayItem{ key: 'taxes', val: rt.create_array([
				rt.ArrayItem{ key: 'total', val: rt.get_property(var_fee, 'tax_data') },
			]) },
			rt.ArrayItem{ key: 'order_id', val: this.get_id() },
		]),
	])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.clone())
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('woocommerce_order_add_fee'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() },
			rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: var_fee }]),
		rt.new_string('3.0'),
		rt.new_string('woocommerce_new_order_item action instead.'),
	])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_product(var_item rt.PhpVal, var_product rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_product_mutated := var_product
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::update_product'),
		rt.new_string('3.0'),
		rt.new_string('an interaction with the WC_Order_Item_Product class'),
	])
	if rt.is_true(rt.new_bool(var_item_mutated.clone().is_long()
		|| var_item_mutated.clone().is_double()))
	{
		var_item_mutated = this.get_item(var_item_mutated.clone())
	}
	if !(var_item_mutated.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('line_item')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
	}
	if var_args_mutated.array_isset(rt.new_string('totals')) {
		mut iter_2 := var_args_mutated.array_get(rt.new_string('totals')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			if rt.is_true(rt.identical(rt.new_string('tax'), var_key)) {
				var_args_mutated.array_set('total_tax', var_value.clone())
			} else if rt.is_true(rt.identical(rt.new_string('tax_data'), var_key)) {
				var_args_mutated.array_set('taxes', var_value.clone())
			} else {
				var_args_mutated.array_set(var_key, var_value.clone())
			}
		}
	}
	if var_args_mutated.array_isset(rt.new_string('qty')) {
		if rt.is_true(rt.call_method(var_product_mutated, 'backorders_require_notification', []rt.PhpVal{}))
			&& rt.is_true(rt.call_method(var_product_mutated, 'is_on_backorder', [var_args_mutated.array_get(rt.new_string('qty'))])) {
			rt.call_method(var_item_mutated, 'add_meta_data', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_backordered_item_meta_name'),
					rt.call_function('__', [rt.new_string('Backordered'),
						rt.new_string('woocommerce')]),
					var_item_mutated.clone(),
				]),
				rt.sub(var_args_mutated.array_get(rt.new_string('qty')), rt.call_function('max', [
					rt.new_int(0),
					rt.call_method(var_product_mutated, 'get_stock_quantity', []rt.PhpVal{}),
				])),
				rt.new_bool(true),
			])
		}
		var_args_mutated.array_set('subtotal', if rt.is_true(var_args_mutated.array_get(rt.new_string('subtotal'))) { var_args_mutated.array_get(rt.new_string('subtotal')) } else { rt.call_function('wc_get_price_excluding_tax', [
				var_product_mutated.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'qty', val: var_args_mutated.array_get(rt.new_string('qty')) },
				]),
			]) })
		var_args_mutated.array_set('total', if rt.is_true(var_args_mutated.array_get(rt.new_string('total'))) { var_args_mutated.array_get(rt.new_string('total')) } else { rt.call_function('wc_get_price_excluding_tax', [
				var_product_mutated.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'qty', val: var_args_mutated.array_get(rt.new_string('qty')) },
				]),
			]) })
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.clone()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_edit_product'),
		this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}),
		var_args_mutated.clone(), var_product_mutated.clone()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_coupon(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_coupon'),
		rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Coupon class')])
	if rt.is_true(rt.new_bool(var_item_mutated.clone().is_long()
		|| var_item_mutated.clone().is_double()))
	{
		var_item_mutated = this.get_item(var_item_mutated.clone())
	}
	if !(var_item_mutated.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('coupon')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
	}
	if var_args_mutated.array_isset(rt.new_string('discount_amount')) {
		var_args_mutated.array_set('discount',
			var_args_mutated.array_get(rt.new_string('discount_amount')))
	}
	if var_args_mutated.array_isset(rt.new_string('discount_amount_tax')) {
		var_args_mutated.array_set('discount_tax',
			var_args_mutated.array_get(rt.new_string('discount_amount_tax')))
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.clone()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_coupon'),
		this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}),
		var_args_mutated.clone()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_shipping(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::update_shipping'),
		rt.new_string('3.0'),
		rt.new_string('an interaction with the WC_Order_Item_Shipping class'),
	])
	if rt.is_true(rt.new_bool(var_item_mutated.clone().is_long()
		|| var_item_mutated.clone().is_double()))
	{
		var_item_mutated = this.get_item(var_item_mutated.clone())
	}
	if !(var_item_mutated.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('shipping')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
	}
	if var_args_mutated.array_isset(rt.new_string('cost')) {
		var_args_mutated.array_set('total', var_args_mutated.array_get(rt.new_string('cost')))
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.clone()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	this.calculate_shipping()
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_shipping'),
		this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}),
		var_args_mutated.clone()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_fee(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_fee'),
		rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Fee class')])
	if rt.is_true(rt.new_bool(var_item_mutated.clone().is_long()
		|| var_item_mutated.clone().is_double()))
	{
		var_item_mutated = this.get_item(var_item_mutated.clone())
	}
	if !(var_item_mutated.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('fee')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.clone()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_fee'),
		this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}),
		var_args_mutated.clone()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_tax(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_tax'),
		rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Tax class')])
	if rt.is_true(rt.new_bool(var_item_mutated.clone().is_long()
		|| var_item_mutated.clone().is_double()))
	{
		var_item_mutated = this.get_item(var_item_mutated.clone())
	}
	if !(var_item_mutated.clone().is_object())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('tax')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.clone()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_tax'),
		this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}),
		var_args_mutated.clone()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_product_from_item(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Abstract_Legacy_Order::get_product_from_item'),
		rt.new_string('4.4.0'),
		rt.new_string('$item->get_product()'),
	])
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated },
			rt.ArrayItem{ key: none, val: 'get_product' }]),
	]))
	{
		mut var_product := rt.call_method(var_item_mutated, 'get_product', []rt.PhpVal{})
	} else {
		var_product = rt.new_bool(false)
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_product_from_item'),
		var_product.clone(),
		var_item_mutated.clone(),
		rt.new_object('WC_Abstract_Legacy_Order', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Order) set_address(var_address rt.PhpVal, type string) {
	mut iter_3 := var_address.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		rt.call_function('update_post_meta', [this.get_id(),
			rt.new_string('_${var_type}_' + var_key.str()), var_value.clone()])
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Abstract_Legacy_Order', [
					'WC_Data',
				], &this) },
				rt.ArrayItem{ key: none, val: 'set_${var_type}_${var_key.to_string()}' },
			]),
		]))
		{
			rt.call_method(rt.new_object('WC_Abstract_Legacy_Order', ['WC_Data'], &this),
				'set_${var_type}_${var_key.to_string()}', [var_value.clone()])
		}
	}
}

fn (mut this Class_WC_Abstract_Legacy_Order) legacy_set_total(var_amount rt.PhpVal, total_type string) bool {
	mut var_amount_mutated := var_amount
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(total_type),
		rt.create_array([rt.ArrayItem{ key: none, val: 'shipping' },
			rt.ArrayItem{ key: none, val: 'tax' }, rt.ArrayItem{ key: none, val: 'shipping_tax' },
			rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'cart_discount' },
			rt.ArrayItem{ key: none, val: 'cart_discount_tax' }]),
	])))))
	{
		return false
	}
	mut switch_val_1 := rt.new_string(total_type)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('total'))) {
		var_amount_mutated = rt.call_function('wc_format_decimal', [
			var_amount_mutated.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
		this.set_total(var_amount_mutated.clone())
		rt.call_function('update_post_meta', [this.get_id(), rt.new_string('_order_total'),
			var_amount_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cart_discount'))) {
		var_amount_mutated = rt.call_function('wc_format_decimal', [
			var_amount_mutated.clone()])
		this.set_discount_total(var_amount_mutated.clone())
		rt.call_function('update_post_meta', [this.get_id(), rt.new_string('_cart_discount'),
			var_amount_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cart_discount_tax'))) {
		var_amount_mutated = rt.call_function('wc_format_decimal', [
			var_amount_mutated.clone()])
		this.set_discount_tax(var_amount_mutated.clone())
		rt.call_function('update_post_meta', [this.get_id(), rt.new_string('_cart_discount_tax'),
			var_amount_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping'))) {
		var_amount_mutated = rt.call_function('wc_format_decimal', [
			var_amount_mutated.clone()])
		this.set_shipping_total(var_amount_mutated.clone())
		rt.call_function('update_post_meta', [this.get_id(), rt.new_string('_order_shipping'),
			var_amount_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_tax'))) {
		var_amount_mutated = rt.call_function('wc_format_decimal', [
			var_amount_mutated.clone()])
		this.set_shipping_tax(var_amount_mutated.clone())
		rt.call_function('update_post_meta', [this.get_id(), rt.new_string('_order_shipping_tax'),
			var_amount_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax'))) {
		var_amount_mutated = rt.call_function('wc_format_decimal', [
			var_amount_mutated.clone()])
		this.set_cart_tax(var_amount_mutated.clone())
		rt.call_function('update_post_meta', [this.get_id(), rt.new_string('_order_tax'),
			var_amount_mutated.clone()])
	}
	return true
}

fn (mut this Class_WC_Abstract_Legacy_Order) magic_isset(var_key rt.PhpVal) bool {
	mut var_legacy_props := ['completed_date', 'id', 'order_type', 'post', 'status', 'post_status',
		'customer_note', 'customer_message', 'user_id', 'customer_user', 'prices_include_tax',
		'tax_display_cart', 'display_totals_ex_tax', 'display_cart_ex_tax', 'order_date',
		'modified_date', 'cart_discount', 'cart_discount_tax', 'order_shipping', 'order_shipping_tax',
		'order_total', 'order_tax', 'billing_first_name', 'billing_last_name', 'billing_company',
		'billing_address_1', 'billing_address_2', 'billing_city', 'billing_state', 'billing_postcode',
		'billing_country', 'billing_phone', 'billing_email', 'shipping_first_name',
		'shipping_last_name', 'shipping_company', 'shipping_address_1', 'shipping_address_2',
		'shipping_city', 'shipping_state', 'shipping_postcode', 'shipping_country',
		'customer_ip_address', 'customer_user_agent', 'payment_method_title', 'payment_method',
		'order_currency']
	return if rt.is_true(this.get_id()) {
			rt.is_true(rt.call_function('in_array', [var_key.clone(), rt.create_array_from_list(var_legacy_props)]))
			|| rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), this.get_id(), rt.new_string('_' + var_key.str())]))
	} else {
		false
	}
}

fn (mut this Class_WC_Abstract_Legacy_Order) magic_get(var_key rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_doing_it_wrong', [var_key.clone(),
		rt.new_string('Order properties should not be accessed directly.'),
		rt.new_string('3.0')])
	if rt.is_true(rt.identical(rt.new_string('completed_date'), var_key)) {
		return if rt.is_true(this.get_date_completed()) { rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(this.get_date_completed(), 'getOffsetTimestamp', []rt.PhpVal{}),
			]) } else { rt.new_string('') }
	} else if rt.is_true(rt.identical(rt.new_string('paid_date'), var_key)) {
		return if rt.is_true(this.get_date_paid()) { rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(this.get_date_paid(), 'getOffsetTimestamp', []rt.PhpVal{}),
			]) } else { rt.new_string('') }
	} else if rt.is_true(rt.identical(rt.new_string('modified_date'), var_key)) {
		return if rt.is_true(this.get_date_modified()) { rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(this.get_date_modified(), 'getOffsetTimestamp', []rt.PhpVal{}),
			]) } else { rt.new_string('') }
	} else if rt.is_true(rt.identical(rt.new_string('order_date'), var_key)) {
		return if rt.is_true(this.get_date_created()) { rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(this.get_date_created(), 'getOffsetTimestamp', []rt.PhpVal{}),
			]) } else { rt.new_string('') }
	} else if rt.is_true(rt.identical(rt.new_string('id'), var_key)) {
		return this.get_id()
	} else if rt.is_true(rt.identical(rt.new_string('post'), var_key)) {
		return rt.call_function('get_post', [this.get_id()])
	} else if rt.is_true(rt.identical(rt.new_string('status'), var_key)) {
		return this.get_status()
	} else if rt.is_true(rt.identical(rt.new_string('post_status'), var_key)) {
		return rt.call_function('get_post_status', [this.get_id()])
	} else if rt.is_true(rt.identical(rt.new_string('customer_message'), var_key))
		|| rt.is_true(rt.identical(rt.new_string('customer_note'), var_key)) {
		return this.get_customer_note()
	} else if rt.is_true(rt.call_function('in_array', [var_key.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'user_id' },
			rt.ArrayItem{ key: none, val: 'customer_user' }])]))
	{
		return this.get_customer_id()
	} else if rt.is_true(rt.identical(rt.new_string('tax_display_cart'), var_key)) {
		return rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		])
	} else if rt.is_true(rt.identical(rt.new_string('display_totals_ex_tax'), var_key)) {
		return rt.identical(rt.new_string('excl'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		]))
	} else if rt.is_true(rt.identical(rt.new_string('display_cart_ex_tax'), var_key)) {
		return rt.identical(rt.new_string('excl'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		]))
	} else if rt.is_true(rt.identical(rt.new_string('cart_discount'), var_key)) {
		return this.get_total_discount()
	} else if rt.is_true(rt.identical(rt.new_string('cart_discount_tax'), var_key)) {
		return this.get_discount_tax()
	} else if rt.is_true(rt.identical(rt.new_string('order_tax'), var_key)) {
		return this.get_cart_tax()
	} else if rt.is_true(rt.identical(rt.new_string('order_shipping_tax'), var_key)) {
		return this.get_shipping_tax()
	} else if rt.is_true(rt.identical(rt.new_string('order_shipping'), var_key)) {
		return this.get_shipping_total()
	} else if rt.is_true(rt.identical(rt.new_string('order_total'), var_key)) {
		return this.get_total()
	} else if rt.is_true(rt.identical(rt.new_string('order_type'), var_key)) {
		return this.get_type()
	} else if rt.is_true(rt.identical(rt.new_string('order_currency'), var_key)) {
		return this.get_currency()
	} else if rt.is_true(rt.identical(rt.new_string('order_version'), var_key)) {
		return this.get_version()
	} else if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Abstract_Legacy_Order', [
				'WC_Data',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_${var_key.to_string()}' },
		]),
	]))
	{
		return rt.call_method(rt.new_object('WC_Abstract_Legacy_Order', ['WC_Data'], &this),
			'get_${var_key.to_string()}', []rt.PhpVal{})
	} else {
		return rt.call_function('get_post_meta', [this.get_id(),
			rt.new_string('_' + var_key.str()), rt.new_bool(true)])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Abstract_Legacy_Order) has_meta(var_order_item_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::has_meta( $order_item_id )'),
		rt.new_string('3.0'),
		rt.new_string('WC_Order_item::get_meta_data'),
	])
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT meta_key, meta_value, meta_id, order_item_id\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_order_itemmeta WHERE order_item_id = %d\n\t\t\tORDER BY meta_id')),
			rt.call_function('absint', [var_order_item_id.clone()]),
		]),
		rt.get_constant('ARRAY_A'),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Order) display_item_meta(var_item rt.PhpVal) {
	mut var_item_mutated := var_item
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::display_item_meta'),
		rt.new_string('3.0'),
		rt.new_string('wc_display_item_meta'),
	])
	mut var_product := rt.call_method(var_item_mutated, 'get_product', []rt.PhpVal{})
	mut var_item_meta := create_wc_order_item_meta(var_item_mutated.clone(), var_product.clone())
	var_item_meta.display()
}

fn (mut this Class_WC_Abstract_Legacy_Order) display_item_downloads(var_item rt.PhpVal) {
	mut var_item_mutated := var_item
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::display_item_downloads'),
		rt.new_string('3.0'),
		rt.new_string('wc_display_item_downloads'),
	])
	mut var_product := rt.call_method(var_item_mutated, 'get_product', []rt.PhpVal{})
	if rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{}))
		&& rt.is_true(this.is_download_permitted()) {
		mut var_download_files := this.get_item_downloads(var_item_mutated.clone())
		mut var_i := rt.new_int(0)
		mut var_links := []rt.PhpVal{}
		mut iter_4 := var_download_files.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_file := item_4.val
			mut var_download_id := item_4.key
			rt.post_inc(var_i)
			mut var_prefix := if var_download_files.clone().array_count() > 1 { rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Download %d'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]) } else { rt.call_function('__', [rt.new_string('Download'),
					rt.new_string('woocommerce')]) }
			var_links << '<small class="download-url">' +
				(rt.call_function('esc_html', [var_prefix.clone()])).str() + ': <a href="' +
				(rt.call_function('esc_url', [var_file.array_get(rt.new_string('download_url'))])).str() +
				'" target="_blank">' +
				(rt.call_function('esc_html', [var_file.array_get(rt.new_string('name'))])).str() +
				'</a></small>' + '\n'
		}
		print('<br/>' +(rt.call_function('implode', [rt.new_string('<br/>'), rt.create_array_from_list(var_links)])).str())
	}
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_download_url(var_product_id rt.PhpVal, var_download_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::get_download_url'),
		rt.new_string('3.0'),
		rt.new_string('WC_Order_Item_Product::get_item_download_url'),
	])
	return rt.call_function('add_query_arg', [
		rt.create_array([
			rt.ArrayItem{ key: 'download_file', val: var_product_id_mutated },
			rt.ArrayItem{ key: 'order', val: this.get_order_key() },
			rt.ArrayItem{ key: 'email', val: rt.call_function('urlencode', [
				this.get_billing_email(),
			]) },
			rt.ArrayItem{ key: 'key', val: var_download_id },
		]),
		rt.call_function('trailingslashit', [
			rt.call_function('home_url', []rt.PhpVal{}),
		]),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_item_downloads(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::get_item_downloads'),
		rt.new_string('3.0'),
		rt.new_string('WC_Order_Item_Product::get_item_downloads'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item_mutated,
		'WC_Order_Item'))))))
	{
		if !(!rt.is_true(var_item_mutated.array_get(rt.new_string('variation_id')))) {
			mut var_product_id := var_item_mutated.array_get(rt.new_string('variation_id'))
		} else if !(!rt.is_true(var_item_mutated.array_get(rt.new_string('product_id')))) {
			var_product_id = var_item_mutated.array_get(rt.new_string('product_id'))
		} else {
			return []rt.PhpVal{}
		}
		var_item_mutated = create_wc_order_item_product()
		rt.call_method(var_item_mutated, 'set_product', [
			rt.call_function('wc_get_product', [var_product_id.clone()]),
		])
		rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	}
	return rt.call_method(var_item_mutated, 'get_item_downloads', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_total_shipping() rt.PhpVal {
	return this.get_shipping_total()
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_item_meta(var_order_item_id rt.PhpVal, key string, single bool) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::get_item_meta'),
		rt.new_string('3.0'), rt.new_string('wc_get_order_item_meta')])
	return rt.call_function('get_metadata', [rt.new_string('order_item'),
		var_order_item_id.clone(), rt.new_string(key), rt.new_bool(single)])
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_item_meta_array(var_order_item_id rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::get_item_meta_array'),
		rt.new_string('3.0'),
		rt.new_string('WC_Order_Item::get_meta_data() (note the format has changed)'),
	])
	mut var_item := this.get_item(var_order_item_id.clone())
	mut var_meta_data := rt.call_method(var_item, 'get_meta_data', []rt.PhpVal{})
	mut var_item_meta_array := []rt.PhpVal{}
	mut iter_5 := var_meta_data.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_meta := item_5.val
		var_item_meta_array.array_set(rt.get_property(var_meta, 'id'), var_meta.clone())
	}
	return var_item_meta_array.clone()
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_used_coupons() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_used_coupons'),
		rt.new_string('3.7'), rt.new_string('WC_Abstract_Order::get_coupon_codes')])
	return this.get_coupon_codes()
}

fn (mut this Class_WC_Abstract_Legacy_Order) expand_item_meta(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::expand_item_meta'),
		rt.new_string('3.0'),
	])
	return var_item_mutated.clone()
}

fn (mut this Class_WC_Abstract_Legacy_Order) init(var_order rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::init'),
		rt.new_string('3.0'), rt.new_string('Logic moved to constructor')])
	if rt.is_true(rt.new_bool(var_order.clone().is_long() || var_order.clone().is_double())) {
		this.set_id(var_order.clone())
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		this.set_id(rt.call_function('absint', [
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		]))
	} else if !(rt.get_property(var_order, 'ID')).is_null() {
		this.set_id(rt.call_function('absint', [rt.get_property(var_order, 'ID')]))
	}
	this.set_object_read(rt.new_bool(false))
	rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Legacy_Order', [
		'WC_Data',
	], &this), 'data_store'), 'read', [
		rt.new_object('WC_Abstract_Legacy_Order', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_order(id i64) bool {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::get_order'),
		rt.new_string('3.0')])
	if !(var_id != 0) {
		return false
	}
	mut var_result := rt.call_function('get_post', [rt.new_int(id)])
	if rt.is_true(var_result) {
		this.populate(var_result.clone())
		return true
	}
	return false
}

fn (mut this Class_WC_Abstract_Legacy_Order) populate(var_result rt.PhpVal) {
	mut var_result_mutated := var_result
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::populate'),
		rt.new_string('3.0')])
	this.set_id(rt.get_property(var_result_mutated, 'ID'))
	this.set_object_read(rt.new_bool(false))
	rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Legacy_Order', [
		'WC_Data',
	], &this), 'data_store'), 'read', [
		rt.new_object('WC_Abstract_Legacy_Order', ['WC_Data'], &this),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Order) cancel_order(note string) {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::cancel_order'),
		rt.new_string('3.0'), rt.new_string('WC_Order::update_status')])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('order_awaiting_payment'),
		rt.new_bool(false),
	])
	this.update_status(Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled(),
		rt.new_string(note))
}

fn (mut this Class_WC_Abstract_Legacy_Order) record_product_sales() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::record_product_sales'),
		rt.new_string('3.0'),
		rt.new_string('wc_update_total_sales_counts'),
	])
	rt.call_function('wc_update_total_sales_counts', [this.get_id()])
}

fn (mut this Class_WC_Abstract_Legacy_Order) increase_coupon_usage_counts() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::increase_coupon_usage_counts'),
		rt.new_string('3.0'),
		rt.new_string('wc_update_coupon_usage_counts'),
	])
	rt.call_function('wc_update_coupon_usage_counts', [this.get_id()])
}

fn (mut this Class_WC_Abstract_Legacy_Order) decrease_coupon_usage_counts() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::decrease_coupon_usage_counts'),
		rt.new_string('3.0'),
		rt.new_string('wc_update_coupon_usage_counts'),
	])
	rt.call_function('wc_update_coupon_usage_counts', [this.get_id()])
}

fn (mut this Class_WC_Abstract_Legacy_Order) reduce_order_stock() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::reduce_order_stock'),
		rt.new_string('3.0'),
		rt.new_string('wc_reduce_stock_levels'),
	])
	rt.call_function('wc_reduce_stock_levels', [this.get_id()])
}

fn (mut this Class_WC_Abstract_Legacy_Order) send_stock_notifications(var_product rt.PhpVal, var_new_stock rt.PhpVal, var_qty_ordered rt.PhpVal) {
	mut var_product_mutated := var_product
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::send_stock_notifications'),
		rt.new_string('3.0'),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Order) email_order_items_table(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::email_order_items_table'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_email_order_items'),
	])
	return rt.call_function('wc_get_email_order_items', [
		rt.new_object('WC_Abstract_Legacy_Order', ['WC_Data'], &this),
		var_args_mutated.clone(),
	])
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_order_currency() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order::get_order_currency'),
		rt.new_string('3.0'),
		rt.new_string('WC_Order::get_currency'),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_order_currency'),
		this.get_currency(),
		rt.new_object('WC_Abstract_Legacy_Order', ['WC_Data'], &this),
	])
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Coupon {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Fee {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Meta {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Product {
	rt.PhpObjectBase
}

fn create_wc_abstract_legacy_order(_args ...rt.PhpVal) &Class_WC_Abstract_Legacy_Order {
	mut obj := &Class_WC_Abstract_Legacy_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data(_args ...rt.PhpVal) &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_coupon(_args ...rt.PhpVal) &Class_WC_Order_Item_Coupon {
	mut obj := &Class_WC_Order_Item_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_tax(_args ...rt.PhpVal) &Class_WC_Order_Item_Tax {
	mut obj := &Class_WC_Order_Item_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_shipping(_args ...rt.PhpVal) &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_fee(_args ...rt.PhpVal) &Class_WC_Order_Item_Fee {
	mut obj := &Class_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_meta(_args ...rt.PhpVal) &Class_WC_Order_Item_Meta {
	mut obj := &Class_WC_Order_Item_Meta{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_product(_args ...rt.PhpVal) &Class_WC_Order_Item_Product {
	mut obj := &Class_WC_Order_Item_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Abstract_Legacy_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.add_coupon(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.add_tax(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_shipping(dispatch_arg_0)
		}
		'add_fee' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_fee(dispatch_arg_0)
		}
		'update_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.update_product(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'update_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_coupon(dispatch_arg_0, dispatch_arg_1))
		}
		'update_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_shipping(dispatch_arg_0, dispatch_arg_1))
		}
		'update_fee' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_fee(dispatch_arg_0, dispatch_arg_1))
		}
		'update_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_tax(dispatch_arg_0, dispatch_arg_1))
		}
		'get_product_from_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_from_item(dispatch_arg_0)
		}
		'set_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.set_address(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'legacy_set_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.legacy_set_total(dispatch_arg_0, dispatch_arg_1))
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'has_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.has_meta(dispatch_arg_0)
		}
		'display_item_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_item_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'display_item_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_item_downloads(dispatch_arg_0)
			return rt.new_null()
		}
		'get_download_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_download_url(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_downloads(dispatch_arg_0)
		}
		'get_total_shipping' {
			return this.get_total_shipping()
		}
		'get_item_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_item_meta(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_item_meta_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_meta_array(dispatch_arg_0)
		}
		'get_used_coupons' {
			return this.get_used_coupons()
		}
		'expand_item_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.expand_item_meta(dispatch_arg_0)
		}
		'init' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.init(dispatch_arg_0)
			return rt.new_null()
		}
		'get_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.get_order(dispatch_arg_0))
		}
		'populate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.populate(dispatch_arg_0)
			return rt.new_null()
		}
		'cancel_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.cancel_order(dispatch_arg_0)
			return rt.new_null()
		}
		'record_product_sales' {
			this.record_product_sales()
			return rt.new_null()
		}
		'increase_coupon_usage_counts' {
			this.increase_coupon_usage_counts()
			return rt.new_null()
		}
		'decrease_coupon_usage_counts' {
			this.decrease_coupon_usage_counts()
			return rt.new_null()
		}
		'reduce_order_stock' {
			this.reduce_order_stock()
			return rt.new_null()
		}
		'send_stock_notifications' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.send_stock_notifications(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'email_order_items_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.email_order_items_table(dispatch_arg_0)
		}
		'get_order_currency' {
			return this.get_order_currency()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Abstract_Legacy_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Abstract_Legacy_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Meta) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Meta) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Meta) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
