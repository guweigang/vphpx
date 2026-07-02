import rt

fn add_metadata(var_meta_type rt.PhpVal, var_object_id_arg rt.PhpVal, var_meta_key_arg rt.PhpVal, var_meta_value_arg rt.PhpVal, unique bool) bool {
	mut var_unique := unique
	mut var_object_id := var_object_id_arg
	mut var_meta_key := var_meta_key_arg
	mut var_meta_value := var_meta_value_arg
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut var_meta_subtype := rt.new_null()
	mut var_column := rt.new_null()
	mut var_check := rt.new_null()
	mut var__meta_value := rt.new_null()
	mut var_result := rt.new_null()
	mut var_mid := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_meta_key)))) || !(var_object_id.clone().is_long()
		|| var_object_id.clone().is_double()) {
		return false
	}
	var_object_id = rt.call_function('absint', [var_object_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) {
		return false
	}
	var_table = rt.new_bool(_get_meta_table(var_meta_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	var_meta_subtype = get_object_subtype(var_meta_type.clone(), var_object_id.clone())
	var_column = rt.call_function('sanitize_key', [
		rt.new_string(var_meta_type.str() + '_id'),
	])
	var_meta_key = rt.call_function('wp_unslash', [var_meta_key.clone()])
	var_meta_value = rt.call_function('wp_unslash', [var_meta_value.clone()])
	var_meta_value = sanitize_meta(var_meta_key.clone(), var_meta_value.clone(),
		var_meta_type.clone(), var_meta_subtype.clone())
	var_check = rt.call_function('apply_filters', [
		rt.new_string('add_${var_meta_type.to_string()}_metadata'),
		rt.new_null(),
		var_object_id.clone(),
		var_meta_key.clone(),
		var_meta_value.clone(),
		rt.new_bool(unique),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	if var_unique
		&& rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT COUNT(*) FROM ${var_table.to_string()} WHERE meta_key = %s AND ${var_column.to_string()} = %d'), var_meta_key.clone(), var_object_id.clone()])])) {
		return false
	}
	var__meta_value = var_meta_value.clone()
	var_meta_value = rt.call_function('maybe_serialize', [var_meta_value.clone()])
	rt.call_function('do_action', [
		rt.new_string('add_${var_meta_type.to_string()}_meta'),
		var_object_id.clone(),
		var_meta_key.clone(),
		var__meta_value.clone(),
	])
	var_result = rt.call_method(var_wpdb, 'insert', [var_table.clone(),
		rt.create_array([rt.ArrayItem{ key: var_column, val: var_object_id },
			rt.ArrayItem{ key: 'meta_key', val: var_meta_key },
			rt.ArrayItem{ key: 'meta_value', val: var_meta_value }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	var_mid = rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	rt.call_function('wp_cache_delete', [var_object_id.clone(),
		rt.new_string(var_meta_type.str() + '_meta')])
	rt.call_function('do_action', [
		rt.new_string('added_${var_meta_type.to_string()}_meta'),
		var_mid.clone(),
		var_object_id.clone(),
		var_meta_key.clone(),
		var__meta_value.clone(),
	])
	return var_mid.to_bool()
}

fn update_metadata(var_meta_type rt.PhpVal, var_object_id_arg rt.PhpVal, var_meta_key_arg rt.PhpVal, var_meta_value_arg rt.PhpVal, prev_value string) bool {
	mut var_prev_value := prev_value
	mut var_object_id := var_object_id_arg
	mut var_meta_key := var_meta_key_arg
	mut var_meta_value := var_meta_value_arg
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut var_meta_subtype := rt.new_null()
	mut var_column := rt.new_null()
	mut var_id_column := ''
	mut var_raw_meta_key := rt.new_null()
	mut var_passed_value := rt.new_null()
	mut var_check := rt.new_null()
	mut var_old_value := rt.new_null()
	mut var_meta_ids := rt.new_null()
	mut var__meta_value := rt.new_null()
	mut var_data := rt.new_null()
	mut var_where := rt.new_null()
	mut var_meta_id := rt.new_null()
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_meta_key)))) || !(var_object_id.clone().is_long()
		|| var_object_id.clone().is_double()) {
		return false
	}
	var_object_id = rt.call_function('absint', [var_object_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) {
		return false
	}
	var_table = rt.new_bool(_get_meta_table(var_meta_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	var_meta_subtype = get_object_subtype(var_meta_type.clone(), var_object_id.clone())
	var_column = rt.call_function('sanitize_key', [
		rt.new_string(var_meta_type.str() + '_id'),
	])
	var_id_column = if rt.is_true(rt.identical(rt.new_string('user'), var_meta_type)) {
		'umeta_id'
	} else {
		'meta_id'
	}
	var_raw_meta_key = var_meta_key.clone()
	var_meta_key = rt.call_function('wp_unslash', [var_meta_key.clone()])
	var_passed_value = var_meta_value.clone()
	var_meta_value = rt.call_function('wp_unslash', [var_meta_value.clone()])
	var_meta_value = sanitize_meta(var_meta_key.clone(), var_meta_value.clone(),
		var_meta_type.clone(), var_meta_subtype.clone())
	var_check = rt.call_function('apply_filters', [
		rt.new_string('update_${var_meta_type.to_string()}_metadata'),
		rt.new_null(),
		var_object_id.clone(),
		var_meta_key.clone(),
		var_meta_value.clone(),
		rt.new_string(var_prev_value.str()),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	if var_prev_value == '' {
		var_old_value = get_metadata_raw(var_meta_type.clone(), var_object_id.clone(),
			var_meta_key.clone(), false)
		if rt.call_function('is_countable', [var_old_value.clone()])
			&& var_old_value.clone().array_count() == 1 {
			if rt.is_true(rt.identical(var_old_value.array_get(rt.new_int(0)), var_meta_value)) {
				return false
			}
		}
	}
	var_meta_ids = rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT ${var_id_column} FROM ${var_table.to_string()} WHERE meta_key = %s AND ${var_column.to_string()} = %d'),
			var_meta_key.clone(),
			var_object_id.clone(),
		]),
	])
	if !rt.is_true(var_meta_ids) {
		return add_metadata(var_meta_type.clone(), var_object_id.clone(), var_raw_meta_key.clone(),
			var_passed_value.clone())
	}
	var__meta_value = var_meta_value.clone()
	var_meta_value = rt.call_function('maybe_serialize', [var_meta_value.clone()])
	var_data = rt.call_function('compact', [rt.new_string('meta_value')])
	var_where = rt.create_array([rt.ArrayItem{ key: var_column, val: var_object_id },
		rt.ArrayItem{ key: 'meta_key', val: var_meta_key }])
	if !(var_prev_value == '') {
		var_prev_value = (rt.call_function('maybe_serialize', [
			rt.new_string(var_prev_value.str()),
		])).str()
		var_where.array_set('meta_value', var_prev_value)
	}
	mut iter_1 := var_meta_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta_id_shadow := item_1.val
		rt.call_function('do_action', [
			rt.new_string('update_${var_meta_type.to_string()}_meta'),
			var_meta_id_shadow.clone(),
			var_object_id.clone(),
			var_meta_key.clone(),
			var__meta_value.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type)) {
			rt.call_function('do_action', [rt.new_string('update_postmeta'),
				var_meta_id_shadow.clone(), var_object_id.clone(),
				var_meta_key.clone(), var_meta_value.clone()])
		}
	}
	var_result = rt.call_method(var_wpdb, 'update', [var_table.clone(),
		var_data.clone(), var_where.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	rt.call_function('wp_cache_delete', [var_object_id.clone(),
		rt.new_string(var_meta_type.str() + '_meta')])
	mut iter_2 := var_meta_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_meta_id_shadow := item_2.val
		rt.call_function('do_action', [
			rt.new_string('updated_${var_meta_type.to_string()}_meta'),
			var_meta_id_shadow.clone(),
			var_object_id.clone(),
			var_meta_key.clone(),
			var__meta_value.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type)) {
			rt.call_function('do_action', [rt.new_string('updated_postmeta'),
				var_meta_id_shadow.clone(), var_object_id.clone(),
				var_meta_key.clone(), var_meta_value.clone()])
		}
	}
	return true
}

fn delete_metadata(var_meta_type rt.PhpVal, var_object_id_arg rt.PhpVal, var_meta_key_arg rt.PhpVal, meta_value string, delete_all bool) bool {
	mut var_meta_value := meta_value
	mut var_delete_all := delete_all
	mut var_object_id := var_object_id_arg
	mut var_meta_key := var_meta_key_arg
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut var_type_column := rt.new_null()
	mut var_id_column := ''
	mut var_check := rt.new_null()
	mut var__meta_value := rt.new_null()
	mut var_query := rt.new_null()
	mut var_meta_ids := rt.new_null()
	mut var_object_ids := rt.new_null()
	mut var_count := rt.new_null()
	mut var_data := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_meta_key))))
		|| (!(var_object_id.clone().is_long() || var_object_id.clone().is_double())
		&& !var_delete_all) {
		return false
	}
	var_object_id = rt.call_function('absint', [var_object_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) && !var_delete_all {
		return false
	}
	var_table = rt.new_bool(_get_meta_table(var_meta_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	var_type_column = rt.call_function('sanitize_key', [
		rt.new_string(var_meta_type.str() + '_id'),
	])
	var_id_column = if rt.is_true(rt.identical(rt.new_string('user'), var_meta_type)) {
		'umeta_id'
	} else {
		'meta_id'
	}
	var_meta_key = rt.call_function('wp_unslash', [var_meta_key.clone()])
	var_meta_value = (rt.call_function('wp_unslash', [
		rt.new_string(var_meta_value.str()),
	])).str()
	var_check = rt.call_function('apply_filters', [
		rt.new_string('delete_${var_meta_type.to_string()}_metadata'),
		rt.new_null(),
		var_object_id.clone(),
		var_meta_key.clone(),
		rt.new_string(var_meta_value.str()),
		rt.new_bool(delete_all),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	var__meta_value = rt.new_string(var_meta_value.str())
	var_meta_value = (rt.call_function('maybe_serialize', [
		rt.new_string(var_meta_value.str()),
	])).str()
	var_query = rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SELECT ${var_id_column} FROM ${var_table.to_string()} WHERE meta_key = %s'),
		var_meta_key.clone(),
	])
	if !var_delete_all {
		var_query = rt.concat(var_query, rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND ${var_type_column.to_string()} = %d'),
			var_object_id.clone(),
		]))
	}
	if rt.is_true(rt.new_bool('' != var_meta_value))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.new_string(var_meta_value.str())))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_string(var_meta_value.str()))))) {
		var_query = rt.concat(var_query, rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND meta_value = %s'),
			rt.new_string(var_meta_value.str()),
		]))
	}
	var_meta_ids = rt.call_method(var_wpdb, 'get_col', [var_query.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_meta_ids.clone().array_count()))))) {
		return false
	}
	if var_delete_all {
		if rt.is_true(rt.new_bool('' != var_meta_value))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.new_string(var_meta_value.str())))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_string(var_meta_value.str()))))) {
			var_object_ids = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.new_string('SELECT ${var_type_column.to_string()} FROM ${var_table.to_string()} WHERE meta_key = %s AND meta_value = %s'),
					var_meta_key.clone(),
					rt.new_string(var_meta_value.str()),
				]),
			])
		} else {
			var_object_ids = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.new_string('SELECT ${var_type_column.to_string()} FROM ${var_table.to_string()} WHERE meta_key = %s'),
					var_meta_key.clone(),
				]),
			])
		}
	}
	rt.call_function('do_action', [
		rt.new_string('delete_${var_meta_type.to_string()}_meta'),
		var_meta_ids.clone(),
		var_object_id.clone(),
		var_meta_key.clone(),
		var__meta_value.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type)) {
		rt.call_function('do_action', [rt.new_string('delete_postmeta'),
			var_meta_ids.clone()])
	}
	var_query = rt.new_string('DELETE FROM ${var_table.to_string()} WHERE ${var_id_column} IN( ' +
		(rt.call_function('implode', [rt.new_string(','), var_meta_ids.clone()])).str() + ' )')
	var_count = rt.call_method(var_wpdb, 'query', [var_query.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_count)))) {
		return false
	}
	if var_delete_all {
		var_data = rt.cast_array(var_object_ids)
	} else {
		var_data = rt.create_array([rt.ArrayItem{ key: none, val: var_object_id }])
	}
	rt.call_function('wp_cache_delete_multiple', [var_data.clone(),
		rt.new_string(var_meta_type.str() + '_meta')])
	rt.call_function('do_action', [
		rt.new_string('deleted_${var_meta_type.to_string()}_meta'),
		var_meta_ids.clone(),
		var_object_id.clone(),
		var_meta_key.clone(),
		var__meta_value.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type)) {
		rt.call_function('do_action', [rt.new_string('deleted_postmeta'),
			var_meta_ids.clone()])
	}
	return true
}

