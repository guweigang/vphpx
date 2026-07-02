import rt

struct Class_WC_REST_Posts_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('')
	post_type rt.PhpVal = rt.new_string('')
	public    rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_REST_Posts_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		this.post_type,
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		this.post_type,
		rt.new_string('create'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := rt.call_function('get_post', [
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
	])
	if rt.is_true(var_post)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read'), rt.get_property(var_post, 'ID')]))))) {
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

fn (mut this Class_WC_REST_Posts_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := rt.call_function('get_post', [
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
	])
	if rt.is_true(var_post)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('edit'), rt.get_property(var_post, 'ID')]))))) {
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

fn (mut this Class_WC_REST_Posts_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := rt.call_function('get_post', [
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
	])
	if rt.is_true(var_post)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('delete'), rt.get_property(var_post, 'ID')]))))) {
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

fn (mut this Class_WC_REST_Posts_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		this.post_type,
		rt.new_string('batch'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_post := rt.call_function('get_post', [var_id.clone()])
	if !(!rt.is_true(rt.get_property(var_post, 'post_type')))
		&& rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post, 'post_type')))
		&& rt.is_true(rt.identical(rt.new_string('product'), this.post_type)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'),
			this.post_type), rt.new_string('_id')), rt.call_function('__', [
			rt.new_string('To manipulate product variations you should use the /products/&lt;product_id&gt;/variations/&lt;id&gt; endpoint.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	} else if !rt.is_true(var_id) || !rt.is_true(rt.get_property(var_post, 'ID'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_post, 'post_type'), this.post_type)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'),
			this.post_type), rt.new_string('_id')), rt.call_function('__', [
			rt.new_string('Invalid ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_data := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(this.public) {
		rt.call_method(var_response, 'link_header', [rt.new_string('alternate'),
			rt.call_function('get_permalink', [var_id.clone()]),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'text/html' }])])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_Posts_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Cannot create existing %s.'),
				rt.new_string('woocommerce')]),
			this.post_type,
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_post := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	rt.set_property(var_post, 'post_type', this.post_type)
	mut var_post_id := rt.call_function('wp_insert_post', [var_post.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		if rt.is_true(rt.call_function('in_array', [
			rt.call_method(var_post_id, 'get_error_code', []rt.PhpVal{}),
			rt.create_array([rt.ArrayItem{ key: none, val: 'db_insert_error' }]),
		]))
		{
			rt.call_method(var_post_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_post_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_post_id.clone()
	}
	rt.set_property(var_post, 'ID', var_post_id.clone())
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	this.update_additional_fields_for_object(var_post.clone(), var_request.clone())
	mut var_meta_fields := rt.new_bool(this.add_post_meta_fields(var_post.clone(),
		var_request.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_meta_fields.clone()])) {
		this.delete_post(var_post.clone())
		return var_meta_fields.clone()
	}
	rt.call_function('do_action', [
		rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type),
		var_post.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
				var_post_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Posts_Controller) add_post_meta_fields(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) delete_post(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	rt.call_function('wp_delete_post', [rt.get_property(var_post_mutated, 'ID'),
		rt.new_bool(true)])
}

fn (mut this Class_WC_REST_Posts_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_post := rt.call_function('get_post', [var_id.clone()])
	if !(!rt.is_true(rt.get_property(var_post, 'post_type')))
		&& rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post, 'post_type')))
		&& rt.is_true(rt.identical(rt.new_string('product'), this.post_type)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'),
			this.post_type), rt.new_string('_id')), rt.call_function('__', [
			rt.new_string('To manipulate product variations you should use the /products/&lt;product_id&gt;/variations/&lt;id&gt; endpoint.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	} else if !rt.is_true(var_id) || !rt.is_true(rt.get_property(var_post, 'ID'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_post, 'post_type'), this.post_type)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('ID is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	var_post = this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_post_id := rt.call_function('wp_update_post', [rt.cast_array(var_post),
		rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		if rt.is_true(rt.call_function('in_array', [
			rt.call_method(var_post_id, 'get_error_code', []rt.PhpVal{}),
			rt.create_array([rt.ArrayItem{ key: none, val: 'db_update_error' }]),
		]))
		{
			rt.call_method(var_post_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
		} else {
			rt.call_method(var_post_id, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]),
			])
		}
		return var_post_id.clone()
	}
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	this.update_additional_fields_for_object(var_post.clone(), var_request.clone())
	mut var_meta_fields := rt.new_bool(this.update_post_meta_fields(var_post.clone(),
		var_request.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_meta_fields.clone()])) {
		return var_meta_fields.clone()
	}
	rt.call_function('do_action', [
		rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type),
		var_post.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Posts_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
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
	var_args.array_set('date_query', rt.new_array())
	if var_request.array_isset(rt.new_string('before')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('before',
			var_request.array_get(rt.new_string('before')))
	}
	if var_request.array_isset(rt.new_string('after')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('after',
			var_request.array_get(rt.new_string('after')))
	}
	if rt.is_true(rt.identical(rt.new_string('wc/v1'), this.namespace)) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('filter')).is_array())) {
			var_args = rt.call_function('array_merge', [var_args.clone(),
				var_request.array_get(rt.new_string('filter'))])
			var_args.array_unset(rt.new_string('filter'))
		}
	}
	var_args.array_set('post_type', this.post_type)
	var_args = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type),
			rt.new_string('_query')),
		var_args.clone(),
		var_request.clone(),
	])
	mut var_query_args := this.prepare_items_query(var_args.clone(), var_request.clone())
	mut var_posts_query := create_wp_query()
	mut var_query_result := var_posts_query.query(var_query_args.clone())
	mut var_posts := rt.new_array()
	mut iter_1 := var_query_result.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
			this.post_type,
			rt.new_string('read'),
			rt.get_property(var_post, 'ID'),
		])))))
		{
			continue
		}
		mut var_data := this.prepare_item_for_response(var_post.clone(), var_request.clone())
		var_posts << this.prepare_response_for_collection(var_data.clone())
	}
	mut var_page := rt.new_int((var_query_args.array_get(rt.new_string('paged'))).to_i64())
	mut var_total_posts := rt.get_property(var_posts_query, 'found_posts')
	if rt.is_true(rt.less(var_total_posts, rt.new_int(1)))
		&& rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		var_query_args.array_unset(rt.new_string('paged'))
		mut var_count_query := create_wp_query()
		var_count_query.query(var_query_args.clone())
		var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	mut var_max_pages := rt.call_function('ceil', [
		rt.div(var_total_posts,
			rt.new_int((var_query_args.array_get(rt.new_string('posts_per_page'))).to_i64())),
	])
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_posts),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total_posts.to_i64())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(var_max_pages.to_i64())])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	if !(!rt.is_true(var_request_params.array_get(rt.new_string('filter')))) {
		var_request_params.array_get(rt.new_string('filter')).array_unset(rt.new_string('posts_per_page'))
		var_request_params.array_get(rt.new_string('filter')).array_unset(rt.new_string('paged'))
	}
	mut var_base := rt.call_function('add_query_arg', [var_request_params.clone(),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
		])])
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

