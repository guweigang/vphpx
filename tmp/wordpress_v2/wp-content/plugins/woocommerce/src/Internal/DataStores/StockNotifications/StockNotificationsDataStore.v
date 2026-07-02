import rt

struct Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore {
	rt.PhpObjectBase
pub mut:
	database_util   rt.PhpVal = rt.new_null()
	data_store_meta rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) init(mut var_data_store_meta Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore, mut var_database_util Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) {
	this.data_store_meta = var_data_store_meta
	this.database_util = var_database_util
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) get_table_name() string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_stock_notifications'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) get_meta_table_name() string {
	return (rt.call_method(this.data_store_meta, 'get_table_name', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) get_database_schema() string {
	mut var_wpdb := rt.new_null()
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('WOOCOMMERCE_BIS_ALPHA_ENABLED'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return ''
	}
	mut var_collate := if rt.is_true(rt.call_method(var_wpdb, 'has_cap', [
		rt.new_string('collation'),
	]))
	{ rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{}) } else { rt.new_string('') }
	mut var_table_name := rt.new_string(this.get_table_name())
	mut var_meta_table_name := rt.new_string(this.get_meta_table_name())
	mut var_max_index_length := rt.call_method(this.database_util, 'get_max_index_length',
		[]rt.PhpVal{})
	mut var_sql :=
		rt.new_string("\nCREATE TABLE ${var_table_name.to_string()} (\n\tid bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n\tproduct_id bigint(20) unsigned NOT NULL,\n\tuser_id bigint(20) unsigned NOT NULL,\n\tuser_email varchar(100) NOT NULL,\n\tstatus varchar(20) NOT NULL DEFAULT 'pending',\n\tdate_created_gmt datetime NULL,\n\tdate_modified_gmt datetime NULL,\n\tdate_confirmed_gmt datetime NULL,\n\tdate_last_attempt_gmt datetime NULL,\n\tdate_notified_gmt datetime NULL,\n\tdate_cancelled_gmt datetime NULL,\n\tcancellation_source varchar(30) NULL,\n\tPRIMARY KEY  (id),\n\tKEY product_status_attempt (product_id, status, date_last_attempt_gmt, id),\n\tKEY user_lookup (user_id, product_id, status),\n\tKEY email_lookup (user_email, product_id, status)\n) ${var_collate.to_string()};\nCREATE TABLE ${var_meta_table_name.to_string()} (\n\tid bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n\tnotification_id bigint(20) unsigned NOT NULL,\n\tmeta_key varchar(255) NULL,\n\tmeta_value longtext NULL,\n\tPRIMARY KEY  (id),\n\tKEY notification_id (notification_id),\n\tKEY meta_key (meta_key(${var_max_index_length.to_string()}))\n) ${var_collate.to_string()};\n\t\t")
	return var_sql.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) filter_raw_meta_data(var_notification rt.PhpVal, var_raw_meta_data rt.PhpVal) rt.PhpVal {
	mut var_raw_meta_data_mutated := var_raw_meta_data
	return var_raw_meta_data_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) get_internal_meta_keys() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) create(var_notification rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_notification, 'get_date_created', [
		rt.new_string('edit'),
	])))))
	{
		rt.call_method(var_notification, 'set_date_created', [
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_notification, 'get_date_modified', [
		rt.new_string('edit'),
	])))))
	{
		rt.call_method(var_notification, 'set_date_modified', [
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	mut var_insert := rt.call_method(var_wpdb, 'insert', [
		rt.new_string(this.get_table_name()),
		rt.create_array([
			rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_notification,
				'get_product_id', [rt.new_string('edit')]) },
			rt.ArrayItem{ key: 'user_id', val: rt.call_method(var_notification, 'get_user_id', [
				rt.new_string('edit')]) },
			rt.ArrayItem{ key: 'user_email', val: rt.call_method(var_notification,
				'get_user_email', [rt.new_string('edit')]) },
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_notification, 'get_status', [
				rt.new_string('edit')]) },
			rt.ArrayItem{
				key: 'date_created_gmt'
				val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_notification, 'get_date_created', [
						rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
			},
			rt.ArrayItem{
				key: 'date_modified_gmt'
				val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_notification, 'get_date_modified', [
						rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
			},
			rt.ArrayItem{
				key: 'date_confirmed_gmt'
				val: if rt.is_true(rt.call_method(var_notification, 'get_date_confirmed', [
					rt.new_string('edit')]))
				{
					rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
						rt.call_method(rt.call_method(var_notification, 'get_date_confirmed', [
							rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'date_last_attempt_gmt'
				val: if rt.is_true(rt.call_method(var_notification, 'get_date_last_attempt', [
					rt.new_string('edit')]))
				{
					rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
						rt.call_method(rt.call_method(var_notification, 'get_date_last_attempt', [
							rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'date_notified_gmt'
				val: if rt.is_true(rt.call_method(var_notification, 'get_date_notified', [
					rt.new_string('edit')]))
				{
					rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
						rt.call_method(rt.call_method(var_notification, 'get_date_notified', [
							rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'date_cancelled_gmt'
				val: if rt.is_true(rt.call_method(var_notification, 'get_date_cancelled', [
					rt.new_string('edit')]))
				{
					rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
						rt.call_method(rt.call_method(var_notification, 'get_date_cancelled', [
							rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{ key: 'cancellation_source', val: rt.call_method(var_notification,
				'get_cancellation_source', [rt.new_string('edit')]) },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%d' },
			rt.ArrayItem{ key: none, val: '%d' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
		]),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_insert)) {
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_datastores_stocknotifications_wp_error(rt.new_string('db_insert_error'),
			rt.new_string('Could not insert stock notification into the database.')))
	}
	mut var_notification_id := rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	rt.call_method(var_notification, 'set_id', [var_notification_id.clone()])
	rt.call_method(var_notification, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_notification, 'apply_changes', []rt.PhpVal{})
	return rt.call_method(var_notification, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) read(var_notification rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_notification, 'get_id',
		[]rt.PhpVal{})))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception',
			[]string{},
			create_automattic_woocommerce_internal_datastores_stocknotifications_exception(rt.new_string('Invalid notification ID.'))))
	}
	mut var_data := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT * FROM %i WHERE id = %d'),
			rt.new_string(this.get_table_name()),
			rt.call_method(var_notification, 'get_id', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception',
			[]string{},
			create_automattic_woocommerce_internal_datastores_stocknotifications_exception(rt.new_string('Stock notification not found'))))
	}
	rt.call_method(var_notification, 'set_props', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_data, 'id') },
			rt.ArrayItem{ key: 'product_id', val: rt.get_property(var_data, 'product_id') },
			rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_data, 'user_id') },
			rt.ArrayItem{ key: 'user_email', val: rt.get_property(var_data, 'user_email') },
			rt.ArrayItem{ key: 'status', val: rt.get_property(var_data, 'status') },
			rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_string_to_timestamp', [
				rt.get_property(var_data, 'date_created_gmt'),
			]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_string_to_timestamp', [
				rt.get_property(var_data, 'date_modified_gmt'),
			]) }, rt.ArrayItem{ key: 'date_confirmed', val: rt.call_function('wc_string_to_timestamp', [
				rt.get_property(var_data, 'date_confirmed_gmt'),
			]) }, rt.ArrayItem{ key: 'date_last_attempt', val: rt.call_function('wc_string_to_timestamp', [
				rt.get_property(var_data, 'date_last_attempt_gmt'),
			]) }, rt.ArrayItem{ key: 'date_notified', val: rt.call_function('wc_string_to_timestamp', [
				rt.get_property(var_data, 'date_notified_gmt'),
			]) }, rt.ArrayItem{ key: 'date_cancelled', val: rt.call_function('wc_string_to_timestamp', [
				rt.get_property(var_data, 'date_cancelled_gmt'),
			]) }, rt.ArrayItem{ key: 'cancellation_source', val: rt.get_property(var_data,
				'cancellation_source') }]),
	])
	rt.call_method(var_notification, 'read_meta_data', []rt.PhpVal{})
	rt.call_method(var_notification, 'set_object_read', [rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) update(var_notification rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_notification, 'get_id',
		[]rt.PhpVal{})))
	{
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error',
			[]string{}, create_automattic_woocommerce_internal_datastores_stocknotifications_wp_error(rt.new_string('invalid_stock_notification'),
			rt.new_string('Invalid notification ID.')))
	}
	mut var_changes := rt.call_method(var_notification, 'get_changes', []rt.PhpVal{})
	mut var_result := rt.new_int(0)
	if rt.is_true(rt.call_function('array_intersect', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'product_id' },
			rt.ArrayItem{ key: none, val: 'user_id' }, rt.ArrayItem{ key: none, val: 'user_email' },
			rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'date_modified' },
			rt.ArrayItem{ key: none, val: 'date_confirmed' },
			rt.ArrayItem{ key: none, val: 'date_last_attempt' },
			rt.ArrayItem{ key: none, val: 'date_notified' }, rt.ArrayItem{
				key: none
				val: 'date_cancelled'
			}, rt.ArrayItem{ key: none, val: 'cancellation_source' }]),
		rt.func_array_keys(var_changes.clone()),
	]))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('date_modified'))))))) {
			rt.call_method(var_notification, 'set_date_modified', [
				rt.call_function('time', []rt.PhpVal{}),
			])
		}
		var_result = rt.call_method(var_wpdb, 'update', [
			rt.new_string(this.get_table_name()),
			rt.create_array([
				rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_notification,
					'get_product_id', [rt.new_string('edit')]) },
				rt.ArrayItem{ key: 'user_id', val: rt.call_method(var_notification, 'get_user_id', [
					rt.new_string('edit')]) },
				rt.ArrayItem{ key: 'user_email', val: rt.call_method(var_notification,
					'get_user_email', [rt.new_string('edit')]) },
				rt.ArrayItem{ key: 'status', val: rt.call_method(var_notification, 'get_status', [
					rt.new_string('edit')]) },
				rt.ArrayItem{
					key: 'date_created_gmt'
					val: if rt.is_true(rt.call_method(var_notification, 'get_date_created', [
						rt.new_string('edit')]))
					{
						rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
							rt.call_method(rt.call_method(var_notification, 'get_date_created', [
								rt.new_string('edit'),
							]), 'getTimestamp', []rt.PhpVal{})])
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'date_modified_gmt'
					val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
						rt.call_method(rt.call_method(var_notification, 'get_date_modified', [
							rt.new_string('edit'),
						]), 'getTimestamp', []rt.PhpVal{})])
				},
				rt.ArrayItem{
					key: 'date_confirmed_gmt'
					val: if rt.is_true(rt.call_method(var_notification, 'get_date_confirmed', [
						rt.new_string('edit')]))
					{
						rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
							rt.call_method(rt.call_method(var_notification, 'get_date_confirmed', [
								rt.new_string('edit'),
							]), 'getTimestamp', []rt.PhpVal{})])
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'date_last_attempt_gmt'
					val: if rt.is_true(rt.call_method(var_notification, 'get_date_last_attempt', [
						rt.new_string('edit')]))
					{
						rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
							rt.call_method(rt.call_method(var_notification,
								'get_date_last_attempt', [
								rt.new_string('edit'),
							]), 'getTimestamp', []rt.PhpVal{})])
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'date_notified_gmt'
					val: if rt.is_true(rt.call_method(var_notification, 'get_date_notified', [
						rt.new_string('edit')]))
					{
						rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
							rt.call_method(rt.call_method(var_notification, 'get_date_notified', [
								rt.new_string('edit'),
							]), 'getTimestamp', []rt.PhpVal{})])
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{
					key: 'date_cancelled_gmt'
					val: if rt.is_true(rt.call_method(var_notification, 'get_date_cancelled', [
						rt.new_string('edit')]))
					{
						rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
							rt.call_method(rt.call_method(var_notification, 'get_date_cancelled', [
								rt.new_string('edit'),
							]), 'getTimestamp', []rt.PhpVal{})])
					} else {
						rt.new_null()
					}
				},
				rt.ArrayItem{ key: 'cancellation_source', val: rt.call_method(var_notification,
					'get_cancellation_source', [rt.new_string('edit')]) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.call_method(var_notification, 'get_id',
					[]rt.PhpVal{}) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%d' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: '%d' },
			]),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
			return rt.new_object('Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error',
				[]string{}, create_automattic_woocommerce_internal_datastores_stocknotifications_wp_error(rt.new_string('db_update_error'),
				rt.new_string('Could not update stock notification in the database.')))
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_result)) {
			return rt.new_object('Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error',
				[]string{}, create_automattic_woocommerce_internal_datastores_stocknotifications_wp_error(rt.new_string('db_update_error'),
				rt.new_string('Invalid notification ID.')))
		}
	}
	rt.call_method(var_notification, 'save_meta_data', []rt.PhpVal{})
	if rt.is_true(var_changes) {
		rt.call_method(var_notification, 'apply_changes', []rt.PhpVal{})
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) delete(var_notification rt.PhpVal, var_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_deleted := rt.call_method(var_wpdb, 'delete', [
		rt.new_string(this.get_table_name()),
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.call_method(var_notification, 'get_id', []rt.PhpVal{}) },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%d' },
		]),
	])
	if rt.is_true(rt.greater(var_deleted, rt.new_int(0))) {
		rt.call_method(this.data_store_meta, 'delete_by_notification_id', [
			rt.call_method(var_notification, 'get_id', []rt.PhpVal{}),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) add_meta(var_notification rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_add_meta := rt.call_method(this.data_store_meta, 'add_meta', [
		var_notification.clone(), var_meta.clone()])
	this.after_meta_change(var_notification.clone())
	return if rt.is_true(var_add_meta) { var_add_meta } else { rt.new_bool(false) }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) read_meta(var_notification rt.PhpVal) rt.PhpVal {
	mut var_raw_meta_data := rt.call_method(this.data_store_meta, 'read_meta', [
		var_notification.clone(),
	])
	return this.filter_raw_meta_data(var_notification.clone(), var_raw_meta_data.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) update_meta(var_notification rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_update_meta := rt.call_method(this.data_store_meta, 'update_meta', [
		var_notification.clone(),
		var_meta.clone(),
	])
	this.after_meta_change(var_notification.clone())
	return var_update_meta.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) delete_meta(var_notification rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_delete_meta := rt.call_method(this.data_store_meta, 'delete_meta', [
		var_notification.clone(),
		var_meta.clone(),
	])
	this.after_meta_change(var_notification.clone())
	return var_delete_meta.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) after_meta_change(var_notification rt.PhpVal) bool {
	mut var_current_time := rt.call_function('time', []rt.PhpVal{})
	mut var_current_date_time := create_automattic_woocommerce_internal_datastores_stocknotifications_wc_datetime(rt.new_string('@${var_current_time.to_string()}'),
		create_automattic_woocommerce_internal_datastores_stocknotifications_datetimezone(rt.new_string('UTC')))
	mut var_should_save := rt.new_bool(
		rt.is_true(rt.greater(rt.call_method(var_notification, 'get_id', []rt.PhpVal{}), rt.new_int(0)))
		&& rt.is_true(rt.less(rt.call_method(var_notification, 'get_date_modified', [rt.new_string('edit')]), var_current_date_time))
		&& !rt.is_true(rt.call_method(var_notification, 'get_changes', []rt.PhpVal{})))
	if rt.is_true(var_should_save) {
		rt.call_method(var_notification, 'set_date_modified', [
			var_current_time.clone()])
		mut var_saved := rt.call_method(var_notification, 'save', []rt.PhpVal{})
		return !(rt.is_true(rt.call_function('is_wp_error', [
			var_saved.clone()])))
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) query(mut var_args Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated,
		rt.create_array([rt.ArrayItem{ key: 'status', val: '' },
			rt.ArrayItem{ key: 'product_id', val: rt.new_array() },
			rt.ArrayItem{ key: 'user_id', val: 0 }, rt.ArrayItem{ key: 'user_email', val: '' },
			rt.ArrayItem{ key: 'last_attempt_limit', val: 0 },
			rt.ArrayItem{ key: 'start_date', val: 0 }, rt.ArrayItem{ key: 'end_date', val: 0 },
			rt.ArrayItem{ key: 'limit', val: -1 }, rt.ArrayItem{ key: 'offset', val: 0 },
			rt.ArrayItem{ key: 'order_by', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'ASC' },
			]) }, rt.ArrayItem{ key: 'return', val: 'ids' }])])
	mut var_table := rt.new_string(this.get_table_name())
	mut var_select := rt.new_string('id')
	if rt.is_true(rt.identical(rt.new_string('count'),
		var_args_mutated.array_get(rt.new_string('return'))))
	{
		var_select = rt.new_string('COUNT(id)')
	} else if rt.is_true(rt.identical(rt.new_string('objects'),
		var_args_mutated.array_get(rt.new_string('return'))))
	{
		var_select = rt.new_string('*')
	}
	mut var_where := rt.new_array()
	mut var_where_values := rt.new_array()
	if rt.is_true(var_args_mutated.array_get(rt.new_string('status'))) {
		var_where.array_push('status = %s')
		var_where_values.array_push(rt.call_function('esc_sql', [
			var_args_mutated.array_get(rt.new_string('status')),
		]))
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('product_id')))) {
		mut var_product_ids := rt.call_function('array_map', [
			rt.new_string('absint'),
			rt.cast_array(var_args_mutated.array_get(rt.new_string('product_id')))])
		var_where.array_push(
			'product_id IN (' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_product_ids.clone().array_count()), rt.new_string('%d')])])).str() +
			')')
		var_where_values = rt.call_function('array_merge', [var_where_values.clone(),
			var_product_ids.clone()])
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('user_id'))) {
		var_where.array_push('user_id = %d')
		var_where_values.array_push(rt.call_function('absint', [
			var_args_mutated.array_get(rt.new_string('user_id')),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('user_email'))) {
		var_where.array_push('user_email = %s')
		var_where_values.array_push(rt.call_function('esc_sql', [
			var_args_mutated.array_get(rt.new_string('user_email')),
		]))
	}
	if rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('last_attempt_limit')),
		rt.new_int(0)))
	{
		var_where.array_push('(date_last_attempt_gmt < %s OR date_last_attempt_gmt IS NULL)')
		var_where_values.array_push(rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			var_args_mutated.array_get(rt.new_string('last_attempt_limit')),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('start_date'))) {
		var_where.array_push('date_created_gmt >= %s')
		var_where_values.array_push(rt.call_function('esc_sql', [
			var_args_mutated.array_get(rt.new_string('start_date')),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('end_date'))) {
		var_where.array_push('date_created_gmt < %s')
		var_where_values.array_push(rt.call_function('esc_sql', [
			var_args_mutated.array_get(rt.new_string('end_date')),
		]))
	}
	mut var_order_by := rt.new_string('')
	mut var_order_by_clauses := rt.new_array()
	if rt.is_true(var_args_mutated.array_get(rt.new_string('order_by')))
		&& var_args_mutated.array_get(rt.new_string('order_by')).is_array() {
		mut iter_1 := var_args_mutated.array_get(rt.new_string('order_by')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_how := item_1.val
			mut var_what := item_1.key
			var_order_by_clauses.array_push(var_table.str() + '.' +
				(rt.call_function('esc_sql', [rt.new_string(var_what.clone().to_string())])).str() +
				' ' +
				(rt.call_function('esc_sql', [rt.new_string(var_how.clone().to_string())])).str())
		}
	}
	var_where = rt.call_function('implode', [rt.new_string(' AND '),
		var_where.clone()])
	var_where =
		rt.new_string((if rt.is_true(var_where) { ' WHERE ' + var_where.str() } else { '' }).str())
	var_order_by = rt.new_string((if !(!rt.is_true(var_order_by_clauses)) {
		' ORDER BY ' +
			(rt.call_function('implode', [rt.new_string(', '), var_order_by_clauses.clone()])).str()
	} else {
		''
	}).str())
	mut var_limit := rt.new_string((if rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('limit')),
		rt.new_int(0)))
	{
		' LIMIT ' +
			(rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('limit'))])).str()
	} else {
		''
	}).str())
	mut var_offset := rt.new_string((if rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('offset')),
		rt.new_int(0)))
	{
		' OFFSET ' +(rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('offset'))])).str()
	} else {
		''
	}).str())
	mut var_sql :=
		rt.new_string('SELECT ${var_select.to_string()} FROM ${var_table.to_string()} ${var_where.to_string()} ${var_order_by.to_string()} ${var_limit.to_string()} ${var_offset.to_string()}')
	mut var_prepared_sql := if !rt.is_true(var_where_values) { var_sql } else { rt.call_method(var_wpdb, 'prepare', [
			var_sql.clone(),
			var_where_values.clone(),
		]) }
	if rt.is_true(rt.identical(rt.new_string('count'),
		var_args_mutated.array_get(rt.new_string('return'))))
	{
		return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			var_prepared_sql.clone()])).to_i64())
	}
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		var_prepared_sql.clone(), rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_results) || !(var_results.clone().is_array()) {
		return rt.new_array()
	}
	if rt.is_true(rt.identical(rt.new_string('objects'),
		var_args_mutated.array_get(rt.new_string('return'))))
	{
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification',
				[]string{},
				create_automattic_woocommerce_internal_stocknotifications_notification(var_result.clone()))
		}
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification',
				[]string{},
				create_automattic_woocommerce_internal_stocknotifications_notification(var_result.clone()))
		}
		return rt.call_function('array_map', [rt.new_closure(closure_2_fn),
			var_results.clone()])
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('absint', [var_result.array_get(rt.new_string('id'))])
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('absint', [var_result.array_get(rt.new_string('id'))])
	}
	return rt.call_function('array_map', [rt.new_closure(closure_4_fn),
		var_results.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) product_has_active_notifications(mut var_product_ids Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_array) bool {
	mut var_wpdb := rt.new_null()
	mut var_product_ids_mutated := var_product_ids
	var_product_ids_mutated = rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('absint'), var_product_ids_mutated]),
	])
	if !rt.is_true(var_product_ids_mutated) {
		return false
	}
	mut var_table := rt.new_string(this.get_table_name())
	mut var_format := rt.call_function('array_fill', [rt.new_int(0),
		rt.new_int(var_product_ids_mutated.array_count()), rt.new_string('%d')])
	mut var_query_in := rt.new_string('(' +
		(rt.call_function('implode', [rt.new_string(','), var_format.clone()])).str() + ')')
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SELECT 1 FROM %i WHERE product_id IN ${var_query_in.to_string()} AND status = %s LIMIT 1'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_table },
			rt.ArrayItem{ key: none, val: var_product_ids_mutated },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active()
			}]),
	])
	return rt.new_bool(rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		var_sql.clone()])).to_i64()) > 0)
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) notification_exists_by_email(product_id i64, email string) bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		rt.new_string(email),
	])))))
	{
		return false
	}
	mut var_table := rt.new_string(this.get_table_name())
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SELECT 1 FROM %i WHERE product_id = %d AND user_email = %s AND status IN (%s, %s) LIMIT 1'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_table },
			rt.ArrayItem{ key: none, val: product_id }, rt.ArrayItem{ key: none, val: email },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active()
			}, rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending()
			}]),
	])
	return rt.new_bool(rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		var_sql.clone()])).to_i64()) > 0)
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) notification_exists_by_user_id(product_id i64, user_id i64) bool {
	mut var_wpdb := rt.new_null()
	if 0 == user_id {
		return false
	}
	mut var_table := rt.new_string(this.get_table_name())
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SELECT 1 FROM %i WHERE product_id = %d AND user_id = %d AND status IN (%s, %s) LIMIT 1'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_table },
			rt.ArrayItem{ key: none, val: product_id }, rt.ArrayItem{ key: none, val: user_id },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active()
			}, rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending()
			}]),
	])
	return rt.new_bool(rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		var_sql.clone()])).to_i64()) > 0)
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) get_distinct_dates() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT DISTINCT\n\t\t\t\t\tYEAR(date_created_gmt) AS year,\n\t\t\t\t\tMONTH(date_created_gmt) AS month\n\t\t\t\tFROM %i\n\t\t\t\tORDER BY year DESC, month DESC'),
			rt.new_string(this.get_table_name()),
		]),
	])
	return var_results.clone()
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_stocknotifications_stocknotificationsdatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore{
		PhpObjectBase:   rt.PhpObjectBase{}
		database_util:   rt.new_null()
		data_store_meta: rt.new_null()
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_stocknotifications_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_stocknotifications_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_stocknotifications_wc_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WC_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_stocknotifications_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notification(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_table_name' {
			return rt.new_string(this.get_table_name())
		}
		'get_meta_table_name' {
			return rt.new_string(this.get_meta_table_name())
		}
		'get_database_schema' {
			return rt.new_string(this.get_database_schema())
		}
		'filter_raw_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_raw_meta_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_internal_meta_keys' {
			return this.get_internal_meta_keys()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create(dispatch_arg_0)
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update(dispatch_arg_0)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'read_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read_meta(dispatch_arg_0)
		}
		'update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.delete_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'after_meta_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.after_meta_change(dispatch_arg_0))
		}
		'query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.query(mut dispatch_arg_0)
		}
		'product_has_active_notifications' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.product_has_active_notifications(mut dispatch_arg_0))
		}
		'notification_exists_by_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.notification_exists_by_email(dispatch_arg_0, dispatch_arg_1))
		}
		'notification_exists_by_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.notification_exists_by_user_id(dispatch_arg_0, dispatch_arg_1))
		}
		'get_distinct_dates' {
			return this.get_distinct_dates()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'database_util' { return this.database_util }
		'data_store_meta' { return this.data_store_meta }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'database_util' {
			this.database_util = val
			return true
		}
		'data_store_meta' {
			this.data_store_meta = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
