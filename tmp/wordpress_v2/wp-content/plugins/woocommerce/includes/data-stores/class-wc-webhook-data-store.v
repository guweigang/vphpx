import rt
import crypto.md5

struct Class_WC_Webhook_Data_Store {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Webhook_Data_Store) create(var_webhook rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_changes := rt.call_method(var_webhook, 'get_changes', []rt.PhpVal{})
	if var_changes.array_isset(rt.new_string('date_created')) {
		mut var_date_created := rt.call_method(rt.call_method(var_webhook, 'get_date_created',
			[]rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')])
		mut var_date_created_gmt := rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			rt.call_method(rt.call_method(var_webhook, 'get_date_created', []rt.PhpVal{}),
				'getTimestamp', []rt.PhpVal{}),
		])
	} else {
		var_date_created = rt.call_function('current_time', [
			rt.new_string('mysql')])
		var_date_created_gmt = rt.call_function('current_time', [
			rt.new_string('mysql'), rt.new_int(1)])
		rt.call_method(var_webhook, 'set_date_created', [var_date_created.clone()])
	}
	if !(var_changes.array_isset(rt.new_string('pending_delivery'))) {
		rt.call_method(var_webhook, 'set_pending_delivery', [
			rt.new_bool(true)])
	}
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_method(var_webhook, 'get_status', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_webhook, 'get_name', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'user_id', val: rt.call_method(var_webhook, 'get_user_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'delivery_url', val: rt.call_method(var_webhook, 'get_delivery_url', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'secret', val: rt.call_method(var_webhook, 'get_secret', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'topic', val: rt.call_method(var_webhook, 'get_topic', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'date_created', val: var_date_created },
		rt.ArrayItem{ key: 'date_created_gmt', val: var_date_created_gmt },
		rt.ArrayItem{ key: 'api_version', val: this.get_api_version_number(rt.call_method(var_webhook,
			'get_api_version', [
			rt.new_string('edit'),
		])) },
		rt.ArrayItem{ key: 'failure_count', val: rt.call_method(var_webhook, 'get_failure_count', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'pending_delivery', val: rt.call_method(var_webhook,
			'get_pending_delivery', [
			rt.new_string('edit'),
		]) },
	])
	rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_webhooks'),
		var_data.clone(),
	])
	mut var_webhook_id := rt.get_property(var_wpdb, 'insert_id')
	rt.call_method(var_webhook, 'set_id', [var_webhook_id.clone()])
	rt.call_method(var_webhook, 'apply_changes', []rt.PhpVal{})
	this.delete_transients((rt.call_method(var_webhook, 'get_status', [
		rt.new_string('edit'),
	])).str())
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.invalidate_cache_group(rt.new_string('webhooks'))
	rt.call_function('do_action', [rt.new_string('woocommerce_new_webhook'),
		var_webhook_id.clone(), var_webhook.clone()])
}