fn (mut this Class_WC_REST_Posts_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_force := rt.new_bool((var_request.array_get(rt.new_string('force'))).to_bool())
	mut var_post := rt.call_function('get_post', [var_id.clone()])
	if !rt.is_true(var_id) || !rt.is_true(rt.get_property(var_post, 'ID'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_post, 'post_type'), this.post_type)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('ID is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_supports_trash := rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0))
	var_supports_trash = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type),
			rt.new_string('_trashable')),
		var_supports_trash.clone(),
		var_post.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		this.post_type,
		rt.new_string('delete'),
		rt.get_property(var_post, 'ID'),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.new_string('woocommerce_rest_user_cannot_delete_'),
			this.post_type), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to delete %s.'),
				rt.new_string('woocommerce'),
			]),
			this.post_type,
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		])))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	if rt.is_true(var_force) {
		mut var_result := rt.call_function('wp_delete_post', [
			var_id.clone(), rt.new_bool(true)])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %s does not support trashing.'),
					rt.new_string('woocommerce'),
				]),
				this.post_type,
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status'))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_already_trashed'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %s has already been deleted.'),
					rt.new_string('woocommerce'),
				]),
				this.post_type,
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
		}
		var_result = rt.call_function('wp_trash_post', [var_id.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('The %s cannot be deleted.'),
				rt.new_string('woocommerce')]),
			this.post_type,
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [
		rt.concat(rt.new_string('woocommerce_rest_delete_'), this.post_type),
		var_post.clone(),
		var_response.clone(),
		var_request.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Posts_Controller) prepare_links(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
					rt.get_property(var_post_mutated, 'ID')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Posts_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_valid_vars := rt.call_function('array_flip', [this.get_allowed_query_vars()])
	mut var_query_args := rt.new_array()
	mut iter_2 := var_valid_vars.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_index := item_2.val
		mut var_var := item_2.key
		if var_prepared_args.array_isset(var_var) {
			var_query_args.array_set(var_var, rt.call_function('apply_filters', [
				rt.new_string('woocommerce_rest_query_var-${var_var.to_string()}'),
				var_prepared_args.array_get(var_var),
			]))
		}
	}
	var_query_args.array_set('ignore_sticky_posts', true)
	if rt.is_true(rt.identical(rt.new_string('include'),
		var_query_args.array_get(rt.new_string('orderby'))))
	{
		var_query_args.array_set('orderby', 'post__in')
	} else if rt.is_true(rt.identical(rt.new_string('id'),
		var_query_args.array_get(rt.new_string('orderby'))))
	{
		var_query_args.array_set('orderby', 'ID')
	} else if rt.is_true(rt.identical(rt.new_string('slug'),
		var_query_args.array_get(rt.new_string('orderby'))))
	{
		var_query_args.array_set('orderby', 'name')
	}
	return var_query_args.clone()
}

