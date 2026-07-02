import rt

pub fn Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status() string {
	return 'wc-checkout-draft'
}

pub fn Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.status() string {
	return 'checkout-draft'
}

pub fn Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.draft_cleanup_event_hook() string {
	return 'woocommerce_cleanup_draft_orders'
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders {
	rt.PhpObjectBase
pub mut:
	package rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) construct(mut var_package Class_Automattic_WooCommerce_Blocks_Domain_Package) {
	this.package = var_package
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) init() {
	rt.call_function('add_filter', [rt.new_string('wc_order_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_draft_order_status' },
		])])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_register_shop_order_post_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_draft_order_post_status' },
		]),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_analytics_excluded_order_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'append_draft_order_post_status' },
		]),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_valid_order_statuses_for_payment'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'append_draft_order_post_status' },
		]),
		rt.new_int(999),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_valid_order_statuses_for_payment_complete'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'append_draft_order_post_status' },
		]),
		rt.new_int(999),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_my_account_my_orders_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'delete_draft_order_post_status_from_args' },
		]),
	])
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.draft_cleanup_event_hook(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'delete_expired_draft_orders' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'install' },
		])])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_PLUGIN_BASENAME')])) {
		rt.call_function('add_action', [
			rt.new_string('deactivate_' + (rt.get_constant('WC_PLUGIN_BASENAME')).str()),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'unschedule_cronjobs' },
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) install() {
	this.maybe_create_cronjobs()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) unschedule_cronjobs() {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}),
		'cancel_all', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.draft_cleanup_event_hook(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) maybe_create_cronjobs() {
	mut var_has_scheduled_action := rt.new_string((if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('as_has_scheduled_action'),
	]))
	{ 'as_has_scheduled_action' } else { 'as_next_scheduled_action' }).str())
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('call_user_func', [
		var_has_scheduled_action.clone(),
		Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.draft_cleanup_event_hook(),
	])))
	{
		mut var_midnight_tonight := rt.call_function('strtotime', [
			rt.new_string('midnight tonight'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_midnight_tonight)))) {
			rt.call_function('as_schedule_recurring_action', [
				var_midnight_tonight.clone(), rt.get_constant('DAY_IN_SECONDS'),
				Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.draft_cleanup_event_hook()])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) register_draft_order_status(mut var_statuses Class_Automattic_WooCommerce_Blocks_Domain_Services_array) rt.PhpVal {
	mut var_statuses_mutated := var_statuses
	var_statuses_mutated.array_set(Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status(), rt.call_function('_x', [
		rt.new_string('Draft'),
		rt.new_string('Order status'),
		rt.new_string('woocommerce'),
	]))
	return rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_array', []string{},
		var_statuses_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) register_draft_order_post_status(mut var_statuses Class_Automattic_WooCommerce_Blocks_Domain_Services_array) rt.PhpVal {
	mut var_statuses_mutated := var_statuses
	var_statuses_mutated.array_set(Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status(),
		this.get_post_status_properties())
	return rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_array', []string{},
		var_statuses_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) get_post_status_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Draft'), rt.new_string('Order status'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'exclude_from_search', val: true },
		rt.ArrayItem{ key: 'show_in_admin_all_list', val: false },
		rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
		rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
			rt.new_string('Drafts <span class="count">(%s)</span>'),
			rt.new_string('Drafts <span class="count">(%s)</span>'),
			rt.new_string('woocommerce')]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) delete_draft_order_post_status_from_args(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.clone().array_isset(rt.new_string('status'))))))) {
		mut var_statuses := rt.new_array()
		mut iter_1 := rt.call_function('wc_get_order_statuses', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status(),
				var_key))))
			{
				var_statuses.array_push(rt.call_function('str_replace', [
					rt.new_string('wc-'),
					rt.new_string(''),
					var_key.clone(),
				]))
			}
		}
		var_args_mutated.array_set('status', var_statuses.clone())
	} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status(),
		var_args_mutated.array_get(rt.new_string('status'))))
	{
		var_args_mutated.array_set('status', '')
	} else if rt.is_true(rt.new_bool(var_args_mutated.array_get(rt.new_string('status')).is_array())) {
		var_args_mutated.array_set('status', rt.call_function('array_diff_key', [
			var_args_mutated.array_get(rt.new_string('status')),
			rt.create_array([
				rt.ArrayItem{
					key: Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.status()
					val: rt.new_null()
				},
			]),
		]))
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) append_draft_order_post_status(var_statuses rt.PhpVal) rt.PhpVal {
	mut var_statuses_mutated := var_statuses
	var_statuses_mutated.array_push(Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.status())
	return var_statuses_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) delete_expired_draft_orders() {
	mut var_count := rt.new_int(0)
	mut var_batch_size := rt.call_function('max', [rt.new_int(1),
		rt.new_int((rt.call_function('apply_filters', [
			rt.new_string('woocommerce_delete_expired_draft_orders_batch_size'),
			rt.new_int(20),
		])).to_i64())])
	this.ensure_draft_status_registered()
	mut var_orders := rt.call_function('wc_get_orders', [
		rt.create_array([
			rt.ArrayItem{ key: 'date_modified', val: '<=' +
				(rt.call_function('strtotime', [rt.new_string('-1 DAY')])).str() },
			rt.ArrayItem{ key: 'limit', val: var_batch_size },
			rt.ArrayItem{
				key: 'status'
				val: Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status()
			},
			rt.ArrayItem{ key: 'type', val: 'shop_order' },
		]),
	])
	this.assert_order_results(var_orders.clone(), var_batch_size.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_orders) {
		mut iter_2 := var_orders.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_order := item_2.val
			rt.call_method(var_order, 'delete', [rt.new_bool(true)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			rt.pre_inc(var_count)
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.identical(var_batch_size, var_count))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('as_enqueue_async_action')])) {
		rt.call_function('as_enqueue_async_action', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.draft_cleanup_event_hook(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
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
		mut var_error := var_e_1.clone()
		rt.call_function('wc_caught_exception', [var_error.clone(),
			rt.new_string(@METHOD)])
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
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) ensure_draft_status_registered() {
	mut var_is_registered := rt.call_function('get_post_stati', [
		rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status()
			},
		]),
	])
	if !rt.is_true(var_is_registered) {
		rt.call_function('register_post_status', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.db_status(),
			this.get_post_status_properties(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) assert_order_results(var_order_results rt.PhpVal, var_expected_batch_size rt.PhpVal) {
	if !(var_order_results.clone().is_array()) {
		return
	}
	mut var_suffix :=
		rt.new_string(' This is an indicator that something is filtering WooCommerce or WordPress queries and modifying the query parameters.')
	if rt.is_true(rt.greater(rt.new_int(var_order_results.clone().array_count()),
		var_expected_batch_size))
	{
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(
			'There are an unexpected number of results returned from the query.' + var_suffix.str())))
	}
	mut iter_3 := var_order_results.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_order := item_3.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(
				'The returned results contain a value that is not a WC_Order.' + var_suffix.str())))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [
			Class_Automattic_WooCommerce_Blocks_Domain_Services_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders.status(),
		])))))
		{
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(
				'The results contain an order that is not a `wc-checkout-draft` status in the results.' +
				var_suffix.str())))
		}
	}
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