fn (mut this Class_WC_Webhook_Data_Store) read(var_webhook rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.call_function('wp_cache_get', [
		rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}),
		rt.new_string('webhooks'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_data)) {
		var_data = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT webhook_id, status, name, user_id, delivery_url, secret, topic, date_created, date_modified, api_version, failure_count, pending_delivery FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('wc_webhooks WHERE webhook_id = %d LIMIT 1;')),
				rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}),
			]),
			rt.get_constant('ARRAY_A'),
		])
		rt.call_function('wp_cache_add', [
			rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}),
			var_data.clone(),
			rt.new_string('webhooks'),
		])
	}
	if rt.is_true(rt.new_bool(var_data.clone().is_array())) {
		rt.call_method(var_webhook, 'set_props', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: var_data.array_get(rt.new_string('webhook_id')) },
				rt.ArrayItem{ key: 'status', val: var_data.array_get(rt.new_string('status')) },
				rt.ArrayItem{ key: 'name', val: var_data.array_get(rt.new_string('name')) },
				rt.ArrayItem{ key: 'user_id', val: var_data.array_get(rt.new_string('user_id')) },
				rt.ArrayItem{
					key: 'delivery_url'
					val: var_data.array_get(rt.new_string('delivery_url'))
				},
				rt.ArrayItem{ key: 'secret', val: var_data.array_get(rt.new_string('secret')) },
				rt.ArrayItem{ key: 'topic', val: var_data.array_get(rt.new_string('topic')) },
				rt.ArrayItem{
					key: 'date_created'
					val: if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'),
						var_data.array_get(rt.new_string('date_created'))))
					{
						rt.new_null()
					} else {
						var_data.array_get(rt.new_string('date_created'))
					}
				},
				rt.ArrayItem{
					key: 'date_modified'
					val: if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'),
						var_data.array_get(rt.new_string('date_modified'))))
					{
						rt.new_null()
					} else {
						var_data.array_get(rt.new_string('date_modified'))
					}
				},
				rt.ArrayItem{
					key: 'api_version'
					val: var_data.array_get(rt.new_string('api_version'))
				},
				rt.ArrayItem{
					key: 'failure_count'
					val: var_data.array_get(rt.new_string('failure_count'))
				},
				rt.ArrayItem{
					key: 'pending_delivery'
					val: var_data.array_get(rt.new_string('pending_delivery'))
				},
			]),
		])
		rt.call_method(var_webhook, 'set_object_read', [rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_webhook_loaded'),
			var_webhook.clone()])
	} else {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid webhook.'),
			rt.new_string('woocommerce'),
		]))))
	}
}

fn (mut this Class_WC_Webhook_Data_Store) update(var_webhook rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_changes := rt.call_method(var_webhook, 'get_changes', []rt.PhpVal{})
	mut var_trigger := rt.new_bool(var_changes.array_isset(rt.new_string('delivery_url')))
	if var_changes.array_isset(rt.new_string('date_modified')) {
		mut var_date_modified := rt.call_method(rt.call_method(var_webhook, 'get_date_modified',
			[]rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')])
		mut var_date_modified_gmt := rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			rt.call_method(rt.call_method(var_webhook, 'get_date_modified', []rt.PhpVal{}),
				'getTimestamp', []rt.PhpVal{}),
		])
	} else {
		var_date_modified = rt.call_function('current_time', [
			rt.new_string('mysql')])
		var_date_modified_gmt = rt.call_function('current_time', [
			rt.new_string('mysql'), rt.new_int(1)])
		rt.call_method(var_webhook, 'set_date_modified', [var_date_modified.clone()])
	}
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_method(var_webhook, 'get_status', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_webhook, 'get_name', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'user_id', val: rt.call_method(var_webhook, 'get_user_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'delivery_url', val: rt.call_method(var_webhook, 'get_delivery_url', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'secret', val: rt.call_method(var_webhook, 'get_secret', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'topic', val: rt.call_method(var_webhook, 'get_topic', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'date_modified', val: var_date_modified },
		rt.ArrayItem{ key: 'date_modified_gmt', val: var_date_modified_gmt },
		rt.ArrayItem{ key: 'api_version', val: this.get_api_version_number(rt.call_method(var_webhook,
			'get_api_version', [
			rt.new_string('edit'),
		])) },
		rt.ArrayItem{ key: 'failure_count', val: rt.call_method(var_webhook, 'get_failure_count', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'pending_delivery', val: rt.call_method(var_webhook,
			'get_pending_delivery', [
			rt.new_string('edit'),
		]) },
	])
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_webhooks'),
		var_data.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'webhook_id', val: rt.call_method(var_webhook, 'get_id',
				[]rt.PhpVal{}) },
		]),
	])
	rt.call_method(var_webhook, 'apply_changes', []rt.PhpVal{})
	if var_changes.array_isset(rt.new_string('status')) {
		this.delete_transients('all')
	}
	rt.call_function('wp_cache_delete', [
		rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}),
		rt.new_string('webhooks'),
	])
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 := iife_temp_1.invalidate_cache_group(rt.new_string('webhooks'))
	if rt.is_true(rt.identical(rt.new_string('active'), rt.call_method(var_webhook, 'get_status', []rt.PhpVal{})))
		&& rt.is_true(var_trigger)
		|| rt.is_true(rt.call_method(var_webhook, 'get_pending_delivery', []rt.PhpVal{})) {
		rt.call_method(var_webhook, 'deliver_ping', []rt.PhpVal{})
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_webhook_updated'),
		rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})])
}

