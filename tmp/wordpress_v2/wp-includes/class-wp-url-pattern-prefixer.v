import rt

struct Class_WP_URL_Pattern_Prefixer {
	rt.PhpObjectBase
pub mut:
	contexts rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_URL_Pattern_Prefixer) construct(mut var_contexts Class_array) {
	if var_contexts.array_count() > 0 {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_str := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_str := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		this.contexts = rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_contexts])
	} else {
		this.contexts = Class_WP_URL_Pattern_Prefixer.get_default_contexts()
	}
}

fn (mut this Class_WP_URL_Pattern_Prefixer) prefix_path_pattern(path_pattern string, context string) string {
	mut path_pattern_mutated := path_pattern
	if !(this.contexts.array_isset(rt.new_string(context))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Invalid URL pattern context %s.'),
					]),
					rt.new_string(context),
				]),
			]),
			rt.new_string('6.8.0')])
		return path_pattern_mutated
	}
	mut var_context_path := this.contexts.array_get(rt.new_string(context))
	mut var_escaped_context_path := var_context_path.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strcspn', [
		var_context_path.clone(),
		rt.new_string(':?#'),
	]), rt.new_int(var_context_path.clone().to_string().len)))))
	{
		var_escaped_context_path = rt.new_string('{' +
			(rt.call_function('substr', [var_context_path.clone(), rt.new_int(0), rt.new_int(-1)])).str() +
			'}/')
	}
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(path_pattern_mutated).clone(),
		var_context_path.clone()]))
	{
		path_pattern_mutated = (rt.call_function('substr', [rt.new_string(path_pattern_mutated).clone(),
			rt.new_int(var_context_path.clone().to_string().len)])).str()
	}
	return var_escaped_context_path.str() + path_pattern_mutated.trim_left(' \t\n\r')
}

fn Class_WP_URL_Pattern_Prefixer.get_default_contexts() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'home', val: Class_WP_URL_Pattern_Prefixer.escape_pattern_string((rt.call_function('trailingslashit', [
			rt.new_string((rt.call_function('wp_parse_url', [
				rt.call_function('home_url', [rt.new_string('/')]),
				rt.get_constant('PHP_URL_PATH'),
			])).str()),
		])).str()) },
		rt.ArrayItem{ key: 'site', val: Class_WP_URL_Pattern_Prefixer.escape_pattern_string((rt.call_function('trailingslashit', [
			rt.new_string((rt.call_function('wp_parse_url', [
				rt.call_function('site_url', [rt.new_string('/')]),
				rt.get_constant('PHP_URL_PATH'),
			])).str()),
		])).str()) },
		rt.ArrayItem{ key: 'uploads', val: Class_WP_URL_Pattern_Prefixer.escape_pattern_string((rt.call_function('trailingslashit', [
			rt.new_string((rt.call_function('wp_parse_url', [
				rt.call_function('wp_upload_dir', [rt.new_null(),
					rt.new_bool(false)]).array_get(rt.new_string('baseurl')),
				rt.get_constant('PHP_URL_PATH'),
			])).str()),
		])).str()) },
		rt.ArrayItem{ key: 'content', val: Class_WP_URL_Pattern_Prefixer.escape_pattern_string((rt.call_function('trailingslashit', [
			rt.new_string((rt.call_function('wp_parse_url', [
				rt.call_function('content_url', []rt.PhpVal{}),
				rt.get_constant('PHP_URL_PATH'),
			])).str()),
		])).str()) },
		rt.ArrayItem{ key: 'plugins', val: Class_WP_URL_Pattern_Prefixer.escape_pattern_string((rt.call_function('trailingslashit', [
			rt.new_string((rt.call_function('wp_parse_url', [
				rt.call_function('plugins_url', []rt.PhpVal{}),
				rt.get_constant('PHP_URL_PATH'),
			])).str()),
		])).str()) },
		rt.ArrayItem{ key: 'template', val: Class_WP_URL_Pattern_Prefixer.escape_pattern_string((rt.call_function('trailingslashit', [
			rt.new_string((rt.call_function('wp_parse_url', [
				rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{}),
				rt.get_constant('PHP_URL_PATH'),
			])).str()),
		])).str()) },
		rt.ArrayItem{ key: 'stylesheet', val: Class_WP_URL_Pattern_Prefixer.escape_pattern_string((rt.call_function('trailingslashit', [
			rt.new_string((rt.call_function('wp_parse_url', [
				rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
				rt.get_constant('PHP_URL_PATH'),
			])).str()),
		])).str()) },
	])
}

fn Class_WP_URL_Pattern_Prefixer.escape_pattern_string(str string) string {
	return (rt.call_function('addcslashes', [rt.new_string(str),
		rt.new_string('+*?:{}()\\')])).str()
}

fn create_wp_url_pattern_prefixer(arg_0 rt.PhpVal) &Class_WP_URL_Pattern_Prefixer {
	mut obj := &Class_WP_URL_Pattern_Prefixer{
		PhpObjectBase: rt.PhpObjectBase{}
		contexts:      rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_URL_Pattern_Prefixer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'prefix_path_pattern' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.prefix_path_pattern(dispatch_arg_0, dispatch_arg_1))
		}
		'get_default_contexts' {
			return Class_WP_URL_Pattern_Prefixer.get_default_contexts()
		}
		'escape_pattern_string' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WP_URL_Pattern_Prefixer.escape_pattern_string(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_URL_Pattern_Prefixer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'contexts' { return this.contexts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_URL_Pattern_Prefixer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'contexts' {
			this.contexts = val
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
}
