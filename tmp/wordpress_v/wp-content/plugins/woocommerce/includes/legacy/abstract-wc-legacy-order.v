import rt

struct Class_WC_Abstract_Legacy_Order {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_coupon(var_code rt.PhpVal, discount i64, discount_tax i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_coupon'), rt.new_string('3.0'), rt.new_string('a new WC_Order_Item_Coupon object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_coupon()
	rt.call_method(var_item, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'code', val: var_code }, rt.ArrayItem{ key: 'discount', val: discount }, rt.ArrayItem{ key: 'discount_tax', val: discount_tax }, rt.ArrayItem{ key: 'order_id', val: this.get_id() }])])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.dup())
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_order_add_coupon'), rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() }, rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: var_code }, rt.ArrayItem{ key: none, val: discount }, rt.ArrayItem{ key: none, val: discount_tax }]), rt.new_string('3.0'), rt.new_string('woocommerce_new_order_item action instead.')])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_tax(var_tax_rate_id rt.PhpVal, tax_amount i64, shipping_tax_amount i64) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_tax'), rt.new_string('3.0'), rt.new_string('a new WC_Order_Item_Tax object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_tax()
	rt.call_method(var_item, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'rate_id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'tax_total', val: tax_amount }, rt.ArrayItem{ key: 'shipping_tax_total', val: shipping_tax_amount }])])
	rt.call_method(var_item, 'set_rate', [var_tax_rate_id.dup()])
	rt.call_method(var_item, 'set_order_id', [this.get_id()])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.dup())
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_order_add_tax'), rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() }, rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: var_tax_rate_id }, rt.ArrayItem{ key: none, val: tax_amount }, rt.ArrayItem{ key: none, val: shipping_tax_amount }]), rt.new_string('3.0'), rt.new_string('woocommerce_new_order_item action instead.')])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_shipping(var_shipping_rate rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_shipping'), rt.new_string('3.0'), rt.new_string('a new WC_Order_Item_Shipping object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_shipping()
	rt.call_method(var_item, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'method_title', val: rt.get_property(var_shipping_rate, 'label') }, rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_shipping_rate, 'id') }, rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [rt.get_property(var_shipping_rate, 'cost')]) }, rt.ArrayItem{ key: 'taxes', val: rt.get_property(var_shipping_rate, 'taxes') }, rt.ArrayItem{ key: 'order_id', val: this.get_id() }])])
	{
		mut iter_1 := rt.call_method(var_shipping_rate, 'get_meta_data', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			rt.call_method(var_item, 'add_meta_data', [var_key.dup(), var_value.dup(), rt.new_bool(true)])
		}
	}
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.dup())
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_order_add_shipping'), rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() }, rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: var_shipping_rate }]), rt.new_string('3.0'), rt.new_string('woocommerce_new_order_item action instead.')])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) add_fee(var_fee rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::add_fee'), rt.new_string('3.0'), rt.new_string('a new WC_Order_Item_Fee object and add to order with WC_Order::add_item()')])
	mut var_item := create_wc_order_item_fee()
	rt.call_method(var_item, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_fee, 'name') }, rt.ArrayItem{ key: 'tax_class', val: if rt.is_true(rt.get_property(var_fee, 'taxable')) { rt.get_property(var_fee, 'tax_class') } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'total', val: rt.get_property(var_fee, 'amount') }, rt.ArrayItem{ key: 'total_tax', val: rt.get_property(var_fee, 'tax') }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'total', val: rt.get_property(var_fee, 'tax_data') }]) }, rt.ArrayItem{ key: 'order_id', val: this.get_id() }])])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.dup())
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_order_add_fee'), rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() }, rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: var_fee }]), rt.new_string('3.0'), rt.new_string('woocommerce_new_order_item action instead.')])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_product(var_item rt.PhpVal, var_product rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_product_mutated := var_product
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_product'), rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Product class')])
	if rt.is_true(rt.new_bool(var_item_mutated.dup().is_long() || var_item_mutated.dup().is_double())) {
		var_item_mutated = this.get_item(var_item_mutated.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item_mutated.dup().is_object()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('line_item')]))))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
		// unsupported statement: Stmt_Nop
	}
	if var_args_mutated.array_isset(rt.new_string('totals')) {
		{
			mut iter_1 := var_args_mutated.array_get('totals').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.new_string('tax'), var_key)) {
					var_args_mutated.array_set('total_tax', var_value.dup())
				} else if rt.is_true(rt.identical(rt.new_string('tax_data'), var_key)) {
					var_args_mutated.array_set('taxes', var_value.dup())
				} else {
					var_args_mutated.array_set(var_key, var_value.dup())
				}
			}
		}
	}
	if var_args_mutated.array_isset(rt.new_string('qty')) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product_mutated, 'backorders_require_notification', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product_mutated, 'is_on_backorder', [var_args_mutated.array_get('qty')])))) {
			rt.call_method(var_item_mutated, 'add_meta_data', [rt.call_function('apply_filters', [rt.new_string('woocommerce_backordered_item_meta_name'), rt.call_function('__', [rt.new_string('Backordered'), rt.new_string('woocommerce')]), var_item_mutated.dup()]), rt.sub(var_args_mutated.array_get('qty'), rt.call_function('max', [rt.new_int(0), rt.call_method(var_product_mutated, 'get_stock_quantity', []rt.PhpVal{})])), rt.new_bool(true)])
		}
		var_args_mutated.array_set('subtotal', if rt.is_true(var_args_mutated.array_get('subtotal')) { var_args_mutated.array_get('subtotal') } else { rt.call_function('wc_get_price_excluding_tax', [var_product_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'qty', val: var_args_mutated.array_get('qty') }])]) })
		var_args_mutated.array_set('total', if rt.is_true(var_args_mutated.array_get('total')) { var_args_mutated.array_get('total') } else { rt.call_function('wc_get_price_excluding_tax', [var_product_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'qty', val: var_args_mutated.array_get('qty') }])]) })
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.dup()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_edit_product'), this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}), var_args_mutated.dup(), var_product_mutated.dup()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_coupon(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_coupon'), rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Coupon class')])
	if rt.is_true(rt.new_bool(var_item_mutated.dup().is_long() || var_item_mutated.dup().is_double())) {
		var_item_mutated = this.get_item(var_item_mutated.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item_mutated.dup().is_object()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('coupon')]))))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
		// unsupported statement: Stmt_Nop
	}
	if var_args_mutated.array_isset(rt.new_string('discount_amount')) {
		var_args_mutated.array_set('discount', var_args_mutated.array_get('discount_amount'))
	}
	if var_args_mutated.array_isset(rt.new_string('discount_amount_tax')) {
		var_args_mutated.array_set('discount_tax', var_args_mutated.array_get('discount_amount_tax'))
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.dup()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_coupon'), this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}), var_args_mutated.dup()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_shipping(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_shipping'), rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Shipping class')])
	if rt.is_true(rt.new_bool(var_item_mutated.dup().is_long() || var_item_mutated.dup().is_double())) {
		var_item_mutated = this.get_item(var_item_mutated.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item_mutated.dup().is_object()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('shipping')]))))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
		// unsupported statement: Stmt_Nop
	}
	if var_args_mutated.array_isset(rt.new_string('cost')) {
		var_args_mutated.array_set('total', var_args_mutated.array_get('cost'))
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.dup()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	this.calculate_shipping()
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_shipping'), this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}), var_args_mutated.dup()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_fee(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_fee'), rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Fee class')])
	if rt.is_true(rt.new_bool(var_item_mutated.dup().is_long() || var_item_mutated.dup().is_double())) {
		var_item_mutated = this.get_item(var_item_mutated.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item_mutated.dup().is_object()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('fee')]))))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
		// unsupported statement: Stmt_Nop
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.dup()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_fee'), this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}), var_args_mutated.dup()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) update_tax(var_item rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order::update_tax'), rt.new_string('3.0'), rt.new_string('an interaction with the WC_Order_Item_Tax class')])
	if rt.is_true(rt.new_bool(var_item_mutated.dup().is_long() || var_item_mutated.dup().is_double())) {
		var_item_mutated = this.get_item(var_item_mutated.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item_mutated.dup().is_object()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_mutated, 'is_type', [rt.new_string('tax')]))))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		this.save()
		// unsupported statement: Stmt_Nop
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	rt.call_method(var_item_mutated, 'set_props', [var_args_mutated.dup()])
	rt.call_method(var_item_mutated, 'save', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_order_update_tax'), this.get_id(), rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{}), var_args_mutated.dup()])
	return (rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_product_from_item(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Abstract_Legacy_Order::get_product_from_item'), rt.new_string('4.4.0'), rt.new_string('$item->get_product()')])
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }])])) {
		mut var_product := 
	} else {
		
	}
	return 
}

