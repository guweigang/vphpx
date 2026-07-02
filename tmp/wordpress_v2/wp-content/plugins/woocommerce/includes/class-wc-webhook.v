import rt

struct Class_WC_Webhook {
	rt.PhpObjectBase
pub mut:
	processed rt.PhpVal = rt.new_array()
	data      rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Webhook) construct(data i64) {
	this.Class_WC_Legacy_Webhook.construct(rt.new_int(data))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(data), 'WC_Webhook'))) {
		this.set_id(rt.call_function('absint', [
			rt.call_method(rt.new_int(data), 'get_id', []rt.PhpVal{}),
		]))
	} else if rt.is_true(rt.new_bool(rt.new_int(data).is_long() || rt.new_int(data).is_double())) {
		this.set_id(rt.new_int(data))
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('webhook'))
	this.dispatch_set_prop('data_store', iife_result_0)
	if rt.is_true(this.get_id()) {
		rt.call_method(rt.get_property(rt.new_object('WC_Webhook', [
			'WC_Legacy_Webhook',
		], &this), 'data_store'), 'read', [
			rt.new_object('WC_Webhook', ['WC_Legacy_Webhook'], &this),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			this.set_id(rt.new_int(0))
			this.set_object_read(rt.new_bool(true))
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
	} else {
		this.set_object_read(rt.new_bool(true))
	}
}

fn (mut this Class_WC_Webhook) enqueue() {
	mut var_hooks := this.get_hooks()
	mut var_url := this.get_delivery_url('')
	if var_hooks.clone().is_array() && !(!rt.is_true(var_url)) {
		mut iter_1 := var_hooks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_hook := item_1.val
			rt.call_function('add_action', [var_hook.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Webhook', [
						'WC_Legacy_Webhook',
					], &this) },
					rt.ArrayItem{ key: none, val: 'process' },
				])])
		}
	}
}

fn (mut this Class_WC_Webhook) process(var_arg rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.should_deliver(var_arg.clone()))))) {
		return rt.new_null()
	}
	this.processed.array_push(var_arg.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_webhook_process_delivery'),
		rt.new_object('WC_Webhook', ['WC_Legacy_Webhook'], &this),
		var_arg.clone()])
	return var_arg.clone()
}

fn (mut this Class_WC_Webhook) should_deliver(var_arg rt.PhpVal) rt.PhpVal {
	mut var_should_deliver := rt.new_bool(rt.is_true(this.is_active())
		&& rt.is_true(this.is_valid_topic()) && rt.is_true(this.is_valid_action(var_arg.clone()))
		&& this.is_valid_resource(var_arg.clone()) && !(this.is_already_processed(var_arg.clone())))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_should_deliver'),
		var_should_deliver.clone(),
		rt.new_object('WC_Webhook', ['WC_Legacy_Webhook'], &this),
		var_arg.clone(),
	])
}

fn (mut this Class_WC_Webhook) is_active() rt.PhpVal {
	return rt.identical(rt.new_string('active'), this.get_status(''))
}

fn (mut this Class_WC_Webhook) is_valid_topic() rt.PhpVal {
	return rt.call_function('wc_is_webhook_valid_topic', [this.get_topic('')])
}

fn (mut this Class_WC_Webhook) is_valid_action(var_arg rt.PhpVal) rt.PhpVal {
	mut var_current_action := rt.call_function('current_action', []rt.PhpVal{})
	mut var_return := rt.new_bool(true)
	mut switch_val_1 := var_current_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_post')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('wp_trash_post')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('untrashed_post'))) {
		var_return = rt.new_bool(this.is_valid_post_action(var_arg.clone()))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_user'))) {
		var_return = rt.new_bool(this.is_valid_user_action(var_arg.clone()))
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_current_action.clone(), rt.new_string('woocommerce_process_shop')])))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_current_action.clone(), rt.new_string('woocommerce_process_product')]))) {
		var_return = rt.new_bool(this.is_valid_processing_action(var_arg.clone()))
	}
	return var_return.clone()
}

