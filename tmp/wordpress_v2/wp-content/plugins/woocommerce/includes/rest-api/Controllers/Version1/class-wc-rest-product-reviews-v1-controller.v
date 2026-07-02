import rt

struct Class_WC_REST_Product_Reviews_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('products/(?P<product_id>[\\d]+)/reviews')
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the variable product.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the variation.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [
					this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()),
					rt.create_array([
						rt.ArrayItem{ key: 'review', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Review content.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
						rt.ArrayItem{ key: 'name', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Name of the reviewer.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
						rt.ArrayItem{ key: 'email', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Email of the reviewer.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
					]),
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the variable product.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to bypass trash and force deletion.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
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

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review := this.get_review(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64()))
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
		rt.new_string('read'),
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
	])))))
	{
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

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
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

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review := this.get_review(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64()))
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
		rt.new_string('edit'),
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot edit this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review := this.get_review(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64()))
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
		rt.new_string('delete'),
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot delete this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [
		var_product_id.clone(),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid product ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_reviews := rt.call_function('get_approved_comments', [
		var_product_id.clone()])
	mut var_data := rt.new_array()
	mut iter_1 := var_reviews.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_review_data := item_1.val
		mut var_review := this.prepare_item_for_response(var_review_data.clone(),
			var_request.clone())
		var_review = this.prepare_response_for_collection(var_review.clone())
		var_data.array_push(var_review.clone())
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) get_review(id i64, product_id i64) rt.PhpVal {
	mut product_id_mutated := product_id
	if 0 >= product_id_mutated
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.new_int(product_id_mutated).clone()]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid product ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_review := if 0 <= id { rt.call_function('get_comment', [
			rt.new_int(id)]) } else { rt.new_null() }
	if !rt.is_true(var_review) || !rt.is_true(rt.get_property(var_review, 'comment_ID'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('review'), rt.call_function('get_comment_type', [rt.new_int(id)])))))
		|| !rt.is_true(rt.get_property(var_review, 'comment_post_ID'))
		|| rt.is_true(rt.new_bool(rt.new_int((rt.get_property(var_review, 'comment_post_ID')).to_i64()) != product_id_mutated)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_review_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid product review ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return var_review.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_review := this.get_review(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64()))
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.clone()
	}
	mut var_delivery := this.prepare_item_for_response(var_review.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_delivery.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [
		var_product_id.clone(),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid product ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_prepared_review := this.prepare_item_for_database(var_request.clone())
	var_prepared_review = rt.call_function('apply_filters', [
		rt.new_string('rest_pre_insert_product_review'),
		var_prepared_review.clone(),
		var_request.clone(),
	])
	mut var_product_review_id := rt.call_function('wp_insert_comment', [
		var_prepared_review.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_review_id)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_product_review_failed_create'), rt.call_function('__', [
			rt.new_string('Creating product review failed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('update_comment_meta', [var_product_review_id.clone(),
		rt.new_string('rating'), if !(!rt.is_true(var_request.array_get(rt.new_string('rating')))) {
			var_request.array_get(rt.new_string('rating'))
		} else {
			rt.new_string('0')
		}])
	mut var_product_review := rt.call_function('get_comment', [
		var_product_review_id.clone()])
	this.update_additional_fields_for_object(var_product_review.clone(), var_request.clone())
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_product_review'),
		var_product_review.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_product_review.clone(),
		var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	mut var_base := rt.call_function('str_replace', [
		rt.new_string('(?P<product_id>[\\d]+)'),
		var_product_id.clone(),
		this.rest_base,
	])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, var_base.clone(),
				var_product_review_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_review_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_product_id := rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64())
	mut var_review := this.get_review(var_product_review_id.to_i64(), var_product_id.to_i64())
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.clone()
	}
	mut var_prepared_review := this.prepare_item_for_database(var_request.clone())
	mut var_updated := rt.call_function('wp_update_comment', [
		var_prepared_review.clone()])
	if rt.is_true(rt.identical(rt.new_int(0), var_updated)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_product_review_failed_edit'), rt.call_function('__', [
			rt.new_string('Updating product review failed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('rating')))) {
		rt.call_function('update_comment_meta', [var_product_review_id.clone(),
			rt.new_string('rating'), var_request.array_get(rt.new_string('rating'))])
	}
	mut var_product_review := rt.call_function('get_comment', [
		var_product_review_id.clone()])
	this.update_additional_fields_for_object(var_product_review.clone(), var_request.clone())
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_product_review'),
		var_product_review.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_product_review.clone(),
		var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64())
	mut var_product_review_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_product_review := this.get_review(var_product_review_id.to_i64(),
		var_product_id.to_i64())
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.call_function('is_wp_error', [var_product_review.clone()])) {
		return var_product_review.clone()
	}
	mut var_supports_trash := rt.call_function('apply_filters', [
		rt.new_string('rest_product_review_trashable'),
		rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0)),
		var_product_review.clone(),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_product_review.clone(),
		var_request.clone())
	if rt.is_true(var_force) {
		mut var_result := rt.call_function('wp_delete_comment', [
			var_product_review_id.clone(), rt.new_bool(true)])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('__', [
				rt.new_string('The product review does not support trashing.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_product_review,
			'comment_approved')))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_already_trashed'), rt.call_function('__', [
				rt.new_string('The comment has already been trashed.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
		}
		var_result = rt.call_function('wp_trash_comment', [
			rt.get_property(var_product_review, 'comment_ID'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The product review cannot be deleted.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [rt.new_string('rest_delete_product_review'),
		var_product_review.clone(), var_response.clone(), var_request.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) prepare_item_for_response(var_review rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_review_mutated := var_review
	mut var_data := rt.create_array([
		rt.ArrayItem{
			key: 'id'
			val: rt.new_int((rt.get_property(var_review_mutated, 'comment_ID')).to_i64())
		},
		rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_review_mutated, 'comment_date_gmt'),
		]) },
		rt.ArrayItem{ key: 'review', val: rt.get_property(var_review_mutated, 'comment_content') },
		rt.ArrayItem{ key: 'rating', val: rt.new_int((rt.call_function('get_comment_meta', [
			rt.get_property(var_review_mutated, 'comment_ID'),
			rt.new_string('rating'),
			rt.new_bool(true),
		])).to_i64()) },
		rt.ArrayItem{ key: 'name', val: rt.get_property(var_review_mutated, 'comment_author') },
		rt.ArrayItem{ key: 'email', val: rt.get_property(var_review_mutated, 'comment_author_email') },
		rt.ArrayItem{ key: 'verified', val: rt.call_function('wc_review_is_from_verified_owner', [
			rt.get_property(var_review_mutated, 'comment_ID'),
		]) },
	])
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_review_mutated.clone(), var_request.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_product_review'),
		var_response.clone(),
		var_review_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_review := rt.create_array([
		rt.ArrayItem{ key: 'comment_approved', val: 1 },
		rt.ArrayItem{ key: 'comment_type', val: 'review' },
	])
	if var_request.array_isset(rt.new_string('id')) {
		var_prepared_review.array_set('comment_ID',
			rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	}
	if var_request.array_isset(rt.new_string('review')) {
		var_prepared_review.array_set('comment_content',
			var_request.array_get(rt.new_string('review')))
	}
	if var_request.array_isset(rt.new_string('product_id')) {
		var_prepared_review.array_set('comment_post_ID',
			rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64()))
	}
	if var_request.array_isset(rt.new_string('name')) {
		var_prepared_review.array_set('comment_author',
			var_request.array_get(rt.new_string('name')))
	}
	if var_request.array_isset(rt.new_string('email')) {
		var_prepared_review.array_set('comment_author_email',
			var_request.array_get(rt.new_string('email')))
	}
	if var_request.array_isset(rt.new_string('date_created')) {
		var_prepared_review.array_set('comment_date',
			var_request.array_get(rt.new_string('date_created')))
	}
	if var_request.array_isset(rt.new_string('date_created_gmt')) {
		var_prepared_review.array_set('comment_date_gmt',
			var_request.array_get(rt.new_string('date_created_gmt')))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('rest_preprocess_product_review'),
		var_prepared_review.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) prepare_links(var_review rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_review_mutated := var_review
	mut var_product_id := rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64())
	mut var_base := rt.call_function('str_replace', [
		rt.new_string('(?P<product_id>[\\d]+)'),
		var_product_id.clone(),
		this.rest_base,
	])
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
					var_base.clone(), rt.get_property(var_review_mutated, 'comment_ID')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, var_base.clone()]),
			])
		}
		'up':         {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), this.namespace,
					var_product_id.clone()]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('product_review')
		'type':       rt.new_string('object')
		'properties': {
			'id':           {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'review':       {
				'description': rt.call_function('__', [
					rt.new_string('The content of the review.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'date_created': {
				'description': rt.call_function('__', [
					rt.new_string("The date the review was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
			}
			'rating':       {
				'description': rt.call_function('__', [
					rt.new_string('Review rating (0 to 5).'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'name':         {
				'description': rt.call_function('__', [rt.new_string('Reviewer name.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'email':        {
				'description': rt.call_function('__', [rt.new_string('Reviewer email.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'verified':     {
				'description': rt.call_function('__', [
					rt.new_string('Shows if the reviewer bought the product or not.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_product_reviews_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Reviews_V1_Controller {
	mut obj := &Class_WC_REST_Product_Reviews_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('products/(?P<product_id>[\\d]+)/reviews')
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

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_review' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_review(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Product_Reviews_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
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
