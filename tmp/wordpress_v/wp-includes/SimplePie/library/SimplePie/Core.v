import rt

struct Class_SimplePie_Core {
	rt.PhpObjectBase
}

struct Class_SimplePie {
	rt.PhpObjectBase
}

fn create_simplepie_core() &Class_SimplePie_Core {
	mut obj := &Class_SimplePie_Core{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie() &Class_SimplePie {
	mut obj := &Class_SimplePie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Core) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Core) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Core) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_simplepie_library_simplepie_core_php() {
	// unsupported statement: Stmt_Declare
}
