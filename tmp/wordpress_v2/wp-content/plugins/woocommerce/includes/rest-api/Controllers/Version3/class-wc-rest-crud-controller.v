import rt

struct Class_WC_REST_CRUD_Controller {
	rt.PhpObjectBase
pub mut:
	namespace    rt.PhpVal = rt.new_string('wc/v2')
	hierarchical rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_REST_CRUD_Controller) get_object(var_id rt.PhpVal) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string("Method '%s' not implemented. Must be overridden in subclass."),
			rt.new_string('woocommerce'),
		]),
		rt.new_string(@METHOD),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WC_REST_CRUD_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_object :=
		this.get_object(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(var_object)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type'), rt.new_string('read'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot view this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_CRUD_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_object :=
		this.get_object(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(var_object)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type'), rt.new_string('edit'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_CRUD_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_object :=
		this.get_object(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(var_object)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this), 'post_type'), rt.new_string('delete'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_CRUD_Controller) get_permalink(var_object rt.PhpVal) string {
	mut var_object_mutated := var_object
	return ''
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string("Method '%s' not implemented. Must be overridden in subclass."),
			rt.new_string('woocommerce'),
		]),
		rt.new_string(@METHOD),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string("Method '%s' not implemented. Must be overridden in subclass."),
			rt.new_string('woocommerce'),
		]),
		rt.new_string(@METHOD),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }])))
}

fn (mut this Class_WC_REST_CRUD_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_object :=
		this.get_object(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object))))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('Invalid ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_data := this.prepare_object_for_response(var_object.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
		'WC_REST_Posts_Controller',
	], &this), 'public'))
	{
		rt.call_method(var_response, 'link_header', [rt.new_string('alternate'),
			rt.new_string(this.get_permalink(var_object.clone())),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'text/html' }])])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_CRUD_Controller) save_object(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_object := this.prepare_object_for_database(var_request.clone(), creating)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_object.clone()])) {
		return var_object.clone()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_object, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		mut var_error := rt.new_string((rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_not_created'))).str())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-rest-api' },
				rt.ArrayItem{ key: 'error', val: var_error },
				rt.ArrayItem{ key: 'code', val: 400 }]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(var_error.clone(), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 400 },
		])))
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return this.get_object(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		var_e = var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e,
			'getErrorData', []rt.PhpVal{})))
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1, 'WC_REST_Exception') {
		var_e = var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
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
	return rt.new_null()
}