fn (mut this Class_WC_Webhook) is_valid_post_action(var_arg rt.PhpVal) bool {
	mut var_GLOBALS := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('post_type'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_GLOBALS.array_get(rt.new_string('post_type')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'shop_coupon'
	}, rt.ArrayItem{ key: none, val: 'shop_order' }, rt.ArrayItem{ key: none, val: 'product' }]), rt.new_bool(true)]))))) {
		return false
	}
	if var_GLOBALS.array_isset(rt.new_string('post_type'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('str_replace', [rt.new_string('shop_'), rt.new_string(''), var_GLOBALS.array_get(rt.new_string('post_type'))]), this.get_resource())))) {
		return false
	}
	return true
}

fn (mut this Class_WC_Webhook) is_valid_user_action(var_arg rt.PhpVal) bool {
	mut var_user := rt.call_function('get_userdata', [
		rt.call_function('absint', [var_arg.clone()]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('customer'), rt.cast_array(rt.get_property(var_user, 'roles')), rt.new_bool(true)]))))) {
		return false
	}
	return true
}

fn (mut this Class_WC_Webhook) is_valid_processing_action(var_arg rt.PhpVal) bool {
	mut var_resource := rt.call_function('get_post', [
		rt.call_function('absint', [var_arg.clone()]),
	])
	mut var_gmt_date := rt.call_function('get_gmt_from_date', [
		rt.get_property(var_resource, 'post_date'),
	])
	mut var_resource_created := rt.less_equal(rt.sub(rt.call_function('time', []rt.PhpVal{}),
		rt.new_int(10)), rt.call_function('strtotime', [var_gmt_date.clone()]))
	if rt.is_true(rt.identical(rt.new_string('created'), this.get_event()))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_resource_created)))) {
		return false
	} else if rt.is_true(rt.identical(rt.new_string('updated'), this.get_event()))
		&& rt.is_true(var_resource_created) {
		return false
	}
	return true
}

fn (mut this Class_WC_Webhook) is_valid_resource(var_arg rt.PhpVal) bool {
	mut var_resource := this.get_resource()
	if rt.is_true(rt.call_function('in_array', [var_resource.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'coupon' }]),
		rt.new_bool(true)]))
	{
		mut var_status := rt.call_function('get_post_status', [
			rt.call_function('absint', [var_arg.clone()]),
		])
		if rt.is_true(rt.call_function('in_array', [var_status.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'auto-draft' },
				rt.ArrayItem{ key: none, val: 'new' }]),
			rt.new_bool(true)]))
		{
			return false
		}
	}
	if rt.is_true(rt.identical(rt.new_string('order'), var_resource)) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_1 := iife_temp_1.is_order(rt.call_function('absint', [
			var_arg.clone()]), rt.call_function('wc_get_order_types', [
			rt.new_string('order-webhooks'),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
			return false
		}
		mut var_order := rt.call_function('wc_get_order', [
			rt.call_function('absint', [var_arg.clone()]),
		])
		if rt.is_true(rt.call_function('in_array', [
			rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()
				},
				rt.ArrayItem{ key: none, val: 'new' },
			]),
			rt.new_bool(true),
		]))
		{
			return false
		}
	}
	return true
}

fn (mut this Class_WC_Webhook) is_already_processed(var_arg rt.PhpVal) bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('array_search', [
		var_arg.clone(),
		this.processed,
		rt.new_bool(true),
	]))))
}

