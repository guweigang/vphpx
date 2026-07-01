import rt

struct Class_Automattic_WooCommerce_Internal_Brands {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Brands.init()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Brands.is_enabled())))) {
		return rt.new_null()
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-brands.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-brands-coupons.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-brands-brand-settings-manager.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-brands-functions.php', '2')
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/class-wc-admin-brands.php', '2')
	}
}

fn Class_Automattic_WooCommerce_Internal_Brands.is_enabled() bool {
	return true
}

fn Class_Automattic_WooCommerce_Internal_Brands.prepare()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Brands.is_enabled())))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_brands_init')])) {
		rt.call_function('remove_action', [rt.new_string('plugins_loaded'), rt.new_string('wc_brands_init'), rt.new_int(1)])
	}
}

fn create_automattic_woocommerce_internal_brands() &Class_Automattic_WooCommerce_Internal_Brands {
	mut obj := &Class_Automattic_WooCommerce_Internal_Brands{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Brands) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_Brands.init()
			return rt.new_null()
		}
		'is_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Brands.is_enabled())
		}
		'prepare' {
			Class_Automattic_WooCommerce_Internal_Brands.prepare()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Brands) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Brands) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_brands_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
