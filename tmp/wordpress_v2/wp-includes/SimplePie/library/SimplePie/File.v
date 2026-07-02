import rt

struct Class_SimplePie_File {
	rt.PhpObjectBase
}

fn create_simplepie_file(_args ...rt.PhpVal) &Class_SimplePie_File {
	mut obj := &Class_SimplePie_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_exists', [rt.new_string('SimplePie\\File')])
	if false {
	}
}
