import rt

pub fn Class_WC_Customer_Download_Data_Store.download_permission_db_fields() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'download_id' },
		rt.ArrayItem{ key: none, val: 'product_id' }, rt.ArrayItem{ key: none, val: 'user_id' },
		rt.ArrayItem{ key: none, val: 'user_email' }, rt.ArrayItem{ key: none, val: 'order_id' },
		rt.ArrayItem{ key: none, val: 'order_key' }, rt.ArrayItem{
			key: none
			val: 'downloads_remaining'
		}, rt.ArrayItem{ key: none, val: 'access_granted' }, rt.ArrayItem{
			key: none
			val: 'download_count'
		}, rt.ArrayItem{ key: none, val: 'access_expires' }])
}

struct Class_WC_Customer_Download_Data_Store {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Customer_Download_Data_Store) create_from_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	var_data_mutated = rt.call_function('array_intersect_key', [
		var_data_mutated.clone(),
		rt.call_function('array_flip', [
			Class_WC_Customer_Download_Data_Store.download_permission_db_fields(),
		])])
	mut var_id := this.insert_new_download_permission(var_data_mutated.clone())
	rt.call_function('do_action', [
		rt.new_string('woocommerce_grant_product_download_access'),
		var_data_mutated.clone(),
	])
	return var_id.clone()
}

fn (mut this Class_WC_Customer_Download_Data_Store) create(var_download rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(rt.call_method(var_download, 'get_access_granted', [
		rt.new_string('edit'),
	]).is_null()))
	{
		rt.call_method(var_download, 'set_access_granted', [
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	mut var_data := rt.new_array()
	mut iter_1 := Class_WC_Customer_Download_Data_Store.download_permission_db_fields().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_db_field_name := item_1.val
		mut var_value := rt.call_function('call_user_func', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_download },
				rt.ArrayItem{ key: none, val: 'get_' + var_db_field_name.str() }]),
			rt.new_string('edit'),
		])
		var_data.array_set(var_db_field_name, var_value.clone())
	}
	mut var_inserted_id := this.insert_new_download_permission(var_data.clone())
	if rt.is_true(var_inserted_id) {
		rt.call_method(var_download, 'set_id', [var_inserted_id.clone()])
		rt.call_method(var_download, 'apply_changes', []rt.PhpVal{})
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_grant_product_download_access'),
		var_data.clone(),
	])
}

fn (mut this Class_WC_Customer_Download_Data_Store) insert_new_download_permission(var_data rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	if !(var_data_mutated.array_isset(rt.new_string('access_granted'))) {
		var_data_mutated.array_set('access_granted', rt.call_function('time', []rt.PhpVal{}))
	}
	var_data_mutated.array_set('access_granted',
		this.adjust_date_for_db(var_data_mutated.array_get(rt.new_string('access_granted'))))
	if var_data_mutated.array_isset(rt.new_string('access_expires')) {
		var_data_mutated.array_set('access_expires',
			this.adjust_date_for_db(var_data_mutated.array_get(rt.new_string('access_expires'))))
	}
	mut var_format := ['%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%d', '%s']
	mut var_result := rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_downloadable_product_permissions'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_downloadable_file_permission_data'),
			var_data_mutated.clone(),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_downloadable_file_permission_format'),
			rt.create_array_from_list(var_format),
			var_data_mutated.clone(),
		]),
	])
	return if rt.is_true(var_result) {
		rt.get_property(var_wpdb, 'insert_id')
	} else {
		rt.new_bool(false)
	}
}

fn (mut this Class_WC_Customer_Download_Data_Store) adjust_date_for_db(var_date rt.PhpVal) rt.PhpVal {
	mut var_date_mutated := var_date
	if rt.is_true(rt.identical(rt.new_string('WC_DateTime'), rt.call_function('get_class', [
		var_date_mutated.clone(),
	])))
	{
		var_date_mutated = rt.call_method(var_date_mutated, 'getTimestamp', []rt.PhpVal{})
	}
	mut var_adjusted_date := rt.call_function('date', [rt.new_string('Y-m-d'),
		var_date_mutated.clone()])
	if rt.is_true(var_adjusted_date) {
		return var_adjusted_date.clone()
	}
	mut var_msg := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string("I don't know how to get a date from a %s"),
			rt.new_string('woocommerce'),
		]),
		if var_date_mutated.clone().is_object() { rt.call_function('get_class', [
				var_date_mutated.clone(),
			]) } else { rt.call_function('gettype', [
				var_date_mutated.clone(),
			]) },
	])
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(var_msg.clone())))
	return rt.new_null()
}

