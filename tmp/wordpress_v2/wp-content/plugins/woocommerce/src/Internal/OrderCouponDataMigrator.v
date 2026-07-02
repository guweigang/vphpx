import rt

struct Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) register() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderCouponDataMigrator', [
				'BatchProcessorInterface',
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'handle_woocommerce_debug_tools' },
		]),
		rt.new_int(999), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) get_name() string {
	return "Coupon line item 'coupon_data' to 'coupon_info' metadata migrator"
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) get_description() string {
	return "Migrates verbose metadata about coupons applied to an order ('coupon_data' metadata key in coupon line items) to simplified metadata ('coupon_info' keys)"
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) get_total_pending_count() i64 {
	mut var_wpdb := rt.new_null()
	return (rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_order_itemmeta WHERE meta_key=%s')),
			rt.new_string('coupon_data'),
		]),
	])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) get_next_batch_to_process(size i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_meta_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_order_itemmeta WHERE meta_key=%s ORDER BY meta_id ASC LIMIT %d')),
			rt.new_string('coupon_data'),
			rt.new_int(size),
		]),
	])
	return rt.call_function('array_map', [rt.new_string('absint'),
		var_meta_ids.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) process_batch(mut var_batch Class_Automattic_WooCommerce_Internal_array) {
	mut var_wpdb := rt.new_null()
	if !rt.is_true(var_batch) {
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_0 := iife_temp_0.to_sql_list(rt.new_object('Automattic_WooCommerce_Internal_array',
		[]string{}, var_batch))
	mut var_meta_ids := iife_result_0
	mut var_meta_ids_and_values := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.new_string('SELECT meta_id,meta_value FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('woocommerce_order_itemmeta WHERE meta_id IN ')),
			var_meta_ids),
		rt.get_constant('ARRAY_N'),
	])
	mut iter_1 := var_meta_ids_and_values.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta_id_and_value := item_1.val
		this.convert_item(rt.new_int((var_meta_id_and_value.array_get(rt.new_int(0))).to_i64()),
			(var_meta_id_and_value.array_get(rt.new_int(1))).str())
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
			mut var_ex := var_e_1.clone()
			mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
			mut iife_result_1 :=
				iife_temp_1.class_name_without_namespace(Class_Automattic_WooCommerce_Internal_Automattic_WooCommerce_Internal_OrderCouponDataMigrator.class())
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
				rt.new_string(iife_result_1.str() +
					rt.concat(rt.concat(rt.concat(rt.new_string(': when converting meta row with id '), var_meta_id_and_value.array_get(rt.new_int(0))), rt.new_string(': ')), rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}))),
			])
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
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) convert_item(meta_id i64, meta_value string) {
	mut var_wpdb := rt.new_null()
	mut var_coupon_data := rt.call_function('unserialize', [rt.new_string(meta_value)])
	mut var_temp_coupon := create_automattic_woocommerce_internal_wc_coupon()
	var_temp_coupon.set_props(var_coupon_data.clone())
	rt.call_method(var_wpdb, 'update', [
		rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_order_itemmeta')),
		rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'coupon_info' },
			rt.ArrayItem{ key: 'meta_value', val: var_temp_coupon.get_short_info() }]),
		rt.create_array([rt.ArrayItem{ key: 'meta_id', val: meta_id }]),
	])
	if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.get_property(var_wpdb,
			'last_error'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) get_default_batch_size() i64 {
	return 1000
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) handle_woocommerce_debug_tools(mut var_tools Class_Automattic_WooCommerce_Internal_array) rt.PhpVal {
	mut var_tools_mutated := var_tools
	mut var_batch_processor := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.class(),
	])
	mut var_pending_count := rt.new_int(this.get_total_pending_count())
	if rt.is_true(rt.identical(rt.new_int(0), var_pending_count)) {
		var_tools_mutated.array_set('start_convert_order_coupon_data', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Start converting order coupon data to the simplified format'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Start converting'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'disabled', val: true },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This will convert <code>coupon_data</code> order item meta entries to simplified <code>coupon_info</code> entries. The conversion will happen overtime in the background (via Action Scheduler). There are currently no entries to convert.'),
				rt.new_string('woocommerce'),
			]) },
		]))
	} else if rt.is_true(rt.call_method(var_batch_processor, 'is_enqueued', [
		Class_Automattic_WooCommerce_Internal_Automattic_WooCommerce_Internal_OrderCouponDataMigrator.class(),
	]))
	{
		var_tools_mutated.array_set('stop_convert_order_coupon_data', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Stop converting order coupon data to the simplified format'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Stop converting'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('This will stop the background process that converts <code>coupon_data</code> order item meta entries to simplified <code>coupon_info</code> entries. There are currently %d entries that can be converted.'),
					rt.new_string('woocommerce'),
				]),
				var_pending_count.clone(),
			]) },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderCouponDataMigrator', [
					'BatchProcessorInterface',
					'RegisterHooksInterface',
				], &this) },
				rt.ArrayItem{ key: none, val: 'dequeue' },
			]) },
		]))
	} else {
		var_tools_mutated.array_set('start_converting_order_coupon_data', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Convert order coupon data to the simplified format'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Start converting'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('This will convert <code>coupon_data</code> order item meta entries to simplified <code>coupon_info</code> entries. The conversion will happen overtime in the background (via Action Scheduler). There are currently %d entries that can be converted.'),
					rt.new_string('woocommerce'),
				]),
				var_pending_count.clone(),
			]) },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderCouponDataMigrator', [
					'BatchProcessorInterface',
					'RegisterHooksInterface',
				], &this) },
				rt.ArrayItem{ key: none, val: 'enqueue' },
			]) },
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_array', []string{}, var_tools_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) enqueue() string {
	mut var_batch_processor := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.class(),
	])
	if rt.is_true(rt.call_method(var_batch_processor, 'is_enqueued', [
		Class_Automattic_WooCommerce_Internal_Automattic_WooCommerce_Internal_OrderCouponDataMigrator.class(),
	]))
	{
		return (rt.call_function('__', [
			rt.new_string('Background process for coupon meta conversion already started, nothing done.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	rt.call_method(var_batch_processor, 'enqueue_processor', [
		Class_Automattic_WooCommerce_Internal_Automattic_WooCommerce_Internal_OrderCouponDataMigrator.class(),
	])
	return (rt.call_function('__', [
		rt.new_string('Background process for coupon meta conversion started'),
		rt.new_string('woocommerce'),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) dequeue() string {
	mut var_batch_processor := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_batch_processor, 'is_enqueued', [
		Class_Automattic_WooCommerce_Internal_Automattic_WooCommerce_Internal_OrderCouponDataMigrator.class(),
	])))))
	{
		return (rt.call_function('__', [
			rt.new_string('Background process for coupon meta conversion not started, nothing done.'),
			rt.new_string('woocommerce'),
		])).str()
	}
	rt.call_method(var_batch_processor, 'remove_processor', [
		Class_Automattic_WooCommerce_Internal_Automattic_WooCommerce_Internal_OrderCouponDataMigrator.class(),
	])
	return (rt.call_function('__', [
		rt.new_string('Background process for coupon meta conversion stopped'),
		rt.new_string('woocommerce'),
	])).str()
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_WC_Coupon {
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

fn create_automattic_woocommerce_internal_ordercoupondatamigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_wc_coupon(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_Internal_WC_Coupon{
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

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_total_pending_count' {
			return rt.new_int(this.get_total_pending_count())
		}
		'get_next_batch_to_process' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_next_batch_to_process(dispatch_arg_0)
		}
		'process_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_batch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'convert_item' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.convert_item(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_default_batch_size' {
			return rt.new_int(this.get_default_batch_size())
		}
		'handle_woocommerce_debug_tools' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.handle_woocommerce_debug_tools(mut dispatch_arg_0)
		}
		'enqueue' {
			return rt.new_string(this.enqueue())
		}
		'dequeue' {
			return rt.new_string(this.dequeue())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderCouponDataMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
