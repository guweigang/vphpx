import rt
import crypto.md5

pub fn Class_WP_Sync_Post_Meta_Storage.post_type() string {
	return 'wp_sync_storage'
}
pub fn Class_WP_Sync_Post_Meta_Storage.awareness_meta_key() string {
	return 'wp_sync_awareness_state'
}
pub fn Class_WP_Sync_Post_Meta_Storage.sync_update_meta_key() string {
	return 'wp_sync_update_data'
}
struct Class_WP_Sync_Post_Meta_Storage {
	rt.PhpObjectBase
pub mut:
		room_cursors rt.PhpVal = rt.new_array()
		room_update_counts rt.PhpVal = rt.new_array()
		storage_post_ids rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) add_update(room string, var_update rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_post_id := rt.new_int(this.get_storage_post_id(room))
	if rt.is_true(rt.identical(rt.new_null(), var_post_id)) {
		return false
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) get_awareness_state(room string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_post_id := rt.new_int(this.get_storage_post_id(room))
	if rt.is_true(rt.identical(rt.new_null(), var_post_id)) {
		return rt.new_array()
	}
	mut var_meta_value := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = %s ORDER BY meta_id DESC LIMIT 1')), var_post_id.dup(), Class_WP_Sync_Post_Meta_Storage.awareness_meta_key()])])
	if rt.is_true(rt.identical(rt.new_null(), var_meta_value)) {
		return rt.new_array()
	}
	mut var_awareness := rt.call_function('json_decode', [var_meta_value.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_awareness.dup().is_array()))))) {
		return rt.new_array()
	}
	return rt.call_function('array_values', [var_awareness.dup()])
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) set_awareness_state(room string, mut var_awareness Class_array) bool {
	mut var_wpdb := rt.new_null()
	mut var_awareness_mutated := var_awareness
	// unsupported statement: Stmt_Global
	mut var_post_id := rt.new_int(this.get_storage_post_id(room))
	if rt.is_true(rt.identical(rt.new_null(), var_post_id)) {
		return false
	}
	mut var_meta_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = %s ORDER BY meta_id DESC LIMIT 1')), var_post_id.dup(), Class_WP_Sync_Post_Meta_Storage.awareness_meta_key()])])
	if rt.is_true(var_meta_id) {
		return (// unsupported expression: Expr_Cast_Bool).to_bool()
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) get_cursor(room string) i64 {
	return (if !(this.room_cursors.array_get(room)).is_null() { this.room_cursors.array_get(room) } else { rt.new_int(0) }).to_i64()
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) get_storage_post_id(room string) i64 {
	mut var_room_hash := rt.new_string(rt.new_string(md5.hexhash(room)))
	if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_room_hash) {
		return (// unsupported expression: Expr_StaticPropertyFetch.array_get(var_room_hash)).to_i64()
	}
	mut var_posts := rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_WP_Sync_Post_Meta_Storage.post_type() }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'name', val: var_room_hash }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'orderby', val: 'ID' }, rt.ArrayItem{ key: 'order', val: 'ASC' }])])
	mut var_post_id := rt.call_function('array_first', [var_posts.dup()])
	if rt.is_true(rt.new_bool(var_post_id.dup().is_long())) {
		// unsupported expression: Expr_StaticPropertyFetch.array_set(var_room_hash, var_post_id.dup())
		return (var_post_id).to_i64()
	}
	var_post_id = rt.call_function('wp_insert_post', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_WP_Sync_Post_Meta_Storage.post_type() }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_title', val: 'Sync Storage' }, rt.ArrayItem{ key: 'post_name', val: var_room_hash }])])
	if rt.is_true(rt.new_bool(var_post_id.dup().is_long())) {
		// unsupported expression: Expr_StaticPropertyFetch.array_set(var_room_hash, var_post_id.dup())
		return (var_post_id).to_i64()
	}
	return (rt.new_null()).to_i64()
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) get_update_count(room string) i64 {
	return (if !(this.room_update_counts.array_get(room)).is_null() { this.room_update_counts.array_get(room) } else { rt.new_int(0) }).to_i64()
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) get_updates_after_cursor(room string, cursor i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_post_id := rt.new_int(this.get_storage_post_id(room))
	if rt.is_true(rt.identical(rt.new_null(), var_post_id)) {
		this.room_cursors.array_set(room, 0)
		this.room_update_counts.array_set(room, 0)
		return rt.new_array()
	}
	mut var_stats := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) AS total_updates, COALESCE( MAX(meta_id), 0 ) AS max_meta_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = %s')), var_post_id.dup(), Class_WP_Sync_Post_Meta_Storage.sync_update_meta_key()])])
	mut var_total_updates := if rt.is_true(var_stats) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_max_meta_id := if rt.is_true(var_stats) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	this.room_update_counts.array_set(room, var_total_updates.dup())
	this.room_cursors.array_set(room, var_max_meta_id.dup())
	if rt.is_true(rt.less_equal(var_max_meta_id, rt.new_int(cursor))) {
		return rt.new_array()
	}
	mut var_rows := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = %s AND meta_id > %d AND meta_id <= %d ORDER BY meta_id ASC')), var_post_id.dup(), Class_WP_Sync_Post_Meta_Storage.sync_update_meta_key(), rt.new_int(cursor), var_max_meta_id.dup()])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_rows)))) {
		return rt.new_array()
	}
	mut var_updates := rt.new_array()
	{
		mut iter_1 := var_rows.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row := item_1.val
			mut var_decoded := rt.call_function('json_decode', [rt.get_property(var_row, 'meta_value'), rt.new_bool(true)])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_updates << var_decoded.dup()
			}
		}
	}
	return var_updates.dup()
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) remove_updates_before_cursor(room string, cursor i64) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_post_id := rt.new_int(this.get_storage_post_id(room))
	if rt.is_true(rt.identical(rt.new_null(), var_post_id)) {
		return false
	}
	mut var_deleted_rows := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d AND meta_key = %s AND meta_id < %d')), var_post_id.dup(), Class_WP_Sync_Post_Meta_Storage.sync_update_meta_key(), rt.new_int(cursor)])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_deleted_rows)) {
		return false
	}
	return true
}

fn create_wp_sync_post_meta_storage() &Class_WP_Sync_Post_Meta_Storage {
	mut obj := &Class_WP_Sync_Post_Meta_Storage{
		PhpObjectBase: rt.PhpObjectBase{}
		room_cursors: rt.new_array()
		room_update_counts: rt.new_array()
		storage_post_ids: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.add_update(dispatch_arg_0, dispatch_arg_1))
		}
		'get_awareness_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_awareness_state(dispatch_arg_0)
		}
		'set_awareness_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.set_awareness_state(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_cursor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.get_cursor(dispatch_arg_0))
		}
		'get_storage_post_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.get_storage_post_id(dispatch_arg_0))
		}
		'get_update_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.get_update_count(dispatch_arg_0))
		}
		'get_updates_after_cursor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_updates_after_cursor(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_updates_before_cursor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.remove_updates_before_cursor(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WP_Sync_Post_Meta_Storage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'room_cursors' { return this.room_cursors }
		'room_update_counts' { return this.room_update_counts }
		'storage_post_ids' { return this.storage_post_ids }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Sync_Post_Meta_Storage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'room_cursors' { this.room_cursors = val; return true }
		'room_update_counts' { this.room_update_counts = val; return true }
		'storage_post_ids' { this.storage_post_ids = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_collaboration_class_wp_sync_post_meta_storage_php() {
}
