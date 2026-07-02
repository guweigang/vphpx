import rt
import crypto.md5

pub fn Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.watchdog_action_name() string {
	return 'wc_schedule_pending_batch_processes'
}
pub fn Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.process_single_batch_action_name() string {
	return 'wc_run_batch_process'
}
pub fn Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.enqueued_processors_option_name() string {
	return 'wc_pending_batch_processes'
}
pub fn Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.action_group() string {
	return 'wc_batch_processes'
}
pub fn Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.failing_process_max_attempts_default() i64 {
	return 5
}
struct Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController {
	rt.PhpObjectBase
pub mut:
		logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) construct() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.handle_watchdog_action()
		return rt.new_null()
		}
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.watchdog_action_name(), rt.new_closure(closure_1_fn)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_batch_process := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.process_next_batch_for_single_processor((var_batch_process).str())
		return rt.new_null()
		}
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.process_single_batch_action_name(), rt.new_closure(closure_2_fn), rt.new_int(10), rt.new_int(2)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.remove_or_retry_failed_processors()
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.new_closure(closure_3_fn)])
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) enqueue_processor(processor_class_name string) {
	mut var_pending_updates := this.get_enqueued_processors()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(processor_class_name), rt.func_array_keys(var_pending_updates.clone()), rt.new_bool(true)]))))) {
		var_pending_updates.array_push(processor_class_name)
		this.set_enqueued_processors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](var_pending_updates))
	}
	this.schedule_watchdog_action(false, true)
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) schedule_watchdog_action(with_delay bool, unique bool) {
	mut var_time := rt.call_function('time', []rt.PhpVal{})
	if var_with_delay {
		var_time = rt.add(var_time, rt.call_function('apply_filters', [rt.new_string('woocommerce_batch_processor_watchdog_delay_seconds'), rt.get_constant('HOUR_IN_SECONDS')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('as_has_scheduled_action', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.watchdog_action_name()]))))) {
		rt.call_function('as_schedule_single_action', [var_time.clone(), Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.watchdog_action_name(), rt.new_array(), Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.action_group(), rt.new_bool(unique)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) handle_watchdog_action() {
	mut var_pending_processes := this.get_enqueued_processors()
	if !rt.is_true(var_pending_processes) {
		return
	}
	mut iter_1 := var_pending_processes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_process_name := item_1.val
		if !(this.is_scheduled((var_process_name).str())) {
			this.schedule_batch_processing((var_process_name).str(), false)
		}
	}
	this.schedule_watchdog_action(true, false)
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) process_next_batch_for_single_processor(processor_class_name string) {
	if !(this.is_enqueued(processor_class_name)) {
		return
	}
	mut var_batch_processor := this.get_processor_instance(processor_class_name)
	mut var_error := this.process_next_batch_for_single_processor_core(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_batch_processor))
	mut var_still_pending := rt.new_bool(rt.call_method(var_batch_processor, 'get_next_batch_to_process', [rt.new_int(1)]).array_count() > 0)
	if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Internal_BatchProcessing_Exception'))) {
		if this.is_consistently_failing(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_batch_processor)) {
			this.log_consistent_failure(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_batch_processor), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](this.get_process_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_batch_processor))))
			this.remove_processor(processor_class_name)
		} else {
			this.schedule_batch_processing(processor_class_name, true)
		}
		rt.throw_exception(var_error)
	}
	if rt.is_true(var_still_pending) {
		this.schedule_batch_processing(processor_class_name, false)
	} else {
		this.dequeue_processor(processor_class_name)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) process_next_batch_for_single_processor_core(mut var_batch_processor Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface) rt.PhpVal {
	mut var_batch_processor_mutated := var_batch_processor
	mut var_details := this.get_process_details(mut var_batch_processor_mutated)
	mut var_time_start := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_batch := rt.call_method(var_batch_processor_mutated, 'get_next_batch_to_process', [var_details.array_get(rt.new_string('current_batch_size'))])
	if !rt.is_true(var_batch) {
		return rt.new_null()
	}
	rt.call_method(var_batch_processor_mutated, 'process_batch', [var_batch.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_time_taken := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_time_start)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.update_processor_state(mut var_batch_processor_mutated, (var_time_taken).to_f64(), rt.new_null())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_BatchProcessing_Exception') {
		mut var_exception := var_e_1.clone()
		var_time_taken = rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_time_start)
		this.log_error(mut var_exception, mut var_batch_processor_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](var_batch))
		this.update_processor_state(mut var_batch_processor_mutated, (var_time_taken).to_f64(), mut var_exception)
		return rt.new_object('Automattic_WooCommerce_Internal_BatchProcessing_Exception', []string{}, var_exception)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) get_process_details(mut var_batch_processor Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface) rt.PhpVal {
	mut var_batch_processor_mutated := var_batch_processor
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'total_time_spent', val: 0 }, rt.ArrayItem{ key: 'current_batch_size', val: rt.call_method(var_batch_processor_mutated, 'get_default_batch_size', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'last_error', val: rt.new_null() }, rt.ArrayItem{ key: 'recent_failures', val: 0 }, rt.ArrayItem{ key: 'batch_first_failure', val: rt.new_null() }, rt.ArrayItem{ key: 'batch_last_failure', val: rt.new_null() }])
	mut var_process_details := rt.call_function('get_option', [rt.new_string(this.get_processor_state_option_name(rt.new_object('Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface', []string{}, var_batch_processor_mutated)))])
	var_process_details = rt.call_function('wp_parse_args', [if var_process_details.clone().is_array() { var_process_details } else { rt.new_array() }, var_defaults.clone()])
	return var_process_details.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) get_processor_state_option_name(var_batch_processor rt.PhpVal) string {
	mut var_batch_processor_mutated := var_batch_processor
	mut var_class_name := if rt.is_true(rt.call_function('is_a', [var_batch_processor_mutated.clone(), Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface.class()])) { rt.call_function('get_class', [var_batch_processor_mutated.clone()]) } else { var_batch_processor_mutated }
	mut var_class_md5 := rt.new_string(md5.hexhash(var_class_name.clone().to_string()))
	var_class_name = rt.call_function('substr', [var_class_name.clone(), rt.new_int(0), rt.new_int(140)])
	return 'wc_batch_' + (var_class_name).str() + '_' + (var_class_md5).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) update_processor_state(mut var_batch_processor Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface, time_taken f64, mut var_last_error Class_Automattic_WooCommerce_Internal_BatchProcessing_?Exception) {
	mut var_batch_processor_mutated := var_batch_processor
	mut time_taken_mutated := time_taken
	mut var_last_error_mutated := var_last_error
	mut var_current_status := this.get_process_details(mut var_batch_processor_mutated)
	var_current_status.array_get(rt.new_string('total_time_spent')) = rt.add(var_current_status.array_get(rt.new_string('total_time_spent')), rt.new_float(time_taken_mutated))
	var_current_status.array_set('last_error', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last_error_mutated)))) { rt.call_method(var_last_error_mutated, 'getMessage', []rt.PhpVal{}) } else { rt.new_null() })
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last_error_mutated)))) {
		var_current_status.array_set('recent_failures', rt.add(if !(var_current_status.array_get(rt.new_string('recent_failures'))).is_null() { var_current_status.array_get(rt.new_string('recent_failures')) } else { rt.new_int(0) }, rt.new_int(1)))
		var_current_status.array_set('batch_last_failure', rt.call_function('current_time', [rt.new_string('mysql')]))
		if rt.is_true(rt.new_bool(var_current_status.array_get(rt.new_string('batch_first_failure')).is_null())) {
			var_current_status.array_set('batch_first_failure', var_current_status.array_get(rt.new_string('batch_last_failure')))
		}
	} else {
		var_current_status.array_set('recent_failures', 0)
		var_current_status.array_set('batch_first_failure', rt.new_null())
		var_current_status.array_set('batch_last_failure', rt.new_null())
	}
	rt.call_function('update_option', [rt.new_string(this.get_processor_state_option_name(rt.new_object('Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface', []string{}, var_batch_processor_mutated))), var_current_status.clone(), rt.new_bool(false)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) clear_processor_state(processor_class_name string) {
	rt.call_function('delete_option', [rt.new_string(this.get_processor_state_option_name(rt.new_string(processor_class_name)))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) schedule_batch_processing(processor_class_name string, with_delay bool) {
	mut var_time := if var_with_delay { rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('MINUTE_IN_SECONDS')) } else { rt.call_function('time', []rt.PhpVal{}) }
	rt.call_function('as_schedule_single_action', [var_time.clone(), Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.process_single_batch_action_name(), rt.create_array([rt.ArrayItem{ key: none, val: processor_class_name }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) is_scheduled(processor_class_name string) bool {
	return (rt.call_function('as_has_scheduled_action', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.process_single_batch_action_name(), rt.create_array([rt.ArrayItem{ key: none, val: processor_class_name }])])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) get_processor_instance(processor_class_name string) rt.PhpVal {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_processor := if rt.is_true(rt.call_method(var_container, 'has', [rt.new_string(processor_class_name)])) { rt.call_method(var_container, 'get', [rt.new_string(processor_class_name)]) } else { rt.new_null() }
	var_processor = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_batch_processor'), var_processor.clone(), rt.new_string(processor_class_name)])
	if !(!(var_processor).is_null()) && rt.is_true(rt.call_function('class_exists', [rt.new_string(processor_class_name)])) {
	var_processor = rt.create_object_dynamically(processor_class_name, []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_processor.clone(), Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface.class()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_BatchProcessing_Exception', []string{}, create_automattic_woocommerce_internal_batchprocessing_exception(rt.new_string("Unable to initialize batch processor instance for ${var_processor_class_name}"))))
	}
	return var_processor.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) get_enqueued_processors() rt.PhpVal {
	mut var_enqueued_processors := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.enqueued_processors_option_name(), rt.new_array()])
	if !(var_enqueued_processors.clone().is_array()) {
		rt.call_method(this.logger, 'error', [rt.new_string('Could not fetch list of processors. Clearing up queue.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'batch-processing' }])])
		rt.call_function('delete_option', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.enqueued_processors_option_name()])
	var_enqueued_processors = rt.new_array()
	}
	return var_enqueued_processors.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) dequeue_processor(processor_class_name string) {
	mut var_pending_processes := this.get_enqueued_processors()
	if rt.is_true(rt.call_function('in_array', [rt.new_string(processor_class_name), var_pending_processes.clone(), rt.new_bool(true)])) {
		this.clear_processor_state(processor_class_name)
		var_pending_processes = rt.call_function('array_diff', [var_pending_processes.clone(), rt.create_array([rt.ArrayItem{ key: none, val: processor_class_name }])])
		this.set_enqueued_processors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](var_pending_processes))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) set_enqueued_processors(mut var_processors Class_Automattic_WooCommerce_Internal_BatchProcessing_array) {
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.enqueued_processors_option_name(), var_processors, rt.new_bool(false)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) is_enqueued(processor_class_name string) bool {
	return (rt.call_function('in_array', [rt.new_string(processor_class_name), this.get_enqueued_processors(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) remove_processor(processor_class_name string) bool {
	mut var_enqueued_processors := this.get_enqueued_processors()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(processor_class_name), var_enqueued_processors.clone(), rt.new_bool(true)]))))) {
		return false
	}
	var_enqueued_processors = rt.call_function('array_diff', [var_enqueued_processors.clone(), rt.create_array([rt.ArrayItem{ key: none, val: processor_class_name }])])
	if !rt.is_true(var_enqueued_processors) {
		this.force_clear_all_processes()
	} else {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.enqueued_processors_option_name(), var_enqueued_processors.clone(), rt.new_bool(false)])
		rt.call_function('as_unschedule_all_actions', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.process_single_batch_action_name(), rt.create_array([rt.ArrayItem{ key: none, val: processor_class_name }])])
		this.clear_processor_state(processor_class_name)
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) force_clear_all_processes() {
	rt.call_function('as_unschedule_all_actions', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.process_single_batch_action_name()])
	rt.call_function('as_unschedule_all_actions', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.watchdog_action_name()])
	mut iter_2 := this.get_enqueued_processors().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_processor := item_2.val
		this.clear_processor_state((var_processor).str())
	}
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.enqueued_processors_option_name(), rt.new_array(), rt.new_bool(false)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) log_error(mut var_error Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception, mut var_batch_processor Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface, mut var_batch Class_Automattic_WooCommerce_Internal_BatchProcessing_array) {
	mut var_error_mutated := var_error
	mut var_batch_processor_mutated := var_batch_processor
	mut var_batch_mutated := var_batch
	mut var_error_message := rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('Error processing batch for '), rt.call_method(var_batch_processor_mutated, 'get_name', []rt.PhpVal{})), rt.new_string(': ')), rt.call_method(var_error_mutated, 'getMessage', []rt.PhpVal{}))).str())
	mut var_error_context := rt.create_array([rt.ArrayItem{ key: 'exception', val: var_error_mutated }, rt.ArrayItem{ key: 'source', val: 'batch-processing' }])
	if var_batch_mutated.array_count() > 0 {
	var_error_context = rt.call_function('array_merge', [var_error_context.clone(), rt.create_array([rt.ArrayItem{ key: 'batch_start', val: var_batch_mutated.array_get(rt.new_int(0)) }, rt.ArrayItem{ key: 'batch_end', val: rt.call_function('end', [var_batch_mutated]) }])])
	}
	var_error_message = rt.call_function('apply_filters', [rt.new_string('wc_batch_processing_log_message'), var_error_message.clone(), var_error_mutated, var_batch_processor_mutated, var_batch_mutated, var_error_context.clone()])
	rt.call_method(this.logger, 'error', [var_error_message.clone(), var_error_context.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) is_consistently_failing(mut var_batch_processor Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface) bool {
	mut var_batch_processor_mutated := var_batch_processor
	mut var_process_details := this.get_process_details(mut var_batch_processor_mutated)
	mut var_max_attempts := rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('wc_batch_processing_max_attempts'), Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.failing_process_max_attempts_default(), var_batch_processor_mutated, var_process_details.clone()])])
	return (rt.greater_equal(rt.call_function('absint', [if !(var_process_details.array_get(rt.new_string('recent_failures'))).is_null() { var_process_details.array_get(rt.new_string('recent_failures')) } else { rt.new_int(0) }]), rt.call_function('max', [var_max_attempts.clone(), rt.new_int(1)]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) log_consistent_failure(mut var_batch_processor Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface, mut var_process_details Class_Automattic_WooCommerce_Internal_BatchProcessing_array) {
	mut var_batch_processor_mutated := var_batch_processor
	mut var_process_details_mutated := var_process_details
	rt.call_method(this.logger, 'error', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Batch processor '), rt.call_method(var_batch_processor_mutated, 'get_name', []rt.PhpVal{})), rt.new_string(' appears to be failing consistently: ')), var_process_details_mutated.array_get(rt.new_string('recent_failures'))), rt.new_string(' unsuccessful attempt(s). No further attempts will be made.')), rt.create_array([rt.ArrayItem{ key: 'source', val: 'batch-processing' }, rt.ArrayItem{ key: 'failures', val: var_process_details_mutated.array_get(rt.new_string('recent_failures')) }, rt.ArrayItem{ key: 'first_failure', val: var_process_details_mutated.array_get(rt.new_string('batch_first_failure')) }, rt.ArrayItem{ key: 'last_failure', val: var_process_details_mutated.array_get(rt.new_string('batch_last_failure')) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) remove_or_retry_failed_processors() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
		return
	}
	mut var_last_error := rt.call_function('error_get_last', []rt.PhpVal{})
	if !(var_last_error.clone().is_null()) && rt.is_true(rt.call_function('in_array', [var_last_error.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('E_ERROR') }, rt.ArrayItem{ key: none, val: rt.get_constant('E_PARSE') }, rt.ArrayItem{ key: none, val: rt.get_constant('E_CORE_ERROR') }, rt.ArrayItem{ key: none, val: rt.get_constant('E_COMPILE_ERROR') }, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_ERROR') }, rt.ArrayItem{ key: none, val: rt.get_constant('E_RECOVERABLE_ERROR') }]), rt.new_bool(true)])) {
		return
	}
	mut var_has_scheduled_action := rt.new_string((if rt.is_true(rt.call_function('function_exists', [rt.new_string('as_has_scheduled_action')])) { 'as_has_scheduled_action' } else { 'as_next_scheduled_action' }).str())
	if rt.is_true(rt.call_function('call_user_func', [var_has_scheduled_action.clone(), Class_Automattic_WooCommerce_Internal_BatchProcessing_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.watchdog_action_name()])) {
		return
	}
	mut var_enqueued_processors := this.get_enqueued_processors()
	mut var_unscheduled_processors := rt.call_function('array_diff', [var_enqueued_processors.clone(), rt.call_function('array_filter', [var_enqueued_processors.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'is_scheduled' }])])])
	mut iter_3 := var_unscheduled_processors.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_processor := item_3.val
		mut var_instance := this.get_processor_instance((var_processor).str())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_BatchProcessing_Exception') {
			mut var_e := var_e_2.clone()
			continue
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
		mut var_exception := create_automattic_woocommerce_internal_batchprocessing_exception(rt.new_string('Processor is enqueued but not scheduled. Background job was probably killed or marked as failed. Reattempting execution.'))
		this.update_processor_state(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_instance), 0, mut var_exception)
		this.log_error(mut var_exception, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_instance), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](rt.new_array()))
		if this.is_consistently_failing(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_instance)) {
			this.log_consistent_failure(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_instance), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](this.get_process_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](var_instance))))
			this.remove_processor((var_processor).str())
		} else {
			this.schedule_batch_processing((var_processor).str(), true)
		}
	}
}

