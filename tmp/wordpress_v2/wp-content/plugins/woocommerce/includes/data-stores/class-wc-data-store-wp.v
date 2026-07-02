import rt

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
pub mut:
	meta_type                rt.PhpVal = rt.new_string('post')
	object_id_field_for_meta rt.PhpVal = rt.new_string('')
	internal_meta_keys       rt.PhpVal = rt.new_array()
	must_exist_meta_keys     rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Data_Store_WP) get_term_ids(var_object rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_object.clone().is_long() || var_object.clone().is_double())) {
		mut var_object_id := var_object
	} else {
		var_object_id = rt.call_method(var_object, 'get_id', []rt.PhpVal{})
	}
	mut var_terms := rt.call_function('get_the_terms', [var_object_id.clone(),
		var_taxonomy.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_terms))
		|| rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
		return rt.new_array()
	}
	return rt.call_function('wp_list_pluck', [var_terms.clone(),
		rt.new_string('term_id')])
}

fn (mut this Class_WC_Data_Store_WP) read_meta(var_object rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_db_info := this.get_db_info()
	mut var_raw_meta_data := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
				var_db_info.array_get(rt.new_string('meta_id_field'))),
				rt.new_string(' as meta_id, meta_key, meta_value\n\t\t\t\tFROM ')),
				var_db_info.array_get(rt.new_string('table'))), rt.new_string('\n\t\t\t\tWHERE ')),
				var_db_info.array_get(rt.new_string('object_id_field'))),
				rt.new_string(' = %d\n\t\t\t\tORDER BY ')),
				var_db_info.array_get(rt.new_string('meta_id_field'))),
			rt.call_method(var_object, 'get_id', []rt.PhpVal{}),
		]),
	])
	return this.filter_raw_meta_data(var_object.clone(), var_raw_meta_data.clone())
}

fn (mut this Class_WC_Data_Store_WP) filter_raw_meta_data(var_object rt.PhpVal, var_raw_meta_data rt.PhpVal) rt.PhpVal {
	mut var_raw_meta_data_mutated := var_raw_meta_data
	this.internal_meta_keys = rt.call_function('array_unique', [
		rt.call_function('array_merge', [
			rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Data_Store_WP', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'prefix_key' },
				]),
				rt.call_method(var_object, 'get_data_keys', []rt.PhpVal{}),
			]),
			this.internal_meta_keys,
		]),
	])
	mut var_meta_data := rt.call_function('array_filter', [var_raw_meta_data_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Data_Store_WP', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'exclude_internal_meta_keys' },
		])])
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_data_store_wp_'), this.meta_type),
			rt.new_string('_read_meta')),
		var_meta_data.clone(),
		var_object.clone(),
		rt.new_object('WC_Data_Store_WP', []string{}, &this),
	])
}

fn (mut this Class_WC_Data_Store_WP) delete_meta(var_object rt.PhpVal, var_meta rt.PhpVal) {
	rt.call_function('delete_metadata_by_mid', [this.meta_type, rt.get_property(var_meta, 'id')])
}

fn (mut this Class_WC_Data_Store_WP) add_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	return rt.call_function('add_metadata', [this.meta_type,
		rt.call_method(var_object, 'get_id', []rt.PhpVal{}),
		rt.call_function('wp_slash', [
			rt.get_property(var_meta, 'key'),
		]), if rt.get_property(var_meta, 'value').is_string() { rt.call_function('wp_slash', [
				rt.get_property(var_meta, 'value'),
			]) } else { rt.get_property(var_meta, 'value') }, rt.new_bool(false)])
}

fn (mut this Class_WC_Data_Store_WP) update_meta(var_object rt.PhpVal, var_meta rt.PhpVal) {
	rt.call_function('update_metadata_by_mid', [this.meta_type, rt.get_property(var_meta, 'id'),
		rt.get_property(var_meta, 'value'), rt.get_property(var_meta, 'key')])
}

