import rt

struct Class_WpOrg_Requests_Autoload {
	rt.PhpObjectBase
pub mut:
			deprecated_classes rt.PhpVal = rt.new_array()
}

fn Class_WpOrg_Requests_Autoload.register()  {
	if rt.is_true(rt.identical(rt.call_function('defined', [rt.new_string('REQUESTS_AUTOLOAD_REGISTERED')]), rt.new_bool(false))) {
		rt.call_function('spl_autoload_register', [rt.create_array([rt.ArrayItem{ key: none, val: Class_WpOrg_Requests_WpOrg_Requests_Autoload.class() }, rt.ArrayItem{ key: none, val: 'load' }]), rt.new_bool(true)])
		rt.call_function('define', [rt.new_string('REQUESTS_AUTOLOAD_REGISTERED'), rt.new_bool(true)])
	}
}

fn Class_WpOrg_Requests_Autoload.load(var_class_name rt.PhpVal) bool {
	mut var_psr_4_prefix_pos := rt.call_function('strpos', [var_class_name.dup(), rt.new_string('WpOrg\\Requests\\')])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	mut var_class_lower := rt.new_string(rt.new_string(var_class_name.dup().to_string().to_lower()))
	if rt.is_true(rt.identical(var_class_lower, rt.new_string('requests'))) {
		mut var_file := rt.new_string((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/library/Requests.php')
	} else if rt.is_true(rt.identical(var_psr_4_prefix_pos, rt.new_int(0))) {
		var_file = rt.new_string(@DIR + '/' + (rt.call_function('strtr', [rt.call_function('substr', [var_class_name.dup(), rt.new_int(15)]), rt.new_string('\\'), rt.new_string('/')])).str() + '.php')
	}
	if rt.is_true(rt.new_bool(!(var_file).is_null() && rt.is_true(rt.call_function('file_exists', [var_file.dup()])))) {
		rt.include_file((var_file).to_string(), '1')
		return true
	}
	if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_class_lower) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS')]))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			rt.call_function('trigger_error', ['The PSR-0 `Requests_...` class names in the Requests library are deprecated.' + ' Switch to the PSR-4 `WpOrg\\Requests\\...` class names at your earliest convenience.', rt.get_constant('E_USER_DEPRECATED')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS')]))))) {
				rt.call_function('define', [rt.new_string('REQUESTS_SILENCE_PSR0_DEPRECATIONS'), rt.new_bool(true)])
			}
		}
		return (rt.call_function('class_alias', [// unsupported expression: Expr_StaticPropertyFetch.array_get(var_class_lower), var_class_name.dup(), rt.new_bool(true)])).to_bool()
	}
	return false
}

fn create_wporg_requests_autoload() &Class_WpOrg_Requests_Autoload {
	mut obj := &Class_WpOrg_Requests_Autoload{
		PhpObjectBase: rt.PhpObjectBase{}
		deprecated_classes: rt.new_array()
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
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Autoload) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'deprecated_classes' { return this.deprecated_classes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Autoload) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'deprecated_classes' { this.deprecated_classes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_requests_src_autoload_php() {
	if rt.is_true(rt.identical(rt.call_function('class_exists', [rt.new_string('WpOrg\\Requests\\Autoload')]), rt.new_bool(false))) {
	}
}