fn (mut this Class_WC_Webhook) deliver(var_arg rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_payload := this.build_payload(var_arg.clone())
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WC_VERSION'))
	mut var_http_args := rt.create_array([rt.ArrayItem{ key: 'method', val: 'POST' },
		rt.ArrayItem{ key: 'timeout', val: rt.get_constant('MINUTE_IN_SECONDS') },
		rt.ArrayItem{ key: 'redirection', val: 0 }, rt.ArrayItem{ key: 'httpversion', val: '1.0' },
		rt.ArrayItem{ key: 'blocking', val: true }, rt.ArrayItem{ key: 'user-agent', val: rt.call_function('sprintf', [
			rt.new_string('WooCommerce/%s Hookshot (WordPress/%s)'),
			iife_result_2,
			var_GLOBALS.array_get(rt.new_string('wp_version')),
		]) }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [
			var_payload.clone(),
		]).to_string().trim_space() }, rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: 'Content-Type', val: 'application/json' },
		]) }, rt.ArrayItem{ key: 'cookies', val: rt.new_array() }])
	var_http_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_http_args'),
		var_http_args.clone(),
		var_arg.clone(),
		this.get_id(),
	])
	mut var_delivery_id := this.get_new_delivery_id()
	var_http_args.array_get_mut('headers').array_set('X-WC-Webhook-Source', rt.call_function('home_url', [
		rt.new_string('/'),
	]))
	var_http_args.array_get_mut('headers').array_set('X-WC-Webhook-Topic', this.get_topic(''))
	var_http_args.array_get_mut('headers').array_set('X-WC-Webhook-Resource', this.get_resource())
	var_http_args.array_get_mut('headers').array_set('X-WC-Webhook-Event', this.get_event())
	var_http_args.array_get_mut('headers').array_set('X-WC-Webhook-Signature',
		this.generate_signature(var_http_args.array_get(rt.new_string('body'))))
	var_http_args.array_get_mut('headers').array_set('X-WC-Webhook-ID', this.get_id())
	var_http_args.array_get_mut('headers').array_set('X-WC-Webhook-Delivery-ID',
		var_delivery_id.clone())
	mut var_response := rt.call_function('wp_safe_remote_request', [
		this.get_delivery_url(''),
		var_http_args.clone(),
	])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_3 := iife_temp_3.round(rt.sub(rt.call_function('microtime', [
		rt.new_bool(true),
	]), var_start_time), rt.new_int(5))
	mut var_duration := iife_result_3
	this.log_delivery(var_delivery_id.clone(), var_http_args.clone(), var_response.clone(),
		var_duration.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_webhook_delivery'),
		var_http_args.clone(), var_response.clone(), var_duration.clone(),
		var_arg.clone(), this.get_id()])
}

fn (mut this Class_WC_Webhook) get_wp_api_payload(var_resource rt.PhpVal, var_resource_id rt.PhpVal, var_event rt.PhpVal) rt.PhpVal {
	mut var_resource_mutated := var_resource
	mut var_resource_id_mutated := var_resource_id
	mut var_event_mutated := var_event
	mut switch_val_2 := var_resource_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('coupon')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('customer')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('order')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('product'))) {
		if rt.is_true(rt.identical(rt.new_string('product'), var_resource_mutated))
			&& rt.is_true(rt.identical(rt.new_string('updated'), var_event_mutated))
			&& rt.is_true(rt.call_function('is_a', [var_resource_id_mutated.clone(), rt.new_string('WC_Product')])) {
			var_resource_id_mutated = rt.call_method(var_resource_id_mutated, 'get_id',
				[]rt.PhpVal{})
		}
		mut var_version := rt.call_function('str_replace', [rt.new_string('wp_api_'),
			rt.new_string(''), rt.new_string(this.get_api_version(''))])
		mut var_payload := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Utilities_RestApiUtil.class(),
		]), 'get_endpoint_data', [
			rt.new_string('/wc/${var_version.to_string()}/${var_resource.to_string()}s/${var_resource_id.to_string()}'),
		])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('action'))) {
		var_payload = rt.create_array([
			rt.ArrayItem{ key: 'action', val: rt.call_function('current', [
				this.get_hooks(),
			]) },
			rt.ArrayItem{ key: 'arg', val: var_resource_id_mutated },
		])
	} else {
		var_payload = rt.new_array()
	}
	return var_payload.clone()
}

