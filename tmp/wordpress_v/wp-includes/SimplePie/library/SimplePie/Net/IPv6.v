import rt

struct Class_SimplePie_Net_IPv6 {
	rt.PhpObjectBase
}

fn create_simplepie_net_ipv6() &Class_SimplePie_Net_IPv6 {
	mut obj := &Class_SimplePie_Net_IPv6{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Net_IPv6) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Net_IPv6) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Net_IPv6) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_simplepie_library_simplepie_net_ipv6_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_exists', [rt.new_string('SimplePie\\Net\\IPv6')])
	if false {
	}
}
