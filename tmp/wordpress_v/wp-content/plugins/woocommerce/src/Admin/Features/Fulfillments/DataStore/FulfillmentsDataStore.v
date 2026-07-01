import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) create(var_data rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_mutated, 'get_entity_type', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Invalid entity type.'), rt.new_string('woocommerce')]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_mutated, 'get_entity_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Invalid entity ID.'), rt.new_string('woocommerce')]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.is_valid_fulfillment_status(arg_0) }(rt.call_method(var_data_mutated, 'get_status', []rt.PhpVal{})))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Invalid fulfillment status.'), rt.new_string('woocommerce')]))))
	}
	this.validate_items(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](var_data_mutated))
	rt.call_method(var_data_mutated, 'set_date_updated', [rt.call_function('current_time', [rt.new_string('mysql')])])
	var_data_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_before_create'), var_data_mutated.dup()])
	mut var_is_fulfill_action := rt.call_method(var_data_mutated, 'get_is_fulfilled', []rt.PhpVal{})
	if rt.is_true(var_is_fulfill_action) {
		rt.call_method(var_data_mutated, 'set_date_fulfilled', [rt.call_function('current_time', [rt.new_string('mysql')])])
		var_data_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_before_fulfill'), var_data_mutated.dup()])
	}
	// unsupported statement: Stmt_Global
	mut var_rows_inserted := rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillments', rt.create_array([rt.ArrayItem{ key: 'entity_type', val: rt.call_method(var_data_mutated, 'get_entity_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'entity_id', val: rt.call_method(var_data_mutated, 'get_entity_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: if !(rt.call_method(var_data_mutated, 'get_status', []rt.PhpVal{})).is_null() { rt.call_method(var_data_mutated, 'get_status', []rt.PhpVal{}) } else { rt.new_string('unfulfilled') } }, rt.ArrayItem{ key: 'is_fulfilled', val: if rt.is_true(rt.call_method(var_data_mutated, 'get_is_fulfilled', []rt.PhpVal{})) { 1 } else { 0 } }, rt.ArrayItem{ key: 'date_updated', val: rt.call_method(var_data_mutated, 'get_date_updated', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_deleted', val: rt.call_method(var_data_mutated, 'get_date_deleted', []rt.PhpVal{}) }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_rows_inserted)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Failed to insert fulfillment.'), rt.new_string('woocommerce')]))))
	}
	mut var_data_id := rt.get_property(var_wpdb, 'insert_id')
	rt.call_method(var_data_mutated, 'set_id', [var_data_id.dup()])
	rt.call_method(var_data_mutated, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_data_mutated, 'apply_changes', []rt.PhpVal{})
	rt.call_method(var_data_mutated, 'set_object_read', [rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_fulfillment_after_create')]))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_after_create'), var_data_mutated.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_is_fulfill_action) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_fulfillment_after_fulfill')]))))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_after_fulfill'), var_data_mutated.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) read(var_data rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	mut var_data_id := rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{})
	mut var_fulfillment_data := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_fulfillments WHERE fulfillment_id = %d')), var_data_id.dup()]), rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_fulfillment_data) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Fulfillment not found.'), rt.new_string('woocommerce')]))))
	}
	rt.call_method(var_data_mutated, 'set_props', [rt.call_function('array_diff_key', [var_fulfillment_data.dup(), rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: true }])])])
	rt.call_method(var_data_mutated, 'set_id', [// unsupported expression: Expr_Cast_Int])
	rt.call_method(var_data_mutated, 'read_meta_data', [rt.new_bool(true)])
	rt.call_method(var_data_mutated, 'set_object_read', [rt.new_bool(true)])
	rt.call_method(var_data_mutated, 'snapshot_meta', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) update(var_data rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.call_method(var_data_mutated, 'get_date_deleted', []rt.PhpVal{})) {
		return rt.new_null()
	}
	mut var_data_id := rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.is_valid_fulfillment_status(arg_0) }(rt.call_method(var_data_mutated, 'get_status', []rt.PhpVal{})))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Invalid fulfillment status.'), rt.new_string('woocommerce')]))))
	}
	this.validate_items(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](var_data_mutated))
	var_data_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_before_update'), var_data_mutated.dup()])
	mut var_is_fulfill_action := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_data_mutated, 'get_is_fulfilled', []rt.PhpVal{})) && !rt.is_true(rt.call_method(var_data_mutated, 'get_date_fulfilled', []rt.PhpVal{})))) {
		var_is_fulfill_action = rt.new_bool(rt.new_bool(true))
		rt.call_method(var_data_mutated, 'set_date_fulfilled', [rt.call_function('current_time', [rt.new_string('mysql')])])
		var_data_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_before_fulfill'), var_data_mutated.dup()])
	}
	// unsupported statement: Stmt_Global
	mut var_changes := rt.call_method(var_data_mutated, 'get_changes', []rt.PhpVal{})
	mut var_previous_status := if !(rt.call_method(var_data_mutated, 'get_data', []rt.PhpVal{}).array_get('status')).is_null() { rt.call_method(var_data_mutated, 'get_data', []rt.PhpVal{}).array_get('status') } else { rt.new_string('unfulfilled') }
	rt.call_method(var_data_mutated, 'set_date_updated', [rt.call_function('current_time', [rt.new_string('mysql')])])
	rt.call_method(var_wpdb, 'update', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillments', rt.create_array([rt.ArrayItem{ key: 'entity_type', val: rt.call_method(var_data_mutated, 'get_entity_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'entity_id', val: rt.call_method(var_data_mutated, 'get_entity_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_data_mutated, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_fulfilled', val: if rt.is_true(rt.call_method(var_data_mutated, 'get_is_fulfilled', []rt.PhpVal{})) { 1 } else { 0 } }, rt.ArrayItem{ key: 'date_updated', val: rt.call_method(var_data_mutated, 'get_date_updated', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_deleted', val: rt.call_method(var_data_mutated, 'get_date_deleted', []rt.PhpVal{}) }]), rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: var_data_id }, rt.ArrayItem{ key: 'date_deleted', val: rt.new_null() }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Failed to update fulfillment.'), rt.new_string('woocommerce')]))))
	}
	rt.call_method(var_data_mutated, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_data_mutated, 'apply_changes', []rt.PhpVal{})
	rt.call_method(var_data_mutated, 'set_object_read', [rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_fulfillment_after_update')]))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_after_update'), var_data_mutated.dup(), var_changes.dup(), var_previous_status.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_is_fulfill_action) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_fulfillment_after_fulfill')]))))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_after_fulfill'), var_data_mutated.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) delete(var_data rt.PhpVal, var_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.call_method(var_data_mutated, 'get_date_deleted', []rt.PhpVal{})) {
		return rt.new_null()
	}
	var_data_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_before_delete'), var_data_mutated.dup()])
	// unsupported statement: Stmt_Global
	mut var_data_id := rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{})
	mut var_deletion_time := rt.call_function('current_time', [rt.new_string('mysql')])
	rt.call_method(var_wpdb, 'update', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillments', rt.create_array([rt.ArrayItem{ key: 'date_deleted', val: var_deletion_time }]), rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: var_data_id }, rt.ArrayItem{ key: 'date_deleted', val: rt.new_null() }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Failed to delete fulfillment.'), rt.new_string('woocommerce')]))))
	}
	rt.call_method(var_data_mutated, 'set_date_deleted', [var_deletion_time.dup()])
	rt.call_method(var_data_mutated, 'apply_changes', []rt.PhpVal{})
	rt.call_method(var_data_mutated, 'set_object_read', [rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_fulfillment_after_delete')]))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_fulfillment_after_delete'), var_data_mutated.dup()])
	}
	var_data_mutated = create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) read_meta(var_data rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Invalid fulfillment.'), rt.new_string('woocommerce')]))))
	}
	// unsupported statement: Stmt_Global
	mut var_data_id := rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{})
	mut var_meta_data := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_fulfillment_meta WHERE fulfillment_id = %d')), var_data_id.dup()]), rt.get_constant('OBJECT')])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_meta := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	rt.set_property(var_meta, 'meta_value', if !(rt.call_function('json_decode', [rt.get_property(var_meta, 'meta_value'), rt.new_bool(true)])).is_null() { rt.call_function('json_decode', [rt.get_property(var_meta, 'meta_value'), rt.new_bool(true)]) } else { rt.get_property(var_meta, 'meta_value') })
	return var_meta.dup()
	}
	mut var_meta := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	rt.set_property(var_meta, 'meta_value', if !(rt.call_function('json_decode', [rt.get_property(var_meta, 'meta_value'), rt.new_bool(true)])).is_null() { rt.call_function('json_decode', [rt.get_property(var_meta, 'meta_value'), rt.new_bool(true)]) } else { rt.get_property(var_meta, 'meta_value') })
	return var_meta.dup()
	}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_meta_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) delete_meta(var_data rt.PhpVal, var_meta rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	mut var_data_id := rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_data_mutated, 'get_date_deleted', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Cannot delete meta from a deleted fulfillment.'), rt.new_string('woocommerce')]))))
	}
	mut var_meta_id := rt.get_property(var_meta, 'id')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_id.dup().is_long() || var_data_id.dup().is_double()))))) || rt.is_true(rt.less_equal(var_data_id, rt.new_int(0))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_meta_id.dup().is_long() || var_meta_id.dup().is_double()))))))) || rt.is_true(rt.less_equal(var_meta_id, rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Invalid fulfillment or meta.'), rt.new_string('woocommerce')]))))
	}
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'delete', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillment_meta', rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: var_data_id }, rt.ArrayItem{ key: 'meta_id', val: var_meta_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%d' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) add_meta(var_data rt.PhpVal, var_meta rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_method(var_data_mutated, 'get_date_deleted', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Cannot add meta to a deleted fulfillment.'), rt.new_string('woocommerce')]))))
	}
	mut var_data_id := rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{})
	rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillment_meta', rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: var_data_id }, rt.ArrayItem{ key: 'meta_key', val: rt.get_property(var_meta, 'key') }, rt.ArrayItem{ key: 'meta_value', val: rt.call_function('wp_json_encode', [rt.get_property(var_meta, 'value')]) }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])])
	if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Failed to insert fulfillment meta.'), rt.new_string('woocommerce')]))))
	}
	return (rt.get_property(var_wpdb, 'insert_id')).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) update_meta(var_data rt.PhpVal, var_meta rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	mut var_data_id := rt.call_method(var_data_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_data_mutated, 'get_date_deleted', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Cannot update meta for a deleted fulfillment.'), rt.new_string('woocommerce')]))))
	}
	mut var_rows_updated := rt.call_method(var_wpdb, 'update', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillment_meta', rt.create_array([rt.ArrayItem{ key: 'meta_value', val: rt.call_function('wp_json_encode', [rt.get_property(var_meta, 'value')]) }]), rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: var_data_id }, rt.ArrayItem{ key: 'meta_id', val: rt.get_property(var_meta, 'id') }, rt.ArrayItem{ key: 'meta_key', val: rt.get_property(var_meta, 'key') }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }])])
	if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, create_automattic_woocommerce_admin_features_fulfillments_datastore_exception(rt.call_function('esc_html__', [rt.new_string('Failed to update fulfillment meta.'), rt.new_string('woocommerce')]))))
	}
	return (var_rows_updated).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) read_fulfillments(entity_type string, entity_id string, with_deleted bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(var_with_deleted) {
		mut var_fulfillment_data := rt.call_method(var_wpdb, 'get_results', [rt.call_method(, 'prepare', [, , ]), rt.get_constant('ARRAY_A')])
	} else {
		var_fulfillment_data = rt.call_method(, 'get_results', [, ])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_fulfillment_data.dup()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception', []string{}, ))
	}
	mut var_fulfillments := 
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) delete_by_entity(entity_type string, entity_id string) i64 {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) validate_items(mut var_data Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment)  {
	mut var_data_mutated := var_data
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_datastore_fulfillmentsdatastore() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_datastore_wc_data_store_wp() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_WC_Data_Store_WP {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_datastore_exception() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception{
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read_meta(dispatch_arg_0)
		}
		'delete_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.add_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.update_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'read_fulfillments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.read_fulfillments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete_by_entity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_int(this.delete_by_entity(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validate_items(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_datastore_fulfillmentsdatastore_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
