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
	rt.call_function('do_action', [rt.new_string('woocommerce_pre_payment_complete'), this.get_id(), rt.new_string(transaction_id_mutated).clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('order_awaiting_payment'), rt.new_bool(false)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_valid_completed_statuses := rt.call_function('apply_filters', [rt.new_string('woocommerce_valid_order_statuses_for_payment_complete'), Class_Automattic_WooCommerce_Enums_OrderStatus.payment_complete_statuses(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(this.has_status(var_valid_completed_statuses.clone())) {
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
		mut var_payment_complete_note := if rt.is_true(var_payment_method) && rt.is_true(rt.new_string(transaction_id_mutated)) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Payment via %1$s (%2$s).'), rt.new_string('woocommerce')]), var_payment_method.clone(), rt.new_string(transaction_id_mutated).clone()]) } else { rt.call_function('__', [rt.new_string('Payment complete.'), rt.new_string('woocommerce')]) }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.set_status(var_next_status.clone(), false, false)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.add_order_note(var_payment_complete_note.clone(), false, false, rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.payment() }]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.save()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_function('do_action', [rt.new_string('woocommerce_payment_complete'), this.get_id(), rt.new_string(transaction_id_mutated).clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		rt.call_function('do_action', [rt.new_string('woocommerce_payment_complete_order_status_' + (this.get_status()).str()), this.get_id(), rt.new_string(transaction_id_mutated).clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
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
	mut var_tax_string := rt.new_string('')
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('incl'), rt.new_string(tax_display_mutated))) {
		mut var_tax_string_array := []rt.PhpVal{}
		mut var_tax_totals := this.get_tax_totals()
		if rt.is_true(rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_total_display')]))) {
			mut iter_1 := var_tax_totals.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax := item_1.val
				mut var_code := item_1.key
				mut iife_temp_0 := Class_WC_Tax{}
				mut iife_result_0 := iife_temp_0.round(rt.sub(rt.get_property(var_tax, 'amount'), this.get_total_tax_refunded_by_rate_id(rt.get_property(var_tax, 'rate_id'))))
				mut iife_temp_1 := Class_WC_Tax{}
				mut iife_result_1 := iife_temp_1.round(rt.sub(rt.get_property(var_tax, 'amount'), this.get_total_tax_refunded_by_rate_id(rt.get_property(var_tax, 'rate_id'))))
				mut var_tax_amount := if rt.is_true(var_total_refunded) && var_display_refunded { rt.call_function('wc_price', [iife_result_0, rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])]) } else { rt.get_property(var_tax, 'formatted_amount') }
				var_tax_string_array << rt.call_function('sprintf', [rt.new_string('%s %s'), var_tax_amount.clone(), rt.get_property(var_tax, 'label')])
			}
		} else if !(!rt.is_true(var_tax_totals)) {
			mut var_tax_amount := if rt.is_true(var_total_refunded) && var_display_refunded { rt.sub(this.get_total_tax(), this.get_total_tax_refunded()) } else { this.get_total_tax() }
			var_tax_string_array << rt.call_function('sprintf', [rt.new_string('%s %s'), rt.call_function('wc_price', [var_tax_amount.clone(), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'tax_or_vat', []rt.PhpVal{})])
		}
		if !(!rt.is_true(var_tax_string_array)) {
		var_tax_string = rt.new_string(' <small class="includes_tax">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(includes %s)'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_tax_string_array)])])).str() + '</small>')
		}
	}
	if rt.is_true(var_total_refunded) && var_display_refunded {
	var_formatted_total = rt.new_string('<del aria-hidden="true">' + (rt.call_function('wp_strip_all_tags', [var_formatted_total.clone()])).str() + '</del> <ins>' + (rt.call_function('wc_price', [rt.sub(var_order_total, var_total_refunded), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])])).str() + (var_tax_string).str() + '</ins>')
	} else {
		var_formatted_total = rt.concat(var_formatted_total, var_tax_string)
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_formatted_order_total'), var_formatted_total.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), rt.new_string(tax_display_mutated).clone(), rt.new_bool(display_refunded)])
}

fn (mut this Class_WC_Order) save() rt.PhpVal {
	this.maybe_set_user_billing_email()
	this.Class_WC_Abstract_Order.save()
	this.status_transition()
	return this.get_id()
}

fn (mut this Class_WC_Order) handle_exception(var_e rt.PhpVal, message string) {
	mut var_e_mutated := var_e
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string(message), rt.create_array([rt.ArrayItem{ key: 'order', val: rt.new_object('WC_Order', ['WC_Abstract_Order'], &this) }, rt.ArrayItem{ key: 'error', val: var_e_mutated }])])
	this.add_order_note(rt.new_string(message + ' ' + (rt.call_method(var_e_mutated, 'getMessage', []rt.PhpVal{})).str()), false, false, rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error() }]))
}

fn (mut this Class_WC_Order) set_status(var_new_status rt.PhpVal, note string, manual_update bool) rt.PhpVal {
	mut var_result := this.Class_WC_Abstract_Order.set_status(var_new_status.clone())
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'object_read'))) && !(!rt.is_true(var_result.array_get(rt.new_string('from')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_result.array_get(rt.new_string('from')), var_result.array_get(rt.new_string('to')))))) {
		this.status_transition = rt.create_array([rt.ArrayItem{ key: 'from', val: if !(!rt.is_true(this.status_transition.array_get(rt.new_string('from')))) { this.status_transition.array_get(rt.new_string('from')) } else { var_result.array_get(rt.new_string('from')) } }, rt.ArrayItem{ key: 'to', val: var_result.array_get(rt.new_string('to')) }, rt.ArrayItem{ key: 'note', val: note }, rt.ArrayItem{ key: 'manual', val: manual_update }])
		if var_manual_update {
			rt.call_function('do_action', [rt.new_string('woocommerce_order_edit_status'), this.get_id(), var_result.array_get(rt.new_string('to'))])
		}
		this.maybe_set_date_paid()
		this.maybe_set_date_completed()
	}
	return var_result.clone()
}

