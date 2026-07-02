import rt

struct Class_WP_SimplePie_Sanitize_KSES {
	rt.PhpObjectBase
}

fn (mut this Class_WP_SimplePie_Sanitize_KSES) sanitize(var_data rt.PhpVal, var_type rt.PhpVal, base string) rt.PhpVal {
	mut var_data_mutated := var_data
	var_data_mutated = rt.new_string(var_data_mutated.clone().to_string().trim_space())
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie.construct_maybe_html())) {
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string(
				'/(&(#(x[0-9a-fA-F]+|[0-9]+)|[a-zA-Z0-9]+)|<\\/[A-Za-z][^\\x09\\x0A\\x0B\\x0C\\x0D\\x20\\x2F\\x3E]*' +
				(rt.get_constant('SIMPLEPIE_PCRE_HTML_ATTRIBUTE')).str() + '>)/'),
			var_data_mutated.clone(),
		]))
		{
			rt.new_null()
		} else {
			rt.new_null()
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie.construct_base64())) {
		var_data_mutated = rt.call_function('base64_decode', [
			var_data_mutated.clone()])
	}
	if rt.is_true(rt.bitwise_and(var_type, rt.bitwise_or(Class_SimplePie_SimplePie.construct_html(),
		Class_SimplePie_SimplePie.construct_xhtml())))
	{
		var_data_mutated = rt.call_function('wp_kses_post', [
			var_data_mutated.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('UTF-8'), rt.get_property(rt.new_object('WP_SimplePie_Sanitize_KSES', [
			'SimplePie_Sanitize',
		], &this), 'output_encoding')))))
		{
			var_data_mutated = rt.call_method(rt.get_property(rt.new_object('WP_SimplePie_Sanitize_KSES', [
				'SimplePie_Sanitize',
			], &this), 'registry'), 'call', [rt.new_string('Misc'),
				rt.new_string('change_encoding'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_data_mutated },
					rt.ArrayItem{ key: none, val: 'UTF-8' },
					rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('WP_SimplePie_Sanitize_KSES', [
						'SimplePie_Sanitize',
					], &this), 'output_encoding') },
				])])
		}
		return var_data_mutated.clone()
	} else {
		return this.Class_SimplePie_Sanitize.sanitize(var_data_mutated.clone(), var_type.clone(),
			rt.new_string(base))
	}
	return rt.new_null()
}

struct Class_SimplePie_Sanitize {
	rt.PhpObjectBase
}

fn create_wp_simplepie_sanitize_kses(_args ...rt.PhpVal) &Class_WP_SimplePie_Sanitize_KSES {
	mut obj := &Class_WP_SimplePie_Sanitize_KSES{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_sanitize(_args ...rt.PhpVal) &Class_SimplePie_Sanitize {
	mut obj := &Class_SimplePie_Sanitize{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_SimplePie_Sanitize_KSES) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sanitize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.sanitize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_SimplePie_Sanitize_KSES) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_SimplePie_Sanitize_KSES) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_Sanitize) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Sanitize) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Sanitize) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
}