fn (mut this Class_WC_Webhook_Data_Store) delete(var_webhook rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'delete', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_webhooks'),
		rt.create_array([
			rt.ArrayItem{ key: 'webhook_id', val: rt.call_method(var_webhook, 'get_id',
				[]rt.PhpVal{}) },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%d' },
		]),
	])
	this.delete_transients('all')
	rt.call_function('wp_cache_delete', [
		rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}),
		rt.new_string('webhooks'),
	])
	mut iife_temp_2 := Class_WC_Cache_Helper{}
	mut iife_result_2 := iife_temp_2.invalidate_cache_group(rt.new_string('webhooks'))
	rt.call_function('do_action', [rt.new_string('woocommerce_webhook_deleted'),
		rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}),
		var_webhook.clone()])
}

fn (mut this Class_WC_Webhook_Data_Store) get_api_version_number(var_api_version rt.PhpVal) i64 {
	mut var_api_version_mutated := var_api_version
	return if rt.is_true(rt.identical(rt.new_string('legacy_v3'), var_api_version_mutated)) { -1 } else { rt.call_function('substr', [
			var_api_version_mutated.clone(),
			rt.new_int(-1),
		]).to_i64() }
}

fn (mut this Class_WC_Webhook_Data_Store) get_webhooks_ids(status string) rt.PhpVal {
	mut status_mutated := status
	if !(status_mutated == '') {
		this.validate_status(rt.new_string(status_mutated))
	}
	mut var_ids := rt.call_function('get_transient', [
		this.get_transient_key(status_mutated),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_ids)) {
		var_ids = this.search_webhooks(rt.create_array([
			rt.ArrayItem{ key: 'limit', val: -1 },
			rt.ArrayItem{ key: 'status', val: status_mutated },
		]))
		var_ids = rt.call_function('array_map', [rt.new_string('absint'),
			var_ids.clone()])
		rt.call_function('set_transient', [this.get_transient_key(status_mutated),
			var_ids.clone()])
	}
	return var_ids.clone()
}

