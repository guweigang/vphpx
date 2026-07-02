import rt

struct Class_WP_Ajax_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	plugin_info rt.PhpVal = rt.new_array()
	theme_info  rt.PhpVal = rt.new_bool(false)
	errors      rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) construct(var_args rt.PhpVal) {
	this.Class_Automatic_Upgrader_Skin.construct(var_args.clone())
	this.errors = create_wp_error()
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) get_errors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) get_error_messages() rt.PhpVal {
	mut var_messages := []rt.PhpVal{}
	mut iter_1 := rt.call_method(this.errors, 'get_error_codes', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_error_code := item_1.val
		mut var_error_data := rt.call_method(this.errors, 'get_error_data', [
			var_error_code.clone()])
		if rt.is_true(var_error_data) && var_error_data.clone().is_string() {
			var_messages <<
				(rt.call_method(this.errors, 'get_error_message', [var_error_code.clone()])).str() +
				' ' +(rt.call_function('esc_html', [rt.call_function('strip_tags', [var_error_data.clone()])])).str()
		} else {
			var_messages << rt.call_method(this.errors, 'get_error_message', [
				var_error_code.clone()])
		}
	}
	return rt.call_function('implode',
		[rt.new_string(', '), rt.create_array_from_list(var_messages)])
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) error(var_errors rt.PhpVal, var_args rt.PhpVal) {
	if rt.is_true(rt.new_bool(var_errors.clone().is_string())) {
		mut var_string := var_errors
		if !(!rt.is_true(rt.get_property(rt.get_property(rt.new_object('WP_Ajax_Upgrader_Skin', [
			'Automatic_Upgrader_Skin',
		], &this), 'upgrader'), 'strings').array_get(var_string))) {
			var_string = rt.get_property(rt.get_property(rt.new_object('WP_Ajax_Upgrader_Skin', [
				'Automatic_Upgrader_Skin',
			], &this), 'upgrader'), 'strings').array_get(var_string)
		}
		if rt.is_true(rt.call_function('str_contains', [var_string.clone(),
			rt.new_string('%')]))
		{
			if !(!rt.is_true(var_args)) {
				var_string = rt.call_function('vsprintf', [var_string.clone(),
					var_args.clone()])
			}
		}
		mut var_errors_count := rt.new_int(rt.call_method(this.errors, 'get_error_codes',
			[]rt.PhpVal{}).array_count())
		rt.call_method(this.errors, 'add', [
			rt.new_string('unknown_upgrade_error_' + (rt.add(var_errors_count, rt.new_int(1))).str()),
			var_string.clone(),
		])
	} else if rt.is_true(rt.call_function('is_wp_error', [var_errors.clone()])) {
		mut iter_2 := rt.call_method(var_errors, 'get_error_codes', []rt.PhpVal{}).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_error_code := item_2.val
			rt.call_method(this.errors, 'add', [var_error_code.clone(),
				rt.call_method(var_errors, 'get_error_message', [
					var_error_code.clone()]),
				rt.call_method(var_errors, 'get_error_data', [
					var_error_code.clone()])])
		}
	}
	this.Class_Automatic_Upgrader_Skin.error(var_errors.clone(), var_args.clone())
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) feedback(var_feedback rt.PhpVal, var_args rt.PhpVal) {
	if rt.is_true(rt.call_function('is_wp_error', [var_feedback.clone()])) {
		mut iter_3 := rt.call_method(var_feedback, 'get_error_codes', []rt.PhpVal{}).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_error_code := item_3.val
			rt.call_method(this.errors, 'add', [var_error_code.clone(),
				rt.call_method(var_feedback, 'get_error_message', [
					var_error_code.clone()]),
				rt.call_method(var_feedback, 'get_error_data', [
					var_error_code.clone()])])
		}
	}
	this.Class_Automatic_Upgrader_Skin.feedback(var_feedback.clone(), var_args.clone())
}

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_ajax_upgrader_skin(arg_0 rt.PhpVal) &Class_WP_Ajax_Upgrader_Skin {
	mut obj := &Class_WP_Ajax_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
		plugin_info:   rt.new_array()
		theme_info:    rt.new_bool(false)
		errors:        rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automatic_upgrader_skin(_args ...rt.PhpVal) &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_errors' {
			return this.get_errors()
		}
		'get_error_messages' {
			return this.get_error_messages()
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'feedback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.feedback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Ajax_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugin_info' { return this.plugin_info }
		'theme_info' { return this.theme_info }
		'errors' { return this.errors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugin_info' {
			this.plugin_info = val
			return true
		}
		'theme_info' {
			this.theme_info = val
			return true
		}
		'errors' {
			this.errors = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
