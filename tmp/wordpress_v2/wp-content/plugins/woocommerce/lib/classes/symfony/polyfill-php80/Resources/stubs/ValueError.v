import rt

struct Class_WC_Vendor_ValueError {
	rt.PhpObjectBase
}

struct Class_Error {
	rt.PhpObjectBase
}

fn create_wc_vendor_valueerror(_args ...rt.PhpVal) &Class_WC_Vendor_ValueError {
	mut obj := &Class_WC_Vendor_ValueError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_error(_args ...rt.PhpVal) &Class_Error {
	mut obj := &Class_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Vendor_ValueError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Vendor_ValueError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Vendor_ValueError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
	}
}