fn (mut this Class_WC_Data_Store_WP) get_db_info() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_meta_id_field := rt.new_string('meta_id')
	mut var_table := rt.get_property(var_wpdb, 'prefix')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.meta_type,
		rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
			rt.ArrayItem{ key: none, val: 'user' }, rt.ArrayItem{ key: none, val: 'comment' },
			rt.ArrayItem{ key: none, val: 'term' }]),
		rt.new_bool(true)])))))
	{
		var_table = rt.concat(var_table, rt.new_string('woocommerce_'))
	}
	var_table = rt.concat(var_table, rt.new_string((this.meta_type).str() + 'meta'))
	mut var_object_id_field := rt.new_string((this.meta_type).str() + '_id')
	if rt.is_true(rt.identical(rt.new_string('user'), this.meta_type)) {
		var_meta_id_field = rt.new_string('umeta_id')
		var_table = rt.get_property(var_wpdb, 'usermeta')
	}
	if !(!rt.is_true(this.object_id_field_for_meta)) {
		var_object_id_field = this.object_id_field_for_meta
	}
	return rt.create_array([rt.ArrayItem{ key: 'table', val: var_table },
		rt.ArrayItem{ key: 'object_id_field', val: var_object_id_field },
		rt.ArrayItem{ key: 'meta_id_field', val: var_meta_id_field }])
}

fn (mut this Class_WC_Data_Store_WP) prefix_key(var_key rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.identical(rt.new_string('_'), rt.call_function('substr', [
		var_key.clone(),
		rt.new_int(0),
		rt.new_int(1),
	])))
	{ var_key } else { '_' + var_key.str() }
}

fn (mut this Class_WC_Data_Store_WP) exclude_internal_meta_keys(var_meta rt.PhpVal) bool {
	return
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'meta_key'), this.internal_meta_keys, rt.new_bool(true)])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [rt.get_property(var_meta, 'meta_key'), rt.new_string('wp_')])))))
}

fn (mut this Class_WC_Data_Store_WP) get_props_to_update(var_object rt.PhpVal, var_meta_key_to_props rt.PhpVal, meta_type string) rt.PhpVal {
	mut var_props_to_update := rt.new_array()
	mut var_changed_props := rt.call_method(var_object, 'get_changes', []rt.PhpVal{})
	mut iter_1 := var_meta_key_to_props.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prop := item_1.val
		mut var_meta_key := item_1.key
		if rt.is_true(rt.new_bool(var_changed_props.clone().array_isset(var_prop.clone())))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('metadata_exists', [rt.new_string(meta_type), rt.call_method(var_object, 'get_id', []rt.PhpVal{}), var_meta_key.clone()]))))) {
			var_props_to_update.array_set(var_meta_key, var_prop.clone())
		}
	}
	return var_props_to_update.clone()
}

fn (mut this Class_WC_Data_Store_WP) update_or_delete_post_meta(var_object rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_meta_value.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: rt.new_array()
	}, rt.ArrayItem{ key: none, val: '' }]), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_meta_key.clone(), this.must_exist_meta_keys, rt.new_bool(true)]))))) {
		mut var_updated := rt.call_function('delete_post_meta', [
			rt.call_method(var_object, 'get_id', []rt.PhpVal{}),
			var_meta_key.clone(),
		])
	} else {
		var_updated = rt.call_function('update_post_meta', [
			rt.call_method(var_object, 'get_id', []rt.PhpVal{}),
			var_meta_key.clone(),
			var_meta_value.clone(),
		])
	}
	return var_updated.to_bool()
}

