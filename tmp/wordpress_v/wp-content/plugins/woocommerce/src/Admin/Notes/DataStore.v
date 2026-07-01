import rt

pub fn Class_Automattic_WooCommerce_Admin_Notes_DataStore.wc_admin_note_oper_global() string {
	return 'global'
}
struct Class_Automattic_WooCommerce_Admin_Notes_DataStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) create(var_note rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_date_created := rt.call_function('time', []rt.PhpVal{})
	rt.call_method(var_note, 'set_date_created', [var_date_created.dup()])
	// unsupported statement: Stmt_Global
	mut var_note_to_be_inserted := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_note, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_note, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'locale', val: rt.call_method(var_note, 'get_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'title', val: rt.call_method(var_note, 'get_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'content', val: rt.call_method(var_note, 'get_content', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_note, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'source', val: rt.call_method(var_note, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_snoozable', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'layout', val: rt.call_method(var_note, 'get_layout', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: rt.call_method(var_note, 'get_image', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_deleted', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'is_read', val: // unsupported expression: Expr_Cast_Int }])
	var_note_to_be_inserted.array_set('content_data', rt.call_function('wp_json_encode', [rt.call_method(var_note, 'get_content_data', []rt.PhpVal{})]))
	var_note_to_be_inserted.array_set('date_created', rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_date_created.dup()]))
	var_note_to_be_inserted.array_set('date_reminder', rt.new_null())
	rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_notes', var_note_to_be_inserted.dup()])
	mut var_note_id := rt.get_property(var_wpdb, 'insert_id')
	rt.call_method(var_note, 'set_id', [var_note_id.dup()])
	this.save_actions(var_note.dup())
	rt.call_method(var_note, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_note_created'), var_note_id.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) read(var_note rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_note, 'set_defaults', []rt.PhpVal{})
	mut var_note_row := rt.new_bool(rt.new_bool(false))
	mut var_note_id := rt.call_method(var_note, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_note_row = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_notes WHERE note_id = %d LIMIT 1')), rt.call_method(var_note, 'get_id', []rt.PhpVal{})])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_note, 'get_id', []rt.PhpVal{}))) || rt.is_true(rt.identical(rt.new_string('0'), rt.call_method(var_note, 'get_id', []rt.PhpVal{}))))) {
		this.read_actions(var_note.dup())
		rt.call_method(var_note, 'set_object_read', [rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_note_loaded'), var_note.dup()])
	} else if rt.is_true(var_note_row) {
		rt.call_method(var_note, 'set_name', [rt.get_property(var_note_row, 'name')])
		rt.call_method(var_note, 'set_type', [rt.get_property(var_note_row, 'type')])
		rt.call_method(var_note, 'set_locale', [rt.get_property(var_note_row, 'locale')])
		rt.call_method(var_note, 'set_title', [rt.get_property(var_note_row, 'title')])
		rt.call_method(var_note, 'set_content', [rt.get_property(var_note_row, 'content')])
		mut var_content_data := rt.call_function('json_decode', [rt.get_property(var_note_row, 'content_data')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_content_data)))) {
			var_content_data = create_automattic_woocommerce_admin_notes_stdclass()
		} else if rt.is_true(rt.new_bool(var_content_data.dup().is_array())) {
			var_content_data = // unsupported expression: Expr_Cast_Object
		}
		rt.call_method(var_note, 'set_content_data', [var_content_data.dup()])
		rt.call_method(var_note, 'set_status', [rt.get_property(var_note_row, 'status')])
		rt.call_method(var_note, 'set_source', [rt.get_property(var_note_row, 'source')])
		rt.call_method(var_note, 'set_date_created', [rt.get_property(var_note_row, 'date_created')])
		rt.call_method(var_note, 'set_date_reminder', [rt.get_property(var_note_row, 'date_reminder')])
		rt.call_method(var_note, 'set_is_snoozable', [// unsupported expression: Expr_Cast_Bool])
		rt.call_method(var_note, 'set_is_deleted', [// unsupported expression: Expr_Cast_Bool])
		rt.new_bool(!(rt.get_property(var_note_row, 'is_read')).is_null() && rt.is_true(rt.call_method(var_note, 'set_is_read', [// unsupported expression: Expr_Cast_Bool])))
		rt.call_method(var_note, 'set_layout', [rt.get_property(var_note_row, 'layout')])
		rt.call_method(var_note, 'set_image', [rt.get_property(var_note_row, 'image')])
		this.read_actions(var_note.dup())
		rt.call_method(var_note, 'set_object_read', [rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_note_loaded'), var_note.dup()])
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Notes_Exception', []string{}, create_automattic_woocommerce_admin_notes_exception(rt.call_function('__', [rt.new_string('Invalid admin note'), rt.new_string('woocommerce')]))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) update(var_note rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_method(var_note, 'get_id', []rt.PhpVal{})) {
		mut var_date_created := rt.call_method(var_note, 'get_date_created', []rt.PhpVal{})
		mut var_date_created_timestamp := rt.call_method(var_date_created, 'getTimestamp', []rt.PhpVal{})
		mut var_date_created_to_db := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_date_created_timestamp.dup()])
		mut var_date_reminder := rt.call_method(var_note, 'get_date_reminder', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_date_reminder.dup().is_null())) {
			mut var_date_reminder_to_db := rt.new_null()
		} else {
			mut var_date_reminder_timestamp := rt.call_method(var_date_reminder, 'getTimestamp', []rt.PhpVal{})
			var_date_reminder_to_db = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_date_reminder_timestamp.dup()])
		}
		rt.call_method(var_wpdb, 'update', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_notes', rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_note, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_note, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'locale', val: rt.call_method(var_note, 'get_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'title', val: rt.call_method(var_note, 'get_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'content', val: rt.call_method(var_note, 'get_content', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'content_data', val: rt.call_function('wp_json_encode', [rt.call_method(var_note, 'get_content_data', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_note, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'source', val: rt.call_method(var_note, 'get_source', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: var_date_created_to_db }, rt.ArrayItem{ key: 'date_reminder', val: var_date_reminder_to_db }, rt.ArrayItem{ key: 'is_snoozable', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'layout', val: rt.call_method(var_note, 'get_layout', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: rt.call_method(var_note, 'get_image', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_deleted', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'is_read', val: // unsupported expression: Expr_Cast_Int }]), rt.create_array([rt.ArrayItem{ key: 'note_id', val: rt.call_method(var_note, 'get_id', []rt.PhpVal{}) }])])
	}
	this.save_actions(var_note.dup())
	rt.call_method(var_note, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_note_updated'), rt.call_method(var_note, 'get_id', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) delete(var_note rt.PhpVal, var_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_note_id := rt.call_method(var_note, 'get_id', []rt.PhpVal{})
	if rt.is_true(var_note_id) {
		// unsupported statement: Stmt_Global
		rt.call_method(var_wpdb, 'delete', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_notes', rt.create_array([rt.ArrayItem{ key: 'note_id', val: var_note_id }])])
		rt.call_method(var_wpdb, 'delete', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_note_actions', rt.create_array([rt.ArrayItem{ key: 'note_id', val: var_note_id }])])
		rt.call_method(var_note, 'set_id', [rt.new_null()])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_note_deleted'), var_note_id.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) read_actions(var_note rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_db_actions := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT action_id, name, label, query, status, actioned_text, nonce_action, nonce_name\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_note_actions\n\t\t\t\tWHERE note_id = %d')), rt.call_method(var_note, 'get_id', []rt.PhpVal{})])])
	mut var_note_actions := rt.new_array()
	if rt.is_true(var_db_actions) {
		{
			mut iter_1 := var_db_actions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action := item_1.val
				var_note_actions.array_push(// unsupported expression: Expr_Cast_Object)
			}
		}
	}
	rt.call_method(var_note, 'set_actions', [var_note_actions.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) save_actions(var_note rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_changed_props := rt.func_array_keys(rt.call_method(var_note, 'get_changes', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('actions'), var_changed_props.dup(), rt.new_bool(true)]))))) {
		return false
	}
	mut var_changed_actions := rt.call_method(var_note, 'get_actions', [rt.new_string('edit')])
	mut var_actions_to_keep := rt.new_array()
	{
		mut iter_1 := var_changed_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			if !(!rt.is_true(rt.get_property(var_action, 'id'))) {
				var_actions_to_keep.array_push(// unsupported expression: Expr_Cast_Int)
			}
		}
	}
	mut var_clear_actions_query := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_note_actions WHERE note_id = %d')), rt.call_method(var_note, 'get_id', []rt.PhpVal{})])
	if rt.is_true(var_actions_to_keep) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_method(var_wpdb, 'query', [var_clear_actions_query.dup()])
	{
		mut iter_1 := var_changed_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			mut var_action_data := rt.create_array([rt.ArrayItem{ key: 'note_id', val: rt.call_method(var_note, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_action, 'name') }, rt.ArrayItem{ key: 'label', val: rt.get_property(var_action, 'label') }, rt.ArrayItem{ key: 'query', val: rt.get_property(var_action, 'query') }, rt.ArrayItem{ key: 'status', val: rt.get_property(var_action, 'status') }, rt.ArrayItem{ key: 'actioned_text', val: rt.get_property(var_action, 'actioned_text') }, rt.ArrayItem{ key: 'nonce_action', val: rt.get_property(var_action, 'nonce_action') }, rt.ArrayItem{ key: 'nonce_name', val: rt.get_property(var_action, 'nonce_name') }])
			mut var_data_format := rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])
			if !(!rt.is_true(rt.get_property(var_action, 'id'))) {
				var_action_data.array_set('action_id', rt.get_property(var_action, 'id'))
				var_data_format.array_push('%d')
			}
			rt.call_method(var_wpdb, 'replace', [(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_note_actions', var_action_data.dup(), var_data_format.dup()])
		}
	}
	this.read_actions(var_note.dup())
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes(var_args rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'per_page', val: rt.call_function('get_option', [rt.new_string('posts_per_page')]) }, rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'orderby', val: 'date_created' }])
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), var_defaults.dup()])
	mut var_offset := rt.mul(var_args_mutated.array_get('per_page'), rt.sub(var_args_mutated.array_get('page'), rt.new_int(1)))
	mut var_where_clauses := this.get_notes_where_clauses(var_args_mutated.dup(), var_context.dup())
	mut var_order_by := rt.new_string('`' + (rt.call_function('str_replace', [rt.new_string('`'), rt.new_string(''), var_args_mutated.array_get('orderby')])).str() + '`')
	mut var_order_dir := rt.new_string(if rt.is_true(rt.identical(rt.new_string('asc'), rt.new_string(var_args_mutated.array_get('order').to_string().to_lower()))) { rt.new_string('ASC') } else { rt.new_string('DESC') })
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_notes WHERE 1=1')), var_where_clauses), rt.new_string(' ORDER BY ')), var_order_by), rt.new_string(' ')), var_order_dir), rt.new_string(' LIMIT %d, %d')), var_offset.dup(), var_args_mutated.array_get('per_page')])
	return rt.call_method(var_wpdb, 'get_results', [var_query.dup()])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) lookup_notes(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	mut var_defaults := 
	
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes_count(var_type rt.PhpVal, var_status rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_escaped_arguments_array_by_key(var_args rt.PhpVal, key string, var_allowed_types rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_allowed_types_mutated := var_allowed_types
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes_where_clauses(var_args rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) args_to_where_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_notes_with_name(var_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_DataStore) get_note_ids_by_type(var_note_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
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

fn create_automattic_woocommerce_admin_notes_datastore() &Class_Automattic_WooCommerce_Admin_Notes_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_data_store_wp() &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_stdclass() &Class_Automattic_WooCommerce_Admin_Notes_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_exception() &Class_Automattic_WooCommerce_Admin_Notes_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Exception{
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
			return this.get_escaped_arguments_array_by_key(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_src_admin_notes_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
