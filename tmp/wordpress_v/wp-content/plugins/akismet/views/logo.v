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

pub fn init_wp_content_plugins_akismet_views_logo_php() {
	mut var_include_logo_link := rt.new_null()
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!var_include_logo_link.is_null()
		&& rt.is_true(rt.identical(var_include_logo_link, rt.new_bool(true)))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [fn () rt.PhpVal {
			mut temp := Class_Akismet_Admin{}
			return temp.get_page_url()
		}()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('plugins_url', [
			rt.new_string('../_inc/img/akismet-refresh-logo@2x.png'),
			rt.new_string(@FILE),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('plugins_url', [
			rt.new_string('../_inc/img/akismet-refresh-logo.svg'),
			rt.new_string(@FILE),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!var_include_logo_link.is_null()
		&& rt.is_true(rt.identical(var_include_logo_link, rt.new_bool(true)))))
	{
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