fn (mut this Class_WC_Webhook) build_payload(var_resource_id rt.PhpVal) rt.PhpVal {
	mut var_resource_id_mutated := var_resource_id
	mut var_current_user := rt.call_function('get_current_user_id', []rt.PhpVal{})
	rt.call_function('wp_set_current_user', [this.get_user_id('')])
	mut var_resource := this.get_resource()
	mut var_event := this.get_event()
	if rt.is_true(rt.identical(rt.new_string('deleted'), var_event)) {
		mut var_payload := rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_resource_id_mutated },
		])
	} else if rt.is_true(rt.call_function('in_array', [
		rt.new_string(this.get_api_version('')),
		rt.call_function('wc_get_webhook_rest_api_versions', []rt.PhpVal{}),
		rt.new_bool(true),
	]))
	{
		var_payload = this.get_wp_api_payload(var_resource.clone(),
			var_resource_id_mutated.clone(), var_event.clone())
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
			'legacy_rest_api_is_available', []rt.PhpVal{})))))
		{
			rt.throw_exception(rt.new_object('Exception', []string{},
				create_exception(rt.new_string('The Legacy REST API plugin is not installed on this site. More information: https://developer.woocommerce.com/2023/10/03/the-legacy-rest-api-will-move-to-a-dedicated-extension-in-woocommerce-9-0/ '))))
		}
		var_payload = rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'api'),
			'get_webhook_api_payload', [var_resource.clone(),
			var_resource_id_mutated.clone(), var_event.clone()])
	}
	rt.call_function('wp_set_current_user', [var_current_user.clone()])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_payload'),
		var_payload.clone(),
		var_resource.clone(),
		var_resource_id_mutated.clone(),
		this.get_id(),
	])
}

fn (mut this Class_WC_Webhook) generate_signature(var_payload rt.PhpVal) rt.PhpVal {
	mut var_payload_mutated := var_payload
	mut var_hash_algo := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_hash_algorithm'),
		rt.new_string('sha256'),
		var_payload_mutated.clone(),
		this.get_id(),
	])
	return rt.call_function('base64_encode', [
		rt.call_function('hash_hmac', [var_hash_algo.clone(),
			var_payload_mutated.clone(),
			rt.call_function('wp_specialchars_decode', [
				this.get_secret(''),
				rt.get_constant('ENT_QUOTES'),
			]),
			rt.new_bool(true)]),
	])
}

fn (mut this Class_WC_Webhook) get_new_delivery_id() rt.PhpVal {
	return rt.call_function('wp_hash', [
		rt.new_string(
			(this.get_id()).str() + (rt.call_function('strtotime', [rt.new_string('now')])).str()),
	])
}

fn (mut this Class_WC_Webhook) log_delivery(var_delivery_id rt.PhpVal, var_request rt.PhpVal, var_response rt.PhpVal, var_duration rt.PhpVal) {
	mut var_delivery_id_mutated := var_delivery_id
	mut var_response_mutated := var_response
	mut var_duration_mutated := var_duration
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	mut var_message := {
		'Webhook Delivery': {
			'Delivery ID': var_delivery_id_mutated
			'Date':        rt.call_function('date_i18n', [
				rt.call_function('__', [rt.new_string('M j, Y @ G:i'),
					rt.new_string('woocommerce')]),
				rt.call_function('strtotime', [rt.new_string('now')]),
				rt.new_bool(true),
			])
			'URL':         this.get_delivery_url('')
			'Duration':    var_duration_mutated
			'Request':     {
				'Method':  var_request.array_get(rt.new_string('method'))
				'Headers': rt.call_function('array_merge', [
					{
						'User-Agent': var_request.array_get(rt.new_string('user-agent'))
					},
					var_request.array_get(rt.new_string('headers')),
				])
			}
			'Body':        rt.call_function('wp_slash', [
				var_request.array_get(rt.new_string('body')),
			])
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response_mutated.clone()])) {
		mut var_response_code := rt.call_method(var_response_mutated, 'get_error_code',
			[]rt.PhpVal{})
		mut var_response_message := rt.call_method(var_response_mutated, 'get_error_message',
			[]rt.PhpVal{})
		mut var_response_headers := rt.new_array()
		mut var_response_body := rt.new_string('')
	} else {
		var_response_code = rt.call_function('wp_remote_retrieve_response_code', [
			var_response_mutated.clone(),
		])
		var_response_message = rt.call_function('wp_remote_retrieve_response_message', [
			var_response_mutated.clone(),
		])
		var_response_headers = rt.call_function('wp_remote_retrieve_headers', [
			var_response_mutated.clone(),
		])
		var_response_body = rt.call_function('wp_remote_retrieve_body', [
			var_response_mutated.clone()])
	}
	var_message.array_get_mut('Webhook Delivery').array_set('Response', rt.create_array([
		rt.ArrayItem{ key: 'Code', val: var_response_code },
		rt.ArrayItem{ key: 'Message', val: var_response_message },
		rt.ArrayItem{ key: 'Headers', val: var_response_headers },
		rt.ArrayItem{ key: 'Body', val: var_response_body },
	]))
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.is_true(rt.new_string('WP_DEBUG'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) {
		var_message.array_get_mut('Webhook Delivery').array_set('Body',
			'Webhook body is not logged unless WP_DEBUG mode is turned on. This is to avoid the storing of personal data in the logs.')
		var_message.array_get_mut('Webhook Delivery').array_get_mut('Response').array_set('Body',
			'Webhook body is not logged unless WP_DEBUG mode is turned on. This is to avoid the storing of personal data in the logs.')
	}
	rt.call_method(var_logger, 'info', [
		rt.call_function('wc_print_r', [rt.create_array_from_native_map(var_message),
			rt.new_bool(true)]),
		rt.create_array([rt.ArrayItem{ key: 'source', val: 'webhooks-delivery' }]),
	])
	if var_response_code.clone().to_i64() >= 200 && var_response_code.clone().to_i64() < 303 {
		this.set_failure_count(rt.new_int(0))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), this.get_id())))) {
			this.save()
		}
	} else {
		this.failed_delivery()
	}
}