fn get_metadata(var_meta_type rt.PhpVal, var_object_id rt.PhpVal, meta_key string, single bool) rt.PhpVal {
	mut var_meta_key := meta_key
	mut var_single := single
	mut var_value := rt.new_null()
	var_value = get_metadata_raw(var_meta_type.clone(), var_object_id.clone(), meta_key, single)
	if !(var_value.clone().is_null()) {
		return var_value.clone()
	}
	return get_metadata_default(var_meta_type.clone(), var_object_id.clone(),
		rt.new_string(meta_key), single)
}

fn get_metadata_raw(var_meta_type rt.PhpVal, var_object_id_arg rt.PhpVal, meta_key string, single bool) rt.PhpVal {
	mut var_meta_key := meta_key
	mut var_single := single
	mut var_object_id := var_object_id_arg
	mut var_check := rt.new_null()
	mut var_meta_cache := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type)))) || !(var_object_id.clone().is_long()
		|| var_object_id.clone().is_double()) {
		return rt.new_bool(false)
	}
	var_object_id = rt.call_function('absint', [var_object_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) {
		return rt.new_bool(false)
	}
	var_check = rt.call_function('apply_filters', [
		rt.new_string('get_${var_meta_type.to_string()}_metadata'),
		rt.new_null(),
		var_object_id.clone(),
		rt.new_string(meta_key),
		rt.new_bool(single),
		var_meta_type.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		if var_single && var_check.clone().is_array() {
			return var_check.array_get(rt.new_int(0))
		} else {
			return var_check.clone()
		}
	}
	var_meta_cache = rt.call_function('wp_cache_get', [var_object_id.clone(),
		rt.new_string(var_meta_type.str() + '_meta')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_cache)))) {
		var_meta_cache = rt.new_bool(update_meta_cache(var_meta_type.clone(), rt.create_array([
			rt.ArrayItem{ key: none, val: var_object_id },
		])))
		var_meta_cache = if !(var_meta_cache.array_get(var_object_id)).is_null() {
			var_meta_cache.array_get(var_object_id)
		} else {
			rt.new_null()
		}
	}
	if !(var_meta_key.len > 0 && var_meta_key != '0') {
		return var_meta_cache.clone()
	}
	if var_meta_cache.array_isset(rt.new_string(meta_key)) {
		if var_single {
			return rt.call_function('maybe_unserialize',
				[var_meta_cache.array_get(rt.new_string(meta_key)).array_get(rt.new_int(0))])
		} else {
			return rt.call_function('array_map', [rt.new_string('maybe_unserialize'),
				var_meta_cache.array_get(rt.new_string(meta_key))])
		}
	}
	return rt.new_null()
}

