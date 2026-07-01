import rt

struct Class_Akismet {
	rt.PhpObjectBase
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
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

pub fn init_wp_content_plugins_akismet_views_connect_jp_php() {
	mut var_akismet_user := rt.new_null()
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.view(arg_0, arg_1)
	}(rt.new_string('setup'), rt.create_array([
		rt.ArrayItem{ key: 'use_jetpack_connection', val: true },
	]))
	// unsupported statement: Stmt_InlineHTML
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.view(arg_0, arg_1)
	}(rt.new_string('setup-jetpack'), rt.create_array([
		rt.ArrayItem{ key: 'akismet_user', val: var_akismet_user },
	]))
	// unsupported statement: Stmt_InlineHTML
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Akismet{}
		return temp.view(arg_0)
	}(rt.new_string('enter'))
	// unsupported statement: Stmt_InlineHTML
}