fn (mut this Class_WC_Order) maybe_set_date_paid() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_date_paid('edit'))))) {
		mut var_payment_completed_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_complete_order_status'), if rt.is_true(this.needs_processing()) { Class_Automattic_WooCommerce_Enums_OrderStatus.processing() } else { Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
		if rt.is_true(this.has_status(var_payment_completed_status.clone())) {
			this.set_date_paid(rt.call_function('time', []rt.PhpVal{}))
		} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.processing(), var_payment_completed_status)) && rt.is_true(this.has_status(Class_Automattic_WooCommerce_Enums_OrderStatus.completed())) {
			this.set_date_paid(rt.call_function('time', []rt.PhpVal{}))
		}
	}
}

fn (mut this Class_WC_Order) maybe_set_date_completed() {
	if rt.is_true(this.has_status(Class_Automattic_WooCommerce_Enums_OrderStatus.completed())) {
		this.set_date_completed(rt.call_function('time', []rt.PhpVal{}))
	}
}

fn (mut this Class_WC_Order) update_status(var_new_status rt.PhpVal, note string, manual bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		return false
	}
	this.set_status(var_new_status.clone(), note, manual)
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.save()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
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

fn (mut this Class_WC_Order) status_transition() {
	mut var_status_transition := this.status_transition
	this.status_transition = rt.new_bool(false)
	if rt.is_true(var_status_transition) {
		rt.call_function('do_action', [rt.new_string('woocommerce_order_status_' + (var_status_transition.array_get(rt.new_string('to'))).str()), this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), var_status_transition.clone()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_status_transition.array_get(rt.new_string('note')))))) {
			if !(!rt.is_true(var_status_transition.array_get(rt.new_string('from')))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status_transition.array_get(rt.new_string('from')), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.new() }, rt.ArrayItem{ key: none, val: 'checkout-draft' }]), rt.new_bool(true)]))))) {
					this.add_status_transition_note(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order status changed from %1$s to %2$s.'), rt.new_string('woocommerce')]), rt.call_function('wc_get_order_status_name', [var_status_transition.array_get(rt.new_string('from'))]), rt.call_function('wc_get_order_status_name', [var_status_transition.array_get(rt.new_string('to'))])]), var_status_transition.clone())
					if rt.has_exception() { unsafe { goto catch_label_3 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			} else {
				mut var_transition_note := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order status set to %s.'), rt.new_string('woocommerce')]), rt.call_function('wc_get_order_status_name', [var_status_transition.array_get(rt.new_string('to'))])])
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				this.add_status_transition_note(var_transition_note.clone(), var_status_transition.clone())
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_3 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		if !(!rt.is_true(var_status_transition.array_get(rt.new_string('from')))) {
			rt.call_function('do_action', [rt.new_string('woocommerce_order_status_' + (var_status_transition.array_get(rt.new_string('from'))).str() + '_to_' + (var_status_transition.array_get(rt.new_string('to'))).str()), this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			rt.call_function('do_action', [rt.new_string('woocommerce_order_status_changed'), this.get_id(), var_status_transition.array_get(rt.new_string('from')), var_status_transition.array_get(rt.new_string('to')), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			mut var_valid_order_statuses_for_payment := rt.call_function('apply_filters', [rt.new_string('woocommerce_valid_order_statuses_for_payment'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }]), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			if rt.is_true(rt.call_function('in_array', [var_status_transition.array_get(rt.new_string('from')), var_valid_order_statuses_for_payment.clone(), rt.new_bool(true)])) && rt.is_true(rt.call_function('in_array', [var_status_transition.array_get(rt.new_string('to')), rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{}), rt.new_bool(true)])) {
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
			mut var_e := var_e_3.clone()
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
		if !(!rt.is_true(var_changed_props.array_get(rt.new_string(sub)))) {
			mut iter_2 := var_changed_props.array_get(rt.new_string(sub)).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_value := item_2.val
				mut var_sub_prop := item_2.key
				var_changed_props.array_set(sub + '_' + (var_sub_prop).str(), var_value.clone())
			}
		}
	}
	if var_changed_props.array_isset(rt.new_string('customer_note')) {
		var_changed_props.array_set('post_excerpt', var_changed_props.array_get(rt.new_string('customer_note')))
	}
	return var_changed_props.clone()
}

fn (mut this Class_WC_Order) get_order_number() string {
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_number'), this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])).str()
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
	if rt.is_true(rt.new_bool(this.data.array_get(rt.new_string(address_type)).array_isset(var_prop.clone()))) {
		var_value = if rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'changes').array_get(rt.new_string(address_type)).array_isset(var_prop) { rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'changes').array_get(rt.new_string(address_type)).array_get(var_prop) } else { this.data.array_get(rt.new_string(address_type)).array_get(var_prop) }
		if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
		var_value = rt.call_function('apply_filters', [rt.new_string((this.get_hook_prefix()).str() + address_type + '_' + (var_prop).str()), var_value.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
		}
	}
	return var_value.clone()
}

fn (mut this Class_WC_Order) get_billing_first_name(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('first_name'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_last_name(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('last_name'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_company(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('company'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_address_1(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('address_1'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_address_2(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('address_2'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_city(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('city'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_state(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('state'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_postcode(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('postcode'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_country(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('country'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_email(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('email'), 'billing', context)
}

fn (mut this Class_WC_Order) get_billing_phone(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('phone'), 'billing', context)
}

fn (mut this Class_WC_Order) get_shipping_first_name(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('first_name'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_last_name(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('last_name'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_company(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('company'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_address_1(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('address_1'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_address_2(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('address_2'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_city(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('city'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_state(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('state'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_postcode(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('postcode'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_country(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('country'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_shipping_phone(context string) rt.PhpVal {
	return this.get_address_prop(rt.new_string('phone'), 'shipping', context)
}

fn (mut this Class_WC_Order) get_payment_method(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('payment_method'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_payment_method_title(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('payment_method_title'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_transaction_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('transaction_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_customer_ip_address(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('customer_ip_address'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_customer_user_agent(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('customer_user_agent'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_created_via(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('created_via'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_customer_note(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('customer_note'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_date_completed(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_completed'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_date_paid(context string) rt.PhpVal {
	mut var_date_paid := this.get_prop(rt.new_string('date_paid'), rt.new_string(context))
	if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) && rt.is_true(rt.new_bool(!(rt.is_true(var_date_paid)))) && rt.is_true(rt.call_function('version_compare', [this.get_version(rt.new_string('edit')), rt.new_string('3.0'), rt.new_string('<')])) && rt.is_true(this.has_status(rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_complete_order_status'), if rt.is_true(this.needs_processing()) { Class_Automattic_WooCommerce_Enums_OrderStatus.processing() } else { Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, this.get_id(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)]))) {
	var_date_paid = this.get_date_created(rt.new_string('edit'))
	}
	return var_date_paid.clone()
}

fn (mut this Class_WC_Order) get_cart_hash(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('cart_hash'), rt.new_string(context))
}

fn (mut this Class_WC_Order) get_address(address_type string) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_order_address'), rt.call_function('array_merge', [this.data.array_get(rt.new_string(address_type)), this.get_prop(rt.new_string(address_type), rt.new_string('view'))]), rt.new_string(address_type), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) get_shipping_address_map_url() rt.PhpVal {
	mut var_address := this.get_address('shipping')
	var_address.array_unset(rt.new_string('first_name'))
	var_address.array_unset(rt.new_string('last_name'))
	var_address.array_unset(rt.new_string('company'))
	var_address.array_unset(rt.new_string('phone'))
	var_address = rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_address_map_url_parts'), var_address.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_address_map_url'), rt.new_string('https://maps.google.com/maps?&q=' + (rt.call_function('rawurlencode', [rt.call_function('implode', [rt.new_string(', '), var_address.clone()])])).str() + '&z=16'), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) get_formatted_billing_full_name() rt.PhpVal {
	return rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s %2$s'), rt.new_string('full name'), rt.new_string('woocommerce')]), this.get_billing_first_name(''), this.get_billing_last_name('')])
}

fn (mut this Class_WC_Order) get_formatted_shipping_full_name() rt.PhpVal {
	return rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s %2$s'), rt.new_string('full name'), rt.new_string('woocommerce')]), this.get_shipping_first_name(''), this.get_shipping_last_name('')])
}

fn (mut this Class_WC_Order) get_formatted_billing_address(empty_content string) rt.PhpVal {
	mut var_raw_address := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_formatted_billing_address'), this.get_address('billing'), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	mut var_address := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_formatted_address', [var_raw_address.clone()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_formatted_billing_address'), if rt.is_true(var_address) { var_address } else { rt.new_string(empty_content) }, var_raw_address.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) get_formatted_shipping_address(empty_content string) rt.PhpVal {
	mut var_address := rt.new_string('')
	mut var_raw_address := this.get_address('shipping')
	if this.has_shipping_address() {
	var_raw_address = rt.call_function('apply_filters', [rt.new_string('woocommerce_order_formatted_shipping_address'), var_raw_address.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	var_address = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_formatted_address', [var_raw_address.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_formatted_shipping_address'), if rt.is_true(var_address) { var_address } else { rt.new_string(empty_content) }, var_raw_address.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) has_billing_address() bool {
	return rt.is_true(this.get_billing_address_1('')) || rt.is_true(this.get_billing_address_2(''))
}

fn (mut this Class_WC_Order) has_shipping_address() bool {
	return rt.is_true(this.get_shipping_address_1('')) || rt.is_true(this.get_shipping_address_2(''))
}

fn (mut this Class_WC_Order) get_order_stock_reduced(context string) rt.PhpVal {
	return rt.call_function('wc_string_to_bool', [this.get_prop(rt.new_string('order_stock_reduced'), rt.new_string(context))])
}

fn (mut this Class_WC_Order) get_download_permissions_granted(context string) rt.PhpVal {
	return rt.call_function('wc_string_to_bool', [this.get_prop(rt.new_string('download_permissions_granted'), rt.new_string(context))])
}

fn (mut this Class_WC_Order) get_new_order_email_sent(context string) rt.PhpVal {
	return rt.call_function('wc_string_to_bool', [this.get_prop(rt.new_string('new_order_email_sent'), rt.new_string(context))])
}

fn (mut this Class_WC_Order) get_recorded_sales(context string) rt.PhpVal {
	return rt.call_function('wc_string_to_bool', [this.get_prop(rt.new_string('recorded_sales'), rt.new_string(context))])
}

fn (mut this Class_WC_Order) set_address_prop(var_prop rt.PhpVal, var_address_type rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(this.data.array_get(var_address_type).array_isset(var_prop.clone()))) {
		if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'object_read'))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value_mutated, this.data.array_get(var_address_type).array_get(var_prop))))) || (rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'changes').array_isset(var_address_type) && rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'changes').array_get(var_address_type).array_isset(var_prop.clone())))) {
				rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'changes').array_get_mut(var_address_type).array_set(var_prop, var_value_mutated.clone())
			}
		} else {
			this.data.array_get_mut(var_address_type).array_set(var_prop, var_value_mutated.clone())
		}
	}
}

fn (mut this Class_WC_Order) set_billing_address(mut var_address Class_array) {
	mut var_address_mutated := var_address
	mut iter_3 := var_address_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		this.set_address_prop(var_key.clone(), rt.new_string('billing'), var_value.clone())
	}
}

fn (mut this Class_WC_Order) set_billing(mut var_address Class_array) {
	mut var_address_mutated := var_address
	this.set_billing_address(mut var_address_mutated)
}

fn (mut this Class_WC_Order) set_shipping_address(mut var_address Class_array) {
	mut var_address_mutated := var_address
	mut iter_4 := var_address_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		this.set_address_prop(var_key.clone(), rt.new_string('shipping'), var_value.clone())
	}
}

fn (mut this Class_WC_Order) set_shipping(mut var_address Class_array) {
	mut var_address_mutated := var_address
	this.set_shipping_address(mut var_address_mutated)
}

fn (mut this Class_WC_Order) set_order_key(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('order_key'), rt.call_function('substr', [var_value_mutated.clone(), rt.new_int(0), rt.new_int(22)]))
}

fn (mut this Class_WC_Order) set_customer_id(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('customer_id'), rt.call_function('absint', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order) set_billing_first_name(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('first_name'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_last_name(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('last_name'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_company(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('company'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_address_1(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('address_1'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_address_2(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('address_2'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_city(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('city'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_state(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('state'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_postcode(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('postcode'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_billing_country(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('country'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) maybe_set_user_billing_email() {
	mut var_user := this.get_user()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_billing_email(''))))) && rt.is_true(var_user) {
		this.set_billing_email(rt.get_property(var_user, 'user_email'))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		unsafe { goto end_label_4 }

catch_label_4:
		mut var_e_4 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_4, 'WC_Data_Exception') {
			mut var_e := var_e_4.clone()
			var_e = rt.new_null()
			unsafe { goto end_label_4 }
		}
		else {
			rt.throw_exception(var_e_4)
			unsafe { goto end_label_4 }
		}

end_label_4:
	}
}

fn (mut this Class_WC_Order) set_billing_email(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(var_value_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_value_mutated.clone()]))))) {
		this.error(rt.new_string('order_invalid_billing_email'), rt.call_function('__', [rt.new_string('Invalid billing email address'), rt.new_string('woocommerce')]))
	}
	this.set_address_prop(rt.new_string('email'), rt.new_string('billing'), rt.call_function('sanitize_email', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order) set_billing_phone(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('phone'), rt.new_string('billing'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_first_name(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('first_name'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_last_name(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('last_name'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_company(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('company'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_address_1(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('address_1'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_address_2(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('address_2'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_city(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('city'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_state(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('state'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_postcode(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('postcode'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_country(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('country'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_shipping_phone(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_address_prop(rt.new_string('phone'), rt.new_string('shipping'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_payment_method(payment_method string) {
	mut payment_method_mutated := payment_method
	if rt.is_true(rt.new_bool(rt.new_string(payment_method_mutated).clone().is_object())) {
		this.set_payment_method((rt.get_property(rt.new_string(payment_method_mutated), 'id')).str())
		this.set_payment_method_title(rt.call_method(rt.new_string(payment_method_mutated), 'get_title', []rt.PhpVal{}))
	} else if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(payment_method_mutated))) {
		this.set_prop(rt.new_string('payment_method'), rt.new_string(''))
		this.set_prop(rt.new_string('payment_method_title'), rt.new_string(''))
	} else {
		this.set_prop(rt.new_string('payment_method'), rt.new_string(payment_method_mutated))
	}
}

fn (mut this Class_WC_Order) set_payment_method_title(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('payment_method_title'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_transaction_id(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('transaction_id'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_customer_ip_address(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('customer_ip_address'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_customer_user_agent(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('customer_user_agent'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_created_via(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('created_via'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_customer_note(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('customer_note'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_date_completed(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_completed'), var_date.clone())
}

fn (mut this Class_WC_Order) set_date_paid(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_paid'), var_date.clone())
}

fn (mut this Class_WC_Order) set_cart_hash(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('cart_hash'), var_value_mutated.clone())
}

fn (mut this Class_WC_Order) set_order_stock_reduced(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('order_stock_reduced'), rt.call_function('wc_string_to_bool', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order) set_download_permissions_granted(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('download_permissions_granted'), rt.call_function('wc_string_to_bool', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order) set_new_order_email_sent(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('new_order_email_sent'), rt.call_function('wc_string_to_bool', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order) set_recorded_sales(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('recorded_sales'), rt.call_function('wc_string_to_bool', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Order) key_is_valid(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('hash_equals', [this.get_order_key(''), var_key.clone()])
}

fn (mut this Class_WC_Order) has_cart_hash(cart_hash string) rt.PhpVal {
	return rt.call_function('hash_equals', [this.get_cart_hash(''), rt.new_string(cart_hash)])
	return rt.new_null()
}

fn (mut this Class_WC_Order) is_editable() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_order_is_editable'), rt.call_function('in_array', [this.get_status(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }]), rt.new_bool(true)]), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) is_paid() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_paid'), this.has_status(rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{})), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) is_download_permitted() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_download_permitted'), rt.new_bool(rt.is_true(this.has_status(Class_Automattic_WooCommerce_Enums_OrderStatus.completed())) || rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_downloads_grant_access_after_payment')]))) && rt.is_true(this.has_status(Class_Automattic_WooCommerce_Enums_OrderStatus.processing()))), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) needs_shipping_address() bool {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_calc_shipping')]))) {
		return false
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_2 := iife_temp_2.get_local_pickup_method_ids()
	mut var_hide := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_hide_shipping_address'), iife_result_2, rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	mut var_needs_address := rt.new_bool(false)
	mut iter_5 := this.get_shipping_methods().iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_shipping_method := item_5.val
		mut var_shipping_method_id := rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_shipping_method_id.clone(), var_hide.clone(), rt.new_bool(true)]))))) {
			var_needs_address = rt.new_bool(true)
			break
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_needs_shipping_address'), var_needs_address.clone(), var_hide.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])).to_bool()
}

fn (mut this Class_WC_Order) has_downloadable_item() bool {
	mut iter_6 := this.get_items().iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		if rt.is_true(rt.call_method(var_item, 'is_type', [rt.new_string('line_item')])) {
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			if rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'has_file', []rt.PhpVal{})) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WC_Order) get_downloadable_items() rt.PhpVal {
	mut var_downloads := []rt.PhpVal{}
	mut iter_7 := this.get_items().iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_item := item_7.val
		if !(var_item.clone().is_object()) {
			continue
		}
		mut var_refunded_qty := rt.call_function('abs', [this.get_qty_refunded_for_item(rt.call_method(var_item, 'get_id', []rt.PhpVal{}), '')])
		if rt.is_true(var_refunded_qty) && rt.is_true(rt.identical(rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), var_refunded_qty)) {
			continue
		}
		if rt.is_true(rt.call_method(var_item, 'is_type', [rt.new_string('line_item')])) {
			mut var_item_downloads := rt.call_method(var_item, 'get_item_downloads', []rt.PhpVal{})
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			if rt.is_true(var_product) && rt.is_true(var_item_downloads) {
				mut iter_8 := var_item_downloads.iterator()
				for {
					item_8 := iter_8.next() or { break }
					mut var_file := item_8.val
					var_downloads << rt.create_array([rt.ArrayItem{ key: 'download_url', val: var_file.array_get(rt.new_string('download_url')) }, rt.ArrayItem{ key: 'download_id', val: var_file.array_get(rt.new_string('id')) }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_name', val: rt.call_method(var_product, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_url', val: if rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{})) { rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'download_name', val: var_file.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'order_id', val: this.get_id() }, rt.ArrayItem{ key: 'order_key', val: this.get_order_key('') }, rt.ArrayItem{ key: 'downloads_remaining', val: var_file.array_get(rt.new_string('downloads_remaining')) }, rt.ArrayItem{ key: 'access_expires', val: var_file.array_get(rt.new_string('access_expires')) }, rt.ArrayItem{ key: 'file', val: rt.create_array([rt.ArrayItem{ key: 'name', val: var_file.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'file', val: var_file.array_get(rt.new_string('file')) }]) }])
				}
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_downloadable_items'), rt.create_array_from_list(var_downloads), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) needs_payment() rt.PhpVal {
	mut var_valid_order_statuses := rt.call_function('apply_filters', [rt.new_string('woocommerce_valid_order_statuses_for_payment'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }]), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_needs_payment'), rt.new_bool(rt.is_true(this.has_status(var_valid_order_statuses.clone())) && rt.is_true(rt.greater(this.get_total(), rt.new_int(0)))), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), var_valid_order_statuses.clone()])
}

fn (mut this Class_WC_Order) needs_processing() rt.PhpVal {
	mut var_order_id := this.get_id()
	mut var_cache_key := rt.new_string('order-needs-processing-' + (var_order_id).str())
	mut var_needs_processing := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('orders')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_needs_processing)) {
		var_needs_processing = rt.new_int(0)
		mut var_line_items := this.get_items()
		if var_line_items.clone().array_count() > 0 {
			mut iter_9 := var_line_items.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_item := item_9.val
				if rt.is_true(rt.call_method(var_item, 'is_type', [rt.new_string('line_item')])) {
					mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
					if rt.is_true(var_product) {
						mut var_virtual_downloadable_item := rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product, 'is_virtual', []rt.PhpVal{})))
						mut var_custom_needs_processing := rt.new_bool((rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_needs_processing'), rt.new_bool(!(rt.is_true(var_virtual_downloadable_item))), var_product.clone(), var_order_id.clone()])).to_bool())
						if rt.is_true(var_custom_needs_processing) {
							var_needs_processing = rt.new_int(1)
							break
						}
					}
				}
			}
		}
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_needs_processing.clone(), rt.new_string('orders'), rt.get_constant('DAY_IN_SECONDS')])
	}
	return rt.identical(rt.new_int(1), rt.call_function('absint', [var_needs_processing.clone()]))
}

fn (mut this Class_WC_Order) get_checkout_payment_url(on_checkout bool) rt.PhpVal {
	mut var_pay_url := rt.call_function('wc_get_endpoint_url', [rt.new_string('order-pay'), this.get_id(), rt.call_function('wc_get_checkout_url', []rt.PhpVal{})])
	if var_on_checkout {
	var_pay_url = rt.call_function('add_query_arg', [rt.new_string('key'), this.get_order_key(''), var_pay_url.clone()])
	} else {
	var_pay_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'pay_for_order', val: 'true' }, rt.ArrayItem{ key: 'key', val: this.get_order_key('') }]), var_pay_url.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_checkout_payment_url'), var_pay_url.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) get_checkout_order_received_url() rt.PhpVal {
	mut var_order_received_url := rt.call_function('wc_get_endpoint_url', [rt.new_string('order-received'), this.get_id(), rt.call_function('wc_get_checkout_url', []rt.PhpVal{})])
	var_order_received_url = rt.call_function('add_query_arg', [rt.new_string('key'), this.get_order_key(''), var_order_received_url.clone()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_checkout_order_received_url'), var_order_received_url.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) get_cancel_order_url(redirect string) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_cancel_order_url'), rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'cancel_order', val: 'true' }, rt.ArrayItem{ key: 'order', val: this.get_order_key('') }, rt.ArrayItem{ key: 'order_id', val: this.get_id() }, rt.ArrayItem{ key: 'redirect', val: redirect }]), this.get_cancel_endpoint()]), rt.new_string('woocommerce-cancel_order')]), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), rt.new_string(redirect)])
}

fn (mut this Class_WC_Order) get_cancel_order_url_raw(redirect string) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_cancel_order_url_raw'), rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'cancel_order', val: 'true' }, rt.ArrayItem{ key: 'order', val: this.get_order_key('') }, rt.ArrayItem{ key: 'order_id', val: this.get_id() }, rt.ArrayItem{ key: 'redirect', val: redirect }, rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [rt.new_string('woocommerce-cancel_order')]) }]), this.get_cancel_endpoint()]), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), rt.new_string(redirect)])
}

fn (mut this Class_WC_Order) get_cancel_endpoint() rt.PhpVal {
	mut var_cancel_endpoint := rt.call_function('wc_get_cart_url', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cancel_endpoint)))) {
	var_cancel_endpoint = rt.call_function('home_url', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_cancel_endpoint.clone(), rt.new_string('?')]))) {
	var_cancel_endpoint = rt.call_function('trailingslashit', [var_cancel_endpoint.clone()])
	}
	return var_cancel_endpoint.clone()
}

fn (mut this Class_WC_Order) get_view_order_url() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_view_order_url'), rt.call_function('wc_get_endpoint_url', [rt.new_string('view-order'), this.get_id(), rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])]), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) get_edit_order_url() rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_3 := iife_temp_3.get_order_admin_edit_url(this.get_id())
	mut var_edit_url := iife_result_3
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_edit_order_url'), var_edit_url.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) add_order_note(var_note rt.PhpVal, is_customer_note i64, added_by_user bool, var_meta_data rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		return 0
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders'), this.get_id()])) && var_added_by_user {
	mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
	mut var_comment_author := rt.get_property(var_user, 'display_name')
	mut var_comment_author_email := rt.get_property(var_user, 'user_email')
	} else {
		var_comment_author = rt.call_function('__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')])
		var_comment_author_email = rt.new_string((rt.call_function('__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')]).to_string().to_lower() + '@').str())
		var_comment_author_email = rt.concat(var_comment_author_email, if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_HOST')) { rt.call_function('str_replace', [rt.new_string('www.'), rt.new_string(''), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))])])]) } else { rt.new_string('noreply.com') })
	var_comment_author_email = rt.call_function('sanitize_email', [var_comment_author_email.clone()])
	}
	mut var_commentdata := rt.call_function('apply_filters', [rt.new_string('woocommerce_new_order_note_data'), rt.create_array([rt.ArrayItem{ key: 'comment_post_ID', val: this.get_id() }, rt.ArrayItem{ key: 'comment_author', val: var_comment_author }, rt.ArrayItem{ key: 'comment_author_email', val: var_comment_author_email }, rt.ArrayItem{ key: 'comment_author_url', val: '' }, rt.ArrayItem{ key: 'comment_content', val: var_note }, rt.ArrayItem{ key: 'comment_agent', val: 'WooCommerce' }, rt.ArrayItem{ key: 'comment_type', val: 'order_note' }, rt.ArrayItem{ key: 'comment_parent', val: 0 }, rt.ArrayItem{ key: 'comment_approved', val: 1 }]), rt.create_array([rt.ArrayItem{ key: 'order_id', val: this.get_id() }, rt.ArrayItem{ key: 'is_customer_note', val: is_customer_note }])])
	mut var_comment_id := rt.call_function('wp_insert_comment', [var_commentdata.clone()])
	if var_is_customer_note != 0 {
		rt.call_function('add_comment_meta', [var_comment_id.clone(), rt.new_string('is_customer_note'), rt.new_int(1)])
		rt.call_function('do_action', [rt.new_string('woocommerce_new_customer_note'), rt.create_array([rt.ArrayItem{ key: 'order_id', val: this.get_id() }, rt.ArrayItem{ key: 'customer_note', val: var_commentdata.array_get(rt.new_string('comment_content')) }])])
	}
	if !(!rt.is_true(var_meta_data)) && var_meta_data.clone().is_array() {
		mut iter_10 := var_meta_data.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_value := item_10.val
			mut var_key := item_10.key
			if rt.is_true(rt.call_function('is_scalar', [var_value.clone()])) {
				rt.call_function('update_comment_meta', [var_comment_id.clone(), rt.call_function('sanitize_key', [var_key.clone()]), rt.call_function('sanitize_text_field', [var_value.clone()])])
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_note_added'), var_comment_id.clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	return (var_comment_id).to_i64()
}

fn (mut this Class_WC_Order) add_status_transition_note(var_note rt.PhpVal, var_transition rt.PhpVal) rt.PhpVal {
	return rt.new_int(this.add_order_note(rt.new_string((var_transition.array_get(rt.new_string('note'))).str() + ' ' + (var_note).str().trim_space()), 0, (var_transition.array_get(rt.new_string('manual'))).to_bool(), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update() }])))
}

fn (mut this Class_WC_Order) get_customer_order_notes() rt.PhpVal {
	mut var_notes := []rt.PhpVal{}
	mut var_args := { 'post_id': this.get_id(), 'approve': rt.new_string('approve'), 'type': rt.new_string('') }
	rt.call_function('remove_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }])])
	mut var_comments := rt.call_function('get_comments', [rt.create_array_from_native_map(var_args)])
	mut iter_11 := var_comments.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_comment := item_11.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_comment_meta', [rt.get_property(var_comment, 'comment_ID'), rt.new_string('is_customer_note'), rt.new_bool(true)]))))) {
			continue
		}
		rt.set_property(var_comment, 'comment_content', rt.call_function('make_clickable', [rt.get_property(var_comment, 'comment_content')]))
		var_notes << var_comment.clone()
	}
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }])])
	return var_notes.clone()
}

fn (mut this Class_WC_Order) get_refunds() rt.PhpVal {
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.get_cache_prefix(rt.new_string('orders'))
	mut var_cache_key := rt.new_string((iife_result_4).str() + 'refund_ids' + (this.get_id()).str())
	mut var_refund_ids := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_refund_ids)) {
		mut var_refunds := rt.cast_array(rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'type', val: 'shop_order_refund' }, rt.ArrayItem{ key: 'parent', val: this.get_id() }, rt.ArrayItem{ key: 'limit', val: -1 }])]))
		var_refund_ids = []rt.PhpVal{}
		mut iter_12 := var_refunds.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_refund := item_12.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_refund, 'WC_Order_Refund'))) {
				var_refund_ids.array_push(rt.call_method(var_refund, 'get_id', []rt.PhpVal{}))
			}
		}
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_refund_ids.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	} else {
	var_refunds = if !(!rt.is_true(var_refund_ids)) { rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'type', val: 'shop_order_refund' }, rt.ArrayItem{ key: 'post__in', val: var_refund_ids }, rt.ArrayItem{ key: 'orderby', val: 'post__in' }, rt.ArrayItem{ key: 'limit', val: -1 }, rt.ArrayItem{ key: 'no_found_rows', val: true }])]) } else { []rt.PhpVal{} }
	}
	this.refunds = []rt.PhpVal{}
	if !(!rt.is_true(var_refunds)) && var_refunds.clone().is_array() {
		mut iter_13 := var_refunds.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_refund := item_13.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_refund, 'WC_Order_Refund'))) {
				this.refunds.array_push(var_refund.clone())
			}
		}
	}
	return this.refunds
}

fn (mut this Class_WC_Order) get_total_refunded() rt.PhpVal {
	mut iife_temp_5 := Class_WC_Cache_Helper{}
	mut iife_result_5 := iife_temp_5.get_cache_prefix(rt.new_string('orders'))
	mut var_cache_key := rt.new_string((iife_result_5).str() + 'total_refunded' + (this.get_id()).str())
	mut var_cached_data := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached_data)))) {
		return var_cached_data.clone()
	}
	mut var_total_refunded := rt.call_method(rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'data_store'), 'get_total_refunded', [rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_total_refunded.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	return var_total_refunded.clone()
}