fn get_metadata_default(var_meta_type rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, single bool) rt.PhpVal {
	mut var_single := single
	mut var_value := rt.new_null()
	if var_single {
		var_value = rt.new_string('')
	} else {
		var_value = rt.new_array()
	}
	var_value = rt.call_function('apply_filters', [
		rt.new_string('default_${var_meta_type.to_string()}_metadata'),
		var_value.clone(),
		var_object_id.clone(),
		var_meta_key.clone(),
		rt.new_bool(single),
		var_meta_type.clone(),
	])
	if !var_single
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_numeric_array', [var_value.clone()]))))) {
		var_value = rt.create_array([rt.ArrayItem{ key: none, val: var_value }])
	}
	return var_value.clone()
}

fn metadata_exists(var_meta_type rt.PhpVal, var_object_id_arg rt.PhpVal, var_meta_key rt.PhpVal) bool {
	mut var_object_id := var_object_id_arg
	mut var_check := rt.new_null()
	mut var_meta_cache := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type)))) || !(var_object_id.clone().is_long()
		|| var_object_id.clone().is_double()) {
		return false
	}
	var_object_id = rt.call_function('absint', [var_object_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) {
		return false
	}
	var_check = rt.call_function('apply_filters', [
		rt.new_string('get_${var_meta_type.to_string()}_metadata'),
		rt.new_null(),
		var_object_id.clone(),
		var_meta_key.clone(),
		rt.new_bool(true),
		var_meta_type.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	var_meta_cache = rt.call_function('wp_cache_get', [var_object_id.clone(),
		rt.new_string(var_meta_type.str() + '_meta')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_cache)))) {
		var_meta_cache = rt.new_bool(update_meta_cache(var_meta_type.clone(), rt.create_array([
			rt.ArrayItem{ key: none, val: var_object_id },
		])))
		var_meta_cache = var_meta_cache.array_get(var_object_id)
	}
	if var_meta_cache.array_isset(var_meta_key) {
		return true
	}
	return false
}