fn (mut this Class_WC_Customer_Download_Data_Store) read(var_download rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_download, 'get_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid download.'),
			rt.new_string('woocommerce'),
		]))))
	}
	rt.call_method(var_download, 'set_defaults', []rt.PhpVal{})
	mut var_raw_download := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '),
				rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_downloadable_product_permissions WHERE permission_id = %d')),
			rt.call_method(var_download, 'get_id', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_raw_download)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid download.'),
			rt.new_string('woocommerce'),
		]))))
	}
	rt.call_method(var_download, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'download_id', val: rt.get_property(var_raw_download, 'download_id') },
			rt.ArrayItem{ key: 'product_id', val: rt.get_property(var_raw_download, 'product_id') },
			rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_raw_download, 'user_id') },
			rt.ArrayItem{ key: 'user_email', val: rt.get_property(var_raw_download, 'user_email') },
			rt.ArrayItem{ key: 'order_id', val: rt.get_property(var_raw_download, 'order_id') },
			rt.ArrayItem{ key: 'order_key', val: rt.get_property(var_raw_download, 'order_key') },
			rt.ArrayItem{ key: 'downloads_remaining', val: rt.get_property(var_raw_download,
				'downloads_remaining') },
			rt.ArrayItem{ key: 'access_granted', val: rt.call_function('strtotime', [
				rt.get_property(var_raw_download, 'access_granted'),
			]) },
			rt.ArrayItem{ key: 'download_count', val: rt.get_property(var_raw_download,
				'download_count') },
			rt.ArrayItem{
				key: 'access_expires'
				val: if rt.get_property(var_raw_download, 'access_expires').is_null() { rt.new_null() } else { rt.call_function('strtotime', [
						rt.get_property(var_raw_download, 'access_expires'),
					]) }
			},
		]),
	])
	rt.call_method(var_download, 'set_object_read', [rt.new_bool(true)])
}

fn (mut this Class_WC_Customer_Download_Data_Store) update(var_download rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'download_id', val: rt.call_method(var_download, 'get_download_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_download, 'get_product_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'user_id', val: rt.call_method(var_download, 'get_user_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'user_email', val: rt.call_method(var_download, 'get_user_email', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_download, 'get_order_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'order_key', val: rt.call_method(var_download, 'get_order_key', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'downloads_remaining', val: rt.call_method(var_download,
			'get_downloads_remaining', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'access_granted', val: rt.call_function('date', [
			rt.new_string('Y-m-d'),
			rt.call_method(rt.call_method(var_download, 'get_access_granted', [
				rt.new_string('edit'),
			]), 'getTimestamp', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'download_count', val: rt.call_method(var_download,
			'get_download_count', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{
			key: 'access_expires'
			val: if !(rt.call_method(var_download, 'get_access_expires', [
				rt.new_string('edit'),
			]).is_null()) { rt.call_function('date', [
					rt.new_string('Y-m-d'),
					rt.call_method(rt.call_method(var_download, 'get_access_expires', [
						rt.new_string('edit'),
					]), 'getTimestamp', []rt.PhpVal{}),
				]) } else { rt.new_null() }
		},
	])
	mut var_format := ['%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%d', '%s']
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_downloadable_product_permissions'),
		var_data.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'permission_id', val: rt.call_method(var_download, 'get_id',
				[]rt.PhpVal{}) },
		]),
		rt.create_array_from_list(var_format),
	])
	rt.call_method(var_download, 'apply_changes', []rt.PhpVal{})
}

fn (mut this Class_WC_Customer_Download_Data_Store) delete(var_download rt.PhpVal, var_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_download_id := rt.call_method(var_download, 'get_id', []rt.PhpVal{})
	this.delete_by_id(var_download_id.clone())
	rt.call_method(var_download, 'set_id', [rt.new_int(0)])
}

fn (mut this Class_WC_Customer_Download_Data_Store) delete_by_id(var_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\tWHERE permission_id = %d')),
			var_id_mutated.clone(),
		]),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('wc_download_log\n\t\t\t\tWHERE permission_id = %d')),
			var_id_mutated.clone(),
		]),
	])
}

fn (mut this Class_WC_Customer_Download_Data_Store) delete_download_log_by_field_value(var_field rt.PhpVal, var_value rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_value_mutated := var_value
	mut var_value_placeholder := rt.new_string('')
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_long())) {
		var_value_placeholder = rt.new_string('%d')
	} else if rt.is_true(rt.new_bool(var_value_mutated.clone().is_string())) {
		var_value_placeholder = rt.new_string('%s')
	} else if rt.is_true(rt.new_bool(var_value_mutated.clone().is_double())) {
		var_value_placeholder = rt.new_string('%f')
	} else {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('Unsupported argument type provided as value.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('7.0')])
		return
	}
	mut var_query := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string('wc_download_log\n\t\t\t\t\tWHERE permission_id IN (\n\t\t\t\t\t    SELECT permission_id\n\t\t\t\t\t    FROM ')), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\t\t    WHERE ')),
		var_field), rt.new_string(' = ')), var_value_placeholder), rt.new_string('\n\t\t\t\t\t)'))).str())
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [var_query.clone(),
			var_value_mutated.clone()]),
	])
}

