import rt

struct Class_WP_REST_Menus_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Menus_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_has_permission := this.Class_WP_REST_Terms_Controller.get_items_permissions_check(var_request.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_has_permission.dup()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.dup()))
}

fn (mut this Class_WP_REST_Menus_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_has_permission := this.Class_WP_REST_Terms_Controller.get_item_permissions_check(var_request.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_has_permission.dup()
	}
	return rt.new_bool(this.check_has_read_only_access(var_request.dup()))
}

fn (mut this Class_WP_REST_Menus_Controller) get_term(var_id rt.PhpVal) rt.PhpVal {
	mut var_term := this.Class_WP_REST_Terms_Controller.get_term(var_id.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		return var_term.dup()
	}
	mut var_nav_term := rt.call_function('wp_get_nav_menu_object', [var_term.dup()])
	rt.set_property(var_nav_term, 'auto_add', this.get_menu_auto_add(rt.get_property(var_nav_term, 'term_id')))
	return var_nav_term.dup()
}

fn (mut this Class_WP_REST_Menus_Controller) check_has_read_only_access(var_request rt.PhpVal) bool {
	mut var_read_only_access := rt.call_function('apply_filters', [rt.new_string('rest_menu_read_access'), rt.new_bool(false), var_request.dup(), rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this)])
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
	return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view menus.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Menus_Controller) prepare_item_for_response(var_term rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
	mut var_nav_menu := rt.call_function('wp_get_nav_menu_object', [var_term_mutated.dup()])
	mut var_response := this.Class_WP_REST_Terms_Controller.prepare_item_for_response(var_nav_menu.dup(), var_request.dup())
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('locations'), var_fields.dup()])) {
		var_data.array_set('locations', this.get_menu_locations(rt.get_property(var_nav_menu, 'term_id')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('auto_add'), var_fields.dup()])) {
		var_data.array_set('auto_add', this.get_menu_auto_add(rt.get_property(var_nav_menu, 'term_id')))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	var_response = rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_term_mutated.dup())])
	}
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('rest_prepare_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')), var_response.dup(), var_term_mutated.dup(), var_request.dup()])
}

fn (mut this Class_WP_REST_Menus_Controller) prepare_links(var_term rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
	mut var_links := this.Class_WP_REST_Terms_Controller.prepare_links(var_term_mutated.dup())
	mut var_locations := this.get_menu_locations(rt.get_property(var_term_mutated, 'term_id'))
	{
		mut iter_1 := var_locations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_location := item_1.val
			mut var_url := rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('wp/v2/menu-locations/%s'), var_location.dup()])])
			var_links.array_get_mut('https://api.w.org/menu-location').array_push(rt.create_array([rt.ArrayItem{ key: 'href', val: var_url }, rt.ArrayItem{ key: 'embeddable', val: true }]))
		}
	}
	return var_links.dup()
}

fn (mut this Class_WP_REST_Menus_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_term := this.Class_WP_REST_Terms_Controller.prepare_item_for_database(var_request.dup())
	mut var_schema := this.get_item_schema()
	if var_request.array_isset(rt.new_string('name')) && !(!rt.is_true(var_schema.array_get('properties').array_get('name'))) {
		rt.set_property(var_prepared_term, '{"nodeType":"Scalar_String","line":190,"value":"menu-name"}', var_request.array_get('name'))
	}
	return var_prepared_term.dup()
}