fn (mut this Class_WC_Order) get_total_tax_refunded() rt.PhpVal {
	mut iife_temp_6 := Class_WC_Cache_Helper{}
	mut iife_result_6 := iife_temp_6.get_cache_prefix(rt.new_string('orders'))
	mut var_cache_key := rt.new_string((iife_result_6).str() + 'total_tax_refunded' + (this.get_id()).str())
	mut var_cached_data := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached_data)))) {
		return var_cached_data.clone()
	}
	mut var_total_refunded := rt.call_method(rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'data_store'), 'get_total_tax_refunded', [rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_total_refunded.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	return var_total_refunded.clone()
}

fn (mut this Class_WC_Order) get_total_shipping_tax_refunded() rt.PhpVal {
	mut iife_temp_7 := Class_WC_Cache_Helper{}
	mut iife_result_7 := iife_temp_7.get_cache_prefix(rt.new_string('orders'))
	mut var_cache_key := rt.new_string((iife_result_7).str() + 'total_shipping_tax_refunded' + (this.get_id()).str())
	mut var_cached_data := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached_data)))) {
		return var_cached_data.clone()
	}
	mut var_total_shipping_tax_refunded := rt.new_int(0)
	if rt.is_true(rt.call_function('method_exists', [rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'data_store'), rt.new_string('get_total_shipping_tax_refunded')])) {
	var_total_shipping_tax_refunded = rt.call_method(rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'data_store'), 'get_total_shipping_tax_refunded', [rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	}
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_total_shipping_tax_refunded.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	return var_total_shipping_tax_refunded.clone()
}

