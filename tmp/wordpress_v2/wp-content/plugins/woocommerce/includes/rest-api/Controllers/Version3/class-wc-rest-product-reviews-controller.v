import rt

struct Class_WC_REST_Product_Reviews_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('products/reviews')
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [
					this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()),
					rt.create_array([
						rt.ArrayItem{ key: 'product_id', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Unique identifier for the product.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'integer' },
						]) },
						rt.ArrayItem{ key: 'review', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Review content.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
						rt.ArrayItem{ key: 'reviewer', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Name of the reviewer.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
						rt.ArrayItem{ key: 'reviewer_email', val: rt.create_array([
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
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
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
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/batch'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_batch_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
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

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review :=
		this.get_review(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
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

fn (mut this Class_WC_REST_Product_Reviews_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
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

fn (mut this Class_WC_REST_Product_Reviews_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review :=
		this.get_review(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
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

fn (mut this Class_WC_REST_Product_Reviews_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_review :=
		this.get_review(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
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

fn (mut this Class_WC_REST_Product_Reviews_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
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

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_registered := this.get_collection_params()
	mut var_parameter_mappings := {
		'reviewer':         'author__in'
		'reviewer_email':   'author_email'
		'reviewer_exclude': 'author__not_in'
		'exclude':          'comment__not_in'
		'include':          'comment__in'
		'offset':           'offset'
		'order':            'order'
		'per_page':         'number'
		'product':          'post__in'
		'search':           'search'
		'status':           'status'
	}
	mut var_prepared_args := rt.new_array()
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param))
			&& var_request.array_isset(rt.new_string(api_param)) {
			var_prepared_args.array_set(wp_param, var_request.array_get(rt.new_string(api_param)))
		}
	}
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'author_email' },
		rt.ArrayItem{ key: none, val: 'search' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_param := item_1.val
		if !(var_prepared_args.array_isset(var_param)) {
			var_prepared_args.array_set(var_param, '')
		}
	}
	if var_registered.array_isset(rt.new_string('orderby')) {
		var_prepared_args.array_set('orderby',
			this.normalize_query_param(var_request.array_get(rt.new_string('orderby'))))
	}
	if var_prepared_args.array_isset(rt.new_string('status')) {
		var_prepared_args.array_set('status', if rt.is_true(rt.identical(rt.new_string('approved'),
			var_prepared_args.array_get(rt.new_string('status'))))
		{
			rt.new_string('approve')
		} else {
			var_prepared_args.array_get(rt.new_string('status'))
		})
	}
	var_prepared_args.array_set('no_found_rows', false)
	var_prepared_args.array_set('date_query', rt.new_array())
	if var_registered.array_isset(rt.new_string('before'))
		&& var_request.array_isset(rt.new_string('before')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('before',
			var_request.array_get(rt.new_string('before')))
	}
	if var_registered.array_isset(rt.new_string('after'))
		&& var_request.array_isset(rt.new_string('after')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('after',
			var_request.array_get(rt.new_string('after')))
	}
	if var_registered.array_isset(rt.new_string('page'))
		&& !rt.is_true(var_request.array_get(rt.new_string('offset'))) {
		var_prepared_args.array_set('offset', rt.mul(var_prepared_args.array_get(rt.new_string('number')), rt.sub(rt.call_function('absint', [
			var_request.array_get(rt.new_string('page')),
		]), rt.new_int(1))))
	}
	var_prepared_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_product_review_query'),
		var_prepared_args.clone(),
		var_request.clone(),
	])
	var_prepared_args.array_set('type', 'review')
	mut var_query := create_wp_comment_query()
	mut var_query_result := var_query.query(var_prepared_args.clone())
	mut var_reviews := rt.new_array()
	mut iter_2 := var_query_result.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_review := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
			rt.new_string('read'),
			rt.get_property(var_review, 'comment_ID'),
		])))))
		{
			continue
		}
		mut var_data := this.prepare_item_for_response(var_review.clone(), var_request.clone())
		var_reviews << this.prepare_response_for_collection(var_data.clone())
	}
	mut var_total_reviews := rt.new_int((rt.get_property(var_query, 'found_comments')).to_i64())
	mut var_max_pages := rt.new_int((rt.get_property(var_query, 'max_num_pages')).to_i64())
	if rt.is_true(rt.less(var_total_reviews, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		var_query = create_wp_comment_query()
		var_prepared_args.array_set('count', true)
		var_total_reviews = var_query.query(var_prepared_args.clone())
		var_max_pages = rt.call_function('ceil', [
			rt.div(var_total_reviews, var_request.array_get(rt.new_string('per_page'))),
		])
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_reviews),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		var_total_reviews.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		var_max_pages.clone()])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s'), this.namespace, this.rest_base]),
		]),
	])
	if rt.is_true(rt.greater(var_request.array_get(rt.new_string('page')), rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_request.array_get(rt.new_string('page')), rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_request.array_get(rt.new_string('page')))) {
		mut var_next_page := rt.add(var_request.array_get(rt.new_string('page')), rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return create_wp_error(rt.new_string('woocommerce_rest_review_exists'), rt.call_function('__', [
			rt.new_string('Cannot create existing product review.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_product_id := rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [
		var_product_id.clone(),
	])))))
	{
		return create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid product ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_prepared_review := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_review.clone()])) {
		return var_prepared_review.clone()
	}
	var_prepared_review.array_set('comment_type', 'review')
	if !rt.is_true(var_prepared_review.array_get(rt.new_string('comment_content'))) {
		return create_wp_error(rt.new_string('woocommerce_rest_review_content_invalid'), rt.call_function('__', [
			rt.new_string('Invalid review content.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(var_prepared_review.array_isset(rt.new_string('comment_date_gmt'))) {
		var_prepared_review.array_set('comment_date_gmt', rt.call_function('current_time', [
			rt.new_string('mysql'),
			rt.new_bool(true),
		]))
	}
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))))
		&& rt.is_true(rt.call_function('rest_is_ip_address', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))])])) {
		var_prepared_review.array_set('comment_author_IP', rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))]),
		]))
	} else {
		var_prepared_review.array_set('comment_author_IP', '127.0.0.1')
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('author_user_agent')))) {
		var_prepared_review.array_set('comment_agent',
			var_request.array_get(rt.new_string('author_user_agent')))
	} else if rt.is_true(rt.call_method(var_request, 'get_header', [
		rt.new_string('user_agent'),
	]))
	{
		var_prepared_review.array_set('comment_agent', rt.call_method(var_request, 'get_header', [
			rt.new_string('user_agent'),
		]))
	} else {
		var_prepared_review.array_set('comment_agent', '')
	}
	mut var_check_comment_lengths := rt.call_function('wp_check_comment_data_max_lengths', [
		var_prepared_review.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_check_comment_lengths.clone()])) {
		mut var_error_code := rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'comment_author' },
				rt.ArrayItem{ key: none, val: 'comment_content' }]),
			rt.create_array([rt.ArrayItem{ key: none, val: 'reviewer' },
				rt.ArrayItem{ key: none, val: 'review_content' }]),
			rt.call_method(var_check_comment_lengths, 'get_error_code', []rt.PhpVal{}),
		])
		return create_wp_error('woocommerce_rest_' + var_error_code.str(), rt.call_function('__', [
			rt.new_string('Product review field exceeds maximum length allowed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	var_prepared_review.array_set('comment_parent', 0)
	var_prepared_review.array_set('comment_author_url', '')
	var_prepared_review.array_set('comment_approved', rt.call_function('wp_allow_comment', [
		var_prepared_review.clone(),
		rt.new_bool(true),
	]))
	if rt.is_true(rt.call_function('is_wp_error', [
		var_prepared_review.array_get(rt.new_string('comment_approved')),
	]))
	{
		var_error_code = rt.call_method(var_prepared_review.array_get(rt.new_string('comment_approved')),
			'get_error_code', []rt.PhpVal{})
		mut var_error_message := rt.call_method(var_prepared_review.array_get(rt.new_string('comment_approved')),
			'get_error_message', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('comment_duplicate'), var_error_code)) {
			return create_wp_error('woocommerce_rest_' + var_error_code.str(),
				var_error_message.clone(), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 409 },
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('comment_flood'), var_error_code)) {
			return create_wp_error('woocommerce_rest_' + var_error_code.str(),
				var_error_message.clone(), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 400 },
			]))
		}
		return var_prepared_review.array_get(rt.new_string('comment_approved'))
	}
	var_prepared_review = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_pre_insert_product_review'),
		var_prepared_review.clone(),
		var_request.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_review.clone()])) {
		return var_prepared_review.clone()
	}
	mut var_review_id := rt.call_function('wp_insert_comment', [
		rt.call_function('wp_filter_comment', [
			rt.call_function('wp_slash', [rt.cast_array(var_prepared_review)]),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_review_id)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_review_failed_create'), rt.call_function('__', [
			rt.new_string('Creating product review failed.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	if var_request.array_isset(rt.new_string('status')) {
		this.handle_status_param(var_request.array_get(rt.new_string('status')),
			var_review_id.clone())
	}
	rt.call_function('update_comment_meta', [var_review_id.clone(),
		rt.new_string('rating'), if !(!rt.is_true(var_request.array_get(rt.new_string('rating')))) {
			var_request.array_get(rt.new_string('rating'))
		} else {
			rt.new_string('0')
		}])
	if var_request.array_isset(rt.new_string('verified'))
		&& !(!rt.is_true(var_request.array_get(rt.new_string('verified')))) {
		rt.call_function('update_comment_meta', [var_review_id.clone(),
			rt.new_string('verified'), var_request.array_get(rt.new_string('verified'))])
	}
	mut var_review := rt.call_function('get_comment', [var_review_id.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_product_review'),
		var_review.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	mut var_fields_update := this.update_additional_fields_for_object(var_review.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	mut var_context := rt.new_string((if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('moderate_comments'),
	]))
	{ 'edit' } else { 'view' }).str())
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		var_context.clone()])
	mut var_response := this.prepare_item_for_response(var_review.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s/%d'), this.namespace, this.rest_base,
				var_review_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_review := this.get_review(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.clone()
	}
	mut var_data := this.prepare_item_for_response(var_review.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_review := this.get_review(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.clone()
	}
	mut var_id := rt.new_int((rt.get_property(var_review, 'comment_ID')).to_i64())
	if var_request.array_isset(rt.new_string('type'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('review'), rt.call_function('get_comment_type', [var_id.clone()]))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_review_invalid_type'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to change the comment type.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_prepared_args := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_args.clone()])) {
		return var_prepared_args.clone()
	}
	if !(!rt.is_true(var_prepared_args.array_get(rt.new_string('comment_post_ID')))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [
			rt.new_int((var_prepared_args.array_get(rt.new_string('comment_post_ID'))).to_i64()),
		])))))
		{
			return create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [
				rt.new_string('Invalid product ID.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
		}
	}
	if !rt.is_true(var_prepared_args) && var_request.array_isset(rt.new_string('status')) {
		mut var_change := rt.new_bool(this.handle_status_param(var_request.array_get(rt.new_string('status')),
			var_id.clone()))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_change)))) {
			return create_wp_error(rt.new_string('woocommerce_rest_review_failed_edit'), rt.call_function('__', [
				rt.new_string('Updating review status failed.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		}
	} else if !(!rt.is_true(var_prepared_args)) {
		if rt.is_true(rt.call_function('is_wp_error', [var_prepared_args.clone()])) {
			return var_prepared_args.clone()
		}
		if var_prepared_args.array_isset(rt.new_string('comment_content'))
			&& !rt.is_true(var_prepared_args.array_get(rt.new_string('comment_content'))) {
			return create_wp_error(rt.new_string('woocommerce_rest_review_content_invalid'), rt.call_function('__', [
				rt.new_string('Invalid review content.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		var_prepared_args.array_set('comment_ID', var_id.clone())
		mut var_check_comment_lengths := rt.call_function('wp_check_comment_data_max_lengths', [
			var_prepared_args.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_check_comment_lengths.clone()])) {
			mut var_error_code := rt.call_function('str_replace', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'comment_author' },
					rt.ArrayItem{ key: none, val: 'comment_content' }]),
				rt.create_array([rt.ArrayItem{ key: none, val: 'reviewer' },
					rt.ArrayItem{ key: none, val: 'review_content' }]),
				rt.call_method(var_check_comment_lengths, 'get_error_code', []rt.PhpVal{}),
			])
			return create_wp_error('woocommerce_rest_' + var_error_code.str(), rt.call_function('__', [
				rt.new_string('Product review field exceeds maximum length allowed.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		mut var_updated := rt.call_function('wp_update_comment', [
			rt.call_function('wp_slash', [rt.cast_array(var_prepared_args)]),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_updated)) {
			return create_wp_error(rt.new_string('woocommerce_rest_comment_failed_edit'), rt.call_function('__', [
				rt.new_string('Updating review failed.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		}
		if var_request.array_isset(rt.new_string('status')) {
			this.handle_status_param(var_request.array_get(rt.new_string('status')), var_id.clone())
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('rating')))) {
		rt.call_function('update_comment_meta', [var_id.clone(),
			rt.new_string('rating'), var_request.array_get(rt.new_string('rating'))])
	}
	if var_request.array_isset(rt.new_string('verified'))
		&& !(!rt.is_true(var_request.array_get(rt.new_string('verified')))) {
		rt.call_function('update_comment_meta', [var_id.clone(),
			rt.new_string('verified'), var_request.array_get(rt.new_string('verified'))])
	}
	var_review = rt.call_function('get_comment', [var_id.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_product_review'),
		var_review.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	mut var_fields_update := this.update_additional_fields_for_object(var_review.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_review.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_review := this.get_review(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_review.clone()])) {
		return var_review.clone()
	}
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	mut var_supports_trash := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_product_review_trashable'),
		rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0)),
		var_review.clone(),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	if rt.is_true(var_force) {
		mut var_previous := this.prepare_item_for_response(var_review.clone(), var_request.clone())
		mut var_result := rt.call_function('wp_delete_comment', [
			rt.get_property(var_review, 'comment_ID'),
			rt.new_bool(true),
		])
		mut var_response := create_wp_rest_response()
		rt.call_method(var_response, 'set_data', [
			rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
				rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data',
					[]rt.PhpVal{}) }]),
		])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("The object does not support trashing. Set '%s' to delete."),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('force=true'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_review,
			'comment_approved')))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_already_trashed'), rt.call_function('__', [
				rt.new_string('The object has already been trashed.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
		}
		var_result = rt.call_function('wp_trash_comment', [
			rt.get_property(var_review, 'comment_ID'),
		])
		var_review = rt.call_function('get_comment', [
			rt.get_property(var_review, 'comment_ID'),
		])
		var_response = this.prepare_item_for_response(var_review.clone(), var_request.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The object cannot be deleted.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_delete_review'),
		var_review.clone(), var_response.clone(), var_request.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_item_for_response(var_review rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_review_mutated := var_review
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [rt.new_string('id'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('id',
			rt.new_int((rt.get_property(var_review_mutated, 'comment_ID')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_created'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('date_created', rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_review_mutated, 'comment_date'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_created_gmt'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('date_created_gmt', rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_review_mutated, 'comment_date_gmt'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('product_id'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('product_id', rt.new_int((rt.get_property(var_review_mutated,
			'comment_post_ID')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('product_name'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('product_name', rt.call_function('get_the_title', [
			rt.new_int((rt.get_property(var_review_mutated, 'comment_post_ID')).to_i64()),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('product_permalink'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('product_permalink', rt.call_function('get_permalink', [
			rt.new_int((rt.get_property(var_review_mutated, 'comment_post_ID')).to_i64()),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('status'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('status', this.prepare_status_response(rt.new_string((rt.get_property(var_review_mutated,
			'comment_approved')).str())))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('reviewer'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('reviewer', rt.get_property(var_review_mutated, 'comment_author'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('reviewer_email'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('reviewer_email', rt.get_property(var_review_mutated,
			'comment_author_email'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('review'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('review', if rt.is_true(rt.identical(rt.new_string('view'), var_context)) { rt.call_function('wpautop', [
				rt.get_property(var_review_mutated, 'comment_content'),
			]) } else { rt.get_property(var_review_mutated, 'comment_content') })
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('rating'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('rating', rt.new_int((rt.call_function('get_comment_meta', [
			rt.get_property(var_review_mutated, 'comment_ID'),
			rt.new_string('rating'),
			rt.new_bool(true),
		])).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('verified'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('verified', rt.call_function('wc_review_is_from_verified_owner', [
			rt.get_property(var_review_mutated, 'comment_ID'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('reviewer_avatar_urls'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('reviewer_avatar_urls', rt.call_function('rest_get_avatar_urls', [
			rt.get_property(var_review_mutated, 'comment_author_email'),
		]))
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_review_mutated.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_product_review'),
		var_response.clone(),
		var_review_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_review := rt.new_array()
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
	if var_request.array_isset(rt.new_string('reviewer')) {
		var_prepared_review.array_set('comment_author',
			var_request.array_get(rt.new_string('reviewer')))
	}
	if var_request.array_isset(rt.new_string('reviewer_email')) {
		var_prepared_review.array_set('comment_author_email',
			var_request.array_get(rt.new_string('reviewer_email')))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('date_created')))) {
		mut var_date_data := rt.call_function('rest_get_date_with_gmt', [
			var_request.array_get(rt.new_string('date_created')),
		])
		if !(!rt.is_true(var_date_data)) {
			mut list_tmp_1 := var_date_data
			var_prepared_review.array_get_mut('comment_date') = list_tmp_1.array_get(0)
			var_prepared_review.array_get_mut('comment_date_gmt') = list_tmp_1.array_get(1)
		}
	} else if !(!rt.is_true(var_request.array_get(rt.new_string('date_created_gmt')))) {
		var_date_data = rt.call_function('rest_get_date_with_gmt', [
			var_request.array_get(rt.new_string('date_created_gmt')),
			rt.new_bool(true),
		])
		if !(!rt.is_true(var_date_data)) {
			mut list_tmp_2 := var_date_data
			var_prepared_review.array_get_mut('comment_date') = list_tmp_2.array_get(0)
			var_prepared_review.array_get_mut('comment_date_gmt') = list_tmp_2.array_get(1)
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_preprocess_product_review'),
		var_prepared_review.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_links(var_review rt.PhpVal) rt.PhpVal {
	mut var_review_mutated := var_review
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
					rt.get_property(var_review_mutated, 'comment_ID')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
			])
		}
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_review_mutated,
		'comment_post_ID')).to_i64())))
	{
		var_links['up'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), this.namespace,
					rt.get_property(var_review_mutated, 'comment_post_ID')]),
			]) },
		])
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_review_mutated, 'user_id')).to_i64()))) {
		var_links['reviewer'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string('wp/v2/users/' +
					(rt.get_property(var_review_mutated, 'user_id')).str()),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		])
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('product_review')
		'type':       rt.new_string('object')
		'properties': {
			'id':                {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created':      {
				'description': rt.call_function('__', [
					rt.new_string("The date the review was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created_gmt':  {
				'description': rt.call_function('__', [
					rt.new_string('The date the review was created, as GMT.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'product_id':        {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the product that the review belongs to.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'product_name':      {
				'description': rt.call_function('__', [rt.new_string('Product name.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'product_permalink': {
				'description': rt.call_function('__', [rt.new_string('Product URL.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'format':      rt.new_string('uri')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'status':            {
				'description': rt.call_function('__', [
					rt.new_string('Status of the review.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'default':     rt.new_string('approved')
				'enum':        map[string]rt.PhpVal{}
				'context':     map[string]rt.PhpVal{}
			}
			'reviewer':          {
				'description': rt.call_function('__', [rt.new_string('Reviewer name.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'reviewer_email':    {
				'description': rt.call_function('__', [rt.new_string('Reviewer email.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'format':      rt.new_string('email')
				'context':     map[string]rt.PhpVal{}
			}
			'review':            {
				'description': rt.call_function('__', [
					rt.new_string('The content of the review.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('wp_filter_post_kses')
				}
			}
			'rating':            {
				'description': rt.call_function('__', [
					rt.new_string('Review rating (0 to 5).'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'verified':          {
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
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		mut var_avatar_properties := rt.new_array()
		mut var_avatar_sizes := rt.call_function('rest_get_avatar_sizes', []rt.PhpVal{})
		mut iter_3 := var_avatar_sizes.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_size := item_3.val
			var_avatar_properties.array_set(var_size, rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Avatar URL with image size of %d pixels.'),
						rt.new_string('woocommerce'),
					]),
					var_size.clone(),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]))
		}
		var_schema.array_get_mut('properties').array_set('reviewer_avatar_urls', rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Avatar URLs for the object reviewer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: var_avatar_properties },
		]))
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Controller.get_collection_params()
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources published after a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
	]))
	var_params.array_set('before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to reviews published before a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
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
	]))
	var_params.array_set('include', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
	]))
	var_params.array_set('offset', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
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
	]))
	var_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by object attribute.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date_gmt' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'date_gmt' },
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'product' },
		]) },
	]))
	var_params.array_set('reviewer', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to reviews assigned to specific user IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('reviewer_exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes reviews assigned to specific user IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('reviewer_email', rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.new_null() },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to that from a specific author email.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'format', val: 'email' },
		rt.ArrayItem{ key: 'type', val: 'string' },
	]))
	var_params.array_set('product', rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to reviews assigned to specific product IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'approved' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to reviews assigned a specific status.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'hold' },
			rt.ArrayItem{ key: none, val: 'approved' },
			rt.ArrayItem{ key: none, val: 'spam' },
			rt.ArrayItem{ key: none, val: 'trash' },
		]) },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_product_review_collection_params'),
		var_params.clone(),
	])
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) get_review(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	var_id_mutated = rt.new_int(var_id_mutated.to_i64())
	mut var_error := create_wp_error(rt.new_string('woocommerce_rest_review_invalid_id'), rt.call_function('__', [
		rt.new_string('Invalid review ID.'),
		rt.new_string('woocommerce'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.is_true(rt.greater_equal(rt.new_int(0), var_id_mutated)) {
		return mut var_error
	}
	mut var_review := rt.call_function('get_comment', [var_id_mutated.clone()])
	if !rt.is_true(var_review)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('review'), rt.call_function('get_comment_type', [var_id_mutated.clone()]))))) {
		return mut var_error
	}
	if !(!rt.is_true(rt.get_property(var_review, 'comment_post_ID'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [
			rt.new_int((rt.get_property(var_review, 'comment_post_ID')).to_i64()),
		])))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [
				rt.new_string('Invalid product ID.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
		}
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_review)
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) normalize_query_param(var_query_param rt.PhpVal) rt.PhpVal {
	mut var_prefix := rt.new_string('comment_')
	mut switch_val_1 := var_query_param
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		mut var_normalized := rt.new_string(var_prefix.str() + 'ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
		var_normalized = rt.new_string(var_prefix.str() + 'post_ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('include'))) {
		var_normalized = rt.new_string('comment__in')
	} else {
		var_normalized = rt.new_string(var_prefix.str() + var_query_param.str())
	}
	return var_normalized.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) prepare_status_response(var_comment_approved rt.PhpVal) rt.PhpVal {
	mut switch_val_2 := var_comment_approved
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('hold')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('0'))) {
		mut var_status := rt.new_string('hold')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('approve')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('1'))) {
		var_status = rt.new_string('approved')
	} else {
		var_status = var_comment_approved
	}
	return var_status.clone()
}

fn (mut this Class_WC_REST_Product_Reviews_Controller) handle_status_param(var_new_status rt.PhpVal, var_id rt.PhpVal) bool {
	mut var_id_mutated := var_id
	mut var_old_status := rt.call_function('wp_get_comment_status', [
		var_id_mutated.clone()])
	if rt.is_true(rt.identical(var_new_status, var_old_status)) {
		return false
	}
	mut switch_val_3 := var_new_status
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('approved')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('approve')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('1'))) {
		mut var_changed := rt.call_function('wp_set_comment_status', [
			var_id_mutated.clone(), rt.new_string('approve')])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('hold')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('0'))) {
		var_changed = rt.call_function('wp_set_comment_status', [
			var_id_mutated.clone(), rt.new_string('hold')])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('spam'))) {
		var_changed = rt.call_function('wp_spam_comment', [var_id_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('unspam'))) {
		var_changed = rt.call_function('wp_unspam_comment', [
			var_id_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('trash'))) {
		var_changed = rt.call_function('wp_trash_comment', [var_id_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('untrash'))) {
		var_changed = rt.call_function('wp_untrash_comment', [
			var_id_mutated.clone()])
	} else {
		var_changed = rt.new_bool(false)
	}
	return var_changed.to_bool()
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

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wc_rest_product_reviews_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Reviews_Controller {
	mut obj := &Class_WC_REST_Product_Reviews_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('products/reviews')
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

fn create_wp_comment_query(_args ...rt.PhpVal) &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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
		else {
			return none
		}
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

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
