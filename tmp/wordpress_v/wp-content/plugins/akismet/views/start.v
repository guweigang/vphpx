import rt

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin() &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_akismet_views_start_php() {
	mut var_akismet_user := rt.new_null()
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('akismet_header')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('akismet_header')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.view(arg_0)
		}(rt.new_string('logo'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.display_status()
	}()
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.predefined_api_key()
	}())
	{
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.view(arg_0)
		}(rt.new_string('predefined'))
	} else if rt.is_true(rt.new_bool(rt.is_true(var_akismet_user)
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_akismet_user, 'status'), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_active()
	}, rt.ArrayItem{ key: none, val: Class_Akismet.user_status_no_sub() }, rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_missing()
	}, rt.ArrayItem{ key: none, val: Class_Akismet.user_status_cancelled() }, rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_suspended()
	}])]))))
	{
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.view(arg_0, arg_1)
		}(rt.new_string('connect-jp'), rt.call_function('compact', [
			rt.new_string('akismet_user'),
		]))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.view(arg_0)
		}(rt.new_string('activate'))
	}
	// unsupported statement: Stmt_InlineHTML
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.view(arg_0)
	}(rt.new_string('footer'))
	// unsupported statement: Stmt_InlineHTML
}