fn (mut this Class_WC_Order) get_total_shipping_refunded() rt.PhpVal {
	mut iife_temp_8 := Class_WC_Cache_Helper{}
	mut iife_result_8 := iife_temp_8.get_cache_prefix(rt.new_string('orders'))
	mut var_cache_key := rt.new_string((iife_result_8).str() + 'total_shipping_refunded' + (this.get_id()).str())
	mut var_cached_data := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached_data)))) {
		return var_cached_data.clone()
	}
	mut var_total_refunded := rt.call_method(rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'data_store'), 'get_total_shipping_refunded', [rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_total_refunded.clone(), rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'cache_group')])
	return var_total_refunded.clone()
}

fn (mut this Class_WC_Order) get_item_count_refunded(item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
	if item_type_mutated == '' {
	item_type_mutated = (rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' }])).str()
	}
	if !(rt.new_string(item_type_mutated).clone().is_array()) {
	item_type_mutated = (rt.create_array([rt.ArrayItem{ key: none, val: item_type_mutated }])).str()
	}
	mut var_count := rt.new_int(0)
	mut iter_14 := this.get_refunds().iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_refund := item_14.val
		mut iter_15 := rt.call_method(var_refund, 'get_items', [rt.new_string(item_type_mutated).clone()]).iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_refunded_item := item_15.val
			var_count = rt.add(var_count, rt.call_function('abs', [rt.call_method(var_refunded_item, 'get_quantity', []rt.PhpVal{})]))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_item_count_refunded'), var_count.clone(), rt.new_string(item_type_mutated).clone(), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])
}

fn (mut this Class_WC_Order) get_total_qty_refunded(item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
	mut var_qty := rt.new_int(0)
	mut iter_16 := this.get_refunds().iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_refund := item_16.val
		mut iter_17 := rt.call_method(var_refund, 'get_items', [rt.new_string(item_type_mutated).clone()]).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_refunded_item := item_17.val
			var_qty = rt.add(var_qty, rt.call_method(var_refunded_item, 'get_quantity', []rt.PhpVal{}))
		}
	}
	return var_qty.clone()
}

