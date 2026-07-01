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

pub fn init_wp_content_plugins_akismet_views_stats_php() {
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('akismet_header')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('akismet_header')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Akismet{}
			return temp.view(arg_0, arg_1)
		}(rt.new_string('logo'), rt.create_array([
			rt.ArrayItem{ key: 'include_logo_link', val: true },
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [fn () rt.PhpVal {
			mut temp := Class_Akismet_Admin{}
			return temp.get_page_url()
		}()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Back to settings'),
			rt.new_string('akismet')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('sprintf', [
			rt.new_string('https://tools.akismet.com/1.0/user-stats.php?blog=%s&token=%s&locale=%s&is_redecorated=1'),
			rt.call_function('urlencode', [
				rt.call_function('get_option', [rt.new_string('home')]),
			]),
			rt.call_function('urlencode', [
				fn () rt.PhpVal {
					mut temp := Class_Akismet{}
					return temp.get_access_token()
				}(),
			]),
			rt.call_function('esc_attr', [
				rt.call_function('get_user_locale', []rt.PhpVal{}),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		'user-stats- ' + (rt.call_function('filemtime', [rt.new_string(@FILE)])).str(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Akismet detailed stats'),
		rt.new_string('akismet')]))
	// unsupported statement: Stmt_InlineHTML
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.view(arg_0)
	}(rt.new_string('footer'))
	// unsupported statement: Stmt_InlineHTML
}
