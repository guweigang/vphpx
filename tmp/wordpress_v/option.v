module wp_includes

import rt

fn get_option(var_option_arg rt.PhpVal, default_value bool) bool {
	mut var_default_value := default_value
	mut var_option := var_option_arg
	mut var_wpdb := rt.new_null()
	mut var_deprecated_keys := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_passed_default := false
	mut var_alloptions := rt.new_null()
	mut var_value := rt.new_null()
	mut var_notoptions := rt.new_null()
	mut var_row := rt.new_null()
	mut var_suppress := rt.new_null()
	if rt.is_true(rt.call_function('is_scalar', [rt.new_string(var_option.str()).clone()])) {
		var_option = var_option.trim_space()
	}
	if var_option == '' {
		return false
	}
	var_deprecated_keys = rt.create_array([
		rt.ArrayItem{ key: 'blacklist_keys', val: 'disallowed_keys' },
		rt.ArrayItem{ key: 'comment_whitelist', val: 'comment_previously_approved' },
	])
	if rt.is_true(rt.new_bool(var_deprecated_keys.array_isset(rt.new_string(var_option.str()))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})))))))
	{
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('5.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%1$s" option key has been renamed to "%2$s".'),
				]),
				rt.new_string(var_option.str()).clone(),
				var_deprecated_keys.array_get(var_option),
			])])
		return get_option(var_deprecated_keys.array_get(var_option), default_value)
	}
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_option_${var_option}'),
		rt.new_bool(false),
		rt.new_string(var_option.str()).clone(),
		rt.new_bool(default_value),
	])
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_option'),
		var_pre.clone(), rt.new_string(var_option.str()).clone(),
		rt.new_bool(default_value)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
		return var_pre.to_bool()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SETUP_CONFIG')])) {
		return false
	}
	var_passed_default = (rt.greater(rt.call_function('func_num_args', []rt.PhpVal{}),
		rt.new_int(1))).to_bool()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		var_alloptions = wp_load_alloptions(false)
		if var_alloptions.array_isset(rt.new_string(var_option.str())) {
			var_value = var_alloptions.array_get(var_option)
		} else {
			var_notoptions = rt.call_function('wp_cache_get', [
				rt.new_string('notoptions'),
				rt.new_string('options'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))))) {
				var_notoptions = rt.new_array()
				rt.call_function('wp_cache_set', [rt.new_string('notoptions'),
					var_notoptions.clone(), rt.new_string('options')])
			}
			if var_notoptions.array_isset(rt.new_string(var_option.str())) {
				return (rt.call_function('apply_filters', [
					rt.new_string('default_option_${var_option}'),
					rt.new_bool(default_value),
					rt.new_string(var_option.str()).clone(),
					rt.new_bool(var_passed_default).clone(),
				])).to_bool()
			}
			var_value = rt.call_function('wp_cache_get', [rt.new_string(var_option.str()).clone(),
				rt.new_string('options')])
			if rt.is_true(rt.identical(rt.new_bool(false), var_value)) {
				var_row = rt.call_method(var_wpdb, 'get_row', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT option_value FROM '), rt.get_property(var_wpdb,
							'options')), rt.new_string(' WHERE option_name = %s LIMIT 1')),
						rt.new_string(var_option.str()).clone(),
					]),
				])
				if rt.is_true(rt.new_bool(var_row.clone().is_object())) {
					var_value = rt.get_property(var_row, 'option_value')
					rt.call_function('wp_cache_add', [rt.new_string(var_option.str()).clone(),
						var_value.clone(), rt.new_string('options')])
				} else {
					var_notoptions.array_set(var_option, true)
					rt.call_function('wp_cache_set', [rt.new_string('notoptions'),
						var_notoptions.clone(), rt.new_string('options')])
					return (rt.call_function('apply_filters', [
						rt.new_string('default_option_${var_option}'),
						rt.new_bool(default_value),
						rt.new_string(var_option.str()).clone(),
						rt.new_bool(var_passed_default).clone(),
					])).to_bool()
				}
			}
		}
	} else {
		var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
		var_row = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT option_value FROM '), rt.get_property(var_wpdb,
					'options')), rt.new_string(' WHERE option_name = %s LIMIT 1')),
				rt.new_string(var_option.str()).clone(),
			]),
		])
		rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
		if rt.is_true(rt.new_bool(var_row.clone().is_object())) {
			var_value = rt.get_property(var_row, 'option_value')
		} else {
			return (rt.call_function('apply_filters', [
				rt.new_string('default_option_${var_option}'),
				rt.new_bool(default_value),
				rt.new_string(var_option.str()).clone(),
				rt.new_bool(var_passed_default).clone(),
			])).to_bool()
		}
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('home'), rt.new_string(var_option.str())))
		&& rt.is_true(rt.identical(rt.new_string(''), var_value))))
	{
		return get_option('siteurl')
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(var_option.str()).clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'siteurl' },
			rt.ArrayItem{ key: none, val: 'home' }, rt.ArrayItem{ key: none, val: 'category_base' },
			rt.ArrayItem{ key: none, val: 'tag_base' }]),
		rt.new_bool(true)]))
	{
		var_value = rt.call_function('untrailingslashit', [var_value.clone()])
	}
	return (rt.call_function('apply_filters', [rt.new_string('option_${var_option}'),
		rt.call_function('maybe_unserialize', [var_value.clone()]),
		rt.new_string(var_option.str()).clone()])).to_bool()
}

fn wp_prime_option_caches(var_options rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_alloptions := rt.new_null()
	mut var_cached_options := rt.new_null()
	mut var_notoptions := rt.new_null()
	mut var_options_to_prime := []rt.PhpVal{}
	mut var_option := rt.new_null()
	mut var_results := rt.new_null()
	mut var_options_found := rt.new_null()
	mut var_result := rt.new_null()
	mut var_options_not_found := rt.new_null()
	mut var_update_notoptions := false
	mut var_option_name := rt.new_null()
	var_alloptions = wp_load_alloptions(false)
	var_cached_options = rt.call_function('wp_cache_get_multiple', [
		var_options.clone(), rt.new_string('options')])
	var_notoptions = rt.call_function('wp_cache_get', [rt.new_string('notoptions'),
		rt.new_string('options')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))))) {
		var_notoptions = rt.new_array()
	}
	var_options_to_prime = rt.new_array()
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option_shadow := item_1.val
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_cached_options.array_isset(var_option_shadow))
				|| rt.is_true(rt.identical(rt.new_bool(false), var_cached_options.array_get(var_option_shadow)))))
				&& !(var_alloptions.array_isset(var_option_shadow))))
				&& !(var_notoptions.array_isset(var_option_shadow))))
			{
				var_options_to_prime << var_option_shadow.clone()
			}
		}
	}
	if !rt.is_true(var_options_to_prime) {
		return
	}
	var_results = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.call_function('sprintf', [
				rt.concat(rt.concat(rt.new_string('SELECT option_name, option_value FROM '), rt.get_property(var_wpdb,
					'options')), rt.new_string(' WHERE option_name IN (%s)')),
				rt.call_function('implode', [rt.new_string(','),
					rt.call_function('array_fill', [rt.new_int(0),
						rt.new_int(var_options_to_prime.len),
						rt.new_string('%s')])]),
			]),
			rt.create_array_from_list(var_options_to_prime),
		]),
	])
	var_options_found = rt.new_array()
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result_shadow := item_1.val
			var_options_found.array_set(rt.get_property(var_result_shadow, 'option_name'), rt.get_property(var_result_shadow,
				'option_value'))
		}
	}
	rt.call_function('wp_cache_set_multiple', [var_options_found.clone(),
		rt.new_string('options')])
	if var_options_found.clone().array_count() == var_options_to_prime.len {
		return
	}
	var_options_not_found = rt.call_function('array_diff', [
		rt.create_array_from_list(var_options_to_prime),
		rt.func_array_keys(var_options_found.clone()),
	])
	var_update_notoptions = false
	{
		mut iter_1 := var_options_not_found.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option_name_shadow := item_1.val
			if !(var_notoptions.array_isset(var_option_name_shadow)) {
				var_notoptions.array_set(var_option_name_shadow, true)
				var_update_notoptions = true
			}
		}
	}
	if var_update_notoptions {
		rt.call_function('wp_cache_set', [rt.new_string('notoptions'),
			var_notoptions.clone(), rt.new_string('options')])
	}
}

fn wp_prime_option_caches_by_group(var_option_group rt.PhpVal) {
	mut var_new_allowed_options := rt.new_null()
	if var_new_allowed_options.array_isset(var_option_group) {
		wp_prime_option_caches(var_new_allowed_options.array_get(var_option_group))
	}
}

fn get_options(var_options rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_null()
	mut var_option := rt.new_null()
	wp_prime_option_caches(var_options.clone())
	var_result = rt.new_array()
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option_shadow := item_1.val
			var_result.array_set(var_option_shadow, get_option(var_option_shadow.clone()))
		}
	}
	return var_result.clone()
}

