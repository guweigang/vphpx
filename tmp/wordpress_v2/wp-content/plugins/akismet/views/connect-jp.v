import rt

struct Class_Akismet {
	rt.PhpObjectBase
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_akismet_user := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_Akismet{}
	mut iife_result_0 := iife_temp_0.view(rt.new_string('setup'), rt.create_array([
		rt.ArrayItem{ key: 'use_jetpack_connection', val: true },
	]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_Akismet{}
	mut iife_result_1 := iife_temp_1.view(rt.new_string('setup-jetpack'), rt.create_array([
		rt.ArrayItem{ key: 'akismet_user', val: var_akismet_user },
	]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_2 := Class_Akismet{}
	mut iife_result_2 := iife_temp_2.view(rt.new_string('enter'))
	// unsupported statement: Stmt_InlineHTML
}