fn (mut this Class_WC_Webhook_Data_Store) search_webhooks(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'limit', val: 10 },
			rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'order', val: 'DESC' },
			rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'paginate', val: false }])])
	mut var_statuses := rt.create_array([rt.ArrayItem{ key: 'publish', val: 'active' },
		rt.ArrayItem{ key: 'draft', val: 'paused' }, rt.ArrayItem{ key: 'pending', val: 'disabled' }])
	mut var_orderby_mapping := {
		'ID':            'webhook_id'
		'id':            'webhook_id'
		'name':          'name'
		'title':         'name'
		'post_title':    'name'
		'post_name':     'name'
		'date_created':  'date_created_gmt'
		'date':          'date_created_gmt'
		'post_date':     'date_created_gmt'
		'date_modified': 'date_modified_gmt'
		'modified':      'date_modified_gmt'
		'post_modified': 'date_modified_gmt'
	}
	mut var_orderby := rt.new_string((if var_orderby_mapping.array_isset(var_args_mutated.array_get(rt.new_string('orderby'))) {
		var_orderby_mapping[var_args_mutated.array_get(rt.new_string('orderby'))]
	} else {
		'webhook_id'
	}).str())
	mut var_sort := rt.new_string((if rt.is_true(rt.identical(rt.new_string('ASC'),
		rt.new_string(var_args_mutated.array_get(rt.new_string('order')).to_string().to_upper())))
	{
		'ASC'
	} else {
		'DESC'
	}).str())
	mut var_order := rt.new_string('ORDER BY ${var_orderby.to_string()} ${var_sort.to_string()}')
	mut var_limit := if rt.is_true(rt.less(-1, var_args_mutated.array_get(rt.new_string('limit')))) { rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('LIMIT %d'),
			var_args_mutated.array_get(rt.new_string('limit')),
		]) } else { rt.new_string('') }
	mut var_offset := if rt.is_true(rt.less(rt.new_int(0), var_args_mutated.array_get(rt.new_string('offset')))) { rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('OFFSET %d'),
			var_args_mutated.array_get(rt.new_string('offset')),
		]) } else { rt.new_string('') }
	mut var_status := if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('status')))) { rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND `status` = %s'),
			if var_statuses.array_isset(var_args_mutated.array_get(rt.new_string('status'))) {
				var_statuses.array_get(var_args_mutated.array_get(rt.new_string('status')))
			} else {
				var_args_mutated.array_get(rt.new_string('status'))
			},
		])
	 } else { rt.new_string('')
	 }
	mut var_search := if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('search')))) { rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND `name` LIKE %s'),
			rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [rt.call_function('sanitize_text_field', [var_args_mutated.array_get(rt.new_string('search'))])])).str() + '%'),
		]) } else { rt.new_string('') }
	mut var_include := rt.new_string('')
	mut var_exclude := rt.new_string('')
	mut var_date_created := rt.new_string('')
	mut var_date_modified := rt.new_string('')
	mut var_user_id := rt.new_string('')
	mut var_api_version := rt.new_string('')
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('include')))) {
		var_args_mutated.array_set('include', rt.call_function('implode', [
			rt.new_string(','),
			rt.call_function('wp_parse_id_list',
				[var_args_mutated.array_get(rt.new_string('include'))]),
		]))
		var_include = rt.new_string(
			'AND webhook_id IN (' + (var_args_mutated.array_get(rt.new_string('include'))).str() + ')')
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('exclude')))) {
		var_args_mutated.array_set('exclude', rt.call_function('implode', [
			rt.new_string(','),
			rt.call_function('wp_parse_id_list',
				[var_args_mutated.array_get(rt.new_string('exclude'))]),
		]))
		var_exclude = rt.new_string(
			'AND webhook_id NOT IN (' + (var_args_mutated.array_get(rt.new_string('exclude'))).str() + ')')
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('user_id')))) {
		var_user_id = rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('AND `user_id` = %d'),
			rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('user_id'))]),
		])
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('after'))))
		|| !(!rt.is_true(var_args_mutated.array_get(rt.new_string('before')))) {
		var_args_mutated.array_set('after', if !rt.is_true(var_args_mutated.array_get(rt.new_string('after'))) {
			rt.new_string('0000-00-00')
		} else {
			var_args_mutated.array_get(rt.new_string('after'))
		})
		var_args_mutated.array_set('before', if !rt.is_true(var_args_mutated.array_get(rt.new_string('before'))) { rt.call_function('current_time', [
				rt.new_string('mysql'),
				rt.new_int(1),
			]) } else { var_args_mutated.array_get(rt.new_string('before')) })
		var_date_created = rt.new_string("AND `date_created_gmt` BETWEEN STR_TO_DATE('" +
			(rt.call_function('esc_sql', [var_args_mutated.array_get(rt.new_string('after'))])).str() +
			"', '%Y-%m-%d %H:%i:%s') and STR_TO_DATE('" +
			(rt.call_function('esc_sql', [var_args_mutated.array_get(rt.new_string('before'))])).str() +
			"', '%Y-%m-%d %H:%i:%s')")
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('modified_after'))))
		|| !(!rt.is_true(var_args_mutated.array_get(rt.new_string('modified_before')))) {
		var_args_mutated.array_set('modified_after', if !rt.is_true(var_args_mutated.array_get(rt.new_string('modified_after'))) {
			rt.new_string('0000-00-00')
		} else {
			var_args_mutated.array_get(rt.new_string('modified_after'))
		})
		var_args_mutated.array_set('modified_before', if !rt.is_true(var_args_mutated.array_get(rt.new_string('modified_before'))) { rt.call_function('current_time', [
				rt.new_string('mysql'),
				rt.new_int(1),
			]) } else { var_args_mutated.array_get(rt.new_string('modified_before')) })
		var_date_modified = rt.new_string("AND `date_modified_gmt` BETWEEN STR_TO_DATE('" +
			(rt.call_function('esc_sql', [var_args_mutated.array_get(rt.new_string('modified_after'))])).str() +
			"', '%Y-%m-%d %H:%i:%s') and STR_TO_DATE('" +
			(rt.call_function('esc_sql', [var_args_mutated.array_get(rt.new_string('modified_before'))])).str() +
			"', '%Y-%m-%d %H:%i:%s')")
	}
	mut var_api_version_value := if !(var_args_mutated.array_get(rt.new_string('api_version'))).is_null() {
		var_args_mutated.array_get(rt.new_string('api_version'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_api_version_value.clone().is_long()
		|| var_api_version_value.clone().is_double()))
	{
		var_api_version = rt.new_string('AND `api_version`=' +
			(rt.call_function('esc_sql', [var_api_version_value.clone()])).str())
	}
	mut iife_temp_3 := Class_WC_Cache_Helper{}
	mut iife_result_3 := iife_temp_3.get_cache_prefix(rt.new_string('webhooks'))
	mut var_cache_key := rt.new_string(iife_result_3.str() + 'search_webhooks' +
		md5.hexhash(rt.call_function('implode', [rt.new_string(','), var_args_mutated.clone()]).to_string()))
	mut var_cache_value := rt.call_function('wp_cache_get', [
		var_cache_key.clone(), rt.new_string('webhook_search_results')])
	if rt.is_true(var_cache_value) {
		return var_cache_value.clone()
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('paginate'))) {
		mut var_query := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT SQL_CALC_FOUND_ROWS webhook_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_webhooks\n\t\t\t\tWHERE 1=1\n\t\t\t\t')), var_status),
			rt.new_string('\n\t\t\t\t')), var_search), rt.new_string('\n\t\t\t\t')), var_include),
			rt.new_string('\n\t\t\t\t')), var_exclude), rt.new_string('\n\t\t\t\t')),
			var_date_created), rt.new_string('\n\t\t\t\t')), var_date_modified),
			rt.new_string('\n\t\t\t\t')), var_api_version), rt.new_string('\n\t\t\t\t')),
			var_user_id), rt.new_string('\n\t\t\t\t')), var_order), rt.new_string('\n\t\t\t\t')),
			var_limit), rt.new_string('\n\t\t\t\t')), var_offset).trim_space())
		mut var_webhook_ids := rt.call_function('wp_parse_id_list', [
			rt.call_method(var_wpdb, 'get_col', [var_query.clone()]),
		])
		mut var_total := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.new_string('SELECT FOUND_ROWS();'),
		])).to_i64())
		mut var_return_value := rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'webhooks', val: var_webhook_ids },
			rt.ArrayItem{ key: 'total', val: var_total },
			rt.ArrayItem{
				key: 'max_num_pages'
				val: if rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('limit')), rt.new_int(1))) { rt.call_function('ceil', [
						rt.div(var_total, var_args_mutated.array_get(rt.new_string('limit'))),
					]) } else { rt.new_int(1) }
			},
		]))
	} else {
		var_query = rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT webhook_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_webhooks\n\t\t\t\tWHERE 1=1\n\t\t\t\t')), var_status),
			rt.new_string('\n\t\t\t\t')), var_search), rt.new_string('\n\t\t\t\t')), var_include),
			rt.new_string('\n\t\t\t\t')), var_exclude), rt.new_string('\n\t\t\t\t')),
			var_date_created), rt.new_string('\n\t\t\t\t')), var_date_modified),
			rt.new_string('\n\t\t\t\t')), var_user_id), rt.new_string('\n\t\t\t\t')), var_order),
			rt.new_string('\n\t\t\t\t')), var_limit), rt.new_string('\n\t\t\t\t')), var_offset).trim_space())
		var_webhook_ids = rt.call_function('wp_parse_id_list', [
			rt.call_method(var_wpdb, 'get_col', [var_query.clone()]),
		])
		var_return_value = var_webhook_ids.clone()
	}
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_return_value.clone(),
		rt.new_string('webhook_search_results')])
	return var_return_value.clone()
}