fn (mut this Class_WC_Webhook) failed_delivery() {
	mut var_failures := this.get_failure_count('')
	if rt.is_true(rt.greater(var_failures, rt.call_function('apply_filters', [
		rt.new_string('woocommerce_max_webhook_delivery_failures'),
		rt.new_int(5),
	])))
	{
		this.set_status(rt.new_string('disabled'))
		rt.call_function('do_action', [
			rt.new_string('woocommerce_webhook_disabled_due_delivery_failures'),
			this.get_id(),
		])
	} else {
		this.set_failure_count(rt.pre_inc(var_failures))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), this.get_id())))) {
		this.save()
	}
}

fn (mut this Class_WC_Webhook) get_delivery_logs() rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_5 := iife_temp_5.get_logs_tab_url()
	return rt.call_function('add_query_arg', [rt.new_string('source'),
		rt.new_string('webhooks-delivery'), iife_result_5])
}

fn (mut this Class_WC_Webhook) get_delivery_log(var_delivery_id rt.PhpVal) {
	mut var_delivery_id_mutated := var_delivery_id
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Webhook::get_delivery_log'),
		rt.new_string('3.3'),
	])
}

fn (mut this Class_WC_Webhook) deliver_ping() bool {
	mut var_GLOBALS := rt.new_null()
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.get_constant(rt.new_string('WC_VERSION'))
	mut var_args := {
		'user-agent': rt.call_function('sprintf', [
			rt.new_string('WooCommerce/%s Hookshot (WordPress/%s)'),
			iife_result_6,
			var_GLOBALS.array_get(rt.new_string('wp_version')),
		])
		'body':       'webhook_id=' + (this.get_id()).str()
	}
	mut var_http_args := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_http_args'),
		rt.create_array_from_native_map(var_args),
		rt.new_null(),
		this.get_id(),
	])
	mut var_test := rt.call_function('wp_safe_remote_post', [
		this.get_delivery_url(''), var_http_args.clone()])
	mut var_response_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_test.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_test.clone()])) {
		return (create_wp_error(rt.new_string('error'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Error: Delivery URL cannot be reached: %s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_test, 'get_error_message', []rt.PhpVal{}),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_response_code)))) {
		return (create_wp_error(rt.new_string('error'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Error: Delivery URL returned response code: %s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('absint', [
				var_response_code.clone(),
			]),
		]))).to_bool()
	}
	this.set_pending_delivery(rt.new_bool(false))
	this.save()
	return true
}

fn (mut this Class_WC_Webhook) get_name(context string) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_webhook_name'),
		this.get_prop(rt.new_string('name'), rt.new_string(context)),
		this.get_id()])
}

fn (mut this Class_WC_Webhook) get_status(context string) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_status'),
		this.get_prop(rt.new_string('status'), rt.new_string(context)),
		this.get_id(),
	])
}

fn (mut this Class_WC_Webhook) get_date_created(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_created'), rt.new_string(context))
}

fn (mut this Class_WC_Webhook) get_date_modified(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_modified'), rt.new_string(context))
}

