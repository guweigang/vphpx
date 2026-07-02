import rt

struct Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_table_name() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_meta_id_field() string {
	return 'id'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_object_id_field() string {
	return 'object_id'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_db_info() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'table', val: this.get_table_name() },
		rt.ArrayItem{ key: 'meta_id_field', val: this.get_meta_id_field() },
		rt.ArrayItem{ key: 'object_id_field', val: this.get_object_id_field() }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) read_meta(var_object rt.PhpVal) rt.PhpVal {
	mut var_object_id := rt.call_method(var_object, 'get_id', []rt.PhpVal{})
	mut var_raw_meta_data := this.get_meta_data_for_object_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_array](rt.create_array([
		rt.ArrayItem{ key: none, val: var_object_id },
	])))
	return if var_raw_meta_data.array_isset(var_object_id) {
		rt.cast_array(var_raw_meta_data.array_get(var_object_id))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) delete_meta(var_object rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_meta_mutated := var_meta
	if !(!(rt.get_property(var_meta_mutated, 'id')).is_null()) {
		return false
	}
	mut var_db_info := this.get_db_info()
	mut var_meta_id := rt.call_function('absint', [
		rt.get_property(var_meta_mutated, 'id'),
	])
	return (rt.call_method(var_wpdb, 'delete', [var_db_info.array_get(rt.new_string('table')),
		rt.create_array([
			rt.ArrayItem{
				key: var_db_info.array_get(rt.new_string('meta_id_field'))
				val: var_meta_id
			},
			rt.ArrayItem{ key: var_db_info.array_get(rt.new_string('object_id_field')), val: rt.call_method(var_object,
				'get_id', []rt.PhpVal{}) },
		]),
		rt.new_string('%d')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) add_meta(var_object rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_meta_mutated := var_meta
	mut var_db_info := this.get_db_info()
	mut var_object_id := rt.call_method(var_object, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) {
		return false
	}
	mut var_meta_key := rt.call_function('wp_unslash', [
		rt.call_function('wp_slash', [rt.get_property(var_meta_mutated, 'key')]),
	])
	mut var_meta_value := rt.call_function('maybe_serialize', [if rt.get_property(var_meta_mutated, 'value').is_string() { rt.call_function('wp_unslash', [
			rt.call_function('wp_slash', [rt.get_property(var_meta_mutated, 'value')]),
		]) } else { rt.get_property(var_meta_mutated, 'value') }])
	mut var_result := rt.call_method(var_wpdb, 'insert', [
		var_db_info.array_get(rt.new_string('table')),
		rt.create_array([
			rt.ArrayItem{
				key: var_db_info.array_get(rt.new_string('object_id_field'))
				val: var_object_id
			},
			rt.ArrayItem{ key: 'meta_key', val: var_meta_key },
			rt.ArrayItem{ key: 'meta_value', val: var_meta_value },
		]),
	])
	return (if rt.is_true(var_result) {
		rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	} else {
		rt.new_bool(false)
	}).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) update_meta(var_object rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_meta_mutated := var_meta
	if !(!(rt.get_property(var_meta_mutated, 'id')).is_null())
		|| !rt.is_true(rt.get_property(var_meta_mutated, 'key'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) {
		return false
	}
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'meta_key', val: rt.get_property(var_meta_mutated, 'key') },
		rt.ArrayItem{ key: 'meta_value', val: rt.call_function('maybe_serialize', [
			rt.get_property(var_meta_mutated, 'value'),
		]) },
	])
	mut var_result := rt.call_method(var_wpdb, 'update', [this.get_table_name(),
		var_data.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: this.get_meta_id_field()
				val: rt.get_property(var_meta_mutated, 'id')
			},
			rt.ArrayItem{ key: this.get_object_id_field(), val: rt.call_method(var_object,
				'get_id', []rt.PhpVal{}) },
		]),
		rt.new_string('%s'), rt.new_string('%d')])
	return (rt.identical(rt.new_int(1), var_result)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_metadata_by_id(var_meta_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_meta_id_mutated := var_meta_id
	if !(var_meta_id_mutated.clone().is_long() || var_meta_id_mutated.clone().is_double())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('floor', [var_meta_id_mutated.clone()]), var_meta_id_mutated)))) {
		return false
	}
	mut var_db_info := this.get_db_info()
	var_meta_id_mutated = rt.call_function('absint', [var_meta_id_mutated.clone()])
	mut var_meta := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
				var_db_info.array_get(rt.new_string('meta_id_field'))),
				rt.new_string(', meta_key, meta_value, ')),
				var_db_info.array_get(rt.new_string('object_id_field'))), rt.new_string(' FROM ')),
				var_db_info.array_get(rt.new_string('table'))), rt.new_string(' WHERE ')),
				var_db_info.array_get(rt.new_string('meta_id_field'))), rt.new_string(' = %d')),
			var_meta_id_mutated.clone(),
		]),
	])
	if !rt.is_true(var_meta) {
		return false
	}
	if !(rt.get_property(var_meta, 'meta_value')).is_null() {
		rt.set_property(var_meta, 'meta_value', rt.call_function('maybe_unserialize', [
			rt.get_property(var_meta, 'meta_value'),
		]))
	}
	return var_meta.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_metadata_by_key(var_object rt.PhpVal, meta_key string) bool {
	mut var_wpdb := rt.new_null()
	mut meta_key_mutated := meta_key
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) {
		return false
	}
	mut var_db_info := this.get_db_info()
	mut var_meta := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
				var_db_info.array_get(rt.new_string('meta_id_field'))),
				rt.new_string(', meta_key, meta_value, ')),
				var_db_info.array_get(rt.new_string('object_id_field'))), rt.new_string(' FROM ')),
				var_db_info.array_get(rt.new_string('table'))),
				rt.new_string(' WHERE meta_key = %s AND ')),
				var_db_info.array_get(rt.new_string('object_id_field'))), rt.new_string(' = %d')),
			rt.new_string(meta_key_mutated).clone(),
			rt.call_method(var_object, 'get_id', []rt.PhpVal{}),
		]),
	])
	if !rt.is_true(var_meta) {
		return false
	}
	mut iter_1 := var_meta.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_row := item_1.val
		if !(rt.get_property(var_row, 'meta_value')).is_null() {
			rt.set_property(var_row, 'meta_value', rt.call_function('maybe_unserialize', [
				rt.get_property(var_row, 'meta_value'),
			]))
		}
	}
	return var_meta.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_meta_keys(limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT DISTINCT meta_key FROM %i WHERE meta_key != '' AND meta_key NOT BETWEEN '_' AND '_z' AND meta_key NOT LIKE %s ORDER BY meta_key ASC LIMIT %d"),
			this.get_db_info().array_get(rt.new_string('table')),
			rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_')])).str() + '%'),
			rt.new_int(limit),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) get_meta_data_for_object_ids(mut var_object_ids Class_Automattic_WooCommerce_Internal_DataStores_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if !rt.is_true(var_object_ids) {
		return rt.new_array()
	}
	mut var_id_placeholder := rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_object_ids.array_count()),
			rt.new_string('%d')])])
	mut var_meta_table := this.get_table_name()
	mut var_object_id_column := rt.new_string(this.get_object_id_field())
	mut var_meta_rows := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT id, ${var_object_id_column.to_string()} as object_id, meta_key, meta_value FROM ${var_meta_table.to_string()} WHERE ${var_object_id_column.to_string()} in ( ${var_id_placeholder.to_string()} )'),
			var_object_ids,
		]),
	])
	mut var_meta_data := rt.call_function('array_fill_keys', [var_object_ids, rt.new_array()])
	mut iter_2 := var_meta_rows.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_meta_row := item_2.val
		if !(var_meta_data.array_isset(rt.get_property(var_meta_row, 'object_id'))) {
			var_meta_data.array_set(rt.get_property(var_meta_row, 'object_id'), rt.new_array())
		}
		var_meta_data.array_get_mut(rt.get_property(var_meta_row, 'object_id')).array_push(rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'meta_id', val: rt.get_property(var_meta_row, 'id') },
			rt.ArrayItem{ key: 'meta_key', val: rt.get_property(var_meta_row, 'meta_key') },
			rt.ArrayItem{ key: 'meta_value', val: rt.get_property(var_meta_row, 'meta_value') },
		])))
	}
	return var_meta_data.clone()
}

fn create_automattic_woocommerce_internal_datastores_custommetadatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_table_name' {
			this.get_table_name()
			return rt.new_null()
		}
		'get_meta_id_field' {
			return rt.new_string(this.get_meta_id_field())
		}
		'get_object_id_field' {
			return rt.new_string(this.get_object_id_field())
		}
		'get_db_info' {
			return this.get_db_info()
		}
		'read_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read_meta(dispatch_arg_0)
		}
		'delete_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.delete_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'add_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.add_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'get_metadata_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_metadata_by_id(dispatch_arg_0))
		}
		'get_metadata_by_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_metadata_by_key(dispatch_arg_0, dispatch_arg_1))
		}
		'get_meta_keys' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_meta_keys(dispatch_arg_0)
		}
		'get_meta_data_for_object_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_meta_data_for_object_ids(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
