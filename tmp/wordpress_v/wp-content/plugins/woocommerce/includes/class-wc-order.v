import rt

struct Class_WC_Order {
	rt.PhpObjectBase
pub mut:
		status_transition rt.PhpVal = rt.new_bool(false)
		data rt.PhpVal = rt.new_array()
		legacy_datastore_props rt.PhpVal = rt.new_array()
		refunds rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order) payment_complete(transaction_id string) bool {
	mut transaction_id_mutated := transaction_id
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_pre_payment_complete'), this.get_id(), rt.new_string(transaction_id_mutated).dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('order_awaiting_payment'), rt.new_bool(false)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_valid_completed_statuses := rt.call_function('apply_filters', [rt.new_string('woocommerce_valid_order_statuses_for_payment_complete'), Class_Automattic_WooCommerce_Enums_OrderStatus.payment_complete_statuses(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(this.has_status(var_valid_completed_statuses.dup())) {
		if !(transaction_id_mutated == '') {
			this.set_transaction_id(rt.new_string(transaction_id_mutated))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(this.get_date_paid('edit'))))) {
			this.set_date_paid(rt.call_function('time', []rt.PhpVal{}))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_next_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_complete_order_status'), if rt.is_true(this.needs_processing()) { Class_Automattic_WooCommerce_Enums_OrderStatus.processing() } else { Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		transaction_id_mutated = (this.get_transaction_id('')).str()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_payment_method := this.get_payment_method_title('')
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_payment_complete_note := if rt.is_true(rt.new_bool(rt.is_true(var_payment_method) && rt.is_true(rt.new_string(transaction_id_mutated)))) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Payment via %1$s (%2$s).'), rt.new_string('woocommerce')]), var_payment_method.dup(), rt.new_string(transaction_id_mutated).dup()]) } else { rt.call_function('__', [rt.new_string('Payment complete.'), rt.new_string('woocommerce')]) }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.set_status(var_next_status.dup(), false, false)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.add_order_note(var_payment_complete_note.dup(), false, false, rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.payment() }]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.save()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_function('do_action', [rt.new_string('woocommerce_payment_complete'), this.get_id(), rt.new_string(transaction_id_mutated).dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		rt.call_function('do_action', ['woocommerce_payment_complete_order_status_' + (this.get_status()).str(), this.get_id(), rt.new_string(transaction_id_mutated).dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'error', [rt.call_function('sprintf', [rt.new_string('Error completing payment for order #%d'), this.get_id()]), rt.create_array([rt.ArrayItem{ key: 'order', val: rt.new_object('WC_Order', ['WC_Abstract_Order'], &this) }, rt.ArrayItem{ key: 'error', val: var_e }])])
		this.add_order_note(rt.new_string((rt.call_function('__', [rt.new_string('Payment complete event failed.'), rt.new_string('woocommerce')])).str() + ' ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()), false, false, rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error() }]))
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return true
}

fn (mut this Class_WC_Order) get_formatted_order_total(tax_display string, display_refunded bool) rt.PhpVal {
	mut tax_display_mutated := tax_display
	mut var_formatted_total := rt.call_function('wc_price', [this.get_total(), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])])
	mut var_order_total := this.get_total()
	mut var_total_refunded := this.get_total_refunded()
	mut var_tax_string := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('incl'), rt.new_string(tax_display_mutated))))) {
		mut var_tax_string_array := []rt.PhpVal{}
		mut var_tax_totals := this.get_tax_totals()
		if rt.is_true(rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_total_display')]))) {
			{
				mut iter_1 := var_tax_totals.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_tax := item_1.val
					mut var_code := item_1.key
					mut var_tax_amount := if rt.is_true(rt.new_bool(rt.is_true(var_total_refunded) && var_display_refunded)) { rt.call_function('wc_price', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.round(arg_0) }(rt.sub(rt.get_property(var_tax, 'amount'), this.get_total_tax_refunded_by_rate_id(rt.get_property(var_tax, 'rate_id')))), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])]) } else { rt.get_property(var_tax, 'formatted_amount') }
					var_tax_string_array << rt.call_function('sprintf', [rt.new_string('%s %s'), var_tax_amount.dup(), rt.get_property(var_tax, 'label')])
				}
			}
		} else if !(!rt.is_true(var_tax_totals)) {
			mut var_tax_amount := if rt.is_true(rt.new_bool(rt.is_true(var_total_refunded) && var_display_refunded)) { rt.sub(this.get_total_tax(), this.get_total_tax_refunded()) } else { this.get_total_tax() }
			var_tax_string_array << rt.call_function('sprintf', [rt.new_string('%s %s'), rt.call_function('wc_price', [var_tax_amount.dup(), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'tax_or_vat', []rt.PhpVal{})])
		}
		if !(!rt.is_true(var_tax_string_array)) {
			var_tax_string = rt.new_string(' <small class="includes_tax">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(includes %s)'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(', '), var_tax_string_array.dup()])])).str() + '</small>')
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_total_refunded) && var_display_refunded)) {
		var_formatted_total = rt.new_string('<del aria-hidden="true">' + (rt.call_function('wp_strip_all_tags', [var_formatted_total.dup()])).str() + '</del> <ins>' + (rt.call_function('wc_price', [rt.sub(var_order_total, var_total_refunded), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])])).str() + (var_tax_string).str() + '</ins>')
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_formatted_order_total'), var_formatted_total.dup(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), rt.new_string(tax_display_mutated).dup(), rt.new_bool(display_refunded)])
}