fn (mut this Class_WC_Webhook) get_secret(context string) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_secret'),
		this.get_prop(rt.new_string('secret'), rt.new_string(context)),
		this.get_id(),
	])
}

fn (mut this Class_WC_Webhook) get_topic(context string) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_webhook_topic'),
		this.get_prop(rt.new_string('topic'), rt.new_string(context)),
		this.get_id()])
}

fn (mut this Class_WC_Webhook) get_delivery_url(context string) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_delivery_url'),
		this.get_prop(rt.new_string('delivery_url'), rt.new_string(context)),
		this.get_id(),
	])
}

fn (mut this Class_WC_Webhook) get_user_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_id'), rt.new_string(context))
}

fn (mut this Class_WC_Webhook) get_api_version(context string) string {
	mut var_version := this.get_prop(rt.new_string('api_version'), rt.new_string(context))
	return if rt.is_true(rt.greater(var_version, rt.new_int(0))) {
		'wp_api_v' + var_version.str()
	} else {
		'legacy_v3'
	}
}

fn (mut this Class_WC_Webhook) get_failure_count(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('failure_count'), rt.new_string(context))
}

fn (mut this Class_WC_Webhook) get_pending_delivery(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('pending_delivery'), rt.new_string(context))
}

fn (mut this Class_WC_Webhook) set_name(var_name rt.PhpVal) {
	this.set_prop(rt.new_string('name'), var_name.clone())
}

fn (mut this Class_WC_Webhook) set_date_created(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_created'), var_date.clone())
}

fn (mut this Class_WC_Webhook) set_date_modified(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_modified'), var_date.clone())
}

fn (mut this Class_WC_Webhook) set_status(var_status rt.PhpVal) {
	mut var_status_mutated := var_status
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('wc_get_webhook_statuses',
		[]rt.PhpVal{}).array_isset(var_status_mutated.clone()))))))
	{
		var_status_mutated = rt.new_string('disabled')
	}
	this.set_prop(rt.new_string('status'), var_status_mutated.clone())
}

fn (mut this Class_WC_Webhook) set_secret(var_secret rt.PhpVal) {
	this.set_prop(rt.new_string('secret'), var_secret.clone())
}

fn (mut this Class_WC_Webhook) set_topic(var_topic rt.PhpVal) {
	mut var_topic_mutated := var_topic
	var_topic_mutated = rt.call_function('wc_clean', [var_topic_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_webhook_valid_topic', [
		var_topic_mutated.clone(),
	])))))
	{
		var_topic_mutated = rt.new_string('')
	}
	this.set_prop(rt.new_string('topic'), var_topic_mutated.clone())
}

fn (mut this Class_WC_Webhook) set_delivery_url(var_url rt.PhpVal) {
	mut var_url_mutated := var_url
	this.set_prop(rt.new_string('delivery_url'), rt.call_function('esc_url_raw', [
		var_url_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'http' },
			rt.ArrayItem{ key: none, val: 'https' }]),
	]))
}

fn (mut this Class_WC_Webhook) set_user_id(var_user_id rt.PhpVal) {
	this.set_prop(rt.new_string('user_id'), rt.new_int(var_user_id.to_i64()))
}

fn (mut this Class_WC_Webhook) set_api_version(var_version rt.PhpVal) {
	mut var_version_mutated := var_version
	if !(var_version_mutated.clone().is_long() || var_version_mutated.clone().is_double()) {
		var_version_mutated = rt.call_method(rt.get_property(rt.new_object('WC_Webhook', [
			'WC_Legacy_Webhook',
		], &this), 'data_store'), 'get_api_version_number', [
			var_version_mutated.clone()])
	}
	this.set_prop(rt.new_string('api_version'), rt.new_int(var_version_mutated.to_i64()))
}

fn (mut this Class_WC_Webhook) set_pending_delivery(var_pending_delivery rt.PhpVal) {
	this.set_prop(rt.new_string('pending_delivery'), rt.new_bool(var_pending_delivery.to_bool()))
}

fn (mut this Class_WC_Webhook) set_failure_count(var_failure_count rt.PhpVal) {
	this.set_prop(rt.new_string('failure_count'), rt.new_int(var_failure_count.clone().to_i64()))
}