fn (mut this Class_WC_Order) get_qty_refunded_for_item(var_item_id rt.PhpVal, item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
	mut var_qty := rt.new_int(0)
	mut iter_18 := this.get_refunds().iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_refund := item_18.val
		mut iter_19 := rt.call_method(var_refund, 'get_items', [rt.new_string(item_type_mutated).clone()]).iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_refunded_item := item_19.val
			if rt.is_true(rt.identical(rt.call_function('absint', [rt.call_method(var_refunded_item, 'get_meta', [rt.new_string('_refunded_item_id')])]), var_item_id)) {
				var_qty = rt.add(var_qty, rt.call_method(var_refunded_item, 'get_quantity', []rt.PhpVal{}))
			}
		}
	}
	return var_qty.clone()
}

fn (mut this Class_WC_Order) get_cogs_refunded_for_item(var_item_id rt.PhpVal, item_type string) i64 {
	mut item_type_mutated := item_type
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))) || !(this.has_cogs()) {
		return 0
	}
	mut var_cogs_value := rt.new_int(0)
	mut iter_20 := this.get_refunds().iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_refund := item_20.val
		mut iter_21 := rt.call_method(var_refund, 'get_items', [rt.new_string(item_type_mutated).clone()]).iterator()
		for {
			item_21 := iter_21.next() or { break }
			mut var_refunded_item := item_21.val
			if rt.is_true(rt.identical(rt.call_function('absint', [rt.call_method(var_refunded_item, 'get_meta', [rt.new_string('_refunded_item_id')])]), var_item_id)) {
				var_cogs_value = rt.add(var_cogs_value, if rt.is_true(rt.call_method(var_refunded_item, 'has_cogs', []rt.PhpVal{})) { rt.call_method(var_refunded_item, 'get_cogs_value', []rt.PhpVal{}) } else { rt.new_int(0) })
			}
		}
	}
	return (var_cogs_value).to_i64()
}