fn get_metadata_by_mid(var_meta_type rt.PhpVal, var_meta_id_arg rt.PhpVal) bool {
	mut var_meta_id := var_meta_id_arg
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut var_check := rt.new_null()
	mut var_id_column := ''
	mut var_meta := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type)))) || !(var_meta_id.clone().is_long()
		|| var_meta_id.clone().is_double())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('floor', [var_meta_id.clone()]), var_meta_id)))) {
		return false
	}
	var_meta_id = rt.new_int(var_meta_id.to_i64())
	if rt.is_true(rt.less_equal(var_meta_id, rt.new_int(0))) {
		return false
	}
	var_table = rt.new_bool(_get_meta_table(var_meta_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	var_check = rt.call_function('apply_filters', [
		rt.new_string('get_${var_meta_type.to_string()}_metadata_by_mid'),
		rt.new_null(),
		var_meta_id.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	var_id_column = if rt.is_true(rt.identical(rt.new_string('user'), var_meta_type)) {
		'umeta_id'
	} else {
		'meta_id'
	}
	var_meta = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT * FROM ${var_table.to_string()} WHERE ${var_id_column} = %d'),
			var_meta_id.clone(),
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

fn update_metadata_by_mid(var_meta_type rt.PhpVal, var_meta_id_arg rt.PhpVal, var_meta_value_arg rt.PhpVal, meta_key bool) bool {
	mut var_meta_key := meta_key
	mut var_meta_id := var_meta_id_arg
	mut var_meta_value := var_meta_value_arg
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut var_column := rt.new_null()
	mut var_id_column := ''
	mut var_check := rt.new_null()
	mut var_meta := false
	mut var_original_key := rt.new_null()
	mut var_object_id := rt.new_null()
	mut var_meta_subtype := rt.new_null()
	mut var__meta_value := rt.new_null()
	mut var_data := rt.new_null()
	mut var_where := rt.new_null()
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type)))) || !(var_meta_id.clone().is_long()
		|| var_meta_id.clone().is_double())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('floor', [var_meta_id.clone()]), var_meta_id)))) {
		return false
	}
	var_meta_id = rt.new_int(var_meta_id.to_i64())
	if rt.is_true(rt.less_equal(var_meta_id, rt.new_int(0))) {
		return false
	}
	var_table = rt.new_bool(_get_meta_table(var_meta_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	var_column = rt.call_function('sanitize_key', [
		rt.new_string(var_meta_type.str() + '_id'),
	])
	var_id_column = if rt.is_true(rt.identical(rt.new_string('user'), var_meta_type)) {
		'umeta_id'
	} else {
		'meta_id'
	}
	var_check = rt.call_function('apply_filters', [
		rt.new_string('update_${var_meta_type.to_string()}_metadata_by_mid'),
		rt.new_null(),
		var_meta_id.clone(),
		var_meta_value.clone(),
		rt.new_bool(var_meta_key),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	var_meta = get_metadata_by_mid(var_meta_type.clone(), var_meta_id.clone())
	if var_meta {
		var_original_key = rt.get_property(rt.new_bool(var_meta), 'meta_key')
		var_object_id = rt.get_property(rt.new_bool(var_meta),
			'{"nodeType":"Expr_Variable","line":940,"name":"column"}')
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_meta_key))) {
			var_meta_key = var_original_key.to_bool()
		} else if !(rt.new_bool(var_meta_key).is_string()) {
			return false
		}
		var_meta_subtype = get_object_subtype(var_meta_type.clone(), var_object_id.clone())
		var__meta_value = var_meta_value.clone()
		var_meta_value = sanitize_meta(rt.new_bool(var_meta_key), var_meta_value.clone(),
			var_meta_type.clone(), var_meta_subtype.clone())
		var_meta_value = rt.call_function('maybe_serialize', [
			var_meta_value.clone()])
		var_data = rt.create_array([rt.ArrayItem{ key: 'meta_key', val: var_meta_key },
			rt.ArrayItem{ key: 'meta_value', val: var_meta_value }])
		var_where = rt.new_array()
		var_where.array_set(var_id_column, var_meta_id.clone())
		rt.call_function('do_action', [
			rt.new_string('update_${var_meta_type.to_string()}_meta'),
			var_meta_id.clone(),
			var_object_id.clone(),
			rt.new_bool(var_meta_key),
			var__meta_value.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type)) {
			rt.call_function('do_action', [rt.new_string('update_postmeta'),
				var_meta_id.clone(), var_object_id.clone(), rt.new_bool(var_meta_key),
				var_meta_value.clone()])
		}
		var_result = rt.call_method(var_wpdb, 'update', [var_table.clone(),
			var_data.clone(), var_where.clone(), rt.new_string('%s'),
			rt.new_string('%d')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
			return false
		}
		rt.call_function('wp_cache_delete', [var_object_id.clone(),
			rt.new_string(var_meta_type.str() + '_meta')])
		rt.call_function('do_action', [
			rt.new_string('updated_${var_meta_type.to_string()}_meta'),
			var_meta_id.clone(),
			var_object_id.clone(),
			rt.new_bool(var_meta_key),
			var__meta_value.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type)) {
			rt.call_function('do_action', [rt.new_string('updated_postmeta'),
				var_meta_id.clone(), var_object_id.clone(), rt.new_bool(var_meta_key),
				var_meta_value.clone()])
		}
		return true
	}
	return false
}

fn delete_metadata_by_mid(var_meta_type rt.PhpVal, var_meta_id_arg rt.PhpVal) bool {
	mut var_meta_id := var_meta_id_arg
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut var_column := rt.new_null()
	mut var_id_column := ''
	mut var_check := rt.new_null()
	mut var_meta := false
	mut var_object_id := rt.new_null()
	mut var_result := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type)))) || !(var_meta_id.clone().is_long()
		|| var_meta_id.clone().is_double())
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('floor', [var_meta_id.clone()]), var_meta_id)))) {
		return false
	}
	var_meta_id = rt.new_int(var_meta_id.to_i64())
	if rt.is_true(rt.less_equal(var_meta_id, rt.new_int(0))) {
		return false
	}
	var_table = rt.new_bool(_get_meta_table(var_meta_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	var_column = rt.call_function('sanitize_key', [
		rt.new_string(var_meta_type.str() + '_id'),
	])
	var_id_column = if rt.is_true(rt.identical(rt.new_string('user'), var_meta_type)) {
		'umeta_id'
	} else {
		'meta_id'
	}
	var_check = rt.call_function('apply_filters', [
		rt.new_string('delete_${var_meta_type.to_string()}_metadata_by_mid'),
		rt.new_null(),
		var_meta_id.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	var_meta = get_metadata_by_mid(var_meta_type.clone(), var_meta_id.clone())
	if var_meta {
		var_object_id = rt.new_int((rt.get_property(rt.new_bool(var_meta),
			'{"nodeType":"Expr_Variable","line":1063,"name":"column"}')).to_i64())
		rt.call_function('do_action', [
			rt.new_string('delete_${var_meta_type.to_string()}_meta'),
			rt.cast_array(var_meta_id),
			var_object_id.clone(),
			rt.get_property(rt.new_bool(var_meta), 'meta_key'),
			rt.get_property(rt.new_bool(var_meta), 'meta_value'),
		])
		if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type))
			|| rt.is_true(rt.identical(rt.new_string('comment'), var_meta_type)) {
			rt.call_function('do_action', [
				rt.new_string('delete_${var_meta_type.to_string()}meta'),
				var_meta_id.clone(),
			])
		}
		var_result = rt.new_bool((rt.call_method(var_wpdb, 'delete', [
			var_table.clone(), rt.create_array([
				rt.ArrayItem{ key: var_id_column, val: var_meta_id },
			])])).to_bool())
		rt.call_function('wp_cache_delete', [var_object_id.clone(),
			rt.new_string(var_meta_type.str() + '_meta')])
		rt.call_function('do_action', [
			rt.new_string('deleted_${var_meta_type.to_string()}_meta'),
			rt.cast_array(var_meta_id),
			var_object_id.clone(),
			rt.get_property(rt.new_bool(var_meta), 'meta_key'),
			rt.get_property(rt.new_bool(var_meta), 'meta_value'),
		])
		if rt.is_true(rt.identical(rt.new_string('post'), var_meta_type))
			|| rt.is_true(rt.identical(rt.new_string('comment'), var_meta_type)) {
			rt.call_function('do_action', [
				rt.new_string('deleted_${var_meta_type.to_string()}meta'),
				var_meta_id.clone(),
			])
		}
		return var_result.to_bool()
	}
	return false
}

fn update_meta_cache(var_meta_type rt.PhpVal, var_object_ids_arg rt.PhpVal) bool {
	mut var_object_ids := var_object_ids_arg
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_null()
	mut var_column := rt.new_null()
	mut var_check := rt.new_null()
	mut var_cache_group := rt.new_null()
	mut var_non_cached_ids := []rt.PhpVal{}
	mut var_cache := rt.new_null()
	mut var_cache_values := rt.new_null()
	mut var_cached_object := rt.new_null()
	mut var_id := rt.new_null()
	mut var_id_list := rt.new_null()
	mut var_id_column := ''
	mut var_meta_list := rt.new_null()
	mut var_metarow := rt.new_null()
	mut var_mpid := rt.new_null()
	mut var_mkey := rt.new_null()
	mut var_mval := rt.new_null()
	mut var_data := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_object_ids)))) {
		return false
	}
	var_table = rt.new_bool(_get_meta_table(var_meta_type.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table)))) {
		return false
	}
	var_column = rt.call_function('sanitize_key', [
		rt.new_string(var_meta_type.str() + '_id'),
	])
	if !(var_object_ids.clone().is_array()) {
		var_object_ids = rt.call_function('preg_replace', [rt.new_string('|[^0-9,]|'),
			rt.new_string(''), var_object_ids.clone()])
		var_object_ids = rt.call_function('explode', [rt.new_string(','),
			var_object_ids.clone()])
	}
	var_object_ids = rt.call_function('array_map', [rt.new_string('intval'),
		var_object_ids.clone()])
	var_check = rt.call_function('apply_filters', [
		rt.new_string('update_${var_meta_type.to_string()}_metadata_cache'),
		rt.new_null(),
		var_object_ids.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.to_bool()
	}
	var_cache_group = rt.new_string(var_meta_type.str() + '_meta')
	var_non_cached_ids = rt.new_array()
	var_cache = rt.new_array()
	var_cache_values = rt.call_function('wp_cache_get_multiple', [
		var_object_ids.clone(), var_cache_group.clone()])
	mut iter_3 := var_cache_values.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_cached_object_shadow := item_3.val
		mut var_id_shadow := item_3.key
		if rt.is_true(rt.identical(rt.new_bool(false), var_cached_object_shadow)) {
			var_non_cached_ids << var_id_shadow.clone()
		} else {
			var_cache.array_set(var_id_shadow, var_cached_object_shadow.clone())
		}
	}
	if !rt.is_true(var_non_cached_ids) {
		return var_cache.to_bool()
	}
	var_id_list = rt.call_function('implode', [rt.new_string(','),
		rt.create_array_from_list(var_non_cached_ids)])
	var_id_column = if rt.is_true(rt.identical(rt.new_string('user'), var_meta_type)) {
		'umeta_id'
	} else {
		'meta_id'
	}
	var_meta_list = rt.call_method(var_wpdb, 'get_results', [
		rt.new_string('SELECT ${var_column.to_string()}, meta_key, meta_value FROM ${var_table.to_string()} WHERE ${var_column.to_string()} IN (${var_id_list.to_string()}) ORDER BY ${var_id_column} ASC'),
		rt.get_constant('ARRAY_A'),
	])
	if !(!rt.is_true(var_meta_list)) {
		mut iter_4 := var_meta_list.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_metarow_shadow := item_4.val
			var_mpid = rt.new_int((var_metarow_shadow.array_get(var_column)).to_i64())
			var_mkey = var_metarow_shadow.array_get(rt.new_string('meta_key'))
			var_mval = var_metarow_shadow.array_get(rt.new_string('meta_value'))
			if !(var_cache.array_isset(var_mpid)) || !(var_cache.array_get(var_mpid).is_array()) {
				var_cache.array_set(var_mpid, rt.new_array())
			}
			if !(var_cache.array_get(var_mpid).array_isset(var_mkey))
				|| !(var_cache.array_get(var_mpid).array_get(var_mkey).is_array()) {
				var_cache.array_get_mut(var_mpid).array_set(var_mkey, rt.new_array())
			}
			var_cache.array_get_mut(var_mpid).array_get_mut(var_mkey).array_push(var_mval.clone())
		}
	}
	var_data = rt.new_array()
	for var_id_shadow in var_non_cached_ids {
		if !(var_cache.array_isset(var_id_shadow)) {
			var_cache.array_set(var_id_shadow, rt.new_array())
		}
		var_data.array_set(var_id_shadow, var_cache.array_get(var_id_shadow))
	}
	rt.call_function('wp_cache_add_multiple', [var_data.clone(),
		var_cache_group.clone()])
	return var_cache.to_bool()
}