fn wp_set_option_autoload_values(var_options_arg rt.PhpVal) rt.PhpVal {
	mut var_options := var_options_arg
	mut var_wpdb := rt.new_null()
	mut var_grouped_options := rt.new_null()
	mut var_results := rt.new_null()
	mut var_autoload := rt.new_null()
	mut var_option := rt.new_null()
	mut var_where := rt.new_null()
	mut var_where_args := []rt.PhpVal{}
	mut var_placeholders := rt.new_null()
	mut var_options_to_update := rt.new_null()
	mut var_success := rt.new_null()
	mut var_alloptions := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options)))) {
		return rt.new_array()
	}
	var_grouped_options = rt.create_array([
		rt.ArrayItem{ key: 'on', val: rt.new_array() },
		rt.ArrayItem{ key: 'off', val: rt.new_array() },
	])
	var_results = rt.new_array()
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_autoload_shadow := item_1.val
			mut var_option_shadow := item_1.key
			wp_protect_special_option(var_option_shadow.clone())
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('off'), var_autoload_shadow))
				|| rt.is_true(rt.identical(rt.new_string('no'), var_autoload_shadow))))
				|| rt.is_true(rt.identical(rt.new_bool(false), var_autoload_shadow))))
			{
				var_grouped_options.array_get_mut('off').array_push(var_option_shadow.clone())
			} else {
				var_grouped_options.array_get_mut('on').array_push(var_option_shadow.clone())
			}
			var_results.array_set(var_option_shadow, false)
		}
	}
	var_where = rt.new_array()
	var_where_args = rt.new_array()
	{
		mut iter_1 := var_grouped_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_options_shadow := item_1.val
			mut var_autoload_shadow := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_options_shadow)))) {
				continue
			}
			var_placeholders = rt.call_function('implode', [rt.new_string(','),
				rt.call_function('array_fill', [rt.new_int(0),
					rt.new_int(var_options_shadow.clone().array_count()),
					rt.new_string('%s')])])
			var_where.array_push("autoload != '%s' AND option_name IN (${var_placeholders.to_string()})")
			var_where_args << var_autoload_shadow.clone()
			{
				mut iter_2 := var_options_shadow.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_option_shadow := item_2.val
					var_where_args << var_option_shadow.clone()
				}
			}
		}
	}
	var_where = rt.new_string('WHERE ' +
		(rt.call_function('implode', [rt.new_string(' OR '), var_where.clone()])).str())
	var_options_to_update = rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.new_string('SELECT option_name FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' ')), var_where),
			rt.create_array_from_list(var_where_args),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options_to_update)))) {
		return var_results.clone()
	}
	{
		mut iter_1 := var_grouped_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_options_shadow := item_1.val
			mut var_autoload_shadow := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_options_shadow)))) {
				continue
			}
			var_options_shadow = rt.call_function('array_intersect', [
				var_options_shadow.clone(), var_options_to_update.clone()])
			var_grouped_options.array_set(var_autoload_shadow, var_options_shadow.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_grouped_options.array_get(var_autoload_shadow))))) {
				continue
			}
			var_success = rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.new_string((
						rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'options')), rt.new_string(' SET autoload = %s WHERE option_name IN (')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_grouped_options.array_get(var_autoload_shadow).array_count()), rt.new_string('%s')])])).str() +
						')').str()),
					rt.call_function('array_merge', [
						rt.create_array([
							rt.ArrayItem{ key: none, val: var_autoload_shadow },
						]),
						var_grouped_options.array_get(var_autoload_shadow),
					]),
				]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
				var_grouped_options.array_set(var_autoload_shadow, rt.new_array())
				continue
			}
			{
				mut iter_2 := var_grouped_options.array_get(var_autoload_shadow).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_option_shadow := item_2.val
					var_results.array_set(var_option_shadow, true)
				}
			}
		}
	}
	if rt.is_true(var_grouped_options.array_get('on')) {
		rt.call_function('wp_cache_delete_multiple', [var_grouped_options.array_get('on'),
			rt.new_string('options')])
		rt.call_function('wp_cache_delete', [rt.new_string('alloptions'),
			rt.new_string('options')])
	} else if rt.is_true(var_grouped_options.array_get('off')) {
		var_alloptions = wp_load_alloptions(true)
		{
			mut iter_1 := var_grouped_options.array_get('off').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_option_shadow := item_1.val
				if var_alloptions.array_isset(var_option_shadow) {
					var_alloptions.array_unset(var_option_shadow)
				}
			}
		}
		rt.call_function('wp_cache_set', [rt.new_string('alloptions'),
			var_alloptions.clone(), rt.new_string('options')])
	}
	return var_results.clone()
}

fn wp_set_options_autoload(var_options rt.PhpVal, var_autoload rt.PhpVal) rt.PhpVal {
	return wp_set_option_autoload_values(rt.call_function('array_fill_keys', [
		var_options.clone(), var_autoload.clone()]))
}

fn wp_set_option_autoload(var_option rt.PhpVal, var_autoload rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_null()
	var_result = wp_set_option_autoload_values(rt.create_array([
		rt.ArrayItem{ key: var_option, val: var_autoload },
	]))
	return if !(var_result.array_get(var_option)).is_null() {
		var_result.array_get(var_option)
	} else {
		rt.new_bool(false)
	}
}

fn wp_protect_special_option(var_option rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('alloptions'), var_option))
		|| rt.is_true(rt.identical(rt.new_string('notoptions'), var_option))))
	{
		rt.call_function('wp_die', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%s is a protected WP option and may not be modified'),
				]),
				rt.call_function('esc_html', [
					var_option.clone(),
				]),
			]),
		])
	}
}

fn form_option(var_option rt.PhpVal) {
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_bool(get_option(var_option.clone(), false)),
	]))
}

fn wp_load_alloptions(force_cache bool) rt.PhpVal {
	mut var_force_cache := force_cache
	mut var_wpdb := rt.new_null()
	mut var_alloptions := rt.new_null()
	mut var_suppress := rt.new_null()
	mut var_alloptions_db := rt.new_null()
	mut var_o := rt.new_null()
	var_alloptions = rt.call_function('apply_filters', [
		rt.new_string('pre_wp_load_alloptions'),
		rt.new_null(),
		rt.new_bool(force_cache),
	])
	if rt.is_true(rt.new_bool(var_alloptions.clone().is_array())) {
		return var_alloptions.clone()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))))
	{
		var_alloptions = rt.call_function('wp_cache_get', [rt.new_string('alloptions'),
			rt.new_string('options'), rt.new_bool(force_cache)])
	} else {
		var_alloptions = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_alloptions)))) {
		var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
		var_alloptions_db = rt.call_method(var_wpdb, 'get_results', [
			rt.new_string((
				rt.concat(rt.concat(rt.new_string('SELECT option_name, option_value FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(" WHERE autoload IN ( '")) +
				(rt.call_function('implode', [rt.new_string("', '"), rt.call_function('esc_sql', [wp_autoload_values_to_autoload()])])).str() +
				"' )").str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_alloptions_db)))) {
			var_alloptions_db = rt.call_method(var_wpdb, 'get_results', [
				rt.concat(rt.new_string('SELECT option_name, option_value FROM '), rt.get_property(var_wpdb,
					'options')),
			])
		}
		rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
		var_alloptions = rt.new_array()
		{
			mut iter_1 := rt.cast_array(var_alloptions_db).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_o_shadow := item_1.val
				var_alloptions.array_set(rt.get_property(var_o_shadow, 'option_name'), rt.get_property(var_o_shadow,
					'option_value'))
			}
		}
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))))
		{
			var_alloptions = rt.call_function('apply_filters', [
				rt.new_string('pre_cache_alloptions'),
				var_alloptions.clone(),
			])
			rt.call_function('wp_cache_add', [rt.new_string('alloptions'),
				var_alloptions.clone(), rt.new_string('options')])
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('alloptions'),
		var_alloptions.clone()])
}

fn wp_prime_site_option_caches(var_options rt.PhpVal) {
	wp_prime_network_option_caches(rt.new_null(), var_options.clone())
}

fn wp_prime_network_option_caches(var_network_id_arg rt.PhpVal, var_options rt.PhpVal) {
	mut var_network_id := var_network_id_arg
	mut var_wpdb := rt.new_null()
	mut var_cache_keys := rt.new_null()
	mut var_option := rt.new_null()
	mut var_cache_group := ''
	mut var_cached_options := rt.new_null()
	mut var_notoptions_key := ''
	mut var_notoptions := rt.new_null()
	mut var_options_to_prime := []rt.PhpVal{}
	mut var_cache_key := rt.new_null()
	mut var_query_args := rt.new_null()
	mut var_results := rt.new_null()
	mut var_data := rt.new_null()
	mut var_options_found := rt.new_null()
	mut var_result := rt.new_null()
	mut var_key := rt.new_null()
	mut var_options_not_found := rt.new_null()
	mut var_update_notoptions := false
	mut var_option_name := rt.new_null()
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		wp_prime_option_caches(var_options.clone())
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_network_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_network_id.clone().is_long()
		|| var_network_id.clone().is_double())))))))
	{
		return
	}
	var_network_id = rt.new_int(var_network_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id)))) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	var_cache_keys = rt.new_array()
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option_shadow := item_1.val
			var_cache_keys.array_set(var_option_shadow,
				'${var_network_id.to_string()}:${var_option.to_string()}')
		}
	}
	var_cache_group = 'site-options'
	var_cached_options = rt.call_function('wp_cache_get_multiple', [
		rt.call_function('array_values', [var_cache_keys.clone()]),
		rt.new_string(var_cache_group.str()).clone(),
	])
	var_notoptions_key = '${var_network_id.to_string()}:notoptions'
	var_notoptions = rt.call_function('wp_cache_get', [rt.new_string(var_notoptions_key.str()).clone(),
		rt.new_string(var_cache_group.str()).clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))))) {
		var_notoptions = rt.new_array()
	}
	var_options_to_prime = rt.new_array()
	{
		mut iter_1 := var_cache_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cache_key_shadow := item_1.val
			mut var_option_shadow := item_1.key
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(var_cached_options.array_isset(var_cache_key_shadow))
				|| rt.is_true(rt.identical(rt.new_bool(false), var_cached_options.array_get(var_cache_key_shadow)))))
				&& !(var_notoptions.array_isset(var_option_shadow))))
			{
				var_options_to_prime << var_option_shadow.clone()
			}
		}
	}
	if !rt.is_true(var_options_to_prime) {
		return
	}
	var_query_args = var_options_to_prime.clone()
	var_query_args.array_push(var_network_id.clone())
	var_results = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.call_function('sprintf', [
				rt.concat(rt.concat(rt.new_string('SELECT meta_key, meta_value FROM '), rt.get_property(var_wpdb,
					'sitemeta')), rt.new_string(' WHERE meta_key IN (%s) AND site_id = %s')),
				rt.call_function('implode', [rt.new_string(','),
					rt.call_function('array_fill', [rt.new_int(0),
						rt.new_int(var_options_to_prime.len),
						rt.new_string('%s')])]),
				rt.new_string('%d'),
			]),
			var_query_args.clone(),
		]),
	])
	var_data = rt.new_array()
	var_options_found = rt.new_array()
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result_shadow := item_1.val
			var_key = rt.get_property(var_result_shadow, 'meta_key')
			var_cache_key = var_cache_keys.array_get(var_key)
			var_data.array_set(var_cache_key, rt.call_function('maybe_unserialize', [
				rt.get_property(var_result_shadow, 'meta_value'),
			]))
			var_options_found.array_push(var_key.clone())
		}
	}
	rt.call_function('wp_cache_set_multiple', [var_data.clone(),
		rt.new_string(var_cache_group.str()).clone()])
	if var_options_found.clone().array_count() == var_options_to_prime.len {
		return
	}
	var_options_not_found = rt.call_function('array_diff', [
		rt.create_array_from_list(var_options_to_prime),
		var_options_found.clone(),
	])
	var_update_notoptions = false
	{
		mut iter_1 := var_options_not_found.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option_name_shadow := item_1.val
			if !(var_notoptions.array_isset(var_option_name_shadow)) {
				var_notoptions.array_set(var_option_name_shadow, true)
				var_update_notoptions = true
			}
		}
	}
	if var_update_notoptions {
		rt.call_function('wp_cache_set', [rt.new_string(var_notoptions_key.str()).clone(),
			var_notoptions.clone(), rt.new_string(var_cache_group.str()).clone()])
	}
}

