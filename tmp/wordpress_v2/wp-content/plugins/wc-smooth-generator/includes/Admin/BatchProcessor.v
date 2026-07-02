import rt

pub fn Class_WC_SmoothGenerator_Admin_BatchProcessor.option_key() string {
	return 'smoothgenerator_async_job'
}

struct Class_WC_SmoothGenerator_Admin_BatchProcessor {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job() rt.PhpVal {
	mut var_current_job := rt.call_function('get_option', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.option_key(),
		rt.new_null(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob'))))))
		&& rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_WC_SmoothGenerator_Admin_BatchProcessingController.class()]), 'is_enqueued', [Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.class()])) {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_WC_SmoothGenerator_Admin_BatchProcessingController.class(),
		]), 'remove_processor', [
			Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.class(),
		])
	} else if
		rt.is_true(rt.new_bool(rt.instance_of(var_current_job, 'WC_SmoothGenerator_Admin_AsyncJob')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_WC_SmoothGenerator_Admin_BatchProcessingController.class()]), 'is_enqueued', [Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.class()]))))) {
		Class_WC_SmoothGenerator_Admin_BatchProcessor.delete_current_job()
		var_current_job = rt.new_null()
	}
	return var_current_job.clone()
}

fn Class_WC_SmoothGenerator_Admin_BatchProcessor.create_new_job(generator_slug string, amount i64, mut var_args Class_WC_SmoothGenerator_Admin_array) rt.PhpVal {
	mut amount_mutated := amount
	if rt.is_true(rt.new_bool(rt.instance_of(Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job(),
		'WC_SmoothGenerator_Admin_AsyncJob')))
	{
		return rt.new_object('WC_SmoothGenerator_Admin_WP_Error', []string{}, create_wc_smoothgenerator_admin_wp_error(rt.new_string('smoothgenerator_async_job_already_exists'),
			rt.new_string("Can't create a new Smooth Generator job because one is already in progress.")))
	}
	mut var_job := create_wc_smoothgenerator_admin_asyncjob(rt.create_array([
		rt.ArrayItem{ key: 'generator_slug', val: generator_slug },
		rt.ArrayItem{ key: 'amount', val: amount_mutated },
		rt.ArrayItem{ key: 'args', val: var_args },
		rt.ArrayItem{ key: 'pending', val: amount_mutated },
	]))
	rt.call_function('update_option', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.option_key(),
		var_job,
		rt.new_bool(false),
	])
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_WC_SmoothGenerator_Admin_BatchProcessingController.class(),
	]), 'enqueue_processor', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.class(),
	])
	return mut var_job
}

fn Class_WC_SmoothGenerator_Admin_BatchProcessor.update_current_job(processed i64) rt.PhpVal {
	mut var_current_job := Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_current_job,
		'WC_SmoothGenerator_Admin_AsyncJob'))))))
	{
		return rt.new_object('WC_SmoothGenerator_Admin_WP_Error', []string{}, create_wc_smoothgenerator_admin_wp_error(rt.new_string('smoothgenerator_async_job_does_not_exist'),
			rt.new_string('There is no Smooth Generator job to update.')))
	}
	rt.get_property(var_current_job, 'processed') = rt.add(rt.get_property(var_current_job,
		'processed'), rt.new_int(processed))
	rt.set_property(var_current_job, 'pending', rt.call_function('max', [
		rt.sub(rt.get_property(var_current_job, 'pending'), rt.new_int(processed)),
		rt.new_int(0),
	]))
	rt.call_function('update_option', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.option_key(),
		var_current_job.clone(),
		rt.new_bool(false),
	])
	return var_current_job.clone()
}