fn create_automattic_woocommerce_blocks_domain_services_draftorders(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders{
		PhpObjectBase: rt.PhpObjectBase{}
		package:       rt.new_null()
	}
	obj.construct(arg_0)
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Package](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'install' {
			this.install()
			return rt.new_null()
		}
		'unschedule_cronjobs' {
			this.unschedule_cronjobs()
			return rt.new_null()
		}
		'maybe_create_cronjobs' {
			this.maybe_create_cronjobs()
			return rt.new_null()
		}
		'register_draft_order_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.register_draft_order_status(mut dispatch_arg_0)
		}
		'register_draft_order_post_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.register_draft_order_post_status(mut dispatch_arg_0)
		}
		'get_post_status_properties' {
			return this.get_post_status_properties()
		}
		'delete_draft_order_post_status_from_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_draft_order_post_status_from_args(dispatch_arg_0)
		}
		'append_draft_order_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_draft_order_post_status(dispatch_arg_0)
		}
		'delete_expired_draft_orders' {
			this.delete_expired_draft_orders()
			return rt.new_null()
		}
		'ensure_draft_status_registered' {
			this.ensure_draft_status_registered()
			return rt.new_null()
		}
		'assert_order_results' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.assert_order_results(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'package' { return this.package }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_DraftOrders) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'package' {
			this.package = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
