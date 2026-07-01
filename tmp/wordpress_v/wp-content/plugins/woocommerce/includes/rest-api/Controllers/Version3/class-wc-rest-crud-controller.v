import rt

struct Class_WC_REST_CRUD_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		hierarchical rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_REST_CRUD_Controller) get_object(var_id rt.PhpVal) rt.PhpVal {
	return create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }]))
}

fn (mut this Class_WC_REST_CRUD_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_object := this.get_object(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_object) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type'), rt.new_string('read'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_CRUD_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_object := this.get_object(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_object) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type'), rt.new_string('edit'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_CRUD_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_object := this.get_object(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_object) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type'), rt.new_string('delete'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_CRUD_Controller) get_permalink(var_object rt.PhpVal) string {
	mut var_object_mutated := var_object
	return ''
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	return create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }]))
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	return create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }]))
}

fn (mut this Class_WC_REST_CRUD_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_object := this.get_object(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_data := this.prepare_object_for_response(var_object.dup(), var_request.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'public')) {
		rt.call_method(var_response, 'link_header', [rt.new_string('alternate'), this.get_permalink(var_object.dup()), rt.create_array([rt.ArrayItem{ key: 'type', val: 'text/html' }])])
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_CRUD_Controller) save_object(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_object := this.prepare_object_for_database(var_request.dup(), creating)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_object.dup()])) {
		return var_object.dup()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_object, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		mut var_error := rt.new_string(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')), rt.new_string('_not_created')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-rest-api' }, rt.ArrayItem{ key: 'error', val: var_error }, rt.ArrayItem{ key: 'code', val: 400 }])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return create_wp_error(var_error.dup(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return this.get_object(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'WC_REST_Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_CRUD_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')), rt.new_string('_exists')), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cannot create existing %s.'), rt.new_string('woocommerce')]), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_object := this.save_object(var_request.dup(), true)
	if rt.is_true(rt.call_function('is_wp_error', [var_object.dup()])) {
		return var_object.dup()
	}
	this.update_additional_fields_for_object(var_object.dup(), var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_function('do_action', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_insert_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')), rt.new_string('_object')), var_object.dup(), var_request.dup(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'WC_Data_Exception') {
		mut var_e := var_e_3.dup()
		rt.call_method(var_object, 'delete', []rt.PhpVal{})
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{}))
		unsafe { goto end_label_3 }
	}
	else if rt.instance_of(var_e_3, 'WC_REST_Exception') {
		mut var_e := var_e_3.dup()
		rt.call_method(var_object, 'delete', []rt.PhpVal{})
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_object_for_response(var_object.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'rest_base'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})])])])
	return var_response.dup()
}