fn (mut this Class_WC_Abstract_Legacy_Order) set_address(var_address rt.PhpVal, type string)  {
}

fn (mut this Class_WC_Abstract_Legacy_Order) legacy_set_total(var_amount rt.PhpVal, total_type string) bool {
	mut var_amount_mutated := var_amount
}

fn (mut this Class_WC_Abstract_Legacy_Order) magic_isset(var_key rt.PhpVal) bool {
}

fn (mut this Class_WC_Abstract_Legacy_Order) magic_get(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_Abstract_Legacy_Order) has_meta(var_order_item_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Abstract_Legacy_Order) display_item_meta(var_item rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Legacy_Order) display_item_downloads(var_item rt.PhpVal)  {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_download_url(var_product_id rt.PhpVal, var_download_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_item_downloads(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_total_shipping() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_item_meta(var_order_item_id rt.PhpVal, key string, single bool) rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_item_meta_array(var_order_item_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_used_coupons() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Legacy_Order) expand_item_meta(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Legacy_Order) init(var_order rt.PhpVal)  {
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_order(id i64) bool {
}

fn (mut this Class_WC_Abstract_Legacy_Order) populate(var_result rt.PhpVal)  {
	mut var_result_mutated := var_result
}

fn (mut this Class_WC_Abstract_Legacy_Order) cancel_order(note string)  {
}

fn (mut this Class_WC_Abstract_Legacy_Order) record_product_sales()  {
}

fn (mut this Class_WC_Abstract_Legacy_Order) increase_coupon_usage_counts()  {
}

fn (mut this Class_WC_Abstract_Legacy_Order) decrease_coupon_usage_counts()  {
}

fn (mut this Class_WC_Abstract_Legacy_Order) reduce_order_stock()  {
}

fn (mut this Class_WC_Abstract_Legacy_Order) send_stock_notifications(var_product rt.PhpVal, var_new_stock rt.PhpVal, var_qty_ordered rt.PhpVal)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_Abstract_Legacy_Order) email_order_items_table(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Abstract_Legacy_Order) get_order_currency() rt.PhpVal {
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

fn create_wc_abstract_legacy_order() &Class_WC_Abstract_Legacy_Order {
	mut obj := &Class_WC_Abstract_Legacy_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data() &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_coupon() &Class_WC_Order_Item_Coupon {
	mut obj := &Class_WC_Order_Item_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_tax() &Class_WC_Order_Item_Tax {
	mut obj := &Class_WC_Order_Item_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_shipping() &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_fee() &Class_WC_Order_Item_Fee {
	mut obj := &Class_WC_Order_Item_Fee{
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
		else { return none }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_legacy_abstract_wc_legacy_order_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