fn wp_metadata_lazyloader() rt.PhpVal {
	mut var_wp_metadata_lazyloader := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_wp_metadata_lazyloader)) {
		var_wp_metadata_lazyloader = create_wp_metadata_lazyloader()
	}
	return mut var_wp_metadata_lazyloader
}

fn get_meta_sql(var_meta_query rt.PhpVal, var_type rt.PhpVal, var_primary_table rt.PhpVal, var_primary_id_column rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_meta_query_obj := rt.new_null()
	var_meta_query_obj = create_wp_meta_query(var_meta_query.clone())
	return var_meta_query_obj.get_sql(var_type.clone(), var_primary_table.clone(),
		var_primary_id_column.clone(), var_context.clone())
}

fn _get_meta_table(var_type rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_table_name := rt.new_null()
	var_table_name = rt.new_string(var_type.str() + 'meta')
	if !rt.is_true(rt.get_property(var_wpdb,
		'{"nodeType":"Expr_Variable","line":1295,"name":"table_name"}')) {
		return false
	}
	return (rt.get_property(var_wpdb,
		'{"nodeType":"Expr_Variable","line":1299,"name":"table_name"}')).to_bool()
}

fn is_protected_meta(var_meta_key rt.PhpVal, meta_type string) rt.PhpVal {
	mut var_meta_type := meta_type
	mut var_sanitized_key := rt.new_null()
	mut var_protected := false
	var_sanitized_key = rt.call_function('preg_replace', [
		rt.new_string('/[^ -~\\p{L}]/'),
		rt.new_string(''),
		var_meta_key.clone(),
	])
	var_protected = var_sanitized_key.clone().to_string().len > 0
		&& rt.is_true(rt.identical(rt.new_string('_'), var_sanitized_key.array_get(rt.new_int(0))))
	return rt.call_function('apply_filters', [rt.new_string('is_protected_meta'),
		rt.new_bool(var_protected).clone(), var_meta_key.clone(),
		rt.new_string(meta_type)])
}