fn (mut this Class_WC_REST_CRUD_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_exists')), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Cannot create existing %s.'),
				rt.new_string('woocommerce')]),
			rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'],
				&this), 'post_type'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_object := this.save_object(var_request.clone(), true)
	if rt.is_true(rt.call_function('is_wp_error', [var_object.clone()])) {
		return var_object.clone()
	}
	this.update_additional_fields_for_object(var_object.clone(), var_request.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	rt.call_function('do_action', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_insert_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_object')),
		var_object.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'WC_Data_Exception') {
		mut var_e := var_e_3.clone()
		rt.call_method(var_object, 'delete', []rt.PhpVal{})
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e,
			'getErrorData', []rt.PhpVal{})))
		unsafe {
			goto end_label_3
		}
	} else if rt.instance_of(var_e_3, 'WC_REST_Exception') {
		var_e = var_e_3.clone()
		rt.call_method(var_object, 'delete', []rt.PhpVal{})
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_object_for_response(var_object.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
				rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
					'WC_REST_Posts_Controller',
				], &this), 'rest_base'),
				rt.call_method(var_object, 'get_id', []rt.PhpVal{})]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_CRUD_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_object :=
		this.get_object(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object))))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('Invalid ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	var_object = this.save_object(var_request.clone(), false)
	if rt.is_true(rt.call_function('is_wp_error', [var_object.clone()])) {
		return var_object.clone()
	}
	this.update_additional_fields_for_object(var_object.clone(), var_request.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	rt.call_function('do_action', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_insert_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_object')),
		var_object.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'WC_Data_Exception') {
		mut var_e := var_e_4.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e,
			'getErrorData', []rt.PhpVal{})))
		unsafe {
			goto end_label_4
		}
	} else if rt.instance_of(var_e_4, 'WC_REST_Exception') {
		var_e = var_e_4.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_object_for_response(var_object.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('offset', var_request.array_get(rt.new_string('offset')))
	var_args.array_set('order', var_request.array_get(rt.new_string('order')))
	var_args.array_set('orderby', var_request.array_get(rt.new_string('orderby')))
	var_args.array_set('paged', var_request.array_get(rt.new_string('page')))
	var_args.array_set('post__in', var_request.array_get(rt.new_string('include')))
	var_args.array_set('post__not_in', var_request.array_get(rt.new_string('exclude')))
	var_args.array_set('posts_per_page', var_request.array_get(rt.new_string('per_page')))
	var_args.array_set('name', var_request.array_get(rt.new_string('slug')))
	var_args.array_set('post_parent__in', var_request.array_get(rt.new_string('parent')))
	var_args.array_set('post_parent__not_in',
		var_request.array_get(rt.new_string('parent_exclude')))
	var_args.array_set('s', var_request.array_get(rt.new_string('search')))
	var_args.array_set('fields', this.get_fields_for_response(var_request.clone()))
	if rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('orderby')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'modified' }]),
		rt.new_bool(true)]))
	{
		var_args.array_set('orderby', (var_args.array_get(rt.new_string('orderby'))).str() + ' ID')
	}
	mut var_date_query := rt.new_array()
	mut var_use_gmt := var_request.array_get(rt.new_string('dates_are_gmt'))
	if var_request.array_isset(rt.new_string('before')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' }
			},
			rt.ArrayItem{ key: 'before', val: var_request.array_get(rt.new_string('before')) },
		]))
	}
	if var_request.array_isset(rt.new_string('after')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_date_gmt' } else { 'post_date' }
			},
			rt.ArrayItem{ key: 'after', val: var_request.array_get(rt.new_string('after')) },
		]))
	}
	if var_request.array_isset(rt.new_string('modified_before')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_modified_gmt' } else { 'post_modified' }
			},
			rt.ArrayItem{
				key: 'before'
				val: var_request.array_get(rt.new_string('modified_before'))
			},
		]))
	}
	if var_request.array_isset(rt.new_string('modified_after')) {
		var_date_query.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'column'
				val: if rt.is_true(var_use_gmt) { 'post_modified_gmt' } else { 'post_modified' }
			},
			rt.ArrayItem{ key: 'after', val: var_request.array_get(rt.new_string('modified_after')) },
		]))
	}
	if !(!rt.is_true(var_date_query)) {
		var_date_query.array_set('relation', 'AND')
		var_args.array_set('date_query', var_date_query.clone())
	}
	var_args.array_set('post_type', rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
		'WC_REST_Posts_Controller',
	], &this), 'post_type'))
	var_args = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_object_query')),
		var_args.clone(),
		var_request.clone(),
	])
	return this.prepare_items_query(var_args.clone(), var_request.clone())
}

fn (mut this Class_WC_REST_CRUD_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_query := create_wp_query()
	mut var_result := var_query.query(var_query_args_mutated.clone())
	mut var_total_posts := rt.get_property(var_query, 'found_posts')
	if rt.is_true(rt.less(var_total_posts, rt.new_int(1)))
		&& var_query_args_mutated.array_isset(rt.new_string('paged'))
		&& rt.is_true(rt.greater(rt.call_function('absint', [var_query_args_mutated.array_get(rt.new_string('paged'))]), rt.new_int(1))) {
		var_query_args_mutated.array_unset(rt.new_string('paged'))
		mut var_count_query := create_wp_query()
		var_count_query.query(var_query_args_mutated.clone())
		var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'objects', val: rt.call_function('array_filter', [
			rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_CRUD_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_object' },
				]),
				var_result.clone(),
			]),
		]) },
		rt.ArrayItem{ key: 'total', val: rt.new_int(var_total_posts.to_i64()) },
		rt.ArrayItem{ key: 'pages', val: rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_posts,
				rt.new_int((rt.get_property(var_query, 'query_vars').array_get(rt.new_string('posts_per_page'))).to_i64())),
		])).to_i64()) },
	])
}

