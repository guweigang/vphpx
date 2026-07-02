import rt

struct Class_WP_HTTP_Proxy {
	rt.PhpObjectBase
}

fn (mut this Class_WP_HTTP_Proxy) is_enabled() bool {
	return rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_HOST')])) && rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_PORT')]))
}

fn (mut this Class_WP_HTTP_Proxy) use_authentication() bool {
	return rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_USERNAME')])) && rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_PASSWORD')]))
}

fn (mut this Class_WP_HTTP_Proxy) host() string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_HOST')])) {
		return (rt.get_constant('WP_PROXY_HOST')).str()
	}
	return ''
}

fn (mut this Class_WP_HTTP_Proxy) port() string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_PORT')])) {
		return (rt.get_constant('WP_PROXY_PORT')).str()
	}
	return ''
}

fn (mut this Class_WP_HTTP_Proxy) username() string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_USERNAME')])) {
		return (rt.get_constant('WP_PROXY_USERNAME')).str()
	}
	return ''
}

fn (mut this Class_WP_HTTP_Proxy) password() string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_PASSWORD')])) {
		return (rt.get_constant('WP_PROXY_PASSWORD')).str()
	}
	return ''
}

fn (mut this Class_WP_HTTP_Proxy) authentication() string {
	return this.username() + ':' + this.password()
}

fn (mut this Class_WP_HTTP_Proxy) authentication_header() string {
	return 'Proxy-Authorization: Basic ' + (rt.call_function('base64_encode', [rt.new_string(this.authentication())])).str()
}

fn (mut this Class_WP_HTTP_Proxy) send_through_proxy(var_uri rt.PhpVal) bool {
	mut var_check := rt.call_function('parse_url', [var_uri.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_check)) {
		return true
	}
	mut var_home := rt.call_function('parse_url', [rt.call_function('get_option', [rt.new_string('siteurl')])])
	mut var_result := rt.call_function('apply_filters', [rt.new_string('pre_http_send_through_proxy'), rt.new_null(), var_uri.clone(), var_check.clone(), var_home.clone()])
	if !(var_result.clone().is_null()) {
		return (var_result).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('localhost'), var_check.array_get(rt.new_string('host')))) || (var_home.array_isset(rt.new_string('host')) && rt.is_true(rt.identical(var_home.array_get(rt.new_string('host')), var_check.array_get(rt.new_string('host'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_PROXY_BYPASS_HOSTS')]))))) {
		return true
	}
	mut var_bypass_hosts := rt.new_null()
	mut var_wildcard_regex := rt.new_array()
	if rt.is_true(rt.identical(rt.new_null(), var_bypass_hosts)) {
		var_bypass_hosts = rt.call_function('preg_split', [rt.new_string('|,\\s*|'), rt.get_constant('WP_PROXY_BYPASS_HOSTS')])
		if rt.is_true(rt.call_function('str_contains', [rt.get_constant('WP_PROXY_BYPASS_HOSTS'), rt.new_string('*')])) {
			var_wildcard_regex = rt.new_array()
			mut iter_1 := var_bypass_hosts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_host := item_1.val
				var_wildcard_regex.array_push(rt.call_function('str_replace', [rt.new_string('\\*'), rt.new_string('.+'), rt.call_function('preg_quote', [var_host.clone(), rt.new_string('/')])]))
			}
		var_wildcard_regex = rt.new_string('/^(' + (rt.call_function('implode', [rt.new_string('|'), var_wildcard_regex.clone()])).str() + ')$/i')
		}
	}
	if !(!rt.is_true(var_wildcard_regex)) {
		return !(rt.is_true(rt.call_function('preg_match', [var_wildcard_regex.clone(), var_check.array_get(rt.new_string('host'))])))
	} else {
		return !(rt.is_true(rt.call_function('in_array', [var_check.array_get(rt.new_string('host')), var_bypass_hosts.clone(), rt.new_bool(true)])))
	}
	return false
}

fn create_wp_http_proxy(_args ...rt.PhpVal) &Class_WP_HTTP_Proxy {
	mut obj := &Class_WP_HTTP_Proxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTTP_Proxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_enabled' {
			return rt.new_bool(this.is_enabled())
		}
		'use_authentication' {
			return rt.new_bool(this.use_authentication())
		}
		'host' {
			return rt.new_string(this.host())
		}
		'port' {
			return rt.new_string(this.port())
		}
		'username' {
			return rt.new_string(this.username())
		}
		'password' {
			return rt.new_string(this.password())
		}
		'authentication' {
			return rt.new_string(this.authentication())
		}
		'authentication_header' {
			return rt.new_string(this.authentication_header())
		}
		'send_through_proxy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.send_through_proxy(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_HTTP_Proxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Proxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
