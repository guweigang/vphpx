import rt

struct Class_WP_Privacy_Policy_Content {
	rt.PhpObjectBase
}

fn create_wp_privacy_policy_content() &Class_WP_Privacy_Policy_Content {
	mut obj := &Class_WP_Privacy_Policy_Content{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Policy_Content) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_privacy_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage privacy options on this site.'),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Privacy_Policy_Content'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-policy-content.php',
			'4')
	}
	mut var_title := rt.call_function('__', [rt.new_string('Privacy Policy Guide')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_body_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		// unsupported expression: Expr_AssignOp_Concat
		return var_body_class.dup()
	}
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.new_closure(closure_1_fn)])
	rt.call_function('wp_enqueue_script', [rt.new_string('privacy-tools')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Secondary menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('options-privacy.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Settings'), rt.new_string('Privacy Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('options-privacy.php?tab=policyguide'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Policy Guide'), rt.new_string('Privacy Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [
		rt.call_function('__', [
			rt.new_string('The Privacy Settings require JavaScript.'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'hide-if-js' },
			]) },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy Policy Guide')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Introduction')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This text template will help you to create your website&#8217;s privacy policy.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The template contains a suggestion of sections you most likely will need. Under each section heading, you will find a short summary of what information you should provide, which will help you to get started. Some sections include suggested policy content, others will have to be completed with information from your theme and plugins.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Please edit your privacy policy content, making sure to delete the summaries, and adding any information from your theme and plugins. Once you publish your policy page, remember to add it to your navigation menu.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('It is your responsibility to write a comprehensive privacy policy, to make sure it reflects all national and international legal requirements on privacy, and to keep your policy current and accurate.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy Policy Guide')])
	// unsupported statement: Stmt_InlineHTML
	mut var_content := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Privacy_Policy_Content{}
		return temp.get_default_content(arg_0, arg_1)
	}(rt.new_bool(true), rt.new_bool(false))
	rt.echo_val(var_content)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Policies')])
	// unsupported statement: Stmt_InlineHTML
	fn () rt.PhpVal {
		mut temp := Class_WP_Privacy_Policy_Content{}
		return temp.privacy_policy_guide()
	}()
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