fn (mut this Class_WP_REST_Menus_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')]))))) {
			return create_wp_error(rt.new_string('rest_taxonomy_not_hierarchical'), rt.call_function('__', [rt.new_string('Cannot set parent term, taxonomy is not hierarchical.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		mut var_parent := rt.call_function('wp_get_nav_menu_object', [// unsupported expression: Expr_Cast_Int])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return create_wp_error(rt.new_string('rest_term_invalid'), rt.call_function('__', [rt.new_string('Parent term does not exist.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	mut var_prepared_term := this.prepare_item_for_database(var_request.dup())
	mut var_term := rt.call_function('wp_update_nav_menu_object', [rt.new_int(0), rt.call_function('wp_slash', [rt.cast_array(var_prepared_term)])])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string('menu_exists'), rt.call_method(var_term, 'get_error_codes', []rt.PhpVal{}), rt.new_bool(true)])) {
			mut var_existing_term := rt.call_function('get_term_by', [rt.new_string('name'), rt.get_property(var_prepared_term, '{"nodeType":"Scalar_String","line":228,"value":"menu-name"}'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')])
			rt.call_method(var_term, 'add_data', [rt.get_property(var_existing_term, 'term_id'), rt.new_string('menu_exists')])
			rt.call_method(var_term, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }, rt.ArrayItem{ key: 'term_id', val: rt.get_property(var_existing_term, 'term_id') }])])
		} else {
			rt.call_method(var_term, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_term.dup()
	}
	var_term = this.get_term(var_term.dup())
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')), var_term.dup(), var_request.dup(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get('properties').array_get('meta'))) && var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'meta'), 'update_value', [var_request.array_get('meta'), rt.get_property(var_term, 'term_id')])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.dup()])) {
			return var_meta_update.dup()
		}
	}
	mut var_locations_update := rt.new_bool(this.handle_locations(rt.get_property(var_term, 'term_id'), var_request.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_locations_update.dup()])) {
		return var_locations_update.dup()
	}
	this.handle_auto_add(rt.get_property(var_term, 'term_id'), var_request.dup())
	mut var_fields_update := this.update_additional_fields_for_object(var_term.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('view')])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_after_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')), var_term.dup(), var_request.dup(), rt.new_bool(true)])
	mut var_response := this.prepare_item_for_response(var_term.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [(rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'namespace')).str() + '/' + (rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'rest_base')).str() + '/' + (rt.get_property(var_term, 'term_id')).str()])])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Menus_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_term := this.get_term(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		return var_term.dup()
	}
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')]))))) {
			return create_wp_error(rt.new_string('rest_taxonomy_not_hierarchical'), rt.call_function('__', [rt.new_string('Cannot set parent term, taxonomy is not hierarchical.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		mut var_parent := rt.call_function('get_term', [// unsupported expression: Expr_Cast_Int, rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return create_wp_error(rt.new_string('rest_term_invalid'), rt.call_function('__', [rt.new_string('Parent term does not exist.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	mut var_prepared_term := this.prepare_item_for_database(var_request.dup())
	if !(!rt.is_true(var_prepared_term)) {
		if !(!(rt.get_property(var_prepared_term, '{"nodeType":"Scalar_String","line":315,"value":"menu-name"}')).is_null()) {
			rt.set_property(var_prepared_term, '{"nodeType":"Scalar_String","line":317,"value":"menu-name"}', rt.get_property(var_term, 'name'))
		}
		mut var_update := rt.call_function('wp_update_nav_menu_object', [rt.get_property(var_term, 'term_id'), rt.call_function('wp_slash', [rt.cast_array(var_prepared_term)])])
		if rt.is_true(rt.call_function('is_wp_error', [var_update.dup()])) {
			return var_update.dup()
		}
	}
	var_term = rt.call_function('get_term', [rt.get_property(var_term, 'term_id'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')), var_term.dup(), var_request.dup(), rt.new_bool(false)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get('properties').array_get('meta'))) && var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'meta'), 'update_value', [var_request.array_get('meta'), rt.get_property(var_term, 'term_id')])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.dup()])) {
			return var_meta_update.dup()
		}
	}
	mut var_locations_update := rt.new_bool(this.handle_locations(rt.get_property(var_term, 'term_id'), var_request.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_locations_update.dup()])) {
		return var_locations_update.dup()
	}
	this.handle_auto_add(rt.get_property(var_term, 'term_id'), var_request.dup())
	mut var_fields_update := this.update_additional_fields_for_object(var_term.dup(), var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.dup()])) {
		return var_fields_update.dup()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('view')])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_after_insert_'), rt.get_property(rt.new_object('WP_REST_Menus_Controller', ['WP_REST_Terms_Controller'], &this), 'taxonomy')), var_term.dup(), var_request.dup(), rt.new_bool(false)])
	mut var_response := this.prepare_item_for_response(var_term.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WP_REST_Menus_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_term := this.get_term(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		return var_term.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request.array_get('force'))))) {
		return create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Menus do not support trashing. Set \'%s\' to delete.')]), rt.new_string('force=true')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('view')])
	mut var_previous := this.prepare_item_for_response(var_term.dup(), var_request.dup())
	mut var_result := rt.call_function('wp_delete_nav_menu', [var_term.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true()))) || rt.is_true(rt.call_function('is_wp_error', [.dup()])))) {
		return create_wp_error(, , )
	}
	mut var_response := 
	
}

fn (mut this Class_WP_REST_Menus_Controller) get_menu_auto_add(var_menu_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Menus_Controller) handle_auto_add(var_menu_id rt.PhpVal, var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Menus_Controller) get_menu_locations(var_menu_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Menus_Controller) handle_locations(var_menu_id rt.PhpVal, var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Menus_Controller) get_item_schema() rt.PhpVal {
}

struct Class_WP_REST_Terms_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_menus_controller() &Class_WP_REST_Menus_Controller {
	mut obj := &Class_WP_REST_Menus_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_terms_controller() &Class_WP_REST_Terms_Controller {
	mut obj := &Class_WP_REST_Terms_Controller{
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

fn (mut this Class_WP_REST_Menus_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'get_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_term(dispatch_arg_0)
		}
		'check_has_read_only_access' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_has_read_only_access(dispatch_arg_0))
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
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
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
		'get_menu_auto_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_menu_auto_add(dispatch_arg_0)
		}
		'handle_auto_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.handle_auto_add(dispatch_arg_0, dispatch_arg_1))
		}
		'get_menu_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_menu_locations(dispatch_arg_0)
		}
		'handle_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.handle_locations(dispatch_arg_0, dispatch_arg_1))
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Menus_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Menus_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Terms_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Terms_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Terms_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_menus_controller_php() {
}
