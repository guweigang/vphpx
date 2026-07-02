import rt

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore {
	rt.PhpObjectBase
pub mut:
	internal_meta_keys              rt.PhpVal = rt.new_array()
	operational_data_column_mapping rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) delete(var_refund rt.PhpVal, var_args rt.PhpVal) {
	mut var_refund_id := rt.call_method(var_refund, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_refund_id)))) {
		return
	}
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_cache_prefix(rt.new_string('orders'))
	mut var_refund_cache_key := rt.new_string(iife_result_0.str() + 'refund_ids' +
		(rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})).str())
	rt.call_function('wp_cache_delete', [var_refund_cache_key.clone(),
		rt.new_string('orders')])
	this.delete_order_data_from_custom_order_tables(var_refund_id.clone())
	rt.call_method(var_refund, 'set_id', [rt.new_int(0)])
	mut var_orders_table_is_authoritative := rt.identical(rt.call_method(rt.call_method(var_refund,
		'get_data_store', []rt.PhpVal{}), 'get_current_class_name', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore.class())
	if rt.is_true(var_orders_table_is_authoritative) {
		mut var_data_synchronizer := rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class(),
		])
		if rt.is_true(rt.call_method(var_data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})) {
			rt.call_function('wp_delete_post', [var_refund_id.clone()])
		} else {
			this.handle_order_deletion_with_sync_disabled(var_refund_id.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) set_order_props_from_data(var_refund rt.PhpVal, var_data rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.set_order_props_from_data(var_refund.clone(),
		var_data.clone())
	mut iter_1 := rt.get_property(var_data, 'meta_data').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta := item_1.val
		mut switch_val_1 := rt.get_property(var_meta, 'meta_key')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('_refund_amount'))) {
			rt.call_method(var_refund, 'set_amount', [
				rt.get_property(var_meta, 'meta_value'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('_refunded_by'))) {
			rt.call_method(var_refund, 'set_refunded_by', [
				rt.get_property(var_meta, 'meta_value'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('_refunded_payment'))) {
			rt.call_method(var_refund, 'set_refunded_payment', [
				rt.call_function('wc_string_to_bool', [
					rt.get_property(var_meta, 'meta_value'),
				]),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('_refund_reason'))) {
			rt.call_method(var_refund, 'set_reason', [
				rt.get_property(var_meta, 'meta_value'),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) create(var_refund rt.PhpVal) {
	rt.call_method(var_refund, 'set_status', [rt.new_string('completed')])
	this.persist_save(var_refund.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) update(var_refund rt.PhpVal) {
	this.persist_updates(var_refund.clone())
	rt.call_method(var_refund, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order_refund'),
		rt.call_method(var_refund, 'get_id', []rt.PhpVal{}), var_refund.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) update_order_meta(var_refund rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.update_order_meta(var_refund.clone())
	mut var_updated_props := rt.new_array()
	mut var_meta_key_to_props := rt.create_array([
		rt.ArrayItem{ key: '_refund_amount', val: 'amount' },
		rt.ArrayItem{ key: '_refunded_by', val: 'refunded_by' },
		rt.ArrayItem{ key: '_refunded_payment', val: 'refunded_payment' },
		rt.ArrayItem{ key: '_refund_reason', val: 'reason' },
	])
	mut var_props_to_update := this.get_props_to_update(var_refund.clone(),
		var_meta_key_to_props.clone())
	mut iter_2 := var_props_to_update.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_prop := item_2.val
		mut var_meta_key := item_2.key
		mut var_meta_object := create_wc_meta_data()
		rt.set_property(var_meta_object, 'key', var_meta_key.clone())
		rt.set_property(var_meta_object, 'value', rt.call_method(var_refund,
			'get_${var_prop.to_string()}', [rt.new_string('edit')]))
		mut var_existing_meta := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore', [
			'Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore',
		], &this), 'data_store_meta'), 'get_metadata_by_key', [
			var_refund.clone(), var_meta_key.clone()])
		if rt.is_true(var_existing_meta) {
			var_existing_meta = var_existing_meta.array_get(rt.new_int(0))
			rt.set_property(var_meta_object, 'id', rt.get_property(var_existing_meta, 'id'))
			this.update_meta(var_refund.clone(), rt.new_object('WC_Meta_Data', []string{},
				var_meta_object))
		} else {
			this.add_meta(var_refund.clone(), rt.new_object('WC_Meta_Data', []string{},
				var_meta_object))
		}
		var_updated_props.array_push(var_prop.clone())
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_refund_object_updated_props'),
		var_refund.clone(),
		var_updated_props.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) get_post_title() rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Refund &ndash; %s'),
			rt.new_string('woocommerce')]),
		rt.call_method(create_automattic_woocommerce_internal_datastores_orders_datetime(rt.new_string('now')),
			'format', [
			rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'),
				rt.new_string('Order date parsed by DateTime::format'),
				rt.new_string('woocommerce')]),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) get_post_data_store_for_backfill() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Refund_Data_Store_CPT',
		[]string{},
		create_automattic_woocommerce_internal_datastores_orders_wc_order_refund_data_store_cpt())
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Meta_Data {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Refund_Data_Store_CPT {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablerefunddatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore{
		PhpObjectBase:                   rt.PhpObjectBase{}
		internal_meta_keys:              rt.new_array()
		operational_data_column_mapping: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
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

fn create_wc_meta_data(_args ...rt.PhpVal) &Class_WC_Meta_Data {
	mut obj := &Class_WC_Meta_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_order_refund_data_store_cpt(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Refund_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Refund_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_order_props_from_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_order_props_from_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'update_order_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_order_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'get_post_title' {
			return this.get_post_title()
		}
		'get_post_data_store_for_backfill' {
			return this.get_post_data_store_for_backfill()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internal_meta_keys' { return this.internal_meta_keys }
		'operational_data_column_mapping' { return this.operational_data_column_mapping }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		'operational_data_column_mapping' {
			this.operational_data_column_mapping = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Meta_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Meta_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Refund_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Refund_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Refund_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