struct Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_batchprocessing_batchprocessingcontroller() &Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController {
	mut obj := &Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController{
		PhpObjectBase: rt.PhpObjectBase{}
		logger: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_batchprocessing_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'enqueue_processor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.enqueue_processor(dispatch_arg_0)
			return rt.new_null()
		}
		'schedule_watchdog_action' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.schedule_watchdog_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_watchdog_action' {
			this.handle_watchdog_action()
			return rt.new_null()
		}
		'process_next_batch_for_single_processor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.process_next_batch_for_single_processor(dispatch_arg_0)
			return rt.new_null()
		}
		'process_next_batch_for_single_processor_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.process_next_batch_for_single_processor_core(mut dispatch_arg_0)
		}
		'get_process_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_process_details(mut dispatch_arg_0)
		}
		'get_processor_state_option_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_processor_state_option_name(dispatch_arg_0))
		}
		'update_processor_state' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_?Exception](if args.len > 2 { args[2] } else { rt.new_null() })
			this.update_processor_state(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'clear_processor_state' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.clear_processor_state(dispatch_arg_0)
			return rt.new_null()
		}
		'schedule_batch_processing' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.schedule_batch_processing(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_scheduled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_scheduled(dispatch_arg_0))
		}
		'get_processor_instance' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_processor_instance(dispatch_arg_0)
		}
		'get_enqueued_processors' {
			return this.get_enqueued_processors()
		}
		'dequeue_processor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.dequeue_processor(dispatch_arg_0)
			return rt.new_null()
		}
		'set_enqueued_processors' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_enqueued_processors(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_enqueued' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_enqueued(dispatch_arg_0))
		}
		'remove_processor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.remove_processor(dispatch_arg_0))
		}
		'force_clear_all_processes' {
			this.force_clear_all_processes()
			return rt.new_null()
		}
		'log_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.log_error(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'is_consistently_failing' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_consistently_failing(mut dispatch_arg_0))
		}
		'log_consistent_failure' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessorInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.log_consistent_failure(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'remove_or_retry_failed_processors' {
			this.remove_or_retry_failed_processors()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_BatchProcessing_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_batchprocessing_batchprocessingcontroller()
		return rt.new_object('Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_BatchProcessing_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_batchprocessing_exception()
		return rt.new_object('Automattic_WooCommerce_Internal_BatchProcessing_Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
