import rt

struct Class_SimplePie_Enclosure {
	rt.PhpObjectBase
}

fn create_simplepie_enclosure(_args ...rt.PhpVal) &Class_SimplePie_Enclosure {
	mut obj := &Class_SimplePie_Enclosure{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Enclosure) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Enclosure) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Enclosure) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_exists', [rt.new_string('SimplePie\\Enclosure')])
	if false {
	}
}
