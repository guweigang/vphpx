import rt

struct Class_EmailEditorVendor_PhpToken {
	rt.PhpObjectBase
}

struct Class_Symfony_Polyfill_Php80_EmailEditorVendor_PhpToken {
	rt.PhpObjectBase
}

fn create_emaileditorvendor_phptoken(_args ...rt.PhpVal) &Class_EmailEditorVendor_PhpToken {
	mut obj := &Class_EmailEditorVendor_PhpToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_symfony_polyfill_php80_emaileditorvendor_phptoken(_args ...rt.PhpVal) &Class_Symfony_Polyfill_Php80_EmailEditorVendor_PhpToken {
	mut obj := &Class_Symfony_Polyfill_Php80_EmailEditorVendor_PhpToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_EmailEditorVendor_PhpToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_EmailEditorVendor_PhpToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_EmailEditorVendor_PhpToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Symfony_Polyfill_Php80_EmailEditorVendor_PhpToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Symfony_Polyfill_Php80_EmailEditorVendor_PhpToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Symfony_Polyfill_Php80_EmailEditorVendor_PhpToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000)))
		&& rt.is_true(rt.call_function('extension_loaded', [rt.new_string('tokenizer')])) {
	}
}