fn (mut this Class_WC_Order) get_total_refunded_for_item(var_item_id rt.PhpVal, item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
	mut var_total := rt.new_int(0)
	mut iter_22 := this.get_refunds().iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_refund := item_22.val
		mut iter_23 := rt.call_method(var_refund, 'get_items', [rt.new_string(item_type_mutated).clone()]).iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_refunded_item := item_23.val
			if rt.is_true(rt.identical(rt.call_function('absint', [rt.call_method(var_refunded_item, 'get_meta', [rt.new_string('_refunded_item_id')])]), var_item_id)) {
				var_total = rt.add(var_total, rt.new_float((rt.call_method(var_refunded_item, 'get_total', []rt.PhpVal{})).to_f64()))
			}
		}
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_9 := iife_temp_9.round(rt.mul(var_total, -1), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	return iife_result_9
}

fn (mut this Class_WC_Order) get_tax_refunded_for_item(var_item_id rt.PhpVal, var_tax_id rt.PhpVal, item_type string) rt.PhpVal {
	mut item_type_mutated := item_type
	mut var_total := rt.new_int(0)
	mut iter_24 := this.get_refunds().iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_refund := item_24.val
		mut iter_25 := rt.call_method(var_refund, 'get_items', [rt.new_string(item_type_mutated).clone()]).iterator()
		for {
			item_25 := iter_25.next() or { break }
			mut var_refunded_item := item_25.val
			mut var_refunded_item_id := rt.new_int((rt.call_method(var_refunded_item, 'get_meta', [rt.new_string('_refunded_item_id')])).to_i64())
			if rt.is_true(rt.identical(var_refunded_item_id, var_item_id)) {
				mut var_taxes := rt.call_method(var_refunded_item, 'get_taxes', []rt.PhpVal{})
				var_total = rt.add(var_total, if var_taxes.array_get(rt.new_string('total')).array_isset(var_tax_id) { rt.new_float((var_taxes.array_get(rt.new_string('total')).array_get(var_tax_id)).to_f64()) } else { rt.new_int(0) })
				break
			}
		}
	}
	return rt.mul(rt.call_function('wc_round_tax_total', [var_total.clone()]), -1)
}

