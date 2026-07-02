import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) register() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_fulfillment_after_create'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_fulfillment_created_note' },
		]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_fulfillment_after_update'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_fulfillment_updated_note' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_fulfillment_after_delete'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_fulfillment_deleted_note' },
		]),
		rt.new_int(10),
		rt.new_int(1),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) add_fulfillment_created_note(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) {
	mut var_order := var_fulfillment.get_order()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order'))))))
	{
		return
	}
	mut var_items_text := rt.new_string(this.format_items(mut var_fulfillment, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order](var_order)))
	mut var_tracking_text := rt.new_string(this.format_tracking(mut var_fulfillment))
	mut var_status := if !(var_fulfillment.get_status()).is_null() {
		var_fulfillment.get_status()
	} else {
		rt.new_string('unfulfilled')
	}
	mut var_status_label := rt.new_string(this.get_fulfillment_status_label(var_status.str()))
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Fulfillment #%1$d created (status: %2$s). Items: %3$s.'),
			rt.new_string('woocommerce'),
		]),
		var_fulfillment.get_id(),
		var_status_label.clone(),
		var_items_text.clone(),
	])
	if !(!rt.is_true(var_tracking_text)) {
		var_message = rt.concat(var_message,
			rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Tracking: %s.'), rt.new_string('woocommerce')]), var_tracking_text.clone()])).str()))
	}
	var_message = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_fulfillment_created_order_note'),
		var_message.clone(),
		var_fulfillment,
		var_order.clone(),
	])
	var_message = rt.new_string(this.normalize_note_message(var_message.clone()))
	if rt.is_true(rt.identical(rt.new_null(), var_message)) {
		return
	}
	rt.call_method(var_order, 'add_order_note', [var_message.clone(),
		rt.new_int(0), rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{
				key: 'note_group'
				val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.fulfillment()
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) add_fulfillment_updated_note(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment, mut var_changes Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array, previous_status string) {
	if !rt.is_true(var_changes) {
		return
	}
	mut var_order := var_fulfillment.get_order()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order'))))))
	{
		return
	}
	if rt.is_true(rt.new_bool(var_changes.array_isset(rt.new_string('status')))) {
		mut var_new_status := if !(var_changes.array_get(rt.new_string('status'))).is_null() {
			var_changes.array_get(rt.new_string('status'))
		} else {
			rt.new_string('unfulfilled')
		}
		this.add_fulfillment_status_changed_note(mut var_fulfillment, mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order](var_order),
			previous_status, var_new_status.str())
		return
	}
	mut var_items_text := rt.new_string(this.format_items(mut var_fulfillment, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order](var_order)))
	mut var_tracking_text := rt.new_string(this.format_tracking(mut var_fulfillment))
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Fulfillment #%1$d updated. Items: %2$s.'),
			rt.new_string('woocommerce')]),
		var_fulfillment.get_id(),
		var_items_text.clone(),
	])
	if !(!rt.is_true(var_tracking_text)) {
		var_message = rt.concat(var_message,
			rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Tracking: %s.'), rt.new_string('woocommerce')]), var_tracking_text.clone()])).str()))
	}
	var_message = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_fulfillment_updated_order_note'),
		var_message.clone(),
		var_fulfillment,
		var_order.clone(),
	])
	var_message = rt.new_string(this.normalize_note_message(var_message.clone()))
	if rt.is_true(rt.identical(rt.new_null(), var_message)) {
		return
	}
	rt.call_method(var_order, 'add_order_note', [var_message.clone(),
		rt.new_int(0), rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{
				key: 'note_group'
				val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.fulfillment()
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) add_fulfillment_deleted_note(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) {
	mut var_order := var_fulfillment.get_order()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order,
		'Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order'))))))
	{
		return
	}
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Fulfillment #%d deleted.'),
			rt.new_string('woocommerce')]),
		var_fulfillment.get_id(),
	])
	var_message = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_fulfillment_deleted_order_note'),
		var_message.clone(),
		var_fulfillment,
		var_order.clone(),
	])
	var_message = rt.new_string(this.normalize_note_message(var_message.clone()))
	if rt.is_true(rt.identical(rt.new_null(), var_message)) {
		return
	}
	rt.call_method(var_order, 'add_order_note', [var_message.clone(),
		rt.new_int(0), rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{
				key: 'note_group'
				val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.fulfillment()
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) add_order_fulfillment_status_changed_note(mut var_order Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order, old_status string, new_status string) {
	mut var_order_mutated := var_order
	mut new_status_mutated := new_status
	mut var_old_status_label := rt.new_string(this.get_order_fulfillment_status_label(old_status))
	mut var_new_status_label :=
		rt.new_string(this.get_order_fulfillment_status_label(new_status_mutated))
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Order fulfillment status changed from %1$s to %2$s.'),
			rt.new_string('woocommerce'),
		]),
		var_old_status_label.clone(),
		var_new_status_label.clone(),
	])
	var_message = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_fulfillment_order_status_changed_order_note'),
		var_message.clone(),
		var_order_mutated,
		rt.new_string(old_status),
		rt.new_string(new_status_mutated).clone(),
	])
	var_message = rt.new_string(this.normalize_note_message(var_message.clone()))
	if rt.is_true(rt.identical(rt.new_null(), var_message)) {
		return
	}
	rt.call_method(var_order_mutated, 'add_order_note', [var_message.clone(),
		rt.new_int(0), rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{
				key: 'note_group'
				val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.fulfillment()
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) add_fulfillment_status_changed_note(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment, mut var_order Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order, old_status string, new_status string) {
	mut var_order_mutated := var_order
	mut new_status_mutated := new_status
	mut var_old_status_label := rt.new_string(this.get_fulfillment_status_label(old_status))
	mut var_new_status_label := rt.new_string(this.get_fulfillment_status_label(new_status_mutated))
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Fulfillment #%1$d status changed from %2$s to %3$s.'),
			rt.new_string('woocommerce'),
		]),
		var_fulfillment.get_id(),
		var_old_status_label.clone(),
		var_new_status_label.clone(),
	])
	var_message = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_fulfillment_status_changed_order_note'),
		var_message.clone(),
		var_fulfillment,
		var_order_mutated,
		rt.new_string(old_status),
		rt.new_string(new_status_mutated).clone(),
	])
	var_message = rt.new_string(this.normalize_note_message(var_message.clone()))
	if rt.is_true(rt.identical(rt.new_null(), var_message)) {
		return
	}
	rt.call_method(var_order_mutated, 'add_order_note', [var_message.clone(),
		rt.new_int(0), rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{
				key: 'note_group'
				val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.fulfillment()
			},
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) format_items(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment, mut var_order Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order) string {
	mut var_order_mutated := var_order
	mut var_items := var_fulfillment.get_items()
	mut var_order_items := rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{})
	mut var_parts := rt.new_array()
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_item_id := rt.new_int(if var_item.array_isset(rt.new_string('item_id')) {
			rt.new_int((var_item.array_get(rt.new_string('item_id'))).to_i64())
		} else {
			0
		})
		mut var_qty := rt.new_int(if var_item.array_isset(rt.new_string('qty')) {
			rt.new_int((var_item.array_get(rt.new_string('qty'))).to_i64())
		} else {
			0
		})
		mut var_name := rt.new_string('')
		mut iter_2 := var_order_items.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_order_item := item_2.val
			if rt.is_true(rt.identical(rt.new_int((rt.call_method(var_order_item, 'get_id',
				[]rt.PhpVal{})).to_i64()), var_item_id))
			{
				var_name = rt.call_method(var_order_item, 'get_name', []rt.PhpVal{})
				break
			}
		}
		if !rt.is_true(var_name) {
			var_name = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Item #%d'),
					rt.new_string('woocommerce')]),
				var_item_id.clone(),
			])
		}
		var_parts.array_push(rt.call_function('sprintf', [rt.new_string('%s x%s'),
			var_name.clone(), var_qty.clone()]))
	}
	return (rt.call_function('implode', [rt.new_string(', '),
		var_parts.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) format_tracking(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) string {
	mut var_tracking_number := var_fulfillment.get_tracking_number()
	mut var_shipping_provider := var_fulfillment.get_shipment_provider()
	mut var_tracking_url := var_fulfillment.get_tracking_url()
	if rt.is_true(rt.identical(rt.new_null(), var_tracking_number)) {
		return ''
	}
	mut var_parts := rt.create_array([
		rt.ArrayItem{ key: none, val: var_tracking_number },
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_shipping_provider)))) {
		var_parts.array_push(rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Provider: %s'),
				rt.new_string('woocommerce')]),
			var_shipping_provider.clone(),
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_tracking_url)))) {
		var_parts.array_push(rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('URL: %s'),
				rt.new_string('woocommerce')]),
			var_tracking_url.clone(),
		]))
	}
	return (rt.call_function('implode', [rt.new_string(', '),
		var_parts.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) get_fulfillment_status_label(status string) string {
	mut status_mutated := status
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_0 := iife_temp_0.get_fulfillment_statuses()
	mut var_statuses := iife_result_0
	return (if !(var_statuses.array_get(rt.new_string(status_mutated)).array_get(rt.new_string('label'))).is_null() {
		var_statuses.array_get(rt.new_string(status_mutated)).array_get(rt.new_string('label'))
	} else {
		rt.new_string(status_mutated)
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) get_order_fulfillment_status_label(status string) string {
	mut status_mutated := status
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_1 := iife_temp_1.get_order_fulfillment_statuses()
	mut var_statuses := iife_result_1
	return (if !(var_statuses.array_get(rt.new_string(status_mutated)).array_get(rt.new_string('label'))).is_null() {
		var_statuses.array_get(rt.new_string(status_mutated)).array_get(rt.new_string('label'))
	} else {
		rt.new_string(status_mutated)
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) normalize_note_message(var_message rt.PhpVal) string {
	mut var_message_mutated := var_message
	if rt.is_true(rt.new_bool(!(rt.is_true(var_message_mutated))))
		|| !(var_message_mutated.clone().is_string()) {
		return (rt.new_null()).str()
	}
	var_message_mutated = rt.call_function('wp_kses_post', [var_message_mutated.clone()])
	var_message_mutated = rt.new_string(var_message_mutated.clone().to_string().trim_space())
	if rt.is_true(rt.identical(rt.new_string(''), var_message_mutated)) {
		return (rt.new_null()).str()
	}
	return var_message_mutated.str()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentordernotes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'add_fulfillment_created_note' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_fulfillment_created_note(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_fulfillment_updated_note' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.add_fulfillment_updated_note(mut dispatch_arg_0, mut dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'add_fulfillment_deleted_note' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_fulfillment_deleted_note(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_order_fulfillment_status_changed_note' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.add_order_fulfillment_status_changed_note(mut dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'add_fulfillment_status_changed_note' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.add_fulfillment_status_changed_note(mut dispatch_arg_0, mut dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'format_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.format_items(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'format_tracking' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.format_tracking(mut dispatch_arg_0))
		}
		'get_fulfillment_status_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_fulfillment_status_label(dispatch_arg_0))
		}
		'get_order_fulfillment_status_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_order_fulfillment_status_label(dispatch_arg_0))
		}
		'normalize_note_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.normalize_note_message(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentOrderNotes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
