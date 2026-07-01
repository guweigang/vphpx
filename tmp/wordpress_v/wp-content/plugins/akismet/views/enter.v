import rt

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet_admin() &Class_Akismet_Admin {
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

pub fn init_wp_content_plugins_akismet_views_enter_php() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Manually enter an API key'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [fn () rt.PhpVal {
		mut temp := Class_Akismet_Admin{}
		return temp.get_page_url()
	}()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [Class_Akismet_Admin.nonce()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enter your API key'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('API key'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Connect with API key'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
}
