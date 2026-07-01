import rt

struct Class_WC_REST_Webhooks_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('webhooks')
		post_type rt.PhpVal = rt.new_string('shop_webhook')
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'topic', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Webhook topic.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'delivery_url', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Webhook delivery URL.'), rt.new_string('woocommerce')]) }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as resource does not support trashing.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('webhooks'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('webhooks'), rt.new_string('create')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('webhooks'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('webhooks'), rt.new_string('edit')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('webhooks'), rt.new_string('delete')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('webhooks'), rt.new_string('batch')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_default_api_version() string {
	return 'wp_api_v1'
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := map[string]rt.PhpVal{}
	var_args['order'] = var_request.array_get('order')
	var_args['orderby'] = var_request.array_get('orderby')
	var_args['status'] = if rt.is_true(rt.identical(rt.new_string('all'), var_request.array_get('status'))) { rt.new_string('') } else { var_request.array_get('status') }
	var_args['include'] = rt.call_function('implode', [rt.new_string(','), var_request.array_get('include')])
	var_args['exclude'] = rt.call_function('implode', [rt.new_string(','), var_request.array_get('exclude')])
	var_args['limit'] = var_request.array_get('per_page')
	var_args['search'] = var_request.array_get('search')
	var_args['before'] = var_request.array_get('before')
	var_args['after'] = var_request.array_get('after')
	if !rt.is_true(var_request.array_get('offset')) {
		var_args['offset'] = if rt.is_true(rt.less(rt.new_int(1), var_request.array_get('page'))) { rt.mul(rt.sub(var_request.array_get('page'), rt.new_int(1)), var_args.array_get('limit')) } else { rt.new_int(0) }
	}
	mut var_prepared_args := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_webhook_query'), var_args.dup(), var_request.dup()])
	var_prepared_args.array_unset(rt.new_string('page'))
	var_prepared_args.array_set('paginate', true)
	mut var_webhooks := map[string]rt.PhpVal{}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('webhook'))
	mut var_results := rt.call_method(var_data_store, 'search_webhooks', [var_prepared_args.dup()])
	mut var_webhook_ids := rt.get_property(var_results, 'webhooks')
	{
		mut iter_1 := var_webhook_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_webhook_id := item_1.val
			mut var_data := this.prepare_item_for_response(var_webhook_id.dup(), var_request.dup())
			var_webhooks << this.prepare_response_for_collection(var_data.dup())
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_webhooks.dup()])
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_page := rt.call_function('ceil', [rt.add(rt.div(// unsupported expression: Expr_Cast_Int, var_per_page), rt.new_int(1))])
	mut var_total_webhooks := rt.get_property(var_results, 'total')
	mut var_max_pages := rt.get_property(var_results, 'max_num_pages')
	mut var_base := rt.call_function('add_query_arg', [rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])])])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total_webhooks.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), var_max_pages.dup()])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.dup()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	if !rt.is_true(var_id) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_data := this.prepare_item_for_response(var_id.dup(), var_request.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cannot create existing %s.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_request.array_get('topic')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_webhook_valid_topic', [rt.new_string(var_request.array_get('topic').to_string().to_lower())]))))))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_topic')), rt.call_function('__', [rt.new_string('Webhook topic is required and must be valid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_request.array_get('delivery_url')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_valid_url', [var_request.array_get('delivery_url')]))))))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_delivery_url')), rt.call_function('__', [rt.new_string('Webhook delivery URL must be a valid URL starting with http:// or https://.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_post := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return var_post.dup()
	}
	mut var_webhook := create_wc_webhook()
	rt.call_method(var_webhook, 'set_name', [rt.get_property(var_post, 'post_title')])
	rt.call_method(var_webhook, 'set_user_id', [rt.get_property(var_post, 'post_author')])
	rt.call_method(var_webhook, 'set_status', [if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status'))) { rt.new_string('active') } else { rt.new_string('disabled') }])
	rt.call_method(var_webhook, 'set_topic', [var_request.array_get('topic')])
	rt.call_method(var_webhook, 'set_delivery_url', [var_request.array_get('delivery_url')])
	rt.call_method(var_webhook, 'set_secret', [if !(!rt.is_true(var_request.array_get('secret'))) { var_request.array_get('secret') } else { rt.call_function('wp_generate_password', [rt.new_int(50), rt.new_bool(true), rt.new_bool(true)]) }])
	rt.call_method(var_webhook, 'set_api_version', [this.get_default_api_version()])
	rt.call_method(var_webhook, 'save', []rt.PhpVal{})
	this.update_additional_fields_for_object(var_webhook.dup(), var_request.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_webhook_object'), var_webhook.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})])])])
	rt.call_method(var_webhook, 'deliver_ping', []rt.PhpVal{})
	return var_response.dup()
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_webhook := rt.call_function('wc_get_webhook', [var_id.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_webhook) || rt.is_true(rt.new_bool(var_webhook.dup().is_null())))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('ID is invalid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(!rt.is_true(var_request.array_get('topic'))) {
		if rt.is_true(rt.call_function('wc_is_webhook_valid_topic', [rt.new_string(var_request.array_get('topic').to_string().to_lower())])) {
			rt.call_method(var_webhook, 'set_topic', [var_request.array_get('topic')])
		} else {
			return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_topic')), rt.call_function('__', [rt.new_string('Webhook topic must be valid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	if !(!rt.is_true(var_request.array_get('delivery_url'))) {
		if rt.is_true(rt.call_function('wc_is_valid_url', [var_request.array_get('delivery_url')])) {
			rt.call_method(var_webhook, 'set_delivery_url', [var_request.array_get('delivery_url')])
		} else {
			return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_delivery_url')), rt.call_function('__', [rt.new_string('Webhook delivery URL must be a valid URL starting with http:// or https://.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	if !(!rt.is_true(var_request.array_get('secret'))) {
		rt.call_method(var_webhook, 'set_secret', [var_request.array_get('secret')])
	}
	if !(!rt.is_true(var_request.array_get('status'))) {
		if rt.is_true(rt.call_function('wc_is_webhook_valid_status', [rt.new_string(var_request.array_get('status').to_string().to_lower())])) {
			rt.call_method(var_webhook, 'set_status', [var_request.array_get('status')])
		} else {
			return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_status')), rt.call_function('__', [rt.new_string('Webhook status must be valid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	mut var_post := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return var_post.dup()
	}
	if !(rt.get_property(var_post, 'post_title')).is_null() {
		rt.call_method(var_webhook, 'set_name', [rt.get_property(var_post, 'post_title')])
	}
	rt.call_method(var_webhook, 'save', []rt.PhpVal{})
	this.update_additional_fields_for_object(var_webhook.dup(), var_request.dup())
	rt.call_function('do_action', [, .dup(), .dup(), ])
	
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) prepare_item_for_response(var_id rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) prepare_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_collection_params() rt.PhpVal {
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Webhook {
	rt.PhpObjectBase
}

fn create_wc_rest_webhooks_v1_controller() &Class_WC_REST_Webhooks_V1_Controller {
	mut obj := &Class_WC_REST_Webhooks_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('webhooks')
		post_type: rt.new_string('shop_webhook')
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

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_webhook() &Class_WC_Webhook {
	mut obj := &Class_WC_Webhook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
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
		'get_default_api_version' {
			return rt.new_string(this.get_default_api_version())
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
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
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Webhooks_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version1_class_wc_rest_webhooks_v1_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