fn wp_load_core_site_options(var_network_id rt.PhpVal) {
	mut var_core_options := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))
	{
		return
	}
	var_core_options = ['site_name', 'siteurl', 'active_sitewide_plugins',
		'_site_transient_timeout_theme_roots', '_site_transient_theme_roots', 'site_admins',
		'can_compress_scripts', 'global_terms_enabled', 'ms_files_rewriting', 'WPLANG']
	wp_prime_network_option_caches(var_network_id.clone(),
		rt.create_array_from_list(var_core_options))
}

fn update_option(var_option_arg rt.PhpVal, var_value_arg rt.PhpVal, var_autoload_arg rt.PhpVal) bool {
	mut var_option := var_option_arg
	mut var_value := var_value_arg
	mut var_autoload := var_autoload_arg
	mut var_wpdb := rt.new_null()
	mut var_deprecated_keys := rt.new_null()
	mut var_old_value := false
	mut var_serialized_value := rt.new_null()
	mut var_update_args := map[string]rt.PhpVal{}
	mut var_raw_autoload := rt.new_null()
	mut var_allow_values := []rt.PhpVal{}
	mut var_result := rt.new_null()
	mut var_notoptions := rt.new_null()
	mut var_alloptions := rt.new_null()
	if rt.is_true(rt.call_function('is_scalar', [rt.new_string(var_option.str()).clone()])) {
		var_option = var_option.trim_space()
	}
	if var_option == '' {
		return false
	}
	var_deprecated_keys = rt.create_array([
		rt.ArrayItem{ key: 'blacklist_keys', val: 'disallowed_keys' },
		rt.ArrayItem{ key: 'comment_whitelist', val: 'comment_previously_approved' },
	])
	if rt.is_true(rt.new_bool(var_deprecated_keys.array_isset(rt.new_string(var_option.str()))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})))))))
	{
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('5.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%1$s" option key has been renamed to "%2$s".'),
				]),
				rt.new_string(var_option.str()).clone(),
				var_deprecated_keys.array_get(var_option),
			])])
		return update_option(var_deprecated_keys.array_get(var_option), var_value.clone(),
			var_autoload.clone())
	}
	wp_protect_special_option(rt.new_string(var_option.str()).clone())
	if rt.is_true(rt.new_bool(var_value.clone().is_object())) {
		var_value = var_value.dup()
	}
	var_value = rt.call_function('sanitize_option', [rt.new_string(var_option.str()).clone(),
		var_value.clone()])
	var_old_value = get_option(var_option)
	var_value = rt.call_function('apply_filters', [
		rt.new_string('pre_update_option_${var_option}'),
		var_value.clone(),
		rt.new_bool(var_old_value).clone(),
		rt.new_string(var_option.str()).clone(),
	])
	var_value = rt.call_function('apply_filters', [rt.new_string('pre_update_option'),
		var_value.clone(), rt.new_string(var_option.str()).clone(),
		rt.new_bool(var_old_value).clone()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_value, rt.new_bool(var_old_value)))
		|| rt.is_true(rt.identical(rt.call_function('maybe_serialize', [var_value.clone()]), rt.call_function('maybe_serialize', [rt.new_bool(var_old_value).clone()])))))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.call_function('apply_filters', [
		rt.new_string('default_option_${var_option}'),
		rt.new_bool(false),
		rt.new_string(var_option.str()).clone(),
		rt.new_bool(false),
	]), rt.new_bool(var_old_value)))
	{
		return add_option(var_option, var_value.clone(), '', var_autoload.clone())
	}
	var_serialized_value = rt.call_function('maybe_serialize', [
		var_value.clone()])
	rt.call_function('do_action', [rt.new_string('update_option'),
		rt.new_string(var_option.str()).clone(), rt.new_bool(var_old_value).clone(),
		var_value.clone()])
	var_update_args = {
		'option_value': var_serialized_value
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_autoload)))) {
		var_update_args['autoload'] = rt.new_string(wp_determine_option_autoload_value(rt.new_string(var_option.str()).clone(),
			var_value.clone(), var_serialized_value.clone(), var_autoload.clone()))
	} else {
		var_raw_autoload = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT autoload FROM '), rt.get_property(var_wpdb,
					'options')), rt.new_string(' WHERE option_name = %s LIMIT 1')),
				rt.new_string(var_option.str()).clone(),
			]),
		])
		var_allow_values = ['auto-on', 'auto-off', 'auto']
		if rt.is_true(rt.call_function('in_array', [var_raw_autoload.clone(),
			rt.create_array_from_list(var_allow_values), rt.new_bool(true)]))
		{
			var_autoload = rt.new_string(wp_determine_option_autoload_value(rt.new_string(var_option.str()).clone(),
				var_value.clone(), var_serialized_value.clone(), var_autoload.clone()))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_autoload, var_raw_autoload)))) {
				var_update_args['autoload'] = var_autoload.clone()
			}
		}
	}
	var_result = rt.call_method(var_wpdb, 'update', [
		rt.get_property(var_wpdb, 'options'),
		rt.create_array_from_native_map(var_update_args),
		rt.create_array([rt.ArrayItem{ key: 'option_name', val: var_option }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	var_notoptions = rt.call_function('wp_cache_get', [rt.new_string('notoptions'),
		rt.new_string('options')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))
		&& var_notoptions.array_isset(rt.new_string(var_option.str()))))
	{
		var_notoptions.array_unset(rt.new_string(var_option.str()))
		rt.call_function('wp_cache_set', [rt.new_string('notoptions'),
			var_notoptions.clone(), rt.new_string('options')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		if !(var_update_args.array_isset(rt.new_string('autoload'))) {
			var_alloptions = wp_load_alloptions(true)
			if var_alloptions.array_isset(rt.new_string(var_option.str())) {
				var_alloptions.array_set(var_option, var_serialized_value.clone())
				rt.call_function('wp_cache_set', [rt.new_string('alloptions'),
					var_alloptions.clone(), rt.new_string('options')])
			} else {
				rt.call_function('wp_cache_set', [rt.new_string(var_option.str()).clone(),
					var_serialized_value.clone(), rt.new_string('options')])
			}
		} else if rt.is_true(rt.call_function('in_array', [var_update_args.array_get('autoload'),
			wp_autoload_values_to_autoload(), rt.new_bool(true)]))
		{
			rt.call_function('wp_cache_delete', [rt.new_string(var_option.str()).clone(),
				rt.new_string('options')])
			var_alloptions = wp_load_alloptions(true)
			var_alloptions.array_set(var_option, var_serialized_value.clone())
			rt.call_function('wp_cache_set', [rt.new_string('alloptions'),
				var_alloptions.clone(), rt.new_string('options')])
		} else {
			var_alloptions = wp_load_alloptions(true)
			if var_alloptions.array_isset(rt.new_string(var_option.str())) {
				var_alloptions.array_unset(rt.new_string(var_option.str()))
				rt.call_function('wp_cache_set', [rt.new_string('alloptions'),
					var_alloptions.clone(), rt.new_string('options')])
			}
			rt.call_function('wp_cache_set', [rt.new_string(var_option.str()).clone(),
				var_serialized_value.clone(), rt.new_string('options')])
		}
	}
	rt.call_function('do_action', [rt.new_string('update_option_${var_option}'),
		rt.new_bool(var_old_value).clone(), var_value.clone(),
		rt.new_string(var_option.str()).clone()])
	rt.call_function('do_action', [rt.new_string('updated_option'),
		rt.new_string(var_option.str()).clone(), rt.new_bool(var_old_value).clone(),
		var_value.clone()])
	return true
}

fn add_option(var_option_arg rt.PhpVal, value string, deprecated string, var_autoload_arg rt.PhpVal) bool {
	mut var_value := value
	mut var_deprecated := deprecated
	mut var_option := var_option_arg
	mut var_autoload := var_autoload_arg
	mut var_wpdb := rt.new_null()
	mut var_deprecated_keys := rt.new_null()
	mut var_notoptions := rt.new_null()
	mut var_serialized_value := rt.new_null()
	mut var_result := rt.new_null()
	mut var_alloptions := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.3.0')])
	}
	if rt.is_true(rt.call_function('is_scalar', [rt.new_string(var_option.str()).clone()])) {
		var_option = var_option.trim_space()
	}
	if var_option == '' {
		return false
	}
	var_deprecated_keys = rt.create_array([
		rt.ArrayItem{ key: 'blacklist_keys', val: 'disallowed_keys' },
		rt.ArrayItem{ key: 'comment_whitelist', val: 'comment_previously_approved' },
	])
	if rt.is_true(rt.new_bool(var_deprecated_keys.array_isset(rt.new_string(var_option.str()))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})))))))
	{
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('5.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%1$s" option key has been renamed to "%2$s".'),
				]),
				rt.new_string(var_option.str()).clone(),
				var_deprecated_keys.array_get(var_option),
			])])
		return add_option(var_deprecated_keys.array_get(var_option), var_value, deprecated,
			var_autoload.clone())
	}
	wp_protect_special_option(rt.new_string(var_option.str()).clone())
	if rt.is_true(rt.new_bool(rt.new_string(var_value.str()).is_object())) {
		var_value = rt.new_string(var_value.str()).dup()
	}
	var_value = (rt.call_function('sanitize_option', [rt.new_string(var_option.str()).clone(),
		rt.new_string(var_value.str())])).str()
	var_notoptions = rt.call_function('wp_cache_get', [rt.new_string('notoptions'),
		rt.new_string('options')])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array())))))
		|| !(var_notoptions.array_isset(rt.new_string(var_option.str())))))
	{
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('apply_filters', [
			rt.new_string('default_option_${var_option}'),
			rt.new_bool(false),
			rt.new_string(var_option.str()).clone(),
			rt.new_bool(false),
		]), rt.new_bool(get_option(rt.new_string(var_option.str()).clone(), false))))))
		{
			return false
		}
	}
	var_serialized_value = rt.call_function('maybe_serialize', [
		rt.new_string(var_value.str()),
	])
	var_autoload = rt.new_string(wp_determine_option_autoload_value(rt.new_string(var_option.str()).clone(),
		rt.new_string(var_value.str()), var_serialized_value.clone(), var_autoload.clone()))
	rt.call_function('do_action', [rt.new_string('add_option'),
		rt.new_string(var_option.str()).clone(), rt.new_string(var_value.str())])
	var_result = rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('INSERT INTO `'),
				rt.get_property(var_wpdb, 'options')),
				rt.new_string('` (`option_name`, `option_value`, `autoload`) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE `option_name` = VALUES(`option_name`), `option_value` = VALUES(`option_value`), `autoload` = VALUES(`autoload`)')),
			rt.new_string(var_option.str()).clone(),
			var_serialized_value.clone(),
			var_autoload.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_function('in_array', [var_autoload.clone(),
			wp_autoload_values_to_autoload(), rt.new_bool(true)]))
		{
			var_alloptions = wp_load_alloptions(true)
			var_alloptions.array_set(var_option, var_serialized_value.clone())
			rt.call_function('wp_cache_set', [rt.new_string('alloptions'),
				var_alloptions.clone(), rt.new_string('options')])
		} else {
			rt.call_function('wp_cache_set', [rt.new_string(var_option.str()).clone(),
				var_serialized_value.clone(), rt.new_string('options')])
		}
	}
	var_notoptions = rt.call_function('wp_cache_get', [rt.new_string('notoptions'),
		rt.new_string('options')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))
		&& var_notoptions.array_isset(rt.new_string(var_option.str()))))
	{
		var_notoptions.array_unset(rt.new_string(var_option.str()))
		rt.call_function('wp_cache_set', [rt.new_string('notoptions'),
			var_notoptions.clone(), rt.new_string('options')])
	}
	rt.call_function('do_action', [rt.new_string('add_option_${var_option}'),
		rt.new_string(var_option.str()).clone(), rt.new_string(var_value.str())])
	rt.call_function('do_action', [rt.new_string('added_option'),
		rt.new_string(var_option.str()).clone(), rt.new_string(var_value.str())])
	return true
}

