import rt

pub fn Class_WC_Customer_Download_Log_Data_Store.wc_download_log_table() string {
	return 'wc_download_log'
}

struct Class_WC_Customer_Download_Log_Data_Store {
	rt.PhpObjectBase
}

fn Class_WC_Customer_Download_Log_Data_Store.get_table_name() string {
	return Class_WC_Customer_Download_Log_Data_Store.wc_download_log_table()
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) create(mut var_download_log Class_WC_Customer_Download_Log) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(var_download_log.get_timestamp(rt.new_string('edit')).is_null())) {
		var_download_log.set_timestamp(rt.call_function('time', []rt.PhpVal{}))
	}
	mut var_data := {
		'timestamp':       rt.call_function('date', [rt.new_string('Y-m-d H:i:s'),
			rt.call_method(var_download_log.get_timestamp(rt.new_string('edit')), 'getTimestamp',
				[]rt.PhpVal{})])
		'permission_id':   var_download_log.get_permission_id(rt.new_string('edit'))
		'user_id':         var_download_log.get_user_id(rt.new_string('edit'))
		'user_ip_address': var_download_log.get_user_ip_address(rt.new_string('edit'))
	}
	mut var_format := ['%s', '%s', '%s', '%s']
	mut var_result := rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			(Class_WC_Customer_Download_Log_Data_Store.get_table_name()).str()),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_downloadable_product_download_log_insert_data'),
			rt.create_array_from_native_map(var_data),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_downloadable_product_download_log_insert_format'),
			rt.create_array_from_list(var_format),
			rt.create_array_from_native_map(var_data),
		]),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_downloadable_product_download_log_insert'),
		rt.create_array_from_native_map(var_data),
	])
	if rt.is_true(var_result) {
		var_download_log.set_id(rt.get_property(var_wpdb, 'insert_id'))
		var_download_log.apply_changes()
	} else {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('Unable to insert download log entry in database.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) read(var_download_log rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_download_log, 'set_defaults', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_download_log, 'get_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid download log: no ID.'),
			rt.new_string('woocommerce'),
		]))))
	}
	mut var_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		(Class_WC_Customer_Download_Log_Data_Store.get_table_name()).str())
	mut var_raw_download_log := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT * FROM ${var_table.to_string()} WHERE download_log_id = %d'),
			rt.call_method(var_download_log, 'get_id', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_raw_download_log)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid download log: not found.'),
			rt.new_string('woocommerce'),
		]))))
	}
	rt.call_method(var_download_log, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'timestamp', val: rt.call_function('strtotime', [
				rt.get_property(var_raw_download_log, 'timestamp'),
			]) },
			rt.ArrayItem{ key: 'permission_id', val: rt.get_property(var_raw_download_log,
				'permission_id') },
			rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_raw_download_log, 'user_id') },
			rt.ArrayItem{ key: 'user_ip_address', val: rt.get_property(var_raw_download_log,
				'user_ip_address') },
		]),
	])
	rt.call_method(var_download_log, 'set_object_read', [rt.new_bool(true)])
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) update(var_download_log rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_data := {
		'timestamp':       rt.call_function('date', [rt.new_string('Y-m-d H:i:s'),
			rt.call_method(rt.call_method(var_download_log, 'get_timestamp', [
				rt.new_string('edit'),
			]), 'getTimestamp', []rt.PhpVal{})])
		'permission_id':   rt.call_method(var_download_log, 'get_permission_id', [
			rt.new_string('edit'),
		])
		'user_id':         rt.call_method(var_download_log, 'get_user_id', [
			rt.new_string('edit'),
		])
		'user_ip_address': rt.call_method(var_download_log, 'get_user_ip_address', [
			rt.new_string('edit'),
		])
	}
	mut var_format := ['%s', '%s', '%s', '%s']
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			(Class_WC_Customer_Download_Log_Data_Store.get_table_name()).str()),
		rt.create_array_from_native_map(var_data),
		rt.create_array([
			rt.ArrayItem{ key: 'download_log_id', val: rt.call_method(var_download_log, 'get_id',
				[]rt.PhpVal{}) },
		]),
		rt.create_array_from_list(var_format),
	])
	rt.call_method(var_download_log, 'apply_changes', []rt.PhpVal{})
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) get_download_log(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	return rt.new_object('WC_Customer_Download_Log', []string{},
		create_wc_customer_download_log(var_data_mutated.clone()))
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) get_download_logs(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'permission_id', val: '' },
			rt.ArrayItem{ key: 'user_id', val: '' }, rt.ArrayItem{ key: 'user_ip_address', val: '' },
			rt.ArrayItem{ key: 'orderby', val: 'download_log_id' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'limit', val: -1 },
			rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'return', val: 'objects' }])])
	mut var_is_count := rt.identical(rt.new_string('count'),
		var_args_mutated.array_get(rt.new_string('return')))
	mut var_query := []rt.PhpVal{}
	mut var_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		(Class_WC_Customer_Download_Log_Data_Store.get_table_name()).str())
	var_query << 'SELECT ' + if rt.is_true(var_is_count) { 'COUNT(1)' } else { '*' } +
		' FROM ${var_table.to_string()} WHERE 1=1'
	if rt.is_true(var_args_mutated.array_get(rt.new_string('permission_id'))) {
		var_query << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND permission_id = %d'),
			var_args_mutated.array_get(rt.new_string('permission_id')),
		])
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('user_id'))) {
		var_query << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND user_id = %d'),
			var_args_mutated.array_get(rt.new_string('user_id')),
		])
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('user_ip_address'))) {
		var_query << rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND user_ip_address = %s'),
			var_args_mutated.array_get(rt.new_string('user_ip_address')),
		])
	}
	mut var_allowed_orders := ['download_log_id', 'timestamp', 'permission_id', 'user_id']
	mut var_orderby := if rt.is_true(rt.call_function('in_array', [
		var_args_mutated.array_get(rt.new_string('orderby')),
		rt.create_array_from_list(var_allowed_orders),
		rt.new_bool(true),
	]))
	{
		var_args_mutated.array_get(rt.new_string('orderby'))
	} else {
		rt.new_string('download_log_id')
	}
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
	var_query << rt.new_string('ORDER BY ${var_orderby_sql.to_string()}')
	if rt.is_true(rt.less(rt.new_int(0), var_args_mutated.array_get(rt.new_string('limit')))) {
		var_query << rt.call_method(var_wpdb, 'prepare', [rt.new_string('LIMIT %d, %d'),
			rt.mul(rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('limit'))]), rt.call_function('absint', [
				rt.sub(var_args_mutated.array_get(rt.new_string('page')), rt.new_int(1))])),
			rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('limit'))])])
	}
	if rt.is_true(var_is_count) {
		return rt.call_function('absint', [
			rt.call_method(var_wpdb, 'get_var', [
				rt.call_function('implode', [rt.new_string(' '),
					rt.create_array_from_list(var_query)]),
			]),
		])
	}
	mut var_raw_download_logs := rt.call_method(var_wpdb, 'get_results', [
		rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_query)]),
	])
	mut switch_val_1 := var_args_mutated.array_get(rt.new_string('return'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('ids'))) {
		return rt.call_function('wp_list_pluck', [var_raw_download_logs.clone(),
			rt.new_string('download_log_id')])
	} else {
		return rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Customer_Download_Log_Data_Store', [
					'WC_Customer_Download_Log_Data_Store_Interface',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_download_log' },
			]),
			var_raw_download_logs.clone(),
		])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) get_download_logs_for_permission(var_permission_id rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_permission_id) {
		return []rt.PhpVal{}
	}
	return this.get_download_logs(rt.create_array([
		rt.ArrayItem{ key: 'permission_id', val: var_permission_id },
	]))
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) get_download_logs_count_for_permission(var_permission_id rt.PhpVal) i64 {
	if !rt.is_true(var_permission_id) {
		return 0
	}
	return (this.get_download_logs(rt.create_array([
		rt.ArrayItem{ key: 'permission_id', val: var_permission_id },
		rt.ArrayItem{ key: 'return', val: 'count' },
	]))).to_i64()
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) delete_by_permission_id(var_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_downloadable_product_permissions WHERE permission_id = %d')),
			var_id.clone(),
		]),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('wc_download_log WHERE permission_id = %d')),
			var_id.clone(),
		]),
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

struct Class_WC_Customer_Download_Log {
	rt.PhpObjectBase
}

fn create_wc_customer_download_log_data_store(_args ...rt.PhpVal) &Class_WC_Customer_Download_Log_Data_Store {
	mut obj := &Class_WC_Customer_Download_Log_Data_Store{
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

fn create_wc_customer_download_log(_args ...rt.PhpVal) &Class_WC_Customer_Download_Log {
	mut obj := &Class_WC_Customer_Download_Log{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_table_name' {
			return rt.new_string(Class_WC_Customer_Download_Log_Data_Store.get_table_name())
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Customer_Download_Log](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.create(mut dispatch_arg_0)
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
		'get_download_log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_download_log(dispatch_arg_0)
		}
		'get_download_logs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_download_logs(dispatch_arg_0)
		}
		'get_download_logs_for_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_download_logs_for_permission(dispatch_arg_0)
		}
		'get_download_logs_count_for_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_download_logs_count_for_permission(dispatch_arg_0))
		}
		'delete_by_permission_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_by_permission_id(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Customer_Download_Log_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download_Log_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Customer_Download_Log) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download_Log) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download_Log) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