fn (mut this Class_WC_Data_Store_WP) get_wp_query_args(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_skipped_values := [rt.new_string(''), rt.new_array(),
		rt.new_null()]
	mut var_wp_query_args := rt.create_array([
		rt.ArrayItem{ key: 'errors', val: rt.new_array() },
		rt.ArrayItem{ key: 'meta_query', val: rt.new_array() },
	])
	mut iter_2 := var_query_vars.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.call_function('in_array', [var_value.clone(), rt.create_array_from_list(var_skipped_values), rt.new_bool(true)]))
			|| rt.is_true(rt.identical(rt.new_string('meta_query'), var_key)) {
			continue
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('_' + var_key.str()),
			this.internal_meta_keys, rt.new_bool(true)]))
		{
			if rt.is_true(rt.identical(rt.new_string('*'), var_value)) {
				var_wp_query_args.array_get_mut('meta_query').array_push(rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'key', val: '_' + var_key.str() },
						rt.ArrayItem{ key: 'compare', val: 'EXISTS' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'key', val: '_' + var_key.str() },
						rt.ArrayItem{ key: 'value', val: '' },
						rt.ArrayItem{ key: 'compare', val: '!=' },
					]) },
				]))
			} else {
				var_wp_query_args.array_get_mut('meta_query').array_push(rt.create_array([
					rt.ArrayItem{ key: 'key', val: '_' + var_key.str() },
					rt.ArrayItem{ key: 'value', val: var_value },
					rt.ArrayItem{
						key: 'compare'
						val: if var_value.clone().is_array() { 'IN' } else { '=' }
					},
				]))
			}
		} else {
			mut var_key_mapping := rt.create_array([
				rt.ArrayItem{ key: 'parent', val: 'post_parent' },
				rt.ArrayItem{ key: 'parent_exclude', val: 'post_parent__not_in' },
				rt.ArrayItem{ key: 'exclude', val: 'post__not_in' },
				rt.ArrayItem{ key: 'limit', val: 'posts_per_page' },
				rt.ArrayItem{ key: 'type', val: 'post_type' },
				rt.ArrayItem{ key: 'return', val: 'fields' },
			])
			if var_key_mapping.array_isset(var_key) {
				var_wp_query_args.array_set(var_key_mapping.array_get(var_key), var_value.clone())
			} else {
				var_wp_query_args.array_set(var_key, var_value.clone())
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_wp_query_args'),
		var_wp_query_args.clone(),
		var_query_vars.clone(),
	])
}