fn (mut this Class_WC_Webhook_Data_Store) get_webhook_count(status string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut status_mutated := status
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.get_cache_prefix(rt.new_string('webhooks'))
	mut var_cache_key := rt.new_string(iife_result_4.str() + status_mutated + '_count')
	mut var_count := rt.call_function('wp_cache_get', [var_cache_key.clone(),
		rt.new_string('webhooks')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
		var_count = rt.call_function('absint', [
			rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT count( webhook_id ) FROM '), rt.get_property(var_wpdb,
						'prefix')), rt.new_string('wc_webhooks WHERE `status` = %s;')),
					rt.new_string(status_mutated).clone(),
				]),
			]),
		])
		rt.call_function('wp_cache_add', [var_cache_key.clone(),
			var_count.clone(), rt.new_string('webhooks')])
	}
	return var_count.clone()
}

fn (mut this Class_WC_Webhook_Data_Store) get_count_webhooks_by_status() rt.PhpVal {
	mut var_statuses := rt.func_array_keys(rt.call_function('wc_get_webhook_statuses',
		[]rt.PhpVal{}))
	mut var_counts := rt.new_array()
	mut iter_1 := var_statuses.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_status := item_1.val
		var_counts.array_set(var_status, this.get_webhook_count(var_status.str()))
	}
	return var_counts.clone()
}