fn (mut this Class_WC_REST_CRUD_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [
		rt.call_function('current', [var_query_args.clone()]),
	]))
	{
		return rt.call_function('current', [var_query_args.clone()])
	}
	mut var_query_results := this.get_objects(var_query_args.clone())
	mut var_objects := rt.new_array()
	mut iter_1 := var_query_results.array_get(rt.new_string('objects')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_object := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
			rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
				'WC_REST_Posts_Controller',
			], &this), 'post_type'),
			rt.new_string('read'),
			rt.call_method(var_object, 'get_id', []rt.PhpVal{}),
		])))))
		{
			continue
		}
		mut var_data := this.prepare_object_for_response(var_object.clone(), var_request.clone())
		var_objects << this.prepare_response_for_collection(var_data.clone())
	}
	mut var_page := rt.new_int((var_query_args.array_get(rt.new_string('paged'))).to_i64())
	mut var_max_pages := var_query_results.array_get(rt.new_string('pages'))
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_objects),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		var_query_results.array_get(rt.new_string('total'))])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(var_max_pages.to_i64())])
	mut var_base := rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
		'WC_REST_Posts_Controller',
	], &this), 'rest_base')
	mut var_attrib_prefix := rt.new_string('(?P<')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_base.clone(),
		var_attrib_prefix.clone(),
	]), rt.new_bool(false)))))
	{
		mut var_attrib_names := rt.new_array()
		rt.call_function('preg_match', [rt.new_string('/\\(\\?P<[^>]+>.*\\)/'),
			var_base.clone(), var_attrib_names.clone(), rt.get_constant('PREG_OFFSET_CAPTURE')])
		mut iter_2 := var_attrib_names.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_attrib_name_match := item_2.val
			mut var_beginning_offset := rt.new_int(var_attrib_prefix.clone().to_string().len)
			mut var_attrib_name_end := rt.call_function('strpos', [
				var_attrib_name_match.array_get(rt.new_int(0)),
				rt.new_string('>'),
				var_attrib_name_match.array_get(rt.new_int(1)),
			])
			mut var_attrib_name := rt.call_function('substr', [
				var_attrib_name_match.array_get(rt.new_int(0)),
				var_beginning_offset.clone(),
				rt.sub(var_attrib_name_end, var_beginning_offset),
			])
			if var_request.array_isset(var_attrib_name) {
				var_base = rt.call_function('str_replace', [
					rt.new_string('(?P<${var_attrib_name.to_string()}>[\\d]+)'),
					var_request.array_get(var_attrib_name),
					var_base.clone(),
				])
			}
		}
	}
	var_base = rt.call_function('add_query_arg', [
		rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, var_base.clone()]),
		]),
	])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_CRUD_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_force := rt.new_bool((var_request.array_get(rt.new_string('force'))).to_bool())
	mut var_object :=
		this.get_object(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	mut var_result := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object))))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('Invalid ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_supports_trash := rt.new_bool(
		rt.is_true(rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0)))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_object
	}, rt.ArrayItem{ key: none, val: 'get_status' }])]))
	var_supports_trash = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_object_trashable')),
		var_supports_trash.clone(),
		var_object.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type'),
		rt.new_string('delete'),
		rt.call_method(var_object, 'get_id', []rt.PhpVal{}),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.new_string('woocommerce_rest_user_cannot_delete_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to delete %s.'),
				rt.new_string('woocommerce'),
			]),
			rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
				'WC_REST_Posts_Controller',
			], &this), 'post_type'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		])))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_object_for_response(var_object.clone(), var_request.clone())
	if rt.is_true(var_force) {
		rt.call_method(var_object, 'delete', [rt.new_bool(true)])
		var_result = rt.identical(rt.new_int(0),
			rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %s does not support trashing.'),
					rt.new_string('woocommerce'),
				]),
				rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
					'WC_REST_Posts_Controller',
				], &this), 'post_type'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_object },
				rt.ArrayItem{ key: none, val: 'get_status' }]),
		]))
		{
			if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_method(var_object,
				'get_status', []rt.PhpVal{})))
			{
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_already_trashed'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The %s has already been deleted.'),
						rt.new_string('woocommerce'),
					]),
					rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
						'WC_REST_Posts_Controller',
					], &this), 'post_type'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
			}
			rt.call_method(var_object, 'delete', []rt.PhpVal{})
			var_result = rt.identical(rt.new_string('trash'), rt.call_method(var_object,
				'get_status', []rt.PhpVal{}))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('The %s cannot be deleted.'),
				rt.new_string('woocommerce')]),
			rt.get_property(rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'],
				&this), 'post_type'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_delete_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_object')),
		var_object.clone(),
		var_response.clone(),
		var_request.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_WC_REST_CRUD_Controller) fetch_fields_using_getters(var_object rt.PhpVal, var_context rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_data := rt.new_array()
	mut iter_3 := var_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		if rt.is_true(rt.call_function('method_exists', [
			rt.new_object('WC_REST_CRUD_Controller', ['WC_REST_Posts_Controller'], &this),
			rt.new_string('api_get_${var_field.to_string()}'),
		]))
		{
			var_data.array_set(var_field, rt.call_method(rt.new_object('WC_REST_CRUD_Controller', [
				'WC_REST_Posts_Controller',
			], &this), 'api_get_${var_field.to_string()}', [var_object_mutated.clone(),
				var_context.clone()]))
		}
	}
	return var_data.clone()
}

