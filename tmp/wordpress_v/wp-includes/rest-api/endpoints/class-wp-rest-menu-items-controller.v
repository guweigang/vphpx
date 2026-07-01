import rt

struct Class_WP_REST_Menu_Items_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_nav_menu_item(var_id rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_id.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return var_post.dup()
	}
	return rt.call_function('wp_setup_nav_menu_item', [var_post.dup()])
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_has_permission := this.Class_WP_REST_Posts_Controller.get_items_permissions_check(var_request.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_has_permission.dup()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.dup()))
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_permission_check := this.Class_WP_REST_Posts_Controller.get_item_permissions_check(var_request.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_permission_check.dup()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.dup()))
}

fn (mut this Class_WP_REST_Menu_Items_Controller) check_has_read_only_access(var_request rt.PhpVal) bool {
	mut var_read_only_access := rt.call_function('apply_filters', [rt.new_string('rest_menu_read_access'), rt.new_bool(false), var_request.dup(), rt.new_object('WP_REST_Menu_Items_Controller', ['WP_REST_Posts_Controller'], &this)])
	if rt.is_true(var_read_only_access) {
		return true
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) {
		return true
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	{
		mut iter_1 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')])) {
				return true
			}
		}
	}
	return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view menu items.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return create_wp_error(rt.new_string('rest_post_exists'), rt.call_function('__', [rt.new_string('Cannot create existing post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_prepared_nav_item := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_nav_item.dup()])) {
		return var_prepared_nav_item.dup()
	}
	var_prepared_nav_item = rt.cast_array(var_prepared_nav_item)
	mut var_nav_menu_item_id := rt.call_function('wp_update_nav_menu_item', [var_prepared_nav_item.array_get('menu-id'), var_prepared_nav_item.array_get('menu-item-db-id'), rt.call_function('wp_slash', [var_prepared_nav_item.dup()]), rt.new_bool(false)])
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item_id.dup()])) {
		if rt.is_true(rt.identical(rt.new_string('db_insert_error'), rt.call_method(var_nav_menu_item_id, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_nav_menu_item_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_nav_menu_item_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_nav_menu_item_id.dup()
	}
	mut var_nav_menu_item := this.get_nav_menu_item(var_nav_menu_item_id.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item.dup()])) {
		rt.call_method(var_nav_menu_item, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])])
		return var_nav_menu_item.dup()
	}
	rt.call_function('do_action', [rt.new_string('rest_insert_nav_menu_item'), var_nav_menu_item.dup(), var_request.dup(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get('properties').array_get('meta'))) && var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', ['WP_REST_Posts_Controller'], &this), 'meta'), 'update_value', [var_request.array_get('meta'), var_nav_menu_item_id.dup()])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.dup()])) {
			return var_meta_update.dup()
		}
	}
	var_nav_menu_item = this.get_nav_menu_item(var_nav_menu_item_id.dup())
	mut var_fields_update := this.update_additional_fields_for_object(var_nav_menu_item.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_nav_menu_item'), var_nav_menu_item.dup(), var_request.dup(), rt.new_bool(true)])
	mut var_post := rt.call_function('get_post', [var_nav_menu_item_id.dup()])
	rt.call_function('wp_after_insert_post', [var_post.dup(), rt.new_bool(false), rt.new_null()])
	mut var_response := this.prepare_item_for_response(var_post.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%d'), rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base'), var_nav_menu_item_id.dup()])])])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_valid_check := this.get_nav_menu_item(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_valid_check.dup()])) {
		return var_valid_check.dup()
	}
	mut var_post_before := rt.call_function('get_post', [var_request.array_get('id')])
	mut var_prepared_nav_item := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_nav_item.dup()])) {
		return var_prepared_nav_item.dup()
	}
	var_prepared_nav_item = rt.cast_array(var_prepared_nav_item)
	mut var_nav_menu_item_id := rt.call_function('wp_update_nav_menu_item', [var_prepared_nav_item.array_get('menu-id'), var_prepared_nav_item.array_get('menu-item-db-id'), rt.call_function('wp_slash', [var_prepared_nav_item.dup()]), rt.new_bool(false)])
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item_id.dup()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_nav_menu_item_id, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_nav_menu_item_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_nav_menu_item_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_nav_menu_item_id.dup()
	}
	mut var_nav_menu_item := this.get_nav_menu_item(var_nav_menu_item_id.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_nav_menu_item.dup()])) {
		rt.call_method(var_nav_menu_item, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])])
		return var_nav_menu_item.dup()
	}
	rt.call_function('do_action', [rt.new_string('rest_insert_nav_menu_item'), var_nav_menu_item.dup(), var_request.dup(), rt.new_bool(false)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get('properties').array_get('meta'))) && var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menu_Items_Controller', ['WP_REST_Posts_Controller'], &this), 'meta'), 'update_value', [var_request.array_get('meta'), rt.get_property(var_nav_menu_item, 'ID')])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.dup()])) {
			return var_meta_update.dup()
		}
	}
	mut var_post := rt.call_function('get_post', [var_nav_menu_item_id.dup()])
	var_nav_menu_item = this.get_nav_menu_item(var_nav_menu_item_id.dup())
	mut var_fields_update := this.update_additional_fields_for_object(var_nav_menu_item.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_nav_menu_item'), var_nav_menu_item.dup(), var_request.dup(), rt.new_bool(false)])
	rt.call_function('wp_after_insert_post', [var_post.dup(), rt.new_bool(true), var_post_before.dup()])
	mut var_response := this.prepare_item_for_response(rt.call_function('get_post', [var_nav_menu_item_id.dup()]), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WP_REST_Menu_Items_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_menu_item := this.get_nav_menu_item(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_menu_item.dup()])) {
		return var_menu_item.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request.array_get('force'))))) {
		return create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Menu items do not support trashing. Set \'%s\' to delete.')]), rt.new_string('force=true')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	mut var_previous := this.prepare_item_for_response(rt.call_function('get_post', [var_request.array_get('id')]), var_request.dup())
	mut var_result := rt.call_function('wp_delete_post', [var_request.array_get('id'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [rt.new_string('The post cannot be deleted.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_response := create_wp_rest_response()
	rt.call_method(var_response, 'set_data', [rt.create_array([rt.ArrayItem{ key: 'deleted', val: true }, rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data', []rt.PhpVal{}) }])])
	rt.call_function('do_action', [rt.new_string('rest_delete_nav_menu_item'), var_menu_item.dup(), var_response.dup(), var_request.dup()])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_menu_item_db_id := var_request.array_get('id')
	mut var_menu_item_obj := this.get_nav_menu_item(var_menu_item_db_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menu_item_obj.dup()]))))) {
		mut var_position := if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_menu_item_obj, 'menu_order'))) { rt.new_int(1) } else { rt.get_property(var_menu_item_obj, 'menu_order') }
		mut var_prepared_nav_item := rt.create_array([rt.ArrayItem{ key: 'menu-item-db-id', val: var_menu_item_db_id }, rt.ArrayItem{ key: 'menu-item-object-id', val: rt.get_property(var_menu_item_obj, 'object_id') }, rt.ArrayItem{ key: 'menu-item-object', val: rt.get_property(var_menu_item_obj, 'object') }, rt.ArrayItem{ key: 'menu-item-parent-id', val: rt.get_property(var_menu_item_obj, 'menu_item_parent') }, rt.ArrayItem{ key: 'menu-item-position', val: var_position }, rt.ArrayItem{ key: 'menu-item-type', val: rt.get_property(var_menu_item_obj, 'type') }, rt.ArrayItem{ key: 'menu-item-title', val: rt.get_property(var_menu_item_obj, 'title') }, rt.ArrayItem{ key: 'menu-item-url', val: rt.get_property(var_menu_item_obj, 'url') }, rt.ArrayItem{ key: 'menu-item-description', val: rt.get_property(var_menu_item_obj, 'description') }, rt.ArrayItem{ key: 'menu-item-attr-title', val: rt.get_property(var_menu_item_obj, 'attr_title') }, rt.ArrayItem{ key: 'menu-item-target', val: rt.get_property(var_menu_item_obj, 'target') }, rt.ArrayItem{ key: 'menu-item-classes', val: rt.get_property(var_menu_item_obj, 'classes') }, rt.ArrayItem{ key: 'menu-item-xfn', val: rt.call_function('explode', [rt.new_string(' '), rt.get_property(var_menu_item_obj, 'xfn')]) }, rt.ArrayItem{ key: 'menu-item-status', val: rt.get_property(var_menu_item_obj, 'post_status') }, rt.ArrayItem{ key: 'menu-id', val: this.get_menu_id(var_menu_item_db_id.dup()) }])
	} else {
		var_prepared_nav_item = rt.create_array([rt.ArrayItem{ key: 'menu-id', val: 0 }, rt.ArrayItem{ key: 'menu-item-db-id', val: 0 }, rt.ArrayItem{ key: 'menu-item-object-id', val: 0 }, rt.ArrayItem{ key: 'menu-item-object', val: '' }, rt.ArrayItem{ key: 'menu-item-parent-id', val: 0 }, rt.ArrayItem{ key: 'menu-item-position', val: 1 }, rt.ArrayItem{ key: 'menu-item-type', val: 'custom' }, rt.ArrayItem{ key: 'menu-item-title', val: '' }, rt.ArrayItem{ key: 'menu-item-url', val: '' }, rt.ArrayItem{ key: 'menu-item-description', val: '' }, rt.ArrayItem{ key: 'menu-item-attr-title', val: '' }, rt.ArrayItem{ key: 'menu-item-target', val: '' }, rt.ArrayItem{ key: 'menu-item-classes', val: rt.new_array() }, rt.ArrayItem{ key: 'menu-item-xfn', val: rt.new_array() }, rt.ArrayItem{ key: 'menu-item-status', val: 'publish' }])
	}
	mut var_mapping := { 'menu-item-db-id': 'id', 'menu-item-object-id': 'object_id', 'menu-item-object': 'object', 'menu-item-parent-id': 'parent', 'menu-item-position': 'menu_order', 'menu-item-type': 'type', 'menu-item-url': 'url', 'menu-item-description': 'description', 'menu-item-attr-title': 'attr_title', 'menu-item-target': 'target', 'menu-item-classes': 'classes', 'menu-item-xfn': 'xfn', 'menu-item-status': 'status' }
	mut var_schema := this.get_item_schema()
	for var_original, var_api_request in var_mapping {
		if var_request.array_isset(rt.new_string(api_request)) {
			var_prepared_nav_item.array_set(original, var_request.array_get(api_request))
		}
	}
	mut var_taxonomy := rt.call_function('get_taxonomy', [rt.new_string('nav_menu')])
	mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
	if !(!rt.is_true(var_request.array_get(var_base))) {
		var_prepared_nav_item.array_set('menu-id', rt.call_function('absint', [var_request.array_get(var_base)]))
	}
	if !(!rt.is_true(var_schema.array_get('properties').array_get('title'))) && var_request.array_isset(rt.new_string('title')) {
		if rt.is_true(rt.new_bool(var_request.array_get('title').is_string())) {
			var_prepared_nav_item.array_set('menu-item-title', var_request.array_get('title'))
		} else if !(!rt.is_true(var_request.array_get('title').array_get('raw'))) {
			var_prepared_nav_item.array_set('menu-item-title', var_request.array_get('title').array_get('raw'))
		}
	}
	mut var_error := create_wp_error()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_prepared_nav_item.array_get('menu-item-object'))))) {
		if rt.is_true(rt.identical(rt.new_string('taxonomy'), var_prepared_nav_item.array_get('menu-item-type'))) {
			mut var_original := rt.call_function('get_term', [])
			if rt.is_true(rt.new_bool(!rt.is_true() || rt.is_true())) {
				
			} else {
			}
			// unsupported statement: Stmt_Nop
		} else if rt.is_true() {
		}
	}
	if rt.is_true(rt.identical(, )) {
		
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
		}
	}
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_schema_links() rt.PhpVal {
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Menu_Items_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Menu_Items_Controller) get_menu_id(var_menu_item_id rt.PhpVal) rt.PhpVal {
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_menu_items_controller() &Class_WP_REST_Menu_Items_Controller {
	mut obj := &Class_WP_REST_Menu_Items_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_posts_controller() &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Menu_Items_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_nav_menu_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_nav_menu_item(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'check_has_read_only_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_has_read_only_access(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_schema_links' {
			return this.get_schema_links()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_items_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_menu_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_menu_id(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Menu_Items_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Menu_Items_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_menu_items_controller_php() {
}