fn delete_option(var_option_arg rt.PhpVal) bool {
	mut var_option := var_option_arg
	mut var_wpdb := rt.new_null()
	mut var_row := rt.new_null()
	mut var_result := rt.new_null()
	mut var_alloptions := rt.new_null()
	mut var_notoptions := rt.new_null()
	if rt.is_true(rt.call_function('is_scalar', [rt.new_string(var_option.str()).clone()])) {
		var_option = var_option.trim_space()
	}
	if var_option == '' {
		return false
	}
	wp_protect_special_option(rt.new_string(var_option.str()).clone())
	var_row = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT autoload FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' WHERE option_name = %s')),
			rt.new_string(var_option.str()).clone(),
		]),
	])
	if rt.is_true(rt.new_bool(var_row.clone().is_null())) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('delete_option'),
		rt.new_string(var_option.str()).clone()])
	var_result = rt.call_method(var_wpdb, 'delete', [
		rt.get_property(var_wpdb, 'options'),
		rt.create_array([rt.ArrayItem{ key: 'option_name', val: var_option }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_function('in_array', [rt.get_property(var_row, 'autoload'),
			wp_autoload_values_to_autoload(), rt.new_bool(true)]))
		{
			var_alloptions = wp_load_alloptions(true)
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_alloptions.clone().is_array()))
				&& var_alloptions.array_isset(rt.new_string(var_option.str()))))
			{
				var_alloptions.array_unset(rt.new_string(var_option.str()))
				rt.call_function('wp_cache_set', [rt.new_string('alloptions'),
					var_alloptions.clone(), rt.new_string('options')])
			}
		} else {
			rt.call_function('wp_cache_delete', [rt.new_string(var_option.str()).clone(),
				rt.new_string('options')])
		}
		var_notoptions = rt.call_function('wp_cache_get', [rt.new_string('notoptions'),
			rt.new_string('options')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))))) {
			var_notoptions = rt.new_array()
		}
		var_notoptions.array_set(var_option, true)
		rt.call_function('wp_cache_set', [rt.new_string('notoptions'),
			var_notoptions.clone(), rt.new_string('options')])
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [rt.new_string('delete_option_${var_option}'),
			rt.new_string(var_option.str()).clone()])
		rt.call_function('do_action', [rt.new_string('deleted_option'),
			rt.new_string(var_option.str()).clone()])
		return true
	}
	return false
}

fn wp_determine_option_autoload_value(var_option rt.PhpVal, var_value rt.PhpVal, var_serialized_value rt.PhpVal, var_autoload_arg rt.PhpVal) string {
	mut var_autoload := var_autoload_arg
	if rt.is_true(rt.new_bool(var_autoload.clone().is_bool())) {
		return if rt.is_true(var_autoload) { 'on' } else { 'off' }
	}
	mut switch_val_1 := var_autoload
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('on')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('yes'))) {
		return 'on'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('off')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('no'))) {
		return 'off'
	}
	var_autoload = rt.call_function('apply_filters', [
		rt.new_string('wp_default_autoload_value'),
		rt.new_null(),
		var_option.clone(),
		var_value.clone(),
		var_serialized_value.clone(),
	])
	if rt.is_true(rt.new_bool(var_autoload.clone().is_bool())) {
		return if rt.is_true(var_autoload) { 'auto-on' } else { 'auto-off' }
	}
	return 'auto'
}

fn wp_filter_default_autoload_value_via_option_size(var_autoload rt.PhpVal, var_option rt.PhpVal, var_value rt.PhpVal, var_serialized_value rt.PhpVal) bool {
	mut var_max_option_size := rt.new_null()
	mut var_size := i64(0)
	var_max_option_size = rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('wp_max_autoloaded_option_size'),
		rt.new_int(150000),
		var_option.clone(),
	])).to_i64())
	var_size = if !(!rt.is_true(var_serialized_value)) {
		var_serialized_value.clone().to_string().len
	} else {
		0
	}
	if rt.is_true(rt.greater(rt.new_int(var_size), var_max_option_size)) {
		return false
	}
	return var_autoload.to_bool()
}

fn delete_transient(var_transient rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_null()
	mut var_option_timeout := rt.new_null()
	mut var_option := rt.new_null()
	rt.call_function('do_action', [
		rt.new_string('delete_transient_${var_transient.to_string()}'),
		var_transient.clone(),
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))
	{
		var_result = rt.call_function('wp_cache_delete', [var_transient.clone(),
			rt.new_string('transient')])
	} else {
		var_option_timeout = rt.new_string('_transient_timeout_' + var_transient.str())
		var_option = rt.new_string('_transient_' + var_transient.str())
		var_result = rt.new_bool(delete_option(var_option.clone()))
		if rt.is_true(var_result) {
			rt.new_bool(delete_option(var_option_timeout.clone()))
		}
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [rt.new_string('deleted_transient'),
			var_transient.clone()])
	}
	return var_result.clone()
}

fn get_transient(var_transient rt.PhpVal) rt.PhpVal {
	mut var_pre := rt.new_null()
	mut var_value := rt.new_null()
	mut var_transient_option := rt.new_null()
	mut var_alloptions := rt.new_null()
	mut var_transient_timeout := rt.new_null()
	mut var_timeout := false
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_transient_${var_transient.to_string()}'),
		rt.new_bool(false),
		var_transient.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
		return var_pre.clone()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))
	{
		var_value = rt.call_function('wp_cache_get', [var_transient.clone(),
			rt.new_string('transient')])
	} else {
		var_transient_option = rt.new_string('_transient_' + var_transient.str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
			var_alloptions = wp_load_alloptions(false)
			if !(var_alloptions.array_isset(var_transient_option)) {
				var_transient_timeout = rt.new_string('_transient_timeout_' + var_transient.str())
				wp_prime_option_caches(rt.create_array([
					rt.ArrayItem{ key: none, val: var_transient_option },
					rt.ArrayItem{ key: none, val: var_transient_timeout },
				]))
				var_timeout = get_option(var_transient_timeout.clone())
				if rt.is_true(rt.new_bool(
					rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_timeout)))))
					&& rt.is_true(rt.less(rt.new_bool(var_timeout), rt.call_function('time', []rt.PhpVal{})))))
				{
					rt.new_bool(delete_option(var_transient_option.clone()))
					rt.new_bool(delete_option(var_transient_timeout.clone()))
					var_value = rt.new_bool(false)
				}
			}
		}
		if !(!var_value.is_null()) {
			var_value = rt.new_bool(get_option(var_transient_option.clone(), false))
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('transient_${var_transient.to_string()}'),
		var_value.clone(),
		var_transient.clone(),
	])
}

