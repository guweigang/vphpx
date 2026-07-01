import rt

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	messages rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automatic_Upgrader_Skin) request_filesystem_credentials(error bool, context string, allow_relaxed_file_ownership bool) rt.PhpVal {
	if var_context.len > 0 && var_context != '0' {
		rt.get_property(rt.new_object('Automatic_Upgrader_Skin', ['WP_Upgrader_Skin'], &this),
			'options').array_set('context', context)
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_result := this.Class_WP_Upgrader_Skin.request_filesystem_credentials(rt.new_bool(error),
		rt.new_string(context), rt.new_bool(allow_relaxed_file_ownership))
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	return var_result.dup()
}

fn (mut this Class_Automatic_Upgrader_Skin) get_upgrade_messages() rt.PhpVal {
	return this.messages
}

fn (mut this Class_Automatic_Upgrader_Skin) feedback(var_feedback rt.PhpVal, var_args rt.PhpVal) {
	if rt.is_true(rt.call_function('is_wp_error', [var_feedback.dup()])) {
		mut var_string := rt.call_method(var_feedback, 'get_error_message', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(var_feedback.dup().is_array())) {
		return rt.new_null()
	} else {
		var_string = var_feedback
	}
	if !(!rt.is_true(rt.get_property(rt.get_property(rt.new_object('Automatic_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_get(var_string))) {
		var_string = rt.get_property(rt.get_property(rt.new_object('Automatic_Upgrader_Skin', [
			'WP_Upgrader_Skin',
		], &this), 'upgrader'), 'strings').array_get(var_string)
	}
	if rt.is_true(rt.call_function('str_contains', [var_string.dup(),
		rt.new_string('%')]))
	{
		if !(!rt.is_true(var_args)) {
			var_string = rt.call_function('vsprintf', [var_string.dup(),
				var_args.dup()])
		}
	}
	var_string = rt.new_string(rt.new_string(var_string.dup().to_string().trim_space()))
	var_string = rt.call_function('wp_kses', [var_string.dup(),
		rt.create_array([
			rt.ArrayItem{ key: 'a', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: true },
			]) },
			rt.ArrayItem{ key: 'br', val: true },
			rt.ArrayItem{ key: 'em', val: true },
			rt.ArrayItem{ key: 'strong', val: true },
		])])
	if !rt.is_true(var_string) {
		return rt.new_null()
	}
	this.messages.array_push(var_string.dup())
}

fn (mut this Class_Automatic_Upgrader_Skin) header() {
	rt.call_function('ob_start', []rt.PhpVal{})
}

fn (mut this Class_Automatic_Upgrader_Skin) footer() {
	mut var_output := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if !(!rt.is_true(var_output)) {
		this.feedback(var_output.dup(), rt.new_null())
	}
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_automatic_upgrader_skin() &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
		messages:      rt.new_array()
	}
	return obj
}

fn create_wp_upgrader_skin() &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'request_filesystem_credentials' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.request_filesystem_credentials(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_upgrade_messages' {
			return this.get_upgrade_messages()
		}
		'feedback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.feedback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'header' {
			this.header()
			return rt.new_null()
		}
		'footer' {
			this.footer()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'messages' { return this.messages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'messages' {
			this.messages = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_admin_includes_class_automatic_upgrader_skin_php() {
}