fn (mut this Class_WC_Order) get_total_tax_refunded_by_rate_id(var_rate_id rt.PhpVal) rt.PhpVal {
	mut var_total := rt.new_int(0)
	mut iter_26 := this.get_refunds().iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_refund := item_26.val
		mut iter_27 := rt.call_method(var_refund, 'get_items', [rt.new_string('tax')]).iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_refunded_item := item_27.val
			if rt.is_true(rt.identical(rt.call_function('absint', [rt.call_method(var_refunded_item, 'get_rate_id', []rt.PhpVal{})]), var_rate_id)) {
				var_total = rt.add(var_total, rt.add(rt.call_function('abs', [rt.call_method(var_refunded_item, 'get_tax_total', []rt.PhpVal{})]), rt.call_function('abs', [rt.call_method(var_refunded_item, 'get_shipping_tax_total', []rt.PhpVal{})])))
			}
		}
	}
	return var_total.clone()
}

fn (mut this Class_WC_Order) get_remaining_refund_amount() rt.PhpVal {
	return rt.call_function('wc_format_decimal', [rt.sub(this.get_total(), this.get_total_refunded()), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
}

fn (mut this Class_WC_Order) get_remaining_refund_items() rt.PhpVal {
	return rt.call_function('absint', [rt.sub(this.get_item_count(), this.get_item_count_refunded(''))])
}

fn (mut this Class_WC_Order) add_order_item_totals_payment_method_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	if rt.is_true(rt.greater(this.get_total(), rt.new_int(0))) && rt.is_true(this.get_payment_method_title('')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('other'), this.get_payment_method(''))))) {
		mut var_value := this.get_payment_method_title('')
		mut var_card_info := this.get_payment_card_info()
		if var_card_info.array_isset(rt.new_string('last4')) && rt.is_true(var_card_info.array_get(rt.new_string('last4'))) {
			var_value = rt.concat(var_value, rt.new_string(' - ' + (var_card_info.array_get(rt.new_string('last4'))).str()))
		}
		var_total_rows_mutated.array_set('payment_method', rt.create_array([rt.ArrayItem{ key: 'type', val: 'payment_method' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Payment method:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: var_value }]))
	}
}

