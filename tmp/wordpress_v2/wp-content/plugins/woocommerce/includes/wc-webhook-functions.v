import rt

fn wc_webhook_execute_queue() {
	mut var_wc_queued_webhooks := []rt.PhpVal{}
	mut var_data := rt.new_null()
	mut var_queue_args := map[string]rt.PhpVal{}
	mut var_next_scheduled_date := rt.new_null()
	if !rt.is_true(var_wc_queued_webhooks) {
		return
	}
	for var_data_shadow in var_wc_queued_webhooks {
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_webhook_deliver_async'),
			rt.new_bool(true),
			var_data_shadow.array_get(rt.new_string('webhook')),
			var_data_shadow.array_get(rt.new_string('arg')),
		]))
		{
			var_queue_args = {
				'webhook_id': rt.call_method(var_data_shadow.array_get(rt.new_string('webhook')),
					'get_id', []rt.PhpVal{})
				'arg':        var_data_shadow.array_get(rt.new_string('arg'))
			}
			var_next_scheduled_date = rt.call_method(rt.call_method(rt.call_function('WC',
				[]rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [
				rt.new_string('woocommerce_deliver_webhook_async'),
				rt.create_array_from_native_map(var_queue_args),
				rt.new_string('woocommerce-webhooks'),
			])
			if var_next_scheduled_date.clone().is_null()
				|| rt.is_true(rt.greater_equal(rt.call_method(var_next_scheduled_date, 'getTimestamp', []rt.PhpVal{}), rt.add(rt.new_int(600), rt.call_function('gmdate', [rt.new_string('U')])))) {
				rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue',
					[]rt.PhpVal{}), 'add', [
					rt.new_string('woocommerce_deliver_webhook_async'),
					rt.create_array_from_native_map(var_queue_args),
					rt.new_string('woocommerce-webhooks'),
				])
			}
		} else {
			rt.call_method(var_data_shadow.array_get(rt.new_string('webhook')), 'deliver', [
				var_data_shadow.array_get(rt.new_string('arg')),
			])
		}
	}
}

fn wc_webhook_process_delivery(var_webhook rt.PhpVal, var_arg rt.PhpVal) {
	mut var_wc_queued_webhooks := []rt.PhpVal{}
	if !(!var_wc_queued_webhooks.is_null()) {
		var_wc_queued_webhooks = []rt.PhpVal{}
	}
	var_wc_queued_webhooks << rt.create_array([
		rt.ArrayItem{ key: 'webhook', val: var_webhook },
		rt.ArrayItem{ key: 'arg', val: var_arg },
	])
}

fn wc_deliver_webhook_async(var_webhook_id rt.PhpVal, var_arg rt.PhpVal) {
	mut var_webhook := rt.new_null()
	var_webhook = create_wc_webhook(var_webhook_id.clone())
	if rt.is_true(rt.identical(rt.new_int(0), var_webhook.get_id())) {
		return
	}
	var_webhook.deliver(var_arg.clone())
}

fn wc_is_webhook_valid_topic(var_topic rt.PhpVal) bool {
	mut var_invalid_topics := []rt.PhpVal{}
	mut var_data := rt.new_null()
	mut var_valid_resources := rt.new_null()
	mut var_valid_events := rt.new_null()
	var_invalid_topics = ['action.woocommerce_login_credentials',
		'action.woocommerce_product_csv_importer_check_import_file_path',
		'action.woocommerce_webhook_should_deliver']
	if rt.is_true(rt.call_function('in_array', [var_topic.clone(),
		rt.create_array_from_list(var_invalid_topics), rt.new_bool(true)]))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_topic.clone(), rt.new_string('action.woocommerce_')])))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_topic.clone(), rt.new_string('action.wc_')]))) {
		return true
	}
	var_data = rt.call_function('explode', [rt.new_string('.'),
		var_topic.clone()])
	if !(var_data.array_isset(rt.new_int(0))) || !(var_data.array_isset(rt.new_int(1))) {
		return false
	}
	var_valid_resources = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_valid_webhook_resources'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'coupon' },
			rt.ArrayItem{ key: none, val: 'customer' }, rt.ArrayItem{ key: none, val: 'order' },
			rt.ArrayItem{ key: none, val: 'product' }]),
	])
	var_valid_events = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_valid_webhook_events'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'created' },
			rt.ArrayItem{ key: none, val: 'updated' }, rt.ArrayItem{ key: none, val: 'deleted' },
			rt.ArrayItem{ key: none, val: 'restored' }, rt.ArrayItem{ key: none, val: 'published' }]),
	])
	if rt.is_true(rt.call_function('in_array', [var_data.array_get(rt.new_int(0)), var_valid_resources.clone(), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('in_array', [var_data.array_get(rt.new_int(1)), var_valid_events.clone(), rt.new_bool(true)])) {
		return true
	}
	return false
}

fn wc_is_webhook_valid_status(var_status rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_status.clone(),
		rt.func_array_keys(wc_get_webhook_statuses()), rt.new_bool(true)])
}

fn wc_get_webhook_statuses() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_webhook_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: 'active', val: rt.call_function('__', [
				rt.new_string('Active'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'paused', val: rt.call_function('__', [
				rt.new_string('Paused'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'disabled', val: rt.call_function('__', [
				rt.new_string('Disabled'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
}

fn wc_load_webhooks(status string, var_limit rt.PhpVal) bool {
	mut var_status := status
	mut var_data_store := rt.new_null()
	mut var_webhooks := rt.new_null()
	mut var_loaded := i64(0)
	mut var_webhook_id := rt.new_null()
	mut var_webhook := rt.new_null()
	if !(var_limit.clone().is_null()) && rt.is_true(rt.less_equal(var_limit, rt.new_int(0))) {
		return false
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('webhook'))
	var_data_store = iife_result_0
	var_webhooks = rt.call_method(var_data_store, 'get_webhooks_ids', [
		rt.new_string(status),
	])
	var_loaded = 0
	mut iter_1 := var_webhooks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_webhook_id_shadow := item_1.val
		if !(var_limit.clone().is_null())
			&& rt.is_true(rt.greater_equal(rt.new_int(var_loaded), var_limit)) {
			break
		}
		var_webhook = create_wc_webhook(var_webhook_id_shadow.clone())
		var_webhook.enqueue()
		var_loaded += 1
	}
	return rt.new_bool(0 < var_loaded)
}

fn wc_get_webhook(var_id rt.PhpVal) rt.PhpVal {
	mut var_webhook := rt.new_null()
	var_webhook = create_wc_webhook(var_id.clone())
	return if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_webhook.get_id())))) {
		var_webhook
	} else {
		rt.new_null()
	}
}

fn wc_get_webhook_rest_api_versions() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'wp_api_v1' },
		rt.ArrayItem{ key: none, val: 'wp_api_v2' }, rt.ArrayItem{ key: none, val: 'wp_api_v3' }])
}

struct Class_WC_Webhook {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_webhook(_args ...rt.PhpVal) &Class_WC_Webhook {
	mut obj := &Class_WC_Webhook{
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

fn (mut this Class_WC_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.new_string('wc_webhook_execute_queue')])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_webhook_process_delivery'),
		rt.new_string('wc_webhook_process_delivery'),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_deliver_webhook_async'),
		rt.new_string('wc_deliver_webhook_async'), rt.new_int(10),
		rt.new_int(2)])
}
