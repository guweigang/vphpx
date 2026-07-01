import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager {
	rt.PhpObjectBase
pub mut:
		fulfillment_order_notes rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) register()  {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_fulfillment_status_hooks()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_fulfillment_after_create'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_order_fulfillment_status_on_fulfillment_update' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_fulfillment_after_update'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_order_fulfillment_status_on_fulfillment_update' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_fulfillment_after_delete'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_order_fulfillment_status_on_fulfillment_update' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_refund_hooks()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_refund_created'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_fulfillments_after_refund' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_delete_order_refund'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_fulfillment_status_after_refund_deleted' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_email_template_tracking_hooks()  {
	mut var_fulfillment_email_ids := rt.create_array([rt.ArrayItem{ key: none, val: 'customer_fulfillment_created' }, rt.ArrayItem{ key: none, val: 'customer_fulfillment_updated' }, rt.ArrayItem{ key: none, val: 'customer_fulfillment_deleted' }])
	{
		mut iter_1 := var_fulfillment_email_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email_id := item_1.val
			closure_1_fn := fn [var_email_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{}; return temp.track_fulfillment_email_template_customized(arg_0) }(var_email_id.dup())
	return rt.new_null()
	}
			rt.call_function('add_action', ['woocommerce_update_options_email_' + (var_email_id).str(), rt.new_closure(closure_1_fn)])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) init_order_deletion_hooks()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'delete_order_fulfillments' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('before_delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'delete_order_fulfillments' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) delete_order_fulfillments(order_id i64)  {
	mut order_id_mutated := order_id
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.is_order(arg_0, arg_1) }(rt.new_int(order_id_mutated), rt.call_function('wc_get_order_types', []rt.PhpVal{})))))) {
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_fulfillments_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_fulfillments_data_store, 'delete_by_entity', [Class_WC_Order.class(), // unsupported expression: Expr_Cast_String])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to delete fulfillments for order %d: %s'), rt.new_int(order_id_mutated).dup(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_shipping_providers_mutated.dup().is_array()))))) {
		var_shipping_providers_mutated = rt.new_array()
	}
	var_shipping_providers_mutated = rt.call_function('array_merge', [var_shipping_providers_mutated.dup(), rt.include_file(@DIR + '/ShippingProviders.php', '1')])
	rt.call_function('ksort', [var_shipping_providers_mutated.dup()])
	return var_shipping_providers_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) get_custom_shipping_providers(var_shipping_providers rt.PhpVal) rt.PhpVal {
	mut var_shipping_providers_mutated := var_shipping_providers
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_shipping_providers_mutated.dup().is_array()))))) {
		var_shipping_providers_mutated = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string('wc_fulfillment_shipping_provider')]))))) {
		return var_shipping_providers_mutated.dup()
	}
	mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'wc_fulfillment_shipping_provider' }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])) || !rt.is_true(var_terms))) {
		return var_shipping_providers_mutated.dup()
	}
	{
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_icon := rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('icon'), rt.new_bool(true)])
			mut var_tracking_url_template := rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('tracking_url_template'), rt.new_bool(true)])
			var_shipping_providers_mutated.array_push(create_automattic_woocommerce_admin_features_fulfillments_providers_customshippingprovider(rt.get_property(var_term, 'slug'), rt.get_property(var_term, 'name'), if rt.is_true(rt.new_bool(var_icon.dup().is_string())) { var_icon } else { rt.new_string('') }, if rt.is_true(rt.new_bool(var_tracking_url_template.dup().is_string())) { var_tracking_url_template } else { rt.new_string('') }))
		}
	}
	return var_shipping_providers_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_order_fulfillment_status_on_fulfillment_update(mut var_data Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment)  {
	if !(true) {
		return rt.new_null()
	}
	mut var_order := var_data.get_order()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
	}
	mut var_fulfillments_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment'))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [Class_WC_Order.class(), // unsupported expression: Expr_Cast_String])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %d: %s'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		return rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	this.update_fulfillment_status(var_order.dup(), var_fulfillments.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_fulfillment_status_after_refund_deleted(refund_id i64)  {
	mut var_refund := rt.call_function('wc_get_order', [rt.new_int(refund_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_refund, 'WC_Order')))))) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_order_id := rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_fulfillments_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment'))
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [Class_WC_Order.class(), // unsupported expression: Expr_Cast_String])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_3.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %d: %s'), var_order_id.dup(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		return rt.new_null()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	this.update_fulfillment_status(var_order.dup(), var_fulfillments.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_fulfillments_after_refund(refund_id i64)  {
	mut var_refund := if var_refund_id != 0 { rt.call_function('wc_get_order', [rt.new_int(refund_id)]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_refund, 'WC_Order_Refund')))))) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_order_id := rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_items_refunded := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_refunded_items(arg_0) }(var_order.dup())
	if !rt.is_true(var_items_refunded) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_fulfillments_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment'))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_fulfillments := rt.call_method(var_fulfillments_data_store, 'read_fulfillments', [Class_WC_Order.class(), // unsupported expression: Expr_Cast_String])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_4.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %d: %s'), var_order_id.dup(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		return rt.new_null()
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	if !rt.is_true(var_fulfillments) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	mut var_pending_items_without_refunds := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_pending_items(arg_0, arg_1, arg_2) }(var_order.dup(), var_fulfillments.dup(), rt.new_bool(false))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: .array_get() }, rt.ArrayItem{ key: 'qty', val: .array_get() }])
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: .array_get() }, rt.ArrayItem{ key: 'qty', val: .array_get() }])
	}
	var_pending_items_without_refunds = rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_pending_items_without_refunds.dup()])
	{
		mut iter_1 := var_items_refunded.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_refunded_qty := item_1.val
			mut var_item_id := item_1.key
			mut var_pending_item_record := rt.call_function('array_filter', [.dup(), ])
			if !(!rt.is_true(var_pending_item_record)) {
				
			}
		}
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) update_fulfillment_status(var_order rt.PhpVal, var_fulfillments rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_fulfillments_mutated := var_fulfillments
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut tracking_number_mutated := tracking_number
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager) get_best_parsing_result(mut var_results Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array, tracking_number string) rt.PhpVal {
	mut var_results_mutated := var_results
	mut tracking_number_mutated := tracking_number
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentsmanager() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsManager{
		PhpObjectBase: rt.PhpObjectBase{}
		fulfillment_order_notes: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentstracker() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data_store() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_customshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_fulfillmentsmanager_php() {
	// unsupported statement: Stmt_Declare
}