fn Class_WC_SmoothGenerator_Admin_BatchProcessor.delete_current_job() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_WC_SmoothGenerator_Admin_BatchProcessingController.class(),
	]), 'remove_processor', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.class(),
	])
	rt.call_function('delete_option', [
		Class_WC_SmoothGenerator_Admin_WC_SmoothGenerator_Admin_BatchProcessor.option_key(),
	])
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) get_name() string {
	return 'Smooth Generator'
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) get_description() string {
	return 'Generates various types of WooCommerce data objects with randomized data for use in testing.'
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) get_total_pending_count() i64 {
	mut var_current_job := Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_current_job,
		'WC_SmoothGenerator_Admin_AsyncJob'))))))
	{
		return 0
	}
	return (rt.get_property(var_current_job, 'pending')).to_i64()
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) get_next_batch_to_process(size i64) rt.PhpVal {
	mut var_current_job := Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job()
	mut iife_temp_0 := Class_WC_SmoothGenerator_Admin_BatchProcessor{}
	mut iife_result_0 := iife_temp_0.get_default_batch_size()
	mut var_max_batch := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_current_job,
		'WC_SmoothGenerator_Admin_AsyncJob'))))))
	{
		var_current_job = create_wc_smoothgenerator_admin_asyncjob()
	}
	mut var_amount := rt.call_function('min', [rt.new_int(size),
		rt.get_property(var_current_job, 'pending'), var_max_batch.clone()])
	if rt.is_true(rt.less(var_amount, rt.new_int(1))) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'generator_slug', val: rt.get_property(var_current_job, 'generator_slug') },
		rt.ArrayItem{ key: 'amount', val: var_amount },
		rt.ArrayItem{ key: 'args', val: rt.get_property(var_current_job, 'args') },
	])
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) process_batch(mut var_batch Class_WC_SmoothGenerator_Admin_array) {
	mut var_slug := rt.new_null()
	mut var_amount := rt.new_null()
	mut var_args := rt.new_null()
	mut list_tmp_1 := var_batch
	var_slug = list_tmp_1.array_get(0)
	var_amount = list_tmp_1.array_get(1)
	var_args = list_tmp_1.array_get(2)
	mut iife_temp_1 := Class_WC_SmoothGenerator_Router{}
	mut iife_result_1 := iife_temp_1.generate_batch(var_slug.clone(), var_amount.clone(), rt.new_object('WC_SmoothGenerator_Admin_array',
		[]string{}, var_args))
	mut var_result := iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('WC_SmoothGenerator_Admin_Exception', []string{}, create_wc_smoothgenerator_admin_exception(rt.call_method(var_result,
			'get_error_message', []rt.PhpVal{}))))
	}
	Class_WC_SmoothGenerator_Admin_BatchProcessor.update_current_job(var_result.clone().array_count())
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) get_default_batch_size() i64 {
	mut var_current_job := if rt.is_true(Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job()) {
		Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job()
	} else {
		create_wc_smoothgenerator_admin_asyncjob()
	}
	mut iife_temp_2 := Class_WC_SmoothGenerator_Router{}
	mut iife_result_2 := iife_temp_2.get_generator_class(rt.get_property(var_current_job,
		'generator_slug'))
	mut var_generator := iife_result_2
	if rt.is_true(rt.call_function('is_wp_error', [var_generator.clone()])) {
		return 0
	}
	return (Class_WC_SmoothGenerator_Admin_{
		nodeType: 'Expr_Variable'
		line:     221
		name:     'generator'
	}.max_batch_size()).to_i64()
}

struct Class_WC_SmoothGenerator_Admin_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Admin_AsyncJob {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Router {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Admin_Exception {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_admin_batchprocessor(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Admin_BatchProcessor {
	mut obj := &Class_WC_SmoothGenerator_Admin_BatchProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_admin_wp_error(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Admin_WP_Error {
	mut obj := &Class_WC_SmoothGenerator_Admin_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_admin_asyncjob(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Admin_AsyncJob {
	mut obj := &Class_WC_SmoothGenerator_Admin_AsyncJob{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_router(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Router {
	mut obj := &Class_WC_SmoothGenerator_Router{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_admin_exception(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Admin_Exception {
	mut obj := &Class_WC_SmoothGenerator_Admin_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_current_job' {
			return Class_WC_SmoothGenerator_Admin_BatchProcessor.get_current_job()
		}
		'create_new_job' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Admin_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return Class_WC_SmoothGenerator_Admin_BatchProcessor.create_new_job(dispatch_arg_0,
				dispatch_arg_1, mut dispatch_arg_2)
		}
		'update_current_job' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Admin_BatchProcessor.update_current_job(dispatch_arg_0)
		}
		'delete_current_job' {
			Class_WC_SmoothGenerator_Admin_BatchProcessor.delete_current_job()
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Admin_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_batch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_batch_size' {
			return rt.new_int(this.get_default_batch_size())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_SmoothGenerator_Admin_BatchProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Admin_BatchProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Admin_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Admin_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Admin_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Admin_AsyncJob) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Admin_AsyncJob) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Admin_AsyncJob) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Router) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Router) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Router) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Admin_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Admin_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Admin_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
}
