import rt

fn wc() rt.PhpVal {
	mut iife_temp_2 := Class_WooCommerce{}
	mut iife_result_2 := iife_temp_2.instance()
	return iife_result_2
}

fn wc_get_container() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	return var_GLOBALS.array_get(rt.new_string('wc_container'))
}

struct Class_Automattic_WooCommerce_Autoloader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Packages {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Container {
	rt.PhpObjectBase
}

struct Class_WooCommerce {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Rest_Authentication {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_autoloader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Autoloader {
	mut obj := &Class_Automattic_WooCommerce_Autoloader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_packages(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Packages {
	mut obj := &Class_Automattic_WooCommerce_Packages{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Container {
	mut obj := &Class_Automattic_WooCommerce_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_woocommerce(_args ...rt.PhpVal) &Class_WooCommerce {
	mut obj := &Class_WooCommerce{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_rest_authentication(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Connection_Rest_Authentication {
	mut obj := &Class_Automattic_Jetpack_Connection_Rest_Authentication{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Autoloader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Autoloader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Autoloader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Packages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Packages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Packages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WooCommerce) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WooCommerce) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WooCommerce) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Connection_Rest_Authentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Rest_Authentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Rest_Authentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WC_PLUGIN_FILE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WC_PLUGIN_FILE'),
			rt.new_string(@FILE)])
	}
	rt.include_file(@DIR + '/src/Autoloader.php', '3')
	rt.include_file(@DIR + '/src/Packages.php', '3')
	mut iife_temp_0 := Class_Automattic_WooCommerce_Autoloader{}
	mut iife_result_0 := iife_temp_0.init()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.new_null()
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Packages{}
	mut iife_result_1 := iife_temp_1.init()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WooCommerce'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.get_constant('WC_PLUGIN_FILE')])).str() +
			'/includes/class-woocommerce.php', '2')
	}
	var_GLOBALS.array_set('wc_container', create_automattic_woocommerce_container())
	var_GLOBALS.array_set('woocommerce', wc())
	if rt.is_true(rt.call_function('class_exists', [
		Class_Automattic_Jetpack_Connection_Rest_Authentication.class(),
	]))
	{
		mut iife_temp_3 := Class_Automattic_Jetpack_Connection_Rest_Authentication{}
		mut iife_result_3 := iife_temp_3.init()
	}
}
