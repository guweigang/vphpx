import rt

struct Class_WC_REST_Webhooks_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('webhooks')
	post_type rt.PhpVal = rt.new_string('shop_webhook')
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [
					this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()),
					rt.create_array([
						rt.ArrayItem{ key: 'topic', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Webhook topic.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
						rt.ArrayItem{ key: 'delivery_url', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Webhook delivery URL.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
					]),
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as resource does not support trashing.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
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
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Webhooks_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_batch_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
		rt.new_string('read'),
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
		rt.new_string('edit'),
	])))))
	{
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
		rt.new_string('delete'),
	])))))
	{
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('webhooks'),
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_default_api_version() string {
	return 'wp_api_v1'
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := map[string]rt.PhpVal{}
	var_args['order'] = var_request.array_get(rt.new_string('order'))
	var_args['orderby'] = var_request.array_get(rt.new_string('orderby'))
	var_args['status'] = if rt.is_true(rt.identical(rt.new_string('all'),
		var_request.array_get(rt.new_string('status'))))
	{
		rt.new_string('')
	} else {
		var_request.array_get(rt.new_string('status'))
	}
	var_args['include'] = rt.call_function('implode', [rt.new_string(','),
		var_request.array_get(rt.new_string('include'))])
	var_args['exclude'] = rt.call_function('implode', [rt.new_string(','),
		var_request.array_get(rt.new_string('exclude'))])
	var_args['limit'] = var_request.array_get(rt.new_string('per_page'))
	var_args['search'] = var_request.array_get(rt.new_string('search'))
	var_args['before'] = var_request.array_get(rt.new_string('before'))
	var_args['after'] = var_request.array_get(rt.new_string('after'))
	if !rt.is_true(var_request.array_get(rt.new_string('offset'))) {
		var_args['offset'] = if rt.is_true(rt.less(rt.new_int(1),
			var_request.array_get(rt.new_string('page'))))
		{
			rt.mul(rt.sub(var_request.array_get(rt.new_string('page')), rt.new_int(1)),
				var_args['limit'])
		} else {
			rt.new_int(0)
		}
	}
	mut var_prepared_args := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_webhook_query'),
		rt.create_array_from_native_map(var_args),
		var_request.clone(),
	])
	var_prepared_args.array_unset(rt.new_string('page'))
	var_prepared_args.array_set('paginate', true)
	mut var_webhooks := map[string]rt.PhpVal{}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('webhook'))
	mut var_data_store := iife_result_0
	mut var_results := rt.call_method(var_data_store, 'search_webhooks', [
		var_prepared_args.clone()])
	mut var_webhook_ids := rt.get_property(var_results, 'webhooks')
	mut iter_1 := var_webhook_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_webhook_id := item_1.val
		mut var_data := this.prepare_item_for_response(var_webhook_id.clone(), var_request.clone())
		var_webhooks << this.prepare_response_for_collection(var_data.clone())
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_webhooks),
	])
	mut var_per_page := rt.new_int((var_prepared_args.array_get(rt.new_string('limit'))).to_i64())
	mut var_page := rt.call_function('ceil', [
		rt.add(rt.div(rt.new_int((var_prepared_args.array_get(rt.new_string('offset'))).to_i64()),
			var_per_page), rt.new_int(1)),
	])
	mut var_total_webhooks := rt.get_property(var_results, 'total')
	mut var_max_pages := rt.get_property(var_results, 'max_num_pages')
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
		]),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		var_total_webhooks.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		var_max_pages.clone()])
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	if !rt.is_true(var_id) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('Invalid ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_data := this.prepare_item_for_response(var_id.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Cannot create existing %s.'),
				rt.new_string('woocommerce')]),
			this.post_type,
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !rt.is_true(var_request.array_get(rt.new_string('topic')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_webhook_valid_topic', [rt.new_string(var_request.array_get(rt.new_string('topic')).to_string().to_lower())]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_topic')), rt.call_function('__', [
			rt.new_string('Webhook topic is required and must be valid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !rt.is_true(var_request.array_get(rt.new_string('delivery_url')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_valid_url', [var_request.array_get(rt.new_string('delivery_url'))]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_delivery_url')), rt.call_function('__', [
			rt.new_string('Webhook delivery URL must be a valid URL starting with http:// or https://.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_post := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_webhook := create_wc_webhook()
	rt.call_method(var_webhook, 'set_name', [rt.get_property(var_post, 'post_title')])
	rt.call_method(var_webhook, 'set_user_id', [rt.get_property(var_post, 'post_author')])
	rt.call_method(var_webhook, 'set_status', [
		rt.new_string((if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post,
			'post_status')))
		{
			'active'
		} else {
			'disabled'
		}).str()),
	])
	rt.call_method(var_webhook, 'set_topic', [var_request.array_get(rt.new_string('topic'))])
	rt.call_method(var_webhook, 'set_delivery_url', [
		var_request.array_get(rt.new_string('delivery_url')),
	])
	rt.call_method(var_webhook, 'set_secret', [if !(!rt.is_true(var_request.array_get(rt.new_string('secret')))) { var_request.array_get(rt.new_string('secret')) } else { rt.call_function('wp_generate_password', [
			rt.new_int(50),
			rt.new_bool(true),
			rt.new_bool(true),
		]) }])
	rt.call_method(var_webhook, 'set_api_version', [
		rt.new_string(this.get_default_api_version()),
	])
	rt.call_method(var_webhook, 'save', []rt.PhpVal{})
	this.update_additional_fields_for_object(var_webhook.clone(), var_request.clone())
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_webhook_object'),
		var_webhook.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(rt.call_method(var_webhook, 'get_id',
		[]rt.PhpVal{}), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
				rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})]),
		])])
	rt.call_method(var_webhook, 'deliver_ping', []rt.PhpVal{})
	return var_response.clone()
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_webhook := rt.call_function('wc_get_webhook', [var_id.clone()])
	if !rt.is_true(var_webhook) || var_webhook.clone().is_null() {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('ID is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('topic')))) {
		if rt.is_true(rt.call_function('wc_is_webhook_valid_topic', [
			rt.new_string(var_request.array_get(rt.new_string('topic')).to_string().to_lower()),
		]))
		{
			rt.call_method(var_webhook, 'set_topic', [
				var_request.array_get(rt.new_string('topic')),
			])
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
				this.post_type), rt.new_string('_invalid_topic')), rt.call_function('__', [
				rt.new_string('Webhook topic must be valid.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('delivery_url')))) {
		if rt.is_true(rt.call_function('wc_is_valid_url', [
			var_request.array_get(rt.new_string('delivery_url')),
		]))
		{
			rt.call_method(var_webhook, 'set_delivery_url', [
				var_request.array_get(rt.new_string('delivery_url')),
			])
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
				this.post_type), rt.new_string('_invalid_delivery_url')), rt.call_function('__', [
				rt.new_string('Webhook delivery URL must be a valid URL starting with http:// or https://.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('secret')))) {
		rt.call_method(var_webhook, 'set_secret', [var_request.array_get(rt.new_string('secret'))])
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('status')))) {
		if rt.is_true(rt.call_function('wc_is_webhook_valid_status', [
			rt.new_string(var_request.array_get(rt.new_string('status')).to_string().to_lower()),
		]))
		{
			rt.call_method(var_webhook, 'set_status', [
				var_request.array_get(rt.new_string('status')),
			])
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
				this.post_type), rt.new_string('_invalid_status')), rt.call_function('__', [
				rt.new_string('Webhook status must be valid.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	mut var_post := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	if !(rt.get_property(var_post, 'post_title')).is_null() {
		rt.call_method(var_webhook, 'set_name', [rt.get_property(var_post, 'post_title')])
	}
	rt.call_method(var_webhook, 'save', []rt.PhpVal{})
	this.update_additional_fields_for_object(var_webhook.clone(), var_request.clone())
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_webhook_object'),
		var_webhook.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(rt.call_method(var_webhook, 'get_id',
		[]rt.PhpVal{}), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('__', [
			rt.new_string('Webhooks do not support trashing.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	mut var_webhook := rt.call_function('wc_get_webhook', [var_id.clone()])
	if !rt.is_true(var_webhook) || var_webhook.clone().is_null() {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('Invalid ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_webhook.clone(), var_request.clone())
	mut var_result := rt.call_method(var_webhook, 'delete', [
		rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('The %s cannot be deleted.'),
				rt.new_string('woocommerce')]),
			this.post_type,
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_delete_webhook_object'),
		var_webhook.clone(),
		var_response.clone(),
		var_request.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := create_stdclass()
	if var_request.array_isset(rt.new_string('id')) {
		rt.set_property(var_data, 'ID', rt.call_function('absint', [
			var_request.array_get(rt.new_string('id')),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('POST'), rt.call_method(var_request, 'get_method', []rt.PhpVal{})))
		&& !rt.is_true(rt.get_property(var_data, 'ID')) {
		rt.set_property(var_data, 'post_title', if !(!rt.is_true(var_request.array_get(rt.new_string('name')))) { var_request.array_get(rt.new_string('name')) } else { rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Webhook created on %s'),
					rt.new_string('woocommerce')]),
				rt.call_method(create_datetime(rt.new_string('now')), 'format', [
					rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'),
						rt.new_string('Webhook created on date parsed by DateTime::format'),
						rt.new_string('woocommerce')])]),
			]) })
		rt.set_property(var_data, 'post_author', rt.call_function('get_current_user_id',
			[]rt.PhpVal{}))
		rt.set_property(var_data, 'post_password', 'webhook_' +
			(rt.call_function('wp_generate_password', []rt.PhpVal{})).str())
		rt.set_property(var_data, 'post_status', rt.new_string('publish'))
	} else {
		if !(!rt.is_true(var_request.array_get(rt.new_string('name')))) {
			rt.set_property(var_data, 'post_title', var_request.array_get(rt.new_string('name')))
		}
	}
	rt.set_property(var_data, 'comment_status', rt.new_string('closed'))
	rt.set_property(var_data, 'ping_status', rt.new_string('closed'))
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type),
		var_data.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) prepare_item_for_response(var_id rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_webhook := rt.call_function('wc_get_webhook', [var_id_mutated.clone()])
	if !rt.is_true(var_webhook) || var_webhook.clone().is_null() {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('ID is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_webhook, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_webhook, 'get_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'status', val: rt.call_method(var_webhook, 'get_status', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'topic', val: rt.call_method(var_webhook, 'get_topic', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'resource', val: rt.call_method(var_webhook, 'get_resource',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'event', val: rt.call_method(var_webhook, 'get_event', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'hooks', val: rt.call_method(var_webhook, 'get_hooks', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'delivery_url', val: rt.call_method(var_webhook, 'get_delivery_url',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_webhook, 'get_date_created', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.call_method(var_webhook, 'get_date_modified', []rt.PhpVal{}),
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
		this.prepare_links(rt.call_method(var_webhook, 'get_id', []rt.PhpVal{})),
	])
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type),
		var_response.clone(),
		var_webhook.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) prepare_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
					var_id_mutated.clone()]),
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

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('webhook')
		'type':       rt.new_string('object')
		'properties': {
			'id':            {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'name':          {
				'description': rt.call_function('__', [
					rt.new_string('A friendly name for the webhook.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'status':        {
				'description': rt.call_function('__', [rt.new_string('Webhook status.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'default':     rt.new_string('active')
				'enum':        rt.func_array_keys(rt.call_function('wc_get_webhook_statuses',
					[]rt.PhpVal{}))
				'context':     map[string]rt.PhpVal{}
			}
			'topic':         {
				'description': rt.call_function('__', [rt.new_string('Webhook topic.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'resource':      {
				'description': rt.call_function('__', [
					rt.new_string('Webhook resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'event':         {
				'description': rt.call_function('__', [rt.new_string('Webhook event.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'hooks':         {
				'description': rt.call_function('__', [
					rt.new_string('WooCommerce action names associated with the webhook.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
				'items':       {
					'type': rt.new_string('string')
				}
			}
			'delivery_url':  {
				'description': rt.call_function('__', [
					rt.new_string('The URL where the webhook payload is delivered.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('uri')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'secret':        {
				'description': rt.call_function('__', [
					rt.new_string("Secret key used to generate a hash of the delivered webhook and provided in the request headers. This will default to a MD5 hash from the current user's ID|username if not provided."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'date_created':  {
				'description': rt.call_function('__', [
					rt.new_string("The date the webhook was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_modified': {
				'description': rt.call_function('__', [
					rt.new_string("The date the webhook was last modified, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Webhooks_V1_Controller) get_collection_params() rt.PhpVal {
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
		rt.ArrayItem{
			key: 'default'
			val: map[string]rt.PhpVal{}
		},
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
		rt.ArrayItem{
			key: 'default'
			val: map[string]rt.PhpVal{}
		},
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
			rt.ArrayItem{ key: none, val: 'title' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'all' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to webhooks assigned a specific status.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'active' },
			rt.ArrayItem{ key: none, val: 'paused' },
			rt.ArrayItem{ key: none, val: 'disabled' },
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
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

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wc_rest_webhooks_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Webhooks_V1_Controller {
	mut obj := &Class_WC_REST_Webhooks_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('webhooks')
		post_type:     rt.new_string('shop_webhook')
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_webhook(_args ...rt.PhpVal) &Class_WC_Webhook {
	mut obj := &Class_WC_Webhook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
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
		else {
			return none
		}
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