fn (mut this Class_WC_Order) add_order_item_totals_refund_rows(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	mut var_refunds := this.get_refunds()
	if rt.is_true(var_refunds) {
		mut iter_28 := var_refunds.iterator()
		for {
			item_28 := iter_28.next() or { break }
			mut var_refund := item_28.val
			mut var_id := item_28.key
			mut var_reason := rt.new_string(rt.call_method(var_refund, 'get_reason', []rt.PhpVal{}).to_string().trim_space())
			if var_reason.clone().to_string().len > 0 {
			var_reason = rt.new_string("<br><small>${var_reason.to_string()}</small>")
			}
			var_total_rows_mutated.array_set('refund_' + (var_id).str(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'refund' }, rt.ArrayItem{ key: 'label', val: (rt.call_function('__', [rt.new_string('Refund'), rt.new_string('woocommerce')])).str() + ':' }, rt.ArrayItem{ key: 'value', val: (rt.call_function('wc_price', [rt.new_string('-' + (rt.call_method(var_refund, 'get_amount', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency() }])])).str() + (var_reason).str() }]))
		}
	}
}

fn (mut this Class_WC_Order) get_order_item_totals(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
	tax_display_mutated = (if rt.is_true(rt.new_string(tax_display_mutated)) { rt.new_string(tax_display_mutated) } else { rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')]) }).str()
	mut var_total_rows := []rt.PhpVal{}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_10 := iife_temp_10.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_10
	this.add_order_item_totals_subtotal_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_discount_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_shipping_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_fee_rows(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_tax_rows(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email_improvements_enabled)))) {
		this.add_order_item_totals_payment_method_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	}
	this.add_order_item_totals_refund_rows(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_total_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	if rt.is_true(var_email_improvements_enabled) {
		this.add_order_item_totals_payment_method_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_order_item_totals'), rt.create_array_from_native_map(var_total_rows), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), rt.new_string(tax_display_mutated).clone()])
}

fn (mut this Class_WC_Order) is_created_via(var_modus rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_created_via'), rt.identical(var_modus, this.get_created_via('')), rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), var_modus.clone()])
}

fn (mut this Class_WC_Order) untrash() bool {
	return (rt.call_method(rt.get_property(rt.new_object('WC_Order', ['WC_Abstract_Order'], &this), 'data_store'), 'untrash_order', [rt.new_object('WC_Order', ['WC_Abstract_Order'], &this)])).to_bool()
}

fn (mut this Class_WC_Order) has_cogs() bool {
	return true
}

fn (mut this Class_WC_Order) calculate_cogs_total_value_core() f64 {
	mut var_value := this.Class_WC_Abstract_Order.calculate_cogs_total_value_core()
	mut var_refunds := this.get_refunds()
	mut iter_29 := var_refunds.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_refund := item_29.val
		mut var_refund_items := rt.call_method(var_refund, 'get_items', []rt.PhpVal{})
		mut iter_30 := var_refund_items.iterator()
		for {
			item_30 := iter_30.next() or { break }
			mut var_refund_item := item_30.val
			if rt.is_true(rt.call_method(var_refund_item, 'has_cogs', []rt.PhpVal{})) {
				rt.call_method(var_refund_item, 'calculate_cogs_value', []rt.PhpVal{})
				var_value = rt.sub(var_value, rt.call_function('abs', [rt.call_method(var_refund_item, 'get_cogs_value', []rt.PhpVal{})]))
			}
		}
	}
	return (var_value).to_f64()
}

struct Class_WC_Abstract_Order {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
		status_transition: rt.new_bool(false)
		data: rt.new_array()
		legacy_datastore_props: rt.new_array()
		refunds: rt.new_array()
	}
	return obj
}

fn create_wc_abstract_order(_args ...rt.PhpVal) &Class_WC_Abstract_Order {
	mut obj := &Class_WC_Abstract_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
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
			return rt.new_string(this.get_order_number())
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
