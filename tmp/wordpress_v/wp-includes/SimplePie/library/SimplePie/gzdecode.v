import rt

struct Class_SimplePie_gzdecode {
	rt.PhpObjectBase
}

struct Class_SimplePie_Gzdecode {
	rt.PhpObjectBase
}

fn create_simplepie_gzdecode() &Class_SimplePie_gzdecode {
	mut obj := &Class_SimplePie_gzdecode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_gzdecode() &Class_SimplePie_Gzdecode {
	mut obj := &Class_SimplePie_Gzdecode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_gzdecode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_gzdecode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_gzdecode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_Gzdecode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Gzdecode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Gzdecode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_simplepie_library_simplepie_gzdecode_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_exists', [rt.new_string('SimplePie\\Gzdecode')])
	if false {
	}
}