fn set_transient(var_transient rt.PhpVal, var_value_arg rt.PhpVal, expiration i64) rt.PhpVal {
	mut var_expiration := expiration
	mut var_value := var_value_arg
	mut var_result := rt.new_null()
	mut var_transient_timeout := rt.new_null()
	mut var_transient_option := rt.new_null()
	mut var_autoload := false
	mut var_update := false
	var_expiration = var_expiration
	var_value = rt.call_function('apply_filters', [
		rt.new_string('pre_set_transient_${var_transient.to_string()}'),
		var_value.clone(),
		rt.new_int(var_expiration),
		var_transient.clone(),
	])
	var_expiration = (rt.call_function('apply_filters', [
		rt.new_string('expiration_of_transient_${var_transient.to_string()}'),
		rt.new_int(var_expiration),
		var_value.clone(),
		var_transient.clone(),
	])).to_i64()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))
	{
		var_result = rt.call_function('wp_cache_set', [var_transient.clone(),
			var_value.clone(), rt.new_string('transient'), rt.new_int(var_expiration)])
	} else {
		var_transient_timeout = rt.new_string('_transient_timeout_' + var_transient.str())
		var_transient_option = rt.new_string('_transient_' + var_transient.str())
		wp_prime_option_caches(rt.create_array([
			rt.ArrayItem{ key: none, val: var_transient_option },
			rt.ArrayItem{ key: none, val: var_transient_timeout },
		]))
		if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(get_option(var_transient_option.clone(),
			false))))
		{
			var_autoload = true
			if var_expiration != 0 {
				var_autoload = false
				rt.new_bool(add_option(var_transient_timeout.clone(), rt.add(rt.call_function('time',
					[]rt.PhpVal{}), rt.new_int(var_expiration)), '', rt.new_bool(false)))
			}
			var_result = rt.new_bool(add_option(var_transient_option.clone(), var_value.clone(),
				'', rt.new_bool(var_autoload).clone()))
		} else {
			var_update = true
			if var_expiration != 0 {
				if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(get_option(var_transient_timeout.clone(),
					false))))
				{
					rt.new_bool(delete_option(var_transient_option.clone()))
					rt.new_bool(add_option(var_transient_timeout.clone(), rt.add(rt.call_function('time',
						[]rt.PhpVal{}), rt.new_int(var_expiration)), '', rt.new_bool(false)))
					var_result = rt.new_bool(add_option(var_transient_option.clone(),
						var_value.clone(), '', rt.new_bool(false)))
					var_update = false
				} else {
					rt.new_bool(update_option(var_transient_timeout.clone(), rt.add(rt.call_function('time',
						[]rt.PhpVal{}), rt.new_int(var_expiration)), rt.new_null()))
				}
			}
			if var_update {
				var_result = rt.new_bool(update_option(var_transient_option.clone(),
					var_value.clone(), rt.new_null()))
			}
		}
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [
			rt.new_string('set_transient_${var_transient.to_string()}'),
			var_value.clone(),
			rt.new_int(var_expiration),
			var_transient.clone(),
		])
		rt.call_function('do_action', [rt.new_string('set_transient'),
			var_transient.clone(), var_value.clone(), rt.new_int(var_expiration)])
		rt.call_function('do_action_deprecated', [rt.new_string('setted_transient'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_transient },
				rt.ArrayItem{ key: none, val: var_value }, rt.ArrayItem{
					key: none
					val: var_expiration
				}]),
			rt.new_string('6.8.0'), rt.new_string('set_transient')])
	}
	return var_result.clone()
}

fn delete_expired_transients(force_db bool) {
	mut var_force_db := force_db
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!var_force_db
		&& rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))))
	{
		return
	}
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE a, b FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' a, ')), rt.get_property(var_wpdb, 'options')),
				rt.new_string(" b\n\t\t\tWHERE a.option_name LIKE %s\n\t\t\tAND a.option_name NOT LIKE %s\n\t\t\tAND b.option_name = CONCAT( '_transient_timeout_', SUBSTRING( a.option_name, 12 ) )\n\t\t\tAND b.option_value < %d")),
			rt.new_string(
				(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_transient_')])).str() + '%'),
			rt.new_string(
				(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_transient_timeout_')])).str() +
				'%'),
			rt.call_function('time', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE a, b FROM '), rt.get_property(var_wpdb,
					'options')), rt.new_string(' a, ')), rt.get_property(var_wpdb, 'options')),
					rt.new_string(" b\n\t\t\t\tWHERE a.option_name LIKE %s\n\t\t\t\tAND a.option_name NOT LIKE %s\n\t\t\t\tAND b.option_name = CONCAT( '_site_transient_timeout_', SUBSTRING( a.option_name, 17 ) )\n\t\t\t\tAND b.option_value < %d")),
				rt.new_string(
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_site_transient_')])).str() +
					'%'),
				rt.new_string(
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_site_transient_timeout_')])).str() +
					'%'),
				rt.call_function('time', []rt.PhpVal{}),
			]),
		])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_main_network', []rt.PhpVal{}))))
	{
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE a, b FROM '), rt.get_property(var_wpdb,
					'sitemeta')), rt.new_string(' a, ')), rt.get_property(var_wpdb, 'sitemeta')),
					rt.new_string(" b\n\t\t\t\tWHERE a.meta_key LIKE %s\n\t\t\t\tAND a.meta_key NOT LIKE %s\n\t\t\t\tAND b.meta_key = CONCAT( '_site_transient_timeout_', SUBSTRING( a.meta_key, 17 ) )\n\t\t\t\tAND b.meta_value < %d")),
				rt.new_string(
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_site_transient_')])).str() +
					'%'),
				rt.new_string(
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_site_transient_timeout_')])).str() +
					'%'),
				rt.call_function('time', []rt.PhpVal{}),
			]),
		])
	}
}

fn wp_user_settings() {
	mut var_user_id := rt.new_null()
	mut var_settings := rt.new_null()
	mut var_cookie := rt.new_null()
	mut var_last_saved := rt.new_null()
	mut var_current := rt.new_null()
	mut var_secure := false
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))
	{
		return
	}
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', []rt.PhpVal{}))))) {
		return
	}
	var_settings = rt.new_string((rt.call_function('get_user_option', [
		rt.new_string('user-settings'),
		var_user_id.clone(),
	])).str())
	if rt.get_superglobal('_COOKIE').array_isset('wp-settings-' + var_user_id.str()) {
		var_cookie = rt.call_function('preg_replace', [
			rt.new_string('/[^A-Za-z0-9=&_]/'),
			rt.new_string(''),
			rt.get_superglobal('_COOKIE').array_get('wp-settings-' + var_user_id.str()),
		])
		if rt.is_true(rt.identical(var_cookie, var_settings)) {
			return
		}
		var_last_saved = rt.new_int((rt.call_function('get_user_option', [
			rt.new_string('user-settings-time'),
			var_user_id.clone(),
		])).to_i64())
		var_current = rt.new_int(0)
		if rt.get_superglobal('_COOKIE').array_isset('wp-settings-time-' + var_user_id.str()) {
			var_current = rt.new_int((rt.call_function('preg_replace', [
				rt.new_string('/[^0-9]/'),
				rt.new_string(''),
				rt.get_superglobal('_COOKIE').array_get('wp-settings-time-' + var_user_id.str()),
			])).to_i64())
		}
		if rt.is_true(rt.greater(var_current, var_last_saved)) {
			rt.call_function('update_user_option', [var_user_id.clone(),
				rt.new_string('user-settings'), var_cookie.clone(),
				rt.new_bool(false)])
			rt.call_function('update_user_option', [var_user_id.clone(),
				rt.new_string('user-settings-time'),
				rt.sub(rt.call_function('time', []rt.PhpVal{}),
					rt.new_int(5)),
				rt.new_bool(false)])
			return
		}
	}
	var_secure = (rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
		rt.call_function('admin_url', []rt.PhpVal{}),
		rt.get_constant('PHP_URL_SCHEME'),
	]))).to_bool()
	rt.call_function('setcookie', [rt.new_string('wp-settings-' + var_user_id.str()),
		var_settings.clone(),
		rt.add(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'), rt.new_string(''),
		rt.new_bool(var_secure).clone()])
	rt.call_function('setcookie', [
		rt.new_string('wp-settings-time-' + var_user_id.str()),
		rt.call_function('time', []rt.PhpVal{}),
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'),
		rt.new_string(''),
		rt.new_bool(var_secure).clone(),
	])
	rt.get_superglobal('_COOKIE').array_set('wp-settings-' + var_user_id.str(),
		var_settings.clone())
}

fn get_user_setting(var_name rt.PhpVal, default_value bool) rt.PhpVal {
	mut var_default_value := default_value
	mut var_all_user_settings := rt.new_null()
	var_all_user_settings = get_all_user_settings()
	return if !(var_all_user_settings.array_get(var_name)).is_null() {
		var_all_user_settings.array_get(var_name)
	} else {
		rt.new_bool(default_value)
	}
}

fn set_user_setting(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_all_user_settings := rt.new_null()
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return false
	}
	var_all_user_settings = get_all_user_settings()
	var_all_user_settings.array_set(var_name, var_value.clone())
	return (wp_set_all_user_settings(var_all_user_settings.clone())).to_bool()
}

fn delete_user_setting(var_names_arg rt.PhpVal) bool {
	mut var_names := var_names_arg
	mut var_all_user_settings := rt.new_null()
	mut var_deleted := false
	mut var_name := rt.new_null()
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return false
	}
	var_all_user_settings = get_all_user_settings()
	var_names = rt.cast_array(var_names)
	var_deleted = false
	{
		mut iter_1 := var_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name_shadow := item_1.val
			if var_all_user_settings.array_isset(var_name_shadow) {
				var_all_user_settings.array_unset(var_name_shadow)
				var_deleted = true
			}
		}
	}
	if var_deleted {
		return (wp_set_all_user_settings(var_all_user_settings.clone())).to_bool()
	}
	return false
}