fn sanitize_meta(var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, var_object_type rt.PhpVal, object_subtype string) rt.PhpVal {
	mut var_object_subtype := object_subtype
	if !(object_subtype == '')
		&& rt.is_true(rt.call_function('has_filter', [rt.new_string('sanitize_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype}')])) {
		return rt.call_function('apply_filters', [
			rt.new_string('sanitize_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype}'),
			var_meta_value.clone(),
			var_meta_key.clone(),
			var_object_type.clone(),
			rt.new_string(object_subtype),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('sanitize_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}'),
		var_meta_value.clone(),
		var_meta_key.clone(),
		var_object_type.clone(),
	])
}

fn register_meta(var_object_type rt.PhpVal, var_meta_key rt.PhpVal, var_args_arg rt.PhpVal, var_deprecated rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_wp_meta_keys := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_has_old_sanitize_cb := false
	mut var_has_old_auth_cb := false
	mut var_object_subtype := rt.new_null()
	mut var_schema := rt.new_null()
	mut var_check := rt.new_null()
	if !(var_wp_meta_keys.clone().is_array()) {
		var_wp_meta_keys = rt.new_array()
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'object_subtype', val: '' },
		rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'label', val: '' },
		rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'default', val: '' },
		rt.ArrayItem{ key: 'single', val: false }, rt.ArrayItem{
			key: 'sanitize_callback'
			val: rt.new_null()
		}, rt.ArrayItem{ key: 'auth_callback', val: rt.new_null() },
		rt.ArrayItem{ key: 'show_in_rest', val: false }, rt.ArrayItem{
			key: 'revisions_enabled'
			val: false
		}])
	var_has_old_sanitize_cb = false
	var_has_old_auth_cb = false
	if rt.is_true(rt.call_function('is_callable', [var_args.clone()])) {
		var_args = rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: var_args },
		])
		var_has_old_sanitize_cb = true
	} else {
		var_args = rt.cast_array(var_args)
	}
	if rt.is_true(rt.call_function('is_callable', [var_deprecated.clone()])) {
		var_args.array_set('auth_callback', var_deprecated.clone())
		var_has_old_auth_cb = true
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('register_meta_args'),
		var_args.clone(), var_defaults.clone(), var_object_type.clone(),
		var_meta_key.clone()])
	var_defaults.array_unset(rt.new_string('default'))
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_string('show_in_rest'))))))
		&& rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get(rt.new_string('type')))) {
		if !(var_args.array_get(rt.new_string('show_in_rest')).is_array())
			|| !(var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema')).array_isset(rt.new_string('items'))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('__', [
					rt.new_string('When registering an "array" meta type to show in the REST API, you must specify the schema for each array item in "show_in_rest.schema.items".'),
				]),
				rt.new_string('5.3.0')])
			return false
		}
	}
	var_object_subtype = if !(!rt.is_true(var_args.array_get(rt.new_string('object_subtype')))) {
		var_args.array_get(rt.new_string('object_subtype'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(var_args.array_get(rt.new_string('revisions_enabled'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_object_type)))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('__', [
					rt.new_string('Meta keys cannot enable revisions support unless the object type supports revisions.'),
				]),
				rt.new_string('6.4.0')])
			return false
		} else if !(!rt.is_true(var_object_subtype))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [var_object_subtype.clone(), rt.new_string('revisions')]))))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('__', [
					rt.new_string('Meta keys cannot enable revisions support unless the object subtype supports revisions.'),
				]),
				rt.new_string('6.4.0')])
			return false
		}
	}
	if !rt.is_true(var_args.array_get(rt.new_string('auth_callback'))) {
		if rt.is_true(is_protected_meta(var_meta_key.clone(), var_object_type.clone())) {
			var_args.array_set('auth_callback', '__return_false')
		} else {
			var_args.array_set('auth_callback', '__return_true')
		}
	}
	if rt.is_true(rt.call_function('is_callable', [
		var_args.array_get(rt.new_string('sanitize_callback')),
	]))
	{
		if !(!rt.is_true(var_object_subtype)) {
			rt.call_function('add_filter', [
				rt.new_string('sanitize_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype.to_string()}'),
				var_args.array_get(rt.new_string('sanitize_callback')),
				rt.new_int(10),
				rt.new_int(4),
			])
		} else {
			rt.call_function('add_filter', [
				rt.new_string('sanitize_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}'),
				var_args.array_get(rt.new_string('sanitize_callback')),
				rt.new_int(10),
				rt.new_int(3),
			])
		}
	}
	if rt.is_true(rt.call_function('is_callable', [
		var_args.array_get(rt.new_string('auth_callback')),
	]))
	{
		if !(!rt.is_true(var_object_subtype)) {
			rt.call_function('add_filter', [
				rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype.to_string()}'),
				var_args.array_get(rt.new_string('auth_callback')),
				rt.new_int(10),
				rt.new_int(6),
			])
		} else {
			rt.call_function('add_filter', [
				rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}'),
				var_args.array_get(rt.new_string('auth_callback')),
				rt.new_int(10),
				rt.new_int(6),
			])
		}
	}
	if rt.is_true(rt.new_bool(var_args.clone().array_isset(rt.new_string('default')))) {
		var_schema = var_args.clone()
		if var_args.array_get(rt.new_string('show_in_rest')).is_array()
			&& var_args.array_get(rt.new_string('show_in_rest')).array_isset(rt.new_string('schema')) {
			var_schema = rt.call_function('array_merge', [var_schema.clone(),
				var_args.array_get(rt.new_string('show_in_rest')).array_get(rt.new_string('schema'))])
		}
		var_check = rt.call_function('rest_validate_value_from_schema', [
			var_args.array_get(rt.new_string('default')),
			var_schema.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_check.clone()])) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('__', [
					rt.new_string('When registering a default meta value the data must match the type provided.'),
				]),
				rt.new_string('5.5.0')])
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_filter', [
			rt.new_string('default_${var_object_type.to_string()}_metadata'),
			rt.new_string('filter_default_metadata'),
		])))))
		{
			rt.call_function('add_filter', [
				rt.new_string('default_${var_object_type.to_string()}_metadata'),
				rt.new_string('filter_default_metadata'),
				rt.new_int(10),
				rt.new_int(5),
			])
		}
	}
	if !var_has_old_auth_cb && !var_has_old_sanitize_cb {
		var_args.array_unset(rt.new_string('object_subtype'))
		var_wp_meta_keys.array_get_mut(var_object_type).array_get_mut(var_object_subtype).array_set(var_meta_key,
			var_args.clone())
		return true
	}
	return false
}

