import rt

struct Class_PhpToken {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken {
	rt.PhpObjectBase
}

fn create_phptoken() &Class_PhpToken {
	mut obj := &Class_PhpToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_polyfill_php80_phptoken() &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PhpToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PhpToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PhpToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Polyfill_Php80_PhpToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_polyfill_php80_resources_stubs_phptoken_php() {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000)))
		&& rt.is_true(rt.call_function('extension_loaded', [rt.new_string('tokenizer')]))))
	{
	}
}
