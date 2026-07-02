import rt

struct Class_WC_Log_Handler_Email {
	rt.PhpObjectBase
pub mut:
	threshold    rt.PhpVal = rt.new_null()
	recipients   rt.PhpVal = rt.new_array()
	logs         rt.PhpVal = rt.new_array()
	max_severity rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Log_Handler_Email) construct(var_recipients rt.PhpVal, threshold string) {
	mut var_recipients_mutated := var_recipients
	if rt.is_true(rt.identical(rt.new_null(), var_recipients_mutated)) {
		var_recipients_mutated = rt.call_function('get_option', [
			rt.new_string('admin_email'),
		])
	}
	if rt.is_true(rt.new_bool(var_recipients_mutated.clone().is_array())) {
		mut iter_1 := var_recipients_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_recipient := item_1.val
			this.add_email(var_recipient.clone())
		}
	} else {
		this.add_email(var_recipients_mutated.clone())
	}
	this.set_threshold(rt.new_string(threshold))
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Log_Handler_Email', [
				'WC_Log_Handler',
			], &this) },
			rt.ArrayItem{ key: none, val: 'send_log_email' },
		])])
}

fn (mut this Class_WC_Log_Handler_Email) set_threshold(var_level rt.PhpVal) {
	mut iife_temp_0 := Class_WC_Log_Levels{}
	mut iife_result_0 := iife_temp_0.get_level_severity(var_level.clone())
	this.threshold = iife_result_0
}

fn (mut this Class_WC_Log_Handler_Email) should_handle(var_level rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_WC_Log_Levels{}
	mut iife_result_1 := iife_temp_1.get_level_severity(var_level.clone())
	return rt.less_equal(this.threshold, iife_result_1)
}

fn (mut this Class_WC_Log_Handler_Email) handle(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) bool {
	if rt.is_true(this.should_handle(var_level.clone())) {
		this.add_log(var_timestamp.clone(), var_level.clone(), var_message.clone(),
			var_context.clone())
		return true
	}
	return false
}

fn (mut this Class_WC_Log_Handler_Email) send_log_email() rt.PhpVal {
	mut var_result := rt.new_bool(false)
	if !(!rt.is_true(this.logs)) {
		mut var_subject := this.get_subject()
		mut var_body := rt.new_string(this.get_body())
		var_result = rt.call_function('wp_mail', [this.recipients, var_subject.clone(),
			var_body.clone()])
		this.clear_logs()
	}
	return var_result.clone()
}

fn (mut this Class_WC_Log_Handler_Email) get_subject() rt.PhpVal {
	mut var_site_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	mut iife_temp_2 := Class_WC_Log_Levels{}
	mut iife_result_2 := iife_temp_2.get_severity_level(this.max_severity)
	mut iife_temp_3 := Class_WC_Log_Levels{}
	mut iife_result_3 := iife_temp_3.get_severity_level(this.max_severity)
	mut var_max_level := rt.new_string(iife_result_3.to_string().to_upper())
	mut var_log_count := rt.new_int(this.logs.array_count())
	return rt.call_function('sprintf', [
		rt.call_function('_n', [
			rt.new_string('[%1$s] %2$s: %3$s WooCommerce log message'),
			rt.new_string('[%1$s] %2$s: %3$s WooCommerce log messages'),
			var_log_count.clone(),
			rt.new_string('woocommerce'),
		]),
		var_site_name.clone(),
		var_max_level.clone(),
		var_log_count.clone(),
	])
}

fn (mut this Class_WC_Log_Handler_Email) get_body() string {
	mut var_site_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	mut var_entries := rt.call_function('implode', [rt.get_constant('PHP_EOL'), this.logs])
	mut var_log_count := rt.new_int(this.logs.array_count())
	return
		(rt.call_function('_n', [rt.new_string('You have received the following WooCommerce log message:'), rt.new_string('You have received the following WooCommerce log messages:'), var_log_count.clone(), rt.new_string('woocommerce')])).str() +
		(rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() + var_entries.str() +
		(rt.get_constant('PHP_EOL')).str() + (rt.get_constant('PHP_EOL')).str() + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Visit %s admin area:'), rt.new_string('woocommerce')]), var_site_name.clone()])).str() +
		(rt.get_constant('PHP_EOL')).str() + (rt.call_function('admin_url', []rt.PhpVal{})).str()
}

fn (mut this Class_WC_Log_Handler_Email) add_email(var_email rt.PhpVal) {
	this.recipients.array_push(var_email.clone())
}

fn (mut this Class_WC_Log_Handler_Email) add_log(var_timestamp rt.PhpVal, var_level rt.PhpVal, var_message rt.PhpVal, var_context rt.PhpVal) {
	this.logs.array_push(this.format_entry(var_timestamp.clone(), var_level.clone(),
		var_message.clone(), var_context.clone()))
	mut iife_temp_4 := Class_WC_Log_Levels{}
	mut iife_result_4 := iife_temp_4.get_level_severity(var_level.clone())
	mut var_log_severity := iife_result_4
	if rt.is_true(rt.less(this.max_severity, var_log_severity)) {
		this.max_severity = var_log_severity.clone()
	}
}

fn (mut this Class_WC_Log_Handler_Email) clear_logs() {
	this.logs = rt.new_array()
}

struct Class_WC_Log_Handler {
	rt.PhpObjectBase
}

struct Class_WC_Log_Levels {
	rt.PhpObjectBase
}

fn create_wc_log_handler_email(arg_0 rt.PhpVal, threshold string) &Class_WC_Log_Handler_Email {
	mut obj := &Class_WC_Log_Handler_Email{
		PhpObjectBase: rt.PhpObjectBase{}
		threshold:     rt.new_null()
		recipients:    rt.new_array()
		logs:          rt.new_array()
		max_severity:  rt.new_null()
	}
	obj.construct(arg_0, threshold)
	return obj
}

fn create_wc_log_handler(_args ...rt.PhpVal) &Class_WC_Log_Handler {
	mut obj := &Class_WC_Log_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_log_levels(_args ...rt.PhpVal) &Class_WC_Log_Levels {
	mut obj := &Class_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Log_Handler_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_threshold' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_threshold(dispatch_arg_0)
			return rt.new_null()
		}
		'should_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.should_handle(dispatch_arg_0)
		}
		'handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.handle(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'send_log_email' {
			return this.send_log_email()
		}
		'get_subject' {
			return this.get_subject()
		}
		'get_body' {
			return rt.new_string(this.get_body())
		}
		'add_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_email(dispatch_arg_0)
			return rt.new_null()
		}
		'add_log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.add_log(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'clear_logs' {
			this.clear_logs()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Log_Handler_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'threshold' { return this.threshold }
		'recipients' { return this.recipients }
		'logs' { return this.logs }
		'max_severity' { return this.max_severity }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Log_Handler_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'threshold' {
			this.threshold = val
			return true
		}
		'recipients' {
			this.recipients = val
			return true
		}
		'logs' {
			this.logs = val
			return true
		}
		'max_severity' {
			this.max_severity = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Log_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Log_Levels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