fn (mut this Class_WC_Webhook) get_topic_hooks(var_topic rt.PhpVal) rt.PhpVal {
	mut var_topic_mutated := var_topic
	mut var_topic_hooks := rt.create_array([
		rt.ArrayItem{ key: 'coupon.created', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_process_shop_coupon_meta' },
			rt.ArrayItem{ key: none, val: 'woocommerce_new_coupon' },
		]) },
		rt.ArrayItem{ key: 'coupon.updated', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_process_shop_coupon_meta' },
			rt.ArrayItem{ key: none, val: 'woocommerce_update_coupon' },
		]) },
		rt.ArrayItem{ key: 'coupon.deleted', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp_trash_post' },
		]) },
		rt.ArrayItem{ key: 'coupon.restored', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'untrashed_post' },
		]) },
		rt.ArrayItem{ key: 'customer.created', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'user_register' },
			rt.ArrayItem{ key: none, val: 'woocommerce_created_customer' },
			rt.ArrayItem{ key: none, val: 'woocommerce_new_customer' },
		]) },
		rt.ArrayItem{ key: 'customer.updated', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'profile_update' },
			rt.ArrayItem{ key: none, val: 'woocommerce_update_customer' },
		]) },
		rt.ArrayItem{ key: 'customer.deleted', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'delete_user' },
		]) },
		rt.ArrayItem{ key: 'order.created', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_new_order' },
		]) },
		rt.ArrayItem{ key: 'order.updated', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_update_order' },
			rt.ArrayItem{ key: none, val: 'woocommerce_order_refunded' },
		]) },
		rt.ArrayItem{ key: 'order.deleted', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp_trash_post' },
			rt.ArrayItem{ key: none, val: 'woocommerce_trash_order' },
		]) },
		rt.ArrayItem{ key: 'order.restored', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'untrashed_post' },
			rt.ArrayItem{ key: none, val: 'woocommerce_untrash_order' },
		]) },
		rt.ArrayItem{ key: 'product.created', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_process_product_meta' },
			rt.ArrayItem{ key: none, val: 'woocommerce_new_product' },
			rt.ArrayItem{ key: none, val: 'woocommerce_new_product_variation' },
		]) },
		rt.ArrayItem{ key: 'product.updated', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_process_product_meta' },
			rt.ArrayItem{ key: none, val: 'woocommerce_update_product' },
			rt.ArrayItem{ key: none, val: 'woocommerce_update_product_variation' },
		]) },
		rt.ArrayItem{ key: 'product.deleted', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp_trash_post' },
		]) },
		rt.ArrayItem{ key: 'product.restored', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'untrashed_post' },
		]) },
		rt.ArrayItem{ key: 'product.published', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_product_published' },
		]) },
	])
	var_topic_hooks = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_topic_hooks'),
		var_topic_hooks.clone(),
		rt.new_object('WC_Webhook', ['WC_Legacy_Webhook'], &this),
	])
	return if var_topic_hooks.array_isset(var_topic_mutated) {
		var_topic_hooks.array_get(var_topic_mutated)
	} else {
		rt.new_array()
	}
}

fn (mut this Class_WC_Webhook) get_hooks() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('action'), this.get_resource())) {
		mut var_hooks := rt.create_array([
			rt.ArrayItem{ key: none, val: this.get_event() },
		])
	} else {
		var_hooks = this.get_topic_hooks(this.get_topic(''))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_webhook_hooks'),
		var_hooks.clone(), this.get_id()])
}

fn (mut this Class_WC_Webhook) get_resource() rt.PhpVal {
	mut var_topic := rt.call_function('explode', [rt.new_string('.'),
		this.get_topic('')])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_resource'),
		var_topic.array_get(rt.new_int(0)),
		this.get_id(),
	])
}

fn (mut this Class_WC_Webhook) get_event() rt.PhpVal {
	mut var_topic := rt.call_function('explode', [rt.new_string('.'),
		this.get_topic('')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_webhook_event'),
		if var_topic.array_isset(rt.new_int(1)) {
			var_topic.array_get(rt.new_int(1))
		} else {
			rt.new_string('')
		}, this.get_id()])
}