fn filter_default_metadata(var_value_arg rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_single rt.PhpVal, var_meta_type rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_wp_meta_keys := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_meta_data := rt.new_null()
	mut var_sub_type := rt.new_null()
	mut var_args := rt.new_null()
	mut var__meta_key := rt.new_null()
	mut var_metadata := rt.new_null()
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return var_value.clone()
	}
	if !(var_wp_meta_keys.clone().is_array()) || !(var_wp_meta_keys.array_isset(var_meta_type)) {
		return var_value.clone()
	}
	var_defaults = rt.new_array()
	mut iter_5 := var_wp_meta_keys.array_get(var_meta_type).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_meta_data_shadow := item_5.val
		mut var_sub_type_shadow := item_5.key
		mut iter_6 := var_meta_data_shadow.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_args_shadow := item_6.val
			mut var__meta_key_shadow := item_6.key
			if rt.is_true(rt.identical(var__meta_key_shadow, var_meta_key))
				&& rt.is_true(rt.new_bool(var_args_shadow.clone().array_isset(rt.new_string('default')))) {
				var_defaults.array_set(var_sub_type_shadow, var_args_shadow.clone())
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_defaults)))) {
		return var_value.clone()
	}
	if var_defaults.array_isset(rt.new_string('')) {
		var_metadata = var_defaults.array_get(rt.new_string(''))
	} else {
		var_sub_type = get_object_subtype(var_meta_type.clone(), var_object_id.clone())
		if !(var_defaults.array_isset(var_sub_type)) {
			return var_value.clone()
		}
		var_metadata = var_defaults.array_get(var_sub_type)
	}
	if rt.is_true(var_single) {
		var_value = var_metadata.array_get(rt.new_string('default'))
	} else {
		var_value = rt.create_array([
			rt.ArrayItem{ key: none, val: var_metadata.array_get(rt.new_string('default')) },
		])
	}
	return var_value.clone()
}

fn registered_meta_key_exists(var_object_type rt.PhpVal, var_meta_key rt.PhpVal, object_subtype string) rt.PhpVal {
	mut var_object_subtype := object_subtype
	mut var_meta_keys := rt.new_null()
	var_meta_keys = get_registered_meta_keys(var_object_type.clone(), object_subtype)
	return rt.new_bool(var_meta_keys.array_isset(var_meta_key))
}

