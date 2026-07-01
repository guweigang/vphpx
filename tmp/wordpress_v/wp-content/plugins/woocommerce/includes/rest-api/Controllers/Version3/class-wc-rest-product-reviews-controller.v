import rt

struct Class_WC_REST_Product_Reviews_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		rest_base rt.PhpVal = rt.new_string('products/reviews')
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'review', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Review content.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'reviewer', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Name of the reviewer.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'reviewer_email', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email of the reviewer.'), rt.new_string('woocommerce')]) }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review := this.get_review(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.call_function('is_wp_error', [var_review.dup()])) {
		return (var_review).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [rt.new_string('read'), // unsupported expression: Expr_Cast_Int]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [rt.new_string('create')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review := this.get_review(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.call_function('is_wp_error', [var_review.dup()])) {
		return (var_review).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [rt.new_string('edit'), // unsupported expression: Expr_Cast_Int]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you cannot edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review := this.get_review(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.call_function('is_wp_error', [var_review.dup()])) {
		return (var_review).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [rt.new_string('delete'), // unsupported expression: Expr_Cast_Int]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you cannot delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [rt.new_string('batch')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_registered := this.get_collection_params()
	mut var_parameter_mappings := { 'reviewer': 'author__in', 'reviewer_email': 'author_email', 'reviewer_exclude': 'author__not_in', 'exclude': 'comment__not_in', 'include': 'comment__in', 'offset': 'offset', 'order': 'order', 'per_page': 'number', 'product': 'post__in', 'search': 'search', 'status': 'status' }
	mut var_prepared_args := rt.new_array()
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param)) && var_request.array_isset(rt.new_string(api_param)) {
			var_prepared_args.array_set(wp_param, var_request.array_get(api_param))
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'author_email' }, rt.ArrayItem{ key: none, val: 'search' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param := item_1.val
			if !(var_prepared_args.array_isset(var_param)) {
				var_prepared_args.array_set(var_param, '')
			}
		}
	}
	if var_registered.array_isset(rt.new_string('orderby')) {
		var_prepared_args.array_set('orderby', this.normalize_query_param(var_request.array_get('orderby')))
	}
	if var_prepared_args.array_isset(rt.new_string('status')) {
		var_prepared_args.array_set('status', if rt.is_true(rt.identical(rt.new_string('approved'), var_prepared_args.array_get('status'))) { rt.new_string('approve') } else { var_prepared_args.array_get('status') })
	}
	var_prepared_args.array_set('no_found_rows', false)
	var_prepared_args.array_set('date_query', rt.new_array())
	if var_registered.array_isset(rt.new_string('before')) && var_request.array_isset(rt.new_string('before')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('before', var_request.array_get('before'))
	}
	if var_registered.array_isset(rt.new_string('after')) && var_request.array_isset(rt.new_string('after')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('after', var_request.array_get('after'))
	}
	if var_registered.array_isset(rt.new_string('page')) && !rt.is_true(var_request.array_get('offset')) {
		var_prepared_args.array_set('offset', rt.mul(var_prepared_args.array_get('number'), rt.sub(rt.call_function('absint', [var_request.array_get('page')]), rt.new_int(1))))
	}
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_product_review_query'), var_prepared_args.dup(), var_request.dup()])
	var_prepared_args.array_set('type', 'review')
	mut var_query := create_wp_comment_query()
	mut var_query_result := var_query.query(var_prepared_args.dup())
	mut var_reviews := rt.new_array()
	{
		mut iter_1 := var_query_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_review := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [rt.new_string('read'), rt.get_property(var_review, 'comment_ID')]))))) {
				continue
			}
			mut var_data := this.prepare_item_for_response(var_review.dup(), var_request.dup())
			var_reviews << this.prepare_response_for_collection(var_data.dup())
		}
	}
	mut var_total_reviews := // unsupported expression: Expr_Cast_Int
	mut var_max_pages := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less(var_total_reviews, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		var_query = create_wp_comment_query()
		var_prepared_args.array_set('count', true)
		var_total_reviews = var_query.query(var_prepared_args.dup())
		var_max_pages = rt.call_function('ceil', [rt.div(var_total_reviews, var_request.array_get('per_page'))])
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_reviews.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total_reviews.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), var_max_pages.dup()])
	mut var_base := rt.call_function('add_query_arg', [rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), this.namespace, this.rest_base])])])
	if rt.is_true(rt.greater(var_request.array_get('page'), rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_request.array_get('page'), rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.dup()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_request.array_get('page'))) {
		mut var_next_page := rt.add(var_request.array_get('page'), rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return create_wp_error(rt.new_string('woocommerce_rest_review_exists'), rt.call_function('__', [rt.new_string('Cannot create existing product review.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_product_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [rt.new_string('Invalid product ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_prepared_review := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_review.dup()])) {
		return var_prepared_review.dup()
	}
	var_prepared_review.array_set('comment_type', 'review')
	if !rt.is_true(var_prepared_review.array_get('comment_content')) {
		return create_wp_error(rt.new_string('woocommerce_rest_review_content_invalid'), rt.call_function('__', [rt.new_string('Invalid review content.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(var_prepared_review.array_isset(rt.new_string('comment_date_gmt'))) {
		var_prepared_review.array_set('comment_date_gmt', rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]))
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR'))) && rt.is_true(rt.call_function('rest_is_ip_address', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR')])])))) {
		var_prepared_review.array_set('comment_author_IP', rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR')])]))
		// unsupported statement: Stmt_Nop
	} else {
		var_prepared_review.array_set('comment_author_IP', '127.0.0.1')
	}
	if !(!rt.is_true(var_request.array_get('author_user_agent'))) {
		var_prepared_review.array_set('comment_agent', var_request.array_get('author_user_agent'))
	} else if rt.is_true(rt.call_method(var_request, 'get_header', [rt.new_string('user_agent')])) {
		var_prepared_review.array_set('comment_agent', rt.call_method(var_request, 'get_header', [rt.new_string('user_agent')]))
	} else {
		var_prepared_review.array_set('comment_agent', '')
	}
	mut var_check_comment_lengths := rt.call_function('wp_check_comment_data_max_lengths', [var_prepared_review.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_check_comment_lengths.dup()])) {
		mut var_error_code := rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'comment_author' }, rt.ArrayItem{ key: none, val: 'comment_content' }]), rt.create_array([rt.ArrayItem{ key: none, val: 'reviewer' }, rt.ArrayItem{ key: none, val: 'review_content' }]), rt.call_method(var_check_comment_lengths, 'get_error_code', []rt.PhpVal{})])
		return create_wp_error('woocommerce_rest_' + (var_error_code).str(), rt.call_function('__', [rt.new_string('Product review field exceeds maximum length allowed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	var_prepared_review.array_set('comment_parent', 0)
	var_prepared_review.array_set('comment_author_url', '')
	var_prepared_review.array_set('comment_approved', rt.call_function('wp_allow_comment', [var_prepared_review.dup(), rt.new_bool(true)]))
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_review.array_get('comment_approved')])) {
		var_error_code = rt.call_method(var_prepared_review.array_get('comment_approved'), 'get_error_code', []rt.PhpVal{})
		mut var_error_message := rt.call_method(var_prepared_review.array_get('comment_approved'), 'get_error_message', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('comment_duplicate'), var_error_code)) {
			return create_wp_error('woocommerce_rest_' + (var_error_code).str(), var_error_message.dup(), rt.create_array([rt.ArrayItem{ key: 'status', val: 409 }]))
		}
		if rt.is_true(rt.identical(rt.new_string('comment_flood'), var_error_code)) {
			return create_wp_error('woocommerce_rest_' + (var_error_code).str(), var_error_message.dup(), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		return var_prepared_review.array_get('comment_approved')
	}
	var_prepared_review = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_pre_insert_product_review'), var_prepared_review.dup(), var_request.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_review.dup()])) {
		return var_prepared_review.dup()
	}
	mut var_review_id := rt.call_function('wp_insert_comment', [rt.call_function('wp_filter_comment', [rt.call_function('wp_slash', [rt.cast_array(var_prepared_review)])])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_review_id)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_review_failed_create'), rt.call_function('__', [rt.new_string('Creating product review failed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	if var_request.array_isset(rt.new_string('status')) {
		this.handle_status_param(var_request.array_get('status'), var_review_id.dup())
	}
	rt.call_function('update_comment_meta', [var_review_id.dup(), rt.new_string('rating'), if !(!rt.is_true(var_request.array_get('rating'))) { var_request.array_get('rating') } else { rt.new_string('0') }])
	if var_request.array_isset(rt.new_string('verified')) && !(!rt.is_true(var_request.array_get('verified'))) {
		rt.call_function('update_comment_meta', [var_review_id.dup(), rt.new_string('verified'), .array_get()])
	}
	mut var_review := rt.call_function('get_comment', [.dup()])
	rt.call_function('do_action', [, .dup(), .dup(), ])
	
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_item_for_response(var_review rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_review_mutated := var_review
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_links(var_review rt.PhpVal) rt.PhpVal {
	mut var_review_mutated := var_review
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_review(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) normalize_query_param(var_query_param rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_status_response(var_comment_approved rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) handle_status_param(var_new_status rt.PhpVal, var_id rt.PhpVal) bool {
	mut var_id_mutated := var_id
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_wc_rest_product_reviews_controller() &Class_WC_REST_Product_Reviews_Controller {
	mut obj := &Class_WC_REST_Product_Reviews_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('products/reviews')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn create_wp_comment_query() &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'batch_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.batch_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_review' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_review(dispatch_arg_0)
		}
		'normalize_query_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.normalize_query_param(dispatch_arg_0)
		}
		'prepare_status_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_status_response(dispatch_arg_0)
		}
		'handle_status_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.handle_status_param(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Product_Reviews_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_product_reviews_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
