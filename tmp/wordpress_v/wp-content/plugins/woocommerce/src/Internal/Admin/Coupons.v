import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Coupons {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Coupons.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) construct()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('marketing')))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_add_marketing_coupon_script' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_register_post_type_shop_coupon'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'move_coupons' }])])
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'fix_coupon_menu_highlight' }]), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_add_coupon_menu_redirect' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) maybe_add_coupon_menu_redirect()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.should_display_legacy_menu())))) {
		return rt.new_null()
	}
	rt.call_function('add_submenu_page', [rt.new_string('woocommerce'), rt.call_function('__', [rt.new_string('Coupons'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('Coupons'), rt.new_string('woocommerce')]), rt.new_string('manage_options'), rt.new_string('coupons-moved'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'coupon_menu_moved' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) coupon_menu_moved()  {
	rt.call_function('wp_safe_redirect', [this.get_legacy_coupon_url(), rt.new_int(301)])
	// unsupported expression: Expr_Exit
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) move_coupons(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('show_in_menu', if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) { rt.new_string('woocommerce-marketing') } else { rt.new_bool(true) })
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) fix_coupon_menu_highlight()  {
	mut var_post_type := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(var_post_type, rt.new_string('shop_coupon'))) {
		mut var_parent_file := rt.new_string(rt.new_string('woocommerce-marketing'))
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) maybe_add_marketing_coupon_script()  {
	mut var_curent_screen := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.get_instance() }(), 'get_current_page', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(var_curent_screen.array_isset(rt.new_string('id'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_style(arg_0, arg_1) }(rt.new_string('marketing-coupons'), rt.new_string('style'))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('marketing-coupons'), rt.new_bool(true))
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_coupons() &Class_Automattic_WooCommerce_Internal_Admin_Coupons {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Coupons{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Coupons.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'maybe_add_coupon_menu_redirect' {
			this.maybe_add_coupon_menu_redirect()
			return rt.new_null()
		}
		'coupon_menu_moved' {
			this.coupon_menu_moved()
			return rt.new_null()
		}
		'move_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.move_coupons(dispatch_arg_0)
		}
		'fix_coupon_menu_highlight' {
			this.fix_coupon_menu_highlight()
			return rt.new_null()
		}
		'maybe_add_marketing_coupon_script' {
			this.maybe_add_marketing_coupon_script()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Coupons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_coupons_php() {
}