fn (mut this Class_WC_Order) save() rt.PhpVal {
	this.maybe_set_user_billing_email()
	this.Class_WC_Abstract_Order.save()
	this.status_transition()
	return this.get_id()
}

fn (mut this Class_WC_Order) handle_exception(var_e rt.PhpVal, message string)  {
	mut var_e_mutated := var_e
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string(message), rt.create_array([rt.ArrayItem{ key: 'order', val: rt.new_object('WC_Order', ['WC_Abstract_Order'], &this) }, rt.ArrayItem{ key: 'error', val: var_e_mutated }])])
	this.add_order_note(rt.new_string(message + ' ' + (rt.call_method(var_e_mutated, 'getMessage', []rt.PhpVal{})).str()), false, false, rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error() }]))
}

fn (mut this Class_WC_Order) set_status(var_new_status rt.PhpVal, note string, manual_update bool) rt.PhpVal {
	mut var_result := this.Class_WC_Abstract_Order.set_status(var_new_status.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'object_read'))) && !(!rt.is_true(var_result.array_get('from'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.status_transition = rt.create_array([rt.ArrayItem{ key: 'from', val: if !(!rt.is_true(this.status_transition.array_get('from'))) { this.status_transition.array_get('from') } else { var_result.array_get('from') } }, rt.ArrayItem{ key: 'to', val: var_result.array_get('to') }, rt.ArrayItem{ key: 'note', val: note }, rt.ArrayItem{ key: 'manual', val: // unsupported expression: Expr_Cast_Bool }])
		if var_manual_update {
			rt.call_function('do_action', [rt.new_string('woocommerce_order_edit_status'), this.get_id(), var_result.array_get('to')])
		}
		this.maybe_set_date_paid()
		this.maybe_set_date_completed()
	}
	return var_result.dup()
}

fn (mut this Class_WC_Order) maybe_set_date_paid()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_date_paid('edit'))))) {
		mut var_payment_completed_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_complete_order_status'), if rt.is_true(this.needs_processing()) { Class_Automattic_WooCommerce_Enums_OrderStatus.processing() } else { Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
		if rt.is_true(this.has_status(var_payment_completed_status.dup())) {
			this.set_date_paid(rt.call_function('time', []rt.PhpVal{}))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.processing(), var_payment_completed_status)) && rt.is_true(this.has_status(Class_Automattic_WooCommerce_Enums_OrderStatus.completed())))) {
			this.set_date_paid(rt.call_function('time', []rt.PhpVal{}))
		}
	}
}

fn (mut this Class_WC_Order) maybe_set_date_completed()  {
	if rt.is_true(this.has_status(Class_Automattic_WooCommerce_Enums_OrderStatus.completed())) {
		this.set_date_completed(rt.call_function('time', []rt.PhpVal{}))
	}
}

