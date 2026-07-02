import rt

struct Class_WP_Async_Request {
	rt.PhpObjectBase
pub mut:
	prefix     rt.PhpVal = rt.new_string('wp')
	action     rt.PhpVal = rt.new_string('async_request')
	identifier rt.PhpVal = rt.new_null()
	data       rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Async_Request) construct() {
	this.identifier = (this.prefix).str() + '_' + (this.action).str()
	rt.call_function('add_action', [rt.new_string('wp_ajax_' + (this.identifier).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Async_Request', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_handle' },
		])])
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_nopriv_' + (this.identifier).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Async_Request', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_handle' },
		]),
	])
}

fn (mut this Class_WP_Async_Request) data(var_data rt.PhpVal) rt.PhpVal {
	this.data = var_data.clone()
	return rt.new_object('WP_Async_Request', []string{}, this)
}

fn (mut this Class_WP_Async_Request) dispatch() rt.PhpVal {
	mut var_url := rt.call_function('add_query_arg', [this.get_query_args(),
		this.get_query_url()])
	mut var_args := this.get_post_args()
	return rt.call_function('wp_remote_post', [
		rt.call_function('esc_url_raw', [var_url.clone()]),
		var_args.clone(),
	])
}

fn (mut this Class_WP_Async_Request) get_query_args() rt.PhpVal {
	if rt.is_true(rt.call_function('property_exists', [
		rt.new_object('WP_Async_Request', []string{}, &this),
		rt.new_string('query_args'),
	]))
	{
		return rt.get_property(rt.new_object('WP_Async_Request', []string{}, &this), 'query_args')
	}
	return rt.create_array([rt.ArrayItem{ key: 'action', val: this.identifier },
		rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
			this.identifier,
		]) }])
}

fn (mut this Class_WP_Async_Request) get_query_url() rt.PhpVal {
	if rt.is_true(rt.call_function('property_exists', [
		rt.new_object('WP_Async_Request', []string{}, &this),
		rt.new_string('query_url'),
	]))
	{
		return rt.get_property(rt.new_object('WP_Async_Request', []string{}, &this), 'query_url')
	}
	return rt.call_function('admin_url', [rt.new_string('admin-ajax.php')])
}

fn (mut this Class_WP_Async_Request) get_post_args() rt.PhpVal {
	if rt.is_true(rt.call_function('property_exists', [
		rt.new_object('WP_Async_Request', []string{}, &this),
		rt.new_string('post_args'),
	]))
	{
		return rt.get_property(rt.new_object('WP_Async_Request', []string{}, &this), 'post_args')
	}
	return rt.create_array([rt.ArrayItem{ key: 'timeout', val: 0.01 },
		rt.ArrayItem{ key: 'blocking', val: false }, rt.ArrayItem{ key: 'body', val: this.data },
		rt.ArrayItem{ key: 'cookies', val: rt.get_superglobal('_COOKIE') },
		rt.ArrayItem{ key: 'sslverify', val: rt.call_function('apply_filters', [
			rt.new_string('https_local_ssl_verify'),
			rt.new_bool(false),
		]) }])
}

fn (mut this Class_WP_Async_Request) maybe_handle() {
	rt.call_function('session_write_close', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [this.identifier, rt.new_string('nonce')])
	this.handle()
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn (mut this Class_WP_Async_Request) handle() {
}

fn create_wp_async_request() &Class_WP_Async_Request {
	mut obj := &Class_WP_Async_Request{
		PhpObjectBase: rt.PhpObjectBase{}
		prefix:        rt.new_string('wp')
		action:        rt.new_string('async_request')
		identifier:    rt.new_null()
		data:          rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Async_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.data(dispatch_arg_0)
		}
		'dispatch' {
			return this.dispatch()
		}
		'get_query_args' {
			return this.get_query_args()
		}
		'get_query_url' {
			return this.get_query_url()
		}
		'get_post_args' {
			return this.get_post_args()
		}
		'maybe_handle' {
			this.maybe_handle()
			return rt.new_null()
		}
		'handle' {
			this.handle()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Async_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'prefix' { return this.prefix }
		'action' { return this.action }
		'identifier' { return this.identifier }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Async_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'prefix' {
			this.prefix = val
			return true
		}
		'action' {
			this.action = val
			return true
		}
		'identifier' {
			this.identifier = val
			return true
		}
		'data' {
			this.data = val
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
