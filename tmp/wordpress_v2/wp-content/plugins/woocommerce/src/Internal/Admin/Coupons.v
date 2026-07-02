import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Coupons {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_coupons() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Coupons', 'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Coupons.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Coupons',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Coupons', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self',
			[]string{}, create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Coupons', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) construct() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('marketing'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_add_marketing_coupon_script' },
		])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_register_post_type_shop_coupon'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'move_coupons' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'fix_coupon_menu_highlight' },
		]),
		rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_add_coupon_menu_redirect' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) maybe_add_coupon_menu_redirect() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.should_display_legacy_menu())))) {
		return
	}
	rt.call_function('add_submenu_page', [rt.new_string('woocommerce'),
		rt.call_function('__', [rt.new_string('Coupons'), rt.new_string('woocommerce')]),
		rt.call_function('__', [rt.new_string('Coupons'), rt.new_string('woocommerce')]),
		rt.new_string('manage_options'), rt.new_string('coupons-moved'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Coupons',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'coupon_menu_moved' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) coupon_menu_moved() {
	rt.call_function('wp_safe_redirect', [this.get_legacy_coupon_url(),
		rt.new_int(301)])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) move_coupons(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('show_in_menu', if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	]))
	{ rt.new_string('woocommerce-marketing') } else { rt.new_bool(true) })
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) fix_coupon_menu_highlight() {
	mut var_post_type := rt.new_null()
	mut var_parent_file := rt.get_superglobal('parent_file')
	if rt.is_true(rt.identical(var_post_type, rt.new_string('shop_coupon'))) {
		var_parent_file = rt.new_string('woocommerce-marketing')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) maybe_add_marketing_coupon_script() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_curent_screen := rt.call_method(iife_result_1, 'get_current_page', []rt.PhpVal{})
	if !(var_curent_screen.array_isset(rt.new_string('id')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_curent_screen.array_get(rt.new_string('id')), rt.new_string('woocommerce-coupons'))))) {
		return
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_2 := iife_temp_2.register_style(rt.new_string('marketing-coupons'),
		rt.new_string('style'))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_3 := iife_temp_3.register_script(rt.new_string('wp-admin-scripts'),
		rt.new_string('marketing-coupons'), rt.new_bool(true))
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
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
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Coupons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Coupons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