fn (mut this Class_WC_REST_Posts_Controller) get_allowed_query_vars() rt.PhpVal {
	mut var_wp := rt.new_null()
	mut var_valid_vars := rt.call_function('apply_filters', [
		rt.new_string('query_vars'), rt.get_property(var_wp, 'public_query_vars')])
	mut var_post_type_obj := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_posts'),
	]))
	{
		mut var_private := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_rest_private_query_vars'),
			rt.get_property(var_wp, 'private_query_vars'),
		])
		var_valid_vars = rt.call_function('array_merge', [var_valid_vars.clone(),
			var_private.clone()])
	}
	mut var_rest_valid := ['date_query', 'ignore_sticky_posts', 'offset', 'post__in', 'post__not_in',
		'post_parent', 'post_parent__in', 'post_parent__not_in', 'posts_per_page', 'meta_query',
		'tax_query', 'meta_key', 'meta_value', 'meta_compare', 'meta_value_num']
	var_valid_vars = rt.call_function('array_merge', [var_valid_vars.clone(),
		rt.create_array_from_list(var_rest_valid)])
	var_valid_vars = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_query_vars'),
		var_valid_vars.clone(),
	])
	return var_valid_vars.clone()
}

fn (mut this Class_WC_REST_Posts_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Controller.get_collection_params()
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published after a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published before a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('exclude', rt.create_array([
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
	]))
	var_params.array_set('include', rt.create_array([
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
	]))
	var_params.array_set('offset', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('order', rt.create_array([
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
	]))
	var_params.array_set('orderby', rt.create_array([
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
	]))
	mut var_post_type_obj := rt.call_function('get_post_type_object', [this.post_type])
	if !(rt.get_property(var_post_type_obj, 'hierarchical')).is_null()
		&& rt.is_true(rt.get_property(var_post_type_obj, 'hierarchical')) {
		var_params.array_set('parent', rt.create_array([
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
		]))
		var_params.array_set('parent_exclude', rt.create_array([
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
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('wc/v1'), this.namespace)) {
		var_params.array_set('filter', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Use WP Query arguments to modify the response; private query vars require appropriate authorization.'),
				rt.new_string('woocommerce'),
			]) },
		]))
	}
	return var_params.clone()
}

fn (mut this Class_WC_REST_Posts_Controller) update_post_meta_fields(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
	return true
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wc_rest_posts_controller(_args ...rt.PhpVal) &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('')
		post_type:     rt.new_string('')
		public:        rt.new_bool(false)
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn (mut this Class_WC_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
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
		'batch_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.batch_items_permissions_check(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'add_post_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.add_post_meta_fields(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_post(dispatch_arg_0)
			return rt.new_null()
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_items_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_allowed_query_vars' {
			return this.get_allowed_query_vars()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'update_post_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_post_meta_fields(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		'public' { return this.public }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'post_type' {
			this.post_type = val
			return true
		}
		'public' {
			this.public = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
