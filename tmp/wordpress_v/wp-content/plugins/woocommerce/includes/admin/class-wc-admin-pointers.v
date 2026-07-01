import rt

struct Class_WC_Admin_Pointers {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Pointers) construct() {
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Pointers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'setup_pointers_for_screen' },
		])])
}

fn (mut this Class_WC_Admin_Pointers) setup_pointers_for_screen() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen)))) {
		return rt.new_null()
	}
	mut switch_val_1 := rt.get_property(var_screen, 'id')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
		this.create_product_tutorial()
		this.create_variable_product_tutorial()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_page_wc-addons'))) {
		this.create_wc_addons_tutorial()
	}
}

fn (mut this Class_WC_Admin_Pointers) create_product_tutorial() {
	mut var_wp_post_types := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('tutorial')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')])))))))
	{
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	if !(!var_wp_post_types.is_null()) {
		return rt.new_null()
	}
	mut var_labels := rt.get_property(var_wp_post_types.array_get('product'), 'labels')
	rt.set_property(var_labels, 'add_new', rt.call_function('__', [
		rt.new_string('Enable guided mode'),
		rt.new_string('woocommerce'),
	]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
		return temp.register_script(arg_0, arg_1, arg_2)
	}(rt.new_string('wp-admin-scripts'), rt.new_string('product-tour'), rt.new_bool(true))
}

fn (mut this Class_WC_Admin_Pointers) create_variable_product_tutorial() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
		return temp.register_script(arg_0, arg_1, arg_2)
	}(rt.new_string('wp-admin-scripts'), rt.new_string('variable-product-tour'), rt.new_bool(true))
}

fn (mut this Class_WC_Admin_Pointers) create_wc_addons_tutorial() {
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('tutorial')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')])))))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
		return temp.register_script(arg_0, arg_1, arg_2)
	}(rt.new_string('wp-admin-scripts'), rt.new_string('wc-addons-tour'), rt.new_bool(true))
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_wc_admin_pointers() &Class_WC_Admin_Pointers {
	mut obj := &Class_WC_Admin_Pointers{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Pointers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'setup_pointers_for_screen' {
			this.setup_pointers_for_screen()
			return rt.new_null()
		}
		'create_product_tutorial' {
			this.create_product_tutorial()
			return rt.new_null()
		}
		'create_variable_product_tutorial' {
			this.create_variable_product_tutorial()
			return rt.new_null()
		}
		'create_wc_addons_tutorial' {
			this.create_wc_addons_tutorial()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Pointers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Pointers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_pointers_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	create_wc_admin_pointers()
}