fn get_all_user_settings() rt.PhpVal {
	mut var_user_id := rt.new_null()
	mut var_user_settings := rt.new_null()
	mut var_cookie := rt.new_null()
	mut var_option := rt.new_null()
	mut var__updated_user_settings := rt.new_null()
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!var__updated_user_settings.is_null()
		&& rt.is_true(rt.new_bool(var__updated_user_settings.clone().is_array()))))
	{
		return var__updated_user_settings.clone()
	}
	var_user_settings = rt.new_array()
	if rt.get_superglobal('_COOKIE').array_isset('wp-settings-' + var_user_id.str()) {
		var_cookie = rt.call_function('preg_replace', [
			rt.new_string('/[^A-Za-z0-9=&_-]/'),
			rt.new_string(''),
			rt.get_superglobal('_COOKIE').array_get('wp-settings-' + var_user_id.str()),
		])
		if rt.is_true(rt.call_function('strpos', [var_cookie.clone(),
			rt.new_string('=')]))
		{
			rt.call_function('parse_str', [var_cookie.clone(),
				var_user_settings.clone()])
		}
	} else {
		var_option = rt.call_function('get_user_option', [rt.new_string('user-settings'),
			var_user_id.clone()])
		if rt.is_true(rt.new_bool(rt.is_true(var_option)
			&& rt.is_true(rt.new_bool(var_option.clone().is_string()))))
		{
			rt.call_function('parse_str', [var_option.clone(),
				var_user_settings.clone()])
		}
	}
	var__updated_user_settings = var_user_settings.clone()
	return var_user_settings.clone()
}

fn wp_set_all_user_settings(var_user_settings rt.PhpVal) rt.PhpVal {
	mut var__updated_user_settings := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_settings := ''
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	mut var__name := rt.new_null()
	mut var__value := rt.new_null()
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	var_settings = ''
	{
		mut iter_1 := var_user_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value_shadow := item_1.val
			mut var_name_shadow := item_1.key
			var__name = rt.call_function('preg_replace', [
				rt.new_string('/[^A-Za-z0-9_-]+/'),
				rt.new_string(''),
				var_name_shadow.clone(),
			])
			var__value = rt.call_function('preg_replace', [
				rt.new_string('/[^A-Za-z0-9_-]+/'),
				rt.new_string(''),
				var_value_shadow.clone(),
			])
			if !(!rt.is_true(var__name)) {
				var_settings = var_settings + var__name.str() + '=' + var__value.str() + '&'
			}
		}
	}
	var_settings = var_settings.trim_right(' \t\n\r')
	rt.call_function('parse_str', [rt.new_string(var_settings.str()).clone(),
		var__updated_user_settings.clone()])
	rt.call_function('update_user_option', [var_user_id.clone(),
		rt.new_string('user-settings'), rt.new_string(var_settings.str()).clone(),
		rt.new_bool(false)])
	rt.call_function('update_user_option', [var_user_id.clone(),
		rt.new_string('user-settings-time'), rt.call_function('time', []rt.PhpVal{}),
		rt.new_bool(false)])
	return rt.new_bool(true)
}

fn delete_all_user_settings() {
	mut var_user_id := rt.new_null()
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return
	}
	rt.call_function('update_user_option', [var_user_id.clone(),
		rt.new_string('user-settings'), rt.new_string(''), rt.new_bool(false)])
	rt.call_function('setcookie', [rt.new_string('wp-settings-' + var_user_id.str()),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH')])
}

fn get_site_option(var_option rt.PhpVal, default_value bool, deprecated bool) rt.PhpVal {
	mut var_default_value := default_value
	mut var_deprecated := deprecated
	return rt.new_bool(get_network_option(rt.new_null(), var_option.clone(), default_value))
}

fn add_site_option(var_option rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	return rt.new_bool(add_network_option(rt.new_null(), var_option.clone(), var_value.clone()))
}

fn delete_site_option(var_option rt.PhpVal) rt.PhpVal {
	return rt.new_bool(delete_network_option(rt.new_null(), var_option.clone()))
}

fn update_site_option(var_option rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	return rt.new_bool(update_network_option(rt.new_null(), var_option.clone(), var_value.clone()))
}

fn get_network_option(var_network_id_arg rt.PhpVal, var_option rt.PhpVal, default_value bool) bool {
	mut var_default_value := default_value
	mut var_network_id := var_network_id_arg
	mut var_wpdb := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_notoptions_key := ''
	mut var_notoptions := rt.new_null()
	mut var_value := rt.new_null()
	mut var_cache_key := ''
	mut var_row := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(var_network_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_network_id.clone().is_long()
		|| var_network_id.clone().is_double())))))))
	{
		return false
	}
	var_network_id = rt.new_int(var_network_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id)))) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_site_option_${var_option.to_string()}'),
		rt.new_bool(false),
		var_option.clone(),
		var_network_id.clone(),
		rt.new_bool(var_default_value),
	])
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_site_option'),
		var_pre.clone(), var_option.clone(), var_network_id.clone(),
		rt.new_bool(var_default_value)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
		return var_pre.to_bool()
	}
	var_notoptions_key = '${var_network_id.to_string()}:notoptions'
	var_notoptions = rt.call_function('wp_cache_get', [rt.new_string(var_notoptions_key.str()).clone(),
		rt.new_string('site-options')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))
		&& var_notoptions.array_isset(var_option)))
	{
		return (rt.call_function('apply_filters', [
			rt.new_string('default_site_option_${var_option.to_string()}'),
			rt.new_bool(var_default_value),
			var_option.clone(),
			var_network_id.clone(),
		])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_default_value = (rt.call_function('apply_filters', [
			rt.new_string('default_site_option_' + var_option.str()),
			rt.new_bool(var_default_value),
			var_option.clone(),
			var_network_id.clone(),
		])).to_bool()
		var_value = rt.new_bool(get_option(var_option.clone(), var_default_value))
	} else {
		var_cache_key = '${var_network_id.to_string()}:${var_option.to_string()}'
		var_value = rt.call_function('wp_cache_get', [rt.new_string(var_cache_key.str()).clone(),
			rt.new_string('site-options')])
		if rt.is_true(rt.new_bool(!(!var_value.is_null())
			|| rt.is_true(rt.identical(rt.new_bool(false), var_value))))
		{
			var_row = rt.call_method(var_wpdb, 'get_row', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb,
						'sitemeta')), rt.new_string(' WHERE meta_key = %s AND site_id = %d')),
					var_option.clone(),
					var_network_id.clone(),
				]),
			])
			if rt.is_true(rt.new_bool(var_row.clone().is_object())) {
				var_value = rt.get_property(var_row, 'meta_value')
				var_value = rt.call_function('maybe_unserialize', [
					var_value.clone()])
				rt.call_function('wp_cache_set', [rt.new_string(var_cache_key.str()).clone(),
					var_value.clone(), rt.new_string('site-options')])
			} else {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))))) {
					var_notoptions = rt.new_array()
				}
				var_notoptions.array_set(var_option, true)
				rt.call_function('wp_cache_set', [rt.new_string(var_notoptions_key.str()).clone(),
					var_notoptions.clone(), rt.new_string('site-options')])
				var_value = rt.call_function('apply_filters', [
					rt.new_string('default_site_option_' + var_option.str()),
					rt.new_bool(var_default_value),
					var_option.clone(),
					var_network_id.clone(),
				])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))))) {
		var_notoptions = rt.new_array()
		rt.call_function('wp_cache_set', [rt.new_string(var_notoptions_key.str()).clone(),
			var_notoptions.clone(), rt.new_string('site-options')])
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('site_option_${var_option.to_string()}'),
		var_value.clone(),
		var_option.clone(),
		var_network_id.clone(),
	])).to_bool()
}

fn add_network_option(var_network_id_arg rt.PhpVal, var_option rt.PhpVal, var_value_arg rt.PhpVal) bool {
	mut var_network_id := var_network_id_arg
	mut var_value := var_value_arg
	mut var_wpdb := rt.new_null()
	mut var_notoptions_key := ''
	mut var_result := rt.new_null()
	mut var_cache_key := ''
	mut var_notoptions := rt.new_null()
	mut var_serialized_value := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(var_network_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_network_id.clone().is_long()
		|| var_network_id.clone().is_double())))))))
	{
		return false
	}
	var_network_id = rt.new_int(var_network_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id)))) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	wp_protect_special_option(var_option.clone())
	var_value = rt.call_function('apply_filters', [
		rt.new_string('pre_add_site_option_${var_option.to_string()}'),
		var_value.clone(),
		var_option.clone(),
		var_network_id.clone(),
	])
	var_notoptions_key = '${var_network_id.to_string()}:notoptions'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_result = rt.new_bool(add_option(var_option.clone(), var_value.clone(), '',
			rt.new_bool(false)))
	} else {
		var_cache_key = '${var_network_id.to_string()}:${var_option.to_string()}'
		var_notoptions = rt.call_function('wp_cache_get', [rt.new_string(var_notoptions_key.str()).clone(),
			rt.new_string('site-options')])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array())))))
			|| !(var_notoptions.array_isset(var_option))))
		{
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(get_network_option(var_network_id.clone(),
				var_option.clone(), false))))))
			{
				return false
			}
		}
		var_value = rt.call_function('sanitize_option', [var_option.clone(),
			var_value.clone()])
		var_serialized_value = rt.call_function('maybe_serialize', [
			var_value.clone()])
		var_result = rt.call_method(var_wpdb, 'insert', [
			rt.get_property(var_wpdb, 'sitemeta'),
			rt.create_array([rt.ArrayItem{ key: 'site_id', val: var_network_id },
				rt.ArrayItem{ key: 'meta_key', val: var_option },
				rt.ArrayItem{ key: 'meta_value', val: var_serialized_value }]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
			return false
		}
		rt.call_function('wp_cache_set', [rt.new_string(var_cache_key.str()).clone(),
			var_value.clone(), rt.new_string('site-options')])
		var_notoptions = rt.call_function('wp_cache_get', [rt.new_string(var_notoptions_key.str()).clone(),
			rt.new_string('site-options')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))
			&& var_notoptions.array_isset(var_option)))
		{
			var_notoptions.array_unset(var_option)
			rt.call_function('wp_cache_set', [rt.new_string(var_notoptions_key.str()).clone(),
				var_notoptions.clone(), rt.new_string('site-options')])
		}
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [
			rt.new_string('add_site_option_${var_option.to_string()}'),
			var_option.clone(),
			var_value.clone(),
			var_network_id.clone(),
		])
		rt.call_function('do_action', [rt.new_string('add_site_option'),
			var_option.clone(), var_value.clone(), var_network_id.clone()])
		return true
	}
	return false
}