fn (mut this Class_WC_Webhook_Data_Store) validate_status(var_status rt.PhpVal) {
	mut var_status_mutated := var_status
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('wc_get_webhook_statuses',
		[]rt.PhpVal{}).array_isset(var_status_mutated.clone()))))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('Invalid status given: %s. Status must be one of: %s.'),
			var_status_mutated.clone(),
			rt.call_function('implode', [rt.new_string(', '),
				rt.func_array_keys(rt.call_function('wc_get_webhook_statuses', []rt.PhpVal{}))]),
		]))))
	}
}

fn (mut this Class_WC_Webhook_Data_Store) get_transient_key(status string) rt.PhpVal {
	mut status_mutated := status
	return if status_mutated == '' { rt.new_string('woocommerce_webhook_ids') } else { rt.call_function('sprintf', [
			rt.new_string('woocommerce_webhook_ids_status_%s'),
			rt.new_string(status_mutated).clone(),
		]) }
}

fn (mut this Class_WC_Webhook_Data_Store) delete_transients(status string) {
	mut status_mutated := status
	rt.call_function('delete_transient', [this.get_transient_key('')])
	if !(status_mutated == '') {
		if rt.is_true(rt.identical(rt.new_string('all'), rt.new_string(status_mutated))) {
			mut iter_2 := rt.call_function('wc_get_webhook_statuses', []rt.PhpVal{}).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_status_string := item_2.val
				mut var_status_key := item_2.key
				rt.call_function('delete_transient', [
					this.get_transient_key(var_status_key.str()),
				])
			}
		} else {
			rt.call_function('delete_transient', [this.get_transient_key(status_mutated)])
		}
	}
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
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

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_wc_webhook_data_store(_args ...rt.PhpVal) &Class_WC_Webhook_Data_Store {
	mut obj := &Class_WC_Webhook_Data_Store{
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

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Webhook_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			this.delete(dispatch_arg_0)
			return rt.new_null()
		}
		'get_api_version_number' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_api_version_number(dispatch_arg_0))
		}
		'get_webhooks_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_webhooks_ids(dispatch_arg_0)
		}
		'search_webhooks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.search_webhooks(dispatch_arg_0)
		}
		'get_webhook_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_webhook_count(dispatch_arg_0)
		}
		'get_count_webhooks_by_status' {
			return this.get_count_webhooks_by_status()
		}
		'validate_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.validate_status(dispatch_arg_0)
			return rt.new_null()
		}
		'get_transient_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_transient_key(dispatch_arg_0)
		}
		'delete_transients' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.delete_transients(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Webhook_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Webhook_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
