import rt

struct Class_EmailEditorVendor_UnhandledMatchError {
	rt.PhpObjectBase
}

struct Class_Error {
	rt.PhpObjectBase
}

fn create_emaileditorvendor_unhandledmatcherror() &Class_EmailEditorVendor_UnhandledMatchError {
	mut obj := &Class_EmailEditorVendor_UnhandledMatchError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_error() &Class_Error {
	mut obj := &Class_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_EmailEditorVendor_UnhandledMatchError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_EmailEditorVendor_UnhandledMatchError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_EmailEditorVendor_UnhandledMatchError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_classes_symfony_polyfill_php80_resources_stubs_unhandledmatcherror_php() {
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
	}
}