fn (mut this Class_WC_REST_CRUD_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_object := this.get_object(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	var_object = this.save_object(var_request.dup(), false)
	if rt.is_true(rt.call_function('is_wp_error', [var_object.dup()])) {
		return var_object.dup()
	}
	this.update_additional_fields_for_object(var_object.dup(), var_request.dup())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_function('do_action', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_insert_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')), rt.new_string('_object')), var_object.dup(), var_request.dup(), rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'WC_Data_Exception') {
		mut var_e := var_e_4.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getErrorData', []rt.PhpVal{}))
		unsafe { goto end_label_4 }
	}
	else if rt.instance_of(var_e_4, 'WC_REST_Exception') {
		mut var_e := var_e_4.dup()
		return create_wp_error(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_object_for_response(var_object.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('offset', var_request.array_get('offset'))
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('paged', var_request.array_get('page'))
	var_args.array_set('post__in', var_request.array_get('include'))
	var_args.array_set('post__not_in', var_request.array_get('exclude'))
	var_args.array_set('posts_per_page', var_request.array_get('per_page'))
	var_args.array_set('name', var_request.array_get('slug'))
	var_args.array_set('post_parent__in', var_request.array_get('parent'))
	var_args.array_set('post_parent__not_in', var_request.array_get('parent_exclude'))
	var_args.array_set('s', var_request.array_get('search'))
	var_args.array_set('fields', this.get_fields_for_response(var_request.dup()))
	if rt.is_true(rt.call_function('in_array', [var_args.array_get('orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'modified' }]), rt.new_bool(true)])) {
		var_args.array_set('orderby', (var_args.array_get('orderby')).str() + ' ID')
	}
	mut var_date_query := rt.new_array()
	mut var_use_gmt := var_request.array_get('dates_are_gmt')
	if var_request.array_isset(rt.new_string('before')) {
		var_date_query.array_push(rt.create_array([rt.ArrayItem{ key: 'column', val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' } }, rt.ArrayItem{ key: 'before', val: var_request.array_get('before') }]))
	}
	if var_request.array_isset(rt.new_string('after')) {
		var_date_query.array_push(rt.create_array([rt.ArrayItem{ key: 'column', val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' } }, rt.ArrayItem{ key: 'after', val: var_request.array_get('after') }]))
	}
	if var_request.array_isset(rt.new_string('modified_before')) {
		var_date_query.array_push(rt.create_array([rt.ArrayItem{ key: 'column', val: if rt.is_true(var_use_gmt) { 'post_modified_gmt' } else { 'post_modified' } }, rt.ArrayItem{ key: 'before', val: var_request.array_get('modified_before') }]))
	}
	if var_request.array_isset(rt.new_string('modified_after')) {
		var_date_query.array_push(rt.create_array([rt.ArrayItem{ key: 'column', val: if rt.is_true(var_use_gmt) { 'post_modified_gmt' } else { 'post_modified' } }, rt.ArrayItem{ key: 'after', val: var_request.array_get('modified_after') }]))
	}
	if !(!rt.is_true(var_date_query)) {
		var_date_query.array_set('relation', 'AND')
		var_args.array_set('date_query', var_date_query.dup())
	}
	var_args.array_set('post_type', rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type'))
	var_args = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type')), rt.new_string('_object_query')), var_args.dup(), var_request.dup()])
	return this.prepare_items_query(var_args.dup(), var_request.dup())
}

fn (mut this Class_WC_REST_CRUD_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_query := create_wp_query()
	mut var_result := var_query.query(var_query_args_mutated.dup())
	mut var_total_posts := rt.get_property(var_query, 'found_posts')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_total_posts, rt.new_int(1))) && var_query_args_mutated.array_isset(rt.new_string('paged')))) && rt.is_true(rt.greater(rt.call_function('absint', [var_query_args_mutated.array_get('paged')]), rt.new_int(1))))) {
		var_query_args_mutated.array_unset(rt.new_string('paged'))
		mut var_count_query := create_wp_query()
		var_count_query.query(var_query_args_mutated.dup())
		var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	return rt.create_array([rt.ArrayItem{ key: 'objects', val: rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_object' }]), var_result.dup()])]) }, rt.ArrayItem{ key: 'total', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'pages', val: // unsupported expression: Expr_Cast_Int }])
}

fn (mut this Class_WC_REST_CRUD_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [rt.call_function('current', [var_query_args.dup()])])) {
		return rt.call_function('current', [var_query_args.dup()])
	}
	mut var_query_results := this.get_objects(var_query_args.dup())
	mut var_objects := rt.new_array()
	{
		mut iter_1 := var_query_results.array_get('objects').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_object := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true()))) {
				continue
			}
			
		}
	}
}

fn (mut this Class_WC_REST_CRUD_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_CRUD_Controller) fetch_fields_using_getters(var_object rt.PhpVal, var_context rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
}

fn (mut this Class_WC_REST_CRUD_Controller) get_collection_params() rt.PhpVal {
}

struct Class_WC_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wc_rest_crud_controller() &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		hierarchical: rt.new_bool(false)
	}
	return obj
}

fn create_wc_rest_posts_controller() &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_CRUD_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_object(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'get_permalink' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_permalink(dispatch_arg_0))
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'save_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.save_object(dispatch_arg_0, dispatch_arg_1)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_objects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_objects(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'fetch_fields_using_getters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.fetch_fields_using_getters(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_CRUD_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'hierarchical' { return this.hierarchical }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_CRUD_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'hierarchical' { this.hierarchical = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_crud_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
