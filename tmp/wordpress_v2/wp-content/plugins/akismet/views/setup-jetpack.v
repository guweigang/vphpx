import rt

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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
	mut var_user_status := if !(rt.get_property(var_akismet_user, 'status')).is_null() {
		rt.get_property(var_akismet_user, 'status')
	} else {
		rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(var_akismet_user, 'user_email')))
		&& !(!rt.is_true(rt.get_property(var_akismet_user, 'user_login'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_avatar', [
			rt.get_property(var_akismet_user, 'user_email'),
			rt.new_int(48),
			rt.new_string(''),
			rt.new_string(''),
			rt.create_array([
				rt.ArrayItem{ key: 'class', val: 'akismet-setup__connection-avatar-image' },
				rt.ArrayItem{ key: 'alt', val: '' },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Signed in as %s'),
				rt.new_string('akismet')]),
			rt.new_string('<strong>' +
				(rt.call_function('esc_html', [rt.get_property(var_akismet_user, 'user_login')])).str() +
				'</strong>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.get_property(var_akismet_user, 'user_email'),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('in_array', [var_user_status.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Akismet.user_status_cancelled() },
			rt.ArrayItem{ key: none, val: Class_Akismet.user_status_missing() },
			rt.ArrayItem{ key: none, val: Class_Akismet.user_status_no_sub() },
		])]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string("Your Jetpack account is connected, but it doesn't have an active Akismet subscription yet. To continue, please choose a plan on Akismet.com."),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('str_replace', [rt.new_string('-'),
				rt.new_string('_'), var_user_status.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Choose a plan on Akismet.com'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string("Once you've chosen a plan, return here to complete your setup."),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(var_user_status, Class_Akismet.user_status_suspended())) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string("Your Akismet account appears to be suspended. This sometimes happens if there's a billing or verification issue. Please contact our support team so we can help you get it sorted."),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Contact support'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		mut iife_temp_0 := Class_Akismet_Admin{}
		mut iife_result_0 := iife_temp_0.get_page_url()
		mut iife_temp_1 := Class_Akismet_Admin{}
		mut iife_result_1 := iife_temp_1.get_page_url()
		rt.echo_val(rt.call_function('esc_url', [iife_result_0]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_akismet_user, 'api_key'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [Class_Akismet_Admin.nonce()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Connect with Jetpack'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string("By connecting, we'll use your Jetpack account to activate Akismet on this site."),
			rt.new_string('akismet'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_user_status.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Akismet.user_status_cancelled() },
			rt.ArrayItem{ key: none, val: Class_Akismet.user_status_missing() },
			rt.ArrayItem{ key: none, val: Class_Akismet.user_status_no_sub() },
		])])))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Want to use a different account? <a href="%s" class="akismet-external-link">Visit akismet.com</a> to set it up and get your API key.'),
					rt.new_string('akismet'),
				]),
				rt.call_function('esc_url', [
					rt.new_string('https://akismet.com/get?utm_source=akismet_plugin&utm_campaign=plugin_static_link&utm_medium=in_plugin&utm_content=jetpack_flow_different_account'),
				]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: rt.new_array() },
					rt.ArrayItem{ key: 'class', val: rt.new_array() },
				]) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
