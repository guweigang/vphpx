import rt

struct Class_WP_SimplePie_File {
	rt.PhpObjectBase
pub mut:
	timeout rt.PhpVal = rt.new_int(10)
}

fn (mut this Class_WP_SimplePie_File) construct(var_url rt.PhpVal, timeout i64, redirects i64, var_headers rt.PhpVal, var_useragent rt.PhpVal, force_fsockopen bool) {
	this.dispatch_set_prop('url', var_url.clone())
	this.timeout = rt.new_int(timeout)
	this.dispatch_set_prop('redirects', rt.new_int(redirects))
	this.dispatch_set_prop('headers', var_headers.clone())
	this.dispatch_set_prop('useragent', var_useragent.clone())
	this.dispatch_set_prop('method', Class_SimplePie_SimplePie.file_source_remote())
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^http(s)?:\\/\\//i'),
		var_url.clone()]))
	{
		mut var_args := {
			'timeout':     this.timeout
			'redirection': rt.get_property(rt.new_object('WP_SimplePie_File', [
				'SimplePie_File',
			], &this), 'redirects')
		}
		if !(!rt.is_true(rt.get_property(rt.new_object('WP_SimplePie_File', [
			'SimplePie_File',
		], &this), 'headers'))) {
			var_args['headers'] = rt.get_property(rt.new_object('WP_SimplePie_File', [
				'SimplePie_File',
			], &this), 'headers')
		}
		mut iife_temp_0 := Class_SimplePie_Misc{}
		mut iife_result_0 := iife_temp_0.get_default_useragent()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0, rt.get_property(rt.new_object('WP_SimplePie_File', [
			'SimplePie_File',
		], &this), 'useragent')))))
		{
			var_args['user-agent'] = rt.get_property(rt.new_object('WP_SimplePie_File', [
				'SimplePie_File',
			], &this), 'useragent')
		}
		mut var_res := rt.call_function('wp_safe_remote_request', [
			var_url.clone(), rt.create_array_from_native_map(var_args)])
		if rt.is_true(rt.call_function('is_wp_error', [var_res.clone()])) {
			this.dispatch_set_prop('error', 'WP HTTP Error: ' +
				(rt.call_method(var_res, 'get_error_message', []rt.PhpVal{})).str())
			this.dispatch_set_prop('success', rt.new_bool(false))
		} else {
			this.dispatch_set_prop('headers', rt.call_function('wp_remote_retrieve_headers', [
				var_res.clone(),
			]))
			if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.new_object('WP_SimplePie_File', [
				'SimplePie_File',
			], &this), 'headers'), 'WpOrg_Requests_Utility_CaseInsensitiveDictionary')))
			{
				this.dispatch_set_prop('headers', rt.call_method(rt.get_property(rt.new_object('WP_SimplePie_File', [
					'SimplePie_File',
				], &this), 'headers'), 'getAll', []rt.PhpVal{}))
			}
			mut iter_1 := rt.get_property(rt.new_object('WP_SimplePie_File', [
				'SimplePie_File',
			], &this), 'headers').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_name := item_1.key
				if !(var_value.clone().is_array()) {
					continue
				}
				if rt.is_true(rt.identical(rt.new_string('content-type'), var_name)) {
					rt.get_property(rt.new_object('WP_SimplePie_File', [
						'SimplePie_File',
					], &this), 'headers').array_set(var_name, rt.call_function('array_pop', [
						var_value.clone(),
					]))
				} else {
					rt.get_property(rt.new_object('WP_SimplePie_File', [
						'SimplePie_File',
					], &this), 'headers').array_set(var_name, rt.call_function('implode', [
						rt.new_string(', '),
						var_value.clone(),
					]))
				}
			}
			this.dispatch_set_prop('body', rt.call_function('wp_remote_retrieve_body', [
				var_res.clone(),
			]))
			this.dispatch_set_prop('status_code', rt.call_function('wp_remote_retrieve_response_code', [
				var_res.clone(),
			]))
		}
	} else {
		this.dispatch_set_prop('error', rt.new_string(''))
		this.dispatch_set_prop('success', rt.new_bool(false))
	}
}

struct Class_SimplePie_File {
	rt.PhpObjectBase
}

struct Class_SimplePie_Misc {
	rt.PhpObjectBase
}

fn create_wp_simplepie_file(timeout i64, redirects i64, arg_2 rt.PhpVal, arg_3 rt.PhpVal, force_fsockopen bool, arg_5 rt.PhpVal) &Class_WP_SimplePie_File {
	mut obj := &Class_WP_SimplePie_File{
		PhpObjectBase: rt.PhpObjectBase{}
		timeout:       rt.new_int(10)
	}
	obj.construct(timeout, redirects, arg_2, arg_3, force_fsockopen, arg_5)
	return obj
}

fn create_simplepie_file(_args ...rt.PhpVal) &Class_SimplePie_File {
	mut obj := &Class_SimplePie_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_misc(_args ...rt.PhpVal) &Class_SimplePie_Misc {
	mut obj := &Class_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_SimplePie_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_SimplePie_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'timeout' { return this.timeout }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_SimplePie_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'timeout' {
			this.timeout = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_SimplePie_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