fn (mut this Class_WC_Webhook) get_i18n_status() rt.PhpVal {
	mut var_status := this.get_status('')
	mut var_statuses := rt.call_function('wc_get_webhook_statuses', []rt.PhpVal{})
	return if var_statuses.array_isset(var_status) {
		var_statuses.array_get(var_status)
	} else {
		var_status
	}
}

struct Class_WC_Legacy_Webhook {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_webhook(data i64) &Class_WC_Webhook {
	mut obj := &Class_WC_Webhook{
		PhpObjectBase: rt.PhpObjectBase{}
		processed:     rt.new_array()
		data:          rt.new_array()
	}
	obj.construct(data)
	return obj
}

fn create_wc_legacy_webhook(_args ...rt.PhpVal) &Class_WC_Legacy_Webhook {
	mut obj := &Class_WC_Legacy_Webhook{
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

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_utilities_loggingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_LoggingUtil{
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

fn (mut this Class_WC_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue' {
			this.enqueue()
			return rt.new_null()
		}
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process(dispatch_arg_0)
		}
		'should_deliver' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.should_deliver(dispatch_arg_0)
		}
		'is_active' {
			return this.is_active()
		}
		'is_valid_topic' {
			return this.is_valid_topic()
		}
		'is_valid_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_valid_action(dispatch_arg_0)
		}
		'is_valid_post_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_post_action(dispatch_arg_0))
		}
		'is_valid_user_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_user_action(dispatch_arg_0))
		}
		'is_valid_processing_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_processing_action(dispatch_arg_0))
		}
		'is_valid_resource' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_resource(dispatch_arg_0))
		}
		'is_already_processed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_already_processed(dispatch_arg_0))
		}
		'deliver' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.deliver(dispatch_arg_0)
			return rt.new_null()
		}
		'get_wp_api_payload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_wp_api_payload(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'build_payload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.build_payload(dispatch_arg_0)
		}
		'generate_signature' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_signature(dispatch_arg_0)
		}
		'get_new_delivery_id' {
			return this.get_new_delivery_id()
		}
		'log_delivery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.log_delivery(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'failed_delivery' {
			this.failed_delivery()
			return rt.new_null()
		}
		'get_delivery_logs' {
			return this.get_delivery_logs()
		}
		'get_delivery_log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_delivery_log(dispatch_arg_0)
			return rt.new_null()
		}
		'deliver_ping' {
			return rt.new_bool(this.deliver_ping())
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_status(dispatch_arg_0)
		}
		'get_date_created' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_created(dispatch_arg_0)
		}
		'get_date_modified' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_modified(dispatch_arg_0)
		}
		'get_secret' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_secret(dispatch_arg_0)
		}
		'get_topic' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_topic(dispatch_arg_0)
		}
		'get_delivery_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_delivery_url(dispatch_arg_0)
		}
		'get_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_user_id(dispatch_arg_0)
		}
		'get_api_version' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_api_version(dispatch_arg_0))
		}
		'get_failure_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_failure_count(dispatch_arg_0)
		}
		'get_pending_delivery' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_pending_delivery(dispatch_arg_0)
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_created(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_modified(dispatch_arg_0)
			return rt.new_null()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_secret' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_secret(dispatch_arg_0)
			return rt.new_null()
		}
		'set_topic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_topic(dispatch_arg_0)
			return rt.new_null()
		}
		'set_delivery_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_delivery_url(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_user_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_api_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_api_version(dispatch_arg_0)
			return rt.new_null()
		}
		'set_pending_delivery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_pending_delivery(dispatch_arg_0)
			return rt.new_null()
		}
		'set_failure_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_failure_count(dispatch_arg_0)
			return rt.new_null()
		}
		'get_topic_hooks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_topic_hooks(dispatch_arg_0)
		}
		'get_hooks' {
			return this.get_hooks()
		}
		'get_resource' {
			return this.get_resource()
		}
		'get_event' {
			return this.get_event()
		}
		'get_i18n_status' {
			return this.get_i18n_status()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'processed' { return this.processed }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'processed' {
			this.processed = val
			return true
		}
		'data' {
			this.data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Legacy_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Legacy_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.include_file(@DIR + '/legacy/class-wc-legacy-webhook.php', '4')
}
