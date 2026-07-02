import rt

struct Class_WpOrg_Requests_Autoload {
	rt.PhpObjectBase
}

fn init_static_wporg_requests_autoload() {
	rt.init_static_prop('WpOrg_Requests_Autoload', 'deprecated_classes', rt.create_array([
		rt.ArrayItem{ key: 'requests_auth', val: '\\WpOrg\\Requests\\Auth' },
		rt.ArrayItem{ key: 'requests_hooker', val: '\\WpOrg\\Requests\\HookManager' },
		rt.ArrayItem{ key: 'requests_proxy', val: '\\WpOrg\\Requests\\Proxy' },
		rt.ArrayItem{ key: 'requests_transport', val: '\\WpOrg\\Requests\\Transport' },
		rt.ArrayItem{ key: 'requests_cookie', val: '\\WpOrg\\Requests\\Cookie' },
		rt.ArrayItem{ key: 'requests_exception', val: '\\WpOrg\\Requests\\Exception' },
		rt.ArrayItem{ key: 'requests_hooks', val: '\\WpOrg\\Requests\\Hooks' },
		rt.ArrayItem{ key: 'requests_idnaencoder', val: '\\WpOrg\\Requests\\IdnaEncoder' },
		rt.ArrayItem{ key: 'requests_ipv6', val: '\\WpOrg\\Requests\\Ipv6' },
		rt.ArrayItem{ key: 'requests_iri', val: '\\WpOrg\\Requests\\Iri' },
		rt.ArrayItem{ key: 'requests_response', val: '\\WpOrg\\Requests\\Response' },
		rt.ArrayItem{ key: 'requests_session', val: '\\WpOrg\\Requests\\Session' },
		rt.ArrayItem{ key: 'requests_ssl', val: '\\WpOrg\\Requests\\Ssl' },
		rt.ArrayItem{ key: 'requests_auth_basic', val: '\\WpOrg\\Requests\\Auth\\Basic' },
		rt.ArrayItem{ key: 'requests_cookie_jar', val: '\\WpOrg\\Requests\\Cookie\\Jar' },
		rt.ArrayItem{ key: 'requests_proxy_http', val: '\\WpOrg\\Requests\\Proxy\\Http' },
		rt.ArrayItem{ key: 'requests_response_headers', val: '\\WpOrg\\Requests\\Response\\Headers' },
		rt.ArrayItem{ key: 'requests_transport_curl', val: '\\WpOrg\\Requests\\Transport\\Curl' },
		rt.ArrayItem{
			key: 'requests_transport_fsockopen'
			val: '\\WpOrg\\Requests\\Transport\\Fsockopen'
		},
		rt.ArrayItem{
			key: 'requests_utility_caseinsensitivedictionary'
			val: '\\WpOrg\\Requests\\Utility\\CaseInsensitiveDictionary'
		},
		rt.ArrayItem{
			key: 'requests_utility_filterediterator'
			val: '\\WpOrg\\Requests\\Utility\\FilteredIterator'
		},
		rt.ArrayItem{ key: 'requests_exception_http', val: '\\WpOrg\\Requests\\Exception\\Http' },
		rt.ArrayItem{
			key: 'requests_exception_transport'
			val: '\\WpOrg\\Requests\\Exception\\Transport'
		},
		rt.ArrayItem{
			key: 'requests_exception_transport_curl'
			val: '\\WpOrg\\Requests\\Exception\\Transport\\Curl'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_304'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status304'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_305'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status305'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_306'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status306'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_400'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status400'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_401'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status401'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_402'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status402'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_403'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status403'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_404'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status404'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_405'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status405'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_406'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status406'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_407'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status407'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_408'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status408'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_409'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status409'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_410'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status410'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_411'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status411'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_412'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status412'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_413'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status413'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_414'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status414'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_415'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status415'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_416'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status416'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_417'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status417'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_418'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status418'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_428'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status428'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_429'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status429'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_431'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status431'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_500'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status500'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_501'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status501'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_502'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status502'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_503'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status503'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_504'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status504'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_505'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status505'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_511'
			val: '\\WpOrg\\Requests\\Exception\\Http\\Status511'
		},
		rt.ArrayItem{
			key: 'requests_exception_http_unknown'
			val: '\\WpOrg\\Requests\\Exception\\Http\\StatusUnknown'
		},
	]))
}

fn Class_WpOrg_Requests_Autoload.register() {
	if rt.is_true(rt.identical(rt.call_function('defined', [
		rt.new_string('REQUESTS_AUTOLOAD_REGISTERED'),
	]), rt.new_bool(false)))
	{
		rt.call_function('spl_autoload_register', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: Class_WpOrg_Requests_WpOrg_Requests_Autoload.class() },
				rt.ArrayItem{ key: none, val: 'load' },
			]),
			rt.new_bool(true),
		])
		rt.call_function('define', [rt.new_string('REQUESTS_AUTOLOAD_REGISTERED'),
			rt.new_bool(true)])
	}
}

fn Class_WpOrg_Requests_Autoload.load(var_class_name rt.PhpVal) bool {
	mut var_psr_4_prefix_pos := rt.call_function('strpos', [var_class_name.clone(),
		rt.new_string('WpOrg\\Requests\\')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_class_name.clone(), rt.new_string('Requests')]), rt.new_int(0)))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_psr_4_prefix_pos, rt.new_int(0))))) {
		return false
	}
	mut var_class_lower := rt.new_string(var_class_name.clone().to_string().to_lower())
	if rt.is_true(rt.identical(var_class_lower, rt.new_string('requests'))) {
		mut var_file := rt.new_string((rt.call_function('dirname', [rt.new_string(@DIR)])).str() +
			'/library/Requests.php')
	} else if rt.is_true(rt.identical(var_psr_4_prefix_pos, rt.new_int(0))) {
		var_file = rt.new_string(@DIR + '/' +
			(rt.call_function('strtr', [rt.call_function('substr', [var_class_name.clone(), rt.new_int(15)]), rt.new_string('\\'), rt.new_string('/')])).str() +
			'.php')
	}
	if !var_file.is_null() && rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
		rt.include_file(var_file.to_string(), '1')
		return true
	}
	if rt.get_static_prop('WpOrg_Requests_Autoload', 'deprecated_classes').array_isset(var_class_lower) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS')])))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('REQUESTS_SILENCE_PSR0_DEPRECATIONS'), rt.new_bool(true))))) {
			rt.call_function('trigger_error', [
				rt.new_string(
					'The PSR-0 `Requests_...` class names in the Requests library are deprecated.' +
					' Switch to the PSR-4 `WpOrg\\Requests\\...` class names at your earliest convenience.'),
				rt.get_constant('E_USER_DEPRECATED'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
				rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS'),
			])))))
			{
				rt.call_function('define', [
					rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS'),
					rt.new_bool(true),
				])
			}
		}
		return (rt.call_function('class_alias', [rt.get_static_prop('WpOrg_Requests_Autoload',
			'deprecated_classes').array_get(var_class_lower),
			var_class_name.clone(), rt.new_bool(true)])).to_bool()
	}
	return false
}

fn create_wporg_requests_autoload(_args ...rt.PhpVal) &Class_WpOrg_Requests_Autoload {
	mut obj := &Class_WpOrg_Requests_Autoload{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Autoload) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			Class_WpOrg_Requests_Autoload.register()
			return rt.new_null()
		}
		'load' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Autoload.load(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Autoload) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Autoload) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.identical(rt.call_function('class_exists', [
		rt.new_string('WpOrg\\Requests\\Autoload'),
	]), rt.new_bool(false)))
	{
	}
}
