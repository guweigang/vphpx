import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager {
	rt.PhpObjectBase
pub mut:
		fulfillment_order_notes rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) register() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_fulfillment_shipping_providers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_initial_shipping_providers' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_fulfillment_shipping_providers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_custom_shipping_providers' }]), rt.new_int(20), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_fulfillment_translate_meta_key'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'translate_fulfillment_meta_key' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_fulfillment_parse_tracking_number'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'try_parse_tracking_number' }]), rt.new_int(10), rt.new_int(3)])
	this.init_fulfillment_status_hooks()
	this.init_refund_hooks()
	this.init_email_template_tracking_hooks()
	this.init_order_deletion_hooks()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.fulfillment_order_notes)))) {
		this.fulfillment_order_notes = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes.class()])
	}
	rt.call_method(this.fulfillment_order_notes, 'register', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_fulfillment_status_hooks() {
	rt.call_function('add_action', [rt.new_string('woocommerce_fulfillment_after_create'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_order_fulfillment_status_on_fulfillment_update' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_fulfillment_after_update'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_order_fulfillment_status_on_fulfillment_update' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_fulfillment_after_delete'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_order_fulfillment_status_on_fulfillment_update' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_refund_hooks() {
	rt.call_function('add_action', [rt.new_string('woocommerce_refund_created'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_fulfillments_after_refund' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_delete_order_refund'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_fulfillment_status_after_refund_deleted' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_email_template_tracking_hooks() {
	mut var_fulfillment_email_ids := rt.create_array([rt.ArrayItem{ key: none, val: 'customer_fulfillment_created' }, rt.ArrayItem{ key: none, val: 'customer_fulfillment_updated' }, rt.ArrayItem{ key: none, val: 'customer_fulfillment_deleted' }])
	mut iter_1 := var_fulfillment_email_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_email_id := item_1.val
		closure_2_fn := fn [var_email_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
			mut iife_result_1 := iife_temp_1.track_fulfillment_email_template_customized(var_email_id.clone())
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('woocommerce_update_options_email_' + (var_email_id).str()), rt.new_closure(closure_2_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_order_deletion_hooks() {
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'delete_order_fulfillments' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('before_delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'delete_order_fulfillments' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) delete_order_fulfillments(order_id i64) {
	mut order_id_mutated := order_id
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.is_order(rt.new_int(order_id_mutated), rt.call_function('wc_get_order_types', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}
	mut iife_result_3 := iife_temp_3.load(rt.new_string('order-fulfillment'))
	mut var_fulfillments_data_store := iife_result_3
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_fulfillments_data_store, 'delete_by_entity', [Class_WC_Order.class(), rt.new_string(order_id_mutated.str())])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to delete fulfillments for order %d: %s'), rt.new_int(order_id_mutated).clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) translate_fulfillment_meta_key(var_meta_key rt.PhpVal) rt.PhpVal {
	mut var_meta_key_translations := rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_meta_key_translations'), rt.create_array([rt.ArrayItem{ key: 'fulfillment_status', val: rt.call_function('__', [rt.new_string('Fulfillment Status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipment_tracking', val: rt.call_function('__', [rt.new_string('Shipment Tracking'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipment_provider', val: rt.call_function('__', [rt.new_string('Shipment Provider'), rt.new_string('woocommerce')]) }])])
	return if var_meta_key_translations.array_isset(var_meta_key) { var_meta_key_translations.array_get(var_meta_key) } else { var_meta_key }
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) get_initial_shipping_providers(var_shipping_providers rt.PhpVal) rt.PhpVal {
	mut var_shipping_providers_mutated := var_shipping_providers
	if !(var_shipping_providers_mutated.clone().is_array()) {
	var_shipping_providers_mutated = rt.new_array()
	}
	var_shipping_providers_mutated = rt.call_function('array_merge', [var_shipping_providers_mutated.clone(), rt.include_file(@DIR + '/ShippingProviders.php', '1')])
	rt.call_function('ksort', [var_shipping_providers_mutated.clone()])
	return var_shipping_providers_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) get_custom_shipping_providers(var_shipping_providers rt.PhpVal) rt.PhpVal {
	mut var_shipping_providers_mutated := var_shipping_providers
	if !(var_shipping_providers_mutated.clone().is_array()) {
	var_shipping_providers_mutated = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string('wc_fulfillment_shipping_provider')]))))) {
		return var_shipping_providers_mutated.clone()
	}
	mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'wc_fulfillment_shipping_provider' }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) || !rt.is_true(var_terms) {
		return var_shipping_providers_mutated.clone()
	}
	mut iter_2 := var_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term := item_2.val
		mut var_icon := rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('icon'), rt.new_bool(true)])
		mut var_tracking_url_template := rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('tracking_url_template'), rt.new_bool(true)])
		var_shipping_providers_mutated.array_push(create_automattic_woocommerce_admin_features_fulfillments_providers_customshippingprovider(rt.get_property(var_term, 'slug'), rt.get_property(var_term, 'name'), if var_icon.clone().is_string() { var_icon } else { rt.new_string('') }, if var_tracking_url_template.clone().is_string() { var_tracking_url_template } else { rt.new_string('') }))
	}
	return var_shipping_providers_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_order_fulfillment_status_on_fulfillment_update(mut var_data Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) {
	if !(true) {
		return
	}
	mut var_order := var_data.get_order()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}
	mut iife_result_4 := iife_temp_4.load(rt.new_string('order-fulfillment'))
	mut var_fulfillments_data_store := iife_result_4
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [Class_WC_Order.class(), rt.new_string((rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str())])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_2.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %d: %s'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		return
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	this.update_fulfillment_status(var_order.clone(), var_fulfillments.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_fulfillment_status_after_refund_deleted(refund_id i64) {
	mut var_refund := rt.call_function('wc_get_order', [rt.new_int(refund_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_refund, 'WC_Order')))))) {
		return
	}
	mut var_order_id := rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}
	mut iife_result_5 := iife_temp_5.load(rt.new_string('order-fulfillment'))
	mut var_fulfillments_data_store := iife_result_5
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [Class_WC_Order.class(), rt.new_string((var_order_id).str())])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_3.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %d: %s'), var_order_id.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		return
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	this.update_fulfillment_status(var_order.clone(), var_fulfillments.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_fulfillments_after_refund(refund_id i64) {
	mut var_refund := if var_refund_id != 0 { rt.call_function('wc_get_order', [rt.new_int(refund_id)]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_refund, 'WC_Order_Refund')))))) {
		return
	}
	mut var_order_id := rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_6 := iife_temp_6.get_refunded_items(var_order.clone())
	mut var_items_refunded := iife_result_6
	if !rt.is_true(var_items_refunded) {
		return
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}
	mut iife_result_7 := iife_temp_7.load(rt.new_string('order-fulfillment'))
	mut var_fulfillments_data_store := iife_result_7
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [Class_WC_Order.class(), rt.new_string((var_order_id).str())])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_4.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %d: %s'), var_order_id.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		return
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	if !rt.is_true(var_fulfillments) {
		return
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_8 := iife_temp_8.get_pending_items(var_order.clone(), var_fulfillments.clone(), rt.new_bool(false))
	mut var_pending_items_without_refunds := iife_result_8
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	var_pending_items_without_refunds = rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_pending_items_without_refunds.clone()])
	mut iter_3 := var_items_refunded.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_refunded_qty := item_3.val
		mut var_item_id := item_3.key
		closure_12_fn := fn [var_item_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
			}
		mut var_pending_item_record := rt.call_function('array_filter', [var_pending_items_without_refunds.clone(), rt.new_closure(closure_12_fn)])
		if !(!rt.is_true(var_pending_item_record)) {
			var_pending_item_record = rt.call_function('reset', [var_pending_item_record.clone()])
			if var_pending_item_record.array_isset(rt.new_string('qty')) && rt.is_true(rt.greater(var_pending_item_record.array_get(rt.new_string('qty')), rt.new_int(0))) {
				var_refunded_qty = rt.sub(var_refunded_qty, var_pending_item_record.array_get(rt.new_string('qty')))
			}
		}
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_actual_qty := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	mut var_items_need_removal_from_fulfillments := rt.call_function('array_filter', [var_items_refunded.clone(), rt.new_closure(closure_13_fn)])
	if !rt.is_true(var_items_need_removal_from_fulfillments) {
		return
	}
	mut iter_4 := var_fulfillments.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_fulfillment := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_fulfillment, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment')))))) {
			continue
		}
		if rt.is_true(rt.call_method(var_fulfillment, 'get_is_fulfilled', []rt.PhpVal{})) {
			continue
		}
		mut var_items := rt.call_method(var_fulfillment, 'get_items', []rt.PhpVal{})
		if !rt.is_true(var_items) {
			continue
		}
		mut var_new_items := rt.new_array()
		mut iter_5 := var_items.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_item := item_5.val
			if var_item.array_isset(rt.new_string('qty')) && var_item.array_isset(rt.new_string('item_id')) && var_items_need_removal_from_fulfillments.array_isset(var_item.array_get(rt.new_string('item_id'))) {
				if rt.is_true(rt.less_equal(var_items_need_removal_from_fulfillments.array_get(var_item.array_get(rt.new_string('item_id'))), var_item.array_get(rt.new_string('qty')))) {
					var_item.array_get(rt.new_string('qty')) = rt.sub(var_item.array_get(rt.new_string('qty')), var_items_need_removal_from_fulfillments.array_get(var_item.array_get(rt.new_string('item_id'))))
					var_items_need_removal_from_fulfillments.array_set(var_item.array_get(rt.new_string('item_id')), 0)
				} else {
					var_item.array_set('qty', 0)
					var_items_need_removal_from_fulfillments.array_get(var_item.array_get(rt.new_string('item_id'))) = rt.sub(var_items_need_removal_from_fulfillments.array_get(var_item.array_get(rt.new_string('item_id'))), var_item.array_get(rt.new_string('qty')))
				}
				var_new_items.array_push(var_item.clone())
			} else {
				var_new_items.array_push(var_item.clone())
			}
		}
		closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
			return rt.new_null()
			}
		var_new_items = rt.call_function('array_filter', [var_new_items.clone(), rt.new_closure(closure_14_fn)])
		if !rt.is_true(var_new_items) {
			rt.call_method(var_fulfillment, 'delete', []rt.PhpVal{})
		} else {
			rt.call_method(var_fulfillment, 'set_items', [var_new_items.clone()])
			rt.call_method(var_fulfillment, 'save', []rt.PhpVal{})
		}
	}
	this.update_fulfillment_status(var_order.clone(), var_fulfillments.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_fulfillment_status(var_order rt.PhpVal, var_fulfillments rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_fulfillments_mutated := var_fulfillments
	mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_14 := iife_temp_14.get_order_fulfillment_status(var_order_mutated.clone())
	mut var_old_status := iife_result_14
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_15 := iife_temp_15.calculate_order_fulfillment_status(var_order_mutated.clone(), var_fulfillments_mutated.clone())
	mut var_new_status := iife_result_15
	if rt.is_true(rt.identical(rt.new_string('no_fulfillments'), var_new_status)) {
		rt.call_method(var_order_mutated, 'delete_meta_data', [rt.new_string('_fulfillment_status')])
	} else {
		rt.call_method(var_order_mutated, 'update_meta_data', [rt.new_string('_fulfillment_status'), var_new_status.clone()])
	}
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_status, var_new_status)))) && !(this.fulfillment_order_notes).is_null() {
		rt.call_method(this.fulfillment_order_notes, 'add_order_fulfillment_status_changed_note', [var_order_mutated.clone(), var_old_status.clone(), var_new_status.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut tracking_number_mutated := tracking_number
	if !(rt.new_string(tracking_number_mutated).clone().is_string()) || tracking_number_mutated == '' || tracking_number_mutated.len > 50 {
		tracking_number_mutated = (if rt.new_string(tracking_number_mutated).clone().is_string() && !(tracking_number_mutated == '') { rt.call_function('substr', [rt.new_string(tracking_number_mutated).clone(), rt.new_int(0), rt.new_int(50)]) } else { rt.new_string('') }).str()
		return rt.create_array([rt.ArrayItem{ key: 'tracking_number', val: tracking_number_mutated }, rt.ArrayItem{ key: 'shipping_provider', val: '' }, rt.ArrayItem{ key: 'tracking_url', val: '' }])
	}
	tracking_number_mutated = tracking_number_mutated.to_upper()
	tracking_number_mutated = (rt.call_function('preg_replace', [rt.new_string('/[^A-Z0-9]/'), rt.new_string(''), rt.new_string(tracking_number_mutated).clone()])).str()
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_16 := iife_temp_16.get_shipping_providers()
	mut var_shipping_providers := iife_result_16
	mut var_results := rt.new_array()
	mut iter_6 := var_shipping_providers.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_provider := item_6.val
		mut var_parsing_result := rt.call_method(var_provider, 'try_parse_tracking_number', [rt.new_string(tracking_number_mutated).clone(), rt.new_string(shipping_from), rt.new_string(shipping_to)])
		if !(var_parsing_result.clone().is_null()) {
			var_results.array_set(rt.call_method(var_provider, 'get_key', []rt.PhpVal{}), var_parsing_result.clone())
		}
	}
	if 1 == var_results.clone().array_count() {
	mut var_result := rt.call_function('reset', [var_results.clone()])
	mut var_key := rt.call_function('key', [var_results.clone()])
	var_results = rt.create_array([rt.ArrayItem{ key: 'tracking_number', val: tracking_number_mutated }, rt.ArrayItem{ key: 'shipping_provider', val: var_key }, rt.ArrayItem{ key: 'tracking_url', val: if !(var_result.array_get(rt.new_string('url'))).is_null() { var_result.array_get(rt.new_string('url')) } else { rt.new_string('') } }])
	} else if 1 < var_results.clone().array_count() {
		mut var_possibilities := var_results.clone()
		var_results = this.get_best_parsing_result(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_results), tracking_number_mutated)
		var_results.array_set('possibilities', var_possibilities.clone())
	}
	if var_results.array_isset(rt.new_string('shipping_provider')) {
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
	mut iife_result_17 := iife_temp_17.track_fulfillment_tracking_lookup_attempt(rt.new_string('success'), var_results.array_get(rt.new_string('shipping_provider')), rt.new_bool(!(!rt.is_true(var_results.array_get(rt.new_string('tracking_url'))))))
	} else {
	mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}
	mut iife_result_18 := iife_temp_18.track_fulfillment_tracking_lookup_attempt(rt.new_string('not_found'), rt.new_string(''), rt.new_bool(false))
	}
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) get_best_parsing_result(mut var_results Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array, tracking_number string) rt.PhpVal {
	mut var_results_mutated := var_results
	mut tracking_number_mutated := tracking_number
	mut var_best_result := rt.new_null()
	mut var_best_provider := rt.new_string('')
	mut var_best_score := rt.new_int(0)
	mut iter_7 := var_results_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_result := item_7.val
		mut var_provider_key := item_7.key
		if !(var_result.array_isset(rt.new_string('ambiguity_score'))) || !(var_result.array_get(rt.new_string('ambiguity_score')).is_long() || var_result.array_get(rt.new_string('ambiguity_score')).is_double()) {
			continue
		}
		if var_best_result.clone().is_null() || rt.is_true(rt.greater(var_result.array_get(rt.new_string('ambiguity_score')), var_best_score)) {
		var_best_result = var_result.clone()
		var_best_provider = var_provider_key
		var_best_score = var_result.array_get(rt.new_string('ambiguity_score'))
		}
	}
	return if var_best_result.clone().is_null() { rt.new_array() } else { rt.create_array([rt.ArrayItem{ key: 'tracking_number', val: tracking_number_mutated }, rt.ArrayItem{ key: 'shipping_provider', val: var_best_provider }, rt.ArrayItem{ key: 'tracking_url', val: var_best_result.array_get(rt.new_string('url')) }]) }
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager{
		PhpObjectBase: rt.PhpObjectBase{}
		fulfillment_order_notes: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentstracker(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{
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

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_customshippingprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init_fulfillment_status_hooks' {
			this.init_fulfillment_status_hooks()
			return rt.new_null()
		}
		'init_refund_hooks' {
			this.init_refund_hooks()
			return rt.new_null()
		}
		'init_email_template_tracking_hooks' {
			this.init_email_template_tracking_hooks()
			return rt.new_null()
		}
		'init_order_deletion_hooks' {
			this.init_order_deletion_hooks()
			return rt.new_null()
		}
		'delete_order_fulfillments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.delete_order_fulfillments(dispatch_arg_0)
			return rt.new_null()
		}
		'translate_fulfillment_meta_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.translate_fulfillment_meta_key(dispatch_arg_0)
		}
		'get_initial_shipping_providers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_initial_shipping_providers(dispatch_arg_0)
		}
		'get_custom_shipping_providers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_custom_shipping_providers(dispatch_arg_0)
		}
		'update_order_fulfillment_status_on_fulfillment_update' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 { args[0] } else { rt.new_null() })
			this.update_order_fulfillment_status_on_fulfillment_update(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_fulfillment_status_after_refund_deleted' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.update_fulfillment_status_after_refund_deleted(dispatch_arg_0)
			return rt.new_null()
		}
		'update_fulfillments_after_refund' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.update_fulfillments_after_refund(dispatch_arg_0)
			return rt.new_null()
		}
		'update_fulfillment_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_fulfillment_status(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'try_parse_tracking_number' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.try_parse_tracking_number(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_best_parsing_result' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_best_parsing_result(mut dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fulfillment_order_notes' { return this.fulfillment_order_notes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fulfillment_order_notes' { this.fulfillment_order_notes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