fn (mut this Class_WC_Customer_Download_Data_Store) delete_by_order_id(var_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	this.delete_download_log_by_field_value(rt.new_string('order_id'), var_id_mutated.clone())
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\tWHERE order_id = %d')),
			var_id_mutated.clone(),
		]),
	])
}

fn (mut this Class_WC_Customer_Download_Data_Store) delete_by_download_id(var_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	this.delete_download_log_by_field_value(rt.new_string('download_id'), var_id_mutated.clone())
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\tWHERE download_id = %s')),
			var_id_mutated.clone(),
		]),
	])
}

fn (mut this Class_WC_Customer_Download_Data_Store) delete_by_user_id(var_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	this.delete_download_log_by_field_value(rt.new_string('user_id'), var_id_mutated.clone())
	return (rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\tWHERE user_id = %d')),
			var_id_mutated.clone(),
		]),
	])).to_bool()
}

fn (mut this Class_WC_Customer_Download_Data_Store) delete_by_user_email(var_email rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	this.delete_download_log_by_field_value(rt.new_string('user_email'), var_email.clone())
	return (rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\tWHERE user_email = %s')),
			var_email.clone(),
		]),
	])).to_bool()
}

fn (mut this Class_WC_Customer_Download_Data_Store) get_download(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	return rt.new_object('WC_Customer_Download', []string{},
		create_wc_customer_download(var_data_mutated.clone()))
}

fn (mut this Class_WC_Customer_Download_Data_Store) get_downloads(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'user_email', val: '' },
			rt.ArrayItem{ key: 'user_id', val: '' }, rt.ArrayItem{ key: 'order_id', val: '' },
			rt.ArrayItem{ key: 'order_key', val: '' }, rt.ArrayItem{ key: 'product_id', val: '' },
			rt.ArrayItem{ key: 'download_id', val: '' }, rt.ArrayItem{
				key: 'orderby'
				val: 'permission_id'
			}, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'limit', val: -1 },
			rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'return', val: 'objects' }])])
	mut var_valid_fields := ['permission_id', 'download_id', 'product_id', 'order_id', 'order_key',
		'user_email', 'user_id', 'downloads_remaining', 'access_granted', 'access_expires',
		'download_count']
	mut var_get_results_output := rt.get_constant('ARRAY_A')
	if rt.is_true(rt.identical(rt.new_string('ids'),
		var_args_mutated.array_get(rt.new_string('return'))))
	{
		mut var_fields := rt.new_string('permission_id')
	} else if rt.is_true(rt.identical(rt.new_string('objects'),
		var_args_mutated.array_get(rt.new_string('return'))))
	{
		var_fields = rt.new_string('*')
		var_get_results_output = rt.get_constant('OBJECT')
	} else {
		var_fields = rt.call_function('explode', [rt.new_string(','),
			rt.new_string((var_args_mutated.array_get(rt.new_string('return'))).str())])
		var_fields = rt.call_function('implode', [rt.new_string(', '),
			rt.call_function('array_intersect', [var_fields.clone(),
				rt.create_array_from_list(var_valid_fields)])])
	}
	mut var_query := rt.new_array()
	var_query.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
		var_fields), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'prefix')),
		rt.new_string('woocommerce_downloadable_product_permissions WHERE 1=1')))
	if rt.is_true(var_args_mutated.array_get(rt.new_string('user_email'))) {
		var_query.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND user_email = %s'),
			rt.call_function('sanitize_email', [
				var_args_mutated.array_get(rt.new_string('user_email')),
			]),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('user_id'))) {
		var_query.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND user_id = %d'),
			rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('user_id'))]),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('order_id'))) {
		var_query.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND order_id = %d'),
			var_args_mutated.array_get(rt.new_string('order_id')),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('order_key'))) {
		var_query.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND order_key = %s'),
			var_args_mutated.array_get(rt.new_string('order_key')),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('product_id'))) {
		var_query.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND product_id = %d'),
			var_args_mutated.array_get(rt.new_string('product_id')),
		]))
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('download_id'))) {
		var_query.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND download_id = %s'),
			var_args_mutated.array_get(rt.new_string('download_id')),
		]))
	}
	mut var_orderby := if rt.is_true(rt.call_function('in_array', [
		var_args_mutated.array_get(rt.new_string('orderby')),
		rt.create_array_from_list(var_valid_fields),
		rt.new_bool(true),
	]))
	{ var_args_mutated.array_get(rt.new_string('orderby')) } else { rt.new_string('permission_id') }
	mut var_order := rt.new_string((if rt.is_true(rt.identical(rt.new_string('DESC'),
		rt.new_string(var_args_mutated.array_get(rt.new_string('order')).to_string().to_upper())))
	{
		'DESC'
	} else {
		'ASC'
	}).str())
	mut var_orderby_sql := rt.call_function('sanitize_sql_orderby', [
		rt.new_string('${var_orderby.to_string()} ${var_order.to_string()}'),
	])
	var_query.array_push('ORDER BY ${var_orderby_sql.to_string()}')
	if rt.is_true(rt.less(rt.new_int(0), var_args_mutated.array_get(rt.new_string('limit')))) {
		var_query.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('LIMIT %d, %d'),
			rt.mul(rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('limit'))]), rt.call_function('absint', [
				rt.sub(var_args_mutated.array_get(rt.new_string('page')), rt.new_int(1))])),
			rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('limit'))]),
		]))
	}
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		rt.call_function('implode', [rt.new_string(' '), var_query.clone()]),
		var_get_results_output.clone(),
	])
	mut switch_val_1 := var_args_mutated.array_get(rt.new_string('return'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('ids'))) {
		return rt.call_function('wp_list_pluck', [var_results.clone(),
			rt.new_string('permission_id')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('objects'))) {
		return rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Customer_Download_Data_Store', [
					'WC_Customer_Download_Data_Store_Interface',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_download' },
			]),
			var_results.clone(),
		])
	} else {
		return var_results.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Customer_Download_Data_Store) update_download_id(var_product_id rt.PhpVal, var_old_id rt.PhpVal, var_new_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.3')])
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_downloadable_product_permissions'),
		rt.create_array([rt.ArrayItem{ key: 'download_id', val: var_new_id }]),
		rt.create_array([rt.ArrayItem{ key: 'download_id', val: var_old_id },
			rt.ArrayItem{ key: 'product_id', val: var_product_id }]),
	])
}

