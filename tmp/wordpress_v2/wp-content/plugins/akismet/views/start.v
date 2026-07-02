import rt

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_akismet_user := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('akismet_header')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('akismet_header')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_0 := Class_Akismet{}
		mut iife_result_0 := iife_temp_0.view(rt.new_string('logo'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_Akismet_Admin{}
	mut iife_result_1 := iife_temp_1.display_status()
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_2 := Class_Akismet{}
	mut iife_result_2 := iife_temp_2.predefined_api_key()
	if rt.is_true(iife_result_2) {
		mut iife_temp_3 := Class_Akismet{}
		mut iife_result_3 := iife_temp_3.view(rt.new_string('predefined'))
	} else if rt.is_true(var_akismet_user)
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_akismet_user, 'status'), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_active()
	}, rt.ArrayItem{ key: none, val: Class_Akismet.user_status_no_sub() }, rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_missing()
	}, rt.ArrayItem{ key: none, val: Class_Akismet.user_status_cancelled() }, rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_suspended()
	}])])) {
		mut iife_temp_4 := Class_Akismet{}
		mut iife_result_4 := iife_temp_4.view(rt.new_string('connect-jp'), rt.call_function('compact', [
			rt.new_string('akismet_user'),
		]))
	} else {
		mut iife_temp_5 := Class_Akismet{}
		mut iife_result_5 := iife_temp_5.view(rt.new_string('activate'))
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_6 := Class_Akismet{}
	mut iife_result_6 := iife_temp_6.view(rt.new_string('footer'))
	// unsupported statement: Stmt_InlineHTML
}