fn delete_network_option(var_network_id_arg rt.PhpVal, var_option rt.PhpVal) bool {
	mut var_network_id := var_network_id_arg
	mut var_wpdb := rt.new_null()
	mut var_result := rt.new_null()
	mut var_row := rt.new_null()
	mut var_cache_key := ''
	mut var_notoptions_key := ''
	mut var_notoptions := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(var_network_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_network_id.clone().is_long()
		|| var_network_id.clone().is_double())))))))
	{
		return false
	}
	var_network_id = rt.new_int(var_network_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id)))) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	rt.call_function('do_action', [
		rt.new_string('pre_delete_site_option_${var_option.to_string()}'),
		var_option.clone(),
		var_network_id.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_result = rt.new_bool(delete_option(var_option.clone()))
	} else {
		var_row = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb,
					'sitemeta')), rt.new_string(' WHERE meta_key = %s AND site_id = %d')),
				var_option.clone(),
				var_network_id.clone(),
			]),
		])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_row.clone().is_null()))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_row, 'meta_id')))))))
		{
			return false
		}
		var_cache_key = '${var_network_id.to_string()}:${var_option.to_string()}'
		rt.call_function('wp_cache_delete', [rt.new_string(var_cache_key.str()).clone(),
			rt.new_string('site-options')])
		var_result = rt.call_method(var_wpdb, 'delete', [
			rt.get_property(var_wpdb, 'sitemeta'),
			rt.create_array([rt.ArrayItem{ key: 'meta_key', val: var_option },
				rt.ArrayItem{ key: 'site_id', val: var_network_id }]),
		])
		if rt.is_true(var_result) {
			var_notoptions_key = '${var_network_id.to_string()}:notoptions'
			var_notoptions = rt.call_function('wp_cache_get', [
				rt.new_string(var_notoptions_key.str()).clone(),
				rt.new_string('site-options')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))))) {
				var_notoptions = rt.new_array()
			}
			var_notoptions.array_set(var_option, true)
			rt.call_function('wp_cache_set', [rt.new_string(var_notoptions_key.str()).clone(),
				var_notoptions.clone(), rt.new_string('site-options')])
		}
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [
			rt.new_string('delete_site_option_${var_option.to_string()}'),
			var_option.clone(),
			var_network_id.clone(),
		])
		rt.call_function('do_action', [rt.new_string('delete_site_option'),
			var_option.clone(), var_network_id.clone()])
		return true
	}
	return false
}

fn update_network_option(var_network_id_arg rt.PhpVal, var_option rt.PhpVal, var_value_arg rt.PhpVal) bool {
	mut var_network_id := var_network_id_arg
	mut var_value := var_value_arg
	mut var_wpdb := rt.new_null()
	mut var_old_value := false
	mut var_notoptions_key := ''
	mut var_notoptions := rt.new_null()
	mut var_result := rt.new_null()
	mut var_serialized_value := rt.new_null()
	mut var_cache_key := ''
	if rt.is_true(rt.new_bool(rt.is_true(var_network_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_network_id.clone().is_long()
		|| var_network_id.clone().is_double())))))))
	{
		return false
	}
	var_network_id = rt.new_int(var_network_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id)))) {
		var_network_id = rt.call_function('get_current_network_id', []rt.PhpVal{})
	}
	wp_protect_special_option(var_option.clone())
	var_old_value = get_network_option(var_network_id.clone(), var_option.clone())
	var_value = rt.call_function('apply_filters', [
		rt.new_string('pre_update_site_option_${var_option.to_string()}'),
		var_value.clone(),
		rt.new_bool(var_old_value).clone(),
		var_option.clone(),
		var_network_id.clone(),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_value, rt.new_bool(var_old_value)))
		|| rt.is_true(rt.identical(rt.call_function('maybe_serialize', [var_value.clone()]), rt.call_function('maybe_serialize', [rt.new_bool(var_old_value).clone()])))))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_old_value))) {
		return add_network_option(var_network_id.clone(), var_option.clone(), var_value.clone())
	}
	var_notoptions_key = '${var_network_id.to_string()}:notoptions'
	var_notoptions = rt.call_function('wp_cache_get', [rt.new_string(var_notoptions_key.str()).clone(),
		rt.new_string('site-options')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_notoptions.clone().is_array()))
		&& var_notoptions.array_isset(var_option)))
	{
		var_notoptions.array_unset(var_option)
		rt.call_function('wp_cache_set', [rt.new_string(var_notoptions_key.str()).clone(),
			var_notoptions.clone(), rt.new_string('site-options')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_result = rt.new_bool(update_option(var_option.clone(), var_value.clone(),
			rt.new_bool(false)))
	} else {
		var_value = rt.call_function('sanitize_option', [var_option.clone(),
			var_value.clone()])
		var_serialized_value = rt.call_function('maybe_serialize', [
			var_value.clone()])
		var_result = rt.call_method(var_wpdb, 'update', [
			rt.get_property(var_wpdb, 'sitemeta'),
			rt.create_array([
				rt.ArrayItem{ key: 'meta_value', val: var_serialized_value },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'site_id', val: var_network_id },
				rt.ArrayItem{ key: 'meta_key', val: var_option },
			]),
		])
		if rt.is_true(var_result) {
			var_cache_key = '${var_network_id.to_string()}:${var_option.to_string()}'
			rt.call_function('wp_cache_set', [rt.new_string(var_cache_key.str()).clone(),
				var_value.clone(), rt.new_string('site-options')])
		}
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [
			rt.new_string('update_site_option_${var_option.to_string()}'),
			var_option.clone(),
			var_value.clone(),
			rt.new_bool(var_old_value).clone(),
			var_network_id.clone(),
		])
		rt.call_function('do_action', [rt.new_string('update_site_option'),
			var_option.clone(), var_value.clone(), rt.new_bool(var_old_value).clone(),
			var_network_id.clone()])
		return true
	}
	return false
}

fn delete_site_transient(var_transient rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_null()
	mut var_option_timeout := rt.new_null()
	mut var_option := rt.new_null()
	rt.call_function('do_action', [
		rt.new_string('delete_site_transient_${var_transient.to_string()}'),
		var_transient.clone(),
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))
	{
		var_result = rt.call_function('wp_cache_delete', [var_transient.clone(),
			rt.new_string('site-transient')])
	} else {
		var_option_timeout = rt.new_string('_site_transient_timeout_' + var_transient.str())
		var_option = rt.new_string('_site_transient_' + var_transient.str())
		var_result = delete_site_option(var_option.clone())
		if rt.is_true(var_result) {
			delete_site_option(var_option_timeout.clone())
		}
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [rt.new_string('deleted_site_transient'),
			var_transient.clone()])
	}
	return var_result.clone()
}

fn get_site_transient(var_transient rt.PhpVal) rt.PhpVal {
	mut var_pre := rt.new_null()
	mut var_value := rt.new_null()
	mut var_no_timeout := []rt.PhpVal{}
	mut var_transient_option := rt.new_null()
	mut var_transient_timeout := rt.new_null()
	mut var_timeout := rt.new_null()
	var_pre = rt.call_function('apply_filters', [
		rt.new_string('pre_site_transient_${var_transient.to_string()}'),
		rt.new_bool(false),
		var_transient.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pre)))) {
		return var_pre.clone()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))
	{
		var_value = rt.call_function('wp_cache_get', [var_transient.clone(),
			rt.new_string('site-transient')])
	} else {
		var_no_timeout = ['update_core', 'update_plugins', 'update_themes']
		var_transient_option = rt.new_string('_site_transient_' + var_transient.str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_transient.clone(), rt.create_array_from_list(var_no_timeout),
			rt.new_bool(true)])))))
		{
			var_transient_timeout = rt.new_string('_site_transient_timeout_' + var_transient.str())
			wp_prime_site_option_caches(rt.create_array([
				rt.ArrayItem{ key: none, val: var_transient_option },
				rt.ArrayItem{ key: none, val: var_transient_timeout },
			]))
			var_timeout = get_site_option(var_transient_timeout.clone(), false, false)
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_timeout))))
				&& rt.is_true(rt.less(var_timeout, rt.call_function('time', []rt.PhpVal{})))))
			{
				delete_site_option(var_transient_option.clone())
				delete_site_option(var_transient_timeout.clone())
				var_value = rt.new_bool(false)
			}
		}
		if !(!var_value.is_null()) {
			var_value = get_site_option(var_transient_option.clone(), false, false)
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('site_transient_${var_transient.to_string()}'),
		var_value.clone(),
		var_transient.clone(),
	])
}

fn set_site_transient(var_transient rt.PhpVal, var_value_arg rt.PhpVal, expiration i64) rt.PhpVal {
	mut var_expiration := expiration
	mut var_value := var_value_arg
	mut var_result := rt.new_null()
	mut var_transient_timeout := rt.new_null()
	mut var_option := rt.new_null()
	var_value = rt.call_function('apply_filters', [
		rt.new_string('pre_set_site_transient_${var_transient.to_string()}'),
		var_value.clone(),
		var_transient.clone(),
	])
	var_expiration = var_expiration
	var_expiration = (rt.call_function('apply_filters', [
		rt.new_string('expiration_of_site_transient_${var_transient.to_string()}'),
		rt.new_int(var_expiration),
		var_value.clone(),
		var_transient.clone(),
	])).to_i64()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))
	{
		var_result = rt.call_function('wp_cache_set', [var_transient.clone(),
			var_value.clone(), rt.new_string('site-transient'),
			rt.new_int(var_expiration)])
	} else {
		var_transient_timeout = rt.new_string('_site_transient_timeout_' + var_transient.str())
		var_option = rt.new_string('_site_transient_' + var_transient.str())
		wp_prime_site_option_caches(rt.create_array([
			rt.ArrayItem{ key: none, val: var_option },
			rt.ArrayItem{ key: none, val: var_transient_timeout },
		]))
		if rt.is_true(rt.identical(rt.new_bool(false), get_site_option(var_option.clone(), false,
			false)))
		{
			if var_expiration != 0 {
				add_site_option(var_transient_timeout.clone(), rt.add(rt.call_function('time',
					[]rt.PhpVal{}), rt.new_int(var_expiration)))
			}
			var_result = add_site_option(var_option.clone(), var_value.clone())
		} else {
			if var_expiration != 0 {
				update_site_option(var_transient_timeout.clone(), rt.add(rt.call_function('time',
					[]rt.PhpVal{}), rt.new_int(var_expiration)))
			}
			var_result = update_site_option(var_option.clone(), var_value.clone())
		}
	}
	if rt.is_true(var_result) {
		rt.call_function('do_action', [
			rt.new_string('set_site_transient_${var_transient.to_string()}'),
			var_value.clone(),
			rt.new_int(var_expiration),
			var_transient.clone(),
		])
		rt.call_function('do_action', [rt.new_string('set_site_transient'),
			var_transient.clone(), var_value.clone(), rt.new_int(var_expiration)])
		rt.call_function('do_action_deprecated', [rt.new_string('setted_site_transient'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_transient },
				rt.ArrayItem{ key: none, val: var_value }, rt.ArrayItem{
					key: none
					val: var_expiration
				}]),
			rt.new_string('6.8.0'), rt.new_string('set_site_transient')])
	}
	return var_result.clone()
}

