import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger {
	rt.PhpObjectBase
pub mut:
		slug rt.PhpVal = rt.new_null()
		results rt.PhpVal = rt.new_array()
		logger rt.PhpVal = rt.new_null()
		source rt.PhpVal = rt.new_string('')
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) construct(var_slug rt.PhpVal, var_source rt.PhpVal, mut var_logger Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_?WC_Logger_Interface) {
	mut var_logger_mutated := var_logger
	this.slug = var_slug.clone()
	if rt.is_true(rt.identical(rt.new_null(), var_logger_mutated)) {
	var_logger_mutated = rt.call_function('wc_get_logger', []rt.PhpVal{})
	}
	if rt.is_true(var_source) {
		this.source = var_source.clone()
	}
	this.logger = var_logger_mutated
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) add_result(var_rule_type rt.PhpVal, var_result rt.PhpVal) {
	this.results.array_push(rt.create_array([rt.ArrayItem{ key: 'rule', val: var_rule_type }, rt.ArrayItem{ key: 'result', val: if rt.is_true(var_result) { 'passed' } else { 'failed' } }]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) log() {
	mut var_should_log := rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WC_ADMIN_DEBUG_RULE_EVALUATOR')])) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('constant', [rt.new_string('WC_ADMIN_DEBUG_RULE_EVALUATOR')]))))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_remote_specs_evaluator_should_log'), var_should_log.clone()]))))) {
		return
	}
	mut iter_1 := this.results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_result := item_1.val
		rt.call_method(this.logger, 'debug', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('['), this.slug), rt.new_string('] ')), var_result.array_get(rt.new_string('rule'))), rt.new_string(': ')), var_result.array_get(rt.new_string('result'))), rt.create_array([rt.ArrayItem{ key: 'source', val: this.source }])])
	}
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluationlogger(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger{
		PhpObjectBase: rt.PhpObjectBase{}
		slug: rt.new_null()
		results: rt.new_array()
		logger: rt.new_null()
		source: rt.new_string('')
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_?WC_Logger_Interface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'add_result' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_result(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'log' {
			this.log()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'slug' { return this.slug }
		'results' { return this.results }
		'logger' { return this.logger }
		'source' { return this.source }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'slug' { this.slug = val; return true }
		'results' { this.results = val; return true }
		'logger' { this.logger = val; return true }
		'source' { this.source = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