fn unregister_meta_key(var_object_type rt.PhpVal, var_meta_key rt.PhpVal, object_subtype string) bool {
	mut var_object_subtype := object_subtype
	mut var_wp_meta_keys := rt.new_null()
	mut var_args := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(registered_meta_key_exists(var_object_type.clone(),
		var_meta_key.clone(), object_subtype)))))
	{
		return false
	}
	var_args =
		var_wp_meta_keys.array_get(var_object_type).array_get(rt.new_string(object_subtype)).array_get(var_meta_key)
	if var_args.array_isset(rt.new_string('sanitize_callback'))
		&& rt.call_function('is_callable', [var_args.array_get(rt.new_string('sanitize_callback'))]) {
		if !(object_subtype == '') {
			rt.call_function('remove_filter', [
				rt.new_string('sanitize_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype}'),
				var_args.array_get(rt.new_string('sanitize_callback')),
			])
		} else {
			rt.call_function('remove_filter', [
				rt.new_string('sanitize_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}'),
				var_args.array_get(rt.new_string('sanitize_callback')),
			])
		}
	}
	if var_args.array_isset(rt.new_string('auth_callback'))
		&& rt.call_function('is_callable', [var_args.array_get(rt.new_string('auth_callback'))]) {
		if !(object_subtype == '') {
			rt.call_function('remove_filter', [
				rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}_for_${var_object_subtype}'),
				var_args.array_get(rt.new_string('auth_callback')),
			])
		} else {
			rt.call_function('remove_filter', [
				rt.new_string('auth_${var_object_type.to_string()}_meta_${var_meta_key.to_string()}'),
				var_args.array_get(rt.new_string('auth_callback')),
			])
		}
	}
	var_wp_meta_keys.array_get(var_object_type).array_get(rt.new_string(object_subtype)).array_unset(var_meta_key)
	if !rt.is_true(var_wp_meta_keys.array_get(var_object_type).array_get(rt.new_string(object_subtype))) {
		var_wp_meta_keys.array_get(var_object_type).array_unset(rt.new_string(object_subtype))
	}
	if !rt.is_true(var_wp_meta_keys.array_get(var_object_type)) {
		var_wp_meta_keys.array_unset(var_object_type)
	}
	return true
}

fn get_registered_meta_keys(var_object_type rt.PhpVal, object_subtype string) rt.PhpVal {
	mut var_object_subtype := object_subtype
	mut var_wp_meta_keys := rt.new_null()
	if !(var_wp_meta_keys.clone().is_array()) || !(var_wp_meta_keys.array_isset(var_object_type))
		|| !(var_wp_meta_keys.array_get(var_object_type).array_isset(rt.new_string(object_subtype))) {
		return rt.new_array()
	}
	return var_wp_meta_keys.array_get(var_object_type).array_get(rt.new_string(object_subtype))
}

fn get_registered_metadata(var_object_type rt.PhpVal, var_object_id rt.PhpVal, meta_key string) rt.PhpVal {
	mut var_meta_key := meta_key
	mut var_object_subtype := rt.new_null()
	mut var_meta_keys := rt.new_null()
	mut var_meta_key_data := rt.new_null()
	mut var_data := rt.new_null()
	var_object_subtype = get_object_subtype(var_object_type.clone(), var_object_id.clone())
	if !(var_meta_key == '') {
		if !(!rt.is_true(var_object_subtype))
			&& rt.is_true(rt.new_bool(!(rt.is_true(registered_meta_key_exists(var_object_type.clone(), rt.new_string(var_meta_key.str()), var_object_subtype.clone()))))) {
			var_object_subtype = rt.new_string('')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(registered_meta_key_exists(var_object_type.clone(),
			rt.new_string(var_meta_key.str()), var_object_subtype.clone())))))
		{
			return rt.new_bool(false)
		}
		var_meta_keys = get_registered_meta_keys(var_object_type.clone(),
			var_object_subtype.clone())
		var_meta_key_data = var_meta_keys.array_get(rt.new_string(var_meta_key.str()))
		var_data = get_metadata(var_object_type.clone(), var_object_id.clone(), var_meta_key,
			var_meta_key_data.array_get(rt.new_string('single')))
		return var_data.clone()
	}
	var_data = get_metadata(var_object_type.clone(), var_object_id.clone(), '', false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
		return rt.new_array()
	}
	var_meta_keys = get_registered_meta_keys(var_object_type.clone(), '')
	if !(!rt.is_true(var_object_subtype)) {
		var_meta_keys = rt.call_function('array_merge', [var_meta_keys.clone(),
			get_registered_meta_keys(var_object_type.clone(), var_object_subtype.clone())])
	}
	return rt.call_function('array_intersect_key', [var_data.clone(),
		var_meta_keys.clone()])
}

fn _wp_register_meta_args_allowed_list(var_args rt.PhpVal, var_default_args rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_intersect_key', [var_args.clone(),
		var_default_args.clone()])
}

fn get_object_subtype(var_object_type rt.PhpVal, var_object_id_arg rt.PhpVal) rt.PhpVal {
	mut var_object_id := var_object_id_arg
	mut var_object_subtype := ''
	mut var_post_type := rt.new_null()
	mut var_term := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_user := rt.new_null()
	var_object_id = rt.new_int(var_object_id.to_i64())
	var_object_subtype = ''
	mut switch_val_1 := var_object_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
		var_post_type = rt.call_function('get_post_type', [var_object_id.clone()])
		if !(!rt.is_true(var_post_type)) {
			var_object_subtype = var_post_type.str()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('term'))) {
		var_term = rt.call_function('get_term', [var_object_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term')))))) {
		}
		var_object_subtype = (rt.get_property(var_term, 'taxonomy')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('comment'))) {
		var_comment = rt.call_function('get_comment', [var_object_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		}
		var_object_subtype = 'comment'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('user'))) {
		var_user = rt.call_function('get_user_by', [rt.new_string('id'),
			var_object_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		}
		var_object_subtype = 'user'
	}
	return rt.call_function('apply_filters', [
		rt.new_string('get_object_subtype_${var_object_type.to_string()}'),
		rt.new_string(var_object_subtype.str()).clone(),
		var_object_id.clone(),
	])
}

struct Class_WP_Metadata_Lazyloader {
	rt.PhpObjectBase
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

fn create_wp_metadata_lazyloader(_args ...rt.PhpVal) &Class_WP_Metadata_Lazyloader {
	mut obj := &Class_WP_Metadata_Lazyloader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_meta_query(_args ...rt.PhpVal) &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Metadata_Lazyloader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Metadata_Lazyloader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Metadata_Lazyloader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Meta_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Meta_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Meta_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-metadata-lazyloader.php',
		'3')
}
