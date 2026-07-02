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

	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Manually enter an API key'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_Akismet_Admin{}
	mut iife_result_0 := iife_temp_0.get_page_url()
	mut iife_temp_1 := Class_Akismet_Admin{}
	mut iife_result_1 := iife_temp_1.get_page_url()
	rt.echo_val(rt.call_function('esc_url', [iife_result_0]))
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