fn register_initial_settings() {
	register_setting('general', 'blogname', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'title' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Title'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Site title.'),
		]) },
	]))
	register_setting('general', 'blogdescription', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'description' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Tagline'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Site tagline.'),
		]) },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		register_setting('general', 'siteurl', rt.create_array([
			rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'url' },
				rt.ArrayItem{ key: 'schema', val: rt.create_array([
					rt.ArrayItem{ key: 'format', val: 'uri' },
				]) },
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Site URL.'),
			]) },
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		register_setting('general', 'admin_email', rt.create_array([
			rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'email' },
				rt.ArrayItem{ key: 'schema', val: rt.create_array([
					rt.ArrayItem{ key: 'format', val: 'email' },
				]) },
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('This address is used for admin purposes, like new user notification.'),
			]) },
		]))
	}
	register_setting('general', 'timezone_string', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'timezone' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A city in the same timezone as you.'),
		]) },
	]))
	register_setting('general', 'date_format', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A date format for all date strings.'),
		]) },
	]))
	register_setting('general', 'time_format', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A time format for all time strings.'),
		]) },
	]))
	register_setting('general', 'start_of_week', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A day number of the week that the week should start on.'),
		]) },
	]))
	register_setting('general', 'WPLANG', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'language' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('WordPress locale code.'),
		]) },
		rt.ArrayItem{ key: 'default', val: 'en_US' },
	]))
	register_setting('writing', 'use_smilies', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Convert emoticons like :-) and :-P to graphics on display.'),
		]) },
		rt.ArrayItem{ key: 'default', val: true },
	]))
	register_setting('writing', 'default_category', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Default post category.'),
		]) },
	]))
	register_setting('writing', 'default_post_format', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Default post format.'),
		]) },
	]))
	register_setting('reading', 'posts_per_page', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Maximum posts per page'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Blog pages show at most.'),
		]) },
		rt.ArrayItem{ key: 'default', val: 10 },
	]))
	register_setting('reading', 'show_on_front', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Show on front'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('What to show on the front page'),
		]) },
	]))
	register_setting('reading', 'page_on_front', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Page on front'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The ID of the page that should be displayed on the front page'),
		]) },
	]))
	register_setting('reading', 'page_for_posts', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The ID of the page that should display the latest posts'),
		]) },
	]))
	register_setting('discussion', 'default_ping_status', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'open' },
					rt.ArrayItem{ key: none, val: 'closed' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Allow link notifications from other blogs (pingbacks and trackbacks) on new articles.'),
		]) },
	]))
	register_setting('discussion', 'default_comment_status', rt.create_array([
		rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'open' },
					rt.ArrayItem{ key: none, val: 'closed' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Allow comments on new posts'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Allow people to submit comments on new posts.'),
		]) },
	]))
}

fn register_setting(option_group string, option_name string, var_args_arg rt.PhpVal) {
	mut var_option_group := option_group
	mut var_option_name := option_name
	mut var_args := var_args_arg
	mut var_new_allowed_options := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_wp_registered_settings := rt.new_null()
	var_GLOBALS.array_get('new_whitelist_options') = var_new_allowed_options
	var_defaults = {
		'type':              rt.new_string('string')
		'group':             rt.new_string(var_option_group.str())
		'label':             rt.new_string('')
		'description':       rt.new_string('')
		'sanitize_callback': rt.new_null()
		'show_in_rest':      rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('is_callable', [var_args.clone()])) {
		var_args = rt.create_array([
			rt.ArrayItem{ key: 'sanitize_callback', val: var_args },
		])
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('register_setting_args'),
		var_args.clone(), rt.create_array_from_native_map(var_defaults),
		rt.new_string(var_option_group.str()), rt.new_string(option_name)])
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get('show_in_rest')))))
		&& rt.is_true(rt.identical(rt.new_string('array'), var_args.array_get('type')))))
		&& rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('show_in_rest').is_array())))))
		|| !(var_args.array_get('show_in_rest').array_get('schema').array_isset(rt.new_string('items')))))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('When registering an "array" setting to show in the REST API, you must specify the schema for each array item in "show_in_rest.schema.items".'),
			]),
			rt.new_string('5.4.0')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_registered_settings.clone().is_array()))))) {
		var_wp_registered_settings = rt.new_array()
	}
	if rt.is_true(rt.identical(rt.new_string('misc'), rt.new_string(var_option_group.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('misc'),
			])])
		var_option_group = 'general'
	}
	if rt.is_true(rt.identical(rt.new_string('privacy'), rt.new_string(var_option_group.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('privacy'),
			])])
		var_option_group = 'reading'
	}
	var_new_allowed_options.array_get_mut(var_option_group).array_push(option_name)
	if !(!rt.is_true(var_args.array_get('sanitize_callback'))) {
		rt.call_function('add_filter', [
			rt.new_string('sanitize_option_${var_option_name}'),
			var_args.array_get('sanitize_callback'),
		])
	}
	if rt.is_true(rt.new_bool(var_args.clone().array_isset(rt.new_string('default')))) {
		rt.call_function('add_filter', [
			rt.new_string('default_option_${var_option_name}'),
			rt.new_string('filter_default_option'),
			rt.new_int(10),
			rt.new_int(3),
		])
	}
	rt.call_function('do_action', [rt.new_string('register_setting'),
		rt.new_string(var_option_group.str()), rt.new_string(option_name),
		var_args.clone()])
	var_wp_registered_settings.array_set(option_name, var_args.clone())
}

fn unregister_setting(var_option_group_arg rt.PhpVal, var_option_name rt.PhpVal, deprecated string) {
	mut var_deprecated := deprecated
	mut var_option_group := var_option_group_arg
	mut var_new_allowed_options := rt.new_null()
	mut var_wp_registered_settings := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_pos := rt.new_null()
	var_GLOBALS.array_get('new_whitelist_options') = var_new_allowed_options
	if rt.is_true(rt.identical(rt.new_string('misc'), rt.new_string(var_option_group.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('misc'),
			])])
		var_option_group = 'general'
	}
	if rt.is_true(rt.identical(rt.new_string('privacy'), rt.new_string(var_option_group.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('privacy'),
			])])
		var_option_group = 'reading'
	}
	var_pos = rt.new_bool(false)
	if var_new_allowed_options.array_isset(rt.new_string(var_option_group.str())) {
		var_pos = rt.call_function('array_search', [var_option_name.clone(),
			rt.cast_array(var_new_allowed_options.array_get(var_option_group)),
			rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pos)))) {
		var_new_allowed_options.array_get(var_option_group).array_unset(var_pos)
	}
	if rt.is_true(rt.new_bool('' != deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('4.7.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s is deprecated. The callback from %2$s is used instead.'),
				]),
				rt.new_string('<code>$sanitize_callback</code>'),
				rt.new_string('<code>register_setting()</code>'),
			])])
		rt.call_function('remove_filter', [
			rt.new_string('sanitize_option_${var_option_name.to_string()}'),
			rt.new_string(deprecated),
		])
	}
	if var_wp_registered_settings.array_isset(var_option_name) {
		if !(!rt.is_true(var_wp_registered_settings.array_get(var_option_name).array_get('sanitize_callback'))) {
			rt.call_function('remove_filter', [
				rt.new_string('sanitize_option_${var_option_name.to_string()}'),
				var_wp_registered_settings.array_get(var_option_name).array_get('sanitize_callback'),
			])
		}
		if rt.is_true(rt.new_bool(var_wp_registered_settings.array_get(var_option_name).array_isset(rt.new_string('default')))) {
			rt.call_function('remove_filter', [
				rt.new_string('default_option_${var_option_name.to_string()}'),
				rt.new_string('filter_default_option'),
				rt.new_int(10),
			])
		}
		rt.call_function('do_action', [rt.new_string('unregister_setting'),
			rt.new_string(var_option_group.str()).clone(), var_option_name.clone()])
		var_wp_registered_settings.array_unset(var_option_name)
	}
}

fn get_registered_settings() rt.PhpVal {
	mut var_wp_registered_settings := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_registered_settings.clone().is_array()))))) {
		return rt.new_array()
	}
	return var_wp_registered_settings.clone()
}

fn filter_default_option(var_default_value rt.PhpVal, var_option rt.PhpVal, var_passed_default rt.PhpVal) rt.PhpVal {
	mut var_registered := rt.new_null()
	if rt.is_true(var_passed_default) {
		return var_default_value.clone()
	}
	var_registered = get_registered_settings()
	if !rt.is_true(var_registered.array_get(var_option)) {
		return var_default_value.clone()
	}
	return var_registered.array_get(var_option).array_get('default')
}

fn wp_autoload_values_to_autoload() rt.PhpVal {
	mut var_autoload_values := []rt.PhpVal{}
	mut var_filtered_values := rt.new_null()
	var_autoload_values = ['yes', 'on', 'auto-on', 'auto']
	var_filtered_values = rt.call_function('apply_filters', [
		rt.new_string('wp_autoload_values_to_autoload'),
		rt.create_array_from_list(var_autoload_values),
	])
	return rt.call_function('array_intersect', [var_filtered_values.clone(),
		rt.create_array_from_list(var_autoload_values)])
}

pub fn init_wp_includes_option_php() {
}
