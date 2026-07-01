import rt

pub fn Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue.as_hook() string {
	return 'woocommerce_send_queued_transactional_email'
}

pub fn Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue.as_group() string {
	return 'woocommerce-emails'
}

struct Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue {
	rt.PhpObjectBase
pub mut:
	queue               rt.PhpVal = rt.new_array()
	shutdown_registered bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue) init() {
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Internal_Email_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue.as_hook(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_DeferredEmailQueue',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'send_queued_transactional_email' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue) push(filter string, mut var_args Class_Automattic_WooCommerce_Internal_Email_array) {
	this.queue.array_push(rt.create_array([rt.ArrayItem{ key: 'filter', val: filter },
		rt.ArrayItem{ key: 'args', val: var_args }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(this.shutdown_registered)))) {
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Email_DeferredEmailQueue',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'dispatch' },
			]),
			rt.new_int(100)])
		this.shutdown_registered = true
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue) dispatch() {
	if !rt.is_true(this.queue) {
		return rt.new_null()
	}
	{
		mut iter_1 := this.queue.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue',
				[]rt.PhpVal{}), 'add', [
				Class_Automattic_WooCommerce_Internal_Email_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue.as_hook(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_item.array_get('filter') },
					rt.ArrayItem{ key: none, val: var_item.array_get('args') },
				]),
				Class_Automattic_WooCommerce_Internal_Email_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue.as_group(),
			])
		}
	}
	this.queue = rt.new_array()
	this.shutdown_registered = false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue) send_queued_transactional_email(var_filter rt.PhpVal, var_args rt.PhpVal) {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_filter.dup().is_string())))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array())))))))
	{
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Email_WC_Emails{}
		return temp.send_queued_transactional_email(arg_0, arg_1)
	}(var_filter.dup(), var_args.dup())
}

struct Class_Automattic_WooCommerce_Internal_Email_WC_Emails {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_email_deferredemailqueue() &Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue{
		PhpObjectBase:       rt.PhpObjectBase{}
		queue:               rt.new_array()
		shutdown_registered: false
	}
	return obj
}

fn create_automattic_woocommerce_internal_email_wc_emails() &Class_Automattic_WooCommerce_Internal_Email_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'push' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Email_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.push(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'dispatch' {
			this.dispatch()
			return rt.new_null()
		}
		'send_queued_transactional_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.send_queued_transactional_email(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queue' { return this.queue }
		'shutdown_registered' { return rt.new_bool(this.shutdown_registered) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_DeferredEmailQueue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queue' {
			this.queue = val
			return true
		}
		'shutdown_registered' {
			this.shutdown_registered = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_email_deferredemailqueue_php() {
	// unsupported statement: Stmt_Declare
}
