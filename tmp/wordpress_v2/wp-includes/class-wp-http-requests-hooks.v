import rt

struct Class_WP_HTTP_Requests_Hooks {
	rt.PhpObjectBase
pub mut:
	url     rt.PhpVal = rt.new_null()
	request rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_HTTP_Requests_Hooks) construct(var_url rt.PhpVal, var_request rt.PhpVal) {
	this.url = var_url.clone()
	this.request = var_request.clone()
}

fn (mut this Class_WP_HTTP_Requests_Hooks) dispatch(var_hook rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	mut var_result := this.Class_WpOrg_Requests_Hooks.dispatch(var_hook.clone(),
		var_parameters.clone())
	mut switch_val_1 := var_hook
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('curl.before_send'))) {
		rt.call_function('do_action_ref_array', [rt.new_string('http_api_curl'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_parameters.array_get(rt.new_int(0)) },
				rt.ArrayItem{ key: none, val: this.request },
				rt.ArrayItem{ key: none, val: this.url },
			])])
	}
	rt.call_function('do_action_ref_array', [
		rt.new_string('requests-${var_hook.to_string()}'),
		var_parameters.clone(),
		this.request,
		this.url,
	])
	return var_result.clone()
}

struct Class_WpOrg_Requests_Hooks {
	rt.PhpObjectBase
}

fn create_wp_http_requests_hooks(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_HTTP_Requests_Hooks {
	mut obj := &Class_WP_HTTP_Requests_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
		url:           rt.new_null()
		request:       rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wporg_requests_hooks(_args ...rt.PhpVal) &Class_WpOrg_Requests_Hooks {
	mut obj := &Class_WpOrg_Requests_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTTP_Requests_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'dispatch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.dispatch(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTTP_Requests_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'url' { return this.url }
		'request' { return this.request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTTP_Requests_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'url' {
			this.url = val
			return true
		}
		'request' {
			this.request = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WpOrg_Requests_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
