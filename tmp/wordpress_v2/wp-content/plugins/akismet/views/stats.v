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

	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('akismet_header')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('akismet_header')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_0 := Class_Akismet{}
		mut iife_result_0 := iife_temp_0.view(rt.new_string('logo'), rt.create_array([
			rt.ArrayItem{ key: 'include_logo_link', val: true },
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_1 := Class_Akismet_Admin{}
		mut iife_result_1 := iife_temp_1.get_page_url()
		mut iife_temp_2 := Class_Akismet_Admin{}
		mut iife_result_2 := iife_temp_2.get_page_url()
		rt.echo_val(rt.call_function('esc_url', [iife_result_1]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Back to settings'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_3 := Class_Akismet{}
	mut iife_result_3 := iife_temp_3.get_access_token()
	mut iife_temp_4 := Class_Akismet{}
	mut iife_result_4 := iife_temp_4.get_access_token()
	mut iife_temp_5 := Class_Akismet{}
	mut iife_result_5 := iife_temp_5.get_access_token()
	mut iife_temp_6 := Class_Akismet{}
	mut iife_result_6 := iife_temp_6.get_access_token()
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('sprintf', [
			rt.new_string('https://tools.akismet.com/1.0/user-stats.php?blog=%s&token=%s&locale=%s&is_redecorated=1'),
			rt.call_function('urlencode', [
				rt.call_function('get_option', [rt.new_string('home')]),
			]),
			rt.call_function('urlencode', [
				iife_result_3,
			]),
			rt.call_function('esc_attr', [
				rt.call_function('get_user_locale', []rt.PhpVal{}),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('user-stats- ' + (rt.call_function('filemtime', [rt.new_string(@FILE)])).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Akismet detailed stats'),
		rt.new_string('akismet')]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_7 := Class_Akismet{}
	mut iife_result_7 := iife_temp_7.view(rt.new_string('footer'))
	// unsupported statement: Stmt_InlineHTML
}
