import rt

struct Class_WC_Background_Emailer {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Background_Emailer) construct()  {
	this.dispatch_set_prop('prefix', 'wp_' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str())
	this.dispatch_set_prop('action', rt.new_string('wc_emailer'))
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this) }, rt.ArrayItem{ key: none, val: 'dispatch_queue' }]), rt.new_int(100)])
	this.Class_WC_Background_Process.construct()
}

fn (mut this Class_WC_Background_Emailer) schedule_event()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.get_property(rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this), 'cron_hook_identifier')]))))) {
		rt.call_function('wp_schedule_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)), rt.get_property(rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this), 'cron_interval_identifier'), rt.get_property(rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this), 'cron_hook_identifier')])
	}
}

fn (mut this Class_WC_Background_Emailer) task(var_callback rt.PhpVal) bool {
	if var_callback.array_isset(rt.new_string('filter')) && var_callback.array_isset(rt.new_string('args')) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Emails{}; return temp.send_queued_transactional_email(arg_0, arg_1) }(var_callback.array_get('filter'), var_callback.array_get('args'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.dup()
			if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('WP_DEBUG'))) {
				rt.call_function('trigger_error', ['Transactional email triggered fatal error for callback ' + (rt.call_function('esc_html', [var_callback.array_get('filter')])).str(), rt.get_constant('E_USER_WARNING')])
				// unsupported statement: Stmt_Nop
			}
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	return false
}

fn (mut this Class_WC_Background_Emailer) close_http_connection()  {
	if rt.is_true(rt.call_function('session_id', []rt.PhpVal{})) {
		rt.call_function('session_write_close', []rt.PhpVal{})
	}
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	if rt.is_true(rt.call_function('is_callable', [rt.new_string('fastcgi_finish_request')])) {
		rt.call_function('fastcgi_finish_request', []rt.PhpVal{})
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
			rt.call_function('header', [rt.new_string('Connection: close')])
		}
		rt.call_function('ob_end_flush', []rt.PhpVal{})
		rt.call_function('flush', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Background_Emailer) dispatch_queue()  {
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this), 'data'))) {
		this.close_http_connection()
		rt.call_method(this.save(), 'dispatch', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Background_Emailer) get_post_args() rt.PhpVal {
	if rt.is_true(rt.call_function('property_exists', [rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this), rt.new_string('post_args')])) {
		return rt.get_property(rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this), 'post_args')
	}
	mut var_cookies := []rt.PhpVal{}
	{
		mut iter_1 := rt.get_superglobal('_COOKIE').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_name := item_1.key
			if rt.is_true(rt.identical(rt.new_string('PHPSESSID'), var_name)) {
				continue
			}
			var_cookies << create_wp_http_cookie(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'value', val: var_value }]))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'timeout', val: 0.01 }, rt.ArrayItem{ key: 'blocking', val: false }, rt.ArrayItem{ key: 'body', val: rt.get_property(rt.new_object('WC_Background_Emailer', ['WC_Background_Process'], &this), 'data') }, rt.ArrayItem{ key: 'cookies', val: var_cookies }, rt.ArrayItem{ key: 'sslverify', val: rt.call_function('apply_filters', [rt.new_string('https_local_ssl_verify'), rt.new_bool(false)]) }])
}

fn (mut this Class_WC_Background_Emailer) handle()  {
	this.lock_process()
	for {
		mut var_batch := this.get_batch()
		if !rt.is_true(rt.get_property(var_batch, 'data')) {
			break
		}
		{
			mut iter_1 := rt.get_property(var_batch, 'data').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				mut var_task := rt.new_bool(this.task(var_value.dup()))
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.get_property(var_batch, 'data').array_set(var_key, var_task.dup())
				} else {
					rt.get_property(var_batch, 'data').array_unset(var_key)
				}
				this.update(rt.get_property(var_batch, 'key'), rt.get_property(var_batch, 'data'))
				if rt.is_true(rt.new_bool(rt.is_true(this.time_exceeded()) || rt.is_true(this.memory_exceeded()))) {
					break
				}
			}
		}
		if !rt.is_true(rt.get_property(var_batch, 'data')) {
			this.delete(rt.get_property(var_batch, 'key'))
		}
		if !(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.time_exceeded())))) && rt.is_true(rt.new_bool(!(rt.is_true(this.memory_exceeded())))))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_queue_empty()))))))) {
			break
		}
	}
	this.unlock_process()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_queue_empty())))) {
		this.dispatch()
	} else {
		this.complete()
	}
}

struct Class_WC_Background_Process {
	rt.PhpObjectBase
}

struct Class_WC_Emails {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WP_Http_Cookie {
	rt.PhpObjectBase
}

fn create_wc_background_emailer() &Class_WC_Background_Emailer {
	mut obj := &Class_WC_Background_Emailer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_background_process() &Class_WC_Background_Process {
	mut obj := &Class_WC_Background_Process{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_emails() &Class_WC_Emails {
	mut obj := &Class_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_cookie() &Class_WP_Http_Cookie {
	mut obj := &Class_WP_Http_Cookie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Background_Emailer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'schedule_event' {
			this.schedule_event()
			return rt.new_null()
		}
		'task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.task(dispatch_arg_0))
		}
		'close_http_connection' {
			this.close_http_connection()
			return rt.new_null()
		}
		'dispatch_queue' {
			this.dispatch_queue()
			return rt.new_null()
		}
		'get_post_args' {
			return this.get_post_args()
		}
		'handle' {
			this.handle()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Background_Emailer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Background_Emailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Background_Process) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Background_Process) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Background_Process) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Http_Cookie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http_Cookie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http_Cookie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_background_emailer_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Background_Process'), rt.new_bool(false)]))))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/abstracts/class-wc-background-process.php', '2')
	}
}