fn (mut this Class_WC_Order) update_status(var_new_status rt.PhpVal, note string, manual bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		return false
	}
	this.set_status(var_new_status.dup(), note, manual)
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.save()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'error', [rt.call_function('sprintf', [rt.new_string('Error updating status for order #%d'), this.get_id()]), rt.create_array([rt.ArrayItem{ key: 'order', val: rt.new_object('WC_Order', ['WC_Abstract_Order'], &this) }, rt.ArrayItem{ key: 'error', val: var_e }])])
		this.add_order_note(rt.new_string((rt.call_function('__', [rt.new_string('Update status event failed.'), rt.new_string('woocommerce')])).str() + ' ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()), false, false, rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error() }]))
		return false
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return true
}

fn (mut this Class_WC_Order) status_transition()  {
	mut var_status_transition := this.status_transition
	this.status_transition = rt.new_bool(false)
	if rt.is_true(var_status_transition) {
		rt.call_function('do_action', ['woocommerce_order_status_' + (var_status_transition.array_get('to')).str(), this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), var_status_transition.dup()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if !(!rt.is_true(var_status_transition.array_get('from'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status_transition.array_get('from'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.new() }, rt.ArrayItem{ key: none, val: 'checkout-draft' }]), rt.new_bool(true)]))))) {
					this.add_status_transition_note(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order status changed from %1$s to %2$s.'), rt.new_string('woocommerce')]), rt.call_function('wc_get_order_status_name', [var_status_transition.array_get('from')]), rt.call_function('wc_get_order_status_name', [var_status_transition.array_get('to')])]), var_status_transition.dup())
					if rt.has_exception() { unsafe { goto catch_label_3 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			} else {
				mut var_transition_note := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order status set to %s.'), rt.new_string('woocommerce')]), rt.call_function('wc_get_order_status_name', [var_status_transition.array_get('to')])])
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				this.add_status_transition_note(var_transition_note.dup(), var_status_transition.dup())
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if !(!rt.is_true(var_status_transition.array_get('from'))) {
			rt.call_function('do_action', ['woocommerce_order_status_' + (var_status_transition.array_get('from')).str() + '_to_' + (var_status_transition.array_get('to')).str(), this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			rt.call_function('do_action', [rt.new_string('woocommerce_order_status_changed'), this.get_id(), var_status_transition.array_get('from'), var_status_transition.array_get('to'), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			mut var_valid_order_statuses_for_payment := rt.call_function('apply_filters', [rt.new_string('woocommerce_valid_order_statuses_for_payment'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }]), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_status_transition.array_get('from'), var_valid_order_statuses_for_payment.dup(), rt.new_bool(true)])) && rt.is_true(rt.call_function('in_array', [var_status_transition.array_get('to'), rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{}), rt.new_bool(true)])))) {
				rt.call_function('do_action', [rt.new_string('woocommerce_order_payment_status_changed'), this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Exception') {
			mut var_e := var_e_3.dup()
			mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
			rt.call_method(var_logger, 'error', [rt.call_function('sprintf', [rt.new_string('Status transition of order #%d errored!'), this.get_id()]), rt.create_array([rt.ArrayItem{ key: 'order', val: rt.new_object('WC_Order', ['WC_Abstract_Order'], &this) }, rt.ArrayItem{ key: 'error', val: var_e }])])
			this.add_order_note(rt.new_string((rt.call_function('__', [rt.new_string('Error during status transition.'), rt.new_string('woocommerce')])).str() + ' ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()), false, false, rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error() }]))
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
	}
}

fn (mut this Class_WC_Order) get_base_data() rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }]), this.data, rt.create_array([rt.ArrayItem{ key: 'number', val: this.get_order_number() }])])
}

fn (mut this Class_WC_Order) get_data() rt.PhpVal {
	return rt.call_function('array_merge', [this.get_base_data(), rt.create_array([rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data() }, rt.ArrayItem{ key: 'line_items', val: this.get_items(rt.new_string('line_item')) }, rt.ArrayItem{ key: 'tax_lines', val: this.get_items(rt.new_string('tax')) }, rt.ArrayItem{ key: 'shipping_lines', val: this.get_items(rt.new_string('shipping')) }, rt.ArrayItem{ key: 'fee_lines', val: this.get_items(rt.new_string('fee')) }, rt.ArrayItem{ key: 'coupon_lines', val: this.get_items(rt.new_string('coupon')) }])])
}