fn (mut this Class_WC_REST_CRUD_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
					rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
						'WC_REST_Posts_Controller',
					], &this), 'rest_base'),
					rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace,
					rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
						'WC_REST_Posts_Controller',
					], &this), 'rest_base')]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_CRUD_Controller) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params['context'] = this.get_context_param()
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params['page'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Current page of the collection.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 1 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	])
	var_params['per_page'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Maximum number of items to be returned in result set.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 10 },
		rt.ArrayItem{ key: 'minimum', val: 1 },
		rt.ArrayItem{ key: 'maximum', val: 100 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['search'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit results to those matching a string.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['after'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published after a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['before'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published before a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['modified_after'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources modified after a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['modified_before'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources modified before a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['dates_are_gmt'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Whether to consider GMT post dates when limiting response by published or modified date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'default', val: false },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['exclude'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	])
	var_params['include'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	])
	var_params['offset'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['order'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'desc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	var_params['orderby'] = rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by object attribute.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'modified' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	])
	if rt.is_true(this.hierarchical) {
		var_params['parent'] = rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to those of particular parent IDs.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
			]) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
			rt.ArrayItem{ key: 'default', val: rt.new_array() },
		])
		var_params['parent_exclude'] = rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit result set to all items except those of a particular parent ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
			]) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
			rt.ArrayItem{ key: 'default', val: rt.new_array() },
		])
	}
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('rest_'), rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type')), rt.new_string('_collection_params')),
		rt.create_array_from_native_map(var_params),
		rt.get_property(rt.new_object('WC_REST_CRUD_Controller', [
			'WC_REST_Posts_Controller',
		], &this), 'post_type'),
	])
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

fn create_wc_rest_crud_controller(_args ...rt.PhpVal) &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
		hierarchical:  rt.new_bool(false)
	}
	return obj
}

fn create_wc_rest_posts_controller(_args ...rt.PhpVal) &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
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
		else {
			return none
		}
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
		'namespace' {
			this.namespace = val
			return true
		}
		'hierarchical' {
			this.hierarchical = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