fn (mut this Class_WC_Customer_Download_Data_Store) get_downloads_for_customer(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '),
				rt.get_property(var_wpdb, 'prefix')),
				rt.new_string("woocommerce_downloadable_product_permissions as permissions\n\t\t\t\tWHERE user_id = %d\n\t\t\t\tAND permissions.order_id > 0\n\t\t\t\tAND\n\t\t\t\t\t(\n\t\t\t\t\t\tpermissions.downloads_remaining > 0\n\t\t\t\t\t\tOR permissions.downloads_remaining = ''\n\t\t\t\t\t)\n\t\t\t\tAND\n\t\t\t\t\t(\n\t\t\t\t\t\tpermissions.access_expires IS NULL\n\t\t\t\t\t\tOR permissions.access_expires >= %s\n\t\t\t\t\t\tOR permissions.access_expires = '0000-00-00 00:00:00'\n\t\t\t\t\t)\n\t\t\t\tORDER BY permissions.order_id, permissions.product_id, permissions.permission_id;")),
			var_customer_id.clone(),
			rt.call_function('date', [rt.new_string('Y-m-d'),
				rt.call_function('current_time', [rt.new_string('timestamp')])]),
		]),
	])
}

fn (mut this Class_WC_Customer_Download_Data_Store) update_user_by_order_id(var_order_id rt.PhpVal, var_customer_id rt.PhpVal, var_email rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_downloadable_product_permissions'),
		rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_customer_id },
			rt.ArrayItem{ key: 'user_email', val: var_email }]),
		rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' },
			rt.ArrayItem{ key: none, val: '%s' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' }]),
	])
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Customer_Download {
	rt.PhpObjectBase
}

fn create_wc_customer_download_data_store(_args ...rt.PhpVal) &Class_WC_Customer_Download_Data_Store {
	mut obj := &Class_WC_Customer_Download_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_customer_download(_args ...rt.PhpVal) &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer_Download_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create_from_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_from_data(dispatch_arg_0)
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'insert_new_download_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.insert_new_download_permission(dispatch_arg_0)
		}
		'adjust_date_for_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.adjust_date_for_db(dispatch_arg_0)
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
		'delete_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_by_id(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_download_log_by_field_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete_download_log_by_field_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_by_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_by_order_id(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_by_download_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_by_download_id(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_by_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_by_user_id(dispatch_arg_0))
		}
		'delete_by_user_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_by_user_email(dispatch_arg_0))
		}
		'get_download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_download(dispatch_arg_0)
		}
		'get_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_downloads(dispatch_arg_0)
		}
		'update_download_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.update_download_id(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_downloads_for_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_downloads_for_customer(dispatch_arg_0)
		}
		'update_user_by_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.update_user_by_order_id(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Customer_Download_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Customer_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