fn (mut this Class_WC_Data_Store_WP) parse_date_for_wp_query(var_query_var rt.PhpVal, var_key rt.PhpVal, var_wp_query_args rt.PhpVal) rt.PhpVal {
	mut var_sections := rt.new_null()
	mut var_wp_query_args_mutated := var_wp_query_args
	mut var_query_parse_regex := rt.new_string('/([^.<>]*)(>=|<=|>|<|\\.\\.\\.)([^.<>]+)/')
	mut var_valid_operators := ['>', '>=', '=', '<=', '<', '...']
	mut var_precision := rt.new_string('second')
	mut var_dates := rt.new_array()
	mut var_operator := rt.new_string('=')
	if rt.is_true(rt.call_function('is_a', [var_query_var.clone(),
		rt.new_string('WC_DateTime')]))
	{
		var_dates.array_push(var_query_var.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else if rt.is_true(rt.new_bool(var_query_var.clone().is_long()
		|| var_query_var.clone().is_double()))
	{
		var_dates.array_push(create_wc_datetime(rt.new_string('@${var_query_var.to_string()}'),
			create_datetimezone(rt.new_string('UTC'))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else if rt.is_true(rt.call_function('preg_match', [var_query_parse_regex.clone(),
		var_query_var.clone(), var_sections.clone()]))
	{
		if !(!rt.is_true(var_sections.array_get(rt.new_int(1)))) {
			var_dates.array_push(if var_sections.array_get(rt.new_int(1)).is_long() || var_sections.array_get(rt.new_int(1)).is_double() { create_wc_datetime(rt.concat(rt.new_string('@'), var_sections.array_get(rt.new_int(1))), create_datetimezone(rt.new_string('UTC'))) } else { rt.call_function('wc_string_to_datetime', [
					var_sections.array_get(rt.new_int(1)),
				]) })
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_operator = if rt.is_true(rt.call_function('in_array', [
			var_sections.array_get(rt.new_int(2)),
			rt.create_array_from_list(var_valid_operators),
			rt.new_bool(true),
		]))
		{ var_sections.array_get(rt.new_int(2)) } else { rt.new_string('') }
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_dates.array_push(if var_sections.array_get(rt.new_int(3)).is_long() || var_sections.array_get(rt.new_int(3)).is_double() { create_wc_datetime(rt.concat(rt.new_string('@'), var_sections.array_get(rt.new_int(3))), create_datetimezone(rt.new_string('UTC'))) } else { rt.call_function('wc_string_to_datetime', [
				var_sections.array_get(rt.new_int(3)),
			]) })
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if !(var_sections.array_get(rt.new_int(1)).is_long()
			|| var_sections.array_get(rt.new_int(1)).is_double())
			&& !(var_sections.array_get(rt.new_int(3)).is_long()
			|| var_sections.array_get(rt.new_int(3)).is_double()) {
			var_precision = rt.new_string('day')
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else {
		var_dates.array_push(rt.call_function('wc_string_to_datetime', [
			var_query_var.clone()]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_precision = rt.new_string('day')
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return var_wp_query_args_mutated.clone()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	if rt.is_true(rt.new_bool(!(rt.is_true(var_operator)))) || !rt.is_true(var_dates)
		|| (rt.is_true(rt.identical(rt.new_string('...'), var_operator))
		&& var_dates.clone().array_count() < 2) {
		return var_wp_query_args_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('post_date'), var_key))
		|| rt.is_true(rt.identical(rt.new_string('post_modified'), var_key)) {
		if !(var_wp_query_args_mutated.array_isset(rt.new_string('date_query'))) {
			var_wp_query_args_mutated.array_set('date_query', rt.new_array())
		}
		mut var_query_arg := rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(rt.identical(rt.new_string('day'), var_precision)) {
					var_key
				} else {
					var_key.str() + '_gmt'
				}
			},
			rt.ArrayItem{
				key: 'inclusive'
				val:
					rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('>'), var_operator))))
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('<'), var_operator))))
			},
		])
		mut var_comparisons := rt.new_array()
		if rt.is_true(rt.identical(rt.new_string('>'), var_operator))
			|| rt.is_true(rt.identical(rt.new_string('>='), var_operator))
			|| rt.is_true(rt.identical(rt.new_string('...'), var_operator)) {
			var_comparisons << 'after'
		}
		if rt.is_true(rt.identical(rt.new_string('<'), var_operator))
			|| rt.is_true(rt.identical(rt.new_string('<='), var_operator))
			|| rt.is_true(rt.identical(rt.new_string('...'), var_operator)) {
			var_comparisons << 'before'
		}
		for var_index, var_comparison in var_comparisons {
			if rt.is_true(rt.identical(rt.new_string('day'), var_precision)) {
				var_query_arg.array_get_mut(comparison).array_set('year', rt.call_method(var_dates.array_get(rt.new_int(index)),
					'date', [rt.new_string('Y')]))
				var_query_arg.array_get_mut(comparison).array_set('month', rt.call_method(var_dates.array_get(rt.new_int(index)),
					'date', [rt.new_string('n')]))
				var_query_arg.array_get_mut(comparison).array_set('day', rt.call_method(var_dates.array_get(rt.new_int(index)),
					'date', [rt.new_string('j')]))
			} else {
				var_query_arg.array_set(comparison, rt.call_function('gmdate', [
					rt.new_string('m/d/Y H:i:s'),
					rt.call_method(var_dates.array_get(rt.new_int(index)), 'getTimestamp',
						[]rt.PhpVal{}),
				]))
			}
		}
		if !rt.is_true(var_comparisons) {
			var_query_arg.array_set('year', rt.call_method(var_dates.array_get(rt.new_int(0)),
				'date', [rt.new_string('Y')]))
			var_query_arg.array_set('month', rt.call_method(var_dates.array_get(rt.new_int(0)),
				'date', [rt.new_string('n')]))
			var_query_arg.array_set('day', rt.call_method(var_dates.array_get(rt.new_int(0)),
				'date', [rt.new_string('j')]))
			if rt.is_true(rt.identical(rt.new_string('second'), var_precision)) {
				var_query_arg.array_set('hour', rt.call_method(var_dates.array_get(rt.new_int(0)),
					'date', [rt.new_string('H')]))
				var_query_arg.array_set('minute', rt.call_method(var_dates.array_get(rt.new_int(0)),
					'date', [rt.new_string('i')]))
				var_query_arg.array_set('second', rt.call_method(var_dates.array_get(rt.new_int(0)),
					'date', [rt.new_string('s')]))
			}
		}
		var_wp_query_args_mutated.array_get_mut('date_query').array_push(var_query_arg.clone())
		return var_wp_query_args_mutated.clone()
	}
	if !(var_wp_query_args_mutated.array_isset(rt.new_string('meta_query'))) {
		var_wp_query_args_mutated.array_set('meta_query', rt.new_array())
	}
	if rt.is_true(rt.identical(rt.new_string('day'), var_precision)) {
		mut var_start_timestamp := rt.call_function('strtotime', [
			rt.call_function('gmdate', [rt.new_string('m/d/Y 00:00:00'),
				rt.call_method(var_dates.array_get(rt.new_int(0)), 'getTimestamp', []rt.PhpVal{})]),
		])
		mut var_end_timestamp := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('...'), var_operator)))) { rt.add(var_start_timestamp, rt.get_constant('DAY_IN_SECONDS')) } else { rt.call_function('strtotime', [
				rt.call_function('gmdate', [rt.new_string('m/d/Y 00:00:00'),
					rt.call_method(var_dates.array_get(rt.new_int(1)), 'getTimestamp', []rt.PhpVal{})]),
			]) }
		mut switch_val_1 := var_operator
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('>')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('<='))) {
			var_wp_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: var_key },
				rt.ArrayItem{ key: 'value', val: var_end_timestamp },
				rt.ArrayItem{ key: 'compare', val: var_operator },
			]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('>='))) {
			var_wp_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: var_key },
				rt.ArrayItem{ key: 'value', val: var_start_timestamp },
				rt.ArrayItem{ key: 'compare', val: var_operator },
			]))
		} else {
			var_wp_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: var_key },
				rt.ArrayItem{ key: 'value', val: var_start_timestamp },
				rt.ArrayItem{ key: 'compare', val: '>=' },
			]))
			var_wp_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: var_key },
				rt.ArrayItem{ key: 'value', val: var_end_timestamp },
				rt.ArrayItem{ key: 'compare', val: '<=' },
			]))
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('...'), var_operator)))) {
		var_wp_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: var_key },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_dates.array_get(rt.new_int(0)),
				'getTimestamp', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'compare', val: var_operator },
		]))
	} else {
		var_wp_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: var_key },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_dates.array_get(rt.new_int(0)),
				'getTimestamp', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'compare', val: '>=' },
		]))
		var_wp_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: var_key },
			rt.ArrayItem{ key: 'value', val: rt.call_method(var_dates.array_get(rt.new_int(1)),
				'getTimestamp', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'compare', val: '<=' },
		]))
	}
	return var_wp_query_args_mutated.clone()
}