fn (mut this Class_WC_Order) get_changes() rt.PhpVal {
	mut var_changed_props := this.Class_WC_Abstract_Order.get_changes()
	mut var_subs := ['shipping', 'billing']
	for var_sub in var_subs {
		if !(!rt.is_true(var_changed_props.array_get(sub))) {
			{
				mut iter_1 := var_changed_props.array_get(sub).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_sub_prop := item_1.key
					var_changed_props.array_set(sub + '_' + (var_sub_prop).str(), var_value.dup())
				}
			}
		}
	}
	if var_changed_props.array_isset(rt.new_string('customer_note')) {
		var_changed_props.array_set('post_excerpt', var_changed_props.array_get('customer_note'))
	}
	return var_changed_props.dup()
}

fn (mut this Class_WC_Order) get_order_number() rt.PhpVal {
	return // unsupported expression: Expr_Cast_String
}

fn (mut this Class_WC_Order) get_order_key(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('order_key'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_customer_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('customer_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_user_id(context string) rt.PhpVal {
	return this.get_customer_id(context)
}

fn (mut this Class_WC_Order) get_user() rt.PhpVal {
	return if rt.is_true(this.get_user_id('')) { rt.call_function('get_user_by', [rt.new_string('id'), this.get_user_id('')]) } else { rt.new_bool(false) }
}

fn (mut this Class_WC_Order) get_address_prop(var_prop rt.PhpVal, address_type string, context string) rt.PhpVal {
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(.array_get().array_isset(var_prop.dup()))) {
		var_value = 
		if rt.is_true() {
		}
	}
	return var_value.dup()
}

fn (mut this Class_WC_Order) get_billing_first_name(context string) rt.PhpVal {
	return 
}

fn (mut this Class_WC_Order) get_billing_last_name(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_company(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_address_1(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_address_2(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_city(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_state(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_postcode(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_country(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_email(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_billing_phone(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_first_name(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_last_name(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_company(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_address_1(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_address_2(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_city(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_state(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_postcode(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_country(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_phone(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_payment_method(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_payment_method_title(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_transaction_id(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_customer_ip_address(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_customer_user_agent(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_created_via(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_customer_note(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_date_completed(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_date_paid(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_cart_hash(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_address(address_type string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_shipping_address_map_url() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_formatted_billing_full_name() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_formatted_shipping_full_name() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_formatted_billing_address(empty_content string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_formatted_shipping_address(empty_content string) rt.PhpVal {
}

fn (mut this Class_WC_Order) has_billing_address() bool {
}

fn (mut this Class_WC_Order) has_shipping_address() bool {
}

fn (mut this Class_WC_Order) get_order_stock_reduced(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_download_permissions_granted(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_new_order_email_sent(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_recorded_sales(context string) rt.PhpVal {
}

fn (mut this Class_WC_Order) set_address_prop(var_prop rt.PhpVal, var_address_type rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_address(mut var_address Class_array)  {
	mut var_address_mutated := var_address
}

fn (mut this Class_WC_Order) set_billing(mut var_address Class_array)  {
	mut var_address_mutated := var_address
}

fn (mut this Class_WC_Order) set_shipping_address(mut var_address Class_array)  {
	mut var_address_mutated := var_address
}

fn (mut this Class_WC_Order) set_shipping(mut var_address Class_array)  {
	mut var_address_mutated := var_address
}

fn (mut this Class_WC_Order) set_order_key(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_customer_id(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_first_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_last_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_company(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_address_1(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_address_2(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_city(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_state(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_postcode(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_country(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) maybe_set_user_billing_email()  {
}

fn (mut this Class_WC_Order) set_billing_email(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_billing_phone(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_first_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_last_name(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_company(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_address_1(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_address_2(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_city(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_state(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_postcode(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_country(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_shipping_phone(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_payment_method(payment_method string)  {
	mut payment_method_mutated := payment_method
}

fn (mut this Class_WC_Order) set_payment_method_title(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_transaction_id(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_customer_ip_address(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_customer_user_agent(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_created_via(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_customer_note(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_date_completed(var_date rt.PhpVal)  {
}

fn (mut this Class_WC_Order) set_date_paid(var_date rt.PhpVal)  {
}

fn (mut this Class_WC_Order) set_cart_hash(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_order_stock_reduced(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_download_permissions_granted(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_new_order_email_sent(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) set_recorded_sales(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Order) key_is_valid(var_key rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Order) has_cart_hash(cart_hash string) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_Order) is_editable() rt.PhpVal {
}

fn (mut this Class_WC_Order) is_paid() rt.PhpVal {
}

fn (mut this Class_WC_Order) is_download_permitted() rt.PhpVal {
}

fn (mut this Class_WC_Order) needs_shipping_address() bool {
}

fn (mut this Class_WC_Order) has_downloadable_item() bool {
}

fn (mut this Class_WC_Order) get_downloadable_items() rt.PhpVal {
}

fn (mut this Class_WC_Order) needs_payment() rt.PhpVal {
}

fn (mut this Class_WC_Order) needs_processing() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_checkout_payment_url(on_checkout bool) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_checkout_order_received_url() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_cancel_order_url(redirect string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_cancel_order_url_raw(redirect string) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_cancel_endpoint() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_view_order_url() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_edit_order_url() rt.PhpVal {
}

fn (mut this Class_WC_Order) add_order_note(var_note rt.PhpVal, is_customer_note i64, added_by_user bool, var_meta_data rt.PhpVal) i64 {
}

fn (mut this Class_WC_Order) add_status_transition_note(var_note rt.PhpVal, var_transition rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_customer_order_notes() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_refunds() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_total_refunded() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_total_tax_refunded() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_total_shipping_tax_refunded() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_total_shipping_refunded() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_item_count_refunded(item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
}

fn (mut this Class_WC_Order) get_total_qty_refunded(item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
}

fn (mut this Class_WC_Order) get_qty_refunded_for_item(var_item_id rt.PhpVal, item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
}

fn (mut this Class_WC_Order) get_cogs_refunded_for_item(var_item_id rt.PhpVal, item_type string) i64 {
	mut item_type_mutated := item_type
}

fn (mut this Class_WC_Order) get_total_refunded_for_item(var_item_id rt.PhpVal, item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
}

fn (mut this Class_WC_Order) get_tax_refunded_for_item(var_item_id rt.PhpVal, var_tax_id rt.PhpVal, item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
}

fn (mut this Class_WC_Order) get_total_tax_refunded_by_rate_id(var_rate_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Order) get_remaining_refund_amount() rt.PhpVal {
}

fn (mut this Class_WC_Order) get_remaining_refund_items() rt.PhpVal {
}

fn (mut this Class_WC_Order) add_order_item_totals_payment_method_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Order) add_order_item_totals_refund_rows(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Order) get_order_item_totals(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
}

fn (mut this Class_WC_Order) is_created_via(var_modus rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Order) untrash() bool {
}

fn (mut this Class_WC_Order) has_cogs() bool {
}

fn (mut this Class_WC_Order) calculate_cogs_total_value_core() f64 {
}

struct Class_WC_Abstract_Order {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_order() &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
		status_transition: rt.new_bool(false)
		data: rt.new_array()
		legacy_datastore_props: rt.new_array()
		refunds: rt.new_array()
	}
	return obj
}

fn create_wc_abstract_order() &Class_WC_Abstract_Order {
	mut obj := &Class_WC_Abstract_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'payment_complete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.payment_complete(dispatch_arg_0))
		}
		'get_formatted_order_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_formatted_order_total(dispatch_arg_0, dispatch_arg_1)
		}
		'save' {
			return this.save()
		}
		'handle_exception' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.handle_exception(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.set_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'maybe_set_date_paid' {
			this.maybe_set_date_paid()
			return rt.new_null()
		}
		'maybe_set_date_completed' {
			this.maybe_set_date_completed()
			return rt.new_null()
		}
		'update_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.update_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'status_transition' {
			this.status_transition()
			return rt.new_null()
		}
		'get_base_data' {
			return this.get_base_data()
		}
		'get_data' {
			return this.get_data()
		}
		'get_changes' {
			return this.get_changes()
		}
		'get_order_number' {
			return this.get_order_number()
		}
		'get_order_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_key(dispatch_arg_0)
		}
		'get_customer_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_customer_id(dispatch_arg_0)
		}
		'get_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_user_id(dispatch_arg_0)
		}
		'get_user' {
			return this.get_user()
		}
		'get_address_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_address_prop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_billing_first_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_first_name(dispatch_arg_0)
		}
		'get_billing_last_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_last_name(dispatch_arg_0)
		}
		'get_billing_company' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_company(dispatch_arg_0)
		}
		'get_billing_address_1' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_address_1(dispatch_arg_0)
		}
		'get_billing_address_2' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_address_2(dispatch_arg_0)
		}
		'get_billing_city' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_city(dispatch_arg_0)
		}
		'get_billing_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_state(dispatch_arg_0)
		}
		'get_billing_postcode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_postcode(dispatch_arg_0)
		}
		'get_billing_country' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_country(dispatch_arg_0)
		}
		'get_billing_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_email(dispatch_arg_0)
		}
		'get_billing_phone' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_billing_phone(dispatch_arg_0)
		}
		'get_shipping_first_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_first_name(dispatch_arg_0)
		}
		'get_shipping_last_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_last_name(dispatch_arg_0)
		}
		'get_shipping_company' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_company(dispatch_arg_0)
		}
		'get_shipping_address_1' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_address_1(dispatch_arg_0)
		}
		'get_shipping_address_2' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_address_2(dispatch_arg_0)
		}
		'get_shipping_city' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_city(dispatch_arg_0)
		}
		'get_shipping_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_state(dispatch_arg_0)
		}
		'get_shipping_postcode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_postcode(dispatch_arg_0)
		}
		'get_shipping_country' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_country(dispatch_arg_0)
		}
		'get_shipping_phone' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_phone(dispatch_arg_0)
		}
		'get_payment_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_payment_method(dispatch_arg_0)
		}
		'get_payment_method_title' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_payment_method_title(dispatch_arg_0)
		}
		'get_transaction_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_transaction_id(dispatch_arg_0)
		}
		'get_customer_ip_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_customer_ip_address(dispatch_arg_0)
		}
		'get_customer_user_agent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_customer_user_agent(dispatch_arg_0)
		}
		'get_created_via' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_created_via(dispatch_arg_0)
		}
		'get_customer_note' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_customer_note(dispatch_arg_0)
		}
		'get_date_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_completed(dispatch_arg_0)
		}
		'get_date_paid' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_paid(dispatch_arg_0)
		}
		'get_cart_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cart_hash(dispatch_arg_0)
		}
		'get_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_address(dispatch_arg_0)
		}
		'get_shipping_address_map_url' {
			return this.get_shipping_address_map_url()
		}
		'get_formatted_billing_full_name' {
			return this.get_formatted_billing_full_name()
		}
		'get_formatted_shipping_full_name' {
			return this.get_formatted_shipping_full_name()
		}
		'get_formatted_billing_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_formatted_billing_address(dispatch_arg_0)
		}
		'get_formatted_shipping_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_formatted_shipping_address(dispatch_arg_0)
		}
		'has_billing_address' {
			return rt.new_bool(this.has_billing_address())
		}
		'has_shipping_address' {
			return rt.new_bool(this.has_shipping_address())
		}
		'get_order_stock_reduced' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_stock_reduced(dispatch_arg_0)
		}
		'get_download_permissions_granted' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_download_permissions_granted(dispatch_arg_0)
		}
		'get_new_order_email_sent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_new_order_email_sent(dispatch_arg_0)
		}
		'get_recorded_sales' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_recorded_sales(dispatch_arg_0)
		}
		'set_address_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_address_prop(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_billing_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_billing_address(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_billing(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_shipping_address(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_shipping(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_order_key(dispatch_arg_0)
			return rt.new_null()
		}
		'set_customer_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_customer_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_first_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_first_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_last_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_last_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_company' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_company(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_address_1' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_address_1(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_address_2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_address_2(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_city' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_city(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_state(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_postcode(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_country(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_set_user_billing_email' {
			this.maybe_set_user_billing_email()
			return rt.new_null()
		}
		'set_billing_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_email(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_phone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_billing_phone(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_first_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_first_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_last_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_last_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_company' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_company(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_address_1' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_address_1(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_address_2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_address_2(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_city' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_city(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_state(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_postcode(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_country(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_phone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_phone(dispatch_arg_0)
			return rt.new_null()
		}
		'set_payment_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_payment_method(dispatch_arg_0)
			return rt.new_null()
		}
		'set_payment_method_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_payment_method_title(dispatch_arg_0)
			return rt.new_null()
		}
		'set_transaction_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_transaction_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_customer_ip_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_customer_ip_address(dispatch_arg_0)
			return rt.new_null()
		}
		'set_customer_user_agent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_customer_user_agent(dispatch_arg_0)
			return rt.new_null()
		}
		'set_created_via' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_created_via(dispatch_arg_0)
			return rt.new_null()
		}
		'set_customer_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_customer_note(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_completed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_completed(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_paid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_paid(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cart_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cart_hash(dispatch_arg_0)
			return rt.new_null()
		}
		'set_order_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_order_stock_reduced(dispatch_arg_0)
			return rt.new_null()
		}
		'set_download_permissions_granted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_download_permissions_granted(dispatch_arg_0)
			return rt.new_null()
		}
		'set_new_order_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_new_order_email_sent(dispatch_arg_0)
			return rt.new_null()
		}
		'set_recorded_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_recorded_sales(dispatch_arg_0)
			return rt.new_null()
		}
		'key_is_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.key_is_valid(dispatch_arg_0)
		}
		'has_cart_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.has_cart_hash(dispatch_arg_0)
		}
		'is_editable' {
			return this.is_editable()
		}
		'is_paid' {
			return this.is_paid()
		}
		'is_download_permitted' {
			return this.is_download_permitted()
		}
		'needs_shipping_address' {
			return rt.new_bool(this.needs_shipping_address())
		}
		'has_downloadable_item' {
			return rt.new_bool(this.has_downloadable_item())
		}
		'get_downloadable_items' {
			return this.get_downloadable_items()
		}
		'needs_payment' {
			return this.needs_payment()
		}
		'needs_processing' {
			return this.needs_processing()
		}
		'get_checkout_payment_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_checkout_payment_url(dispatch_arg_0)
		}
		'get_checkout_order_received_url' {
			return this.get_checkout_order_received_url()
		}
		'get_cancel_order_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cancel_order_url(dispatch_arg_0)
		}
		'get_cancel_order_url_raw' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cancel_order_url_raw(dispatch_arg_0)
		}
		'get_cancel_endpoint' {
			return this.get_cancel_endpoint()
		}
		'get_view_order_url' {
			return this.get_view_order_url()
		}
		'get_edit_order_url' {
			return this.get_edit_order_url()
		}
		'add_order_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_int(this.add_order_note(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'add_status_transition_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_status_transition_note(dispatch_arg_0, dispatch_arg_1)
		}
		'get_customer_order_notes' {
			return this.get_customer_order_notes()
		}
		'get_refunds' {
			return this.get_refunds()
		}
		'get_total_refunded' {
			return this.get_total_refunded()
		}
		'get_total_tax_refunded' {
			return this.get_total_tax_refunded()
		}
		'get_total_shipping_tax_refunded' {
			return this.get_total_shipping_tax_refunded()
		}
		'get_total_shipping_refunded' {
			return this.get_total_shipping_refunded()
		}
		'get_item_count_refunded' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_item_count_refunded(dispatch_arg_0)
		}
		'get_total_qty_refunded' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total_qty_refunded(dispatch_arg_0)
		}
		'get_qty_refunded_for_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_qty_refunded_for_item(dispatch_arg_0, dispatch_arg_1)
		}
		'get_cogs_refunded_for_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_int(this.get_cogs_refunded_for_item(dispatch_arg_0, dispatch_arg_1))
		}
		'get_total_refunded_for_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_total_refunded_for_item(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tax_refunded_for_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_tax_refunded_for_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_total_tax_refunded_by_rate_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_tax_refunded_by_rate_id(dispatch_arg_0)
		}
		'get_remaining_refund_amount' {
			return this.get_remaining_refund_amount()
		}
		'get_remaining_refund_items' {
			return this.get_remaining_refund_items()
		}
		'add_order_item_totals_payment_method_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_payment_method_row(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_order_item_totals_refund_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_refund_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_order_item_totals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_item_totals(dispatch_arg_0)
		}
		'is_created_via' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_created_via(dispatch_arg_0)
		}
		'untrash' {
			return rt.new_bool(this.untrash())
		}
		'has_cogs' {
			return rt.new_bool(this.has_cogs())
		}
		'calculate_cogs_total_value_core' {
			return rt.new_float(this.calculate_cogs_total_value_core())
		}
		else { return none }
	}
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'status_transition' { return this.status_transition }
		'data' { return this.data }
		'legacy_datastore_props' { return this.legacy_datastore_props }
		'refunds' { return this.refunds }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'status_transition' { this.status_transition = val; return true }
		'data' { this.data = val; return true }
		'legacy_datastore_props' { this.legacy_datastore_props = val; return true }
		'refunds' { this.refunds = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Abstract_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Abstract_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Abstract_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_order_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
