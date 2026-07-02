import rt

struct Class_Automattic_WooCommerce_Autoloader {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Autoloader) construct() {
}

fn Class_Automattic_WooCommerce_Autoloader.init() bool {
	mut var_autoloader := rt.new_string(
		(rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/vendor/autoload_packages.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [
		var_autoloader.clone()])))))
	{
		Class_Automattic_WooCommerce_Autoloader.missing_autoloader()
		return false
	}
	mut var_autoloader_result := rt.include_file(var_autoloader.to_string(), '3')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_autoloader_result)))) {
		return false
	}
	return var_autoloader_result.to_bool()
}

fn Class_Automattic_WooCommerce_Autoloader.missing_autoloader() {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG')) {
		rt.call_function('error_log', [
			rt.call_function('esc_html', [
				rt.new_string('Your installation of WooCommerce is incomplete. If you installed WooCommerce from GitHub, please refer to this document to set up your development environment: https://developer.woocommerce.com/docs/contribution/contributing/#setting-up-your-development-environment'),
			]),
		])
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('Your installation of WooCommerce is incomplete. If you installed WooCommerce from GitHub, %1$splease refer to this document%2$s to set up your development environment.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<a href="' +
				(rt.call_function('esc_url', [rt.new_string('https://developer.woocommerce.com/docs/contribution/contributing/#setting-up-your-development-environment')])).str() +
				'" target="_blank" rel="noopener noreferrer">'),
			rt.new_string('</a>'),
		])
		// unsupported statement: Stmt_InlineHTML
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.new_closure(closure_1_fn)])
}

fn create_automattic_woocommerce_autoloader() &Class_Automattic_WooCommerce_Autoloader {
	mut obj := &Class_Automattic_WooCommerce_Autoloader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Autoloader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			return rt.new_bool(Class_Automattic_WooCommerce_Autoloader.init())
		}
		'missing_autoloader' {
			Class_Automattic_WooCommerce_Autoloader.missing_autoloader()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Autoloader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Autoloader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