fn (mut this Class_WC_Data_Store_WP) get_internal_meta_keys() rt.PhpVal {
	return this.internal_meta_keys
}

fn (mut this Class_WC_Data_Store_WP) get_valid_search_terms(var_terms rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_valid_terms := rt.new_array()
	mut var_stopwords := this.get_search_stopwords()
	mut iter_3 := var_terms_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_term := item_3.val
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^".+"$/'),
			var_term.clone()]))
		{
			var_term = rt.new_string(var_term.clone().to_string().trim_space())
		} else {
			var_term = rt.new_string(var_term.clone().to_string().trim_space())
		}
		if !rt.is_true(var_term) || (1 == var_term.clone().to_string().len
			&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z\\-]$/i'), var_term.clone()]))) {
			continue
		}
		if rt.is_true(rt.call_function('in_array', [
			rt.call_function('wc_strtolower', [var_term.clone()]),
			var_stopwords.clone(),
			rt.new_bool(true),
		]))
		{
			continue
		}
		var_valid_terms << var_term.clone()
	}
	return var_valid_terms.clone()
}

fn (mut this Class_WC_Data_Store_WP) get_search_stopwords() rt.PhpVal {
	mut var_stopwords := rt.call_function('array_map', [rt.new_string('wc_strtolower'),
		rt.call_function('array_map', [rt.new_string('trim'),
			rt.call_function('explode', [rt.new_string(','),
				rt.call_function('_x', [
					rt.new_string('about,an,are,as,at,be,by,com,for,from,how,in,is,it,of,on,or,that,the,this,to,was,what,when,where,who,will,with,www'),
					rt.new_string('Comma-separated list of search stopwords in your language'),
					rt.new_string('woocommerce'),
				])])])])
	return rt.call_function('apply_filters', [rt.new_string('wp_search_stopwords'),
		var_stopwords.clone()])
}

fn (mut this Class_WC_Data_Store_WP) get_data_for_lookup_table(var_id rt.PhpVal, var_table rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_table_mutated := var_table
	return rt.new_array()
}

fn (mut this Class_WC_Data_Store_WP) get_primary_key_for_lookup_table(var_table rt.PhpVal) string {
	mut var_table_mutated := var_table
	return ''
}

