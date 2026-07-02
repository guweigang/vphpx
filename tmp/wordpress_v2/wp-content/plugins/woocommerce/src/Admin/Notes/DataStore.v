import rt

pub fn Class_Automattic_WooCommerce_Admin_Notes_DataStore.wc_admin_note_oper_global() string {
	return 'global'
}

struct Class_Automattic_WooCommerce_Admin_Notes_DataStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) create(var_note rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_date_created := rt.call_function('time', []rt.PhpVal{})
	rt.call_method(var_note, 'set_date_created', [var_date_created.clone()])
	mut var_note_to_be_inserted := rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_note, 'get_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'type', val: rt.call_method(var_note, 'get_type', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'locale', val: rt.call_method(var_note, 'get_locale', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'title', val: rt.call_method(var_note, 'get_title', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'content', val: rt.call_method(var_note, 'get_content', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'status', val: rt.call_method(var_note, 'get_status', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'source', val: rt.call_method(var_note, 'get_source', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'is_snoozable', val: rt.new_int((rt.call_method(var_note,
			'get_is_snoozable', []rt.PhpVal{})).to_i64()) },
		rt.ArrayItem{ key: 'layout', val: rt.call_method(var_note, 'get_layout', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'image', val: rt.call_method(var_note, 'get_image', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'is_deleted', val: rt.new_int((rt.call_method(var_note,
			'get_is_deleted', []rt.PhpVal{})).to_i64()) },
		rt.ArrayItem{ key: 'is_read', val: rt.new_int((rt.call_method(var_note, 'get_is_read',
			[]rt.PhpVal{})).to_i64()) },
	])
	var_note_to_be_inserted.array_set('content_data', rt.call_function('wp_json_encode', [
		rt.call_method(var_note, 'get_content_data', []rt.PhpVal{}),
	]))
	var_note_to_be_inserted.array_set('date_created', rt.call_function('gmdate', [
		rt.new_string('Y-m-d H:i:s'),
		var_date_created.clone(),
	]))
	var_note_to_be_inserted.array_set('date_reminder', rt.new_null())
	rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_notes'),
		var_note_to_be_inserted.clone(),
	])
	mut var_note_id := rt.get_property(var_wpdb, 'insert_id')
	rt.call_method(var_note, 'set_id', [var_note_id.clone()])
	this.save_actions(var_note.clone())
	rt.call_method(var_note, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_note_created'),
		var_note_id.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) read(var_note rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_note, 'set_defaults', []rt.PhpVal{})
	mut var_note_row := rt.new_bool(false)
	mut var_note_id := rt.call_method(var_note, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_note_id))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), var_note_id)))) {
		var_note_row = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('wc_admin_notes WHERE note_id = %d LIMIT 1')),
				rt.call_method(var_note, 'get_id', []rt.PhpVal{}),
			]),
		])
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_note, 'get_id', []rt.PhpVal{})))
		|| rt.is_true(rt.identical(rt.new_string('0'), rt.call_method(var_note, 'get_id', []rt.PhpVal{}))) {
		this.read_actions(var_note.clone())
		rt.call_method(var_note, 'set_object_read', [rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_note_loaded'),
			var_note.clone()])
	} else if rt.is_true(var_note_row) {
		rt.call_method(var_note, 'set_name', [rt.get_property(var_note_row, 'name')])
		rt.call_method(var_note, 'set_type', [rt.get_property(var_note_row, 'type')])
		rt.call_method(var_note, 'set_locale', [rt.get_property(var_note_row, 'locale')])
		rt.call_method(var_note, 'set_title', [rt.get_property(var_note_row, 'title')])
		rt.call_method(var_note, 'set_content', [
			rt.get_property(var_note_row, 'content'),
		])
		mut var_content_data := rt.call_function('json_decode', [
			rt.get_property(var_note_row, 'content_data'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_content_data)))) {
			var_content_data = create_automattic_woocommerce_admin_notes_stdclass()
		} else if rt.is_true(rt.new_bool(var_content_data.clone().is_array())) {
			var_content_data = rt.array_to_object(var_content_data)
		}
		rt.call_method(var_note, 'set_content_data', [var_content_data.clone()])
		rt.call_method(var_note, 'set_status', [rt.get_property(var_note_row, 'status')])
		rt.call_method(var_note, 'set_source', [rt.get_property(var_note_row, 'source')])
		rt.call_method(var_note, 'set_date_created', [
			rt.get_property(var_note_row, 'date_created'),
		])
		rt.call_method(var_note, 'set_date_reminder', [
			rt.get_property(var_note_row, 'date_reminder'),
		])
		rt.call_method(var_note, 'set_is_snoozable', [
			rt.new_bool((rt.get_property(var_note_row, 'is_snoozable')).to_bool()),
		])
		rt.call_method(var_note, 'set_is_deleted', [
			rt.new_bool((rt.get_property(var_note_row, 'is_deleted')).to_bool()),
		])
		rt.new_bool(!(rt.get_property(var_note_row, 'is_read')).is_null()
			&& rt.is_true(rt.call_method(var_note, 'set_is_read', [rt.new_bool((rt.get_property(var_note_row, 'is_read')).to_bool())])))
		rt.call_method(var_note, 'set_layout', [rt.get_property(var_note_row, 'layout')])
		rt.call_method(var_note, 'set_image', [rt.get_property(var_note_row, 'image')])
		this.read_actions(var_note.clone())
		rt.call_method(var_note, 'set_object_read', [rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_note_loaded'),
			var_note.clone()])
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Notes_Exception',
			[]string{}, create_automattic_woocommerce_admin_notes_exception(rt.call_function('__', [
			rt.new_string('Invalid admin note'),
			rt.new_string('woocommerce'),
		]))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) update(var_note rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_method(var_note, 'get_id', []rt.PhpVal{})) {
		mut var_date_created := rt.call_method(var_note, 'get_date_created', []rt.PhpVal{})
		mut var_date_created_timestamp := rt.call_method(var_date_created, 'getTimestamp',
			[]rt.PhpVal{})
		mut var_date_created_to_db := rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			var_date_created_timestamp.clone(),
		])
		mut var_date_reminder := rt.call_method(var_note, 'get_date_reminder', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_date_reminder.clone().is_null())) {
			mut var_date_reminder_to_db := rt.new_null()
		} else {
			mut var_date_reminder_timestamp := rt.call_method(var_date_reminder, 'getTimestamp',
				[]rt.PhpVal{})
			var_date_reminder_to_db = rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				var_date_reminder_timestamp.clone(),
			])
		}
		rt.call_method(var_wpdb, 'update', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_notes'),
			rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_method(var_note, 'get_name', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'type', val: rt.call_method(var_note, 'get_type', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'locale', val: rt.call_method(var_note, 'get_locale',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'title', val: rt.call_method(var_note, 'get_title',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'content', val: rt.call_method(var_note, 'get_content',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'content_data', val: rt.call_function('wp_json_encode', [
					rt.call_method(var_note, 'get_content_data', []rt.PhpVal{}),
				]) },
				rt.ArrayItem{ key: 'status', val: rt.call_method(var_note, 'get_status',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'source', val: rt.call_method(var_note, 'get_source',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'date_created', val: var_date_created_to_db },
				rt.ArrayItem{ key: 'date_reminder', val: var_date_reminder_to_db },
				rt.ArrayItem{ key: 'is_snoozable', val: rt.new_int((rt.call_method(var_note,
					'get_is_snoozable', []rt.PhpVal{})).to_i64()) },
				rt.ArrayItem{ key: 'layout', val: rt.call_method(var_note, 'get_layout',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'image', val: rt.call_method(var_note, 'get_image',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'is_deleted', val: rt.new_int((rt.call_method(var_note,
					'get_is_deleted', []rt.PhpVal{})).to_i64()) },
				rt.ArrayItem{ key: 'is_read', val: rt.new_int((rt.call_method(var_note,
					'get_is_read', []rt.PhpVal{})).to_i64()) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'note_id', val: rt.call_method(var_note, 'get_id', []rt.PhpVal{}) },
			]),
		])
	}
	this.save_actions(var_note.clone())
	rt.call_method(var_note, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_note_updated'),
		rt.call_method(var_note, 'get_id', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) delete(var_note rt.PhpVal, var_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_note_id := rt.call_method(var_note, 'get_id', []rt.PhpVal{})
	if rt.is_true(var_note_id) {
		rt.call_method(var_wpdb, 'delete', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_notes'),
			rt.create_array([rt.ArrayItem{ key: 'note_id', val: var_note_id }]),
		])
		rt.call_method(var_wpdb, 'delete', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_note_actions'),
			rt.create_array([rt.ArrayItem{ key: 'note_id', val: var_note_id }]),
		])
		rt.call_method(var_note, 'set_id', [rt.new_null()])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_note_deleted'),
		var_note_id.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) read_actions(var_note rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_db_actions := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT action_id, name, label, query, status, actioned_text, nonce_action, nonce_name\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_admin_note_actions\n\t\t\t\tWHERE note_id = %d')),
			rt.call_method(var_note, 'get_id', []rt.PhpVal{}),
		]),
	])
	mut var_note_actions := rt.new_array()
	if rt.is_true(var_db_actions) {
		mut iter_1 := var_db_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			var_note_actions.array_push(rt.array_to_object(rt.create_array([
				rt.ArrayItem{
					key: 'id'
					val: rt.new_int((rt.get_property(var_action, 'action_id')).to_i64())
				},
				rt.ArrayItem{ key: 'name', val: rt.get_property(var_action, 'name') },
				rt.ArrayItem{ key: 'label', val: rt.get_property(var_action, 'label') },
				rt.ArrayItem{ key: 'query', val: rt.get_property(var_action, 'query') },
				rt.ArrayItem{ key: 'status', val: rt.get_property(var_action, 'status') },
				rt.ArrayItem{ key: 'actioned_text', val: rt.get_property(var_action,
					'actioned_text') },
				rt.ArrayItem{ key: 'nonce_action', val: rt.get_property(var_action, 'nonce_action') },
				rt.ArrayItem{ key: 'nonce_name', val: rt.get_property(var_action, 'nonce_name') },
			])))
		}
	}
	rt.call_method(var_note, 'set_actions', [var_note_actions.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) save_actions(var_note rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_changed_props := rt.func_array_keys(rt.call_method(var_note, 'get_changes',
		[]rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('actions'),
		var_changed_props.clone(),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	mut var_changed_actions := rt.call_method(var_note, 'get_actions', [
		rt.new_string('edit'),
	])
	mut var_actions_to_keep := rt.new_array()
	mut iter_2 := var_changed_actions.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_action := item_2.val
		if !(!rt.is_true(rt.get_property(var_action, 'id'))) {
			var_actions_to_keep.array_push(rt.new_int((rt.get_property(var_action, 'id')).to_i64()))
		}
	}
	mut var_clear_actions_query := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('wc_admin_note_actions WHERE note_id = %d')),
		rt.call_method(var_note, 'get_id', []rt.PhpVal{}),
	])
	if rt.is_true(var_actions_to_keep) {
		var_clear_actions_query = rt.concat(var_clear_actions_query, rt.call_function('sprintf', [
			rt.new_string(' AND action_id NOT IN (%s)'),
			rt.call_function('implode', [rt.new_string(','), var_actions_to_keep.clone()]),
		]))
	}
	rt.call_method(var_wpdb, 'query', [var_clear_actions_query.clone()])
	mut iter_3 := var_changed_actions.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_action := item_3.val
		mut var_action_data := rt.create_array([
			rt.ArrayItem{ key: 'note_id', val: rt.call_method(var_note, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_action, 'name') },
			rt.ArrayItem{ key: 'label', val: rt.get_property(var_action, 'label') },
			rt.ArrayItem{ key: 'query', val: rt.get_property(var_action, 'query') },
			rt.ArrayItem{ key: 'status', val: rt.get_property(var_action, 'status') },
			rt.ArrayItem{ key: 'actioned_text', val: rt.get_property(var_action, 'actioned_text') },
			rt.ArrayItem{ key: 'nonce_action', val: rt.get_property(var_action, 'nonce_action') },
			rt.ArrayItem{ key: 'nonce_name', val: rt.get_property(var_action, 'nonce_name') },
		])
		mut var_data_format := rt.create_array([rt.ArrayItem{ key: none, val: '%d' },
			rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' }])
		if !(!rt.is_true(rt.get_property(var_action, 'id'))) {
			var_action_data.array_set('action_id', rt.get_property(var_action, 'id'))
			var_data_format.array_push('%d')
		}
		rt.call_method(var_wpdb, 'replace', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_note_actions'),
			var_action_data.clone(),
			var_data_format.clone(),
		])
	}
	this.read_actions(var_note.clone())
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes(var_args rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'per_page', val: rt.call_function('get_option', [
			rt.new_string('posts_per_page'),
		]) },
		rt.ArrayItem{ key: 'page', val: 1 },
		rt.ArrayItem{ key: 'order', val: 'DESC' },
		rt.ArrayItem{ key: 'orderby', val: 'date_created' },
	])
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		var_defaults.clone()])
	mut var_offset := rt.mul(var_args_mutated.array_get(rt.new_string('per_page')), rt.sub(var_args_mutated.array_get(rt.new_string('page')),
		rt.new_int(1)))
	mut var_where_clauses := this.get_notes_where_clauses(var_args_mutated.clone(),
		var_context.clone())
	mut var_order_by := rt.new_string('`' +
		(rt.call_function('str_replace', [rt.new_string('`'), rt.new_string(''), var_args_mutated.array_get(rt.new_string('orderby'))])).str() +
		'`')
	mut var_order_dir := rt.new_string((if rt.is_true(rt.identical(rt.new_string('asc'),
		rt.new_string(var_args_mutated.array_get(rt.new_string('order')).to_string().to_lower())))
	{
		'ASC'
	} else {
		'DESC'
	}).str())
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_admin_notes WHERE 1=1')), var_where_clauses),
			rt.new_string(' ORDER BY ')), var_order_by), rt.new_string(' ')), var_order_dir),
			rt.new_string(' LIMIT %d, %d')),
		var_offset.clone(),
		var_args_mutated.array_get(rt.new_string('per_page')),
	])
	return rt.call_method(var_wpdb, 'get_results', [var_query.clone()])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) lookup_notes(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'order', val: 'DESC' },
		rt.ArrayItem{ key: 'orderby', val: 'date_created' }])
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		var_defaults.clone()])
	mut var_where_clauses := this.args_to_where_clauses(var_args_mutated.clone())
	mut var_order_by := rt.new_string('`' +
		(rt.call_function('str_replace', [rt.new_string('`'), rt.new_string(''), var_args_mutated.array_get(rt.new_string('orderby'))])).str() +
		'`')
	mut var_order_dir := rt.new_string((if rt.is_true(rt.identical(rt.new_string('asc'),
		rt.new_string(var_args_mutated.array_get(rt.new_string('order')).to_string().to_lower())))
	{
		'ASC'
	} else {
		'DESC'
	}).str())
	mut var_query := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
		'prefix')), rt.new_string('wc_admin_notes WHERE 1=1')), var_where_clauses),
		rt.new_string(' ORDER BY ')), var_order_by), rt.new_string(' ')), var_order_dir)).str())
	return rt.call_method(var_wpdb, 'get_results', [var_query.clone()])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes_count(var_type rt.PhpVal, var_status rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_where_clauses := this.get_notes_where_clauses(rt.create_array([
		rt.ArrayItem{ key: 'type', val: var_type },
		rt.ArrayItem{ key: 'status', val: var_status },
	]), var_context.clone())
	if !(!rt.is_true(var_where_clauses)) {
		return rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_admin_notes WHERE 1=1')), var_where_clauses),
		])
	}
	return rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_admin_notes')),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_escaped_arguments_array_by_key(var_args rt.PhpVal, key string, var_allowed_types rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_allowed_types_mutated := var_allowed_types
	mut var_arg_array := rt.new_array()
	if var_args_mutated.array_isset(rt.new_string(key)) {
		mut iter_4 := var_args_mutated.array_get(rt.new_string(key)).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_args_type := item_4.val
			var_args_type = rt.new_string(var_args_type.clone().to_string().trim_space())
			mut var_allowed := rt.new_bool(var_allowed_types_mutated.clone().is_null()
				|| rt.is_true(rt.call_function('in_array', [var_args_type.clone(), var_allowed_types_mutated.clone(), rt.new_bool(true)])))
			if rt.is_true(var_allowed) {
				var_arg_array.array_push(rt.call_function('sprintf', [
					rt.new_string("'%s'"),
					rt.call_function('esc_sql', [var_args_type.clone()]),
				]))
			}
		}
	}
	return var_arg_array.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes_where_clauses(var_args rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_where_clauses := this.args_to_where_clauses(var_args_mutated.clone())
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_note_where_clauses'),
		var_where_clauses.clone(),
		var_args_mutated.clone(),
		var_context.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) args_to_where_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Notes_Note{}
	mut iife_result_0 := iife_temp_0.get_allowed_types()
	mut var_allowed_types := iife_result_0
	mut var_where_type_array := this.get_escaped_arguments_array_by_key(var_args_mutated.clone(),
		'type', var_allowed_types.clone())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Notes_Note{}
	mut iife_result_1 := iife_temp_1.get_allowed_statuses()
	mut var_allowed_statuses := iife_result_1
	mut var_where_status_array := this.get_escaped_arguments_array_by_key(var_args_mutated.clone(),
		'status', var_allowed_statuses.clone())
	mut var_escaped_is_deleted := rt.new_string('')
	if var_args_mutated.array_isset(rt.new_string('is_deleted')) {
		var_escaped_is_deleted = rt.call_function('esc_sql', [
			var_args_mutated.array_get(rt.new_string('is_deleted')),
		])
	}
	mut var_where_name_array := this.get_escaped_arguments_array_by_key(var_args_mutated.clone(),
		'name', rt.new_null())
	mut var_where_excluded_name_array := this.get_escaped_arguments_array_by_key(var_args_mutated.clone(),
		'excluded_name', rt.new_null())
	mut var_where_source_array := this.get_escaped_arguments_array_by_key(var_args_mutated.clone(),
		'source', rt.new_null())
	mut var_escaped_where_types := rt.call_function('implode', [
		rt.new_string(','), var_where_type_array.clone()])
	mut var_escaped_where_status := rt.call_function('implode', [
		rt.new_string(','), var_where_status_array.clone()])
	mut var_escaped_where_names := rt.call_function('implode', [
		rt.new_string(','), var_where_name_array.clone()])
	mut var_escaped_where_excluded_names := rt.call_function('implode', [
		rt.new_string(','),
		var_where_excluded_name_array.clone(),
	])
	mut var_escaped_where_source := rt.call_function('implode', [
		rt.new_string(','), var_where_source_array.clone()])
	mut var_where_clauses := rt.new_string('')
	if !(!rt.is_true(var_escaped_where_types)) {
		var_where_clauses = rt.concat(var_where_clauses,
			rt.new_string(' AND type IN (${var_escaped_where_types.to_string()})'))
	}
	if !(!rt.is_true(var_escaped_where_status)) {
		var_where_clauses = rt.concat(var_where_clauses,
			rt.new_string(' AND status IN (${var_escaped_where_status.to_string()})'))
	}
	if !(!rt.is_true(var_escaped_where_names)) {
		var_where_clauses = rt.concat(var_where_clauses,
			rt.new_string(' AND name IN (${var_escaped_where_names.to_string()})'))
	}
	if !(!rt.is_true(var_escaped_where_excluded_names)) {
		var_where_clauses = rt.concat(var_where_clauses,
			rt.new_string(' AND name NOT IN (${var_escaped_where_excluded_names.to_string()})'))
	}
	if !(!rt.is_true(var_escaped_where_source)) {
		var_where_clauses = rt.concat(var_where_clauses,
			rt.new_string(' AND source IN (${var_escaped_where_source.to_string()})'))
	}
	if var_args_mutated.array_isset(rt.new_string('is_read')) {
		var_where_clauses = rt.concat(var_where_clauses, if rt.is_true(var_args_mutated.array_get(rt.new_string('is_read'))) {
			' AND is_read = 1'
		} else {
			' AND is_read = 0'
		})
	}
	var_where_clauses = rt.concat(var_where_clauses, if rt.is_true(var_escaped_is_deleted) {
		' AND is_deleted = 1'
	} else {
		' AND is_deleted = 0'
	})
	return var_where_clauses.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes_with_name(var_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT note_id FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_admin_notes WHERE name = %s ORDER BY note_id ASC')),
			var_name.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_note_ids_by_type(var_note_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT note_id FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_admin_notes WHERE type = %s ORDER BY note_id ASC')),
			var_note_type.clone(),
		]),
	])
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_notes_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_data_store_wp(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_stdclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'read_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'save_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.save_actions(dispatch_arg_0))
		}
		'get_notes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_notes(dispatch_arg_0, dispatch_arg_1)
		}
		'lookup_notes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.lookup_notes(dispatch_arg_0)
		}
		'get_notes_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_notes_count(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_escaped_arguments_array_by_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_escaped_arguments_array_by_key(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_notes_where_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_notes_where_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'args_to_where_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.args_to_where_clauses(dispatch_arg_0)
		}
		'get_notes_with_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_notes_with_name(dispatch_arg_0)
		}
		'get_note_ids_by_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_note_ids_by_type(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
