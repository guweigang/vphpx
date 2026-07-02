import rt
import crypto.md5

pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_generation_action() string {
	return 'woocommerce_product_feed_generation'
}
pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_deletion_action() string {
	return 'woocommerce_product_feed_deletion'
}
pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_expiry() rt.PhpVal {
	return 20 * rt.get_constant('HOUR_IN_SECONDS')
}
pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_scheduled() string {
	return 'scheduled'
}
pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_in_progress() string {
	return 'in_progress'
}
pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_completed() string {
	return 'completed'
}
pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_failed() string {
	return 'failed'
}
struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator {
	rt.PhpObjectBase
pub mut:
		integration rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) init(mut var_integration Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) {
	this.integration = var_integration
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) register_hooks() {
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_generation_action(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'feed_generation_action' }])])
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_deletion_action(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'feed_deletion_action' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) get_status(mut var_args Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?array) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_option_key := rt.new_string(this.get_option_key(mut var_args_mutated))
	mut var_status := rt.call_function('get_option', [var_option_key.clone()])
	if var_status.clone().is_array() && !(this.validate_status(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array](var_status))) {
	var_status = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(var_status.clone().is_array())) {
		return var_status.clone()
	}
	rt.call_function('as_unschedule_all_actions', [Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_generation_action(), rt.create_array([rt.ArrayItem{ key: none, val: var_option_key }]), rt.new_string('woo-product-feed')])
	var_status = rt.create_array([rt.ArrayItem{ key: 'scheduled_at', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'completed_at', val: rt.new_null() }, rt.ArrayItem{ key: 'state', val: Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_scheduled() }, rt.ArrayItem{ key: 'progress', val: 0 }, rt.ArrayItem{ key: 'processed', val: 0 }, rt.ArrayItem{ key: 'total', val: -1 }, rt.ArrayItem{ key: 'args', val: if !(var_args_mutated).is_null() { var_args_mutated } else { rt.new_array() } }])
	rt.call_function('update_option', [var_option_key.clone(), var_status.clone()])
	rt.call_function('as_enqueue_async_action', [Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_generation_action(), rt.create_array([rt.ArrayItem{ key: none, val: var_option_key }]), rt.new_string('woo-product-feed'), rt.new_bool(true), rt.new_int(1)])
	if rt.is_true(rt.call_function('class_exists', [Class_ActionScheduler_AsyncRequest_QueueRunner.class()])) && rt.is_true(rt.call_function('class_exists', [Class_ActionScheduler_Store.class()])) {
		mut iife_temp_0 := Class_ActionScheduler_Store{}
		mut iife_result_0 := iife_temp_0.instance()
		mut var_store := iife_result_0
		mut var_async_request := create_actionscheduler_asyncrequest_queuerunner(var_store.clone())
		var_async_request.dispatch()
	}
	return var_status.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) feed_generation_action(option_key string) {
	mut option_key_mutated := option_key
	mut var_status := rt.call_function('get_option', [rt.new_string(option_key_mutated).clone()])
	if !(var_status.clone().is_array()) || !(var_status.array_isset(rt.new_string('state'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_scheduled(), var_status.array_get(rt.new_string('state')))))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Invalid feed generation status'), rt.create_array([rt.ArrayItem{ key: 'status', val: var_status }])])
		return
	}
	var_status.array_set('state', Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_in_progress())
	rt.call_function('update_option', [rt.new_string(option_key_mutated).clone(), var_status.clone()])
	mut var_feed := rt.call_method(this.integration, 'create_feed', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker{}
	mut iife_result_1 := iife_temp_1.from_integration(this.integration, var_feed.clone())
	mut var_walker := iife_result_1
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_args := if !(var_status.array_get(rt.new_string('args'))).is_null() { var_status.array_get(rt.new_string('args')) } else { rt.new_array() }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_args.array_isset(rt.new_string('_product_fields')) && var_args.array_get(rt.new_string('_product_fields')).is_string() && !(!rt.is_true(var_args.array_get(rt.new_string('_product_fields')))) {
		rt.call_method(rt.call_method(this.integration, 'get_product_mapper', []rt.PhpVal{}), 'set_fields', [var_args.array_get(rt.new_string('_product_fields'))])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_args.array_isset(rt.new_string('_variation_fields')) && var_args.array_get(rt.new_string('_variation_fields')).is_string() && !(!rt.is_true(var_args.array_get(rt.new_string('_variation_fields')))) {
		rt.call_method(rt.call_method(this.integration, 'get_product_mapper', []rt.PhpVal{}), 'set_variation_fields', [var_args.array_get(rt.new_string('_variation_fields'))])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	closure_3_fn := fn [mut var_status, var_option_key] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_progress := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_status = this.update_feed_progress(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array](var_status), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress](var_progress))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_function('update_option', [rt.new_string(option_key_mutated).clone(), var_status.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return rt.new_null()
		}
	rt.call_method(var_walker, 'walk', [rt.new_closure(closure_3_fn)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_status.array_set('state', Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_completed())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_status.array_set('url', rt.call_method(var_feed, 'get_file_url', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_status.array_set('path', rt.call_method(var_feed, 'get_file_path', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_status.array_set('completed_at', rt.call_function('time', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('update_option', [rt.new_string(option_key_mutated).clone(), var_status.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('as_schedule_single_action', [rt.add(rt.call_function('time', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_expiry()), Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_deletion_action(), rt.create_array([rt.ArrayItem{ key: none, val: option_key_mutated }, rt.ArrayItem{ key: none, val: rt.call_method(var_feed, 'get_file_path', []rt.PhpVal{}) }]), rt.new_string('woo-product-feed'), rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Throwable') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Feed generation failed'), rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'option_key', val: option_key_mutated }])])
		var_status.array_set('state', Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_failed())
		var_status.array_set('error', rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		var_status.array_set('failed_at', rt.call_function('time', []rt.PhpVal{}))
		rt.call_function('update_option', [rt.new_string(option_key_mutated).clone(), var_status.clone()])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) force_regeneration(mut var_args Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?array) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_option_key := rt.new_string(this.get_option_key(mut var_args_mutated))
	mut var_status := rt.call_function('get_option', [var_option_key.clone()])
	if !(var_status.clone().is_array()) || !(this.validate_status(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array](var_status))) {
		return this.get_status(mut var_args_mutated)
	}
	mut switch_val_1 := if !(var_status.array_get(rt.new_string('state'))).is_null() { var_status.array_get(rt.new_string('state')) } else { rt.new_string('') }
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_scheduled())) {
		return var_status.clone()
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_in_progress())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception', []string{}, create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_exception(rt.new_string('Feed generation is already in progress and cannot be stopped.'))))
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_completed())) {
		rt.call_function('wp_delete_file', [rt.new_string((var_status.array_get(rt.new_string('path'))).str())])
		rt.call_function('delete_option', [var_option_key.clone()])
		return this.get_status(mut var_args_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_failed())) {
		rt.call_function('delete_option', [var_option_key.clone()])
		return this.get_status(mut var_args_mutated)
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception', []string{}, create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_exception(rt.new_string('Unknown feed generation state.'))))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) feed_deletion_action(option_key string, path string) {
	mut option_key_mutated := option_key
	rt.call_function('delete_option', [rt.new_string(option_key_mutated).clone()])
	rt.call_function('wp_delete_file', [rt.new_string(path)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) get_option_key(mut var_args Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?array) string {
	mut var_args_mutated := var_args
	mut var_normalized_args := if !(var_args_mutated).is_null() { var_args_mutated } else { rt.new_array() }
	if !(!rt.is_true(var_normalized_args)) {
		rt.call_function('ksort', [var_normalized_args.clone()])
	}
	return 'feed_status_' + md5.hexhash(rt.call_function('serialize', [rt.create_array([rt.ArrayItem{ key: 'integration', val: rt.call_method(this.integration, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'args', val: var_normalized_args }])]).to_string())
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) update_feed_progress(mut var_status Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array, mut var_progress Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress) rt.PhpVal {
	mut var_status_mutated := var_status
	var_status_mutated.array_set('progress', if rt.is_true(rt.greater(rt.get_property(var_progress, 'total_count'), rt.new_int(0))) { rt.call_function('round', [rt.mul(rt.div(rt.get_property(var_progress, 'processed_items'), rt.get_property(var_progress, 'total_count')), rt.new_int(100)), rt.new_int(2)]) } else { rt.new_int(0) })
	var_status_mutated.array_set('processed', rt.get_property(var_progress, 'processed_items'))
	var_status_mutated.array_set('total', rt.get_property(var_progress, 'total_count'))
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array', []string{}, var_status_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) validate_status(mut var_status Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array) bool {
	mut var_status_mutated := var_status
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_completed(), var_status_mutated.array_get(rt.new_string('state')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_status_mutated.array_get(rt.new_string('path'))]))))) {
			return false
		}
		if !(var_status_mutated.array_isset(rt.new_string('completed_at'))) {
			return false
		}
		if rt.is_true(rt.less(rt.add(var_status_mutated.array_get(rt.new_string('completed_at')), Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.feed_expiry()), rt.call_function('time', []rt.PhpVal{}))) {
			return false
		}
	}
	mut var_scheduled_timeout := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_feed_scheduled_timeout'), rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS'))])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.state_scheduled(), var_status_mutated.array_get(rt.new_string('state')))) && !(var_status_mutated.array_isset(rt.new_string('scheduled_at'))) || rt.is_true(rt.greater(rt.sub(rt.call_function('time', []rt.PhpVal{}), var_status_mutated.array_get(rt.new_string('scheduled_at'))), var_scheduled_timeout)) {
		return false
	}
	return true
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_AsyncRequest_QueueRunner {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_asyncgenerator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator{
		PhpObjectBase: rt.PhpObjectBase{}
		integration: rt.new_null()
	}
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_asyncrequest_queuerunner(_args ...rt.PhpVal) &Class_ActionScheduler_AsyncRequest_QueueRunner {
	mut obj := &Class_ActionScheduler_AsyncRequest_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfeed_feed_productwalker(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'get_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_status(mut dispatch_arg_0)
		}
		'feed_generation_action' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.feed_generation_action(dispatch_arg_0)
			return rt.new_null()
		}
		'force_regeneration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.force_regeneration(mut dispatch_arg_0)
		}
		'feed_deletion_action' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.feed_deletion_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_option_key' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_option_key(mut dispatch_arg_0))
		}
		'update_feed_progress' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_WalkerProgress](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.update_feed_progress(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'validate_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate_status(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'integration' { return this.integration }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'integration' { this.integration = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_AsyncRequest_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductWalker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}