fn (mut this Class_WC_Data_Store_WP) update_lookup_table(var_id rt.PhpVal, var_table rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	mut var_table_mutated := var_table
	var_id_mutated = rt.call_function('absint', [var_id_mutated.clone()])
	var_table_mutated = rt.call_function('sanitize_key', [var_table_mutated.clone()])
	if !rt.is_true(var_id_mutated) || !rt.is_true(var_table_mutated) {
		return false
	}
	mut var_existing_data := rt.call_function('wp_cache_get', [
		rt.new_string('lookup_table'),
		rt.new_string('object_' + var_id_mutated.str()),
	])
	mut var_update_data := this.get_data_for_lookup_table(var_id_mutated.clone(),
		var_table_mutated.clone())
	if !(!rt.is_true(var_update_data))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_update_data, var_existing_data)))) {
		rt.call_method(var_wpdb, 'replace', [
			rt.get_property(var_wpdb, '{"nodeType":"Expr_Variable","line":618,"name":"table"}'),
			var_update_data.clone(),
		])
		rt.call_function('wp_cache_set', [rt.new_string('lookup_table'),
			var_update_data.clone(), rt.new_string('object_' + var_id_mutated.str())])
	}
	return false
}

fn (mut this Class_WC_Data_Store_WP) delete_from_lookup_table(var_id rt.PhpVal, var_table rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	mut var_table_mutated := var_table
	var_id_mutated = rt.call_function('absint', [var_id_mutated.clone()])
	var_table_mutated = rt.call_function('sanitize_key', [var_table_mutated.clone()])
	if !rt.is_true(var_id_mutated) || !rt.is_true(var_table_mutated) {
		return false
	}
	mut var_pk := rt.new_string(this.get_primary_key_for_lookup_table(var_table_mutated.clone()))
	rt.call_method(var_wpdb, 'delete', [
		rt.get_property(var_wpdb, '{"nodeType":"Expr_Variable","line":645,"name":"table"}'),
		rt.create_array([rt.ArrayItem{ key: var_pk, val: var_id_mutated }]),
	])
	rt.call_function('wp_cache_delete', [rt.new_string('lookup_table'),
		rt.new_string('object_' + var_id_mutated.str())])
	return false
}

fn (mut this Class_WC_Data_Store_WP) string_to_timestamp(var_time_string rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_time_string)))) { rt.call_function('wc_string_to_timestamp', [
			var_time_string.clone(),
		]) } else { rt.new_null() }
}

struct Class_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase:            rt.PhpObjectBase{}
		meta_type:                rt.new_string('post')
		object_id_field_for_meta: rt.new_string('')
		internal_meta_keys:       rt.new_array()
		must_exist_meta_keys:     rt.new_array()
	}
	return obj
}

fn create_wc_datetime(_args ...rt.PhpVal) &Class_WC_DateTime {
	mut obj := &Class_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_term_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_term_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'read_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read_meta(dispatch_arg_0)
		}
		'filter_raw_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_raw_meta_data(dispatch_arg_0, dispatch_arg_1)
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
			return this.add_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_db_info' {
			return this.get_db_info()
		}
		'prefix_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prefix_key(dispatch_arg_0)
		}
		'exclude_internal_meta_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.exclude_internal_meta_keys(dispatch_arg_0))
		}
		'get_props_to_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_props_to_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_or_delete_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.update_or_delete_post_meta(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'get_wp_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_wp_query_args(dispatch_arg_0)
		}
		'parse_date_for_wp_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.parse_date_for_wp_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_internal_meta_keys' {
			return this.get_internal_meta_keys()
		}
		'get_valid_search_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_valid_search_terms(dispatch_arg_0)
		}
		'get_search_stopwords' {
			return this.get_search_stopwords()
		}
		'get_data_for_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_data_for_lookup_table(dispatch_arg_0, dispatch_arg_1)
		}
		'get_primary_key_for_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_primary_key_for_lookup_table(dispatch_arg_0))
		}
		'update_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_lookup_table(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_from_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.delete_from_lookup_table(dispatch_arg_0, dispatch_arg_1))
		}
		'string_to_timestamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.string_to_timestamp(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_type' { return this.meta_type }
		'object_id_field_for_meta' { return this.object_id_field_for_meta }
		'internal_meta_keys' { return this.internal_meta_keys }
		'must_exist_meta_keys' { return this.must_exist_meta_keys }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_type' {
			this.meta_type = val
			return true
		}
		'object_id_field_for_meta' {
			this.object_id_field_for_meta = val
			return true
		}
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		'must_exist_meta_keys' {
			this.must_exist_meta_keys = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
